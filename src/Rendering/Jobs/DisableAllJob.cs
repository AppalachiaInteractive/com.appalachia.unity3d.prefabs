using Appalachia.Core.Rendering.States;
using Unity.Burst;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using UnityEngine;

namespace Appalachia.Core.Rendering.Jobs
{
    [BurstCompile]
    public struct DisableAllJob : IJobParallelFor
    {
        public NativeArray<InstanceState> pendingStates;
        [WriteOnly] public NativeArray<Matrix4x4> matrices_noGameObject_OWNED;
        [WriteOnly] public NativeArray<bool> instancesExcludedFromFrame;
        [WriteOnly] public NativeArray<InstanceStateCode> instancesStateCodes;

        public void Execute(int index)
        {
            pendingStates[index] = InstanceState.Disabled;
            matrices_noGameObject_OWNED[index] = float4x4.zero; // need to figure out how to separate usage of this array
            instancesExcludedFromFrame[index] = false;
            instancesStateCodes[index] = InstanceStateCode.ForceDisabled;
        }
    }
}