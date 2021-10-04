#region

using System;
using Appalachia.Core.Collections;
using Appalachia.Prefabs.Core;

#endregion

namespace Appalachia.Prefabs.Rendering.ModelType
{
    [Serializable]
public sealed class AppaList_PrefabModelType : AppaList<PrefabModelType>
    {
        public AppaList_PrefabModelType()
        {
        }

        public AppaList_PrefabModelType(int capacity, float capacityIncreaseMultiplier = 2, bool noTracking = false) : base(
            capacity,
            capacityIncreaseMultiplier,
            noTracking
        )
        {
        }

        public AppaList_PrefabModelType(AppaList<PrefabModelType> list) : base(list)
        {
        }

        public AppaList_PrefabModelType(PrefabModelType[] values) : base(values)
        {
        }
    }
}
