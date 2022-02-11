#region

using System;
using Appalachia.Core.Objects.Models;
using Appalachia.Rendering.Prefabs.Rendering.ModelType.Rendering;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Overrides
{
    [Serializable]
    public sealed class
        OverridableAssetLightingSettings : Overridable<AssetLightingSettings,
            OverridableAssetLightingSettings>
    {
        public OverridableAssetLightingSettings() : base(false, default)
        {
        }

        public OverridableAssetLightingSettings(
            bool isOverridingAllowed,
            bool overriding,
            AssetLightingSettings value) : base(overriding, value)
        {
        }

        public OverridableAssetLightingSettings(
            Overridable<AssetLightingSettings, OverridableAssetLightingSettings> value) : base(value)
        {
        }
    }
}
