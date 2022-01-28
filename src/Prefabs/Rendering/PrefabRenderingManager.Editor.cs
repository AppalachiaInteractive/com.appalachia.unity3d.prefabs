#if UNITY_EDITOR

//using System.Linq;

#region

using System;
using System.Collections.Generic;
using Appalachia.Core.Objects.Root;
using Appalachia.Spatial.MeshBurial.Processing;
using Appalachia.Utility.Execution;
using Appalachia.Utility.Strings;
using GPUInstancer;
using Unity.Profiling;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering
{
    public partial class PrefabRenderingManager
    {
        #region Static Fields and Autoproperties

        private static MeshBurialExecutionManager _meshBurialExecutionManager;

        #endregion

        public PrefabRenderingSet ManageNewPrefabRegistration(GameObject prefab)
        {
            using (_PRF_ManageNewPrefabRegistration.Auto())
            {
                if (renderingSets.Sets.ContainsKey(prefab))
                {
                    return renderingSets.Sets[prefab];
                }

                var prototypeLookup = new Dictionary<GPUInstancerPrefabPrototype, RegisteredPrefabsData>();

                for (var i = 0; i < gpui.prototypeList.Count; i++)
                {
                    var prototype = gpui.prototypeList[i] as GPUInstancerPrefabPrototype;

                    if (prototype == null)
                    {
                        throw new NotSupportedException(
                            ZString.Format("Prototype at index {0} was null.", i)
                        );
                    }

                    if (prototypeLookup.ContainsKey(prototype))
                    {
                        continue;
                    }

                    var registeredPrefabsData = gpui.registeredPrefabInstances.Get(prototype);

                    prototypeLookup.Add(prototype, registeredPrefabsData);
                }

                var set = AppalachiaObject.LoadOrCreateNew<PrefabRenderingSet>(
                    ZString.Format("{0}_{1}", nameof(PrefabRenderingSet), prefab.name)
                );

                set.Initialize(prefab, metadatas.FindOrCreate(prefab, gpui, prototypeLookup));

                renderingSets.Sets.AddOrUpdate(prefab, set);

                return set;
            }
        }

        public void SetSceneDirty()
        {
            using (_PRF_SetSceneDirty.Auto())
            {
                if (!AppalachiaApplication.IsPlayingOrWillPlay)
                {
                    UnityEditor.SceneManagement.EditorSceneManager.MarkSceneDirty(gameObject.scene);
                }
            }
        }

        #region Profiling

        private static readonly ProfilerMarker _PRF_SetSceneDirty = new(_PRF_PFX + nameof(SetSceneDirty));

        private static readonly ProfilerMarker _PRF_ManageNewPrefabRegistration =
            new(_PRF_PFX + nameof(ManageNewPrefabRegistration));

        #endregion
    }
}

#endif
