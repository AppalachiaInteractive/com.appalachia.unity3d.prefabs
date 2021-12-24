#region

using System;
using Appalachia.Core.Layers;
using Appalachia.Core.Objects.Root;
using Sirenix.OdinInspector;

#endregion

namespace Appalachia.Rendering.Prefabs.Spawning.Settings
{
    [Serializable]
    public class PrefabSpawnInstanceSettings : AppalachiaSimpleBase
    {
        public bool updateSpawnLayer;

        [EnableIf(nameof(updateSpawnLayer))]
        public LayerSelection spawnLayer;
    }
}
