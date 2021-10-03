#region

using System;
using System.Runtime.CompilerServices;
using Unity.Burst;

#endregion

namespace Appalachia.Core.Rendering.States
{
    [BurstCompile, Serializable]
    public struct InstanceStateCounts
    {
        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public InstanceStateCounts(InstanceState states)
        {
            total = 1;

            interaction = new InstanceInteractionCounts(states.interaction);
            rendering = new InstanceRenderingCounts(states.rendering);
            physics = new InstancePhysicsCounts(states.physics);
        }

        public int total;

        public InstanceInteractionCounts interaction;
        public InstanceRenderingCounts rendering;
        public InstancePhysicsCounts physics;

        [BurstCompile, MethodImpl(MethodImplOptions.AggressiveInlining)]
        public void AddFrom(InstanceStateCounts b)
        {
            total += b.total;
            interaction.AddFrom(b.interaction);
            rendering.AddFrom(b.rendering);
            physics.AddFrom(b.physics);
        }

        [BurstCompile, MethodImpl(MethodImplOptions.AggressiveInlining)]
        public void AddFrom(InstanceState bs)
        {
            var b = new InstanceStateCounts(bs);
           
            total += b.total;
            interaction.AddFrom(b.interaction);
            rendering.AddFrom(b.rendering);
            physics.AddFrom(b.physics);
        }
        
        [BurstDiscard, MethodImpl(MethodImplOptions.AggressiveInlining)]
        public override string ToString()
        {
            return $"Total: {total} | {rendering} | {physics} | {interaction}";
        }

        public static readonly InstanceStateCounts Zero = new InstanceStateCounts();
    }
}
