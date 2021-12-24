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
    public struct InstanceStateCounts
    {
        public static readonly InstanceStateCounts Zero = new();

        public int total;

        public InstanceInteractionCounts interaction;
        public InstanceRenderingCounts rendering;
        public InstancePhysicsCounts physics;

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public InstanceStateCounts(InstanceState states)
        {
            total = 1;

            interaction = new InstanceInteractionCounts(states.interaction);
            rendering = new InstanceRenderingCounts(states.rendering);
            physics = new InstancePhysicsCounts(states.physics);
        }

        [BurstCompile]
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public void AddFrom(InstanceStateCounts b)
        {
            total += b.total;
            interaction.AddFrom(b.interaction);
            rendering.AddFrom(b.rendering);
            physics.AddFrom(b.physics);
        }

        [BurstCompile]
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public void AddFrom(InstanceState bs)
        {
            var b = new InstanceStateCounts(bs);

            total += b.total;
            interaction.AddFrom(b.interaction);
            rendering.AddFrom(b.rendering);
            physics.AddFrom(b.physics);
        }

        [BurstDiscard]
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        [DebuggerStepThrough] public override string ToString()
        {
            return ZString.Format("Total: {0} | {1} | {2} | {3}", total, rendering, physics, interaction);
        }
    }
}
