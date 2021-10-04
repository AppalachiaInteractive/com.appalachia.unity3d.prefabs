#region

using System;
using Appalachia.Editing.Attributes;
using Appalachia.Jobs;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Prefabs.Rendering.Options
{
    [Serializable]
    public class RuntimeRenderingExecutionOptions
    {
        [ToggleLeft]
        [SmartLabel]
        [SerializeField]
        public bool startInEditor = true;

        [ToggleLeft]
        [SmartLabel]
        [SerializeField]
        public bool startOnPlay = true;

        [ToggleLeft]
        [SmartLabel]
        [SerializeField]
        public bool allowUpdates = true;

        [ToggleLeft]
        [SmartLabel]
        [SerializeField]
        public bool useExplicitFrameCounts = true;

        [SmartLabel]
        [PropertyRange(1, 500)]
        [SerializeField, EnableIf(nameof(useExplicitFrameCounts))]
        public int setUpdatesPerFrame = 1;

        [SmartLabel]
        [PropertyRange(1, 25)]
        [SerializeField, DisableIf(nameof(useExplicitFrameCounts))]
        public int setUpdateMillisecondsPerFrame = 3;

        [SmartLabel]
        [PropertyRange(500, 10000)]
        [SerializeField, DisableIf(nameof(useExplicitFrameCounts))]
        public double fastestAllowedSetCycleMilliseconds = 3000;

        [SmartLabel]
        [PropertyRange(0.01, 5.0)]
        [SerializeField, DisableIf(nameof(useExplicitFrameCounts))]
        public double idealCycleTimeMilliseconds = 1.0;

        [SmartLabel]
        [PropertyRange(1, 500)]
        [SerializeField]
        public int updateJobSize = JOB_SIZE._MEDIUM;
    }
}
