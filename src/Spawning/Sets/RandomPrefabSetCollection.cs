#region

using System.Collections.Generic;
using Appalachia.Core.Scriptables;
using Appalachia.Core.Spawning.Data;

#endregion

namespace Appalachia.Core.Spawning.Sets
{
    public class RandomPrefabSetCollection : SelfNamingSavingAndIdentifyingScriptableObject<RandomPrefabSetCollection>
    {
        public List<RandomPrefabSetElement> prefabSets = new List<RandomPrefabSetElement>();

        public List<RandomPrefabSpawnSource> spawners = new List<RandomPrefabSpawnSource>();
        protected override bool ShowIDProperties => false;
    }
}
