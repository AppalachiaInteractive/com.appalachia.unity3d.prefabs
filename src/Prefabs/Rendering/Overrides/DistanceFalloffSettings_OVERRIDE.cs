#region

using System;
using Appalachia.Core.Overrides;
using Appalachia.Rendering.Prefabs.Rendering.ModelType.Rendering;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Overrides
{
    [Serializable]
    public sealed class
        OverridableDistanceFalloffSettings : Overridable<DistanceFalloffSettings,
            OverridableDistanceFalloffSettings>
    {
        public OverridableDistanceFalloffSettings() : base(false, default)
        {
        }

        public OverridableDistanceFalloffSettings(
            bool isOverridingAllowed,
            bool overrideEnabled,
            DistanceFalloffSettings value) : base(overrideEnabled, value)
        {
        }

        public OverridableDistanceFalloffSettings(
            Overridable<DistanceFalloffSettings, OverridableDistanceFalloffSettings> value) : base(
            value
        )
        {
        }
    }
}
