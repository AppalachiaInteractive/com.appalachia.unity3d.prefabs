#region

using System;
using System.Collections.Generic;
using Appalachia.Core.Behaviours;
using Appalachia.Core.Extensions;
using Appalachia.Rendering.Prefabs.Rendering;
using Appalachia.Rendering.Prefabs.Spawning.Physical;
using Appalachia.Rendering.Prefabs.Spawning.Settings;
using Appalachia.Spatial.Terrains.Utilities;
using Sirenix.OdinInspector;
using Unity.Profiling;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Spawning
{
    [Serializable]
    public class PrefabSpawnerRigidbodyManager : AppalachiaBase<PrefabSpawnerRigidbodyManager>
    {
        private const string _PRF_PFX = nameof(PrefabSpawnerRigidbodyManager) + ".";

        private static readonly ProfilerMarker _PRF_Enqueue = new(_PRF_PFX + nameof(Enqueue));

        private static readonly ProfilerMarker _PRF_HandleRigidbodyRemoval =
            new(_PRF_PFX + nameof(HandleRigidbodyRemoval));

        private static readonly ProfilerMarker _PRF_EligibleForActivation =
            new(_PRF_PFX + nameof(EligibleForActivation));

        public Bounds bounds;

        [ReadOnly]
        [ShowInInspector]
        private readonly Queue<Rigidbody> _rigidbodies;

        public PrefabSpawnerRigidbodyManager()
        {
            _rigidbodies = new Queue<Rigidbody>();
        }

        [ShowInInspector] public int ActiveCount => _rigidbodies.Count;

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
                PrefabRenderingManager.instance.AddDistanceReferenceObject(rb.gameObject);
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

                            PrefabRenderingManager.instance.RemoveDistanceReferenceObject(
                                deq.gameObject
                            );
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

                            var terrainBounds =
                                Terrain.activeTerrains.GetTerrainAtPosition(deqPosition)
                                      ?.GetWorldTerrainBounds() ??
                                default;

                            if ((terrainBounds == default) ||
                                !terrainBounds.Contains(deq.transform.position))
                            {
                                var rdm = deq.GetComponentInParent<RigidbodyDragModifier>();

                                PrefabRenderingManager.instance.RemoveDistanceReferenceObject(
                                    rdm.gameObject
                                );
                                rdm.gameObject.DestroySafely();
                            }
                            else if (deq.velocity.magnitude >
                                     settings.physics.rigidbodyVelocityActiveThreshold)
                            {
                                _rigidbodies.Enqueue(deq);
                            }
                            else
                            {
                                PrefabRenderingManager.instance.RemoveDistanceReferenceObject(
                                    deq.gameObject
                                );
                                deq.DestroySafely();
                            }
                        }
                    }
                }

                var b = _rigidbodies.GetEncompassingBounds(rb => rb.transform.position);

                bounds = b;
            }
        }

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
    }
}
