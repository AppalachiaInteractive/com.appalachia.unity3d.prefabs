#region

using System;
using System.Collections.Generic;
using Appalachia.CI.Integration;
using Appalachia.CI.Integration.Assets;
using Appalachia.CI.Integration.FileSystem;
using Appalachia.Core.Extensions;
using Appalachia.Core.Scriptables;
using Appalachia.Simulation.Core;
using GPUInstancer;
using Unity.Profiling;
using UnityEditor;
using UnityEngine;

#if UNITY_EDITOR

#endif

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.GPUI
{
    [Serializable]
    public class GPUInstancerPrototypeMetadata : IdentifiableAppalachiaObject<
        GPUInstancerPrototypeMetadata>
    {
        private const string _PRF_PFX = nameof(GPUInstancerPrototypeMetadata) + ".";

        private static readonly ProfilerMarker _PRF_CreatePrototypeIfNecessary =
            new(_PRF_PFX + nameof(CreatePrototypeIfNecessary));

        private static readonly ProfilerMarker _PRF_CreatePrototypeIfNecessary_PrototypeLookup =
            new(_PRF_PFX + nameof(CreatePrototypeIfNecessary) + ".PrototypeLookup");

        [SerializeField] private GameObject _originalPrefab;

        [SerializeField] private GameObject _updatedPrefab;

        [SerializeField] private string _prefabHashForNoGoGeneration;

        [SerializeField] private GPUInstancerPrefabPrototype _prototype;

        public bool hasRigidBody;
        public RigidbodyData rigidbodyData;

        public GPUInstancerPrefabPrototype prototype => _prototype;
        public GameObject originalPrefab => _originalPrefab;
        public GameObject updatedPrefab => _updatedPrefab;

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

                    throw new NotSupportedException($"Prototype [{prototypeName}] has no prefab!");
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
                        out long _
                    );
                }
                else
                {
                    AssetDatabaseManager.TryGetGUIDAndLocalFileIdentifier(
                        _originalPrefab,
                        out var guid,
                        out long _
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

        public void SetPrefab(GameObject original)
        {
            _originalPrefab = original;
        }

        public void SetPrototype(GPUInstancerPrefabPrototype proto)
        {
            _prototype = proto;
        }

#if UNITY_EDITOR

        private static readonly ProfilerMarker _PRF_CreateNOGOPrefab =
            new(_PRF_PFX + nameof(CreateNOGOPrefab));

        private GameObject CreateNOGOPrefab()
        {
            using (_PRF_CreateNOGOPrefab.Auto())
            {
                var modified = PrefabUtility.InstantiatePrefab(_originalPrefab) as GameObject;

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
                        if (Application.isPlaying)
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

                var subDirectory = $"{directory}_NGO";

                AppaDirectory.CreateDirectory(subDirectory);

                var newPath = $"{subDirectory}/{fileName}_NGO{extension}";

                var result = PrefabUtility.SaveAsPrefabAsset(modified, newPath);

                modified.DestroySafely();

                return result;
            }
        }
#endif
    }
}
