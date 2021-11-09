#region

using System;
using System.Diagnostics;
using Appalachia.Core.Attributes.Editing;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.ModelType.Instancing
{
    [Serializable]
    public class FrustumSettings : IEquatable<FrustumSettings>
    {
        [SerializeField]
        [HorizontalGroup("A", .33f)]
        [PropertyRange(-20, 20)]
        [SmartLabel]
        public float fovOffset;

        [SerializeField]
        [HorizontalGroup("A", .33f)]
        [PropertyRange(.5f, 1.5f)]
        [SmartLabel]
        public float aspectOffset;

        [SerializeField]
        [HorizontalGroup("A", .33f)]
        [PropertyRange(-20, 20)]
        [SmartLabel]
        public float depthOffset;

        [SerializeField]
        [HorizontalGroup("C", .5f)]
        [PropertyRange(0f, 5.0f)]
        [SmartLabel]
        public float nearPlaneOffset;

        [SerializeField]
        [HorizontalGroup("C", .5f)]
        [PropertyRange(-20f, 20f)]
        [SmartLabel]
        public float farPlaneOffset;

        public void Confirm()
        {
            if (aspectOffset == 0.0f)
            {
                aspectOffset = 1.0f;
            }
        }

        public static FrustumSettings MatchCamera()
        {
            return new()
            {
                fovOffset = 0.0f,
                aspectOffset = 1.0f,
                nearPlaneOffset = 0.0f,
                farPlaneOffset = 0.0f
            };
        }

        public static FrustumSettings SetBack()
        {
            return new()
            {
                fovOffset = 0.0f,
                aspectOffset = 1.0f,
                nearPlaneOffset = 0.0f,
                farPlaneOffset = 0.0f
            };
        }

        public static FrustumSettings Narrow()
        {
            return new()
            {
                fovOffset = -3.0f,
                aspectOffset = 1.0f,
                nearPlaneOffset = 0.0f,
                farPlaneOffset = 0.0f
            };
        }

        public static FrustumSettings Wide()
        {
            return new()
            {
                fovOffset = 5.0f,
                aspectOffset = 1.0f,
                nearPlaneOffset = 0.0f,
                farPlaneOffset = 0.0f
            };
        }

#region IEquatable

        [DebuggerStepThrough] public bool Equals(FrustumSettings other)
        {
            if (ReferenceEquals(null, other))
            {
                return false;
            }

            if (ReferenceEquals(this, other))
            {
                return true;
            }

            return fovOffset.Equals(other.fovOffset) &&
                   aspectOffset.Equals(other.aspectOffset) &&
                   depthOffset.Equals(other.depthOffset) &&
                   nearPlaneOffset.Equals(other.nearPlaneOffset) &&
                   farPlaneOffset.Equals(other.farPlaneOffset);
        }

        [DebuggerStepThrough] public override bool Equals(object obj)
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

            return Equals((FrustumSettings) obj);
        }

        [DebuggerStepThrough] public override int GetHashCode()
        {
            unchecked
            {
                var hashCode = fovOffset.GetHashCode();
                hashCode = (hashCode * 397) ^ aspectOffset.GetHashCode();
                hashCode = (hashCode * 397) ^ depthOffset.GetHashCode();
                hashCode = (hashCode * 397) ^ nearPlaneOffset.GetHashCode();
                hashCode = (hashCode * 397) ^ farPlaneOffset.GetHashCode();
                return hashCode;
            }
        }

        [DebuggerStepThrough] public static bool operator ==(FrustumSettings left, FrustumSettings right)
        {
            return Equals(left, right);
        }

        [DebuggerStepThrough] public static bool operator !=(FrustumSettings left, FrustumSettings right)
        {
            return !Equals(left, right);
        }

#endregion
    }
}
