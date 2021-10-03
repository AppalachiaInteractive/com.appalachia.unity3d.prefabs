#region

using System;
using Appalachia.Core.AssetMetadata.Options.Base;

#endregion

namespace Appalachia.Core.AssetMetadata.Options.ContentType
{
    [Serializable]
    public class PrefabContentTypeOptions : PrefabTypeOptions<PrefabContentType, PrefabContentTypeOptions, PrefabContentTypeOptionsOverride,
        PrefabContentTypeOptionsSetData, PrefabContentTypeOptionsWrapper, PrefabContentTypeOptionsLookup, Index_PrefabContentTypeOptions,
        PrefabContentTypeOptionsToggle, Index_PrefabContentTypeOptionsToggle, AppaList_PrefabContentType,
        AppaList_PrefabContentTypeOptionsWrapper, AppaList_PrefabContentTypeOptionsToggle>
    {
        public override bool UpdateForValidity()
        {
            return false;
        }
    }
}
