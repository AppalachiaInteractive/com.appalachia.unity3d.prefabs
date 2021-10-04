using Appalachia.Core.Collections;
using Appalachia.Core.Collections.Implementations.Lists;
using UnityEngine;

namespace Appalachia.Prefabs.Spawning.Data
{
    public class PrefabSpawnStateDataLookup : AppaLookup<string, PrefabSpawnStateData,
        AppaList_string, AppaList_PrefabSpawnStateData>
    {
        protected override string GetDisplayTitle(string key, PrefabSpawnStateData value)
        {
            return key;
        }

        protected override string GetDisplaySubtitle(string key, PrefabSpawnStateData value)
        {
            return value.setElement.set.name;
        }

        protected override Color GetDisplayColor(string key, PrefabSpawnStateData value)
        {
            return Color.white;
        }
    }
}
