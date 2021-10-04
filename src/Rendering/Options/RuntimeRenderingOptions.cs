#region

using System;
using Appalachia.Base.Scriptables;
using Appalachia.Prefabs.Rendering.Options.Rendering;
using Sirenix.OdinInspector;
using Unity.Profiling;

#endregion

namespace Appalachia.Prefabs.Rendering.Options
{
    [Serializable]
    public class
        RuntimeRenderingOptions : SelfSavingSingletonScriptableObject<RuntimeRenderingOptions>
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

        private void Awake()
        {
            using (_PRF_Awake.Auto())
            {
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

                if (gizmos == null)
                {
                    gizmos = new RuntimeRenderingGizmoOptions();
                }

                if (editor == null)
                {
                    editor = new EditorRenderingOptions();
                }
            }
        }
    }
}
