#region

using System;
using Appalachia.Core.AssetMetadata.Options.Base;
using Appalachia.Core.Rendering.Metadata;

#endregion

namespace Appalachia.Core.AssetMetadata.Options.ModelType
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
