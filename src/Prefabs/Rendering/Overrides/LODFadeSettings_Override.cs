#region

using System;
using Appalachia.Core.Objects.Models;
using Appalachia.Rendering.Prefabs.Rendering.ModelType.Rendering;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Overrides
{
    [Serializable]
    public sealed class OverridableLODFadeSettings : Overridable<LODFadeSettings, OverridableLODFadeSettings>
    {
        public OverridableLODFadeSettings() : base(false, default)
        {
        }

        public OverridableLODFadeSettings(
            bool isOverridingAllowed,
            bool overriding,
            LODFadeSettings value) : base(overriding, value)
        {
        }

        public OverridableLODFadeSettings(
            Overridable<LODFadeSettings, OverridableLODFadeSettings> value) : base(value)
        {
        }
    }
}
