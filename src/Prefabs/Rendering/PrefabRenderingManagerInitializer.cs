#region

using System;
using System.Collections.Generic;
using System.Linq;
using Appalachia.Core.Extensions.Helpers;
using Appalachia.Core.Scriptables;
using Appalachia.Editing.Core;
using Appalachia.Globals.Shading;
using Appalachia.Rendering.Prefabs.Core;
using Appalachia.Rendering.Prefabs.Rendering.ContentType;
using Appalachia.Rendering.Prefabs.Rendering.External;
using Appalachia.Rendering.Prefabs.Rendering.GPUI;
using Appalachia.Rendering.Prefabs.Rendering.ModelType;
using Appalachia.Rendering.Prefabs.Rendering.Runtime;
using Appalachia.Spatial.Terrains.Utilities;
using Appalachia.Utility.Logging;
using AwesomeTechnologies.VegetationSystem;
using GPUInstancer;
using Pathfinding;
using Pathfinding.Voxels;
using Unity.Mathematics;
using Unity.Profiling;
using UnityEngine;
using UnityEngine.Rendering;
using Object = UnityEngine.Object;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering
{
    public static class PrefabRenderingManagerInitializer
    {
        private static readonly PassType[] _ptEnum =
            Enum.GetValues(typeof(PassType)).Cast<PassType>().ToArray();

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

        private static readonly ProfilerMarker _PRF_WarmUpShaders =
            new(_PRF_PFX + nameof(WarmUpShaders));

        private static readonly ProfilerMarker _PRF_InitializeAllPrefabRenderingSets =
            new(_PRF_PFX + nameof(InitializeAllPrefabRenderingSets));

        private static readonly ProfilerMarker
            _PRF_InitializeAllPrefabRenderingSets_UpdatePrototypes = new(_PRF_PFX +
                nameof(InitializeAllPrefabRenderingSets) +
                ".UpdatePrototypes");

        private static readonly ProfilerMarker _PRF_InitializeOptions =
            new(_PRF_PFX + nameof(InitializeOptions));

        [NonSerialized] private static bool graphAssigned;

        private static Terrain[] _terrains;

        private static readonly ProfilerMarker _PRF_RecalculateRenderingBounds_Terrains =
            new(_PRF_PFX + nameof(RecalculateRenderingBounds) + ".Terrains");

        private static readonly ProfilerMarker _PRF_RecalculateRenderingBounds_GetTerrainBounds =
            new(_PRF_PFX + nameof(RecalculateRenderingBounds) + ".GetTerrainBounds");

        private static readonly ProfilerMarker _PRF_RecalculateRenderingBounds_EncapsulateBounds =
            new(_PRF_PFX + nameof(RecalculateRenderingBounds) + ".EncapsulateBounds");

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
                var manager = PrefabRenderingManager.instance;

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
                    InitializeOptions(manager.transform.position);
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
                    manager.gpui.Awake();
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

        public static void CheckNulls()
        {
            using (_PRF_CheckNulls.Auto())
            {
                var manager = PrefabRenderingManager.instance;

                using (_PRF_CheckNulls_UpdateMetadata.Auto())
                {
                    if (manager.metadatas == null)
                    {
                        manager.metadatas = GPUInstancerPrototypeMetadataCollection.instance;
                    }
                }

                using (_PRF_CheckNulls_UpdateReferencePoints.Auto())
                {
                    if (manager.distanceReferencePoint == null)
                    {
                        manager.distanceReferencePoint = Camera.main.gameObject;
                    }
                }

                using (_PRF_CheckNulls_UpdatePrefabSource.Auto())
                {
                    if (manager.prefabSource == null)
                    {
                        manager.prefabSource = PrefabLocationSource.instance;
                    }
                }

                using (_PRF_CheckNulls_UpdateVSP.Auto())
                {
                    if (manager.vegetationSystem == null)
                    {
                        manager.vegetationSystem = Object.FindObjectOfType<VegetationSystemPro>();
                    }
                }

                using (_PRF_CheckNulls_UpdateShaderVariants.Auto())
                {
                    if (manager.shaderVariants == null)
                    {
                        manager.shaderVariants = GSR.instance.shaderVariants;
                    }
                }

                using (_PRF_CheckNulls_UpdateGPUI.Auto())
                {
                    if (manager.gpui == null)
                    {
                        manager.gpui = Object.FindObjectOfType<GPUInstancerPrefabManager>();

                        if (manager.gpui == null)
                        {
                            var go = new GameObject("GPUI Prefab Manager");
                            manager.gpui = go.AddComponent<GPUInstancerPrefabManager>();
                            manager.gpui.OnEnable();
                            manager.gpui.Awake();
                        }
                    }
                }

                using (_PRF_CheckNulls_UpdateFrustum.Auto())
                {
                    if (manager.frustumCamera == null)
                    {
                        var child = manager.transform.Find("Frustum");

                        if (child == null)
                        {
                            child = new GameObject("Frustum").transform;
                            child.SetParent(manager.transform);
                        }

                        manager.frustumCamera = child.GetComponent<Camera>();

                        if (manager.frustumCamera == null)
                        {
                            manager.frustumCamera = child.gameObject.AddComponent<Camera>();
                        }
                    }

                    manager.frustumCamera.enabled = false;
                    manager.frustumCamera.depth = -100;
                }

                using (_PRF_CheckNulls_UpdatePathfinder.Auto())
                {
                    if (manager.pathFinder == null)
                    {
                        manager.pathFinder = Object.FindObjectOfType<AstarPath>();
                    }
                    else if (!graphAssigned)
                    {
                        graphAssigned = true;
                        RecastGraph.OnCollectSceneMeshes -= RecastGraphOnOnCollectSceneMeshes;
                        RecastGraph.OnCollectSceneMeshes += RecastGraphOnOnCollectSceneMeshes;
                    }
                }

                using (_PRF_CheckNulls_UpdateSimulator.Auto())
                {
#if UNITY_EDITOR
                    var simulator = manager.gpui.gpuiSimulator;

                    if (simulator == null)
                    {
                        manager.gpui.gpuiSimulator = new GPUInstancerEditorSimulator(
                            manager.gpui,
                            "MainCamera",
                            true
                        );
                    }
                    else
                    {
                        manager.RenderingOptions.editor.ApplyTo(simulator);
                    }
#endif
                }
            }
        }

        private static void RecastGraphOnOnCollectSceneMeshes(
            List<RasterizationMesh> meshes,
            LayerMask mask,
            List<string> tags,
            Bounds pathBounds)
        {
            PrefabRenderingManager.instance.RecastGraphOnOnCollectSceneMeshes(
                meshes,
                mask,
                tags,
                pathBounds
            );
        }

        private static void InitializeTransform()
        {
            using (_PRF_InitializeTransform.Auto())
            {
                var manager = PrefabRenderingManager.instance;
                manager.name = "Prefab Rendering Manager";
                var t = manager.transform;
                t.position = Vector3.zero;
                t.rotation = Quaternion.identity;
                t.localScale = Vector3.one;
            }
        }

        public static void InitializeStructure()
        {
            using (_PRF_InitializeStructure.Auto())
            {
                var manager = PrefabRenderingManager.instance;
                if (manager.structure == null)
                {
                    manager.structure = new PrefabRenderingRuntimeStructure();
                }

                manager.InitializeStructureInPlace(manager.structure);
            }
        }

        private static void RecalculateRenderingBounds()
        {
            using (_PRF_RecalculateRenderingBounds.Auto())
            {
                var manager = PrefabRenderingManager.instance;

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
                        if (manager.renderingBounds == default)
                        {
                            manager.renderingBounds = bounds;
                        }
                        else
                        {
                            manager.renderingBounds.Encapsulate(bounds);
                        }
                    }
                }
            }
        }

        private static void InitializeGPUIInitializationTracking(bool forceClear)
        {
            using (_PRF_InitializeGPUIInitializationTracking.Auto())
            {
                var manager = PrefabRenderingManager.instance;

                if (!manager.gpuiRuntimeBuffersInitialized)
                {
                    if (forceClear || (manager.gpui.runtimeDataDictionary == null))
                    {
                        manager.gpui.isInitialized = false;
                    }

                    manager.gpui.InitializeRuntimeDataAndBuffers();
                    manager.gpuiRuntimeBuffersInitialized = true;
                }
            }
        }

        private static void WarmUpShaders()
        {
            using (_PRF_WarmUpShaders.Auto())
            {
                var manager = PrefabRenderingManager.instance;

                var materialHash = new HashSet<Material>();

                var renderingSets = manager.renderingSets;

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
                               AppaLog.Warn(
                                    $"Missing a material for renderer {renderer.name}!",
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

                        if (!manager.shaderVariants.Contains(variant))
                        {
                            manager.shaderVariants.Add(variant);
                        }
                    }
                }

                manager.shaderVariants.WarmUp();
            }
        }

        public static void InitializeAllPrefabRenderingSets()
        {
            using (_PRF_InitializeAllPrefabRenderingSets.Auto())
            {
                var manager = PrefabRenderingManager.instance;
                manager.renderingSets.RemoveInvalid();

                var existingParameters = new Dictionary<string, ExternalRenderingParameters>();

                var setCount = manager.renderingSets.Sets.Count;

                for (var i = 0; i < setCount; i++)
                {
                    var prefabs = manager.renderingSets;
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

                var externalParameters =
                    manager.prefabSource.GetRenderingParameters(existingParameters);

                using (var bar = new EditorOnlyProgressBar(
                    "Initializing Prefab Rendering Parameters",
                    externalParameters.Count,
                    false
                ))
                {
                    manager.gpui.prototypeList.Clear();

                    PrefabModelTypeOptionsLookup.instance.InitializeExternal();
                    PrefabContentTypeOptionsLookup.instance.InitializeExternal();

                    var prototypeLookup =
                        new Dictionary<GPUInstancerPrefabPrototype, RegisteredPrefabsData>();

                    for (var rpi = externalParameters.Count - 1; rpi >= 0; rpi--)
                    {
                        var renderingParameter = externalParameters[rpi];
                        bar.Increment1AndShowProgress($"{renderingParameter.prefab.name}");

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

                            if (manager.renderingSets.Sets.ContainsKey(renderingParameter.prefab))
                            {
                                renderingSet =
                                    manager.renderingSets.Sets[renderingParameter.prefab];

                                renderingSet.ExternalParameters.AddOrUpdate(
                                    renderingParameter.identifyingKey,
                                    renderingParameter
                                );

#if UNITY_EDITOR
                                if (renderingSet.prototypeMetadata == null)
                                {
                                    renderingSet.prototypeMetadata = manager.metadatas.FindOrCreate(
                                        renderingParameter.prefab,
                                        manager.gpui,
                                        prototypeLookup
                                    );
                                }
                                else
                                {
#endif
                                    manager.metadatas.ConfirmPrototype(
                                        renderingSet.prototypeMetadata
                                    );
#if UNITY_EDITOR
                                }
#endif

#if UNITY_EDITOR
                                renderingSet.prototypeMetadata.CreatePrototypeIfNecessary(
                                    renderingParameter.prefab,
                                    manager.gpui,
                                    prototypeLookup
                                );
#endif
                            }
#if UNITY_EDITOR
                            else
                            {
                                renderingSet = AppalachiaObject.LoadOrCreateNew<PrefabRenderingSet>(
                                    $"{renderingParameter.prefab.name}",
                                    true,
                                    false
                                );

                                renderingSet.ExternalParameters.AddOrUpdate(
                                    renderingParameter.identifyingKey,
                                    renderingParameter
                                );

                                renderingSet.Initialize(
                                    renderingParameter.prefab,
                                    manager.metadatas.FindOrCreate(
                                        renderingParameter.prefab,
                                        manager.gpui,
                                        prototypeLookup
                                    )
                                );

                                manager.renderingSets.Sets.AddOrUpdate(
                                    renderingSet.prefab,
                                    renderingSet
                                );
                            }
#endif

                            if (renderingSet == null)
                            {
                               AppaLog.Warn(
                                    $"No render set for [{renderingParameter.prefab}].",
                                    manager
                                );
                            }
                        }
                    }
                }

                using (var bar = new EditorOnlyProgressBar(
                    "Updating Prefab Render Sets",
                    manager.renderingSets.Sets.Count,
                    false
                ))
                {
                    for (var setIndex = 0; setIndex < manager.renderingSets.Sets.Count; setIndex++)
                    {
                        var renderingSet = manager.renderingSets.Sets.at[setIndex];

                        bar.Increment1AndShowProgress($"{renderingSet.prefab.name}");

                        if (bar.Cancelled)
                        {
                            break;
                        }

                        renderingSet.Refresh();

                        if (renderingSet.modelType == PrefabModelType.None)
                        {
                           AppaLog.Warn(
                                $"Could not assign a prefab type for object [{renderingSet.prefab.name}].",
                                renderingSet.prefab
                            );
                        }

                        renderingSet.UpdatePrototypeSettings();
                    }
                }

                if (manager.renderingSets.Sets.Count > 0)
                {
                    PrefabRenderingManagerDestroyer.ResetExistingRuntimeStateInstances();
                }

#if UNITY_EDITOR
                UnityEditor.SceneManagement.EditorSceneManager.MarkSceneDirty(manager.gameObject.scene);
#endif
            }
        }

        private static void InitializeOptions(Vector3 referencePosition)
        {
            using (_PRF_InitializeOptions.Auto())
            {
                var manager = PrefabRenderingManager.instance;

                if (manager.RenderingOptions.global.defaultSettings.proxyVolume == null)
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

                    manager.RenderingOptions.global.defaultSettings.proxyVolume = volume;
                }

                if (manager.RenderingOptions.global.shadowSettings.proxyVolume == null)
                {
                    manager.RenderingOptions.global.shadowSettings.proxyVolume =
                        manager.RenderingOptions.global.defaultSettings.proxyVolume;
                }
            }
        }

#region ProfilerMarkers

        private const string _PRF_PFX = nameof(PrefabRenderingManagerInitializer) + ".";

#endregion
    }
}
