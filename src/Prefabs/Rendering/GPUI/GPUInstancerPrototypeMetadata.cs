#region

using System;
using System.Collections.Generic;
using Appalachia.CI.Integration.Assets;
using Appalachia.CI.Integration.FileSystem;
using Appalachia.Core.Objects.Scriptables;
using Appalachia.Simulation.Core;
using Appalachia.Utility.Execution;
using Appalachia.Utility.Extensions;
using Appalachia.Utility.Strings;
using GPUInstancer;
using Unity.Profiling;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.GPUI
{
    [Serializable]
    public class GPUInstancerPrototypeMetadata : IdentifiableAppalachiaObject<GPUInstancerPrototypeMetadata>
    {
        #region Profiling And Tracing Markers

        private const string _PRF_PFX = nameof(GPUInstancerPrototypeMetadata) + ".";

#if UNITY_EDITOR
        private static readonly ProfilerMarker _PRF_CreatePrototypeIfNecessary =
            new(_PRF_PFX + nameof(CreatePrototypeIfNecessary));

        private static readonly ProfilerMarker _PRF_CreatePrototypeIfNecessary_PrototypeLookup =
            new(_PRF_PFX + nameof(CreatePrototypeIfNecessary) + ".PrototypeLookup");
#endif

        #endregion
        public bool hasRigidBody;

        public RigidbodyData rigidbodyData;

        [SerializeField] private GameObject _originalPrefab;

        [SerializeField] private GameObject _updatedPrefab;

        [SerializeField] private GPUInstancerPrefabPrototype _prototype;

        [SerializeField] private string _prefabHashForNoGoGeneration;
        public GameObject originalPrefab => _originalPrefab;
        public GameObject updatedPrefab => _updatedPrefab;

        public GPUInstancerPrefabPrototype prototype => _prototype;

        public void SetPrefab(GameObject original)
        {
            _originalPrefab = original;
        }

        public void SetPrototype(GPUInstancerPrefabPrototype proto)
        {
            _prototype = proto;
        }

#if UNITY_EDITOR
        public void CreatePrototypeIfNecessary(
            GameObject ogPF,
            GPUInstancerPrefabManager gpui,
            Dictionary<GPUInstancerPrefabPrototype, RegisteredPrefabsData> prototypeLookup)
        {
            using (_PRF_CreatePrototypeIfNecessary.Auto())
            {
                _originalPrefab = ogPF;

                if (_originalPrefab == null)
                {
                    var prototypeName = _prototype == null ? "UNNAMED" : _prototype.name;

                    throw new NotSupportedException(
                        ZString.Format("Prototype [{0}] has no prefab!", prototypeName)
                    );
                }

                var rigidbody = _originalPrefab.GetComponent<Rigidbody>();

                hasRigidBody = rigidbody != null;
                if (hasRigidBody)
                {
                    rigidbodyData = new RigidbodyData(rigidbody);
                }

                if (_updatedPrefab == null)
                {
                    _updatedPrefab = CreateNOGOPrefab();

                    AssetDatabaseManager.TryGetGUIDAndLocalFileIdentifier(
                        _originalPrefab,
                        out _prefabHashForNoGoGeneration,
                        out var _
                    );
                }
                else
                {
                    AssetDatabaseManager.TryGetGUIDAndLocalFileIdentifier(
                        _originalPrefab,
                        out var guid,
                        out var _
                    );

                    if (guid != _prefabHashForNoGoGeneration)
                    {
                        _prefabHashForNoGoGeneration = guid;
                        _updatedPrefab = CreateNOGOPrefab();
                    }
                }

                if (_prototype == null)
                {
                    foreach (var proto in gpui.prototypeList)
                    {
                        if (proto.prefabObject == _updatedPrefab)
                        {
                            _prototype = proto as GPUInstancerPrefabPrototype;
                        }
                    }
                }

                if ((_prototype == null) || (_prototype.prefabObject != _updatedPrefab))
                {
                    _prototype = GPUInstancerUtility.GeneratePrefabPrototype(_updatedPrefab, false);
                }

                using (_PRF_CreatePrototypeIfNecessary_PrototypeLookup.Auto())
                {
                    if (!prototypeLookup.ContainsKey(prototype))
                    {
                        gpui.prototypeList.Add(prototype);

                        gpui.prefabs.Add(prototype.prefabObject);
                        prototypeLookup.Add(prototype, null);
                    }

                    var goRegisteredPrefabs = prototypeLookup[prototype];

                    if (goRegisteredPrefabs == null)
                    {
                        goRegisteredPrefabs = new RegisteredPrefabsData(prototype);
                        gpui.registeredPrefabInstances.AddOrUpdate(prototype, goRegisteredPrefabs);
                        prototypeLookup[prototype] = goRegisteredPrefabs;
                    }

                    goRegisteredPrefabs.registeredPrefabs.Clear();
                }
            }
        }

        private static readonly ProfilerMarker _PRF_CreateNOGOPrefab =
            new(_PRF_PFX + nameof(CreateNOGOPrefab));

        private GameObject CreateNOGOPrefab()
        {
            using (_PRF_CreateNOGOPrefab.Auto())
            {
                var modified = UnityEditor.PrefabUtility.InstantiatePrefab(_originalPrefab) as GameObject;

                if (modified == null)
                {
                    throw new NotSupportedException();
                }

                var components = modified.GetComponentsInChildren<Component>();

                for (var i = 0; i < components.Length; i++)
                {
                    var component = components[i];

                    if (component is Renderer ||
                        component is MeshFilter ||
                        component is Transform ||
                        component is LODGroup)
                    {
                    }
                    else
                    {
                        if (AppalachiaApplication.IsPlayingOrWillPlay)
                        {
                            Destroy(component);
                        }
                        else
                        {
                            DestroyImmediate(component);
                        }
                    }
                }

                /*void RemoveEmptyGameObjects(GameObject go)
                {
                    for (var i = go.transform.childCount - 1; i >= 0; i--)
                    {
                        var child = go.transform.GetChild(i);

                        if (child.childCount > 0)
                        {
                            RemoveEmptyGameObjects(child.gameObject);
                        }

                        if (child.childCount == 0)
                        {
                            var comps = child.GetComponents<Component>();

                            if (comps.Length == 1)
                            {
                                child.gameObject.DestroyAppropriately();
                            }
                        }
                    }
                }

                RemoveEmptyGameObjects(modified);*/

                var existingPath = AssetDatabaseManager.GetAssetPath(_originalPrefab);
                var fileName = AppaPath.GetFileNameWithoutExtension(existingPath);
                var directory = AppaPath.GetDirectoryName(existingPath);
                var extension = AppaPath.GetExtension(existingPath);

                var subDirectory = ZString.Format("{0}_NGO", directory);

                AppaDirectory.CreateDirectory(subDirectory);

                var newPath = ZString.Format("{0}/{1}_NGO{2}", subDirectory, fileName, extension);

                var result = UnityEditor.PrefabUtility.SaveAsPrefabAsset(modified, newPath);

                modified.DestroySafely();

                return result;
            }
        }
#endif
    }
}