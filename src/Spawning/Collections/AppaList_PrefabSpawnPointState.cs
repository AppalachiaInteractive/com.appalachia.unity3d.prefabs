#region

using System;
using Appalachia.Core.Spawning.Data;

#endregion

namespace Appalachia.Core.Collections.Implementations.Lists
{
    [Serializable]
    public sealed class AppaList_PrefabSpawnPointState : AppaList<PrefabSpawnPointState>
    {
        public AppaList_PrefabSpawnPointState()
        {
        }

        public AppaList_PrefabSpawnPointState(int capacity, float capacityIncreaseMultiplier = 2, bool noTracking = false) : base(
            capacity,
            capacityIncreaseMultiplier,
            noTracking
        )
        {
        }

        public AppaList_PrefabSpawnPointState(AppaList<PrefabSpawnPointState> list) : base(list)
        {
        }

        public AppaList_PrefabSpawnPointState(PrefabSpawnPointState[] values) : base(values)
        {
        }
    }
}
