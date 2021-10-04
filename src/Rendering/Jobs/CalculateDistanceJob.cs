using Appalachia.Prefabs.Core.States;
using Unity.Burst;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;

namespace Appalachia.Prefabs.Rendering.Jobs
{
    [BurstCompile]
    public struct CalculateDistanceJob : IJobParallelFor
    {
        [ReadOnly] public NativeArray<InstanceState> currentStates;
        [ReadOnly] public NativeArray<float3> positions;
        [ReadOnly] public float maximumDistance;
        [ReadOnly] public NativeArray<float3> referencePoints;

        public NativeArray<float> primaryDistances;
        public NativeArray<float> secondaryDistances;
        public NativeArray<bool> instancesExcludedFromFrame;

        [WriteOnly] public NativeArray<InstanceStateCode> instancesStateCodes;

        public void Execute(int index)
        {
            var currentState = currentStates[index];
            var secondaryDistance = float.MaxValue;

            var position = positions[index];

            var references = referencePoints.Length;

            var primaryDistance = math.distance(position, referencePoints[0]);

            if (references == 1)
            {
                secondaryDistance = primaryDistance;
            }
            else
            {
                for (var i = 1; i < references; i++)
                {
                    secondaryDistance = math.min(
                        math.distance(position, referencePoints[i]),
                        secondaryDistance
                    );
                }
            }

            primaryDistances[index] = primaryDistance;
            secondaryDistances[index] = secondaryDistance;

            var canExclude = (currentState.interaction == InstanceInteractionState.Disabled) &&
                             (currentState.physics == InstancePhysicsState.Disabled) &&
                             ((currentState.rendering == InstanceRenderingState.GPUInstancing) ||
                              (currentState.rendering == InstanceRenderingState.Disabled));

            var excludeFromFrame = canExclude &&
                                   (math.min(primaryDistance, secondaryDistance) > maximumDistance);

            instancesExcludedFromFrame[index] = excludeFromFrame;
            instancesStateCodes[index] = excludeFromFrame
                ? InstanceStateCode.OutsideOfMaximumChangeRadius
                : InstanceStateCode.Normal;
        }
    }
}
