#region

using Appalachia.Rendering.Prefabs.Spawning.Data;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Spawning
{
    public static class RandomPrefabSpawnUtility
    {
        //private static Dictionary<GameObject, GameObject> _prefabInstanceLookup;

        public static RandomPrefabInstanceData GetPrefabInstance(
            Transform parent,
            GameObject prefab)
        {
#if UNITY_EDITOR
            var realInstance = UnityEditor.PrefabUtility.InstantiatePrefab(prefab, parent) as GameObject;
#else
            var realInstance = Object.Instantiate(prefab, parent);
#endif
            var instanceData = new RandomPrefabInstanceData(realInstance);

            return instanceData;
        }

        /*private static Dictionary<GameObject, GameObject> _prefabInstanceLookup;

        public static RandomPrefabInstanceData GetPrefabInstance(Transform parent, GameObject prefab)
        {
            if (_prefabInstanceLookup == null)
            {
                _prefabInstanceLookup = new Dictionary<GameObject, GameObject>();
            }

            RandomPrefabInstanceData instanceData;

            GameObject instanceTemplate;

            var contains = _prefabInstanceLookup.ContainsKey(prefab);
            GameObject value = null;

            if (contains)
            {
                value = _prefabInstanceLookup[prefab];
            }
            
            if (contains && value != null)
            {
                instanceTemplate = _prefabInstanceLookup[prefab];
            }
            else
            {
                if (contains)
                {
                    _prefabInstanceLookup.Remove(prefab);
                }
                
#if UNITY_EDITOR
                instanceTemplate = PrefabUtility.InstantiatePrefab(prefab) as GameObject;
#else
                instanceTemplate = Object.Instantiate(prefab) as GameObject;
#endif
                instanceTemplate.hideFlags = HideFlags.HideAndDontSave;
                instanceTemplate.SetActive(false);

                _prefabInstanceLookup.Add(prefab, instanceTemplate);
            }

            var realInstance = Object.Instantiate(instanceTemplate, parent, true);

            realInstance.hideFlags = HideFlags.None;

            realInstance.SetActive(true);

            instanceData = new RandomPrefabInstanceData(realInstance);

            return instanceData;
        }*/
    }
}
