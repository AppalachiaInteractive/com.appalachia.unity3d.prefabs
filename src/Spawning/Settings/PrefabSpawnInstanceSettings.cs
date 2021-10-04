#region

using System;
using Appalachia.Core.Layers;
using Sirenix.OdinInspector;

#endregion

namespace Appalachia.Prefabs.Spawning.Settings
{
    [Serializable]
    public class PrefabSpawnInstanceSettings
    {
        public bool updateSpawnLayer;

        [EnableIf(nameof(updateSpawnLayer))]
        public LayerSelection spawnLayer;
    }
}
