#region

using System;
using System.Collections.Generic;
using Appalachia.Core.Extensions;
using Appalachia.Editing.Attributes;
using Appalachia.Prefabs.Rendering;
using AwesomeTechnologies.VegetationStudio;
using AwesomeTechnologies.VegetationSystem;
using Sirenix.OdinInspector;
using UnityEditor;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.Serialization;

#endregion

namespace Appalachia.Prefabs.Spawning.Data
{
    [Serializable]
    public class RandomPrefabSpawnSource
    {
        [ToggleLeft]
        [HorizontalGroup("A", .05f), SmartLabel, LabelText(" Enabled")]
        public bool enabled = true;

        [HorizontalGroup("A", .4f), SmartLabel, LabelText(" Type")]
        public RandomPrefabSpawnerType spawnerType;

        [PropertyRange(0f, 15f)]
        [HorizontalGroup("A", .55f), SmartLabel, LabelText(" Density")]
        [EnableIf(nameof(enabled))]
        public float instanceDensity = 1.0f;

        [AssetsOnly, ShowIf(nameof(_showPrefab)), SmartLabel]
        public GameObject prefab;

        [SceneObjectsOnly, ShowIf(nameof(_showSceneObject)), SmartLabel]
        public GameObject sceneObject;

        private ValueDropdownList<string> _vegetationItemList;

        [FormerlySerializedAs("package")]
        [ShowIf(nameof(_showVegetationpackageSelection)), SmartLabel]
        public VegetationPackagePro vegetationPackage;

        [ValueDropdown(nameof(GetVegetationItems)), ShowIf(nameof(_showVegetationItem)), SmartLabel]
        public string vegetationItemID;

        [ShowIf(nameof(_showPrefabRenderingSet)), SmartLabel]
        public PrefabRenderingSet prefabRenderingSet;

        private bool _pendingReset;

        private PrefabRenderingManager _prefabRenderingManager;

        private VegetationSystemPro _vegetationSystem;
        private bool _showPrefab => spawnerType == RandomPrefabSpawnerType.Prefab;

        private bool _showSceneObject => spawnerType == RandomPrefabSpawnerType.SceneObject;

        private bool _showVegetationPackage => spawnerType == RandomPrefabSpawnerType.VegetationPackage;

        private bool _showVegetationItem => spawnerType == RandomPrefabSpawnerType.VegetationItem;

        private bool _showVegetationpackageSelection => _showVegetationPackage || _showVegetationItem;

        private bool _showPrefabRenderingSet => spawnerType == RandomPrefabSpawnerType.PrefabRenderingSet;

        public bool PendingReset
        {
            get => _pendingReset;
            set => _pendingReset = value;
        }

        private ValueDropdownList<string> GetVegetationItems()
        {
            if (_vegetationItemList == null)
            {
                _vegetationItemList = new ValueDropdownList<string>();
            }

            if (vegetationPackage == null)
            {
                return _vegetationItemList;
            }

            if (vegetationPackage.VegetationInfoList.Count != _vegetationItemList.Count)
            {
                _vegetationItemList.Clear();

                for (var i = 0; i < vegetationPackage.VegetationInfoList.Count; i++)
                {
                    var item = vegetationPackage.VegetationInfoList[i];

                    _vegetationItemList.Add(item.Name, item.VegetationItemID);
                }
            }

            return _vegetationItemList;
        }

        /*public GameObject GetPrefab()
        {
            switch (spawnerType)
            {
                case RandomPrefabSpawnerType.Prefab:
                    return prefab;
                case RandomPrefabSpawnerType.SceneObject:
                    return sceneObject;
                case RandomPrefabSpawnerType.VegetationItem:
                    return package.GetVegetationInfo(vegetationItemID)?.VegetationPrefab;
                case RandomPrefabSpawnerType.PrefabRenderingSet:
                    return prefabRenderingSet.prefab;
                case RandomPrefabSpawnerType.VegetationPackage:
                    break;
                default:
                    throw new ArgumentOutOfRangeException();
            }
        }*/

        public string GetKey()
        {
            switch (spawnerType)
            {
                case RandomPrefabSpawnerType.Prefab:
                    return $"PREFAB_RPSE_{prefab.name}";
                case RandomPrefabSpawnerType.SceneObject:
                    return $"SCENE_RPSE_{sceneObject.name}";
                case RandomPrefabSpawnerType.VegetationPackage:
                    return $"VEG-P_RPSE_{vegetationPackage.name}";
                case RandomPrefabSpawnerType.VegetationItem:
                    return $"VEG-I_RPSE_{vegetationItemID}";
                case RandomPrefabSpawnerType.PrefabRenderingSet:
                    return $"PRE-REN-SET_RPSE_{prefabRenderingSet.name}";
                default:
                    throw new ArgumentOutOfRangeException();
            }
        }

        [Button]
        public void Reset()
        {
            _pendingReset = true;
        }

        public int GetSpawnPointCount()
        {
            switch (spawnerType)
            {
                case RandomPrefabSpawnerType.Prefab:
                {
                    if (prefab == null)
                    {
                        return 0;
                    }

                    var sum = 0;
                    var path = AssetDatabase.GetAssetPath(prefab);

                    for (var i = 0; i < SceneManager.sceneCount; i++)
                    {
                        var scene = SceneManager.GetSceneAt(i);

                        var roots = scene.GetRootGameObjects();

                        foreach (var root in roots)
                        {
                            sum += GetPrefabInstanceCountsRecursive(root, path);
                        }
                    }

                    return sum;
                }
                case RandomPrefabSpawnerType.SceneObject:
                {
                    if (sceneObject == null)
                    {
                        return 0;
                    }

                    return 1;
                }
                case RandomPrefabSpawnerType.VegetationPackage:
                {
                    if (vegetationPackage == null)
                    {
                        return 0;
                    }

                    var system = GetVegetationSystem();

                    var sum = 0;

                    var packageIndex = -1;

                    for (var i = 0; i < system.VegetationPackageProList.Count; i++)
                    {
                        if (vegetationPackage == system.VegetationPackageProList[i])
                        {
                            packageIndex = i;
                            break;
                        }
                    }

                    if (packageIndex == -1)
                    {
                        return 0;
                    }

                    for (var i = 0; i < system.VegetationCellList.Count; i++)
                    {
                        var cell = system.VegetationCellList[i];

                        var packageInstances = cell.VegetationPackageInstancesList[packageIndex];

                        var matrixLists = packageInstances.VegetationItemMatrixList;

                        for (var k = 0; k < matrixLists.Count; k++)
                        {
                            var matrixList = matrixLists[k];

                            sum += matrixList.Length;
                        }
                    }

                    return sum;
                }
                case RandomPrefabSpawnerType.VegetationItem:
                {
                    if (vegetationPackage == null)
                    {
                        return 0;
                    }

                    var system = GetVegetationSystem();

                    var sum = 0;

                    var packageIndex = -1;
                    var veggieIndex = -1;

                    for (var i = 0; i < system.VegetationPackageProList.Count; i++)
                    {
                        if (vegetationPackage == system.VegetationPackageProList[i])
                        {
                            packageIndex = i;

                            for (var j = 0; j < vegetationPackage.VegetationInfoList.Count; j++)
                            {
                                if (vegetationItemID == vegetationPackage.VegetationInfoList[j].VegetationItemID)
                                {
                                    veggieIndex = j;
                                    break;
                                }
                            }

                            break;
                        }
                    }

                    if ((packageIndex == -1) || (veggieIndex == -1))
                    {
                        return 0;
                    }

                    for (var i = 0; i < system.VegetationCellList.Count; i++)
                    {
                        var cell = system.VegetationCellList[i];

                        var packageInstances = cell.VegetationPackageInstancesList[packageIndex];

                        var matrixList = packageInstances.VegetationItemMatrixList[veggieIndex];

                        sum += matrixList.Length;
                    }

                    return sum;
                }
                case RandomPrefabSpawnerType.PrefabRenderingSet:
                {
                    if (prefabRenderingSet == null)
                    {
                        return 0;
                    }

                    return prefabRenderingSet.instanceManager.element.Count;
                }
                default:
                    throw new ArgumentOutOfRangeException();
            }
        }

        public IEnumerable<Vector3> GetSpawnPoints()
        {
            switch (spawnerType)
            {
                case RandomPrefabSpawnerType.Prefab:
                {
                    var path = AssetDatabase.GetAssetPath(prefab);

                    for (var i = 0; i < SceneManager.sceneCount; i++)
                    {
                        var scene = SceneManager.GetSceneAt(i);

                        var roots = scene.GetRootGameObjects();

                        foreach (var root in roots)
                        {
                            var rootInstances = GetPrefabInstancesRecursive(root, path);

                            foreach (var rootInstance in rootInstances)
                            {
                                yield return rootInstance;
                            }
                        }
                    }
                }
                    break;
                case RandomPrefabSpawnerType.SceneObject:
                {
                    yield return sceneObject.transform.position;
                }
                    break;
                case RandomPrefabSpawnerType.VegetationPackage:
                {
                    var system = GetVegetationSystem();

                    var packageIndex = -1;

                    for (var i = 0; i < system.VegetationPackageProList.Count; i++)
                    {
                        if (vegetationPackage == system.VegetationPackageProList[i])
                        {
                            packageIndex = i;
                            break;
                        }
                    }

                    for (var i = 0; i < system.VegetationCellList.Count; i++)
                    {
                        var cell = system.VegetationCellList[i];

                        var packageInstances = cell.VegetationPackageInstancesList[packageIndex];

                        var matrixLists = packageInstances.VegetationItemMatrixList;

                        for (var k = 0; k < matrixLists.Count; k++)
                        {
                            var matrixList = matrixLists[k];

                            for (var l = 0; l < matrixList.Length; l++)
                            {
                                yield return matrixList[l].Matrix.GetPositionFromMatrix();
                            }
                        }
                    }
                }
                    break;
                case RandomPrefabSpawnerType.VegetationItem:
                {
                    var system = GetVegetationSystem();

                    var packageIndex = -1;
                    var veggieIndex = -1;

                    for (var i = 0; i < system.VegetationPackageProList.Count; i++)
                    {
                        if (vegetationPackage == system.VegetationPackageProList[i])
                        {
                            packageIndex = i;

                            for (var j = 0; j < vegetationPackage.VegetationInfoList.Count; j++)
                            {
                                if (vegetationItemID == vegetationPackage.VegetationInfoList[j].VegetationItemID)
                                {
                                    veggieIndex = j;
                                    break;
                                }
                            }

                            break;
                        }
                    }

                    for (var i = 0; i < system.VegetationCellList.Count; i++)
                    {
                        var cell = system.VegetationCellList[i];

                        var packageInstances = cell.VegetationPackageInstancesList[packageIndex];

                        var matrixList = packageInstances.VegetationItemMatrixList[veggieIndex];

                        for (var l = 0; l < matrixList.Length; l++)
                        {
                            yield return matrixList[l].Matrix.GetPositionFromMatrix();
                        }
                    }
                }
                    break;
                case RandomPrefabSpawnerType.PrefabRenderingSet:
                {
                    for (var i = 0; i < prefabRenderingSet.instanceManager.element.positions.Length; i++)
                    {
                        yield return prefabRenderingSet.instanceManager.element.positions[i];
                    }
                }
                    break;
                default:
                    throw new ArgumentOutOfRangeException();
            }
        }

        private PrefabRenderingManager GetPrefabRenderingManager()
        {
            if (_prefabRenderingManager != null)
            {
                if (!_prefabRenderingManager.enabled || !_prefabRenderingManager.gameObject.activeInHierarchy)
                {
                    return null;
                }

                return _prefabRenderingManager;
            }

            _prefabRenderingManager = PrefabRenderingManager.instance;

            if (!_prefabRenderingManager.enabled || !_prefabRenderingManager.gameObject.activeInHierarchy)
            {
                return null;
            }

            return _prefabRenderingManager;
        }

        private VegetationSystemPro GetVegetationSystem()
        {
            if (_vegetationSystem != null)
            {
                if (!_vegetationSystem.enabled || !_vegetationSystem.gameObject.activeInHierarchy)
                {
                    return null;
                }

                return _vegetationSystem;
            }

            var instance = VegetationStudioManager.Instance;

            if (instance.VegetationSystemList.Count == 0)
            {
                return null;
            }

            _vegetationSystem = instance.VegetationSystemList[0];

            if (!_vegetationSystem.enabled || !_vegetationSystem.gameObject.activeInHierarchy)
            {
                return null;
            }

            return _vegetationSystem;
        }

        private int GetPrefabInstanceCountsRecursive(GameObject root, string assetSearch)
        {
            if (PrefabUtility.IsAnyPrefabInstanceRoot(root))
            {
                var asset = PrefabUtility.GetPrefabAssetPathOfNearestInstanceRoot(root);

                if (asset == assetSearch)
                {
                    return 1;
                }
            }

            var sum = 0;

            for (var i = 0; i < root.transform.childCount; i++)
            {
                var child = root.transform.GetChild(i).gameObject;
                sum += GetPrefabInstanceCountsRecursive(child, assetSearch);
            }

            return sum;
        }

        private IEnumerable<Vector3> GetPrefabInstancesRecursive(GameObject root, string assetSearch)
        {
            if (PrefabUtility.IsAnyPrefabInstanceRoot(root))
            {
                var asset = PrefabUtility.GetPrefabAssetPathOfNearestInstanceRoot(root);

                if (asset == assetSearch)
                {
                    yield return root.transform.position;
                }
            }

            for (var i = 0; i < root.transform.childCount; i++)
            {
                var child = root.transform.GetChild(i).gameObject;
                var ret = GetPrefabInstancesRecursive(child, assetSearch);

                foreach (var r in ret)
                {
                    yield return r;
                }
            }
        }
    }
}
