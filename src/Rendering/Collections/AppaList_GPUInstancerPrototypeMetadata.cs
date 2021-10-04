#region

using System;
using Appalachia.Core.Collections;
using Appalachia.Prefabs.Rendering.GPUI;

#endregion

namespace Appalachia.Prefabs.Rendering.Collections
{
    [Serializable]
    public sealed class
        AppaList_GPUInstancerPrototypeMetadata : AppaList<GPUInstancerPrototypeMetadata>
    {
        public AppaList_GPUInstancerPrototypeMetadata()
        {
        }

        public AppaList_GPUInstancerPrototypeMetadata(
            int capacity,
            float capacityIncreaseMultiplier = 2,
            bool noTracking = false) : base(capacity, capacityIncreaseMultiplier, noTracking)
        {
        }

        public AppaList_GPUInstancerPrototypeMetadata(
            AppaList<GPUInstancerPrototypeMetadata> list) : base(list)
        {
        }

        public AppaList_GPUInstancerPrototypeMetadata(GPUInstancerPrototypeMetadata[] values) :
            base(values)
        {
        }
    }
}
