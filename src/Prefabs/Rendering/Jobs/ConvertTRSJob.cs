using Unity.Burst;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;

namespace Appalachia.Rendering.Prefabs.Rendering.Jobs
{
    [BurstCompile]
    public struct ConvertTRSJob : IJobParallelFor
    {
        [ReadOnly] public NativeArray<float3> tempPositions;
        [ReadOnly] public NativeArray<quaternion> tempRotations;
        [ReadOnly] public NativeArray<float3> tempScales;
        public NativeArray<float3> positions;
        public NativeArray<quaternion> rotations;
        public NativeArray<float3> scales;
        public NativeArray<float4x4> matrices_current;
        [ReadOnly] public int limit;

        public void Execute(int index)
        {
            if (index < limit)
            {
                return;
            }

            var position = tempPositions[index];
            var rotation = tempRotations[index];
            var scale = tempScales[index];

            positions[index] = position;
            rotations[index] = rotation;
            scales[index] = scale;

            matrices_current[index] = float4x4.TRS(position, rotation, scale);
        }
    }
}
