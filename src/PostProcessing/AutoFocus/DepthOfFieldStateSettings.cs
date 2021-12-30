using System;
using Appalachia.Core.Attributes.Editing;
using Appalachia.Core.Objects.Scriptables;
using Sirenix.OdinInspector;
using Unity.Mathematics;
using UnityEngine;

namespace Appalachia.Rendering.PostProcessing.AutoFocus
{
    [Serializable]
    public class DepthOfFieldStateSettings : AutonamedIdentifiableAppalachiaObject<DepthOfFieldStateSettings>
    {
        #region Fields and Autoproperties

        [SerializeField]
        [SmartLabel]
        public DepthOfFieldState state;

        [TabGroup("Planes", "Far Plane")]
        [InlineProperty]
        [HideLabel]
        public DepthOfFieldStatePlaneSettings farPlane;

        [TabGroup("Planes", "Near Plane")]
        [InlineProperty]
        [HideLabel]
        public DepthOfFieldStatePlaneSettings nearPlane;

        [BoxGroup("Focus")]
        [PropertyTooltip("Sets the focus distance when nothing is explicitly targeted.")]
        [PropertyRange(0.1f, 20.0f)]
        [SmartLabel]
        public float defaultFocusDistance = 10f;

        [BoxGroup("Focus")]
        [PropertyRange(20.0f, 200.0f)]
        [SmartLabel]
        public float maxFocusDistance = 75.0f;

        [BoxGroup("Movement")]
        [PropertyTooltip("Movement velocity at which these settings enable.")]
        [PropertyRange(0.1f, 2f)]
        [HideIf(nameof(hideVelocityThreshold))]
        [SmartLabel]
        public float velocityFadeRange = 1.0f;

        [BoxGroup("Movement")]
        [PropertyTooltip("Movement velocity at which these settings enable.")]
        [PropertyRange(0.1f, 6f)]
        [HideIf(nameof(hideVelocityThreshold))]
        [SmartLabel]
        public float velocityThreshold = 3.0f;

        #endregion

        private bool hideVelocityThreshold => state == DepthOfFieldState.Standing;

        public void Lerp(DepthOfFieldStateSettings a, DepthOfFieldStateSettings b, float t)
        {
            state = b.state;
            velocityThreshold = math.lerp(a.velocityThreshold,       b.velocityThreshold,    t);
            velocityFadeRange = math.lerp(a.velocityFadeRange,       b.velocityFadeRange,    t);
            defaultFocusDistance = math.lerp(a.defaultFocusDistance, b.defaultFocusDistance, t);
            maxFocusDistance = math.lerp(a.maxFocusDistance,         b.maxFocusDistance,     t);

            nearPlane.Lerp(a.nearPlane, b.farPlane, t);
            farPlane.Lerp(a.farPlane, b.nearPlane, t);
        }

        public void Set(DepthOfFieldStateSettings a)
        {
            state = a.state;
            velocityThreshold = a.velocityThreshold;
            velocityFadeRange = a.velocityFadeRange;
            defaultFocusDistance = a.defaultFocusDistance;
            maxFocusDistance = a.maxFocusDistance;

            nearPlane.Set(a.nearPlane);
            farPlane.Set(a.farPlane);
        }
    }
}
