#region

using System;
using Appalachia.Core.Objects.Layers;
using Appalachia.Core.Objects.Root;
using Sirenix.OdinInspector;

#endregion

namespace Appalachia.Rendering.Prefabs.Spawning.Settings
{
    [Serializable]
    public class PrefabSpawnInstanceSettings : AppalachiaSimpleBase
    {
        #region Fields and Autoproperties

        public bool updateSpawnLayer;

        [EnableIf(nameof(updateSpawnLayer))]
        public LayerSelection spawnLayer;

        #endregion
    }
}
