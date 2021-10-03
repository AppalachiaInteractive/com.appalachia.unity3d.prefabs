#region

using System;
using System.Collections.Generic;
using Appalachia.Core.Extensions;
using Appalachia.Core.Scriptables;
using Appalachia.Core.Spawning.Data;
using GPUInstancer;
using Unity.Profiling;
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
using System.IO;

#endif

#endregion

namespace Appalachia.Core.Rendering.Metadata.GPUI
{
    [Serializable]
    public class GPUInstancerPrototypeMetadata : SelfSavingAndIdentifyingScriptableObject<GPUInstancerPrototypeMetadata>
    {
        private const string _PRF_PFX = nameof(GPUInstancerPrototypeMetadata) + ".";
        
        [SerializeField] private GameObject _originalPrefab;

        [SerializeField] private GameObject _updatedPrefab;

        [SerializeField] private string _prefabHashForNoGoGeneration;

        [SerializeField] private GPUInstancerPrefabPrototype _prototype;

        public bool hasRigidBody;
        public RigidbodyData rigidbodyData;

        public GPUInstancerPrefabPrototype prototype => _prototype;
        public GameObject originalPrefab => _originalPrefab;
        public GameObject updatedPrefab => _updatedPrefab;

        private static readonly ProfilerMarker _PRF_CreatePrototypeIfNecessary = new ProfilerMarker(_PRF_PFX + nameof(CreatePrototypeIfNecessary));

        private static readonly ProfilerMarker _PRF_CreatePrototypeIfNecessary_PrototypeLookup = new ProfilerMarker(_PRF_PFX + nameof(CreatePrototypeIfNecessary) + ".PrototypeLookup");
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
                    var name = _prototype == null ? "UNNAMED" : _prototype.name;

                    throw new NotSupportedException($"Prototype [{name}] has no prefab!");
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

                    AssetDatabase.TryGetGUIDAndLocalFileIdentifier(_originalPrefab, out _prefabHashForNoGoGeneration, out long _);
                }
                else
                {
                    AssetDatabase.TryGetGUIDAndLocalFileIdentifier(_originalPrefab, out var guid, out long _);

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

        private static readonly ProfilerMarker _PRF_CreateNOGOPrefab = new ProfilerMarker(_PRF_PFX + nameof(CreateNOGOPrefab));
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

                    if (component is Renderer || component is MeshFilter || component is Transform || component is LODGroup)
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

                var existingPath = AssetDatabase.GetAssetPath(_originalPrefab);
                var fileName = Path.GetFileNameWithoutExtension(existingPath);
                var directory = Path.GetDirectoryName(existingPath);
                var extension = Path.GetExtension(existingPath);

                var subDirectory = $"{directory}_NGO";

                Directory.CreateDirectory(subDirectory);

                var newPath = $"{subDirectory}/{fileName}_NGO{extension}";

                var result = PrefabUtility.SaveAsPrefabAsset(modified, newPath);

                modified.DestroySafely();

                return result;
            }
        }
#endif
    }
}
