#region

using System;
using Appalachia.Core.AssetMetadata.Options.Base;
using Appalachia.Core.Rendering.Metadata;

#endregion

namespace Appalachia.Core.AssetMetadata.Options.ContentType
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
