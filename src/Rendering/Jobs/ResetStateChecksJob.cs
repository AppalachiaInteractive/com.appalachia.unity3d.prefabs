using Appalachia.Prefabs.Core.States;
using Unity.Burst;
using Unity.Collections;
using Unity.Jobs;

namespace Appalachia.Prefabs.Rendering.Jobs
{
    [BurstCompile]
    public struct ResetStateChecksJob : IJobParallelFor
    {
        [WriteOnly] public NativeArray<bool> instancesExcludedFromFrame;
        [WriteOnly] public NativeArray<InstanceStateCode> instancesStateCodes;
        [WriteOnly] public NativeArray<bool> inFrustums;

        public void Execute(int index)
        {
            //forcedStates[index] = forcedState;
            //hasForcedStatePending[index] = forcedState != InstanceState.Disabled;
            instancesExcludedFromFrame[index] = false;
            instancesStateCodes[index] = InstanceStateCode.NotSet;
            inFrustums[index] = false;
        }
    }
}