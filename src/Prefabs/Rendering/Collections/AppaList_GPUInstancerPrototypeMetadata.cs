#region

using System;
using Appalachia.Core.Collections;
using Appalachia.Rendering.Prefabs.Rendering.GPUI;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Collections
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
