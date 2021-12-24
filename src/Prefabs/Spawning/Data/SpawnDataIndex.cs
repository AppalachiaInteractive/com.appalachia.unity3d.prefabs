using Appalachia.Core.Collections;
using Appalachia.Core.Collections.Implementations.Lists;
using Appalachia.Rendering.Prefabs.Spawning.Sets;
using Appalachia.Utility.Strings;
using UnityEngine;

namespace Appalachia.Rendering.Prefabs.Spawning.Data
{
    public class SpawnDataIndex : AppaLookup2<RandomPrefabSet, string, PrefabSpawnStateData,
        AppaList_RandomPrefabSet, stringList, AppaList_PrefabSpawnStateData,
        PrefabSpawnStateDataLookup, AppaList_PrefabSpawnStateDataIndex>
    {
        protected override string GetDisplayTitle(
            RandomPrefabSet key,
            PrefabSpawnStateDataLookup value)
        {
            return key.profileName;
        }

        protected override string GetDisplaySubtitle(
            RandomPrefabSet key,
            PrefabSpawnStateDataLookup value)
        {
            return ZString.Format("{0} sub-values", value.Count);
        }

        protected override Color GetDisplayColor(
            RandomPrefabSet key,
            PrefabSpawnStateDataLookup value)
        {
            return Color.white;
        }
    }
}
