#region

using System;
using Appalachia.Prefabs.Core;
using Appalachia.Prefabs.Rendering.Base;

#endregion

namespace Appalachia.Prefabs.Rendering.ModelType
{
    [Serializable]
    public class PrefabModelTypeCounts : PrefabTypeCounts<PrefabModelType>
    {
        protected override PrefabModelType FromPrefabSet(PrefabRenderingSet set)
        {
            return set.modelType;
        }
    }
}
