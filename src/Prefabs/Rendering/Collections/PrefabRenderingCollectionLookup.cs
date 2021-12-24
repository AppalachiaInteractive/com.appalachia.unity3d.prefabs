#region

using System;
using System.Collections.Generic;
using Appalachia.Core.Collections;
using Appalachia.Core.Collections.Implementations.Lists;
using Appalachia.Rendering.Prefabs.Core;
using Appalachia.Rendering.Prefabs.Rendering.ModelType;
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
    public class PrefabRenderingCollectionLookup : AppaLookup<PrefabModelType, List<GameObject>,
        AppaList_PrefabModelType, AppaList_ListOfGameObject>
    {
        protected override string GetDisplayTitle(PrefabModelType key, List<GameObject> value)
        {
            return key.ToString().SeperateWords();
        }

        protected override string GetDisplaySubtitle(PrefabModelType key, List<GameObject> value)
        {
            return ZString.Format("{0} Game Objects", value.Count);
        }

        protected override Color GetDisplayColor(PrefabModelType key, List<GameObject> value)
        {
            return (value != null) && (value.Count > 0) ? Color.white : Color.gray;
        }
    }
}
