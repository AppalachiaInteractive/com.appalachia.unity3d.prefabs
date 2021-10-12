#region

using System;
using Appalachia.Core.Collections;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Collections
{
    [Serializable]
    public sealed class AppaList_PrefabRenderingSet : AppaList<PrefabRenderingSet>
    {
        public AppaList_PrefabRenderingSet()
        {
        }

        public AppaList_PrefabRenderingSet(
            int capacity,
            float capacityIncreaseMultiplier = 2,
            bool noTracking = false) : base(capacity, capacityIncreaseMultiplier, noTracking)
        {
        }

        public AppaList_PrefabRenderingSet(AppaList<PrefabRenderingSet> list) : base(list)
        {
        }

        public AppaList_PrefabRenderingSet(PrefabRenderingSet[] values) : base(values)
        {
        }
    }
}
