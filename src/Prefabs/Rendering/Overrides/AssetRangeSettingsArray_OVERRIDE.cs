#region

using System;
using Appalachia.Core.Overrides;
using Appalachia.Rendering.Prefabs.Rendering.ModelType.Instancing;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Overrides
{
    [Serializable]
    public sealed class
        OverridableAssetRangeSettingsArray : Overridable<AssetRangeSettings[],
            OverridableAssetRangeSettingsArray>
    {
        public OverridableAssetRangeSettingsArray() : base(false, default)
        {
        }

        public OverridableAssetRangeSettingsArray(
            bool isOverridingAllowed,
            bool overrideEnabled,
            AssetRangeSettings[] value) : base(overrideEnabled, value)
        {
        }

        public OverridableAssetRangeSettingsArray(
            Overridable<AssetRangeSettings[], OverridableAssetRangeSettingsArray> value) : base(value)
        {
        }
    }
}
