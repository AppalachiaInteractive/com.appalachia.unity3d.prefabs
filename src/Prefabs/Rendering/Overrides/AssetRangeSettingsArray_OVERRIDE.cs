#region

using System;
using Appalachia.Core.Overrides;
using Appalachia.Rendering.Prefabs.Rendering.ModelType.Instancing;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Overrides
{
    [Serializable]
    public sealed class
        AssetRangeSettingsArray_OVERRIDE : Overridable<AssetRangeSettings[],
            AssetRangeSettingsArray_OVERRIDE>
    {
        public AssetRangeSettingsArray_OVERRIDE() : base(false, default)
        {
        }

        public AssetRangeSettingsArray_OVERRIDE(
            bool isOverridingAllowed,
            bool overrideEnabled,
            AssetRangeSettings[] value) : base(overrideEnabled, value)
        {
        }

        public AssetRangeSettingsArray_OVERRIDE(
            Overridable<AssetRangeSettings[], AssetRangeSettingsArray_OVERRIDE> value) : base(value)
        {
        }
    }
}
