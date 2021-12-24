#region

using System;
using Appalachia.Core.Objects.Root;
using Appalachia.Rendering.Prefabs.Rendering.Options.Rendering;
using Sirenix.OdinInspector;
using Unity.Profiling;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Options
{
    [Serializable]
    public class
        RuntimeRenderingOptions : SingletonAppalachiaObject<RuntimeRenderingOptions>
    {
        private const string _PRF_PFX = nameof(RuntimeRenderingOptions) + ".";

        private static readonly ProfilerMarker _PRF_Awake = new(_PRF_PFX + nameof(Awake));

        [FoldoutGroup("Global")]
        [HideLabel]
        [LabelWidth(0)]
        [InlineProperty]
        public GlobalRenderingOptions global = new();

        [FoldoutGroup("Execution")]
        [HideLabel]
        [LabelWidth(0)]
        [InlineProperty]
        public RuntimeRenderingExecutionOptions execution = new();

        [FoldoutGroup("Profiling")]
        [HideLabel]
        [LabelWidth(0)]
        [InlineProperty]
        public RuntimeRenderingProfilerOptions profiling = new();

#if UNITY_EDITOR
        [FoldoutGroup("Gizmos")]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        public RuntimeRenderingGizmoOptions gizmos = new();

        [FoldoutGroup("Editor")]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        public EditorRenderingOptions editor = new();
#endif

        protected override void Awake()
        {
            using (_PRF_Awake.Auto())
            {
                base.Awake();
                if (global == null)
                {
                    global = new GlobalRenderingOptions();
                }

                if (execution == null)
                {
                    execution = new RuntimeRenderingExecutionOptions();
                }

                if (profiling == null)
                {
                    profiling = new RuntimeRenderingProfilerOptions();
                }

#if UNITY_EDITOR
                if (gizmos == null)
                {
                    gizmos = new RuntimeRenderingGizmoOptions();
                }

                if (editor == null)
                {
                    editor = new EditorRenderingOptions();
                }
#endif
            }
        }
    }
}
