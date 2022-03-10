#region

using System.Collections.Generic;
using System.Linq;
using Appalachia.Core.Math.Probability;
using Appalachia.Core.Objects.Scriptables;
using Appalachia.Rendering.Prefabs.Spawning.Data;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Spawning.Sets
{
    public class RandomPrefabSet : AutonamedIdentifiableAppalachiaObject<RandomPrefabSet>
    {
        #region Fields and Autoproperties

        [ListDrawerSettings(Expanded = true)]
        [PropertyOrder(11)]
        public List<RandomPrefab> spawnablePrefabs = new();

        public RandomTransformData transformData;

        [FoldoutGroup("Add Prefabs", Expanded = false)]
        [PropertyOrder(10)]
        public List<GameObject> addPrefabs = new();

        [HideInInspector] public ProbabilitySet probabilities = new();

        #endregion

#if UNITY_EDITOR
        /// <inheritdoc />
        protected override bool HideIDProperties => true;
#endif

        private bool _canAdd => (addPrefabs?.Count ?? 0) > 0;

        public GameObject GetNextPrefab(out RandomTransformData useTransformData)
        {
            ValidateProbabilities();

            var nextIndex = probabilities.GetNextIndex();
            var prefab = spawnablePrefabs[nextIndex];

            useTransformData = prefab.overridePositioning ? prefab.transformOverrideData : transformData;

            return prefab.prefab;
        }

        [FoldoutGroup("Add Prefabs", Expanded = false)]
        [Button]
        [EnableIf(nameof(_canAdd))]
        [PropertyOrder(9)]
        public void ProcessAdd()
        {
            if (addPrefabs == null)
            {
                addPrefabs = new List<GameObject>();
            }

            var existing = spawnablePrefabs.Select(sp => sp.prefab).ToHashSet();

            for (var index = 0; index < addPrefabs.Count; index++)
            {
                var prefab = addPrefabs[index];
                if (!existing.Contains(prefab))
                {
                    spawnablePrefabs.Add(new RandomPrefab { prefab = prefab });
                }
            }

            addPrefabs.Clear();
        }

        [OnInspectorGUI]
        public void ValidateProbabilities()
        {
            for (var i = spawnablePrefabs.Count - 1; i >= 0; i--)
            {
                if (spawnablePrefabs[i] == null)
                {
                    spawnablePrefabs.RemoveAt(i);
                }
            }

            if (probabilities == null)
            {
                probabilities = new ProbabilitySet();
            }

            probabilities.ValidateProbabilities(spawnablePrefabs);
        }
    }
}
