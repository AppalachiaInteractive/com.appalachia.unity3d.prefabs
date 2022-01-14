#region

using System;
using Appalachia.Rendering.Prefabs.Core;
using Appalachia.Rendering.Prefabs.Rendering.Base;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.ContentType
{
    [Serializable]
    public class PrefabContentTypeOptions : PrefabTypeOptions<PrefabContentType, PrefabContentTypeOptions,
        PrefabContentTypeOptionsOverride, PrefabContentTypeOptionsSetData, PrefabContentTypeOptionsWrapper,
        PrefabContentTypeOptionsLookup, Index_PrefabContentTypeOptions, PrefabContentTypeOptionsToggle,
        Index_PrefabContentTypeOptionsToggle, AppaList_PrefabContentType,
        AppaList_PrefabContentTypeOptionsWrapper, AppaList_PrefabContentTypeOptionsToggle>
    {
        public override bool UpdateForValidity()
        {
            return false;
        }
    }
}
