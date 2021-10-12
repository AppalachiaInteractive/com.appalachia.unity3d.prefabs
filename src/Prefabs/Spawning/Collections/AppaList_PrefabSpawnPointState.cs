#region

using System;
using Appalachia.Core.Collections;
using Appalachia.Rendering.Prefabs.Spawning.Data;

#endregion

namespace Appalachia.Rendering.Prefabs.Spawning.Collections
{
    [Serializable]
    public sealed class AppaList_PrefabSpawnPointState : AppaList<PrefabSpawnPointState>
    {
        public AppaList_PrefabSpawnPointState()
        {
        }

        public AppaList_PrefabSpawnPointState(
            int capacity,
            float capacityIncreaseMultiplier = 2,
            bool noTracking = false) : base(capacity, capacityIncreaseMultiplier, noTracking)
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
