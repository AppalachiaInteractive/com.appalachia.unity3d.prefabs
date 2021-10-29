using Cinemachine;
using UnityEngine;
using UnityEngine.VFX;
using UnityEngine.VFX.Utility;

namespace Appalachia.Rendering.VFX.OutputEvents
{
    [ExecuteAlways]
    [RequireComponent(typeof(VisualEffect))]
    public class VFXOutputEventCinemachineCameraShake : VFXOutputEventAbstractHandler
    {
        public enum Space
        {
            Local,
            World
        }

        private static readonly int k_Position = Shader.PropertyToID("position");
        private static readonly int k_Velocity = Shader.PropertyToID("velocity");

        [Tooltip("The Cinemachine Impulse Source to use in order to send impulses.")]
        public CinemachineImpulseSource cinemachineImpulseSource;

        [Tooltip(
            "The space in which the position and velocity attributes values are defined (local to the VFX, or world)."
        )]
        public Space attributeSpace;

        public override bool canExecuteInEditor => true;

        public override void OnVFXOutputEvent(VFXEventAttribute eventAttribute)
        {
            if (cinemachineImpulseSource != null)
            {
                var pos = eventAttribute.GetVector3(k_Position);
                var vel = eventAttribute.GetVector3(k_Velocity);

                if (attributeSpace == Space.Local)
                {
                    pos = transform.localToWorldMatrix.MultiplyPoint(pos);
                    vel = transform.localToWorldMatrix.MultiplyVector(vel);
                }

                cinemachineImpulseSource.GenerateImpulseAt(pos, vel);
            }
        }
    }
}
