#region

using System;
using Appalachia.Rendering.Prefabs.Core;
using Appalachia.Rendering.Prefabs.Rendering.Base;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.ModelType
{
    [Serializable]
    public class PrefabModelTypeCounts : PrefabTypeCounts<PrefabModelType>
    {
        /// <inheritdoc />
        protected override PrefabModelType FromPrefabSet(PrefabRenderingSet set)
        {
            return set.modelType;
        }
    }
}
