#region

using System;
using Appalachia.Editing.Attributes;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Prefabs.Rendering.ModelType.Rendering
{
    [Serializable]
    public class DistanceFalloffSettings : IEquatable<DistanceFalloffSettings>
    {
        [ToggleLeft]
        [HorizontalGroup("2", .2f)]
        [SerializeField]
        public bool useDistanceFalloff;

        [SmartLabel]
        [HorizontalGroup("2", .4f)]
        [PropertyRange(.0f, 0.9f)]
        [EnableIf(nameof(useDistanceFalloff))]
        [SerializeField]
        public float distanceFalloffStartDistance;

        public DistanceFalloffSettings(
            bool useDistanceFalloff = true,
            float distanceFalloffStartDistance = .5f)
        {
            this.useDistanceFalloff = useDistanceFalloff;
            this.distanceFalloffStartDistance = distanceFalloffStartDistance;
        }

        public static DistanceFalloffSettings Off()
        {
            return new(false);
        }

        public static DistanceFalloffSettings Immediate()
        {
            return new(true, 0.1f);
        }

        public static DistanceFalloffSettings Fast()
        {
            return new(true, 0.2f);
        }

        public static DistanceFalloffSettings Normal()
        {
            return new(true, 0.4f);
        }

        public static DistanceFalloffSettings Slow()
        {
            return new(true, 0.6f);
        }

        public static DistanceFalloffSettings VerySlow()
        {
            return new(true, 0.8f);
        }

#region IEquatable

        public bool Equals(DistanceFalloffSettings other)
        {
            if (ReferenceEquals(null, other))
            {
                return false;
            }

            if (ReferenceEquals(this, other))
            {
                return true;
            }

            return (useDistanceFalloff == other.useDistanceFalloff) &&
                   distanceFalloffStartDistance.Equals(other.distanceFalloffStartDistance);
        }

        public override bool Equals(object obj)
        {
            if (ReferenceEquals(null, obj))
            {
                return false;
            }

            if (ReferenceEquals(this, obj))
            {
                return true;
            }

            if (obj.GetType() != GetType())
            {
                return false;
            }

            return Equals((DistanceFalloffSettings) obj);
        }

        public override int GetHashCode()
        {
            unchecked
            {
                return (useDistanceFalloff.GetHashCode() * 397) ^
                       distanceFalloffStartDistance.GetHashCode();
            }
        }

        public static bool operator ==(DistanceFalloffSettings left, DistanceFalloffSettings right)
        {
            return Equals(left, right);
        }

        public static bool operator !=(DistanceFalloffSettings left, DistanceFalloffSettings right)
        {
            return !Equals(left, right);
        }

#endregion
    }
}
