using Unity.Burst;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;

namespace Appalachia.Core.Rendering.Jobs
{
    [BurstCompile]
    public struct ConvertMatricesJob : IJobParallelFor
    {
        [ReadOnly] public NativeArray<float4x4> tempMatrices;
        public NativeArray<float4x4> matrices_current;
        public NativeArray<float3> positions;
        public NativeArray<quaternion> rotations;
        public NativeArray<float3> scales;
        [ReadOnly] public int limit;

        public void Execute(int index)
        {
            if (index >= limit)
            {
                return;
            }

            var tempMatrix = tempMatrices[index];
            matrices_current[index] = tempMatrix;

            var c0 = tempMatrix.c0;
            var c1 = tempMatrix.c1;
            var c2 = tempMatrix.c2;
            var c3 = tempMatrix.c3;

            positions[index] = c3.xyz;
            rotations[index] = quaternion.LookRotation(c2.xyz, c1.xyz);
            scales[index] = new float3(math.length(c0), math.length(c1), math.length(c2));
        }
    }
}