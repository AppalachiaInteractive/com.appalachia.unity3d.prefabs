#region

using System;
using Appalachia.Core.Collections;
using Appalachia.Core.Collections.Implementations.Lists;
using Appalachia.Utility.Extensions;
using Appalachia.Utility.Strings;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Collections
{
    [Serializable]
    [ListDrawerSettings(
        Expanded = true,
        DraggableItems = false,
        HideAddButton = true,
        HideRemoveButton = true,
        NumberOfItemsPerPage = 5
    )]
    public class PrefabRenderingSetLookup : AppaLookup<GameObject, PrefabRenderingSet, AppaList_GameObject,
        AppaList_PrefabRenderingSet>
    {
        /// <inheritdoc />
        protected override Color GetDisplayColor(GameObject key, PrefabRenderingSet value)
        {
            return value._stateColor;
        }

        /// <inheritdoc />
        protected override string GetDisplaySubtitle(GameObject key, PrefabRenderingSet value)
        {
            return value.instanceManager?.element?.stateCounts.ToString();
        }

        /// <inheritdoc />
        protected override string GetDisplayTitle(GameObject key, PrefabRenderingSet value)
        {
            return ZString.Format("{0}: {1}", value.modelType.ToString().SeperateWords(), key.name);
        }
    }
}
