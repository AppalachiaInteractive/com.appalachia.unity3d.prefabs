#region

using System;
using Appalachia.Editing.Attributes;
using Sirenix.OdinInspector;

#endregion

namespace Appalachia.Prefabs.Rendering.Options
{
    [Serializable]
    public class RuntimeRenderingProfilerOptions
    {
        [ToggleLeft]
        [SmartLabel]
        public bool enableProfilingOnStart;

        [ToggleLeft]
        [SmartLabel]
        [DisableIf(nameof(disableProfilingAfterUpdateLoop))]
        public bool disableProfilingAfterInitializationLoop = true;

        [ToggleLeft]
        [SmartLabel]
        [DisableIf(nameof(disableProfilingAfterInitializationLoop))]
        public bool disableProfilingAfterUpdateLoop;

        [SmartLabel]
        [EnableIf(nameof(disableProfilingAfterUpdateLoop))]
        [PropertyRange(1, 150)]
        public int updateLoopProfilingCount = 10;
    }
}
