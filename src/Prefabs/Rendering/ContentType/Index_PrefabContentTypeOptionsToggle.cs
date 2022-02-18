#region

using System;
using Appalachia.Core.Collections;
using Appalachia.Rendering.Prefabs.Core;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.ContentType
{
    [Serializable]
    public class Index_PrefabContentTypeOptionsToggle : AppaLookup<PrefabContentType,
        PrefabContentTypeOptionsToggle, AppaList_PrefabContentType, AppaList_PrefabContentTypeOptionsToggle>
    {
        /// <inheritdoc />
        protected override bool NoTracking => true;

        /// <inheritdoc />
        protected override bool ShouldDisplayTitle => false;

        /// <inheritdoc />
        protected override Color GetDisplayColor(PrefabContentType key, PrefabContentTypeOptionsToggle value)
        {
            return Color.white;
        }

        /// <inheritdoc />
        protected override string GetDisplaySubtitle(
            PrefabContentType key,
            PrefabContentTypeOptionsToggle value)
        {
            return string.Empty;
        }

        /// <inheritdoc />
        protected override string GetDisplayTitle(PrefabContentType key, PrefabContentTypeOptionsToggle value)
        {
            return string.Empty;
        }
    }
}
