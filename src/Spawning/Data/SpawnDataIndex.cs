using Appalachia.Core.Collections;
using Appalachia.Core.Collections.Implementations.Lists;
using Appalachia.Core.Spawning.Sets;
using UnityEngine;

namespace Appalachia.Core.Spawning.Data
{
    public class SpawnDataIndex : AppaLookup2<RandomPrefabSet, string, PrefabSpawnStateData, AppaList_RandomPrefabSet, AppaList_string,
        AppaList_PrefabSpawnStateData, PrefabSpawnStateDataLookup, AppaList_PrefabSpawnStateDataIndex>
    {
        protected override string GetDisplayTitle(RandomPrefabSet key, PrefabSpawnStateDataLookup value)
        {
            return key.profileName;
        }

        protected override string GetDisplaySubtitle(RandomPrefabSet key, PrefabSpawnStateDataLookup value)
        {
            return $"{value.Count} sub-values";
        }

        protected override Color GetDisplayColor(RandomPrefabSet key, PrefabSpawnStateDataLookup value)
        {
            return Color.white;
        }
    }
}