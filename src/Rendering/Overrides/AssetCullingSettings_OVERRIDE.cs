#region

using System;
using Appalachia.Core.Overrides;
using Appalachia.Prefabs.Rendering.ModelType.Rendering;

#endregion

namespace Appalachia.Prefabs.Rendering.Overrides
{
    [Serializable]
    public sealed class
        AssetCullingSettings_OVERRIDE : Overridable<AssetCullingSettings,
            AssetCullingSettings_OVERRIDE>
    {
        public AssetCullingSettings_OVERRIDE() : base(false, default)
        {
        }

        public AssetCullingSettings_OVERRIDE(
            bool isOverridingAllowed,
            bool overrideEnabled,
            AssetCullingSettings value) : base(overrideEnabled, value)
        {
        }

        public AssetCullingSettings_OVERRIDE(
            Overridable<AssetCullingSettings, AssetCullingSettings_OVERRIDE> value) : base(value)
        {
        }
    }
}
