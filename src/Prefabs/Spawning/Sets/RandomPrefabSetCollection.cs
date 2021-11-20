#region

using System.Collections.Generic;
using Appalachia.Core.Scriptables;
using Appalachia.Rendering.Prefabs.Spawning.Data;

#endregion

namespace Appalachia.Rendering.Prefabs.Spawning.Sets
{
    public class RandomPrefabSetCollection : AutonamedIdentifiableAppalachiaObject
    {
        public List<RandomPrefabSetElement> prefabSets = new();

        public List<RandomPrefabSpawnSource> spawners = new();
#if UNITY_EDITOR
        protected override bool ShowIDProperties => false;
#endif
    }
}
