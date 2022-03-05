using System;
using System.Collections.Generic;
using System.Linq;
using Appalachia.CI.Constants;
using Appalachia.Core.Attributes;
using Appalachia.Core.Objects.Availability;
using Appalachia.Core.Objects.Root;
using Appalachia.Editing.Core;
using Appalachia.Globals.Shading;
using Appalachia.Rendering.Prefabs.Core;
using Appalachia.Rendering.Prefabs.Rendering.ContentType;
using Appalachia.Rendering.Prefabs.Rendering.External;
using Appalachia.Rendering.Prefabs.Rendering.GPUI;
using Appalachia.Rendering.Prefabs.Rendering.ModelType;
using Appalachia.Rendering.Prefabs.Rendering.Runtime;
using Appalachia.Spatial.Terrains.Utilities;
using Appalachia.Utility.Strings;
using AwesomeTechnologies.VegetationSystem;
using GPUInstancer;
using Pathfinding;
using Pathfinding.Voxels;
using Unity.Mathematics;
using Unity.Profiling;
using UnityEngine;
using UnityEngine.Rendering;
using Object = UnityEngine.Object;

namespace Appalachia.Rendering.Prefabs.Rendering
{
    [CallStaticConstructorInEditor]
    public static class PrefabRenderingManagerInitializer
    {
        #region Constants and Static Readonly

        private static readonly PassType[] _ptEnum =
            Enum.GetValues(typeof(PassType)).Cast<PassType>().ToArray();

        #endregion

        static PrefabRenderingManagerInitializer()
        {
            RegisterInstanceCallbacks.WithoutSorting().When.Object<GPUInstancerPrototypeMetadataCollection>().IsAvailableThen(
                i => _GPUInstancerPrototypeMetadataCollection = i);
            RegisterInstanceCallbacks.WithoutSorting().When.Object<PrefabLocationSource>().IsAvailableThen( i => _prefabLocationSource = i);
            RegisterInstanceCallbacks.WithoutSorting().When.Object<PrefabContentTypeOptionsLookup>().IsAvailableThen( i => _prefabContentTypeOptionsLookup = i);
            RegisterInstanceCallbacks.WithoutSorting().When.Object<PrefabModelTypeOptionsLookup>().IsAvailableThen( i => _prefabModelTypeOptionsLookup = i);
            RegisterInstanceCallbacks.WithoutSorting().When.Behaviour<PrefabRenderingManager>().IsAvailableThen( i => _prefabRenderingManager = i);
            RegisterInstanceCallbacks.WithoutSorting().When.Object<GSR>().IsAvailableThen( i => _GSR = i);
        }

        #region Static Fields and Autoproperties

        [NonSerialized] private static AppaContext _context;
        [NonSerialized] private static bool graphAssigned;

        private static GPUInstancerPrototypeMetadataCollection _GPUInstancerPrototypeMetadataCollection;
        private static GSR _GSR;
        private static PrefabContentTypeOptionsLookup _prefabContentTypeOptionsLookup;
        private static PrefabLocationSource _prefabLocationSource;
        private static PrefabModelTypeOptionsLookup _prefabModelTypeOptionsLookup;
        private static PrefabRenderingManager _prefabRenderingManager;

        private static Terrain[] _terrains;

        #endregion

        private static AppaContext Context
        {
            get
            {
                if (_context == null)
                {
                    _context = new AppaContext(typeof(PrefabRenderingManagerInitializer));
                }

                return _context;
            }
        }

        public static void CheckNulls()
        {
            using (_PRF_CheckNulls.Auto())
            {
                var mainCamera = Camera.main;

                using (_PRF_CheckNulls_UpdateMetadata.Auto())
                {
                    if (_prefabRenderingManager.metadatas == null)
                    {
                        _prefabRenderingManager.metadatas = _GPUInstancerPrototypeMetadataCollection;
                    }
                }

                using (_PRF_CheckNulls_UpdateReferencePoints.Auto())
                {
                    if ((_prefabRenderingManager.distanceReferencePoint == null) && (mainCamera != null))
                    {
                        _prefabRenderingManager.distanceReferencePoint = mainCamera.gameObject;
                    }
                }

                using (_PRF_CheckNulls_UpdatePrefabSource.Auto())
                {
                    if (_prefabRenderingManager.prefabSource == null)
                    {
                        _prefabRenderingManager.prefabSource = _prefabLocationSource;
                    }
                }

                using (_PRF_CheckNulls_UpdateVSP.Auto())
                {
                    if (_prefabRenderingManager.vegetationSystem == null)
                    {
                        _prefabRenderingManager.vegetationSystem =
                            Object.FindObjectOfType<VegetationSystemPro>();
                    }
                }

                using (_PRF_CheckNulls_UpdateShaderVariants.Auto())
                {
                    if (_prefabRenderingManager.shaderVariants == null)
                    {
                        _prefabRenderingManager.shaderVariants = _GSR.shaderVariants;
                    }
                }

                using (_PRF_CheckNulls_UpdateGPUI.Auto())
                {
                    if (_prefabRenderingManager.gpui == null)
                    {
                        _prefabRenderingManager.gpui = Object.FindObjectOfType<GPUInstancerPrefabManager>();

                        if (_prefabRenderingManager.gpui == null)
                        {
                            var go = new GameObject(PrefabRenderingManager.GPUI_PREFAB_MANAGER);
                            _prefabRenderingManager.gpui = go.AddComponent<GPUInstancerPrefabManager>();
                            _prefabRenderingManager.gpui.OnEnable();
                            _prefabRenderingManager.gpui.Awake();
                        }
                    }
                }

                using (_PRF_CheckNulls_UpdateFrustum.Auto())
                {
                    if (_prefabRenderingManager.frustumCamera == null)
                    {
                        var frustum =
                            _prefabRenderingManager.transform.Find(PrefabRenderingManager.FRUSTUM_NAME);

                        if (frustum == null)
                        {
                            frustum = new GameObject(PrefabRenderingManager.FRUSTUM_NAME).transform;
                        }

                        frustum.SetParent(_prefabRenderingManager.transform);

                        _prefabRenderingManager.frustumCamera = frustum.GetComponent<Camera>();

                        if (_prefabRenderingManager.frustumCamera == null)
                        {
                            _prefabRenderingManager.frustumCamera = frustum.gameObject.AddComponent<Camera>();
                        }
                    }

                    _prefabRenderingManager.frustumCamera.clearFlags = CameraClearFlags.SolidColor;
                    _prefabRenderingManager.frustumCamera.backgroundColor = Color.black;
                    _prefabRenderingManager.frustumCamera.enabled = false;
                    _prefabRenderingManager.frustumCamera.depth = -100;
                }

                using (_PRF_CheckNulls_UpdatePathfinder.Auto())
                {
                    if (_prefabRenderingManager.pathFinder == null)
                    {
                        _prefabRenderingManager.pathFinder = Object.FindObjectOfType<AstarPath>();
                    }
                    else if (!graphAssigned)
                    {
                        graphAssigned = true;
                        RecastGraph.OnCollectSceneMeshes -= RecastGraphOnOnCollectSceneMeshes;
                        RecastGraph.OnCollectSceneMeshes += RecastGraphOnOnCollectSceneMeshes;
                    }
                }

#if UNITY_EDITOR
                using (_PRF_CheckNulls_UpdateSimulator.Auto())
                {
                    var simulator = _prefabRenderingManager.gpui.gpuiSimulator;

                    if (simulator == null)
                    {
                        _prefabRenderingManager.gpui.gpuiSimulator = new GPUInstancerEditorSimulator(
                            _prefabRenderingManager.gpui,
                            "MainCamera",
                            true
                        );
                    }
                    else
                    {
                        _prefabRenderingManager.RenderingOptions.editor.ApplyTo(simulator);
                    }
                }
#endif
            }
        }

        public static void InitializeAllPrefabRenderingSets()
        {
            using (_PRF_InitializeAllPrefabRenderingSets.Auto())
            {
                _prefabRenderingManager.renderingSets.RemoveInvalid();

                var existingParameters = new Dictionary<string, ExternalRenderingParameters>();

                var setCount = _prefabRenderingManager.renderingSets.Sets.Count;

                for (var i = 0; i < setCount; i++)
                {
                    var prefabs = _prefabRenderingManager.renderingSets;
                    var prefabsCount = prefabs.Sets.Count;

                    for (var j = 0; j < prefabsCount; j++)
                    {
                        var prefab = prefabs.Sets.at[j];

                        for (var k = prefab.ExternalParameters.Count - 1; k >= 0; k--)
                        {
                            var pfep = prefab.ExternalParameters.at[k];

                            if (pfep == null)
                            {
                                prefab.ExternalParameters.RemoveAt(k);
                                continue;
                            }

                            if (existingParameters.ContainsKey(pfep.identifyingKey))
                            {
                                continue;
                            }

                            existingParameters.Add(pfep.identifyingKey, pfep);
                        }
                    }
                }

                var prefabSounrce = _prefabRenderingManager.prefabSource;

                if (prefabSounrce == null)
                {
                    return;
                }

                var externalParameters = prefabSounrce.GetRenderingParameters(existingParameters);

                if ((externalParameters == null) || (externalParameters.Count == 0))
                {
                    return;
                }

                using (var bar = new EditorOnlyProgressBar(
                           "Initializing Prefab Rendering Parameters",
                           externalParameters.Count,
                           false
                       ))
                {
                    _prefabRenderingManager.gpui.prototypeList.Clear();

                    var prototypeLookup =
                        new Dictionary<GPUInstancerPrefabPrototype, RegisteredPrefabsData>();

                    for (var rpi = externalParameters.Count - 1; rpi >= 0; rpi--)
                    {
                        var renderingParameter = externalParameters[rpi];
                        bar.Increment1AndShowProgress(ZString.Format("{0}", renderingParameter.prefab.name));

                        if (bar.Cancelled)
                        {
                            break;
                        }

                        if (renderingParameter.prefab == null)
                        {
                            externalParameters.RemoveAt(rpi);
                            continue;
                        }

                        using (_PRF_InitializeAllPrefabRenderingSets_UpdatePrototypes.Auto())
                        {
                            PrefabRenderingSet renderingSet = null;

                            if (_prefabRenderingManager.renderingSets.Sets.ContainsKey(
                                    renderingParameter.prefab
                                ))
                            {
                                renderingSet =
                                    _prefabRenderingManager.renderingSets.Sets[renderingParameter.prefab];

                                renderingSet.ExternalParameters.AddOrUpdate(
                                    renderingParameter.identifyingKey,
                                    renderingParameter
                                );

#if UNITY_EDITOR
                                if (renderingSet.prototypeMetadata == null)
                                {
                                    renderingSet.prototypeMetadata =
                                        _prefabRenderingManager.metadatas.FindOrCreate(
                                            renderingParameter.prefab,
                                            _prefabRenderingManager.gpui,
                                            prototypeLookup
                                        );
                                }
                                else
                                {
#endif
                                    _prefabRenderingManager.metadatas.ConfirmPrototype(
                                        renderingSet.prototypeMetadata
                                    );
#if UNITY_EDITOR
                                }
#endif

#if UNITY_EDITOR
                                renderingSet.prototypeMetadata.CreatePrototypeIfNecessary(
                                    renderingParameter.prefab,
                                    _prefabRenderingManager.gpui,
                                    prototypeLookup
                                );
#endif
                            }
#if UNITY_EDITOR
                            else
                            {
                                renderingSet = AppalachiaObject.LoadOrCreateNew<PrefabRenderingSet>(
                                    ZString.Format(
                                        "{0}_{1}",
                                        nameof(PrefabRenderingSet),
                                        renderingParameter.prefab.name
                                    )
                                );

                                renderingSet.ExternalParameters.AddOrUpdate(
                                    renderingParameter.identifyingKey,
                                    renderingParameter
                                );

                                renderingSet.Initialize(
                                    renderingParameter.prefab,
                                    _prefabRenderingManager.metadatas.FindOrCreate(
                                        renderingParameter.prefab,
                                        _prefabRenderingManager.gpui,
                                        prototypeLookup
                                    )
                                );

                                _prefabRenderingManager.renderingSets.Sets.AddOrUpdate(
                                    renderingSet.prefab,
                                    renderingSet
                                );
                            }
#endif

                            if (renderingSet == null)
                            {
                                Context.Log.Warn(
                                    ZString.Format("No render set for [{0}].", renderingParameter.prefab),
                                    _prefabRenderingManager
                                );
                            }
                        }
                    }
                }

                using (var bar = new EditorOnlyProgressBar(
                           "Updating Prefab Render Sets",
                           _prefabRenderingManager.renderingSets.Sets.Count,
                           false
                       ))
                {
                    for (var setIndex = 0;
                         setIndex < _prefabRenderingManager.renderingSets.Sets.Count;
                         setIndex++)
                    {
                        var renderingSet = _prefabRenderingManager.renderingSets.Sets.at[setIndex];

                        bar.Increment1AndShowProgress(ZString.Format("{0}", renderingSet.prefab.name));

                        if (bar.Cancelled)
                        {
                            break;
                        }

                        renderingSet.Refresh();

                        if (renderingSet.modelType == PrefabModelType.None)
                        {
                            Context.Log.Warn(
                                ZString.Format(
                                    "Could not assign a prefab type for object [{0}].",
                                    renderingSet.prefab.name
                                ),
                                renderingSet.prefab
                            );
                        }

                        renderingSet.UpdatePrototypeSettings();
                    }
                }

                if (_prefabRenderingManager.renderingSets.Sets.Count > 0)
                {
                    PrefabRenderingManagerDestroyer.ResetExistingRuntimeStateInstances();
                }

#if UNITY_EDITOR
                UnityEditor.SceneManagement.EditorSceneManager.MarkSceneDirty(
                    _prefabRenderingManager.gameObject.scene
                );
#endif
            }
        }

        public static void InitializeStructure()
        {
            using (_PRF_InitializeStructure.Auto())
            {
                if (_prefabRenderingManager.structure == null)
                {
                    _prefabRenderingManager.structure =
                        new PrefabRenderingRuntimeStructure(_prefabRenderingManager);
                }

                _prefabRenderingManager.InitializeStructureInPlace(_prefabRenderingManager.structure);
            }
        }

        public static void OnAwake()
        {
            using (_PRF_OnAwake.Auto())
            {
                ExecuteInitialization(true, true, true, true, false, true, false, false, false);
            }
        }

        public static void OnEnable()
        {
            using (_PRF_OnEnable.Auto())
            {
                ExecuteInitialization(true, true, true, true, true, true, true, true, true);
            }
        }

        public static void Update()
        {
            using (_PRF_Update.Auto())
            {
                ExecuteInitialization(true, false, false, true, true, false, false, false, false);
            }
        }

        private static void ExecuteInitialization(
            bool checkNulls,
            bool initializeTransform,
            bool initializeStructure,
            bool initializeOptions,
            bool renderingBounds,
            bool warmShaders,
            bool wakeGPUI,
            bool renderingSets,
            bool gpuiTracking)
        {
            using (_PRF_ExecuteInitialization.Auto())
            {
                if (checkNulls)
                {
                    CheckNulls();
                }

                if (initializeTransform)
                {
                    InitializeTransform();
                }

                if (initializeStructure)
                {
                    InitializeStructure();
                }

                if (initializeOptions)
                {
                    InitializeOptions(_prefabRenderingManager.transform.position);
                }

                if (renderingBounds)
                {
                    RecalculateRenderingBounds();
                }

                if (warmShaders)
                {
                    WarmUpShaders();
                }

                if (wakeGPUI)
                {
                    _prefabRenderingManager.gpui.Awake();
                }

                if (renderingSets)
                {
                    InitializeAllPrefabRenderingSets();
                }

                if (gpuiTracking)
                {
                    InitializeGPUIInitializationTracking(true);
                }
            }
        }

        private static void InitializeGPUIInitializationTracking(bool forceClear)
        {
            using (_PRF_InitializeGPUIInitializationTracking.Auto())
            {
                if (!_prefabRenderingManager.gpuiRuntimeBuffersInitialized)
                {
                    if (forceClear || (_prefabRenderingManager.gpui.runtimeDataDictionary == null))
                    {
                        _prefabRenderingManager.gpui.isInitialized = false;
                    }

                    _prefabRenderingManager.gpui.InitializeRuntimeDataAndBuffers();
                    _prefabRenderingManager.gpuiRuntimeBuffersInitialized = true;
                }
            }
        }

        private static void InitializeOptions(Vector3 referencePosition)
        {
            using (_PRF_InitializeOptions.Auto())
            {
                if (_prefabRenderingManager.RenderingOptions.global.defaultSettings.proxyVolume == null)
                {
                    var probes = Object.FindObjectsOfType<LightProbeProxyVolume>();

                    LightProbeProxyVolume volume = null;
                    var minDistance = float.MaxValue;

                    for (var i = 0; i < probes.Length; i++)
                    {
                        var probe = probes[i];
                        var probe_transform = probe.transform;

                        var distance = math.distance(probe_transform.position, referencePosition);

                        if (distance < minDistance)
                        {
                            volume = probe;
                            minDistance = distance;
                        }
                    }

                    _prefabRenderingManager.RenderingOptions.global.defaultSettings.proxyVolume = volume;
                }

                if (_prefabRenderingManager.RenderingOptions.global.shadowSettings.proxyVolume == null)
                {
                    _prefabRenderingManager.RenderingOptions.global.shadowSettings.proxyVolume =
                        _prefabRenderingManager.RenderingOptions.global.defaultSettings.proxyVolume;
                }
            }
        }

        private static void InitializeTransform()
        {
            using (_PRF_InitializeTransform.Auto())
            {
                _prefabRenderingManager.name = "Prefab Rendering Manager";
                var t = _prefabRenderingManager.transform;
                t.position = Vector3.zero;
                t.rotation = Quaternion.identity;
                t.localScale = Vector3.one;
            }
        }

        private static void RecalculateRenderingBounds()
        {
            using (_PRF_RecalculateRenderingBounds.Auto())
            {
                using (_PRF_RecalculateRenderingBounds_Terrains.Auto())
                {
                    if (_terrains == null)
                    {
                        _terrains = Object.FindObjectsOfType<Terrain>();
                    }
                }

                var length = _terrains.Length;

                for (var terrainIndex = 0; terrainIndex < length; terrainIndex++)
                {
                    var terrain = _terrains[terrainIndex];

                    Bounds bounds;
                    using (_PRF_RecalculateRenderingBounds_GetTerrainBounds.Auto())
                    {
                        bounds = terrain.GetWorldTerrainBounds();
                    }

                    using (_PRF_RecalculateRenderingBounds_EncapsulateBounds.Auto())
                    {
                        if (_prefabRenderingManager.renderingBounds == default)
                        {
                            _prefabRenderingManager.renderingBounds = bounds;
                        }
                        else
                        {
                            _prefabRenderingManager.renderingBounds.Encapsulate(bounds);
                        }
                    }
                }
            }
        }

        private static void RecastGraphOnOnCollectSceneMeshes(
            List<RasterizationMesh> meshes,
            LayerMask mask,
            List<string> tags,
            Bounds pathBounds)
        {
            _prefabRenderingManager.RecastGraphOnOnCollectSceneMeshes(meshes, mask, tags, pathBounds);
        }

        private static void WarmUpShaders()
        {
            using (_PRF_WarmUpShaders.Auto())
            {
                var materialHash = new HashSet<Material>();

                var renderingSets = _prefabRenderingManager.renderingSets;

                for (var i = 0; i < renderingSets.Sets.Count; i++)
                {
                    var renderingSet = renderingSets.Sets.at[i];
                    var prefab = renderingSet.prefab;

                    var components = prefab.GetComponentsInChildren<Renderer>();

                    for (var j = 0; j < components.Length; j++)
                    {
                        var renderer = components[j];

                        var rendererMaterials = renderer.sharedMaterials;

                        for (var k = 0; k < rendererMaterials.Length; k++)
                        {
                            var sharedRendererMaterial = rendererMaterials[k];

                            if (sharedRendererMaterial == null)
                            {
                                Context.Log.Warn(
                                    ZString.Format("Missing a material for renderer {0}!", renderer.name),
                                    renderer
                                );
                            }
                            else
                            {
                                materialHash.Add(sharedRendererMaterial);
                            }
                        }
                    }
                }

                var materials = materialHash.ToArray();

                foreach (var material in materials)
                {
                    var shader = material.shader;
                    var keywords = material.shaderKeywords;

                    foreach (var passType in _ptEnum)
                    {
                        var variant = new ShaderVariantCollection.ShaderVariant
                        {
                            passType = passType, keywords = keywords, shader = shader
                        };

                        if (!_prefabRenderingManager.shaderVariants.Contains(variant))
                        {
                            _prefabRenderingManager.shaderVariants.Add(variant);
                        }
                    }
                }

                _prefabRenderingManager.shaderVariants.WarmUp();
            }
        }

        #region Profiling

        private const string _PRF_PFX = nameof(PrefabRenderingManagerInitializer) + ".";

        private static readonly ProfilerMarker _PRF_OnAwake = new(_PRF_PFX + nameof(OnAwake));
        private static readonly ProfilerMarker _PRF_OnEnable = new(_PRF_PFX + nameof(OnEnable));
        private static readonly ProfilerMarker _PRF_Update = new(_PRF_PFX + nameof(Update));

        private static readonly ProfilerMarker _PRF_ExecuteInitialization =
            new(_PRF_PFX + nameof(ExecuteInitialization));

        private static readonly ProfilerMarker _PRF_CheckNulls = new(_PRF_PFX + nameof(CheckNulls));

        private static readonly ProfilerMarker _PRF_CheckNulls_UpdateMetadata =
            new(_PRF_PFX + nameof(CheckNulls) + ".UpdateMetadata");

        private static readonly ProfilerMarker _PRF_CheckNulls_UpdateReferencePoints =
            new(_PRF_PFX + nameof(CheckNulls) + ".UpdateReferencePoints");

        private static readonly ProfilerMarker _PRF_CheckNulls_UpdatePrefabSource =
            new(_PRF_PFX + nameof(CheckNulls) + ".UpdatePrefabSource");

        private static readonly ProfilerMarker _PRF_CheckNulls_UpdateVSP =
            new(_PRF_PFX + nameof(CheckNulls) + ".UpdateVSP");

        private static readonly ProfilerMarker _PRF_CheckNulls_UpdateGPUI =
            new(_PRF_PFX + nameof(CheckNulls) + ".UpdateGPUI");

        private static readonly ProfilerMarker _PRF_CheckNulls_UpdateShaderVariants =
            new(_PRF_PFX + nameof(CheckNulls) + ".UpdateShaderVariants");

        private static readonly ProfilerMarker _PRF_CheckNulls_UpdateFrustum =
            new(_PRF_PFX + nameof(CheckNulls) + ".UpdateFrustum");

        private static readonly ProfilerMarker _PRF_CheckNulls_UpdatePathfinder =
            new(_PRF_PFX + nameof(CheckNulls) + ".UpdatePathfinder");

        private static readonly ProfilerMarker _PRF_CheckNulls_UpdateSimulator =
            new(_PRF_PFX + nameof(CheckNulls) + ".UpdateSimulator");

        private static readonly ProfilerMarker _PRF_InitializeTransform =
            new(_PRF_PFX + nameof(InitializeTransform));

        private static readonly ProfilerMarker _PRF_InitializeStructure =
            new(_PRF_PFX + nameof(InitializeStructure));

        private static readonly ProfilerMarker _PRF_RecalculateRenderingBounds =
            new(_PRF_PFX + nameof(RecalculateRenderingBounds));

        private static readonly ProfilerMarker _PRF_InitializeGPUIInitializationTracking =
            new(_PRF_PFX + nameof(InitializeGPUIInitializationTracking));

        private static readonly ProfilerMarker _PRF_WarmUpShaders = new(_PRF_PFX + nameof(WarmUpShaders));

        private static readonly ProfilerMarker _PRF_InitializeAllPrefabRenderingSets =
            new(_PRF_PFX + nameof(InitializeAllPrefabRenderingSets));

        private static readonly ProfilerMarker _PRF_InitializeAllPrefabRenderingSets_UpdatePrototypes =
            new(_PRF_PFX + nameof(InitializeAllPrefabRenderingSets) + ".UpdatePrototypes");

        private static readonly ProfilerMarker _PRF_InitializeOptions =
            new(_PRF_PFX + nameof(InitializeOptions));

        private static readonly ProfilerMarker _PRF_RecalculateRenderingBounds_Terrains =
            new(_PRF_PFX + nameof(RecalculateRenderingBounds) + ".Terrains");

        private static readonly ProfilerMarker _PRF_RecalculateRenderingBounds_GetTerrainBounds =
            new(_PRF_PFX + nameof(RecalculateRenderingBounds) + ".GetTerrainBounds");

        private static readonly ProfilerMarker _PRF_RecalculateRenderingBounds_EncapsulateBounds =
            new(_PRF_PFX + nameof(RecalculateRenderingBounds) + ".EncapsulateBounds");

        #endregion
    }
}
