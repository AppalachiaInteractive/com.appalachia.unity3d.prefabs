#region

using System;

#endregion

namespace Appalachia.Rendering.Prefabs.Core.States
{
    [Serializable]
    public enum InstanceInteractionState : byte
    {
        NotSet = 0,
        Enabled = 1,
        Disabled = 2
    }
}
