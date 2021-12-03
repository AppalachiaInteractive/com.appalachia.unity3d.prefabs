#region

using System;
using Appalachia.Core.Overrides;
using Appalachia.Rendering.Prefabs.Rendering.ModelType.Rendering;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Overrides
{
    [Serializable]
    public sealed class
        OverridableLODFadeSettings : Overridable<LODFadeSettings, OverridableLODFadeSettings>
    {
        public OverridableLODFadeSettings() : base(false, default)
        {
        }

        public OverridableLODFadeSettings(
            bool isOverridingAllowed,
            bool overrideEnabled,
            LODFadeSettings value) : base(overrideEnabled, value)
        {
        }

        public OverridableLODFadeSettings(
            Overridable<LODFadeSettings, OverridableLODFadeSettings> value) : base(value)
        {
        }
    }
}
