#region

using System;
using Appalachia.Core.Objects.Models;
using Appalachia.Rendering.Prefabs.Rendering.ModelType.Rendering;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Overrides
{
    [Serializable]
    public sealed class
        OverridableAssetCullingSettings : Overridable<AssetCullingSettings, OverridableAssetCullingSettings>
    {
        public OverridableAssetCullingSettings() : base(false, default)
        {
        }

        public OverridableAssetCullingSettings(
            bool isOverridingAllowed,
            bool overriding,
            AssetCullingSettings value) : base(overriding, value)
        {
        }

        public OverridableAssetCullingSettings(
            Overridable<AssetCullingSettings, OverridableAssetCullingSettings> value) : base(value)
        {
        }
    }
}
