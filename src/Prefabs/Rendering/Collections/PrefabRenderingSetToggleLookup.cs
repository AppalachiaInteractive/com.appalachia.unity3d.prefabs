#region

using System;
using Appalachia.Core.Collections;
using Appalachia.Core.Collections.Implementations.Lists;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Collections
{
    [Serializable]
    public class PrefabRenderingSetToggleLookup : AppaLookup<GameObject, PrefabRenderingSetToggle,
        AppaList_GameObject, AppaList_PrefabRenderingSetToggle>
    {
        /// <inheritdoc />
        protected override bool NoTracking => true;

        /// <inheritdoc />
        protected override bool ShouldDisplayTitle => false;

        /// <inheritdoc />
        protected override Color GetDisplayColor(GameObject key, PrefabRenderingSetToggle value)
        {
            return Color.white;
        }

        /// <inheritdoc />
        protected override string GetDisplaySubtitle(GameObject key, PrefabRenderingSetToggle value)
        {
            return string.Empty;
        }

        /// <inheritdoc />
        protected override string GetDisplayTitle(GameObject key, PrefabRenderingSetToggle value)
        {
            return string.Empty;
        }
    }
}
