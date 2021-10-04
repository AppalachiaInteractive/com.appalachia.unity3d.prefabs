#region

using System.Collections.Generic;
using System.Linq;
using Appalachia.Base.Scriptables;
using Appalachia.Core.Extensions;
using Appalachia.Core.Math.Probability;
using Appalachia.Prefabs.Spawning.Data;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Prefabs.Spawning.Sets
{
    public class RandomPrefabSet : SelfNamingSavingAndIdentifyingScriptableObject<RandomPrefabSet>
    {
        [ListDrawerSettings(Expanded = true)]
        [PropertyOrder(11)]
        public List<RandomPrefab> spawnablePrefabs = new();

        public RandomTransformData transformData;

        [FoldoutGroup("Add Prefabs", Expanded = false)]
        [PropertyOrder(10)]
        public List<GameObject> addPrefabs = new();

        [HideInInspector] public ProbabilitySet probabilities = new();

        protected override bool ShowIDProperties => false;

        private bool _canAdd => (addPrefabs?.Count ?? 0) > 0;

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

            var existing = spawnablePrefabs.Select(sp => sp.prefab).ToHashSet2();

            for (var index = 0; index < addPrefabs.Count; index++)
            {
                var prefab = addPrefabs[index];
                if (!existing.Contains(prefab))
                {
                    spawnablePrefabs.Add(new RandomPrefab {prefab = prefab});
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

        public GameObject GetNextPrefab(out RandomTransformData useTransformData)
        {
            ValidateProbabilities();

            var nextIndex = probabilities.GetNextIndex();
            var prefab = spawnablePrefabs[nextIndex];

            useTransformData = prefab.overridePositioning
                ? prefab.transformOverrideData
                : transformData;

            return prefab.prefab;
        }
    }
}
