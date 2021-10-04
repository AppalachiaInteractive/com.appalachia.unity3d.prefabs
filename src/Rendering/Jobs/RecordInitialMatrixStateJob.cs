using Unity.Burst;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using UnityEngine;

namespace Appalachia.Prefabs.Rendering.Jobs
{
    [BurstCompile]
    public struct RecordInitialMatrixStateJob : IJobParallelFor
    {
        public NativeArray<float4x4> matrices_original;
        public NativeArray<Matrix4x4> matrices_noGameObject_OWNED;
        public NativeArray<Matrix4x4> matrices_noGameObject_SHARED;
        [ReadOnly] public NativeArray<float4x4> matrices_current;

        public void Execute(int index)
        {
            matrices_original[index] = matrices_current[index];
            matrices_noGameObject_OWNED[index] = matrices_current[index];
            matrices_noGameObject_SHARED[index] = matrices_current[index];
        }
    }
}