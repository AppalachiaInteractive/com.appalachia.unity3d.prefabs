#region

using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using Appalachia.Core.Attributes.Editing;

#endregion

namespace Appalachia.Rendering.Prefabs.Core.States
{
    [Serializable]
    public struct InstanceState : IEquatable<InstanceState>
    {
        public static readonly InstanceState NotSet = new();

        public static readonly InstanceState Disabled = new()
        {
            interaction = InstanceInteractionState.Disabled,
            physics = InstancePhysicsState.Disabled,
            rendering = InstanceRenderingState.Disabled
        };

        [SmartLabel] public InstanceInteractionState interaction;

        [SmartLabel(AlignWith = nameof(interaction))]
        public InstancePhysicsState physics;

        [SmartLabel(AlignWith = nameof(interaction))]
        public InstanceRenderingState rendering;

        [MethodImpl(MethodImplOptions.AggressiveInlining)]
        public InstanceStateCounts Count()
        {
            return new(this);
        }

        [DebuggerStepThrough] public override string ToString()
        {
            return $"Rendering: {rendering} | Physics: {physics} | Interaction: {interaction}";
            ;
        }

#region IEquatable

        [DebuggerStepThrough] public bool Equals(InstanceState other)
        {
            return (interaction == other.interaction) &&
                   (physics == other.physics) &&
                   (rendering == other.rendering);
        }

        [DebuggerStepThrough] public override bool Equals(object obj)
        {
            return obj is InstanceState other && Equals(other);
        }

        [DebuggerStepThrough] public override int GetHashCode()
        {
            unchecked
            {
                var hashCode = (int) interaction;
                hashCode = (hashCode * 397) ^ (int) physics;
                hashCode = (hashCode * 397) ^ (int) rendering;
                return hashCode;
            }
        }

        [DebuggerStepThrough] public static bool operator ==(InstanceState left, InstanceState right)
        {
            return left.Equals(right);
        }

        [DebuggerStepThrough] public static bool operator !=(InstanceState left, InstanceState right)
        {
            return !left.Equals(right);
        }

#endregion
    }
}
