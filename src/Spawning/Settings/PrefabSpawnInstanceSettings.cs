#region

using System;
using Appalachia.Core.Editing;
using Sirenix.OdinInspector;

#endregion

namespace Appalachia.Core.Spawning.Settings
{
    [Serializable]
    public class PrefabSpawnInstanceSettings
    {
        public bool updateSpawnLayer;

        [EnableIf(nameof(updateSpawnLayer))]
        public LayerSelection spawnLayer;
    }
}
