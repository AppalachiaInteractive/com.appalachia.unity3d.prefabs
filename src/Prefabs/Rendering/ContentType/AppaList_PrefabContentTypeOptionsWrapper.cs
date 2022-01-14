#region

using System;
using Appalachia.Core.Collections;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.ContentType
{
    [Serializable]
    public sealed class AppaList_PrefabContentTypeOptionsWrapper : AppaList<PrefabContentTypeOptionsWrapper>
    {
        public AppaList_PrefabContentTypeOptionsWrapper()
        {
        }

        public AppaList_PrefabContentTypeOptionsWrapper(
            int capacity,
            float capacityIncreaseMultiplier = 2,
            bool noTracking = false) : base(capacity, capacityIncreaseMultiplier, noTracking)
        {
        }

        public AppaList_PrefabContentTypeOptionsWrapper(AppaList<PrefabContentTypeOptionsWrapper> list) :
            base(list)
        {
        }

        public AppaList_PrefabContentTypeOptionsWrapper(PrefabContentTypeOptionsWrapper[] values) : base(
            values
        )
        {
        }
    }
}
