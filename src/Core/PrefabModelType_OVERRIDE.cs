#region

using System;
using Appalachia.Core.Overrides;

#endregion

namespace Appalachia.Prefabs.Core
{
    [Serializable] 
public class PrefabModelType_OVERRIDE : Overridable<PrefabModelType, PrefabModelType_OVERRIDE>
    {
        public PrefabModelType_OVERRIDE(bool overrideEnabled, PrefabModelType value) : base(overrideEnabled, value)
        {
        }

        public PrefabModelType_OVERRIDE(Overridable<PrefabModelType, PrefabModelType_OVERRIDE> value) : base(value)
        {
        }

        public PrefabModelType_OVERRIDE() : base(false, default)
        {
        }
    }
}
