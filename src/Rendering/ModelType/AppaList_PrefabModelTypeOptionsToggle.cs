#region

using System;
using Appalachia.Core.Collections;

#endregion

namespace Appalachia.Core.AssetMetadata.Options.ModelType
{
    [Serializable]
public sealed class AppaList_PrefabModelTypeOptionsToggle : AppaList<PrefabModelTypeOptionsToggle>
    {
        public AppaList_PrefabModelTypeOptionsToggle()
        {
        }

        public AppaList_PrefabModelTypeOptionsToggle(int capacity, float capacityIncreaseMultiplier = 2, bool noTracking = false) : base(
            capacity,
            capacityIncreaseMultiplier,
            noTracking
        )
        {
        }

        public AppaList_PrefabModelTypeOptionsToggle(AppaList<PrefabModelTypeOptionsToggle> list) : base(list)
        {
        }

        public AppaList_PrefabModelTypeOptionsToggle(PrefabModelTypeOptionsToggle[] values) : base(values)
        {
        }
    }
}
