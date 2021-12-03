#region

using System;
using Appalachia.Core.Overrides;

#endregion

namespace Appalachia.Rendering.Prefabs.Core
{
    [Serializable]
    public class
        OverridablePrefabContentType : Overridable<PrefabContentType, OverridablePrefabContentType>
    {
        public OverridablePrefabContentType(bool overrideEnabled, PrefabContentType value) : base(
            overrideEnabled,
            value
        )
        {
        }

        public OverridablePrefabContentType(
            Overridable<PrefabContentType, OverridablePrefabContentType> value) : base(value)
        {
        }

        public OverridablePrefabContentType() : base(false, default)
        {
        }
    }
}
