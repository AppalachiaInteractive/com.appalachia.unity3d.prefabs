#region

using System;
using Appalachia.Core.Attributes.Editing;
using Appalachia.Rendering.Prefabs.Core.States;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.ModelType.Instancing
{
    [Serializable]
    public struct AssetRangeSettings : IEquatable<AssetRangeSettings>
    {
        [SerializeField]
        [ToggleLeft]
        [HorizontalGroup("A", .1f)]
        [SmartLabel]
        public bool enabled;

        [SerializeField]
        [HideInInspector]
        public bool showRangeLimit;

        [SerializeField]
        [HorizontalGroup("A", .9f)]
        [PropertyRange(1f, 100f)]
        [ShowIf(nameof(showRangeLimit))]
        [SmartLabel]
        public float rangeLimit;

        [SerializeField]
        [ToggleLeft]
        [HorizontalGroup("C", .2f)]
        [SmartLabel]
        public bool frustumOverridesRange;

        [SerializeField]
        [HorizontalGroup("C", .8f)]
        [PropertyRange(1f, 100f)]
        [ShowIf(nameof(showRangeLimit))]
        [EnableIf(nameof(frustumOverridesRange))]
        [PropertyTooltip("Out of frustrum range limit")]
        [SmartLabel(Text = "O.O.F. Limit")]
        public float outOfFrustumRangeLimit;

        [SerializeField]
        [HorizontalGroup("B", .33f)]
        [SmartLabel]
        public InstanceRenderingState rendering;

        [HorizontalGroup("B", .33f)]
        [SerializeField]
        [SmartLabel]
        public InstancePhysicsState physics;

        [HorizontalGroup("B", .33f)]
        [SerializeField]
        [SmartLabel]
        public InstanceInteractionState interactions;

        public static AssetRangeSettings MeshRendered(
            float distanceLimit,
            bool physics,
            bool interactions)
        {
            return new()
            {
                enabled = true,
                rangeLimit = distanceLimit,
                rendering = InstanceRenderingState.MeshRenderers,
                physics =
                    physics ? InstancePhysicsState.Enabled : InstancePhysicsState.Disabled,
                interactions = interactions
                    ? InstanceInteractionState.Enabled
                    : InstanceInteractionState.Disabled
            };
        }

        public static AssetRangeSettings GPUInstanced(bool physics, bool interactions)
        {
            return new()
            {
                enabled = true,
                rangeLimit = float.MaxValue,
                rendering = InstanceRenderingState.GPUInstancing,
                physics =
                    physics ? InstancePhysicsState.Enabled : InstancePhysicsState.Disabled,
                interactions = interactions
                    ? InstanceInteractionState.Enabled
                    : InstanceInteractionState.Disabled
            };
        }

        public static AssetRangeSettings GPUInstanced(
            float distanceLimit,
            bool physics,
            bool interactions)
        {
            return new()
            {
                enabled = true,
                rangeLimit = distanceLimit,
                rendering = InstanceRenderingState.GPUInstancing,
                physics =
                    physics ? InstancePhysicsState.Enabled : InstancePhysicsState.Disabled,
                interactions = interactions
                    ? InstanceInteractionState.Enabled
                    : InstanceInteractionState.Disabled
            };
        }

        public void CopyTo(ref AssetRangeSettings other)
        {
            other.enabled = enabled;
            other.showRangeLimit = showRangeLimit;
            other.rangeLimit = rangeLimit;
            other.frustumOverridesRange = frustumOverridesRange;
            other.outOfFrustumRangeLimit = outOfFrustumRangeLimit;
            other.rendering = rendering;
            other.physics = physics;
            other.interactions = interactions;
        }

#region IEquatable

        public bool Equals(AssetRangeSettings other)
        {
            return (enabled == other.enabled) &&
                   (showRangeLimit == other.showRangeLimit) &&
                   rangeLimit.Equals(other.rangeLimit) &&
                   (rendering == other.rendering) &&
                   (physics == other.physics) &&
                   (interactions == other.interactions);
        }

        public override bool Equals(object obj)
        {
            return obj is AssetRangeSettings other && Equals(other);
        }

        public override int GetHashCode()
        {
            unchecked
            {
                var hashCode = enabled.GetHashCode();
                hashCode = (hashCode * 397) ^ showRangeLimit.GetHashCode();
                hashCode = (hashCode * 397) ^ rangeLimit.GetHashCode();
                hashCode = (hashCode * 397) ^ (int) rendering;
                hashCode = (hashCode * 397) ^ (int) physics;
                hashCode = (hashCode * 397) ^ (int) interactions;
                return hashCode;
            }
        }

        public static bool operator ==(AssetRangeSettings left, AssetRangeSettings right)
        {
            return left.Equals(right);
        }

        public static bool operator !=(AssetRangeSettings left, AssetRangeSettings right)
        {
            return !left.Equals(right);
        }

#endregion
    }
}
