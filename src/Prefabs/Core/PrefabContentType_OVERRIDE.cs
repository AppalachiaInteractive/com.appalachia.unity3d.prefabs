#region

using System;
using Appalachia.Core.Objects.Models;

#endregion

namespace Appalachia.Rendering.Prefabs.Core
{
    [Serializable]
    public class OverridablePrefabContentType : Overridable<PrefabContentType, OverridablePrefabContentType>
    {
        public OverridablePrefabContentType(bool overriding, PrefabContentType value) : base(
            overriding,
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
