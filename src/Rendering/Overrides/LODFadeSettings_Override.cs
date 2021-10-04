#region

using System;
using Appalachia.Core.Overrides;
using Appalachia.Prefabs.Rendering.ModelType.Rendering;

#endregion

namespace Appalachia.Prefabs.Rendering.Overrides
{
    [Serializable]
    public sealed class LODFadeSettings_OVERRIDE : Overridable<LODFadeSettings, LODFadeSettings_OVERRIDE>
    { public LODFadeSettings_OVERRIDE() : base(false, default){}
        public LODFadeSettings_OVERRIDE(bool isOverridingAllowed, bool overrideEnabled, LODFadeSettings value) : base(
            overrideEnabled,
            value
        )
        {
        }

        public LODFadeSettings_OVERRIDE(Overridable<LODFadeSettings, LODFadeSettings_OVERRIDE> value) : base(value)
        {
        }
    }
}
