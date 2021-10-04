#region

using System;
using Appalachia.Base.Scriptables;
using Appalachia.Core.Collections.Extensions;
using Appalachia.Core.Collections.Implementations.Lists;
using Appalachia.Core.Collections.Implementations.Sets;
using Appalachia.Core.Collections.Interfaces;
using Appalachia.Core.Extensions;
using Appalachia.Editing.Attributes;
using Appalachia.Editing.Preferences.Globals;
using Appalachia.Prefabs.Core;
using Appalachia.Prefabs.Core.States;
using Appalachia.Prefabs.Rendering.Collections;
using Appalachia.Prefabs.Rendering.ContentType;
using Appalachia.Prefabs.Rendering.Data;
using Appalachia.Prefabs.Rendering.External;
using Appalachia.Prefabs.Rendering.GPUI;
using Appalachia.Prefabs.Rendering.ModelType;
using Appalachia.Prefabs.Rendering.Options;
using Appalachia.Prefabs.Rendering.Replacement;
using Appalachia.Prefabs.Rendering.Runtime;
using GPUInstancer;
using Sirenix.OdinInspector;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using Unity.Profiling;
using UnityEditor;
using UnityEditor.Callbacks;
using UnityEngine;
using UnityEngine.Serialization;

#endregion

namespace Appalachia.Prefabs.Rendering
{
    [Serializable]
    [InlineEditor(Expanded = true, ObjectFieldMode = InlineEditorObjectFieldModes.Hidden), InlineProperty]
    [HideLabel, LabelWidth(0)]
    public class PrefabRenderingSet : SelfSavingAndIdentifyingScriptableObject<PrefabRenderingSet>
    {
        private const string _PRF_PFX = nameof(PrefabRenderingSet) + ".";
        public override string ToString()
        {
            return $"{prefab.name} - Prefab Render Set";
        }

#region Base Class

        private void OnEnable()
        {
            if (_externalParameters == null)
            {
                _externalParameters = new ExternalRenderingParametersLookup();
                SetDirty();
            }

            _externalParameters.SetDirtyAction(SetDirty);

            //_assetType = _assetType.CheckObsolete();
        }

        protected override bool ShowIDProperties => false;

#endregion

#region Fields & Properties

#region UI

        private const string _MAIN = "MAIN";
        private const string _MAIN_COLS = _MAIN + "/COLS";
        private const string _MAIN_COLS_1 = _MAIN_COLS + "/1";
        private const string _MAIN_COLS_2 = _MAIN_COLS + "/2";
        private const string _TABS = _MAIN_COLS_1 + "/TABS";
        private const string _META = "Metadata";
        private const string _META_ = _TABS + "/" + _META;
        private const string _REPLACE = "Replacements";
        private const string _OPTS = "Option Overrides";
        private const string _RUN = "Runtime";

        public Color _stateColor =>
            renderingEnabled
                ? _instanceManager?.currentState == RuntimeStateCode.Enabled
                    ? ColorPrefs.Instance.Enabled.v
                    : _instanceManager?.currentState == RuntimeStateCode.Disabled
                        ? ColorPrefs.Instance.DisabledImportant.v
                        : ColorPrefs.Instance.Pending.v
                : ColorPrefs.Instance.DisabledImportant.v;

        private string _stateLabel =>
            renderingEnabled
                ? _instanceManager?.currentState == RuntimeStateCode.Disabled
                    ? "Disabled Elsewhere"
                    : _instanceManager?.currentState.ToString().SeperateWords() ?? string.Empty
                : _instanceManager?.currentState.ToString().SeperateWords() ?? string.Empty;

        private string _substateLabel => _instanceManager?.currentSupplementalStateCode.ToString().SeperateWords() ?? string.Empty;


#endregion

        [VerticalGroup(_MAIN)]
        [SmartTitle("$" + nameof(_stateLabel), "$" + nameof(_substateLabel), Color = nameof(_stateColor), Alignment = TitleAlignments.Split)]
        [ToggleLeft]
        [SmartLabel]
#if UNITY_EDITOR
        [InlineButton(nameof(Ping))]
        [InlineButton(nameof(Select))]
        [InlineButton(nameof(ModelType))]
        [InlineButton(nameof(ContentType))]
        [SmartInlineButton(nameof(Solo), bold: true, color: nameof(_soloColor))]
        [SmartInlineButton(nameof(Mute), bold: true, color: nameof(_muteColor))]
#endif
        [SerializeField]
        public bool renderingEnabled = true;

#if UNITY_EDITOR
        private void ModelType()
        {
            Selection.SetActiveObjectWithContext(modelOptions.typeOptions, this);
        }
        /*
        private void PingType()
        {
            EditorGUIUtility.PingObject(options.ModelTypeOptions);
        }
        */

        private void ContentType()
        {
            Selection.SetActiveObjectWithContext(contentOptions.typeOptions, this);
        }
#endif

#if UNITY_EDITOR
        [DidReloadScripts]
        private static void ReloadSoloAndMute()
        {
            var sets = PrefabRenderingSetCollection.instance.Sets;

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

        public Color _soloColor =>
            _soloed
                ? ColorPrefs.Instance.SoloEnabled.v
                : _anySolo
                    ? ColorPrefs.Instance.SoloAny.v
                    : ColorPrefs.Instance.SoloDisabled.v;

        public Color _muteColor =>
            _muted
                ? ColorPrefs.Instance.MuteEnabled.v
                : _anyMute
                    ? ColorPrefs.Instance.MuteAny.v
                    : ColorPrefs.Instance.MuteDisabled.v;

        public void Enable(bool e)
        {
            renderingEnabled = e;
        }

        public void Solo(bool s)
        {
            _soloed = s;

            ReloadSoloAndMute();
        }

        public void Mute(bool m)
        {
            _muted = m;

            ReloadSoloAndMute();
        }

        public void Enable()
        {
            renderingEnabled = !renderingEnabled;
        }

        public void Solo()
        {
            _soloed = !_soloed;

            ReloadSoloAndMute();
        }

        public void Mute()
        {
            _muted = !_muted;

            ReloadSoloAndMute();
        }
#endif

        private static bool _anySolo;

        public static bool AnySolo
        {
            get => _anySolo;
            set => _anySolo = value;
        }

        private static bool _anyMute;

        public static bool AnyMute
        {
            get => _anyMute;
            set => _anyMute = value;
        }

        public bool Soloed
        {
            get => _soloed;
            set => _soloed = value;
        }

        [SerializeField, HideInInspector]
        private bool _soloed;

        public bool Muted
        {
            get => _muted;
            set => _muted = value;
        }

        [SerializeField, HideInInspector]
        private bool _muted;

        [HorizontalGroup(_MAIN_COLS), LabelWidth(0), HideLabel]
        [VerticalGroup(_MAIN_COLS_1)]
        [TabGroup(_TABS, _RUN), Embed, SmartLabel, SerializeField]
        private PrefabRenderingInstanceManager _instanceManager;

        public PrefabRenderingInstanceManager instanceManager => _instanceManager;

        public bool gpuMatrixPushPending => _instanceManager.gpuMatrixPushPending;

        [TabGroup(_TABS, _META), SmartLabel]
        [SerializeField, InlineProperty] 
        private PrefabContentType_OVERRIDE _contentType;
        
        [TabGroup(_TABS, _META), SmartLabel]
        [SerializeField, InlineProperty] 
        private PrefabModelType_OVERRIDE _modelType;

        public PrefabContentType contentType
        {
            get
            {
                if (_contentType == null)
                {
                    _contentType = new PrefabContentType_OVERRIDE();
                }
                
                return _contentType.value;
            }
            set
            {
                if (_contentType == null)
                {
                    _contentType = new PrefabContentType_OVERRIDE();
                }
                
                if (!_contentType.overrideEnabled)
                {
                    _contentType.value = value;
                }
            }
        }

        public PrefabModelType modelType
        {
            get
            {
                if (_modelType == null)
                {
                    _modelType = new PrefabModelType_OVERRIDE();
                }
                
                return _modelType.value;
            }
            set
            {
                if (_modelType == null)
                {
                    _modelType = new PrefabModelType_OVERRIDE();
                }
                
                if (!_modelType.overrideEnabled)
                {
                    _modelType.value = value;
                }
            }
        }

        [TabGroup(_TABS, _META), SmartLabel]
        [SerializeField]
        public GPUInstancerPrototypeMetadata prototypeMetadata;

        private bool _canUseLocations => (locations != null) && (locations.locations != null) && (locations.locations.Length > 0);

        [TabGroup(_TABS, _META), SmartLabel]
        [SerializeField, EnableIf(nameof(_canUseLocations))]
        public bool useLocations;

        [TabGroup(_TABS, _META), SmartLabel]
        [SerializeField]
        public PrefabRenderingSetLocations locations;

        [TabGroup(_TABS, _META), SmartLabel]
        private void SetRenderingLocations()
        {
            if (locations == null)
            {
                locations = PrefabRenderingSetLocations.LoadOrCreateNew(name);
            }

            locations.SetFromInstance(this);
        }

        [TabGroup(_TABS, _META), SmartLabel]
        [Button]
        private void BuryMeshes()
        {
            //MeshBurialManagementProcessor.EnqueuePrefabRenderingSet(this);
        }

        [TabGroup(_TABS, _META), SmartLabel]
        [Button]
        private void ResetBurials()
        {
            //MeshBurialAdjustmentCollection.instance.GetByPrefab(prefab).Reset();
        }

        [TabGroup(_TABS, _META), SmartLabel]
        [Button]
        private void ResetInstances()
        {
            TearDown(PrefabRenderingManager.instance.gpui);
        }

        [TabGroup(_TABS, _META), SmartLabel]
        [Button]
        private void DefaultPositions()
        {
            useLocations = false;
            ResetInstances();
        }

        [ListDrawerSettings(Expanded = true, DraggableItems = false, HideAddButton = true, HideRemoveButton = true, NumberOfItemsPerPage = 6)]
        [SerializeField, DisableIf(nameof(useLocations))]
        private ExternalRenderingParametersLookup _externalParameters;

        [TabGroup(_TABS, _META), SmartLabel]
        [SerializeField]
        public PrefabRenderingSetLocationModificationLookup modifications;

        [ToggleLeft]
        [TabGroup(_TABS, _REPLACE)]
        [ShowInInspector]
        public bool replacementEligible => replacement != null;

        [ToggleLeft]
        [TabGroup(_TABS, _REPLACE), SmartLabel]
        [EnableIf(nameof(replacementEligible))]
        [SerializeField]
        public bool useReplacement;

        [SmartLabel]
        [TabGroup(_TABS, _REPLACE)]
        [SerializeField]
        public GameObject replacement;

        public IAppaLookup<string, ExternalRenderingParameters, AppaList_ExternalRenderingParameters> ExternalParameters
        {
            get
            {
                if (_externalParameters == null)
                {
                    _externalParameters = new ExternalRenderingParametersLookup();
                    SetDirty();

                    _externalParameters.SetDirtyAction(SetDirty);
                }

                return _externalParameters;
            }
        }

        [HideInInspector]
        [SerializeField]
        public AppaSet_string labels;

        [HideInInspector]
        [SerializeField]
        public Bounds bounds;

        [HideInInspector]
        [SerializeField]
        public MeshFilter cheapestMeshFilter;

        [HideInInspector]
        [SerializeField]
        public Mesh cheapestMesh;

        [HideInInspector]
        [SerializeField]
        public Vector3[] cheapestMeshVerts;

        [HideInInspector]
        [SerializeField]
        public int[] cheapestMeshTris;

        [HideInInspector]
        [SerializeField]
        public RendererLightData[] originalRendererLighting;

        private string _setName;
        private string _suffix => $"{_modelType.value.ToString()} / {_contentType.value.ToString()}";

        public string setName
        {
            get
            {
                if (!string.IsNullOrWhiteSpace(_setName))
                {
                    return _setName;
                }

                _setName = prefab == null ? $"MISSING PREFAB [{_suffix}]" : $"{prefab.name} [{_suffix}]";

                return _setName;
            }
        }

        [FormerlySerializedAs("_options")]
        [TabGroup(_TABS, _OPTS)]
        [InlineEditor(Expanded = true, ObjectFieldMode = InlineEditorObjectFieldModes.Hidden), InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        [SerializeField]
        private PrefabModelTypeOptionsSetData _modelOptions;

        public PrefabModelTypeOptionsSetData modelOptions
        {
            get
            {
                if (_modelOptions == null)
                {
                    _modelOptions = PrefabModelTypeOptionsSetData.LoadOrCreateNew(prefab.name);
                }

                return _modelOptions;
            }
        }

        [TabGroup(_TABS, _OPTS)]
        [InlineEditor(Expanded = true, ObjectFieldMode = InlineEditorObjectFieldModes.Hidden), InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        [SerializeField]
        private PrefabContentTypeOptionsSetData _contentOptions;

        public PrefabContentTypeOptionsSetData contentOptions
        {
            get
            {
                if (_contentOptions == null)
                {
                    _contentOptions = PrefabContentTypeOptionsSetData.LoadOrCreateNew(prefab.name);
                }

                return _contentOptions;
            }
        }

        [HorizontalGroup(_MAIN_COLS, 100f), LabelWidth(0), HideLabel]
        [VerticalGroup(_MAIN_COLS_2)]
        [PreviewField(ObjectFieldAlignment.Right, Height = 96f)]
        [SerializeField]
        public GameObject prefab;

        public GameObject GetPrefab()
        {
            return prefab;
        }

#endregion

#region Metadata Methods

        private static readonly ProfilerMarker _PRF_Initialize = new ProfilerMarker(_PRF_PFX + nameof(Initialize));
        public void Initialize(GameObject pf, GPUInstancerPrototypeMetadata pp)
        {
            using (_PRF_Initialize.Auto())
            {
                prefab = pf;

                prototypeMetadata = pp;

                if (locations == null)
                {
                    locations = PrefabRenderingSetLocations.LoadOrCreateNew(name);
                }

                if (modifications == null)
                {
                    modifications = new PrefabRenderingSetLocationModificationLookup();
                }

                UpdatePrototypeShadowMap(pp.prototype);

                Refresh();

                SetDirty();
            }
        }

        private static readonly ProfilerMarker _PRF_Refresh = new ProfilerMarker(_PRF_PFX + nameof(Refresh));
        public void Refresh()
        {
            using (_PRF_Refresh.Auto())
            {
                var labelsArray = AssetDatabase.GetLabels(prefab);
                labels = labelsArray.ToAppaSet<string, AppaSet_string, AppaList_string>();

                //AssetType = AssetType.CheckObsolete();

                AssignPrefabTypes();

                if (_instanceManager == null)
                {
                    _instanceManager = new PrefabRenderingInstanceManager();
                }

                if (_externalParameters == null)
                {
                    _externalParameters = new ExternalRenderingParametersLookup();
                    SetDirty();

                    _externalParameters.SetDirtyAction(SetDirty);
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

                    if (i == renderers.Length - 1)
                    {
                        
                        if (cheapestMeshFilter == null) cheapestMeshFilter = renderer.GetComponent<MeshFilter>();
                        if (cheapestMesh == null) cheapestMesh = cheapestMeshFilter.sharedMesh;

                        if (!cheapestMesh.isReadable)
                        {
                            if (Application.isPlaying)
                            {
                                throw new NotSupportedException($"Mesh [{cheapestMesh.name}] must be readable!");
                            }
                            
                            var meshImporter = UnityEditor.AssetImporter.GetAtPath(AssetDatabase.GetAssetPath(cheapestMesh)) as UnityEditor.ModelImporter;

                            meshImporter.isReadable = true;
                            
                            meshImporter.SaveAndReimport();

                            cheapestMesh = cheapestMeshFilter.sharedMesh;
                        } 
                        
                        if (cheapestMeshVerts == null) cheapestMeshVerts = cheapestMesh.vertices;
                        if (cheapestMeshTris == null) cheapestMeshTris = cheapestMesh.triangles;

                    }
                }

                var hasInteraction = (rigidbody != null) || (interaction != null);
                var hasColliders = (colliders != null) && (colliders.Length > 0);

                modelOptions.SyncOverridesFull(hasInteraction, hasColliders);

                PrefabReplacementCollection.instance.State.TryGet(prefab, out replacement);
            }
        }

        [TabGroup(_TABS, _META), SmartLabel]
        [Button]
        public void AssignPrefabTypes()
        {
            if (!_modelType.overrideEnabled || (modelType == PrefabModelType.None))
            {
                modelType = PrefabModelTypeOptionsLookup.instance.GetPrefabType(labels);
            }

            modelOptions.type = modelType;
                
            if (!_contentType.overrideEnabled || (contentType == PrefabContentType.None))
            {
                contentType = PrefabContentTypeOptionsLookup.instance.GetPrefabType(labels);
            }

            contentOptions.type = contentType;
        }

        private static readonly ProfilerMarker _PRF_UpdatePrototypeSettings = new ProfilerMarker(_PRF_PFX + nameof(UpdatePrototypeSettings));
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
                
                if (!_modelOptions.instancedLighting.additionalShadowPass && runtimeData.hasShadowCasterBuffer)
                {
                    runtimeData.hasShadowCasterBuffer = false;
                }
                else if (modelOptions.instancedLighting.additionalShadowPass && !runtimeData.hasShadowCasterBuffer)
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
                    runtimeData.resetBuffersEveryXFrames = modelOptions.cullingSettings.updateCullingEveryXFrames;
                }
                
            }
        }

        private static readonly ProfilerMarker _PRF_UpdatePrototypeShadowMap = new ProfilerMarker(_PRF_PFX + nameof(UpdatePrototypeShadowMap));
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

        private static readonly ProfilerMarker _PRF_SyncExternalParameters = new ProfilerMarker(_PRF_PFX + nameof(SyncExternalParameters));
        public void SyncExternalParameters(PrefabLocationSource prefabSource)
        {
            using (_PRF_SyncExternalParameters.Auto())
            {
                for (var i = 0; i < _externalParameters.Count; i++)
                {
                    var external = _externalParameters.at[i];

                    if (external.veggie == null)
                    {
                        prefabSource.UpdateRuntimeRenderingParameters(external, out _, out _, out external.veggie);
                    }
                }
            }
        }

#endregion

#region Runtime Methods

        private static readonly ProfilerMarker _PRF_OnUpdate = new ProfilerMarker(_PRF_PFX + nameof(OnUpdate));
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
                    handle = instanceManager.OnUpdate_Initialize(this, gpui, prefabSource, referencePoints, globalRenderingOptions);
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

        private static readonly ProfilerMarker _PRF_OnLateUpdate = new ProfilerMarker(_PRF_PFX + nameof(OnLateUpdate));
        public bool OnLateUpdate(GPUInstancerPrefabManager gpui, RuntimeRenderingOptions globalRenderingOptions)
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
                    if (!instanceManager.OnLateUpdate_Execute(this, globalRenderingOptions.global, globalRenderingOptions.execution))
                    {
                        Debug.LogError($"Instance validation for [{prefab.name}] producing continued errors.");
                        return false;
                    }
                }

                return true;
            }
        }

        private static readonly ProfilerMarker _PRF_PushAllGPUMatrices = new ProfilerMarker(_PRF_PFX + nameof(PushAllGPUMatrices));
        public void PushAllGPUMatrices()
        {
            using (_PRF_PushAllGPUMatrices.Auto())
            {
                instanceManager.PushAllGPUMatrices();
            }
        }

        private static readonly ProfilerMarker _PRF_TearDown = new ProfilerMarker(_PRF_PFX + nameof(TearDown));
        public void TearDown(GPUInstancerPrefabManager gpui)
        {
            using (_PRF_TearDown.Auto())
            {
                instanceManager.TearDownInstances(gpui, prototypeMetadata);
            }
        }

#endregion
    }
}
