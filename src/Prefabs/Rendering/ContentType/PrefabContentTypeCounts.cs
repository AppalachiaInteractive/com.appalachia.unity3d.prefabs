#region

using System;
using Appalachia.Rendering.Prefabs.Core;
using Appalachia.Rendering.Prefabs.Rendering.Base;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.ContentType
{
    [Serializable]
    public class PrefabContentTypeCounts : PrefabTypeCounts<PrefabContentType>
    {
        protected override PrefabContentType FromPrefabSet(PrefabRenderingSet set)
        {
            return set.contentType;
        }
    }
}
