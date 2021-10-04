#region

using System;
using Appalachia.Core.Collections;

#endregion

namespace Appalachia.Prefabs.Rendering.ContentType
{
    [Serializable]
    public sealed class
        AppaList_PrefabContentTypeOptionsToggle : AppaList<PrefabContentTypeOptionsToggle>
    {
        public AppaList_PrefabContentTypeOptionsToggle()
        {
        }

        public AppaList_PrefabContentTypeOptionsToggle(
            int capacity,
            float capacityIncreaseMultiplier = 2,
            bool noTracking = false) : base(capacity, capacityIncreaseMultiplier, noTracking)
        {
        }

        public AppaList_PrefabContentTypeOptionsToggle(
            AppaList<PrefabContentTypeOptionsToggle> list) : base(list)
        {
        }

        public AppaList_PrefabContentTypeOptionsToggle(PrefabContentTypeOptionsToggle[] values) :
            base(values)
        {
        }
    }
}
