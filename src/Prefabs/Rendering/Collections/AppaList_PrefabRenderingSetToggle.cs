#region

using System;
using Appalachia.Core.Collections;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Collections
{
    [Serializable]
    public sealed class AppaList_PrefabRenderingSetToggle : AppaList<PrefabRenderingSetToggle>
    {
        public AppaList_PrefabRenderingSetToggle()
        {
        }

        public AppaList_PrefabRenderingSetToggle(
            int capacity,
            float capacityIncreaseMultiplier = 2,
            bool noTracking = false) : base(capacity, capacityIncreaseMultiplier, noTracking)
        {
        }

        public AppaList_PrefabRenderingSetToggle(AppaList<PrefabRenderingSetToggle> list) : base(
            list
        )
        {
        }

        public AppaList_PrefabRenderingSetToggle(PrefabRenderingSetToggle[] values) : base(values)
        {
        }
    }
}
