#region

using System;
using Appalachia.Editing.Attributes;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Prefabs.Rendering.ModelType.Rendering
{
    [Serializable]
    public class LODFadeSettings : IEquatable<LODFadeSettings>
    {
        [SerializeField]
        [SmartLabel]
        [PropertyRange(.1f, 5f)]
        public float lodBiasAdjustment;

        [HorizontalGroup("0", .2F)]
        [SerializeField]
        [SmartLabel]
        [ToggleLeft]
        [LabelText("Crossfade")]
        public bool useLODCrossFade;

        [HorizontalGroup("0", .2F)]
        [SerializeField]
        [SmartLabel]
        [ToggleLeft]
        [LabelText("Animate")]
        [EnableIf(nameof(useLODCrossFade))]
        public bool animateLODCrossFade;

        [HorizontalGroup("0", .6F)]
        [SerializeField]
        [SmartLabel]
        [LabelText("Transition Width")]
        [EnableIf(nameof(useLODCrossFade))]
        [PropertyRange(0.01f, 1.0f)]
        public float lodFadeTransitionWidth;

        public LODFadeSettings(
            float lodBiasAdjustment = 1.0f,
            bool useLodCrossFade = false,
            bool animateLodCrossFade = false,
            float lodFadeTransitionWidth = .1f)
        {
            this.lodBiasAdjustment = lodBiasAdjustment;
            useLODCrossFade = useLodCrossFade;
            animateLODCrossFade = animateLodCrossFade;
            this.lodFadeTransitionWidth = lodFadeTransitionWidth;
        }

        public static LODFadeSettings NoFade()
        {
            return new();
        }

        public static LODFadeSettings FadeWide()
        {
            return new(1.0f, true, false, 0.3f);
        }

        public static LODFadeSettings FadeNormal()
        {
            return new(1.0f, true, false, 0.2f);
        }

        public static LODFadeSettings FadeNarrow()
        {
            return new(1.0f, true);
        }

#region IEquatable

        public bool Equals(LODFadeSettings other)
        {
            if (ReferenceEquals(null, other))
            {
                return false;
            }

            if (ReferenceEquals(this, other))
            {
                return true;
            }

            return lodBiasAdjustment.Equals(other.lodBiasAdjustment) &&
                   (useLODCrossFade == other.useLODCrossFade) &&
                   (animateLODCrossFade == other.animateLODCrossFade) &&
                   lodFadeTransitionWidth.Equals(other.lodFadeTransitionWidth);
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

            return Equals((LODFadeSettings) obj);
        }

        public override int GetHashCode()
        {
            unchecked
            {
                var hashCode = lodBiasAdjustment.GetHashCode();
                hashCode = (hashCode * 397) ^ useLODCrossFade.GetHashCode();
                hashCode = (hashCode * 397) ^ animateLODCrossFade.GetHashCode();
                hashCode = (hashCode * 397) ^ lodFadeTransitionWidth.GetHashCode();
                return hashCode;
            }
        }

        public static bool operator ==(LODFadeSettings left, LODFadeSettings right)
        {
            return Equals(left, right);
        }

        public static bool operator !=(LODFadeSettings left, LODFadeSettings right)
        {
            return !Equals(left, right);
        }

#endregion
    }
}
