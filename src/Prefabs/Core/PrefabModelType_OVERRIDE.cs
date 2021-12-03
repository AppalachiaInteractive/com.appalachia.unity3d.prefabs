#region

using System;
using Appalachia.Core.Overrides;

#endregion

namespace Appalachia.Rendering.Prefabs.Core
{
    [Serializable]
    public class OverridablePrefabModelType : Overridable<PrefabModelType, OverridablePrefabModelType>
    {
        public OverridablePrefabModelType(bool overrideEnabled, PrefabModelType value) : base(
            overrideEnabled,
            value
        )
        {
        }

        public OverridablePrefabModelType(
            Overridable<PrefabModelType, OverridablePrefabModelType> value) : base(value)
        {
        }

        public OverridablePrefabModelType() : base(false, default)
        {
        }
    }
}
