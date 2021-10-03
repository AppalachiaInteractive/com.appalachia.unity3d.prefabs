using Appalachia.Core.Rendering.States;
using Unity.Burst;
using Unity.Collections;
using Unity.Jobs;

namespace Appalachia.Core.Rendering.Jobs
{
    [BurstCompile]
    public struct CountStatesJob : IJob
    {
        [ReadOnly] public NativeArray<InstanceState> currentStates;
        [WriteOnly] public NativeArray<InstanceStateCounts> counts;

        public void Execute()
        {
            var count = InstanceStateCounts.Zero;

            for (var i = 0; i < currentStates.Length; i++)
            {
                count.AddFrom(currentStates[i]);
            }

            counts[0] = count;
        }
    }
}