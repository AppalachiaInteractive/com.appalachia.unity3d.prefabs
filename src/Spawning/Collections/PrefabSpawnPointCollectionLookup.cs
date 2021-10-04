#region

using System;
using Appalachia.Core.Collections;
using Appalachia.Core.Collections.Implementations.Lists;
using Appalachia.Prefabs.Spawning.Data;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Prefabs.Spawning.Collections
{
    [Serializable]
    [ListDrawerSettings(Expanded = true, DraggableItems = false, HideAddButton = true, HideRemoveButton = true, NumberOfItemsPerPage = 5)]
    public class PrefabSpawnPointCollectionLookup : AppaLookup<string, PrefabSpawnPointCollection, AppaList_string,
        AppaList_PrefabSpawnPointCollection>
    {
        protected override string GetDisplayTitle(string key, PrefabSpawnPointCollection value)
        {
            throw new NotImplementedException();
        }

        protected override string GetDisplaySubtitle(string key, PrefabSpawnPointCollection value)
        {
            throw new NotImplementedException();
        }

        protected override Color GetDisplayColor(string key, PrefabSpawnPointCollection value)
        {
            throw new NotImplementedException();
        }
    }
}
