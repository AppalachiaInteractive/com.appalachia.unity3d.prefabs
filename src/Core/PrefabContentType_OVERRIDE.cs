#region

using System;
using Appalachia.Core.Overridding;

#endregion

namespace Appalachia.Core.AssetMetadata.Options
{
    [Serializable] 
public class PrefabContentType_OVERRIDE : Overridable<PrefabContentType, PrefabContentType_OVERRIDE>
    {
        public PrefabContentType_OVERRIDE(bool overrideEnabled, PrefabContentType value) : base(overrideEnabled, value)
        {
        }

        public PrefabContentType_OVERRIDE(Overridable<PrefabContentType, PrefabContentType_OVERRIDE> value) : base(value)
        {
        }

        public PrefabContentType_OVERRIDE() : base(false, default)
        {
        }
    }
}
