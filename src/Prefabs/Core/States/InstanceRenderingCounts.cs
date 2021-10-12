#region

using System;
using System.Runtime.CompilerServices;
using Unity.Burst;

#endregion

namespace Appalachia.Rendering.Prefabs.Core.States
{
    [BurstCompile]
    [Serializable]
    public struct InstanceRenderingCounts
    {
        public ushort notSetCount;
        public ushort disabledCount;
        public ushort meshRenderingCount;
        public ushort gpuInstancingCount;

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public InstanceRenderingCounts(InstanceRenderingState state)
        {
            switch (state)
            {
                case InstanceRenderingState.NotSet:
                    notSetCount = 1;
                    disabledCount = 0;
                    meshRenderingCount = 0;
                    gpuInstancingCount = 0;
                    break;
                case InstanceRenderingState.Disabled:
                    notSetCount = 0;
                    disabledCount = 1;
                    meshRenderingCount = 0;
                    gpuInstancingCount = 0;
                    break;
                case InstanceRenderingState.MeshRenderers:
                    notSetCount = 0;
                    disabledCount = 0;
                    meshRenderingCount = 1;
                    gpuInstancingCount = 0;
                    break;
                case InstanceRenderingState.GPUInstancing:
                    notSetCount = 0;
                    disabledCount = 0;
                    meshRenderingCount = 0;
                    gpuInstancingCount = 1;
                    break;
                default:
                    throw new ArgumentOutOfRangeException(nameof(state), state, null);
            }
        }

        public ushort total =>
            (ushort) (notSetCount + disabledCount + meshRenderingCount + gpuInstancingCount);

        [BurstCompile]
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public void AddFrom(InstanceRenderingCounts b)
        {
            notSetCount += b.notSetCount;
            disabledCount += b.disabledCount;
            meshRenderingCount += b.meshRenderingCount;
            gpuInstancingCount += b.gpuInstancingCount;
        }

        [BurstDiscard]
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public override string ToString()
        {
            return $"Render {meshRenderingCount}m + {gpuInstancingCount}i / {total}";
        }
    }
}
