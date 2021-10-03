#region

using System;
using Appalachia.Core.Spawning.Data;

#endregion

namespace Appalachia.Core.Collections.Implementations.Lists
{
    [Serializable]
    public sealed class AppaList_PrefabSpawnPointCollection : AppaList<PrefabSpawnPointCollection>
    {
        public AppaList_PrefabSpawnPointCollection()
        {
        }

        public AppaList_PrefabSpawnPointCollection(int capacity, float capacityIncreaseMultiplier = 2, bool noTracking = false) : base(
            capacity,
            capacityIncreaseMultiplier,
            noTracking
        )
        {
        }

        public AppaList_PrefabSpawnPointCollection(AppaList<PrefabSpawnPointCollection> list) : base(list)
        {
        }

        public AppaList_PrefabSpawnPointCollection(PrefabSpawnPointCollection[] values) : base(values)
        {
        }
    }
}
