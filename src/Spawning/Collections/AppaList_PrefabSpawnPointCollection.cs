#region

using System;
using Appalachia.Core.Collections;
using Appalachia.Prefabs.Spawning.Data;

#endregion

namespace Appalachia.Prefabs.Spawning.Collections
{
    [Serializable]
    public sealed class AppaList_PrefabSpawnPointCollection : AppaList<PrefabSpawnPointCollection>
    {
        public AppaList_PrefabSpawnPointCollection()
        {
        }

        public AppaList_PrefabSpawnPointCollection(
            int capacity,
            float capacityIncreaseMultiplier = 2,
            bool noTracking = false) : base(capacity, capacityIncreaseMultiplier, noTracking)
        {
        }

        public AppaList_PrefabSpawnPointCollection(AppaList<PrefabSpawnPointCollection> list) :
            base(list)
        {
        }

        public AppaList_PrefabSpawnPointCollection(PrefabSpawnPointCollection[] values) : base(
            values
        )
        {
        }
    }
}
