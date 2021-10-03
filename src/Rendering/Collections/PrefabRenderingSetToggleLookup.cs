#region

using System;
using Appalachia.Core.Collections.Implementations.Lists;
using Appalachia.Core.Rendering.Metadata;
using UnityEngine;

#endregion

namespace Appalachia.Core.Collections.Implementations.Lookups
{
    [Serializable]
    public class PrefabRenderingSetToggleLookup : AppaLookup<GameObject, PrefabRenderingSetToggle, AppaList_GameObject,
        AppaList_PrefabRenderingSetToggle>
    {
        protected override bool ShouldDisplayTitle => false;

        protected override bool NoTracking => true;

        protected override string GetDisplayTitle(GameObject key, PrefabRenderingSetToggle value)
        {
            return string.Empty;
        }

        protected override string GetDisplaySubtitle(GameObject key, PrefabRenderingSetToggle value)
        {
            return string.Empty;
        }

        protected override Color GetDisplayColor(GameObject key, PrefabRenderingSetToggle value)
        {
            return Color.white;
        }
    }
}
