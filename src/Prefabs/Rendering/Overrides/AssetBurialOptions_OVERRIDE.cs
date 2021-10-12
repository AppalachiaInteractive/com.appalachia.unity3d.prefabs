#region

using System;
using Appalachia.Core.Overrides;
using Appalachia.Rendering.Prefabs.Rendering.ModelType.Positioning;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Overrides
{
    [Serializable]
    public sealed class
        AssetBurialOptions_OVERRIDE : Overridable<AssetBurialOptions, AssetBurialOptions_OVERRIDE>
    {
        public AssetBurialOptions_OVERRIDE() : base(false, default)
        {
        }

        public AssetBurialOptions_OVERRIDE(
            bool isOverridingAllowed,
            bool overrideEnabled,
            AssetBurialOptions value) : base(overrideEnabled, value)
        {
        }

        public AssetBurialOptions_OVERRIDE(
            Overridable<AssetBurialOptions, AssetBurialOptions_OVERRIDE> value) : base(value)
        {
        }
    }
}
