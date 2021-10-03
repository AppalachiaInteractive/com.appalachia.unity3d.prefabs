#region

using System;

#endregion

namespace Appalachia.Core.Rendering.States
{
    [Serializable]
    public enum InstanceInteractionState : byte
    {
        NotSet = 0,
        Enabled = 1,
        Disabled = 2
    }
}
