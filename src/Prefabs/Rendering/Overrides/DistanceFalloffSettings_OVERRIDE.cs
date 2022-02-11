#region

using System;
using Appalachia.Core.Objects.Models;
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
            bool overriding,
            DistanceFalloffSettings value) : base(overriding, value)
        {
        }

        public OverridableDistanceFalloffSettings(
            Overridable<DistanceFalloffSettings, OverridableDistanceFalloffSettings> value) : base(value)
        {
        }
    }
}
