#region

using System;
using Appalachia.Core.Overrides;
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
            bool overrideEnabled,
            AssetLightingSettings value) : base(overrideEnabled, value)
        {
        }

        public OverridableAssetLightingSettings(
            Overridable<AssetLightingSettings, OverridableAssetLightingSettings> value) : base(value)
        {
        }
    }
}
