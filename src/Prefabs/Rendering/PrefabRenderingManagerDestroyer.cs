#region

using Appalachia.Core.Attributes;
using Appalachia.Editing.Core;
using Unity.Profiling;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering
{
    [CallStaticConstructorInEditor]
    public static class PrefabRenderingManagerDestroyer
    {
        static PrefabRenderingManagerDestroyer()
        {
            PrefabRenderingManager.InstanceAvailable += i => _prefabRenderingManager = i;
        }

        #region Static Fields and Autoproperties

        private static PrefabRenderingManager _prefabRenderingManager;

        #endregion

        public static void Dispose()
        {
            using (_PRF_Dispose.Auto())
            {
                var manager = _prefabRenderingManager;
                manager.renderingBounds = default;
                manager.gpuiRuntimeBuffersInitialized = false;

                for (var i = 0; i < manager.renderingSets.Sets.Count; i++)
                {
                    manager.renderingSets.Sets.at[i]?.instanceManager.Dispose();
                }
            }
        }

        public static void ExecuteDataSetTeardown(PrefabRenderingSet set)
        {
            using (_PRF_ExecuteDataSetTeardown.Auto())
            {
                var manager = _prefabRenderingManager;
                set.instanceManager.TearDownInstances(manager.gpui, set.prototypeMetadata);

#if UNITY_EDITOR
                manager.SetSceneDirty();
#endif
            }
        }

        public static void ResetExistingRuntimeStateInstances()
        {
            using (_PRF_ResetExistingRuntimeStateInstances.Auto())
            {
                var manager = _prefabRenderingManager;
                using (var bar = new EditorOnlyProgressBar(
                           "Tearing Down Runtime Prefab Rendering Data",
                           manager.renderingSets.Sets.Count,
                           false
                       ))
                {
                    manager.renderingSets.TearDown(
                        manager.gpui,

                        // ReSharper disable once AccessToDisposedClosure
                        value => bar.Increment1AndShowProgress(value)
                    );
                }
            }
        }

        #region ProfilerMarkers

        private const string _PRF_PFX = nameof(PrefabRenderingManagerDestroyer) + ".";

        private static readonly ProfilerMarker _PRF_ExecuteDataSetTeardown =
            new(_PRF_PFX + nameof(ExecuteDataSetTeardown));

        private static readonly ProfilerMarker _PRF_ResetExistingRuntimeStateInstances =
            new(_PRF_PFX + nameof(ResetExistingRuntimeStateInstances));

        private static readonly ProfilerMarker _PRF_Dispose = new(_PRF_PFX + nameof(Dispose));

        #endregion
    }
}
