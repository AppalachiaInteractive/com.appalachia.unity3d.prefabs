#region

using System;
using Appalachia.Core.Collections;
using Appalachia.Core.Collections.Implementations.Lists;
using Appalachia.Core.Extensions;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Prefabs.Rendering.Collections
{
    [Serializable]
    [ListDrawerSettings(Expanded = true, DraggableItems = false, HideAddButton = true, HideRemoveButton = true, NumberOfItemsPerPage = 5)]
    public class PrefabRenderingSetLookup : AppaLookup<GameObject, PrefabRenderingSet, AppaList_GameObject, AppaList_PrefabRenderingSet>
    {
        protected override string GetDisplayTitle(GameObject key, PrefabRenderingSet value)
        {
            return $"{value.modelType.ToString().SeperateWords()}: {key.name}";
        }

        protected override string GetDisplaySubtitle(GameObject key, PrefabRenderingSet value)
        {
            return value.instanceManager?.element?.stateCounts.ToString();
        }

        protected override Color GetDisplayColor(GameObject key, PrefabRenderingSet value)
        {
            return value._stateColor;
        }
    }
}
