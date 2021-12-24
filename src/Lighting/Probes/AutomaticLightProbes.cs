using System;
using System.Collections.Generic;
using System.Linq;
using Appalachia.Core.Objects.Initialization;
using Appalachia.Core.Objects.Root;
using Appalachia.Core.Shading;
using Appalachia.Utility.Async;
using Appalachia.Utility.Strings;
using Sirenix.OdinInspector;
using Unity.Profiling;
using UnityEngine;
#if UNITY_EDITOR

#endif

namespace Appalachia.Rendering.Lighting.Probes
{
    [ExecuteAlways]
    public sealed class AutomaticLightProbes : AppalachiaBehaviour<AutomaticLightProbes>
    {
        #region Fields and Autoproperties

        [BoxGroup("Occlusion")]
        [OnValueChanged(nameof(SetOcclusion)), PropertyRange(0f, 1f)]
        public float occlusionProbeGlobal = 1.0f;

        [BoxGroup("Occlusion")]
        [OnValueChanged(nameof(SetOcclusion)), PropertyRange(-.5f, .5f)]
        public float occlusionProbeTerrainOffset;

        [BoxGroup("Occlusion")]
        [OnValueChanged(nameof(SetOcclusion)), PropertyRange(-.5f, .5f)]
        public float occlusionProbeTerrainBlendOffset;

        #endregion

        protected override async AppaTask Initialize(Initializer initializer)
        {
            using (_PRF_Initialize.Auto())
            {
                await base.Initialize(initializer);

                SetOcclusion();

#if UNITY_EDITOR
                CheckExistingGroups();
#endif
            }
        }

        private void SetOcclusion()
        {
            Shader.SetGlobalFloat(GSC.OCCLUSION._OCCLUSION_PROBE_GLOBAL,  occlusionProbeGlobal);
            Shader.SetGlobalFloat(GSC.OCCLUSION._OCCLUSION_PROBE_TERRAIN, occlusionProbeTerrainOffset);
            Shader.SetGlobalFloat(
                GSC.OCCLUSION._OCCLUSION_PROBE_TERRAIN_BLEND,
                occlusionProbeTerrainBlendOffset
            );
        }

        #region Profiling

        private const string _PRF_PFX = nameof(AutomaticLightProbes) + ".";

        private static readonly ProfilerMarker _PRF_Initialize =
            new ProfilerMarker(_PRF_PFX + nameof(Initialize));

        #endregion

#if UNITY_EDITOR

        public List<AutomaticLightProbeGroup> groups;

        public List<AutomaticLightProbeProxyVolume> proxyVolumes;

        [BoxGroup("Check State")]
        [Button, ButtonGroup("Check State/btn")]
        private void CheckExistingGroups()
        {
            groups = GetComponentsInChildren<AutomaticLightProbeGroup>().ToList();
        }

        [Button, ButtonGroup("Check State/btn")]
        private void CheckExistingVolumes()
        {
            proxyVolumes = GetComponentsInChildren<AutomaticLightProbeProxyVolume>().ToList();
        }

        [TitleGroup("Add New")]
        [BoxGroup("Add New/Probe Groups")]
        [Button, ButtonGroup("Add New/Probe Groups/btn")]
        public void AddDefault()
        {
            AddGroup<DefaultAutomaticLightProbeGroup>();
        }

        [Button, ButtonGroup("Add New/Probe Groups/btn")]
        public void AddTerrain()
        {
            AddGroup<TerrainAutomaticLightProbeGroup>();
        }

        [Button, ButtonGroup("Add New/Probe Groups/btn")]
        public void AddPrefabRendering()
        {
            AddGroup<PrefabRenderingManagerAutomaticLightProbeGroup>();
        }

        [Button, ButtonGroup("Add New/Probe Groups/btn")]
        public void AddVSP()
        {
            AddGroup<VegetationSystemAutomaticLightProbeGroup>();
        }

        [Button, ButtonGroup("Add New/Probe Groups/btn")]
        public void AddPersistantVSP()
        {
            AddGroup<PersistentVegetationAutomaticLightProbeGroup>();
        }

        [Button, ButtonGroup("Add New/Probe Groups/btn")]
        public void AddStatic()
        {
            AddGroup<StaticAutomaticLightProbeGroup>();
        }

        private T AddGroup<T>()
            where T : AutomaticLightProbeGroup
        {
            var go = new GameObject();
            go.transform.SetParent(transform, false);

            var lightProbeGroup = go.AddComponent<T>();

            CheckExistingGroups();

            return lightProbeGroup;
        }

        [BoxGroup("Add New/Proxy Volumes")]
        [Button, ButtonGroup("Add New/Proxy Volumes/btn")]
        public void AddProxyVolume()
        {
            AddProxyVolume_Internal();
        }

        private AutomaticLightProbeProxyVolume AddProxyVolume_Internal()
        {
            var go = new GameObject();
            go.transform.SetParent(transform, false);

            var lpg = go.AddComponent<AutomaticLightProbeProxyVolume>();
            lpg.volumeName = (proxyVolumes.Count + 1).ToString();

            CheckExistingVolumes();

            return lpg;
        }

        private bool _enabled_deleteProbes =>
            (groups != null) &&
            (groups.Count > 0) &&
            groups.Any(g => (g != null) && (g.lpg != null) && (g.lpg.probePositions.Length > 0)) &&
            !UnityEditor.Lightmapping.isRunning;

        [BoxGroup("Actions")]
        [Button, ButtonGroup("Actions/Buttons1")]
        [PropertyTooltip("Delete all probes in the group.")]
        [EnableIf(nameof(_enabled_deleteProbes))]
        public void DeleteProbes()
        {
            ValidateGroups();

            foreach (var group in groups)
            {
                if (group.locked)
                {
                    continue;
                }

                if (group.lpg == null)
                {
                    group.lpg = group.gameObject.GetComponent<LightProbeGroup>();
                }

                if (group.lpg == null)
                {
                    continue;
                }

                // this takes a frame to actually delete, so it's NOT immediate.  Hence the delayCall.
                UnityEditor.Undo.DestroyObjectImmediate(group.lpg);
            }

            UnityEditor.EditorApplication.delayCall += () =>
            {
                foreach (var group in groups)
                {
                    if (group.locked)
                    {
                        continue;
                    }

                    group.lpg = UnityEditor.Undo.AddComponent<LightProbeGroup>(group.gameObject);

                    UnityEditor.Undo.RecordObject(group.lpg, "Delete Light Probes");

                    // clear them to nothing
                    group.lpg.probePositions = new Vector3[0];

                    // default this on.  It's higher quality and annoying to have to manually set anyway.
                    group.lpg.dering = true;
                }

                UnityEditor.Undo.CollapseUndoOperations(UnityEditor.Undo.GetCurrentGroup());
                UnityEditor.Undo.SetCurrentGroupName("Delete Light Probes");
            };
        }

        private bool _enabled_generateProbes =>
            (groups != null) && (groups.Count > 0) && !UnityEditor.Lightmapping.isRunning;

        [Button, ButtonGroup("Actions/Buttons1")]
        [PropertyTooltip("Generate a dense field of light probes.  Then click Bake Lights.")]
        [EnableIf(nameof(_enabled_generateProbes))]
        public void GenerateProbes()
        {
            ValidateGroups();

            UnityEditor.EditorApplication.delayCall += () =>
            {
                var totalNewProbes = 0;
                var totalProbes = 0;
                var startTick = DateTime.UtcNow.Ticks;

                foreach (var group in groups)
                {
                    if (group.lpg == null)
                    {
                        continue;
                    }

                    if (group.locked)
                    {
                        totalProbes += group.lpg.probePositions.Length;
                        continue;
                    }

                    totalNewProbes += group.GenerateProbesInternal();

                    if (totalNewProbes > 0)
                    {
                        totalProbes += group.lpg.probePositions.Length;
                    }
                }

                var endTick = DateTime.UtcNow.Ticks;
                var duration = TimeSpan.FromTicks(endTick - startTick);
                var minutes = Mathf.FloorToInt((float)duration.TotalSeconds / 60.0f);
                var secs = Mathf.FloorToInt((float)duration.TotalSeconds - (minutes * 60));

                UnityEditor.EditorUtility.DisplayDialog(
                    "Probe Generation Complete!",
                    ZString.Format(
                        "It took {0}:{1:D2} to place {2} new light probes. \nThere are {3} total.",
                        minutes,
                        secs,
                        totalNewProbes,
                        totalProbes
                    ),
                    "Yes!"
                );
            };
        }

        private bool _enabled_generateVolumes =>
            (proxyVolumes != null) && (proxyVolumes.Count > 0) && !UnityEditor.Lightmapping.isRunning;

        [Button, ButtonGroup("Actions/Buttons3")]
        [PropertyTooltip("Generate proxy volumes.")]
        [EnableIf(nameof(_enabled_generateVolumes))]
        public void GenerateVolumes()
        {
            UnityEditor.EditorApplication.delayCall += () =>
            {
                var volumeCount = 0;
                var volumeUpdateCount = 0;

                var startTick = DateTime.UtcNow.Ticks;

                foreach (var volume in proxyVolumes)
                {
                    if (volume.volume == null)
                    {
                        continue;
                    }

                    volumeCount += 1;

                    if (volume.locked)
                    {
                        continue;
                    }

                    volumeUpdateCount += 1;

                    volume.UpdateVolume();
                }

                var endTick = DateTime.UtcNow.Ticks;
                var duration = TimeSpan.FromTicks(endTick - startTick);
                var minutes = Mathf.FloorToInt((float)duration.TotalSeconds / 60.0f);
                var secs = Mathf.FloorToInt((float)duration.TotalSeconds - (minutes * 60));

                UnityEditor.EditorUtility.DisplayDialog(
                    "Proxy Volume Generation Complete!",
                    ZString.Format(
                        "It took {0}:{1:D2} to update {2} light probe proxy volumes. \nThere are {3} total.",
                        minutes,
                        secs,
                        volumeUpdateCount,
                        volumeCount
                    ),
                    "Yes!"
                );
            };
        }

        private bool _enabled_bakeLightmaps =>
            (groups != null) &&
            (groups.Count > 0) &&
            groups.Any(g => (g != null) && (g.lpg != null) && (g.lpg.probePositions.Length > 0)) &&
            !UnityEditor.Lightmapping.isRunning &&
            (UnityEditor.Lightmapping.giWorkflowMode != UnityEditor.Lightmapping.GIWorkflowMode.Iterative);

        [Button, ButtonGroup("Actions/Buttons2")]
        [PropertyTooltip(
            "Bake lightmaps, which is necessary to create light probe data.  Then click Optimize."
        )]
        [EnableIf(nameof(_enabled_bakeLightmaps))]
        public void BakeLightmaps()
        {
            ValidateGroups();

            UnityEditor.Lightmapping.bakedGI = true;
            UnityEditor.Lightmapping.BakeAsync();
            UnityEditor.Lightmapping.bakeCompleted += () => { UnityEditor.Lightmapping.bakedGI = false; };
        }

        private bool _enabled_cancelBake => UnityEditor.Lightmapping.isRunning;

        [Button, ButtonGroup("Actions/Buttons2")]
        [PropertyTooltip("Cancels the executing bake.")]
        [EnableIf(nameof(_enabled_cancelBake))]
        public void CancelBake()
        {
            ValidateGroups();
            UnityEditor.Lightmapping.Cancel();
        }

        private bool _enabled_optimizeSceneProbes =>
            (groups != null) &&
            (groups.Count > 0) &&
            groups.Any(g => (g != null) && (g.lpg != null) && (g.lpg.probePositions.Length > 0)) &&
            !UnityEditor.Lightmapping.isRunning &&
            (UnityEditor.Lightmapping.giWorkflowMode != UnityEditor.Lightmapping.GIWorkflowMode.Iterative);

        [Button, ButtonGroup("Actions/Buttons1")]
        [PropertyTooltip(
            "Remove redundant light probe positions based on baked runtime probe information. Note! You must re-render light probes to shrink the runtime LightingAsset."
        )]
        [EnableIf(nameof(_enabled_optimizeSceneProbes))]
        public void OptimizeSceneProbes()
        {
            ValidateGroups();

            UnityEditor.EditorApplication.delayCall += () =>
            {
                var totalRemovedProbes = 0;
                var totalProbes = 0;
                var startTick = DateTime.UtcNow.Ticks;

                foreach (var group in groups)
                {
                    if (group.lpg == null)
                    {
                        continue;
                    }

                    if (group.locked)
                    {
                        totalProbes += group.lpg.probePositions.Length;
                        continue;
                    }

                    // Only optimize if we are over our budget (we almost always are if optimization hasn't happened since generation)
                    var initialProbes = group.lpg.probePositions.Length;
                    if (initialProbes > group.probeBudget)
                    {
                        totalRemovedProbes += group.OptimizeProbesInternal();
                    }

                    totalProbes += group.lpg.probePositions.Length;
                }

                var endTick = DateTime.UtcNow.Ticks;
                var duration = TimeSpan.FromTicks(endTick - startTick);
                var minutes = Mathf.FloorToInt((float)duration.TotalSeconds / 60.0f);
                var secs = Mathf.FloorToInt((float)duration.TotalSeconds - (minutes * 60));

                UnityEditor.EditorUtility.DisplayDialog(
                    "Optimization Complete!",
                    "It took " +
                    minutes +
                    ":" +
                    secs.ToString("D2") +
                    " to optimize away " +
                    totalRemovedProbes +
                    " light probes. \nThere are " +
                    totalProbes +
                    " probes remaining.\n",
                    "Yes!"
                );
            };
        }

        private void ValidateGroups()
        {
            for (var i = groups.Count - 1; i >= 0; i--)
            {
                var group = groups[i];

                if (group == null)
                {
                    groups.RemoveAt(i);
                    continue;
                }

                group.lpg = group.GetComponent<LightProbeGroup>();

                if (group.lpg == null)
                {
                    group.lpg = group.gameObject.AddComponent<LightProbeGroup>();
                }
            }
        }
#endif
    }
}
