#region

using System;
using Appalachia.Core.Collections.Native;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Runtime
{
    public class RuntimePrefabRenderingSetTemporary : IDisposable
    {
        public NativeList<float4x4> matrices;
        public NativeList<float3> positions;
        public NativeList<quaternion> rotations;
        public NativeList<float3> scales;

        public void Dispose()
        {
            Dispose(default);
        }

        public void MakeReady(int capacity, Allocator allocator)
        {
            if (matrices.ShouldAllocate())
            {
                matrices.SafeDispose();
                matrices = new NativeList<float4x4>(capacity, allocator);
            }
            else
            {
                matrices.Clear();
            }

            if (positions.ShouldAllocate())
            {
                positions.SafeDispose();
                positions = new NativeList<float3>(capacity, allocator);
            }
            else
            {
                positions.Clear();
            }

            if (rotations.ShouldAllocate())
            {
                rotations.SafeDispose();
                rotations = new NativeList<quaternion>(capacity, allocator);
            }
            else
            {
                rotations.Clear();
            }

            if (scales.ShouldAllocate())
            {
                scales.SafeDispose();
                scales = new NativeList<float3>(capacity, allocator);
            }
            else
            {
                scales.Clear();
            }
        }

        public void Dispose(JobHandle handle)
        {
            matrices.SafeDispose(handle);
            positions.SafeDispose(handle);
            rotations.SafeDispose(handle);
            scales.SafeDispose(handle);
        }
    }
}
