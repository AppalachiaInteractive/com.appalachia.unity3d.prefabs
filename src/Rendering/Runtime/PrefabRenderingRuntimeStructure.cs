#region

using System;
using System.Collections.Generic;
using UnityEngine;

#endregion

namespace Appalachia.Prefabs.Rendering.Runtime
{
    [Serializable]
    public class PrefabRenderingRuntimeStructure
    {
        public GameObject instanceRoot;

        [NonSerialized] private Dictionary<string, GameObject> prefabLookup;

        public GameObject FindRootForPrefab(GameObject go)
        {
            if (instanceRoot == null)
            {
                PrefabRenderingManager.instance.InitializeStructureInPlace(this);
            }

            if (instanceRoot == null)
            {
                return null;
            }

            if (prefabLookup == null)
            {
                prefabLookup = new Dictionary<string, GameObject>();
            }

            if (prefabLookup.TryGetValue(go.name, out var result))
            {
                if (result == null)
                {
                    prefabLookup.Remove(go.name);
                }
                else
                {
                    return result;
                }
            }

            if (!prefabLookup.ContainsKey(go.name))
            {
                ValidateLookup();
            }

            if (prefabLookup.TryGetValue(go.name, out result))
            {
                return result;
            }

            var newGO = new GameObject(go.name);
            newGO.hideFlags |= HideFlags.HideInHierarchy;

            newGO.transform.SetParent(instanceRoot.transform);

            prefabLookup.Add(newGO.name, newGO);

            return newGO;
        }

        private void ValidateLookup()
        {
            for (var i = 0; i < instanceRoot.transform.childCount; i++)
            {
                var child = instanceRoot.transform.GetChild(i);

                if (prefabLookup.ContainsKey(child.gameObject.name))
                {
                    continue;
                }

                var gameObject = child.gameObject;
                prefabLookup.Add(gameObject.name, gameObject);
            }
        }
    }
}
