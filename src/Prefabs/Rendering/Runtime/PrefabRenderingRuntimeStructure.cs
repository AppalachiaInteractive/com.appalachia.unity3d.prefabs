#region

using System;
using System.Collections.Generic;
using Appalachia.Core.Attributes;
using Appalachia.Core.Objects.Root;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Runtime
{
    [CallStaticConstructorInEditor]
    [Serializable]
    public class PrefabRenderingRuntimeStructure : AppalachiaSimpleBase
    {
        static PrefabRenderingRuntimeStructure()
        {
            PrefabRenderingManager.InstanceAvailable += i => _prefabRenderingManager = i;
        }

        #region Static Fields and Autoproperties

        private static PrefabRenderingManager _prefabRenderingManager;

        #endregion

        #region Fields and Autoproperties

        public GameObject instanceRoot;

        [NonSerialized] private Dictionary<string, GameObject> prefabLookup;

        #endregion

        public GameObject FindRootForPrefab(GameObject go)
        {
            if (instanceRoot == null)
            {
                _prefabRenderingManager.InitializeStructureInPlace(this);
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
