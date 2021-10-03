#region

using System;
using Appalachia.Core.Rendering.Metadata.GPUI;

#endregion

namespace Appalachia.Core.Collections.Implementations.Lists
{
    [Serializable]
    public sealed class 
        AppaList_GPUInstancerPrototypeMetadata : AppaList<GPUInstancerPrototypeMetadata>
    {
        public AppaList_GPUInstancerPrototypeMetadata()
        {
        }

        public AppaList_GPUInstancerPrototypeMetadata(int capacity, float capacityIncreaseMultiplier = 2, bool noTracking = false) : base(
            capacity,
            capacityIncreaseMultiplier,
            noTracking
        )
        {
        }

        public AppaList_GPUInstancerPrototypeMetadata(AppaList<GPUInstancerPrototypeMetadata> list) : base(list)
        {
        }

        public AppaList_GPUInstancerPrototypeMetadata(GPUInstancerPrototypeMetadata[] values) : base(values)
        {
        }
    }
}
