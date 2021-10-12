#region

using System;
using Appalachia.Core.Overrides;
using Appalachia.Rendering.Prefabs.Rendering.ModelType.Rendering;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Overrides
{
    [Serializable]
    public sealed class
        AssetLightingSettings_OVERRIDE : Overridable<AssetLightingSettings,
            AssetLightingSettings_OVERRIDE>
    {
        public AssetLightingSettings_OVERRIDE() : base(false, default)
        {
        }

        public AssetLightingSettings_OVERRIDE(
            bool isOverridingAllowed,
            bool overrideEnabled,
            AssetLightingSettings value) : base(overrideEnabled, value)
        {
        }

        public AssetLightingSettings_OVERRIDE(
            Overridable<AssetLightingSettings, AssetLightingSettings_OVERRIDE> value) : base(value)
        {
        }
    }
}
