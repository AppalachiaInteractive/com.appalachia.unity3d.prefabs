#region

using System;
using Appalachia.Core.Collections;
using Appalachia.Core.Collections.Implementations.Lists;
using Appalachia.Rendering.Prefabs.Spawning.Data;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Spawning.Collections
{
    [Serializable]
    [ListDrawerSettings(
        Expanded = true,
        DraggableItems = false,
        HideAddButton = true,
        HideRemoveButton = true,
        NumberOfItemsPerPage = 5
    )]
    public class PrefabSpawnPointCollectionLookup : AppaLookup<string, PrefabSpawnPointCollection, stringList,
        AppaList_PrefabSpawnPointCollection>
    {
        /// <inheritdoc />
        protected override Color GetDisplayColor(string key, PrefabSpawnPointCollection value)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        protected override string GetDisplaySubtitle(string key, PrefabSpawnPointCollection value)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        protected override string GetDisplayTitle(string key, PrefabSpawnPointCollection value)
        {
            throw new NotImplementedException();
        }
    }
}
