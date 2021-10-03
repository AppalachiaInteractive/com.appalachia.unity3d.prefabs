#region

using System;
using Appalachia.Core.Editing.Attributes;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Core.AssetMetadata.Options.ModelType.Rendering
{
    [Serializable]
public class AssetCullingSettings : IEquatable<AssetCullingSettings>
    {
        [SerializeField]
        [HorizontalGroup("0", .4f)]
        [SmartLabel]
        [ToggleLeft]
        public bool isFrustumCulling;

        [SerializeField]
        [HorizontalGroup("0", .6f)]
        [SmartLabel]
        [PropertyRange(0.0f, 0.5f)]
        [EnableIf(nameof(isFrustumCulling))]
        public float frustumOffset;

        [SerializeField]
        [HorizontalGroup("1", .5f)]
        [SmartLabel]
        [ToggleLeft]
        public bool isOcclusionCulling;

        [SerializeField]
        [HorizontalGroup("1", .5f)]
        [SmartLabel]
        [PropertyRange(0.0f, 0.1f)]
        [EnableIf(nameof(isOcclusionCulling))]
        public float occlusionOffset;

        [SerializeField]
        [HorizontalGroup("2", .5f)]
        [SmartLabel]
        [PropertyRange(1, 3)]
        [EnableIf(nameof(isOcclusionCulling))]
        public int occlusionAccuracy;

        [SerializeField]
        [HorizontalGroup("2", .5f)]
        [SmartLabel]
        [PropertyRange(0.0f, 100f)]
        [EnableIf(nameof(isCulling))]
        public float minCullingDistance;
        
        [SerializeField]
        [HorizontalGroup("3", .5f)]
        [SmartLabel]
        [ToggleLeft]
        public bool updateCullingEveryIteration;
        
        [SerializeField]
        [HorizontalGroup("3", .5f)]
        [SmartLabel]
        [PropertyRange(1, 30)]
        [DisableIf(nameof(updateCullingEveryIteration))]
        public int updateCullingEveryXFrames = 6;

        public AssetCullingSettings(
            bool isFrustumCulling = true,
            float frustumOffset = .2f,
            bool isOcclusionCulling = true,
            float occlusionOffset = .0f,
            int occlusionAccuracy = 1,
            float minCullingDistance = 0f)
        {
            this.isFrustumCulling = isFrustumCulling;
            this.frustumOffset = frustumOffset;
            this.isOcclusionCulling = isOcclusionCulling;
            this.occlusionOffset = occlusionOffset;
            this.occlusionAccuracy = occlusionAccuracy;
            this.minCullingDistance = minCullingDistance;
        }

        public bool isCulling => isFrustumCulling || isOcclusionCulling;

        public static AssetCullingSettings NotCulled()
        {
            return new AssetCullingSettings();
        }

        public static AssetCullingSettings OcclusionCulled(float occlusionOffset = 0.0f, int occlusionAccuracy = 1, float minCullingDistance = 0f)
        {
            return new AssetCullingSettings(
                occlusionOffset: occlusionOffset,
                occlusionAccuracy: occlusionAccuracy,
                minCullingDistance: minCullingDistance
            );
        }

        public static AssetCullingSettings FrustumCulled(float frustumOffset = .2f, float minCullingDistance = 0f)
        {
            return new AssetCullingSettings(frustumOffset: frustumOffset, minCullingDistance: minCullingDistance);
        }

        public static AssetCullingSettings CompletelyCulled(
            float frustumOffset = .2f,
            float occlusionOffset = 0.0f,
            int occlusionAccuracy = 1,
            float minCullingDistance = 0f)
        {
            return new AssetCullingSettings(
                frustumOffset: frustumOffset,
                occlusionOffset: occlusionOffset,
                occlusionAccuracy: occlusionAccuracy,
                minCullingDistance: minCullingDistance
            );
        }

#region IEquatable

        public bool Equals(AssetCullingSettings other)
        {
            if (ReferenceEquals(null, other))
            {
                return false;
            }

            if (ReferenceEquals(this, other))
            {
                return true;
            }

            return (isFrustumCulling == other.isFrustumCulling) &&
                   frustumOffset.Equals(other.frustumOffset) &&
                   (isOcclusionCulling == other.isOcclusionCulling) &&
                   occlusionOffset.Equals(other.occlusionOffset) &&
                   (occlusionAccuracy == other.occlusionAccuracy) &&
                   minCullingDistance.Equals(other.minCullingDistance);
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

            return Equals((AssetCullingSettings) obj);
        }

        public override int GetHashCode()
        {
            unchecked
            {
                var hashCode = isFrustumCulling.GetHashCode();
                hashCode = (hashCode * 397) ^ frustumOffset.GetHashCode();
                hashCode = (hashCode * 397) ^ isOcclusionCulling.GetHashCode();
                hashCode = (hashCode * 397) ^ occlusionOffset.GetHashCode();
                hashCode = (hashCode * 397) ^ occlusionAccuracy;
                hashCode = (hashCode * 397) ^ minCullingDistance.GetHashCode();
                return hashCode;
            }
        }

        public static bool operator ==(AssetCullingSettings left, AssetCullingSettings right)
        {
            return Equals(left, right);
        }

        public static bool operator !=(AssetCullingSettings left, AssetCullingSettings right)
        {
            return !Equals(left, right);
        }

#endregion
    }
}
