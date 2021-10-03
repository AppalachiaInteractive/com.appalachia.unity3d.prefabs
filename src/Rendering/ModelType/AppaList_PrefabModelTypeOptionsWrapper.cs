#region

using System;
using Appalachia.Core.Collections;

#endregion

namespace Appalachia.Core.AssetMetadata.Options.ModelType
{
    [Serializable]
public sealed class AppaList_PrefabModelTypeOptionsWrapper : AppaList<PrefabModelTypeOptionsWrapper>
    {
        public AppaList_PrefabModelTypeOptionsWrapper()
        {
        }

        public AppaList_PrefabModelTypeOptionsWrapper(int capacity, float capacityIncreaseMultiplier = 2, bool noTracking = false) : base(
            capacity,
            capacityIncreaseMultiplier,
            noTracking
        )
        {
        }

        public AppaList_PrefabModelTypeOptionsWrapper(AppaList<PrefabModelTypeOptionsWrapper> list) : base(list)
        {
        }

        public AppaList_PrefabModelTypeOptionsWrapper(PrefabModelTypeOptionsWrapper[] values) : base(values)
        {
        }
    }
}
