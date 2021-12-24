#region

using System;
using Appalachia.Rendering.Prefabs.Spawning.Physical;
using Appalachia.Rendering.Prefabs.Spawning.Settings;
using Appalachia.Utility.Strings;
using Unity.Profiling;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Spawning.Data
{
    [Serializable]
    public class RandomPrefabInstanceData
    {
        private const string _PRF_PFX = nameof(RandomPrefabInstanceData) + ".";

        private static readonly ProfilerMarker _PRF_Initialize = new(_PRF_PFX + nameof(Initialize));

        private static readonly ProfilerMarker _PRF_SetUpInstanceProperties =
            new(_PRF_PFX + nameof(SetUpInstanceProperties));

        private static readonly ProfilerMarker _PRF_InitializeRigidbodyProperties =
            new(_PRF_PFX + nameof(InitializeRigidbodyProperties));

        private static readonly ProfilerMarker _PRF_ResetOriginalRigidbodyProperties =
            new(_PRF_PFX + nameof(ResetOriginalRigidbodyProperties));

        public GameObject instance;
        public Transform transform;
        public RigidbodyCreationType rigidbodyCreation;
        public Rigidbody rigidbody;
        public Collider[] colliders;
        public RigidbodyDragModifier dragModifier;
        public RigidbodyRestorer rigidbodyRestorer;

        public Matrix4x4 initial;
        public Vector3 initialVector;

        public RandomPrefabInstanceData()
        {
        }

        public RandomPrefabInstanceData(GameObject i)
        {
            Initialize(i);
        }

        public void Initialize(GameObject i)
        {
            using (_PRF_Initialize.Auto())
            {
                instance = i;
                initial = instance.transform.localToWorldMatrix;
                transform = instance.GetComponent<Transform>();
                rigidbody = instance.GetComponentInChildren<Rigidbody>();
                colliders = instance.GetComponentsInChildren<Collider>();
                dragModifier = instance.GetComponent<RigidbodyDragModifier>();
                rigidbodyRestorer = instance.GetComponent<RigidbodyRestorer>();

                if (dragModifier == null)
                {
                    dragModifier = instance.gameObject.AddComponent<RigidbodyDragModifier>();
                    dragModifier.removeOnSleep = false;
                }
            }
        }

        public void SetUpInstanceProperties(PrefabSpawnSettings settings, bool addRigidbody)
        {
            using (_PRF_SetUpInstanceProperties.Auto())
            {
                if (addRigidbody && settings.physics.addRigidbodies)
                {
                    if (rigidbody == null)
                    {
                        rigidbody = instance.AddComponent<Rigidbody>();
                        rigidbodyCreation = RigidbodyCreationType.Added;

                        InitializeRigidbodyProperties(settings.physics);
                    }
                    else
                    {
                        if (rigidbodyCreation == RigidbodyCreationType.None)
                        {
                            if (rigidbodyRestorer == null)
                            {
                                rigidbodyRestorer =
                                    instance.gameObject.AddComponent<RigidbodyRestorer>();
                            }

                            rigidbodyCreation = RigidbodyCreationType.Original;
                        }

                        if ((rigidbodyCreation == RigidbodyCreationType.Added) ||
                            settings.physics.modifyExistingRigidbodies)
                        {
                            InitializeRigidbodyProperties(settings.physics);
                        }
                    }
                }
            }
        }

        private void InitializeRigidbodyProperties(PrefabSpawnPhysicsSettings settings)
        {
            using (_PRF_InitializeRigidbodyProperties.Auto())
            {
                if (settings.addRigidbodies &&
                    (settings.modifyExistingRigidbodies ||
                     (rigidbodyCreation == RigidbodyCreationType.Added)))
                {
                    rigidbody.drag = settings.drag;
                    rigidbody.angularDrag = settings.angularDrag;
                    Context.Log.Info(
                        ZString.Format("Setting mass from {0} to {1}.", rigidbody.mass, settings.mass)
                    );
                    rigidbody.mass = settings.mass;
                    rigidbody.interpolation = RigidbodyInterpolation.Interpolate;
                    rigidbody.isKinematic = false;
                    rigidbody.detectCollisions = true;
                    rigidbody.useGravity = true;
                    rigidbody.collisionDetectionMode = CollisionDetectionMode.Continuous;
                }
            }
        }

        public void ResetOriginalRigidbodyProperties()
        {
            using (_PRF_ResetOriginalRigidbodyProperties.Auto())
            {
                if (rigidbodyRestorer != null)
                {
                    rigidbodyRestorer.RestoreRigidbody(true);
                }
            }
        }
    }
}
