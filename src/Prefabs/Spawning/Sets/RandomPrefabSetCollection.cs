#region

using System.Collections.Generic;
using Appalachia.Core.Objects.Scriptables;
using Appalachia.Rendering.Prefabs.Spawning.Data;

#endregion

namespace Appalachia.Rendering.Prefabs.Spawning.Sets
{
    public class RandomPrefabSetCollection : AutonamedIdentifiableAppalachiaObject<RandomPrefabSetCollection>
    {
        #region Fields and Autoproperties

        public List<RandomPrefabSetElement> prefabSets = new();

        public List<RandomPrefabSpawnSource> spawners = new();

        #endregion

#if UNITY_EDITOR
        /// <inheritdoc />
        protected override bool ShowIDProperties => false;
#endif
    }
}
