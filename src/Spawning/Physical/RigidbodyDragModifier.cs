#region

using Appalachia.Core.Behaviours;
using Unity.Profiling;
using UnityEngine;

#endregion

namespace Appalachia.Core.Spawning.Physical
{
    public class RigidbodyDragModifier : InternalMonoBehaviour
    {
        private const string _PRF_PFX = nameof(RigidbodyDragModifier) + ".";
        private Rigidbody _rigidbody;

        public bool removeOnSleep;

        public float dragModification = .95f;

        public float angularDragModification = .95f;

        public float massModification = 1.05f;

        private static readonly ProfilerMarker _PRF_FixedUpdate = new ProfilerMarker(_PRF_PFX + nameof(FixedUpdate));
        private void FixedUpdate()
        {
            using (_PRF_FixedUpdate.Auto())
            {
                if (CheckRigidbody())
                {
                    return;
                }

                if (removeOnSleep && _rigidbody.IsSleeping())
                {
                    Destroy(_rigidbody);
                    Destroy(this);
                }
            }
        }

        private static readonly ProfilerMarker _PRF_CheckRigidbody = new ProfilerMarker(_PRF_PFX + nameof(CheckRigidbody));
        private bool CheckRigidbody()
        {
            using (_PRF_CheckRigidbody.Auto())
            {
                if (_rigidbody == null)
                {
                    _rigidbody = GetComponent<Rigidbody>();

                    if (_rigidbody == null)
                    {
                        _rigidbody = GetComponentInChildren<Rigidbody>();

                        if (_rigidbody == null)
                        {
                            return true;
                        }
                    }
                }

                return false;
            }
        }

        private static readonly ProfilerMarker _PRF_OnCollisionEnter = new ProfilerMarker(_PRF_PFX + nameof(OnCollisionEnter));
        private void OnCollisionEnter(Collision other)
        {
            using (_PRF_OnCollisionEnter.Auto())
            {
                if (CheckRigidbody())
                {
                    return;
                }

                _rigidbody.drag *= dragModification;
                _rigidbody.angularDrag *= angularDragModification;
                _rigidbody.mass *= massModification;
            }
        }
    }
}
