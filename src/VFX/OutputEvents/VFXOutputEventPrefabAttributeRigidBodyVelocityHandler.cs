using UnityEngine;
using UnityEngine.VFX;

namespace Appalachia.Rendering.VFX.OutputEvents
{
    [RequireComponent(typeof(Rigidbody))]
    public class
        VFXOutputEventPrefabAttributeRigidBodyVelocityHandler : VFXOutputEventPrefabAttributeAbstractHandler
    {
        public enum Space
        {
            Local,
            World
        }

        private static readonly int k_Velocity = Shader.PropertyToID("velocity");
        public Space attributeSpace;
        private Rigidbody m_RigidBody;

        public override void OnVFXEventAttribute(VFXEventAttribute eventAttribute, VisualEffect visualEffect)
        {
            var velocity = eventAttribute.GetVector3(k_Velocity);
            if (attributeSpace == Space.Local)
            {
                velocity = visualEffect.transform.localToWorldMatrix.MultiplyVector(velocity);
            }

            if (TryGetComponent(out m_RigidBody))
            {
                m_RigidBody.WakeUp();
                m_RigidBody.velocity = velocity;
            }
        }
    }
}
