using UnityEngine;
using UnityEngine.VFX;
using UnityEngine.VFX.Utility;

namespace Appalachia.Rendering.VFX.OutputEvents
{
    [ExecuteAlways]
    [RequireComponent(typeof(VisualEffect))]
    public class VFXOutputEventRigidBody : VFXOutputEventAbstractHandler
    {
        public enum RigidBodyEventType
        {
            Impulse,
            Explosion,
            VelocityChange
        }

        public enum Space
        {
            Local,
            World
        }

        private static readonly int k_Position = Shader.PropertyToID("position");
        private static readonly int k_Size = Shader.PropertyToID("size");
        private static readonly int k_Velocity = Shader.PropertyToID("velocity");

        [Tooltip("The Rigid body to apply a force on.")]
        public Rigidbody rigidBody;

        [Tooltip(
            "Type of Instantaneous Force to apply on the RigidBody upon event:\n - Impulse using the Velocity attribute \n - Explosion at given Position attribute, using the Size for radius and the magnitude of Velocity Attribute for intensity\n - Velocity Change using Velocity Attribute"
        )]
        public RigidBodyEventType eventType;

        [Tooltip("The Space VFX Attributes values are expressed.")]
        public Space attributeSpace;

        public override bool canExecuteInEditor => false;

        public override void OnVFXOutputEvent(VFXEventAttribute eventAttribute)
        {
            if (rigidBody == null)
            {
                return;
            }

            var position = eventAttribute.GetVector3(k_Position);
            var size = eventAttribute.GetFloat(k_Size);
            var velocity = eventAttribute.GetVector3(k_Velocity);
            if (attributeSpace == Space.Local)
            {
                position = transform.localToWorldMatrix.MultiplyPoint(position);
                velocity = transform.localToWorldMatrix.MultiplyVector(velocity);

                // We assume that the size is bound to the X component of the transform scale
                // and that the transform is uniform.
                size = transform.localToWorldMatrix.MultiplyVector(Vector3.right * size).magnitude;
            }

            switch (eventType)
            {
                case RigidBodyEventType.Impulse:
                    rigidBody.AddForce(velocity, ForceMode.Impulse);
                    break;
                case RigidBodyEventType.Explosion:
                    rigidBody.AddExplosionForce(velocity.magnitude, position, size);
                    break;
                case RigidBodyEventType.VelocityChange:
                    rigidBody.AddForce(velocity, ForceMode.VelocityChange);
                    break;
            }
        }
    }
}
