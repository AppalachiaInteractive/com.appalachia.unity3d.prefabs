#region

using System;
using Appalachia.Core.Rendering.Metadata;

#endregion

namespace Appalachia.Core.Collections.Implementations.Lists
{
    [Serializable]
    public sealed class AppaList_ExternalRenderingParameters : AppaList<ExternalRenderingParameters>
    {
        public AppaList_ExternalRenderingParameters()
        {
        }

        public AppaList_ExternalRenderingParameters(int capacity, float capacityIncreaseMultiplier = 2, bool noTracking = false) : base(
            capacity,
            capacityIncreaseMultiplier,
            noTracking
        )
        {
        }

        public AppaList_ExternalRenderingParameters(AppaList<ExternalRenderingParameters> list) : base(list)
        {
        }

        public AppaList_ExternalRenderingParameters(ExternalRenderingParameters[] values) : base(values)
        {
        }
    }
}
