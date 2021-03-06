#region

using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using Appalachia.Utility.Strings;
using Unity.Burst;

#endregion

namespace Appalachia.Rendering.Prefabs.Core.States
{
    [BurstCompile]
    [Serializable]
    public struct InstanceInteractionCounts
    {
        public ushort notSetCount;
        public ushort disabledCount;
        public ushort enabledCount;

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public InstanceInteractionCounts(InstanceInteractionState state)
        {
            notSetCount = GetNotSetCountFromState(state);
            disabledCount = GetDisabledCountFromState(state);
            enabledCount = GetEnabledCountFromState(state);
        }

        public ushort total => (ushort) (notSetCount + disabledCount + enabledCount);

        [BurstCompile]
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public void AddFrom(InstanceInteractionCounts b)
        {
            notSetCount += b.notSetCount;
            disabledCount += b.disabledCount;
            enabledCount += b.enabledCount;
        }

        [BurstDiscard]
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        [DebuggerStepThrough] public override string ToString()
        {
            return ZString.Format("Interact {0} / {1}", enabledCount, total);
        }

        [BurstCompile]
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static ushort GetNotSetCountFromState(InstanceInteractionState state)
        {
            return state switch
            {
                InstanceInteractionState.NotSet => 1,
                InstanceInteractionState.Disabled => 0,
                InstanceInteractionState.Enabled => 0,
                _ => throw new ArgumentOutOfRangeException(nameof(state), state, null)
            };
        }

        [BurstCompile]
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static ushort GetDisabledCountFromState(InstanceInteractionState state)
        {
            return state switch
            {
                InstanceInteractionState.NotSet => 0,
                InstanceInteractionState.Disabled => 1,
                InstanceInteractionState.Enabled => 0,
                _ => throw new ArgumentOutOfRangeException(nameof(state), state, null)
            };
        }

        [BurstCompile]
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public static ushort GetEnabledCountFromState(InstanceInteractionState state)
        {
            return state switch
            {
                InstanceInteractionState.NotSet => 0,
                InstanceInteractionState.Disabled => 0,
                InstanceInteractionState.Enabled => 1,
                _ => throw new ArgumentOutOfRangeException(nameof(state), state, null)
            };
        }
    }
}
