#region

using System.Diagnostics;
using Appalachia.CI.Integration.Assets;
using Appalachia.Core.Attributes;
using Appalachia.Core.Attributes.Editing;
using Appalachia.Core.Collections.Extensions;
using Appalachia.Core.Collections.Implementations.Lists;
using Appalachia.Core.Collections.Implementations.Sets;
using Appalachia.Core.Collections.Interfaces;
using Appalachia.Core.Objects.Scriptables;
using Appalachia.Core.Preferences.Globals;
using Appalachia.Rendering.Prefabs.Core;
using Appalachia.Rendering.Prefabs.Core.States;
using Appalachia.Rendering.Prefabs.Rendering.Collections;
using Appalachia.Rendering.Prefabs.Rendering.ContentType;
using Appalachia.Rendering.Prefabs.Rendering.Data;
using Appalachia.Rendering.Prefabs.Rendering.External;
using Appalachia.Rendering.Prefabs.Rendering.GPUI;
using Appalachia.Rendering.Prefabs.Rendering.ModelType;
using Appalachia.Rendering.Prefabs.Rendering.Options;
using Appalachia.Rendering.Prefabs.Rendering.Replacement;
using Appalachia.Rendering.Prefabs.Rendering.Runtime;
using Appalachia.Utility.Extensions;
using Appalachia.Utility.Strings;
using GPUInstancer;
using Sirenix.OdinInspector;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using Unity.Profiling;
using UnityEngine;
using UnityEngine.Serialization;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering
{
    [CallStaticConstructorInEditor]
    public partial class PrefabRenderingSet : IdentifiableAppalachiaObject<PrefabRenderingSet>
    {
        #region Constants and Static Readonly

        private const string _MAIN = "MAIN";
        private const string _MAIN_COLS = _MAIN + "/COLS";
        private const string _MAIN_COLS_1 = _MAIN_COLS + "/1";
        private const string _MAIN_COLS_2 = _MAIN_COLS + "/2";
        private const string _META = "Metadata";
        private const string _META_ = _TABS + "/" + _META;
        private const string _OPTS = "Option Overrides";
        private const string _REPLACE = "Replacements";
        private const string _RUN = "Runtime";
        private const string _TABS = _MAIN_COLS_1 + "/TABS";

        #endregion

        static PrefabRenderingSet()
        {
            RegisterDependency<PrefabModelTypeOptionsLookup>(i => _prefabModelTypeOptionsLookup = i);
            RegisterDependency<PrefabContentTypeOptionsLookup>(i => _prefabContentTypeOptionsLookup = i);
            RegisterDependency<PrefabReplacementCollection>(i => _prefabReplacementCollection = i);
            RegisterDependency<PrefabRenderingSetCollection>(i => _prefabRenderingSetCollection = i);
            When.Behaviour<PrefabRenderingManager>().IsAvailableThen(i => _prefabRenderingManager = i);
        }

        #region Static Fields and Autoproperties

        private static bool _anyMute;

        private static bool _anySolo;
        private static PrefabContentTypeOptionsLookup _prefabContentTypeOptionsLookup;

        private static PrefabModelTypeOptionsLookup _prefabModelTypeOptionsLookup;

        private static PrefabRenderingManager _prefabRenderingManager;
        private static PrefabRenderingSetCollection _prefabRenderingSetCollection;

        private static PrefabReplacementCollection _prefabReplacementCollection;

        #endregion

        #region Fields and Autoproperties

        [HideInInspector]
        [SerializeField]
        public AppaSet_string labels;

#if UNITY_EDITOR
        [VerticalGroup(_MAIN)]
        [SmartTitle(
            "$" + nameof(_stateLabel),
            "$" + nameof(_substateLabel),
            TitleColor = nameof(_stateColor)
        )]
        [ToggleLeft]
        [SmartLabel]
        [InlineButton(nameof(Ping))]
        [InlineButton(nameof(Select))]
        [InlineButton(nameof(ModelType))]
        [InlineButton(nameof(ContentType))]
        [SmartInlineButton(nameof(Solo), bold: true, color: nameof(_soloColor))]
        [SmartInlineButton(nameof(Mute), bold: true, color: nameof(_muteColor))]
#endif
        [SerializeField]
        public bool renderingEnabled = true;

        [TabGroup(_TABS, _META)]
        [SmartLabel]
        [SerializeField]
        [EnableIf(nameof(_canUseLocations))]
        public bool useLocations;

        [ToggleLeft]
        [TabGroup(_TABS, _REPLACE)]
        [SmartLabel]
        [EnableIf(nameof(replacementEligible))]
        [SerializeField]
        public bool useReplacement;

        [HideInInspector]
        [SerializeField]
        public Bounds bounds;

        [HorizontalGroup(_MAIN_COLS, 100f)]
        [LabelWidth(0)]
        [HideLabel]
        [VerticalGroup(_MAIN_COLS_2)]
        [PreviewField(ObjectFieldAlignment.Right, Height = 96f)]
        [SerializeField]
        public GameObject prefab;

        [SmartLabel]
        [TabGroup(_TABS, _REPLACE)]
        [SerializeField]
        public GameObject replacement;

        [TabGroup(_TABS, _META)]
        [SmartLabel]
        [SerializeField]
        public GPUInstancerPrototypeMetadata prototypeMetadata;

        [HideInInspector]
        [SerializeField]
        public int[] cheapestMeshTris;

        [HideInInspector]
        [SerializeField]
        public Mesh cheapestMesh;

        [HideInInspector]
        [SerializeField]
        public MeshFilter cheapestMeshFilter;

        [TabGroup(_TABS, _META)]
        [SmartLabel]
        [SerializeField]
        public PrefabRenderingSetLocationModificationLookup modifications;

        [TabGroup(_TABS, _META)]
        [SmartLabel]
        [SerializeField]
        public PrefabRenderingSetLocations locations;

        public RendererLightData[] originalRendererLighting;

        [HideInInspector]
        [SerializeField]
        public Vector3[] cheapestMeshVerts;

        [SerializeField]
        [HideInInspector]
        private bool _muted;

        [SerializeField]
        [HideInInspector]
        private bool _soloed;

        [ListDrawerSettings(
            Expanded = true,
            DraggableItems = false,
            HideAddButton = true,
            HideRemoveButton = true,
            NumberOfItemsPerPage = 6
        )]
        [SerializeField]
        [DisableIf(nameof(useLocations))]
        private ExternalRenderingParametersLookup _externalParameters;

        [TabGroup(_TABS, _META)]
        [SmartLabel]
        [InlineProperty]
        [SerializeField]
        private OverridablePrefabContentType _contentType;

        [TabGroup(_TABS, _OPTS)]
        [InlineEditor(Expanded = true, ObjectFieldMode = InlineEditorObjectFieldModes.Hidden)]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        [SerializeField] private PrefabContentTypeOptionsSetData _contentOptions;

        [TabGroup(_TABS, _META)]
        [SmartLabel]
        [InlineProperty]
        [SerializeField]
        private OverridablePrefabModelType _modelType;

        [FormerlySerializedAs("_options")]
        [TabGroup(_TABS, _OPTS)]
        [InlineEditor(Expanded = true, ObjectFieldMode = InlineEditorObjectFieldModes.Hidden)]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        [SerializeField] private PrefabModelTypeOptionsSetData _modelOptions;

        [HorizontalGroup(_MAIN_COLS)]
        [LabelWidth(0)]
        [HideLabel]
        [VerticalGroup(_MAIN_COLS_1)]
        [TabGroup(_TABS, _RUN)]
        [Embed]
        [SmartLabel]
        [SerializeField]
        private PrefabRenderingInstanceManager _instanceManager;

        private string _setName;

        #endregion

        public static bool AnyMute
        {
            get => _anyMute;
            set => _anyMute = value;
        }

        public static bool AnySolo
        {
            get => _anySolo;
            set => _anySolo = value;
        }

        public bool gpuMatrixPushPending => _instanceManager.gpuMatrixPushPending;

        [ToggleLeft]
        [TabGroup(_TABS, _REPLACE)]
        [ShowInInspector]
        public bool replacementEligible => replacement != null;

        public Color _muteColor =>
            _muted
                ? ColorPrefs.Instance.MuteEnabled.v
                : _anyMute
                    ? ColorPrefs.Instance.MuteAny.v
                    : ColorPrefs.Instance.MuteDisabled.v;

        public Color _soloColor =>
            _soloed
                ? ColorPrefs.Instance.SoloEnabled.v
                : _anySolo
                    ? ColorPrefs.Instance.SoloAny.v
                    : ColorPrefs.Instance.SoloDisabled.v;

        public Color _stateColor =>
            renderingEnabled
                ? _instanceManager?.currentState == RuntimeStateCode.Enabled
                    ? ColorPrefs.Instance.Enabled.v
                    : _instanceManager?.currentState == RuntimeStateCode.Disabled
                        ? ColorPrefs.Instance.DisabledImportant.v
                        : ColorPrefs.Instance.Pending.v
                : ColorPrefs.Instance.DisabledImportant.v;

        public IAppaLookup<string, ExternalRenderingParameters, AppaList_ExternalRenderingParameters>
            ExternalParameters
        {
            get
            {
                if (_externalParameters == null)
                {
                    _externalParameters = new ExternalRenderingParametersLookup();
#if UNITY_EDITOR
                    MarkAsModified();

                    _externalParameters.Changed.Event +=(MarkAsModified);
#endif
                }

                return _externalParameters;
            }
        }

        [SerializeField] public PrefabContentTypeOptionsSetData contentOptions
        {
            get
            {
#if UNITY_EDITOR
                if (_contentOptions == null)
                {
                    _contentOptions = PrefabContentTypeOptionsSetData.LoadOrCreateNew(prefab.name);
                }
#endif

                return _contentOptions;
            }
        }

        [SerializeField] public PrefabModelTypeOptionsSetData modelOptions
        {
            get
            {
#if UNITY_EDITOR
                if (_modelOptions == null)
                {
                    _modelOptions = PrefabModelTypeOptionsSetData.LoadOrCreateNew(prefab.name);
                }
#endif

                return _modelOptions;
            }
        }

        public PrefabRenderingInstanceManager instanceManager => _instanceManager;

        public string setName
        {
            get
            {
                if (!string.IsNullOrWhiteSpace(_setName))
                {
                    return _setName;
                }

                _setName = prefab == null
                    ? ZString.Format("MISSING PREFAB [{0}]", _suffix)
                    : ZString.Format("{0} [{1}]",            prefab.name, _suffix);

                return _setName;
            }
        }

        public bool Muted
        {
            get => _muted;
            set => _muted = value;
        }

        public bool Soloed
        {
            get => _soloed;
            set => _soloed = value;
        }

        public PrefabContentType contentType
        {
            get
            {
                if (_contentType == null)
                {
                    _contentType = new OverridablePrefabContentType();
                }

                return _contentType.Value;
            }
            set
            {
                if (_contentType == null)
                {
                    _contentType = new OverridablePrefabContentType();
                }

                if (!_contentType.Overriding)
                {
                    _contentType.Value = value;
                }
            }
        }

        public PrefabModelType modelType
        {
            get
            {
                if (_modelType == null)
                {
                    _modelType = new OverridablePrefabModelType();
                }

                return _modelType.Value;
            }
            set
            {
                if (_modelType == null)
                {
                    _modelType = new OverridablePrefabModelType();
                }

                if (!_modelType.Overriding)
                {
                    _modelType.Value = value;
                }
            }
        }

        private bool _canUseLocations =>
            (locations != null) && (locations.locations != null) && (locations.locations.Length > 0);

        private string _stateLabel =>
            renderingEnabled
                ? _instanceManager?.currentState == RuntimeStateCode.Disabled
                    ? "Disabled Elsewhere"
                    : _instanceManager?.currentState.ToString().SeperateWords() ?? string.Empty
                : _instanceManager?.currentState.ToString().SeperateWords() ?? string.Empty;

        private string _substateLabel =>
            _instanceManager?.currentSupplementalStateCode.ToString().SeperateWords() ?? string.Empty;

        private string _suffix =>
            ZString.Format("{0} / {1}", _modelType.Value.ToString(), _contentType.Value.ToString());

        /// <inheritdoc />
        [DebuggerStepThrough]
        public override string ToString()
        {
            return ZString.Format("{0} - Prefab Render Set", prefab.name);
        }

        public void Enable(bool e)
        {
            renderingEnabled = e;
        }

        public void Enable()
        {
            renderingEnabled = !renderingEnabled;
        }

        public GameObject GetPrefab()
        {
            return prefab;
        }

        public void Initialize(GameObject pf, GPUInstancerPrototypeMetadata pp)
        {
            using (_PRF_Initialize.Auto())
            {
                prefab = pf;

                prototypeMetadata = pp;

#if UNITY_EDITOR
                if (locations == null)
                {
                    locations = PrefabRenderingSetLocations.LoadOrCreateNew(name);
                }
#endif

                if (modifications == null)
                {
                    modifications = new PrefabRenderingSetLocationModificationLookup();
                }

                UpdatePrototypeShadowMap(pp.prototype);

                Refresh();

#if UNITY_EDITOR
                MarkAsModified();
#endif
            }
        }

        public void Mute(bool m)
        {
            _muted = m;

            ReloadSoloAndMute();
        }

        public void Mute()
        {
            _muted = !_muted;

            ReloadSoloAndMute();
        }

        public bool OnLateUpdate(
            GPUInstancerPrefabManager gpui,
            RuntimeRenderingOptions globalRenderingOptions)
        {
            using (_PRF_OnLateUpdate.Auto())
            {
                if (!instanceManager.ShouldProcess)
                {
                    return true;
                }

                if (instanceManager.initializationStarted && !instanceManager.initializationCompleted)
                {
                    instanceManager.OnLateUpdate_Initialize(this, gpui);
                }
                else if (instanceManager.initializationCompleted)
                {
                    if (!instanceManager.OnLateUpdate_Execute(
                            this,
                            globalRenderingOptions.global,
                            globalRenderingOptions.execution
                        ))
                    {
                        Context.Log.Error(
                            ZString.Format(
                                "Instance validation for [{0}] producing continued errors.",
                                prefab.name
                            )
                        );
                        return false;
                    }
                }

                return true;
            }
        }

        public bool OnUpdate(
            GPUInstancerPrefabManager gpui,
            PrefabLocationSource prefabSource,
            NativeList<float3> referencePoints,
            Camera camera,
            Camera frustumCamera,
            RuntimeRenderingOptions globalRenderingOptions,
            out JobHandle handle)
        {
            using (_PRF_OnUpdate.Auto())
            {
                SyncExternalParameters(prefabSource);

                instanceManager.UpdateNextState(this);

                if (!instanceManager.ShouldProcess)
                {
                    handle = default;
                    return true;
                }

                if (!instanceManager.initializationStarted)
                {
                    handle = instanceManager.OnUpdate_Initialize(
                        this,
                        gpui,
                        prefabSource,
                        referencePoints,
                        globalRenderingOptions
                    );
                    return true;
                }

                UpdatePrototypeSettings();

                return instanceManager.OnUpdate_Execute(
                    this,
                    gpui,
                    camera,
                    frustumCamera,
                    referencePoints,
                    globalRenderingOptions.execution,
                    out handle
                );
            }
        }

        public void PushAllGPUMatrices()
        {
            using (_PRF_PushAllGPUMatrices.Auto())
            {
                instanceManager.PushAllGPUMatrices();
            }
        }

        public void Refresh()
        {
            using (_PRF_Refresh.Auto())
            {
#if UNITY_EDITOR
                var labelsArray = AssetDatabaseManager.GetLabels(prefab);
                labels = labelsArray.ToAppaSet<string, AppaSet_string, stringList>();

                //AssetType = AssetType.CheckObsolete();

                AssignPrefabTypes();
#endif

                if (_instanceManager == null)
                {
                    _instanceManager = new PrefabRenderingInstanceManager();
                }

                if (_externalParameters == null)
                {
                    _externalParameters = new ExternalRenderingParametersLookup();
#if UNITY_EDITOR
                    MarkAsModified();

                    _externalParameters.Changed.Event +=(OnChanged);
#endif
                }

                bounds = prefab.GetEncompassingBounds();

                var renderers = prefab.GetComponentsInChildren<MeshRenderer>();
                var colliders = prefab.GetComponentsInChildren<Collider>();
                var rigidbody = prefab.GetComponentInChildren<Rigidbody>();
                var interaction = prefab.GetComponentInChildren<IInteractionMarker>();

                originalRendererLighting = new RendererLightData[renderers.Length];

                for (var i = 0; i < renderers.Length; i++)
                {
                    var renderer = renderers[i];

                    originalRendererLighting[i] = new RendererLightData(
                        renderer.shadowCastingMode,
                        renderer.receiveShadows,
                        renderer.lightProbeUsage,
                        renderer.lightProbeProxyVolumeOverride
                    );

                    if (i == (renderers.Length - 1))
                    {
                        if (cheapestMeshFilter == null)
                        {
                            cheapestMeshFilter = renderer.GetComponent<MeshFilter>();
                        }

                        if (cheapestMesh == null)
                        {
                            cheapestMesh = cheapestMeshFilter.sharedMesh;
                        }

                        if (!cheapestMesh.isReadable)
                        {
#if UNITY_EDITOR
                            var meshImporter =
                                UnityEditor.AssetImporter.GetAtPath(
                                    AssetDatabaseManager.GetAssetPath(cheapestMesh)
                                ) as UnityEditor.ModelImporter;

                            meshImporter.isReadable = true;

                            meshImporter.SaveAndReimport();

                            cheapestMesh = cheapestMeshFilter.sharedMesh;
#else
                            throw new System.NotSupportedException(
                                $"Mesh [{cheapestMesh.name}] must be readable!"
                            );
#endif
                        }

                        if (cheapestMeshVerts == null)
                        {
                            cheapestMeshVerts = cheapestMesh.vertices;
                        }

                        if (cheapestMeshTris == null)
                        {
                            cheapestMeshTris = cheapestMesh.triangles;
                        }
                    }
                }

                var hasInteraction = (rigidbody != null) || (interaction != null);
                var hasColliders = (colliders != null) && (colliders.Length > 0);

                modelOptions.SyncOverridesFull(hasInteraction, hasColliders);

                _prefabReplacementCollection.State.TryGet(prefab, out replacement);
            }
        }

        public void Solo(bool s)
        {
            _soloed = s;

            ReloadSoloAndMute();
        }

        public void Solo()
        {
            _soloed = !_soloed;

            ReloadSoloAndMute();
        }

        public void SyncExternalParameters(PrefabLocationSource prefabSource)
        {
            using (_PRF_SyncExternalParameters.Auto())
            {
                for (var i = 0; i < _externalParameters.Count; i++)
                {
                    var external = _externalParameters.at[i];

                    if (external.veggie == null)
                    {
                        prefabSource.UpdateRuntimeRenderingParameters(
                            external,
                            out _,
                            out _,
                            out external.veggie
                        );
                    }
                }
            }
        }

        public void TearDown(GPUInstancerPrefabManager gpui)
        {
            using (_PRF_TearDown.Auto())
            {
                instanceManager.TearDownInstances(gpui, prototypeMetadata);
            }
        }

        public void UpdatePrototypeSettings()
        {
            using (_PRF_UpdatePrototypeSettings.Auto())
            {
                modelOptions.SyncOverrides();

                modelOptions.ApplyTo(prototypeMetadata.prototype /*, false*/);

                var runtimeData = instanceManager?.element?.gpuInstancerRuntimeData_NoGO;

                if (runtimeData == null)
                {
                    return;
                }

                if (!_modelOptions.instancedLighting.additionalShadowPass &&
                    runtimeData.hasShadowCasterBuffer)
                {
                    runtimeData.hasShadowCasterBuffer = false;
                }
                else if (modelOptions.instancedLighting.additionalShadowPass &&
                         !runtimeData.hasShadowCasterBuffer)
                {
                    runtimeData.hasShadowCasterBuffer = true;
                }

                runtimeData.autoResetBufferState = true;

                if (modelOptions.cullingSettings.updateCullingEveryIteration)
                {
                    runtimeData.canUpdateBuffers = true;
                }
                else
                {
                    runtimeData.canUpdateBuffers = false;
                    runtimeData.resetBuffersEveryXFrames =
                        modelOptions.cullingSettings.updateCullingEveryXFrames;
                }
            }
        }

#if UNITY_EDITOR
        [UnityEditor.Callbacks.DidReloadScripts]
#endif
        private static void ReloadSoloAndMute()
        {
            var collection = _prefabRenderingSetCollection;

            if (collection == null)
            {
                return;
            }

            var sets = collection.Sets;

            _anySolo = false;
            _anyMute = false;

            for (var i = 0; i < sets.Count; i++)
            {
                var set = sets.at[i];

                if (set._soloed)
                {
                    _anySolo = true;
                }

                if (set._muted)
                {
                    _anyMute = true;
                }
            }
        }

        private static void UpdatePrototypeShadowMap(GPUInstancerPrefabPrototype prototype)
        {
            using (_PRF_UpdatePrototypeShadowMap.Auto())
            {
                var lodGroup = prototype.prefabObject.GetComponent<LODGroup>();

                if (lodGroup == null)
                {
                    return;
                }

                var lods = lodGroup.GetLODs();

                var index = 0;
                var minIndex = 0;
                var vertexMinimum = 24;
                var minVertexCount = int.MaxValue;
                var lodLength = Mathf.Min(8, lods.Length);

                for (var i = 0; i < lods.Length; i++)
                {
                    for (var j = 0; j < lods[i].renderers.Length; j++)
                    {
                        var renderer = lods[i].renderers[j];
                        var meshFilter = renderer.GetComponent<MeshFilter>();
                        var mesh = meshFilter.sharedMesh;

                        if ((mesh.vertexCount >= vertexMinimum) && (mesh.vertexCount < minVertexCount))
                        {
                            minVertexCount = mesh.vertexCount;
                            minIndex = index;
                        }

                        index += 1;
                    }
                }

                for (var i = 0; i < lodLength; i++)
                {
                    index = i * 4;
                    if (i >= 4)
                    {
                        index = ((i - 4) * 4) + 1;
                    }

                    prototype.shadowLODMap[index] = minIndex;
                }
            }
        }

        #region Profiling

        private static readonly ProfilerMarker _PRF_Refresh = new(_PRF_PFX + nameof(Refresh));

        private static readonly ProfilerMarker _PRF_UpdatePrototypeSettings =
            new(_PRF_PFX + nameof(UpdatePrototypeSettings));

        private static readonly ProfilerMarker _PRF_UpdatePrototypeShadowMap =
            new(_PRF_PFX + nameof(UpdatePrototypeShadowMap));

        private static readonly ProfilerMarker _PRF_OnLateUpdate = new(_PRF_PFX + nameof(OnLateUpdate));

        private static readonly ProfilerMarker _PRF_OnUpdate = new(_PRF_PFX + nameof(OnUpdate));

        private static readonly ProfilerMarker _PRF_PushAllGPUMatrices =
            new(_PRF_PFX + nameof(PushAllGPUMatrices));

        private static readonly ProfilerMarker _PRF_SyncExternalParameters =
            new(_PRF_PFX + nameof(SyncExternalParameters));

        private static readonly ProfilerMarker _PRF_TearDown = new(_PRF_PFX + nameof(TearDown));

        #endregion
    }
}
