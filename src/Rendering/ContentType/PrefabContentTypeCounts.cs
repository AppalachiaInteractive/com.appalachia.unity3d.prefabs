#region

using System;
using Appalachia.Prefabs.Core;
using Appalachia.Prefabs.Rendering.Base;

#endregion

namespace Appalachia.Prefabs.Rendering.ContentType
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
