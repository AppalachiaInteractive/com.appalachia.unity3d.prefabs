#region

using System;
using Appalachia.Core.AssetMetadata.Options.ModelType.Rendering;

#endregion

namespace Appalachia.Core.Overridding.Implementations
{
    [Serializable]
    public sealed class AssetCullingSettings_OVERRIDE : Overridable<AssetCullingSettings, AssetCullingSettings_OVERRIDE>
    { public AssetCullingSettings_OVERRIDE() : base(false, default){}
        public AssetCullingSettings_OVERRIDE(bool isOverridingAllowed, bool overrideEnabled, AssetCullingSettings value) : base(
            overrideEnabled,
            value
        )
        {
        }

        public AssetCullingSettings_OVERRIDE(Overridable<AssetCullingSettings, AssetCullingSettings_OVERRIDE> value) : base(value)
        {
        }
    }
}
