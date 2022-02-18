#region

using System;
using Appalachia.Core.Collections;
using Appalachia.Rendering.Prefabs.Core;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.ModelType
{
    [Serializable]
    public class Index_PrefabModelTypeOptionsToggle : AppaLookup<PrefabModelType, PrefabModelTypeOptionsToggle
        , AppaList_PrefabModelType, AppaList_PrefabModelTypeOptionsToggle>
    {
        /// <inheritdoc />
        protected override bool NoTracking => true;

        /// <inheritdoc />
        protected override bool ShouldDisplayTitle => false;

        /// <inheritdoc />
        protected override Color GetDisplayColor(PrefabModelType key, PrefabModelTypeOptionsToggle value)
        {
            return Color.white;
        }

        /// <inheritdoc />
        protected override string GetDisplaySubtitle(PrefabModelType key, PrefabModelTypeOptionsToggle value)
        {
            return string.Empty;
        }

        /// <inheritdoc />
        protected override string GetDisplayTitle(PrefabModelType key, PrefabModelTypeOptionsToggle value)
        {
            return string.Empty;
        }
    }
}
