#region

using System;
using System.Collections.Generic;
using Appalachia.Base.Behaviours;
using Appalachia.Core.Constants;
using Appalachia.Prefabs.Spawning.Collections;
using Appalachia.Prefabs.Spawning.Sets;
using Appalachia.Prefabs.Spawning.Settings;
using Appalachia.Spatial.Extensions;
using Sirenix.OdinInspector;
using Unity.Profiling;
using UnityEngine;

#endregion

namespace Appalachia.Prefabs.Spawning.Data
{
    [Serializable]
    public class PrefabSpawnPointCollection : InternalBase<PrefabSpawnPointCollection>
    {
        private const string _PRF_PFX = nameof(PrefabSpawnPointCollection) + ".";
            
        [SerializeField]
        [ListDrawerSettings(Expanded = true, DraggableItems = false, HideAddButton = true, HideRemoveButton = true, NumberOfItemsPerPage = 10)]
        private PrefabSpawnPointStateLookup _state;

        public bool finalized;
        public bool completed;
        public string prefabKey;

        public int activeIndex;

        public Transform root;

        public PrefabSpawnPointCollection(Transform root, string prefabKey)
        {
            this.root = root;
            this.prefabKey = prefabKey;

            _state = new PrefabSpawnPointStateLookup();
        }

        public int Length => _state.SumCounts(v => v.Count);

        private static readonly ProfilerMarker _PRF_FullCheck = new ProfilerMarker(_PRF_PFX + nameof(FullCheck));
        public void FullCheck()
        {
            using (_PRF_FullCheck.Auto())
            {
                for (var i = 0; i < _state.Count; i++)
                {
                    var spawnPoint = _state.at[i];

                    if (spawnPoint.root == null)
                    {
                        var subRoot = GetSpawnPointTransform(spawnPoint.point);
                        spawnPoint.root = subRoot.transform;
                    }

                    spawnPoint.RemoveNulls();
                    spawnPoint.CheckForSpawnOrphans();
                }
            }
        }

        private static readonly ProfilerMarker _PRF_CheckForSpawnOrphans = new ProfilerMarker(_PRF_PFX + nameof(CheckForSpawnOrphans));
        private void CheckForSpawnOrphans()
        {
            using (_PRF_CheckForSpawnOrphans.Auto())
            {
                for (var i = 0; i < _state.Count; i++)
                {
                    var spawnPoint = _state.at[i];

                    if (spawnPoint.root == null)
                    {
                        var subRoot = GetSpawnPointTransform(spawnPoint.point);
                        spawnPoint.root = subRoot.transform;
                    }

                    spawnPoint.CheckForSpawnOrphans();
                }
            }
        }

        private static readonly ProfilerMarker _PRF_RemoveNulls = new ProfilerMarker(_PRF_PFX + nameof(RemoveNulls));
        public void RemoveNulls()
        {
            using (_PRF_RemoveNulls.Auto())
            {
                for (var i = 0; i < _state.Count; i++)
                {
                    var spawnPoint = _state.at[i];
                    spawnPoint.RemoveNulls();
                }
            }
        }

        private static readonly ProfilerMarker _PRF_DestroyInstances = new ProfilerMarker(_PRF_PFX + nameof(DestroyInstances));
        public void DestroyInstances()
        {
            using (_PRF_DestroyInstances.Auto())
            {
                for (var i = 0; i < _state.Count; i++)
                {
                    var spawnPoint = _state.at[i];
                    spawnPoint.DestroyInstances();
                }

                _state.Clear();
            }
        }

        private static readonly ProfilerMarker _PRF_AddSpawnPoint = new ProfilerMarker(_PRF_PFX + nameof(AddSpawnPoint));
        public void AddSpawnPoint(Vector3 point)
        {
            using (_PRF_AddSpawnPoint.Auto())
            {
                var key = point.GetSpatialKey(CONSTANTS.PrefabSpawningGroupingKey);

                if (!_state.ContainsKey(key))
                {
                    var subRoot = GetSpawnPointTransform(point);

                    _state.AddOrUpdate(key, new PrefabSpawnPointState(subRoot) {point = point});
                }
            }
        }

        private static readonly ProfilerMarker _PRF_GetSpawnPointTransform = new ProfilerMarker(_PRF_PFX + nameof(GetSpawnPointTransform));
        private Transform GetSpawnPointTransform(Vector3 point)
        {
            using (_PRF_GetSpawnPointTransform.Auto())
            {
                var pointString = point.ToString();

                var subRoot = root.Find(pointString)?.gameObject;

                if (subRoot == null)
                {
                    Debug.Log($"{root.name}  ::  {pointString}");
                    subRoot = new GameObject(pointString);
                    subRoot.transform.position = point;
                    subRoot.transform.SetParent(root, true);
                }

                return subRoot.transform;
            }
        }

        private static readonly ProfilerMarker _PRF_UpdateSpawnPoints = new ProfilerMarker(_PRF_PFX + nameof(UpdateSpawnPoints));
        public void UpdateSpawnPoints(RandomPrefabSpawnSource spawnSource)
        {
            using (_PRF_UpdateSpawnPoints.Auto())
            {
                var pointCount = spawnSource.GetSpawnPointCount();

                if (pointCount == 0)
                {
                    return;
                }

                if (_state.Count == pointCount)
                {
                    return;
                }

                var points = spawnSource.GetSpawnPoints();

                UpdateSpawnPoints(points);
            }
        }

        
        public void UpdateSpawnPoints(Vector3[] points)
        {
            using (_PRF_UpdateSpawnPoints.Auto())
            {
                for (var i = 0; i < points.Length; i++)
                {
                    var point = points[i];
                    AddSpawnPoint(point);
                }
            }
        }

        public void UpdateSpawnPoints(IEnumerable<Vector3> points)
        {
            using (_PRF_UpdateSpawnPoints.Auto())
            {
                foreach (var point in points)
                {
                    AddSpawnPoint(point);
                }
            }
        }

        private static readonly ProfilerMarker _PRF_EligibleForActivation = new ProfilerMarker(_PRF_PFX + nameof(EligibleForActivation));
        public bool EligibleForActivation(int limit)
        {
            using (_PRF_EligibleForActivation.Auto())
            {
                if (finalized || completed)
                {
                    return false;
                }

                for (var i = 0; i < _state.Count; i++)
                {
                    var spawnPoint = _state.at[i];

                    if (spawnPoint.root == null)
                    {
                        var subRoot = GetSpawnPointTransform(spawnPoint.point);
                        spawnPoint.root = subRoot.transform;
                    }

                    if (spawnPoint.EligibleForActivation(limit))
                    {
                        return true;
                    }
                }

                return false;
            }
        }

        private static readonly ProfilerMarker _PRF_TryGetActiveSpawnPoint = new ProfilerMarker(_PRF_PFX + nameof(TryGetActiveSpawnPoint));
        private bool TryGetActiveSpawnPoint(int limit, out PrefabSpawnPointState spawnPoint)
        {
            using (_PRF_TryGetActiveSpawnPoint.Auto())
            {
                spawnPoint = null;

                if (_state.Count == 0)
                {
                    return false;
                }

                if (activeIndex >= _state.Count)
                {
                    activeIndex = 0;
                }

                while (spawnPoint == null)
                {
                    if (activeIndex >= _state.Count)
                    {
                        activeIndex = 0;
                        return false;
                    }

                    var currentPoint = _state.at[activeIndex];

                    if (currentPoint.Count < limit)
                    {
                        spawnPoint = currentPoint;

                        if (spawnPoint.root == null)
                        {
                            var subRoot = GetSpawnPointTransform(spawnPoint.point);
                            spawnPoint.root = subRoot.transform;
                        }

                        return true;
                    }

                    activeIndex += 1;
                }

                return false;
            }
        }

        private static readonly ProfilerMarker _PRF_SpawnMany = new ProfilerMarker(_PRF_PFX + nameof(SpawnMany));
        public int SpawnMany(
            int limit,
            RandomPrefabSet set,
            PrefabSpawnSettings settings,
            ref Bounds bounds,
            PrefabSpawnerRigidbodyManager rigidbodyManager,
            int spawnCount = 0)
        {
            using (_PRF_SpawnMany.Auto())
            {
                if (spawnCount == 0)
                {
                    spawnCount = limit;
                }

                var spawned = 0;

                if (!TryGetActiveSpawnPoint(limit, out var spawnPoint))
                {
                    return spawned;
                }

                while ((spawnPoint != null) && (spawned < spawnCount))
                {
                    if (spawnPoint.EligibleForActivation(limit))
                    {
                        var s = spawnPoint.Spawn(set, rigidbodyManager, settings);

                        if (bounds == default)
                        {
                            bounds.center = s.transform.position;
                            bounds.size = Vector3.one;
                        }
                        else
                        {
                            bounds.Encapsulate(s.transform.position);
                        }

                        spawned += 1;
                    }
                    else
                    {
                        if (!TryGetActiveSpawnPoint(limit, out spawnPoint))
                        {
                            return spawned;
                        }
                    }
                }

                return spawned;
            }
        }

        private static readonly ProfilerMarker _PRF_CanFinalize = new ProfilerMarker(_PRF_PFX + nameof(CanFinalize));
        public bool CanFinalize(PrefabSpawnerRigidbodyManager rigidbodyManager, int limit)
        {
            using (_PRF_CanFinalize.Auto())
            {
                if (rigidbodyManager.ActiveCount > 0)
                {
                    return false;
                }

                for (var i = 0; i < _state.Count; i++)
                {
                    var point = _state.at[i];

                    if (!point.CanFinalize(limit))
                    {
                        return false;
                    }
                }

                return true;
            }
        }

        private static readonly ProfilerMarker _PRF_ExecutePreFinalization = new ProfilerMarker(_PRF_PFX + nameof(ExecutePreFinalization));
        public void ExecutePreFinalization(RandomPrefabSet set)
        {
            using (_PRF_ExecutePreFinalization.Auto())
            {
                /*if (set.transformData.enableBurying ||
                    set.spawnablePrefabs.Any(sp => sp.overridePositioning && sp.transformOverrideData.enableBurying))
                {
                    finalized = false;
                    MeshBurialManagementProcessor.EnqueuePrefabSpawnPointCollection(this);
                }
                else*/
                {
                    finalized = true;
                }
            }
        }

        private static readonly ProfilerMarker _PRF_ReadyToFinalize = new ProfilerMarker(_PRF_PFX + nameof(ReadyToFinalize));
        public bool ReadyToFinalize()
        {
            using (_PRF_ReadyToFinalize.Auto())
            {
                if (finalized)
                {
                    return true;
                }

                var points = _state.Count;

                for (var i = 0; i < points; i++)
                {
                    var point = _state.at[i];

                    if (point.buryQueued && !point.buried)
                    {
                        return false;
                    }
                }

                finalized = true;
                return true;
            }
        }

        private static readonly ProfilerMarker _PRF_FinalizeSpawning = new ProfilerMarker(_PRF_PFX + nameof(FinalizeSpawning));
        public Matrix4x4[] FinalizeSpawning(bool destroy)
        {
            using (_PRF_FinalizeSpawning.Auto())
            {
                RemoveNulls();

                var count = 0;

                for (var i = 0; i < _state.Count; i++)
                {
                    var spawnPoint = _state.at[i];
                    count += spawnPoint.Count;
                }

                var array = new Matrix4x4[count];

                var step = 0;

                for (var i = 0; i < _state.Count; i++)
                {
                    var spawnPoint = _state.at[i];
                    var instanceCount = spawnPoint.Count;

                    for (var j = 0; j < instanceCount; j++)
                    {
                        var spawn = spawnPoint.spawnedObjects[j];

                        array[step + j] = spawn.transform.localToWorldMatrix;
                    }

                    if (destroy)
                    {
                        spawnPoint.DestroyInstances();
                    }

                    step += instanceCount;
                }

                if (destroy)
                {
                    _state.Clear();
                    completed = true;
                }

                return array;
            }
        }
    }
}
