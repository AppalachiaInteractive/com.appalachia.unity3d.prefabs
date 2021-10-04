#region

using System;
using Appalachia.Core.Collections;
using Appalachia.Editing.Preferences.Globals;
using Appalachia.Prefabs.Core;
using UnityEngine;

#endregion

namespace Appalachia.Prefabs.Rendering.ContentType
{
    [Serializable]
    public class Index_PrefabContentTypeOptions : AppaLookup<PrefabContentType,
        PrefabContentTypeOptionsWrapper, AppaList_PrefabContentType,
        AppaList_PrefabContentTypeOptionsWrapper>
    {
        protected override string GetDisplayTitle(
            PrefabContentType key,
            PrefabContentTypeOptionsWrapper value)
        {
            return value.Title;
        }

        protected override string GetDisplaySubtitle(
            PrefabContentType key,
            PrefabContentTypeOptionsWrapper value)
        {
            return value.Subtitle;
        }

        protected override Color GetDisplayColor(
            PrefabContentType key,
            PrefabContentTypeOptionsWrapper value)
        {
            return value.options.isEnabled
                ? ColorPrefs.Instance.EnabledSubdued.v
                : ColorPrefs.Instance.DisabledImportantSubdued.v;
        }
    }
}
