#region

using System;
using Appalachia.Core.AssetMetadata.Options.ModelType.Instancing;

#endregion

namespace Appalachia.Core.Overridding.Implementations
{
    [Serializable]
    public sealed class AssetRangeSettingsArray_OVERRIDE : Overridable<AssetRangeSettings[], AssetRangeSettingsArray_OVERRIDE>
    {
        
        public AssetRangeSettingsArray_OVERRIDE() : base(
            false,
            default
        )
        {
        }
        
        public AssetRangeSettingsArray_OVERRIDE(bool isOverridingAllowed, bool overrideEnabled, AssetRangeSettings[] value) : base(
            overrideEnabled,
            value
        )
        {
        }

        public AssetRangeSettingsArray_OVERRIDE(Overridable<AssetRangeSettings[], AssetRangeSettingsArray_OVERRIDE> value) : base(value)
        {
        }
    }
}
