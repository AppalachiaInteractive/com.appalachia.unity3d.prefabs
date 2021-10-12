#region

using System.Collections.Generic;
using Appalachia.Core.Scriptables;

#endregion

namespace Appalachia.Rendering.Prefabs.Spawning.Sets
{
    public class
        RandomPrefabMasterCollection : SelfSavingSingletonScriptableObject<
            RandomPrefabMasterCollection>
    {
        public List<RandomPrefabSetCollection> collections = new();
    }
}
