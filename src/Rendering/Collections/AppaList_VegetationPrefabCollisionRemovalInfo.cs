using System;
using Appalachia.Core.Collections;
using Appalachia.Prefabs.Rendering.Vegetation;

namespace Appalachia.Prefabs.Rendering.Collections
{
    [Serializable]
    public sealed class AppaList_VegetationPrefabCollisionRemovalInfo : AppaList<VegetationPrefabCollisionRemovalInfo>
    {
        public AppaList_VegetationPrefabCollisionRemovalInfo()
        {
        }

        public AppaList_VegetationPrefabCollisionRemovalInfo(int capacity, float capacityIncreaseMultiplier = 2, bool noTracking = false) : base(
            capacity,
            capacityIncreaseMultiplier,
            noTracking
        )
        {
        }

        public AppaList_VegetationPrefabCollisionRemovalInfo(AppaList<VegetationPrefabCollisionRemovalInfo> list) : base(list)
        {
        }

        public AppaList_VegetationPrefabCollisionRemovalInfo(VegetationPrefabCollisionRemovalInfo[] values) : base(values)
        {
        }
    }
}
