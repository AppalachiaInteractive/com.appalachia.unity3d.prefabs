#region

using System;
using Appalachia.Core.Objects.Models;
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
            bool overriding,
            AssetBurialOptions value) : base(overriding, value)
        {
        }

        public OverridableAssetBurialOptions(
            Overridable<AssetBurialOptions, OverridableAssetBurialOptions> value) : base(value)
        {
        }
    }
}
