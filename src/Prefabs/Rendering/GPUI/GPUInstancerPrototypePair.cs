/*using System;
using System.Collections.Generic;
using System.IO;
using GPUInstancer;
using Appalachia.Core.Extensions;
using Appalachia.Core.Globals.Serialization.ScriptableObjects;
using Appalachia.Core.Profiling;
using Sirenix.OdinInspector;
using UnityEditor;
using UnityEngine;

namespace Appalachia.Core.Rendering.Metadata.GPUI
{
    [Serializable]
    public class GPUInstancerPrototypePair : SelfSavingAndIdentifyingScriptableObject<GPUInstancerPrototypePair>
    {
        [SerializeField, InlineProperty] private GPUInstancerPrototypeMetadata _gameObject;
        [SerializeField, InlineProperty] private GPUInstancerPrototypeMetadata _noGameObject;

        [SerializeField] private string _prefabHashForNoGoGeneration;

        public GPUInstancerPrototypeMetadata gameObject => _gameObject;
        public GPUInstancerPrototypeMetadata noGameObject => _noGameObject;

        private void OnEnable()
        {
            if (_gameObject == null)
            {
                _gameObject = new GPUInstancerPrototypeMetadata();
                SetDirty();
            }
            if (_noGameObject == null)
            {
                _noGameObject = new GPUInstancerPrototypeMetadata();
                SetDirty();
            }
        }

        public void UpdatePrototypePair(
            GameObject prefab,
            GPUInstancerPrefabManager gpui,
            Dictionary<GPUInstancerPrefabPrototype, RegisteredPrefabsData> prototypeLookup)
        {
           
using (ASPECT.Many(ASPECT.Profile(), ASPECT.Trace()))
            {
                _gameObject.SetPrefab(prefab);

                if (_noGameObject == null || _noGameObject.prefab == null)
                {
                    var newPrefab = CreateNOGOPrefab();
                    _noGameObject.SetPrefab(newPrefab);
                    
                    AssetDatabase.TryGetGUIDAndLocalFileIdentifier(prefab, out _prefabHashForNoGoGeneration, out long _);
                }
                else
                {
                    AssetDatabase.TryGetGUIDAndLocalFileIdentifier(prefab, out var guid, out long _);

                    if (guid != _prefabHashForNoGoGeneration)
                    {
                        _prefabHashForNoGoGeneration = guid;
                        var newPrefab = CreateNOGOPrefab();
                        _noGameObject.SetPrefab(newPrefab);
                    }
                }

                AssignExistingPrototypes(gpui);

               
using (ASPECT.Many(ASPECT.Profile(), ASPECT.Trace()))
                {
                    _gameObject.CreatePrototypeIfNecessary(gpui, prototypeLookup);
                    _noGameObject.CreatePrototypeIfNecessary(gpui, prototypeLookup);
                }
            }
            
            SetDirty();
        }
        
        private void AssignExistingPrototypes(GPUInstancerPrefabManager gpui)
        {
           
using (ASPECT.Many(ASPECT.Profile(), ASPECT.Trace()))
            {
                foreach (var prototype in gpui.prototypeList)
                {
                    if (prototype.prefabObject == _gameObject.prefab)
                    {
                        _gameObject.SetPrototype(prototype as GPUInstancerPrefabPrototype);
                    }
                    else if (prototype.prefabObject == _noGameObject.prefab)
                    {
                        _noGameObject.SetPrototype(prototype as GPUInstancerPrefabPrototype);
                    }
                }
            }
            
            SetDirty();
        }

        private GameObject CreateNOGOPrefab()
        {
           
using (ASPECT.Many(ASPECT.Profile(), ASPECT.Trace()))
            {
                var modified = PrefabUtility.InstantiatePrefab(_gameObject.prefab) as GameObject;

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
                            Component.Destroy(component);
                        }
                        else
                        {
                            Component.DestroyImmediate(component);
                        }
                    }
                }

                void RemoveEmptyGameObjects(GameObject go)
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

                RemoveEmptyGameObjects(modified);

                var existingPath = AssetDatabase.GetAssetPath(_gameObject.prefab);
                var fileName = Path.GetFileNameWithoutExtension(existingPath);
                var directory = Path.GetDirectoryName(existingPath);
                var extension = Path.GetExtension(existingPath);

                var subDirectory = $"{directory}_NGO";

                Directory.CreateDirectory(subDirectory);

                var newPath = $"{subDirectory}/{fileName}_NGO{extension}";

                var result = PrefabUtility.SaveAsPrefabAsset(modified, newPath);

                if (Application.isPlaying)
                {
                    GameObject.Destroy(modified);
                }
                else
                {
                    GameObject.DestroyImmediate(modified);
                }

                return result;
            }
        }
    }
}*/


