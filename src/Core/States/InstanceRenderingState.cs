#region

using System;

#endregion

namespace Appalachia.Prefabs.Core.States
{
    [Serializable]
    public enum InstanceRenderingState : byte
    {
        NotSet = 0,
        MeshRenderers = 1,
        GPUInstancing = 2,
        Disabled = 3
    }
}
