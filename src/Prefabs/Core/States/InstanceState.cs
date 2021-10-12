#region

using System;
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

        public override string ToString()
        {
            return $"Rendering: {rendering} | Physics: {physics} | Interaction: {interaction}";
            ;
        }

#region IEquatable

        public bool Equals(InstanceState other)
        {
            return (interaction == other.interaction) &&
                   (physics == other.physics) &&
                   (rendering == other.rendering);
        }

        public override bool Equals(object obj)
        {
            return obj is InstanceState other && Equals(other);
        }

        public override int GetHashCode()
        {
            unchecked
            {
                var hashCode = (int) interaction;
                hashCode = (hashCode * 397) ^ (int) physics;
                hashCode = (hashCode * 397) ^ (int) rendering;
                return hashCode;
            }
        }

        public static bool operator ==(InstanceState left, InstanceState right)
        {
            return left.Equals(right);
        }

        public static bool operator !=(InstanceState left, InstanceState right)
        {
            return !left.Equals(right);
        }

#endregion
    }
}
