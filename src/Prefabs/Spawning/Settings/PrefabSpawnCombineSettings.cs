#region

using System;
using Sirenix.OdinInspector;

#endregion

namespace Appalachia.Rendering.Prefabs.Spawning.Settings
{
    [Serializable]
    public class PrefabSpawnCombineSettings
    {
        public bool combiningEnabled;

        [EnableIf(nameof(combiningEnabled))]
        public bool removeRigidbodiesWhileCombining = true;

        [EnableIf(nameof(combiningEnabled))]
        public bool removeCollidersWhileCombining = true;

        [EnableIf(nameof(combiningEnabled))]
        public bool disableAfterCombining = true;
    }
}
