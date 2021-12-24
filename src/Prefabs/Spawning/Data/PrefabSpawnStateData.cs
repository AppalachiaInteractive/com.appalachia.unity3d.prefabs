#region

using System;
using Appalachia.Core.Collections.Interfaces;
using Appalachia.Core.Objects.Root;
using Appalachia.Rendering.Prefabs.Spawning.Collections;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Spawning.Data
{
    [Serializable]
    public class PrefabSpawnStateData : AppalachiaSimpleBase
    {
        public RandomPrefabSpawnSource spawnSource;

        public RandomPrefabSetElement setElement;

        [SerializeField]
        [ListDrawerSettings(
            Expanded = true,
            DraggableItems = false,
            HideAddButton = true,
            HideRemoveButton = true,
            NumberOfItemsPerPage = 2
        )]
        private PrefabSpawnPointCollectionLookup _state;

        public PrefabSpawnStateData(
            RandomPrefabSpawnSource spawnSource,
            RandomPrefabSetElement setElement)
        {
            this.spawnSource = spawnSource;
            this.setElement = setElement;

            _state = new PrefabSpawnPointCollectionLookup();
        }

        public IAppaLookup<string, PrefabSpawnPointCollection, AppaList_PrefabSpawnPointCollection>
            State
        {
            get
            {
                if (_state == null)
                {
                    _state = new PrefabSpawnPointCollectionLookup();
                }

                return _state;
            }
        }

        public void InitializeSpawnPointCollections()
        {
            var prefabKey = spawnSource.GetKey();

            _state.AddOrUpdateIf(
                prefabKey,
                () => new PrefabSpawnPointCollection(FindOrCreateRoot(prefabKey), prefabKey),
                val => val == null
            );

            for (var i = 0; i < _state.Count; i++)
            {
                var prefabSpawnPointCollection = _state.at[i];

                if (prefabSpawnPointCollection.root == null)
                {
                    prefabSpawnPointCollection.root = FindOrCreateRoot(prefabKey);
                }
            }
        }

        private Transform FindOrCreateRoot(string prefabKey)
        {
            if (string.IsNullOrWhiteSpace(prefabKey))
            {
                prefabKey = spawnSource.GetKey();
            }

            var root = setElement.setTransform.Find(prefabKey);

            if (root == null)
            {
                var goRoot = new GameObject(prefabKey);
                goRoot.transform.SetParent(setElement.setTransform, false);
                root = goRoot.transform;
            }

            return root;
        }

        public void UpdateSpawnPoints()
        {
            for (var i = 0; i < _state.Count; i++)
            {
                var element = _state.at[i];

                element.UpdateSpawnPoints(spawnSource);
            }
        }
    }
}
