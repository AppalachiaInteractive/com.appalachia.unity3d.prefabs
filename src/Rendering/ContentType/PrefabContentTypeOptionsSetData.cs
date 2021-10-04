#region

using System;
using Appalachia.Prefabs.Core;
using Appalachia.Prefabs.Rendering.Base;

#endregion

namespace Appalachia.Prefabs.Rendering.ContentType
{
    [Serializable]
public class PrefabContentTypeOptionsSetData : PrefabTypeOptionsSetData<PrefabContentType, PrefabContentTypeOptions,
        PrefabContentTypeOptionsOverride, PrefabContentTypeOptionsSetData, PrefabContentTypeOptionsWrapper, PrefabContentTypeOptionsLookup,
        Index_PrefabContentTypeOptions, PrefabContentTypeOptionsToggle, Index_PrefabContentTypeOptionsToggle, AppaList_PrefabContentType,
        AppaList_PrefabContentTypeOptionsWrapper, AppaList_PrefabContentTypeOptionsToggle>
    {
        public override void SyncOverridesFull(bool hasInteractions, bool hasColliders)
        {
        }

        public override void SyncOverrides()
        {
        }
    }
}
