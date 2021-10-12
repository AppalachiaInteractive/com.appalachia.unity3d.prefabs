#region

using Appalachia.Rendering.Prefabs.Core.States;
using Unity.Burst;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Jobs
{
    [BurstCompile]
    public struct InitializeElementArraysJob : IJobParallelFor
    {
        [WriteOnly] public NativeArray<float4x4> matrices_original;
        [WriteOnly] public NativeArray<float4x4> matrices_current;
        [WriteOnly] public NativeArray<Matrix4x4> matrices_noGameObject_OWNED;
        [WriteOnly] public NativeArray<Matrix4x4> matrices_noGameObject_SHARED;
        [WriteOnly] public NativeArray<float3> positions;
        [WriteOnly] public NativeArray<quaternion> rotations;
        [WriteOnly] public NativeArray<float3> scales;
        [WriteOnly] public NativeArray<bool> inFrustums;
        [WriteOnly] public NativeArray<float3> previousPositions;
        [WriteOnly] public NativeArray<float> primaryDistances;
        [WriteOnly] public NativeArray<float> secondaryDistances;
        [WriteOnly] public NativeArray<InstanceState> currentStates;
        [WriteOnly] public NativeArray<InstanceState> pendingStates;
        [WriteOnly] public NativeArray<bool> instancesExcludedFromFrame;
        [WriteOnly] public NativeArray<InstanceStateCode> instancesStateCodes;

        public void Execute(int index)
        {
            matrices_original[index] = float4x4.zero;
            matrices_current[index] = float4x4.zero;
            matrices_noGameObject_OWNED[index] = float4x4.zero;
            matrices_noGameObject_SHARED[index] = float4x4.zero;
            positions[index] = float3.zero;
            rotations[index] = quaternion.identity;
            scales[index] = float3.zero;
            previousPositions[index] = float3.zero;
            primaryDistances[index] = 0f;
            secondaryDistances[index] = 0f;
            currentStates[index] = InstanceState.NotSet;
            pendingStates[index] = InstanceState.NotSet;
            inFrustums[index] = true;
            instancesExcludedFromFrame[index] = false;
            instancesStateCodes[index] = InstanceStateCode.NotSet;
        }
    }
}
