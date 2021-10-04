#region

using System;
using Sirenix.OdinInspector;

#endregion

namespace Appalachia.Prefabs.Spawning.Settings
{
    [Serializable]
    public class PrefabSpawnTimingSettings
    {
        [FoldoutGroup("Advanced")]
        public bool showAdvanced;

        [FoldoutGroup("Advanced")]
        [ShowIf(nameof(showAdvanced))]
        public float spawnLimitMax = 60.0f;

        public PrefabSpawnStyle prefabSpawnStyle;

        [ShowIf(nameof(showTimerSettings)), PropertyRange(0.1f, nameof(spawnLimitMax))]
        public float spawnsPerSecond = 1.0f;

        [ShowIf(nameof(showTimerSettings)), PropertyRange(0, 300)]
        public int frameDelay = 60;

        private bool showTimerSettings => prefabSpawnStyle == PrefabSpawnStyle.Timed;
    }
}
