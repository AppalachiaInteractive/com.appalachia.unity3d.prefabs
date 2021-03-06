#region

using System;
using Appalachia.Core.Objects.Models;

#endregion

namespace Appalachia.Rendering.Prefabs.Core
{
    [Serializable]
    public class OverridablePrefabModelType : Overridable<PrefabModelType, OverridablePrefabModelType>
    {
        public OverridablePrefabModelType(bool overriding, PrefabModelType value) : base(overriding, value)
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
