#region

using System;
using Appalachia.Core.AssetMetadata.Options.ModelType.Rendering;

#endregion

namespace Appalachia.Core.Overridding.Implementations
{
    [Serializable]
    public sealed class DistanceFalloffSettings_OVERRIDE : Overridable<DistanceFalloffSettings, DistanceFalloffSettings_OVERRIDE>
    { public DistanceFalloffSettings_OVERRIDE() : base(false, default){}
        public DistanceFalloffSettings_OVERRIDE(bool isOverridingAllowed, bool overrideEnabled, DistanceFalloffSettings value) : base(
            overrideEnabled,
            value
        )
        {
        }

        public DistanceFalloffSettings_OVERRIDE(Overridable<DistanceFalloffSettings, DistanceFalloffSettings_OVERRIDE> value) : base(value)
        {
        }
    }
}
