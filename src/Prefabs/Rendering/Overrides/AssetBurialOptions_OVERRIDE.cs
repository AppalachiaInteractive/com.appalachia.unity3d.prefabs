#region

using System;
using Appalachia.Core.Overrides;
using Appalachia.Rendering.Prefabs.Rendering.ModelType.Positioning;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Overrides
{
    [Serializable]
    public sealed class
        OverridableAssetBurialOptions : Overridable<AssetBurialOptions, OverridableAssetBurialOptions>
    {
        public OverridableAssetBurialOptions() : base(false, default)
        {
        }

        public OverridableAssetBurialOptions(
            bool isOverridingAllowed,
            bool overrideEnabled,
            AssetBurialOptions value) : base(overrideEnabled, value)
        {
        }

        public OverridableAssetBurialOptions(
            Overridable<AssetBurialOptions, OverridableAssetBurialOptions> value) : base(value)
        {
        }
    }
}
