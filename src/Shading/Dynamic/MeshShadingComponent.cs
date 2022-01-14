#region

using System;
using System.Collections.Generic;
using System.Linq;
using Appalachia.CI.Integration.Assets;
using Appalachia.Core.Objects.Initialization;
using Appalachia.Core.Objects.Root;
using Appalachia.Utility.Async;
using Appalachia.Utility.Strings;
using Sirenix.OdinInspector;
using Unity.Profiling;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Shading.Dynamic
{
    [ExecuteAlways]
    [DisallowMultipleComponent]
    public sealed class MeshShadingComponent : AppalachiaBehaviour<MeshShadingComponent>
    {
        #region Fields and Autoproperties

        [HideLabel]
        [InlineEditor(Expanded = true)]
        [HideReferenceObjectPicker]
        public MeshShadingComponentData componentData;

        #endregion

        [Button]
        public static void AssignAllShadingMetadata()
        {
            var m1 = FindObjectsOfType<MeshShadingComponent>();

            for (var index = 0; index < m1.Length; index++)
            {
                var m = m1[index];
                m.AssignShadingMetadata();
            }
        }

        [Button]
        public void AssignShadingMetadata()
        {
            using (_PRF_AssignShadingMetadata.Auto())
            {
                try
                {
                    if (componentData.updateChildMeshes)
                    {
                        var lod = GetComponent<LODGroup>();

                        if (lod != null)
                        {
                            var filters = lod.GetComponentsInChildren<MeshFilter>();

                            var biggestMeshSize = filters.Max(f => f.sharedMesh.vertexCount);
                            var biggestMesh = filters.First(f => f.sharedMesh.vertexCount == biggestMeshSize)
                                                     .sharedMesh;
                            biggestMesh.RecalculateBounds();

                            for (var index = 0; index < filters.Length; index++)
                            {
                                var filter = filters[index];
                                var r = filter.GetComponent<MeshRenderer>();

                                if ((r == null) || (filter == null))
                                {
                                    Context.Log.Error(
                                        ZString.Format(
                                            "{0}: Could not find mesh data to assign mesh UV shading data to.",
                                            gameObject.name
                                        )
                                    );
                                    return;
                                }

                                var sharedMesh = filter.sharedMesh;

                                sharedMesh.RecalculateBounds();

                                UpdateRenderer(r, biggestMesh, sharedMesh, componentData.metadata);
                            }

                            lod.RecalculateBounds();
                        }
                        else
                        {
                            var filters = GetComponentsInChildren<MeshFilter>();

                            foreach (var filter in filters)
                            {
                                var r = filter.GetComponent<MeshRenderer>();

                                if ((r == null) || (filter == null))
                                {
                                    Context.Log.Error(
                                        ZString.Format(
                                            "{0}: Could not find mesh data to assign mesh UV shading data to.",
                                            gameObject.name
                                        )
                                    );
                                    return;
                                }

                                var sharedMesh = filter.sharedMesh;

                                sharedMesh.RecalculateBounds();

                                UpdateRenderer(r, sharedMesh, sharedMesh, componentData.metadata);
                            }
                        }
                    }
                    else
                    {
                        var r = GetComponent<MeshRenderer>();
                        var filter = GetComponent<MeshFilter>();

                        if ((r == null) || (filter == null))
                        {
                            Context.Log.Error(
                                ZString.Format(
                                    "{0}: Could not find mesh data to assign mesh UV shading data to.",
                                    gameObject.name
                                )
                            );
                            return;
                        }

                        var sharedMesh = filter.sharedMesh;
                        sharedMesh.RecalculateBounds();

                        UpdateRenderer(r, sharedMesh, sharedMesh, componentData.metadata);
                    }
                }
                catch (Exception ex)
                {
                    Context.Log.Error(
                        ZString.Format(
                            "{0}: Failed to assign mesh shading data to {1}",
                            gameObject.name,
                            name
                        )
                    );
                    Context.Log.Error(ex);
                }
            }
        }

        protected override async AppaTask Initialize(Initializer initializer)
        {
            await base.Initialize(initializer);

            AssignShadingMetadata();
        }

        protected override async AppaTask WhenEnabled()
        {
            using (_PRF_WhenEnabled.Auto())
            {
                await base.WhenEnabled();
#if UNITY_EDITOR
                try
                {
                    if (componentData == null)
                    {
                        if (UnityEditor.PrefabUtility.IsPartOfNonAssetPrefabInstance(gameObject))
                        {
                            var prefabAssetPath = AssetDatabaseManager.GetAssetPath(gameObject);

                            if (string.IsNullOrWhiteSpace(prefabAssetPath))
                            {
                                prefabAssetPath = AssetDatabaseManager.GetAssetPath(gameObject);
                            }

                            if (string.IsNullOrWhiteSpace(prefabAssetPath))
                            {
                                prefabAssetPath = UnityEditor.PrefabUtility
                                                             .GetPrefabAssetPathOfNearestInstanceRoot(this);
                            }

                            if (string.IsNullOrWhiteSpace(prefabAssetPath))
                            {
                                Context.Log.Error(
                                    ZString.Format("Could not find asset path for prefab {0}.", name)
                                );

                                return;
                            }

                            componentData =
                                AssetDatabaseManager.LoadAssetAtPath<MeshShadingComponentData>(
                                    prefabAssetPath
                                );

                            if (componentData == null)
                            {
                                componentData =
                                    MeshShadingComponentData
                                       .CreateAndSaveInExisting<MeshShadingComponentData>(
                                            prefabAssetPath,
                                            "Mesh Shading Component Data"
                                        );

                                UnityEditor.PrefabUtility.ApplyPrefabInstance(
                                    gameObject,
                                    UnityEditor.InteractionMode.AutomatedAction
                                );
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Context.Log.Error(ZString.Format("Failed to assign mesh shading data to {0}:", name));
                    Context.Log.Error(ex);

                    return;
                }
#endif
                AssignShadingMetadata();
            }
        }

        private void UpdateRenderer(Renderer r, Mesh sizingMesh, Mesh mesh, MeshShadingMetadata m)
        {
            using (_PRF_UpdateRenderer.Auto())
            {
                var minMaterialCount = Math.Min(r.sharedMaterials.Length, m.submeshMetadata.Count);
                var values = m.Calculate(sizingMesh, componentData.boundsCenterOffsetPercentage);

                for (var submeshIndex = 0; submeshIndex < minMaterialCount; submeshIndex++)
                {
                    var submeshMetadata = m.submeshMetadata[submeshIndex];
                    var submeshValues = values[submeshIndex];
                    var submeshIndices = mesh.GetIndices(submeshIndex).Distinct().ToArray();

                    for (var channelIndex = 0; channelIndex < submeshMetadata.channels.Count; channelIndex++)
                    {
                        var channelMetadata = submeshMetadata.channels[channelIndex];
                        var channel = (int)channelMetadata.channel;
                        var channelValues = submeshValues[channelIndex];

                        var uv = new List<Vector4>();
                        mesh.GetUVs(channel, uv);

                        if (uv.Count != mesh.vertexCount)
                        {
                            uv.Clear();

                            for (var i = 0; i < mesh.vertexCount; i++)
                            {
                                uv.Add(Vector4.zero);
                            }
                        }

                        for (var index = 0; index < submeshIndices.Length; index++)
                        {
                            var i = submeshIndices[index];
                            uv[i] = channelValues;
                        }

                        mesh.SetUVs(channel, uv);
                    }

                    r.sharedMaterials[submeshIndex] = submeshMetadata.material;
                }
            }
        }

        #region Profiling

        private static readonly ProfilerMarker _PRF_AssignShadingMetadata =
            new(_PRF_PFX + nameof(AssignShadingMetadata));

        

        private static readonly ProfilerMarker _PRF_UpdateRenderer = new(_PRF_PFX + nameof(UpdateRenderer));

        

        #endregion
    }
}
