#region

using System;
using Appalachia.Core.Collections;
using Appalachia.Core.Preferences.Globals;
using Appalachia.Rendering.Prefabs.Core;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.ContentType
{
    [Serializable]
    public class Index_PrefabContentTypeOptions : AppaLookup<PrefabContentType,
        PrefabContentTypeOptionsWrapper, AppaList_PrefabContentType, AppaList_PrefabContentTypeOptionsWrapper>
    {
        protected override Color GetDisplayColor(PrefabContentType key, PrefabContentTypeOptionsWrapper value)
        {
            return value.options.isEnabled
                ? ColorPrefs.Instance.EnabledSubdued.v
                : ColorPrefs.Instance.DisabledImportantSubdued.v;
        }

        protected override string GetDisplaySubtitle(
            PrefabContentType key,
            PrefabContentTypeOptionsWrapper value)
        {
            return value.Subtitle;
        }

        protected override string GetDisplayTitle(
            PrefabContentType key,
            PrefabContentTypeOptionsWrapper value)
        {
            return value.Title;
        }
    }
}
