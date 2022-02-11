#region

using System;
using Appalachia.Core.Objects.Models;
using Appalachia.Rendering.Prefabs.Rendering.ModelType.Instancing;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Overrides
{
    [Serializable]
    public sealed class OverridableFrustumSettings : Overridable<FrustumSettings, OverridableFrustumSettings>
    {
        public OverridableFrustumSettings() : base(false, default)
        {
        }

        public OverridableFrustumSettings(
            bool isOverridingAllowed,
            bool overriding,
            FrustumSettings value) : base(overriding, value)
        {
        }

        public OverridableFrustumSettings(
            Overridable<FrustumSettings, OverridableFrustumSettings> value) : base(value)
        {
        }
    }
}
