#region

using System;
using Appalachia.Core.AssetMetadata.Options.ModelType.Rendering;

#endregion

namespace Appalachia.Core.Overridding.Implementations
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
