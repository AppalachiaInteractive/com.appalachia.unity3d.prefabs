#region

using System.Collections.Generic;
using Appalachia.Core.Scriptables;
using Appalachia.Rendering.Prefabs.Spawning.Data;

#endregion

namespace Appalachia.Rendering.Prefabs.Spawning.Sets
{
    public class RandomPrefabSetCollection : SelfNamingSavingAndIdentifyingScriptableObject<
        RandomPrefabSetCollection>
    {
        public List<RandomPrefabSetElement> prefabSets = new();

        public List<RandomPrefabSpawnSource> spawners = new();
        protected override bool ShowIDProperties => false;
    }
}
