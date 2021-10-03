#region

using System;
using Appalachia.Core.Overridding;

#endregion

namespace Appalachia.Core.AssetMetadata.Options
{
    [Serializable] 
public class PrefabModelType_OVERRIDE : Overridable<PrefabModelType, PrefabModelType_OVERRIDE>
    {
        public PrefabModelType_OVERRIDE(bool overrideEnabled, PrefabModelType value) : base(overrideEnabled, value)
        {
        }

        public PrefabModelType_OVERRIDE(Overridable<PrefabModelType, PrefabModelType_OVERRIDE> value) : base(value)
        {
        }

        public PrefabModelType_OVERRIDE() : base(false, default)
        {
        }
    }
}
