#region

using System;
using System.Runtime.CompilerServices;
using Unity.Burst;

#endregion

namespace Appalachia.Rendering.Prefabs.Core.States
{
    [BurstCompile]
    [Serializable]
    public struct InstancePhysicsCounts
    {
        public ushort notSetCount;
        public ushort disabledCount;
        public ushort enabledCount;

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public InstancePhysicsCounts(InstancePhysicsState state)
        {
            switch (state)
            {
                case InstancePhysicsState.NotSet:
                    notSetCount = 1;
                    disabledCount = 0;
                    enabledCount = 0;
                    break;
                case InstancePhysicsState.Disabled:
                    notSetCount = 1;
                    disabledCount = 1;
                    enabledCount = 0;
                    break;
                case InstancePhysicsState.Enabled:
                    notSetCount = 1;
                    disabledCount = 0;
                    enabledCount = 1;
                    break;
                default:
                    throw new ArgumentOutOfRangeException(nameof(state), state, null);
            }
        }

        public ushort total => (ushort) (notSetCount + disabledCount + enabledCount);

        [BurstCompile]
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public void AddFrom(InstancePhysicsCounts b)
        {
            notSetCount += b.notSetCount;
            disabledCount += b.disabledCount;
            enabledCount += b.enabledCount;
        }

        [BurstDiscard]
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public override string ToString()
        {
            return $"Phys {enabledCount} / {total}";
        }
    }
}
