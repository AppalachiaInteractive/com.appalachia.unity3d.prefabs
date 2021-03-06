#region

using System;
using Appalachia.Core.Collections;
using Appalachia.Rendering.Prefabs.Core;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.ContentType
{
    [Serializable]
    public sealed class AppaList_PrefabContentType : AppaList<PrefabContentType>
    {
        public AppaList_PrefabContentType()
        {
        }

        public AppaList_PrefabContentType(
            int capacity,
            float capacityIncreaseMultiplier = 2,
            bool noTracking = false) : base(capacity, capacityIncreaseMultiplier, noTracking)
        {
        }

        public AppaList_PrefabContentType(AppaList<PrefabContentType> list) : base(list)
        {
        }

        public AppaList_PrefabContentType(PrefabContentType[] values) : base(values)
        {
        }
    }
}
