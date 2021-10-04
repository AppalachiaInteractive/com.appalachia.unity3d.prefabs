#region

using System;
using System.Collections.Generic;
using Appalachia.Base.Behaviours;
using Appalachia.Core.Extensions;
using Appalachia.Prefabs.Spawning.Sets;
using Appalachia.Prefabs.Spawning.Settings;
using Sirenix.OdinInspector;
using Unity.Profiling;
using UnityEngine;

#endregion

namespace Appalachia.Prefabs.Spawning.Data
{
    [Serializable]
    public class PrefabSpawnPointState : InternalBase<PrefabSpawnPointState>
    {
        private const string _PRF_PFX = nameof(PrefabSpawnPointState) + ".";

        private static readonly ProfilerMarker _PRF_EligibleForActivation =
            new(_PRF_PFX + nameof(EligibleForActivation));

        private static readonly ProfilerMarker _PRF_CanFinalize =
            new(_PRF_PFX + nameof(CanFinalize));

        private static readonly ProfilerMarker _PRF_CheckForSpawnOrphans =
            new(_PRF_PFX + nameof(CheckForSpawnOrphans));

        private static readonly ProfilerMarker _PRF_RemoveNulls =
            new(_PRF_PFX + nameof(RemoveNulls));

        private static readonly ProfilerMarker _PRF_DestroyInstances =
            new(_PRF_PFX + nameof(DestroyInstances));

        private static readonly ProfilerMarker _PRF_Spawn = new(_PRF_PFX + nameof(Spawn));
        [ReadOnly] public Transform root;

        [HideInInspector] public List<RandomPrefabInstanceData> spawnedObjects;

        public bool buryQueued;
        public bool buried;
        public Vector3 point;

        public PrefabSpawnPointState(Transform root)
        {
            this.root = root;
            spawnedObjects = new List<RandomPrefabInstanceData>();
        }

        [ReadOnly]
        [ShowInInspector]
        public int Count => spawnedObjects?.Count ?? 0;

        public bool EligibleForActivation(int limit)
        {
            using (_PRF_EligibleForActivation.Auto())
            {
                if (Count >= limit)
                {
                    return false;
                }

                return true;
            }
        }

        public bool CanFinalize(int limit)
        {
            using (_PRF_CanFinalize.Auto())
            {
                if (EligibleForActivation(limit))
                {
                    buried = false;
                    return false;
                }

                return true;
            }
        }

        public void CheckForSpawnOrphans()
        {
            using (_PRF_CheckForSpawnOrphans.Auto())
            {
                if (spawnedObjects.Count == root.childCount)
                {
                    return;
                }

                spawnedObjects.Clear();

                for (var i = 0; i < root.childCount; i++)
                {
                    var child = root.GetChild(i);

                    var data = new RandomPrefabInstanceData();
                    data.Initialize(child.gameObject);

                    spawnedObjects.Add(data);
                }
            }
        }

        public void RemoveNulls()
        {
            using (_PRF_RemoveNulls.Auto())
            {
                for (var i = spawnedObjects.Count - 1; i >= 0; i--)
                {
                    if (spawnedObjects[i] == null)
                    {
                        spawnedObjects.RemoveAt(i);
                    }
                }
            }
        }

        public void DestroyInstances()
        {
            using (_PRF_DestroyInstances.Auto())
            {
                for (var i = spawnedObjects.Count - 1; i >= 0; i--)
                {
                    if (spawnedObjects[i] != null)
                    {
                        spawnedObjects[i].instance.DestroySafely();
                    }

                    spawnedObjects.RemoveAt(i);
                }
            }
        }

        public RandomPrefabInstanceData Spawn(
            RandomPrefabSet set,
            PrefabSpawnerRigidbodyManager rigidbodyManager,
            PrefabSpawnSettings settings)
        {
            using (_PRF_Spawn.Auto())
            {
                CheckForSpawnOrphans();

                var spawnablePrefab = set.GetNextPrefab(out var transformData);

                var instance = RandomPrefabSpawnUtility.GetPrefabInstance(root, spawnablePrefab);

                var matrix = transformData.GetSpawnMatrix(
                    root.transform.position,
                    out var addRigidbody,
                    out var force,
                    out var direction
                );

                instance.initial = matrix;
                instance.SetUpInstanceProperties(settings, addRigidbody);

                instance.transform.SetMatrix4x4ToTransform(matrix);

                if (addRigidbody && settings.physics.addRigidbodies)
                {
                    instance.rigidbody.mass *= instance.transform.localScale.magnitude;
                    instance.initialVector = direction.normalized * force;

                    if (force > 0)
                    {
                        instance.rigidbody.AddForce(instance.initialVector, ForceMode.Impulse);
                    }

                    rigidbodyManager.Enqueue(instance.rigidbody);
                }

                spawnedObjects.Add(instance);

                return instance;
            }
        }
    }
}
