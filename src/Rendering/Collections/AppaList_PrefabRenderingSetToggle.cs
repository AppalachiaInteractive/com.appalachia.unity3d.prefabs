#region

using System;
using Appalachia.Core.Rendering.Metadata;

#endregion

namespace Appalachia.Core.Collections.Implementations.Lists
{
    [Serializable]
    public sealed class AppaList_PrefabRenderingSetToggle : AppaList<PrefabRenderingSetToggle>
    {
        public AppaList_PrefabRenderingSetToggle()
        {
        }

        public AppaList_PrefabRenderingSetToggle(int capacity, float capacityIncreaseMultiplier = 2, bool noTracking = false) : base(
            capacity,
            capacityIncreaseMultiplier,
            noTracking
        )
        {
        }

        public AppaList_PrefabRenderingSetToggle(AppaList<PrefabRenderingSetToggle> list) : base(list)
        {
        }

        public AppaList_PrefabRenderingSetToggle(PrefabRenderingSetToggle[] values) : base(values)
        {
        }
    }
}
