using System;
using Appalachia.Core.Collections;
using Appalachia.Core.Collections.Implementations.Lists;
using UnityEngine;

namespace Appalachia.Rendering.Prefabs.Spawning.Data
{
    [Serializable]
    public class PrefabSpawnStateDataLookup : AppaLookup<string, PrefabSpawnStateData, stringList,
        AppaList_PrefabSpawnStateData>
    {
        /// <inheritdoc />
        protected override Color GetDisplayColor(string key, PrefabSpawnStateData value)
        {
            return Color.white;
        }

        /// <inheritdoc />
        protected override string GetDisplaySubtitle(string key, PrefabSpawnStateData value)
        {
            return value.setElement.set.name;
        }

        /// <inheritdoc />
        protected override string GetDisplayTitle(string key, PrefabSpawnStateData value)
        {
            return key;
        }
    }
}
