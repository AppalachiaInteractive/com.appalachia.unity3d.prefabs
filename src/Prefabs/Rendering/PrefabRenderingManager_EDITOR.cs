#if UNITY_EDITOR

//using System.Linq;

#region

using System;
using System.Collections.Generic;
using GPUInstancer;
using Unity.Profiling;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering
{
    public partial class PrefabRenderingManager
    {
        private static readonly ProfilerMarker _PRF_SetSceneDirty =
            new(_PRF_PFX + nameof(SetSceneDirty));

        private static readonly ProfilerMarker _PRF_ManageNewPrefabRegistration =
            new(_PRF_PFX + nameof(ManageNewPrefabRegistration));

        public void SetSceneDirty()
        {
            using (_PRF_SetSceneDirty.Auto())
            {
                if (!Application.isPlaying)
                {
                    UnityEditor.SceneManagement.EditorSceneManager.MarkSceneDirty(gameObject.scene);
                }
            }
        }
        
        public PrefabRenderingSet ManageNewPrefabRegistration(GameObject prefab)
        {
            using (_PRF_ManageNewPrefabRegistration.Auto())
            {
                if (renderingSets.Sets.ContainsKey(prefab))
                {
                    return renderingSets.Sets[prefab];
                }

                var prototypeLookup =
                    new Dictionary<GPUInstancerPrefabPrototype, RegisteredPrefabsData>();

                for (var i = 0; i < gpui.prototypeList.Count; i++)
                {
                    var prototype = gpui.prototypeList[i] as GPUInstancerPrefabPrototype;

                    if (prototype == null)
                    {
                        throw new NotSupportedException($"Prototype at index {i} was null.");
                    }
                    
                    if (prototypeLookup.ContainsKey(prototype))
                    {
                        continue;
                    }

                    var registeredPrefabsData = gpui.registeredPrefabInstances.Get(prototype);

                    prototypeLookup.Add(prototype, registeredPrefabsData);
                }

                var set = PrefabRenderingSet.LoadOrCreateNew($"{prefab.name}", true, false);

                set.Initialize(prefab, metadatas.FindOrCreate(prefab, gpui, prototypeLookup));

                renderingSets.Sets.AddOrUpdate(prefab, set);

                return set;
            }
        }
    }
    
}

#endif