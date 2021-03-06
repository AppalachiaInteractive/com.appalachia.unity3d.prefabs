#region

using Appalachia.Core.Objects.Root;
using Unity.Profiling;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Spawning.Physical
{
    public sealed class RigidbodyDragModifier : AppalachiaBehaviour<RigidbodyDragModifier>
    {
        #region Fields and Autoproperties

        public bool removeOnSleep;

        public float dragModification = .95f;

        public float angularDragModification = .95f;

        public float massModification = 1.05f;
        private Rigidbody _rigidbody;

        #endregion

        #region Event Functions

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

        #endregion

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

        #region Profiling

        private static readonly ProfilerMarker _PRF_CheckRigidbody = new(_PRF_PFX + nameof(CheckRigidbody));

        private static readonly ProfilerMarker _PRF_OnCollisionEnter =
            new(_PRF_PFX + nameof(OnCollisionEnter));

        #endregion
    }
}
