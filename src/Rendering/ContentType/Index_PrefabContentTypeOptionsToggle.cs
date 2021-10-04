#region

using System;
using Appalachia.Core.Collections;
using Appalachia.Prefabs.Core;
using UnityEngine;

#endregion

namespace Appalachia.Prefabs.Rendering.ContentType
{
    [Serializable]
public class Index_PrefabContentTypeOptionsToggle : AppaLookup<PrefabContentType, PrefabContentTypeOptionsToggle, AppaList_PrefabContentType,
    AppaList_PrefabContentTypeOptionsToggle>
    {
        protected override bool ShouldDisplayTitle => false;
        protected override bool NoTracking => true;

        protected override string GetDisplayTitle(PrefabContentType key, PrefabContentTypeOptionsToggle value)
        {
            return string.Empty;
        }

        protected override string GetDisplaySubtitle(PrefabContentType key, PrefabContentTypeOptionsToggle value)
        {
            return string.Empty;
        }

        protected override Color GetDisplayColor(PrefabContentType key, PrefabContentTypeOptionsToggle value)
        {
            return Color.white;
        }
    }
}
