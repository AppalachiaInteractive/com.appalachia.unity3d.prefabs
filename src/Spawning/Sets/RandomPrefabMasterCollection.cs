#region

using System.Collections.Generic;
using Appalachia.Base.Scriptables;

#endregion

namespace Appalachia.Prefabs.Spawning.Sets
{
    public class
        RandomPrefabMasterCollection : SelfSavingSingletonScriptableObject<
            RandomPrefabMasterCollection>
    {
        public List<RandomPrefabSetCollection> collections = new();
    }
}
