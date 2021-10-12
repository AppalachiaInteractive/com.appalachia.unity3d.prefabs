using Appalachia.Jobs.Burstable;
using Appalachia.Rendering.Prefabs.Core.States;
using Unity.Burst;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;

namespace Appalachia.Rendering.Prefabs.Rendering.Jobs
{
    [BurstCompile]
    public struct CalculateFrustumInclusionJob : IJobParallelFor
    {
        [ReadOnly] public NativeArray<float3> positions;
        [ReadOnly] public NativeArray<float3> scales;
        [ReadOnly] public NativeArray<bool> instancesExcludedFromFrame;

        [ReadOnly] public FrustumPlanesBurst frustum;
        [ReadOnly] public BoundsBurst objectBounds;

        [WriteOnly] public NativeArray<bool> inFrustums;
        [WriteOnly] public NativeArray<InstanceStateCode> instancesStateCodes;

        public void Execute(int index)
        {
            if (instancesExcludedFromFrame[index])
            {
                return;
            }

            var position = positions[index];
            var scale = scales[index];

            var tempBounds = objectBounds;

            tempBounds.Shift(position, scale);

            var insideFrustum = frustum.Inside(tempBounds);

            inFrustums[index] = insideFrustum;
            instancesStateCodes[index] = insideFrustum
                ? InstanceStateCode.Normal
                : InstanceStateCode.OutsideOfFrustum;
        }
    }
}
