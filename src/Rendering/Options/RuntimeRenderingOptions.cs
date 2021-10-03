#region

using System;
using Appalachia.Core.Rendering.Options.Rendering;
using Appalachia.Core.Scriptables;
using Sirenix.OdinInspector;
using Unity.Profiling;

#endregion

namespace Appalachia.Core.Rendering.Options
{
    [Serializable]
    public class RuntimeRenderingOptions : SelfSavingSingletonScriptableObject<RuntimeRenderingOptions>
    {
        private const string _PRF_PFX = nameof(RuntimeRenderingOptions) + ".";
        
        [FoldoutGroup("Global"), HideLabel, LabelWidth(0), InlineProperty]
        public GlobalRenderingOptions global = new GlobalRenderingOptions();

        [FoldoutGroup("Execution"), HideLabel, LabelWidth(0), InlineProperty]
        public RuntimeRenderingExecutionOptions execution = new RuntimeRenderingExecutionOptions();

        [FoldoutGroup("Profiling"), HideLabel, LabelWidth(0), InlineProperty]
        public RuntimeRenderingProfilerOptions profiling = new RuntimeRenderingProfilerOptions();

        [FoldoutGroup("Gizmos"), InlineProperty, HideLabel, LabelWidth(0)]
        public RuntimeRenderingGizmoOptions gizmos = new RuntimeRenderingGizmoOptions();

        [FoldoutGroup("Editor"), InlineProperty, HideLabel, LabelWidth(0)]
        public EditorRenderingOptions editor = new EditorRenderingOptions();

        private static readonly ProfilerMarker _PRF_Awake = new ProfilerMarker(_PRF_PFX + nameof(Awake));
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
