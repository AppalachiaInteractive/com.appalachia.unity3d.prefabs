#region

using System.Collections.Generic;
using Appalachia.Base.Scriptables;
using Appalachia.Prefabs.Spawning.Data;

#endregion

namespace Appalachia.Prefabs.Spawning.Sets
{
    public class RandomPrefabSetCollection : SelfNamingSavingAndIdentifyingScriptableObject<RandomPrefabSetCollection>
    {
        public List<RandomPrefabSetElement> prefabSets = new List<RandomPrefabSetElement>();

        public List<RandomPrefabSpawnSource> spawners = new List<RandomPrefabSpawnSource>();
        protected override bool ShowIDProperties => false;
    }
}
