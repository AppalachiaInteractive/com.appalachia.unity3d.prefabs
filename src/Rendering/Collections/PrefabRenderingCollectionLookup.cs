#region

using System;
using System.Collections.Generic;
using Appalachia.Core.AssetMetadata.Options;
using Appalachia.Core.AssetMetadata.Options.ModelType;
using Appalachia.Core.Collections.Implementations.Lists;
using Appalachia.Core.Extensions;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Core.Collections.Implementations.Lookups
{
    [Serializable]
    [ListDrawerSettings(Expanded = true, DraggableItems = false, HideAddButton = true, HideRemoveButton = true, NumberOfItemsPerPage = 5)]
    public class PrefabRenderingCollectionLookup : AppaLookup<PrefabModelType, List<GameObject>, AppaList_PrefabModelType,
        AppaList_ListOfGameObject>
    {
        protected override string GetDisplayTitle(PrefabModelType key, List<GameObject> value)
        {
            return key.ToString().SeperateWords();
        }

        protected override string GetDisplaySubtitle(PrefabModelType key, List<GameObject> value)
        {
            return $"{value.Count} Game Objects";
        }

        protected override Color GetDisplayColor(PrefabModelType key, List<GameObject> value)
        {
            return value != null && value.Count > 0 ? Color.white : Color.gray;
        }
    }
}
