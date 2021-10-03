#region

using Appalachia.Core.Editing;
using Appalachia.Core.Rendering.Metadata;
using Unity.Profiling;

#endregion

namespace Appalachia.Core.Rendering
{
    public static class PrefabRenderingManagerDestroyer
    {
#region ProfilerMarkers

        private const string _PRF_PFX = nameof(PrefabRenderingManagerDestroyer) + ".";
        private static readonly ProfilerMarker _PRF_ExecuteDataSetTeardown = new ProfilerMarker(_PRF_PFX + nameof(ExecuteDataSetTeardown));

        private static readonly ProfilerMarker _PRF_ResetExistingRuntimeStateInstances =
            new ProfilerMarker(_PRF_PFX + nameof(ResetExistingRuntimeStateInstances));

        private static readonly ProfilerMarker _PRF_Dispose = new ProfilerMarker(_PRF_PFX + nameof(Dispose));
        

#endregion
        
        public static void ExecuteDataSetTeardown(PrefabRenderingSet set)
        {
            using (_PRF_ExecuteDataSetTeardown.Auto())
            {
                var manager = PrefabRenderingManager.instance;
                set.instanceManager.TearDownInstances(manager.gpui, set.prototypeMetadata);

                manager.SetSceneDirty();
            }
        }

        public static void ResetExistingRuntimeStateInstances()
        {
            using (_PRF_ResetExistingRuntimeStateInstances.Auto())
            {
                var manager = PrefabRenderingManager.instance;
                using (var bar = new EditorOnlyProgressBar("Tearing Down Runtime Prefab Rendering Data", manager.renderingSets.Sets.Count, false))
                {
                    manager.renderingSets.TearDown(manager.gpui, value => bar.Increment1AndShowProgress(value));
                }
            }
        }

        public static void Dispose()
        {
            using (_PRF_Dispose.Auto())
            {
                var manager = PrefabRenderingManager.instance;
                manager.renderingBounds = default;
                manager.gpuiRuntimeBuffersInitialized = false;

                for (var i = 0; i < manager.renderingSets.Sets.Count; i++)
                {
                    manager.renderingSets.Sets.at[i]?.instanceManager.Dispose();
                }
            }
        }
    }
}
