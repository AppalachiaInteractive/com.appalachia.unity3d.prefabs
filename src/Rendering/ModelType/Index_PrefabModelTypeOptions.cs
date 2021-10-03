#region

using System;
using Appalachia.Core.Collections;
using Appalachia.Core.Editing.Coloring;
using UnityEngine;

#endregion

namespace Appalachia.Core.AssetMetadata.Options.ModelType
{
    [Serializable]
public class Index_PrefabModelTypeOptions : AppaLookup<PrefabModelType, PrefabModelTypeOptionsWrapper, AppaList_PrefabModelType,
    AppaList_PrefabModelTypeOptionsWrapper>
    {
        protected override string GetDisplayTitle(PrefabModelType key, PrefabModelTypeOptionsWrapper value)
        {
            return value.Title;
        }

        protected override string GetDisplaySubtitle(PrefabModelType key, PrefabModelTypeOptionsWrapper value)
        {
            return value.Subtitle;
        }

        protected override Color GetDisplayColor(PrefabModelType key, PrefabModelTypeOptionsWrapper value)
        {
            return value.options.isEnabled ? ColorPrefs.Instance.EnabledSubdued.v : ColorPrefs.Instance.DisabledImportantSubdued.v;
        }
    }
}
