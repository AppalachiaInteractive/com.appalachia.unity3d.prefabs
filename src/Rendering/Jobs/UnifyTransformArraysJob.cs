using Unity.Burst;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;

namespace Appalachia.Prefabs.Rendering.Jobs
{
    [BurstCompile]
    public struct UnifyTransformArraysJob : IJobParallelFor
    {
        [ReadOnly] public NativeArray<float4x4> matrices_current;

        public NativeArray<float3> positions;
        public NativeArray<float3> previousPositions;
        public NativeArray<quaternion> rotations;
        public NativeArray<float3> scales;

        public void Execute(int index)
        {
            var matrix = matrices_current[index];

            var c0 = matrix.c0;
            var c1 = matrix.c1;
            var c2 = matrix.c2;
            var c3 = matrix.c3;

            var newPosition = c3.xyz;
            var currentPosition = positions[index];

            positions[index] = newPosition;
            previousPositions[index] = currentPosition;

            rotations[index] = quaternion.LookRotation(c2.xyz, c1.xyz);
            scales[index] = new float3(math.length(c0), math.length(c1), math.length(c2));

            //var equality = currentPosition == newPosition;

            //var samePosition = first || (equality.x && equality.y && equality.z);

            //moved[index] = !samePosition;
        }
    }
}