#region

using System;
using Appalachia.Core.Overrides;
using Appalachia.Prefabs.Rendering.ModelType.Instancing;

#endregion

namespace Appalachia.Prefabs.Rendering.Overrides
{
    [Serializable]
    public sealed class
        FrustumSettings_OVERRIDE : Overridable<FrustumSettings, FrustumSettings_OVERRIDE>
    {
        public FrustumSettings_OVERRIDE() : base(false, default)
        {
        }

        public FrustumSettings_OVERRIDE(
            bool isOverridingAllowed,
            bool overrideEnabled,
            FrustumSettings value) : base(overrideEnabled, value)
        {
        }

        public FrustumSettings_OVERRIDE(
            Overridable<FrustumSettings, FrustumSettings_OVERRIDE> value) : base(value)
        {
        }
    }
}
