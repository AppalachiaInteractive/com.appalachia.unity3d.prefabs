#region

using System;
using Appalachia.Rendering.Prefabs.Core;
using Appalachia.Rendering.Prefabs.Rendering.Base;
using Sirenix.OdinInspector;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.ContentType
{
    [Serializable]
    [HideReferenceObjectPicker]
    public class PrefabContentTypeOptionsToggle : PrefabTypeOptionsToggle<PrefabContentType,
        PrefabContentTypeOptions, PrefabContentTypeOptionsOverride, PrefabContentTypeOptionsSetData,
        PrefabContentTypeOptionsWrapper, PrefabContentTypeOptionsLookup,
        Index_PrefabContentTypeOptions, PrefabContentTypeOptionsToggle,
        Index_PrefabContentTypeOptionsToggle, AppaList_PrefabContentType,
        AppaList_PrefabContentTypeOptionsWrapper, AppaList_PrefabContentTypeOptionsToggle>
    {
        public PrefabContentTypeOptionsToggle()
        {
        }

        public PrefabContentTypeOptionsToggle(PrefabContentTypeOptionsWrapper options)
        {
            this.options = options;
        }
    }
}
