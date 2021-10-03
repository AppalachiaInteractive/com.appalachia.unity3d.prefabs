#region

using System;
using Appalachia.Core.Rendering.States;

#endregion

namespace Appalachia.Core.Collections.Implementations.Lists
{
    [Serializable]
    public sealed class AppaList_RenderingStateReasonCode : AppaList<RenderingStateReasonCode>
    {
        public AppaList_RenderingStateReasonCode()
        {
        }

        public AppaList_RenderingStateReasonCode(int capacity, float capacityIncreaseMultiplier = 2, bool noTracking = false) : base(
            capacity,
            capacityIncreaseMultiplier,
            noTracking
        )
        {
        }

        public AppaList_RenderingStateReasonCode(AppaList<RenderingStateReasonCode> list) : base(list)
        {
        }

        public AppaList_RenderingStateReasonCode(RenderingStateReasonCode[] values) : base(values)
        {
        }
    }
}
