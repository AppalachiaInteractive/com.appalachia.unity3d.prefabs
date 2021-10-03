#region

using System;
using Appalachia.Core.Editing.Attributes;
using Appalachia.Core.Spawning.Sets;
using Appalachia.Core.Spawning.Settings;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Core.Spawning.Data
{
    [Serializable, SmartLabel]
    public class RandomPrefabSetCollectionState
    {
        [HideInInspector] public Transform parent;
        [HideInInspector] public Transform root;

        [InlineEditor] public RandomPrefabSetCollection collection;

        private SpawnDataIndex _spawnData;

        [HideInInspector] public float lastSpawnTime;

        public RandomPrefabSetCollectionState(Transform parent, RandomPrefabSetCollection collection)
        {
            this.collection = collection;

            _spawnData = new SpawnDataIndex();

            ConfirmStructure(parent);
        }

        public void ConfirmStructure(Transform p)
        {
            if ((p == null) && (root == null))
            {
                throw new NotSupportedException();
            }

            if ((p == null) && (root != null))
            {
                p = root.parent;
            }

            parent = p;

            if (root == null)
            {
                var rootGO = new GameObject(collection.profileName);
                root = rootGO.transform;

                root.transform.SetParent(parent, false);
            }
        }

        public PrefabSpawnPointCollection GetActive(out PrefabSpawnStateData spawnStateData, out int limit)
        {
            if (collection == null)
            {
                spawnStateData = null;
                limit = 0;
                return null;
            }

            ReconcileStateCollections();

            for (var i = 0; i < collection.prefabSets.Count; i++)
            {
                var setElement = collection.prefabSets[i];

                if (!setElement.enabled)
                {
                    continue;
                }

                for (var j = 0; j < collection.spawners.Count; j++)
                {
                    var spawnSource = collection.spawners[j];

                    if (!spawnSource.enabled)
                    {
                        continue;
                    }

                    var density = spawnSource.instanceDensity;
                    limit = (int) (setElement.spawnLimit * density);

                    var key = spawnSource.GetKey();

                    spawnStateData = _spawnData[setElement.set][key];

                    spawnStateData.InitializeSpawnPointCollections();
                    spawnStateData.UpdateSpawnPoints();

                    var clear = spawnStateData.spawnSource.PendingReset;

                    if (clear)
                    {
                        for (var k = 0; k < spawnStateData.State.Count; k++)
                        {
                            var prefabSpawnPointCollection = spawnStateData.State.at[k];

                            prefabSpawnPointCollection.DestroyInstances();
                        }
                    }

                    spawnStateData.spawnSource.PendingReset = false;

                    for (var k = 0; k < spawnStateData.State.Count; k++)
                    {
                        var prefabSpawnPointCollection = spawnStateData.State.at[k];

                        prefabSpawnPointCollection.FullCheck();

                        if (prefabSpawnPointCollection.EligibleForActivation(limit))
                        {
                            return prefabSpawnPointCollection;
                        }
                    }
                }
            }

            spawnStateData = null;
            limit = 0;
            return null;
        }

        private Transform GetElementSpawnPointTransform(RandomPrefabSetElement element)
        {
            if (element.setTransform != null)
            {
                return element.setTransform;
            }

            ConfirmStructure(parent);

            var subRoot = root.Find(element.set.profileName);

            if (subRoot == null)
            {
                Debug.Log($"{root.name}  ::  {element.set.profileName}");

                subRoot = new GameObject(element.set.profileName).transform;

                subRoot.SetParent(root, false);

                element.setTransform = subRoot;
            }

            return subRoot;
        }

        private void ReconcileStateCollections()
        {
            if (_spawnData == null)
            {
                _spawnData = new SpawnDataIndex();
            }

            for (var i = 0; i < collection.prefabSets.Count; i++)
            {
                var setElement = collection.prefabSets[i];

                if (!_spawnData.ContainsKey(setElement.set))
                {
                    _spawnData.Add(setElement.set, new PrefabSpawnStateDataLookup());
                }

                setElement.setTransform = GetElementSpawnPointTransform(setElement);

                for (var j = 0; j < collection.spawners.Count; j++)
                {
                    var spawner = collection.spawners[j];
                    var key = spawner.GetKey();

                    if (!_spawnData.ContainsKeys(setElement.set, key))
                    {
                        _spawnData.AddOrUpdate(setElement.set, key, new PrefabSpawnStateData(spawner, setElement));
                    }
                }
            }
        }

        public void SpawnMany(PrefabSpawnSettings settings, PrefabSpawnerRigidbodyManager rigidbodyManager, int count, ref Bounds bounds)
        {
            var pointCollection = GetActive(out var spawnerData, out var limit);

            if (pointCollection == null)
            {
                return;
            }

            var spawned = 0;

            while (spawned < count)
            {
                if (!pointCollection.EligibleForActivation(limit))
                {
                    pointCollection = GetActive(out spawnerData, out limit);

                    if (pointCollection == null)
                    {
                        break;
                    }
                }

                var remaining = count - spawned;

                spawned += pointCollection.SpawnMany(limit, spawnerData.setElement.set, settings, ref bounds, rigidbodyManager, remaining);
            }
        }
    }
}
