#region

using System;
using Appalachia.Core.Overrides;
using Appalachia.Rendering.Prefabs.Rendering.ModelType.Rendering;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Overrides
{
    [Serializable]
    public sealed class
        DistanceFalloffSettings_OVERRIDE : Overridable<DistanceFalloffSettings,
            DistanceFalloffSettings_OVERRIDE>
    {
        public DistanceFalloffSettings_OVERRIDE() : base(false, default)
        {
        }

        public DistanceFalloffSettings_OVERRIDE(
            bool isOverridingAllowed,
            bool overrideEnabled,
            DistanceFalloffSettings value) : base(overrideEnabled, value)
        {
        }

        public DistanceFalloffSettings_OVERRIDE(
            Overridable<DistanceFalloffSettings, DistanceFalloffSettings_OVERRIDE> value) : base(
            value
        )
        {
        }
    }
}
