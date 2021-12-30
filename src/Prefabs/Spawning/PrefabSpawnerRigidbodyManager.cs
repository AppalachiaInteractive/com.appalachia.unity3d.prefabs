#region

using System;
using System.Collections.Generic;
using Appalachia.Core.Attributes;
using Appalachia.Rendering.Prefabs.Rendering;
using Appalachia.Rendering.Prefabs.Spawning.Physical;
using Appalachia.Rendering.Prefabs.Spawning.Settings;
using Appalachia.Spatial.Terrains.Utilities;
using Appalachia.Utility.Extensions;
using Sirenix.OdinInspector;
using Unity.Profiling;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Spawning
{
    [Serializable]
    [CallStaticConstructorInEditor]
    public class PrefabSpawnerRigidbodyManager
    {
        static PrefabSpawnerRigidbodyManager()
        {
            PrefabRenderingManager.InstanceAvailable += i => _prefabRenderingManager = i;
        }

        public PrefabSpawnerRigidbodyManager()
        {
            _rigidbodies = new Queue<Rigidbody>();
        }

        #region Static Fields and Autoproperties

        private static PrefabRenderingManager _prefabRenderingManager;

        #endregion

        #region Fields and Autoproperties

        public Bounds bounds;

        [ReadOnly]
        [ShowInInspector]
        private readonly Queue<Rigidbody> _rigidbodies;

        #endregion

        [ShowInInspector] public int ActiveCount => _rigidbodies.Count;

        public bool EligibleForActivation(PrefabSpawnSettings settings, out int limit)
        {
            using (_PRF_EligibleForActivation.Auto())
            {
                var delay = settings.physics.removeRigidbodiesAtLimit &&
                            settings.physics.delaySpawningUntilRigidbodiesLimited &&
                            (_rigidbodies.Count >= settings.physics.rigidbodyLimit);

                if (delay)
                {
                    HandleRigidbodyRemoval(settings);
                }

                delay = settings.physics.delaySpawningUntilRigidbodiesLimited &&
                        (_rigidbodies.Count >= settings.physics.rigidbodyLimit);

                limit = settings.physics.rigidbodyLimit - _rigidbodies.Count;

                return !delay;
            }
        }

        public void Enqueue(Rigidbody rb)
        {
            using (_PRF_Enqueue.Auto())
            {
                if (bounds == default)
                {
                    bounds.center = rb.transform.position;
                    bounds.size = Vector3.one;
                }
                else
                {
                    bounds.Encapsulate(rb.transform.position);
                }

                _rigidbodies.Enqueue(rb);
                _prefabRenderingManager.AddDistanceReferenceObject(rb.gameObject);
            }
        }

        public void HandleRigidbodyRemoval(PrefabSpawnSettings settings)
        {
            using (_PRF_HandleRigidbodyRemoval.Auto())
            {
                if (settings.physics.removeRigidbodiesAtLimit)
                {
                    if (!settings.physics.dontDeleteActiveRigidbodies)
                    {
                        while (_rigidbodies.Count > settings.physics.rigidbodyLimit)
                        {
                            var deq = _rigidbodies.Dequeue();

                            _prefabRenderingManager.RemoveDistanceReferenceObject(deq.gameObject);
                            deq.DestroySafely();
                        }
                    }
                    else
                    {
                        for (var i = 0; i < _rigidbodies.Count; i++)
                        {
                            if (_rigidbodies.Count < settings.physics.rigidbodyLimit)
                            {
                                break;
                            }

                            var deq = _rigidbodies.Dequeue();

                            if (deq == null)
                            {
                                continue;
                            }

                            var deqPosition = deq.transform.position;

                            var terrainBounds = Terrain.activeTerrains.GetTerrainAtPosition(deqPosition)
                                                      ?.GetWorldTerrainBounds() ??
                                                default;

                            if ((terrainBounds == default) || !terrainBounds.Contains(deq.transform.position))
                            {
                                var rdm = deq.GetComponentInParent<RigidbodyDragModifier>();

                                _prefabRenderingManager.RemoveDistanceReferenceObject(rdm.gameObject);
                                rdm.gameObject.DestroySafely();
                            }
                            else if (deq.velocity.magnitude >
                                     settings.physics.rigidbodyVelocityActiveThreshold)
                            {
                                _rigidbodies.Enqueue(deq);
                            }
                            else
                            {
                                _prefabRenderingManager.RemoveDistanceReferenceObject(deq.gameObject);
                                deq.DestroySafely();
                            }
                        }
                    }
                }

                var b = _rigidbodies.GetEncompassingBounds(rb => rb.transform.position);

                bounds = b;
            }
        }

        #region Profiling

        private const string _PRF_PFX = nameof(PrefabSpawnerRigidbodyManager) + ".";

        private static readonly ProfilerMarker _PRF_Enqueue = new(_PRF_PFX + nameof(Enqueue));

        private static readonly ProfilerMarker _PRF_HandleRigidbodyRemoval =
            new(_PRF_PFX + nameof(HandleRigidbodyRemoval));

        private static readonly ProfilerMarker _PRF_EligibleForActivation =
            new(_PRF_PFX + nameof(EligibleForActivation));

        #endregion
    }
}
