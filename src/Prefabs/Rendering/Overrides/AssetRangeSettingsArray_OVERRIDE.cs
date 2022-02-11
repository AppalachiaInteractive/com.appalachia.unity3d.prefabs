#region

using System;
using Appalachia.Core.Objects.Models;
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
            bool overriding,
            AssetRangeSettings[] value) : base(overriding, value)
        {
        }

        public OverridableAssetRangeSettingsArray(
            Overridable<AssetRangeSettings[], OverridableAssetRangeSettingsArray> value) : base(value)
        {
        }
    }
}
