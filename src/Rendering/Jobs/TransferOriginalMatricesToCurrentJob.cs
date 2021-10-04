using Unity.Burst;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using UnityEngine;

namespace Appalachia.Prefabs.Rendering.Jobs
{
    [BurstCompile]
    public struct TransferOriginalMatricesToCurrentJob : IJobParallelFor
    {
        [ReadOnly] public NativeArray<float4x4> matrices_original;
        [WriteOnly] public NativeArray<float4x4> matrices_current;
        [WriteOnly] public NativeArray<Matrix4x4> matrices_noGameObject_OWNED;

        public void Execute(int index)
        {
            var matrix = matrices_original[index];

            matrices_current[index] = matrix;
            matrices_noGameObject_OWNED[index] = matrix;
        }
    }
}
