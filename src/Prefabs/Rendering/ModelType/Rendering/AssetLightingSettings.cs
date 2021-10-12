#region

using System;
using Appalachia.Core.Attributes.Editing;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Serialization;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.ModelType.Rendering
{
    [Serializable]
    public class AssetLightingSettings : IEquatable<AssetLightingSettings>
    {
        [HorizontalGroup("0", .5f)]
        [SerializeField]
        [SmartLabel]
        public LightProbeUsage lightProbeUsage;

        [ToggleLeft]
        [SmartLabel]
        [HorizontalGroup("0", .5f)]
        [EnableIf(nameof(_enable_forceAdditionalShadowPass))]
        [ReadOnly]
        [ShowInInspector]
        public bool forceAdditionalShadowPass;

        [HorizontalGroup("1", .5f)]
        [SerializeField]
        [ToggleLeft]
        public bool isShadowCasting;

        [HorizontalGroup("1", .5f)]
        [SmartLabel]
        [SerializeField]
        [ToggleLeft]
        public bool isShadowReceiving;

        [ToggleLeft]
        [SmartLabel]
        [HorizontalGroup("2", .5f)]
        [EnableIf(nameof(_enabled_cullShadows))]
        [SerializeField]
        public bool cullShadows;

        [ToggleLeft]
        [SmartLabel]
        [HorizontalGroup("2", .5f)]
        [EnableIf(nameof(_enabled_useOriginalShaderForShadow))]
        [SerializeField]
        public bool useOriginalShaderForShadow;

        [ToggleLeft]
        [SmartLabel]
        [HorizontalGroup("3", .5f)]
        [EnableIf(nameof(_enabled_useCustomShadowDistance))]
        [SerializeField]
        public bool useCustomShadowDistance;

        [SmartLabel]
        [HorizontalGroup("3", .5f)]
        [PropertyRange(0, 4096f)]
        [EnableIf(nameof(_enabled_shadowRenderingDistance))]
        [SerializeField]
        public float shadowRenderingDistance;

        [FormerlySerializedAs("canCullShadows")]
        [HideInInspector]
        public bool instancedShader;

        private bool _enable_forceAdditionalShadowPass => instancedShader;

        [ToggleLeft]
        [SmartLabel]

        //[HorizontalGroup("0.5", .5f)]
        [ReadOnly]
        [ShowInInspector]
        public bool additionalShadowPass =>
            (instancedShader && forceAdditionalShadowPass) ||
            (isShadowCasting && (useCustomShadowDistance || !cullShadows));

        private bool _enabled_cullShadows => isShadowCasting && instancedShader;
        private bool _enabled_useCustomShadowDistance => isShadowCasting && instancedShader;

        private bool _enabled_shadowRenderingDistance =>
            isShadowCasting && instancedShader && useCustomShadowDistance;

        private bool _enabled_useOriginalShaderForShadow => additionalShadowPass;

        public static AssetLightingSettings Unlit()
        {
            return new()
            {
                cullShadows = false,
                isShadowCasting = false,
                isShadowReceiving = false,
                instancedShader = false,
                lightProbeUsage = LightProbeUsage.Off,
                useCustomShadowDistance = false,
                shadowRenderingDistance = 0.0f,
                useOriginalShaderForShadow = false
            };
        }

        public static AssetLightingSettings Lit(
            LightProbeUsage lighting = LightProbeUsage.BlendProbes)
        {
            return new()
            {
                cullShadows = false,
                isShadowCasting = false,
                isShadowReceiving = true,
                instancedShader = false,
                lightProbeUsage = lighting,
                useCustomShadowDistance = false,
                shadowRenderingDistance = 1024.0f,
                useOriginalShaderForShadow = false
            };
        }

        public static AssetLightingSettings Shadowed(float distance = 0)
        {
            return new()
            {
                cullShadows = true,
                isShadowCasting = true,
                isShadowReceiving = true,
                instancedShader = false,
                lightProbeUsage = LightProbeUsage.Off,
                useCustomShadowDistance = distance > 0,
                shadowRenderingDistance = distance > 0 ? distance : 1024.0f,
                useOriginalShaderForShadow = true
            };
        }

        public static AssetLightingSettings LitAndShadowed(
            LightProbeUsage lighting = LightProbeUsage.BlendProbes,
            float distance = 0)
        {
            return new()
            {
                cullShadows = true,
                isShadowCasting = true,
                isShadowReceiving = true,
                instancedShader = false,
                lightProbeUsage = lighting,
                useCustomShadowDistance = distance > 0,
                shadowRenderingDistance = distance > 0 ? distance : 1024.0f,
                useOriginalShaderForShadow = true
            };
        }

#region IEquatable

        public bool Equals(AssetLightingSettings other)
        {
            if (ReferenceEquals(null, other))
            {
                return false;
            }

            if (ReferenceEquals(this, other))
            {
                return true;
            }

            return (isShadowCasting == other.isShadowCasting) &&
                   (instancedShader == other.instancedShader) &&
                   (isShadowReceiving == other.isShadowReceiving) &&
                   (cullShadows == other.cullShadows) &&
                   (lightProbeUsage == other.lightProbeUsage) &&
                   (useOriginalShaderForShadow == other.useOriginalShaderForShadow) &&
                   (useCustomShadowDistance == other.useCustomShadowDistance) &&
                   shadowRenderingDistance.Equals(other.shadowRenderingDistance);
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

            return Equals((AssetLightingSettings) obj);
        }

        public override int GetHashCode()
        {
            unchecked
            {
                var hashCode = isShadowCasting.GetHashCode();
                hashCode = (hashCode * 397) ^ instancedShader.GetHashCode();
                hashCode = (hashCode * 397) ^ isShadowReceiving.GetHashCode();
                hashCode = (hashCode * 397) ^ cullShadows.GetHashCode();
                hashCode = (hashCode * 397) ^ (int) lightProbeUsage;
                hashCode = (hashCode * 397) ^ useOriginalShaderForShadow.GetHashCode();
                hashCode = (hashCode * 397) ^ useCustomShadowDistance.GetHashCode();
                hashCode = (hashCode * 397) ^ shadowRenderingDistance.GetHashCode();
                return hashCode;
            }
        }

        public static bool operator ==(AssetLightingSettings left, AssetLightingSettings right)
        {
            return Equals(left, right);
        }

        public static bool operator !=(AssetLightingSettings left, AssetLightingSettings right)
        {
            return !Equals(left, right);
        }

#endregion
    }
}
