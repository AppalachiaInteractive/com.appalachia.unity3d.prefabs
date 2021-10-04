using Appalachia.Prefabs.Core.States;
using Appalachia.Prefabs.Rendering.ModelType.Instancing;
using Unity.Burst;
using Unity.Collections;
using Unity.Jobs;

namespace Appalachia.Prefabs.Rendering.Jobs
{
    [BurstCompile]
    public struct UpdatePendingStateJob : IJobParallelFor
    {
        [ReadOnly] public NativeArray<InstanceState> currentStates;
        [ReadOnly] public NativeArray<float> primaryDistances;
        [ReadOnly] public NativeArray<float> secondaryDistances;
        [ReadOnly] public NativeArray<bool> inFrustums;
        [ReadOnly] public NativeArray<AssetRangeSettings> assetRangeSettings;
        [ReadOnly] public bool stateChanging;

        public NativeArray<InstanceState> pendingStates;
        public NativeArray<bool> instancesExcludedFromFrame;

        public void Execute(int index)
        {
            if (!stateChanging && instancesExcludedFromFrame[index])
            {
                return;
            }

            var inFrustum = inFrustums[index];

            var primaryPendingState = InstanceState.Disabled;
            var primaryDistance = primaryDistances[index];
            var primaryFound = false;

            var secondaryPendingState = InstanceState.Disabled;
            var secondaryDistance = secondaryDistances[index];
            var secondaryFound = false;

            for (var i = 0; i < assetRangeSettings.Length; i++)
            {
                var range = assetRangeSettings[i];
                var limit = inFrustum
                    ? range.rangeLimit
                    : range.frustumOverridesRange
                        ? range.outOfFrustumRangeLimit
                        : range.rangeLimit;

                if (!primaryFound && (primaryDistance < limit))
                {
                    primaryPendingState = GetState(range);
                    primaryFound = true;
                }

                if (!secondaryFound && (secondaryDistance < limit))
                {
                    secondaryPendingState = GetState(range);
                    secondaryFound = true;
                }

                if (primaryFound && secondaryFound)
                {
                    break;
                }
            }

            if (!primaryFound)
            {
                primaryPendingState = InstanceState.Disabled;
            }
            else if (secondaryFound)
            {
                if ((primaryPendingState.interaction != InstanceInteractionState.Enabled) &&
                    (secondaryPendingState.interaction == InstanceInteractionState.Enabled))
                {
                    primaryPendingState.interaction = InstanceInteractionState.Enabled;
                }

                if ((primaryPendingState.physics != InstancePhysicsState.Enabled) && (secondaryPendingState.physics == InstancePhysicsState.Enabled))
                {
                    primaryPendingState.physics = InstancePhysicsState.Enabled;
                }
            }

            pendingStates[index] = primaryPendingState;
        }

        private InstanceState GetState(AssetRangeSettings options)
        {
            var state = InstanceState.Disabled;

            if (!options.enabled)
            {
                state.rendering = InstanceRenderingState.Disabled;
                state.interaction = InstanceInteractionState.Disabled;
                state.physics = InstancePhysicsState.Disabled;

                return state;
            }

            state.rendering = options.rendering;
            state.interaction = options.interactions;
            state.physics = options.physics;

            return state;
        }
    }
}