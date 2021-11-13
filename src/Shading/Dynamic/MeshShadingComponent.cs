#region

using System;
using System.Collections.Generic;
using System.Linq;
using Appalachia.CI.Integration.Assets;
using Appalachia.Core.Behaviours;
using Appalachia.Utility.Logging;
using Sirenix.OdinInspector;
using Unity.Profiling;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Shading.Dynamic
{
    [ExecuteAlways]
    [DisallowMultipleComponent]
    public class MeshShadingComponent : AppalachiaBehaviour
    {
        private const string _PRF_PFX = nameof(MeshShadingComponent) + ".";
        private static readonly ProfilerMarker _PRF_Awake = new(_PRF_PFX + "Awake");
        private static readonly ProfilerMarker _PRF_Start = new(_PRF_PFX + "Start");
        private static readonly ProfilerMarker _PRF_OnEnable = new(_PRF_PFX + "OnEnable");
        private static readonly ProfilerMarker _PRF_Update = new(_PRF_PFX + "Update");
        private static readonly ProfilerMarker _PRF_LateUpdate = new(_PRF_PFX + "LateUpdate");
        private static readonly ProfilerMarker _PRF_OnDisable = new(_PRF_PFX + "OnDisable");
        private static readonly ProfilerMarker _PRF_OnDestroy = new(_PRF_PFX + "OnDestroy");
        private static readonly ProfilerMarker _PRF_Reset = new(_PRF_PFX + "Reset");
        private static readonly ProfilerMarker _PRF_OnDrawGizmos = new(_PRF_PFX + "OnDrawGizmos");

        private static readonly ProfilerMarker _PRF_OnDrawGizmosSelected =
            new(_PRF_PFX + "OnDrawGizmosSelected");

        private static readonly ProfilerMarker _PRF_AssignShadingMetadata =
            new(_PRF_PFX + nameof(AssignShadingMetadata));

        private static readonly ProfilerMarker _PRF_UpdateRenderer =
            new(_PRF_PFX + nameof(UpdateRenderer));

        [HideLabel]
        [InlineEditor(Expanded = true)]
        [HideReferenceObjectPicker]
        public MeshShadingComponentData componentData;

        private void Start()
        {
            using (_PRF_Start.Auto())
            {
                AssignShadingMetadata();
            }
        }

        private void OnEnable()
        {
            using (_PRF_OnEnable.Auto())
            {
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
                                prefabAssetPath =
                                    UnityEditor.PrefabUtility.GetPrefabAssetPathOfNearestInstanceRoot(this);
                            }

                            if (string.IsNullOrWhiteSpace(prefabAssetPath))
                            {
                                AppaLog.Error(
                                    $"Could not find asset path for prefab {name}."
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
                    AppaLog.Error($"Failed to assign mesh shading data to {name}:");
                    AppaLog.Exception(ex);

                    return;
                }
#endif
                AssignShadingMetadata();
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
                                    AppaLog.Error(
                                        $"{gameObject.name}: Could not find mesh data to assign mesh UV shading data to."
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
                                    AppaLog.Error(
                                        $"{gameObject.name}: Could not find mesh data to assign mesh UV shading data to."
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
                            AppaLog.Error(
                                $"{gameObject.name}: Could not find mesh data to assign mesh UV shading data to."
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
                    AppaLog.Error($"{gameObject.name}: Failed to assign mesh shading data to {name}");
                    AppaLog.Exception(ex);
                }
            }
        }

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

                    for (var channelIndex = 0;
                        channelIndex < submeshMetadata.channels.Count;
                        channelIndex++)
                    {
                        var channelMetadata = submeshMetadata.channels[channelIndex];
                        var channel = (int) channelMetadata.channel;
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
    }
}
