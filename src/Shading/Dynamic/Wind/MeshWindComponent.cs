#region

using System;
using System.Collections.Generic;
using System.Linq;
using Appalachia.CI.Integration.Assets;
using Appalachia.CI.Integration.FileSystem;
using Appalachia.Core.Math.Noise;
using Appalachia.Core.Objects.Initialization;
using Appalachia.Core.Objects.Root;
using Appalachia.Utility.Async;
using Appalachia.Utility.Extensions;
using Appalachia.Utility.Strings;
using Sirenix.OdinInspector;
using Unity.Profiling;
using UnityEditor;
using UnityEngine;

// ReSharper disable UnusedVariable

#endregion

namespace Appalachia.Rendering.Shading.Dynamic.Wind
{
    [ExecuteAlways]
    [DisallowMultipleComponent]
    public sealed class MeshWindComponent : AppalachiaBehaviour<MeshWindComponent>
    {
        #region Constants and Static Readonly

        private static readonly Dictionary<Material, MeshWindMetadata.MeshWindMaterialMatchGroup>
            _materialLookup = new();

        private static readonly object _materialLookupLock = new();

        #endregion

        #region Static Fields and Autoproperties

        private static bool _showAllButtons;
        private static bool _showRevertButtons;
        private static bool _showBatchRevertButtons = _showRevertButtons && _showAllButtons;

        #endregion

        #region Fields and Autoproperties

        [HideLabel]
        [InlineEditor(Expanded = true)]
        [HideReferenceObjectPicker]
        public MeshWindComponentData componentData;

        [InlineEditor(Expanded = true)]
        public MeshWindMetadata metadata;

        [ShowIf(nameof(showGenerateMaskButton))]
        public MeshWindComponentData.TextureSize generatedMaskSize = MeshWindComponentData.TextureSize.k128;

        #endregion

        private bool showGenerateMaskButton =>
            (componentData != null) &&
            (componentData.style == MeshWindComponentData.MeshWindStyle.Texture2D) &&
            (componentData.windMask == null);

        private bool showPopulateTreeMaterialsButton =>
            (componentData != null) &&
            (componentData.style == MeshWindComponentData.MeshWindStyle.TreeMaterials) &&
            ((componentData.treeMaterials.Count == 0) ||
             componentData.treeMaterials.Any(tm => tm.windMask == null));

        public void AssignWindMetadata(bool force)
        {
            using (_PRF_AssignWindMetadata.Auto())
            {
                try
                {
                    if (metadata == null)
                    {
                        return;
                    }

                    if (_materialLookup.Count != metadata.materialMatches.Sum(m => m.materials.Count))
                    {
                        lock (_materialLookupLock)
                        {
                            if (_materialLookup.Count != metadata.materialMatches.Sum(m => m.materials.Count))
                            {
                                _materialLookup.Clear();
                                foreach (var mat in metadata.materialMatches)
                                {
                                    foreach (var mmat in mat.materials)
                                    {
                                        if (!_materialLookup.ContainsKey(mmat))
                                        {
                                            _materialLookup.Add(mmat, mat);
                                        }
                                    }
                                }
                            }
                        }
                    }

                    var renderers = GetComponentsInChildren<MeshRenderer>();

                    foreach (var renderer_ in renderers)
                    {
                        var currentMesh = renderer_.GetSharedMesh();

                        if (currentMesh.name.Contains("Impostor"))
                        {
                            continue;
                        }

                        var matchingRecoveryInfo =
                            componentData.recoveryInfo.FirstOrDefault(ri => ri.updated == currentMesh);

                        if ((matchingRecoveryInfo != null) && (matchingRecoveryInfo.updated != null))
                        {
                            if (currentMesh != matchingRecoveryInfo.updated)
                            {
                                if (currentMesh == matchingRecoveryInfo.original)
                                {
                                    matchingRecoveryInfo.updated = null;
                                }
                                else
                                {
                                    matchingRecoveryInfo.updated = currentMesh;
                                }
                            }

                            if ((currentMesh == matchingRecoveryInfo.updated) && !force)
                            {
                                continue;
                            }
                        }

                        Mesh updatedMesh;
#if UNITY_EDITOR
                        if ((matchingRecoveryInfo == null) || (matchingRecoveryInfo.updated == null))
                        {
                            var newMeshName = ZString.Format("{0}_ADSP", currentMesh.name);
                            var path = AssetDatabaseManager.GetAssetPath(currentMesh);
                            var directory = AppaPath.GetDirectoryName(path);

                            var newPath = ZString.Format("{0}\\{1}.asset", directory, newMeshName);

                            updatedMesh = AssetDatabaseManager.LoadAssetAtPath<Mesh>(newPath);

                            if (updatedMesh == null)
                            {
                                updatedMesh = Instantiate(currentMesh);
                                updatedMesh.name = newMeshName;
                                AssetDatabaseManager.CreateAsset(updatedMesh, newPath);
                            }

                            matchingRecoveryInfo = new MeshWindComponentData.WindMeshSet
                            {
                                original = currentMesh,
                                originalMaterials = renderer_.sharedMaterials.ToList(),
                                updated = updatedMesh
                            };

                            componentData.recoveryInfo.Add(matchingRecoveryInfo);

                            var mf = renderer_.GetComponent<MeshFilter>();
                            mf.sharedMesh = updatedMesh;
                        }
                        else
#endif
                        {
                            updatedMesh = matchingRecoveryInfo.updated;
                        }

                        List<Color> colors;

                        var rendererTransform = renderer_.transform;

                        switch (componentData.style)
                        {
                            case MeshWindComponentData.MeshWindStyle.FadeUp:
                                colors = AssignWindMetadata_FadeUp(
                                    matchingRecoveryInfo.original,
                                    rendererTransform.localPosition,
                                    rendererTransform.localRotation,
                                    rendererTransform.localScale
                                );
                                break;
                            case MeshWindComponentData.MeshWindStyle.Material:
                                colors = AssignWindMetadata_Material(
                                    matchingRecoveryInfo.original,
                                    rendererTransform.localPosition,
                                    rendererTransform.localRotation,
                                    rendererTransform.localScale,
                                    matchingRecoveryInfo.originalMaterials,
                                    _materialLookup
                                );
                                break;
                            case MeshWindComponentData.MeshWindStyle.Texture2D:
                                colors = AssignWindMetadata_Texture2D(
                                    matchingRecoveryInfo.original,
                                    rendererTransform.localPosition,
                                    rendererTransform.localRotation,
                                    rendererTransform.localScale,
                                    componentData.windMask
                                );
                                break;
                            case MeshWindComponentData.MeshWindStyle.TreeMaterials:
                                colors = AssignWindMetadata_TreeMaterials(
                                    matchingRecoveryInfo.original,
                                    rendererTransform.localPosition,
                                    rendererTransform.localRotation,
                                    rendererTransform.localScale,
                                    gameObject,
                                    componentData.treeMaterials
                                );
                                break;
                            default:
                                throw new ArgumentOutOfRangeException();
                        }

                        updatedMesh.SetColors(colors);
                        updatedMesh.UploadMeshData(false);
                    }
                }
                catch (Exception ex)
                {
                    Context.Log.Error(ZString.Format("Failed to assign mesh wind data to {0}.", name), this);
                    Context.Log.Error(ex,                                                              this);
                }
            }
        }

        /// <inheritdoc />
        protected override async AppaTask Initialize(Initializer initializer)
        {
            await base.Initialize(initializer);

            AssignWindMetadata(false);
        }

        /// <inheritdoc />
        protected override async AppaTask WhenEnabled()
        {
            await base.WhenEnabled();
            using (_PRF_WhenEnabled.Auto())
            {
#if UNITY_EDITOR
                try
                {
                    if (componentData == null)
                    {
                        if (PrefabUtility.IsPartOfNonAssetPrefabInstance(gameObject))
                        {
                            var prefabAssetPath = AssetDatabaseManager.GetAssetPath(gameObject);

                            if (string.IsNullOrWhiteSpace(prefabAssetPath))
                            {
                                prefabAssetPath = AssetDatabaseManager.GetAssetPath(gameObject);
                            }

                            if (string.IsNullOrWhiteSpace(prefabAssetPath))
                            {
                                prefabAssetPath = PrefabUtility.GetPrefabAssetPathOfNearestInstanceRoot(this);
                            }

                            if (string.IsNullOrWhiteSpace(prefabAssetPath))
                            {
                                Context.Log.Error(
                                    ZString.Format("Could not find asset path for prefab {0}.", name),
                                    this
                                );

                                return;
                            }

                            componentData =
                                AssetDatabaseManager.LoadAssetAtPath<MeshWindComponentData>(prefabAssetPath);

                            if (componentData == null)
                            {
                                componentData =
                                    MeshWindComponentData.CreateAndSaveInExisting<MeshWindComponentData>(
                                        prefabAssetPath,
                                        "Mesh Wind Component Data"
                                    );

                                PrefabUtility.ApplyPrefabInstance(
                                    gameObject,
                                    InteractionMode.AutomatedAction
                                );
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Context.Log.Error(ZString.Format("Failed to assign mesh wind data to {0}.", name), this);
                    Context.Log.Error(ex,                                                              this);

                    return;
                }
#endif
                AssignWindMetadata(false);
            }
        }

        private List<Color> AssignWindMetadata_FadeUp(
            Mesh mesh,
            Vector3 offset,
            Quaternion meshRotation,
            Vector3 scale)
        {
            var bounds = new MeshBounds(mesh, offset, meshRotation, scale);

            var vertices = new List<Vector3>();
            mesh.GetVertices(vertices);

            var colors = new List<Color>();

            for (var i = 0; i < mesh.vertexCount; i++)
            {
                colors.Add(metadata.baseColor);
            }

            for (var i = 0; i < vertices.Count; i++)
            {
                var vertex = vertices[i];
                var updatedVertex = new Vector3(vertex.x * scale.x, vertex.y * scale.y, vertex.z * scale.z);
                updatedVertex = meshRotation * updatedVertex;
                updatedVertex += offset;

                var timeX = bounds.NormalizeX(updatedVertex.x);
                var timeY = bounds.NormalizeY(updatedVertex.y);
                var timeZ = bounds.NormalizeZ(updatedVertex.z);

                var color = new Color(
                    Mathf.Lerp(metadata.grassFadeR.x, metadata.grassFadeR.y, timeY),
                    0f,
                    Mathf.Lerp(metadata.grassFadeB.x, metadata.grassFadeB.y, timeX * timeZ),
                    Mathf.Lerp(metadata.grassFadeA.x, metadata.grassFadeA.y, 1 - (timeX * timeZ))
                );

                color.r = Mathf.Clamp01(color.r * componentData.windStrengthModifier);
                color.g = Mathf.Clamp01(color.g);
                color.b = Mathf.Clamp01(color.b * componentData.leafStrengthModifier);

                colors[i] = color;
            }

            return colors;
        }

        private List<Color> AssignWindMetadata_Material(
            Mesh mesh,
            Vector3 offset,
            Quaternion meshRotation,
            Vector3 scale,
            List<Material> materials,
            Dictionary<Material, MeshWindMetadata.MeshWindMaterialMatchGroup> matLookup)
        {
            var bounds = new MeshBounds(mesh, offset, meshRotation, scale);

            var variationNoise = Perlin.Noise(mesh.bounds.size * metadata.variationNoiseScale);
            var variationNoiseAmount = metadata.variationNoiseRange.x +
                                       (variationNoise * metadata.variationNoiseRange.y);

            bounds.x.min = 0;
            bounds.z.min = 0;

            var vertices = new List<Vector3>();
            mesh.GetVertices(vertices);

            var indices = new List<int>();
            var colors = new List<Color>();

            for (var i = 0; i < mesh.vertexCount; i++)
            {
                colors.Add(metadata.baseColor);
            }

            for (var i = 0; i < mesh.subMeshCount; i++)
            {
                var material = materials[i];

                mesh.GetIndices(indices, i);

                var color = matLookup.ContainsKey(material)
                    ? matLookup[material].vertexColor
                    : metadata.baseColor;

                for (var j = 0; j < indices.Count; j++)
                {
                    var vertex = vertices[indices[j]];
                    var updatedVertex = new Vector3(
                        vertex.x * scale.x,
                        vertex.y * scale.y,
                        vertex.z * scale.z
                    );
                    updatedVertex = meshRotation * updatedVertex;
                    updatedVertex += offset;

                    var timeX = Mathf.Clamp01(bounds.NormalizeX(Mathf.Abs(updatedVertex.x)));
                    var timeY = Mathf.Clamp01(bounds.NormalizeY(Mathf.Abs(updatedVertex.y)));
                    var timeZ = Mathf.Clamp01(bounds.NormalizeZ(Mathf.Abs(updatedVertex.z)));

                    //var timeXYZ = Mathf.Max(timeX, Mathf.Max(timeY, timeZ));
                    var timeXZ = Mathf.Max(timeX, timeZ);

                    var generalNoise = Perlin.Noise(metadata.generalMotionNoiseScale * updatedVertex.xz());
                    var leafNoise = 1 - Perlin.Noise(metadata.leafMotionNoiseScale * updatedVertex);

                    var generalNoiseAmount = metadata.generalMotionNoiseRange.x +
                                             (generalNoise * metadata.generalMotionNoiseRange.y);

                    var leafNoiseAmount = metadata.leafMotionNoiseRange.x +
                                          (leafNoise * metadata.leafMotionNoiseRange.y);

                    var generalTime = timeY +
                                      ((metadata.generalMotionXZInfluence * timeXZ) /
                                       (1 + metadata.generalMotionXZInfluence));

                    var colorAugment = new Color(
                        componentData.disableGeneralMotion
                            ? 0f
                            : Mathf.SmoothStep(
                                metadata.grassFadeR.x,
                                metadata.grassFadeR.y,
                                generalNoiseAmount * generalTime
                            ),
                        0f,
                        componentData.disableLeafMotion
                            ? 0f
                            : Mathf.SmoothStep(
                                metadata.grassFadeB.x,
                                metadata.grassFadeB.y,
                                leafNoiseAmount * timeXZ
                            ),
                        componentData.disableVariationMotion
                            ? 0f
                            : componentData.invertVariationMotion
                                ? 1 -
                                  Mathf.SmoothStep(
                                      metadata.grassFadeA.x,
                                      metadata.grassFadeA.y,
                                      variationNoiseAmount
                                  )
                                : Mathf.SmoothStep(
                                    metadata.grassFadeA.x,
                                    metadata.grassFadeA.y,
                                    variationNoiseAmount
                                )
                    );

                    var finalColor = color * colorAugment;

                    finalColor.r = Mathf.Clamp01(finalColor.r * componentData.windStrengthModifier);
                    finalColor.g = Mathf.Clamp01(finalColor.g);
                    finalColor.b = Mathf.Clamp01(finalColor.b * componentData.leafStrengthModifier);

                    colors[indices[j]] = finalColor;
                }
            }

            return colors;
        }

        private List<Color> AssignWindMetadata_Texture2D(
            Mesh mesh,
            Vector3 offset,
            Quaternion meshRotation,
            Vector3 scale,
            Texture2D windMask)
        {
            if (windMask == null)
            {
                var ret = new List<Color>(mesh.vertexCount);
                for (var i = 0; i < mesh.vertexCount; i++)
                {
                    ret[i] = Color.black;
                }

                Context.Log.Error(ZString.Format("Could not find wind mask for object {0}", mesh.name), mesh);
                return ret;
            }

            var bounds = new MeshBounds(mesh, offset, meshRotation, scale);

            var variationNoise = Perlin.Noise(mesh.bounds.size * metadata.variationNoiseScale);
            var variationNoiseAmount = metadata.variationNoiseRange.x +
                                       (variationNoise * metadata.variationNoiseRange.y);

            bounds.x.min = 0;
            bounds.z.min = 0;

            var vertices = new List<Vector3>();
            mesh.GetVertices(vertices);

            var indices = new List<int>();
            var uv1 = new List<Vector2>();
            var colors = new List<Color>();

            for (var i = 0; i < mesh.vertexCount; i++)
            {
                colors.Add(metadata.baseColor);
            }

            mesh.GetUVs(0, uv1);

            for (var i = mesh.subMeshCount - 1; i >= 0; i--)
            {
                mesh.GetIndices(indices, i);

                for (var j = 0; j < indices.Count; j++)
                {
                    var vertex = vertices[indices[j]];
                    var updatedVertex = new Vector3(
                        vertex.x * scale.x,
                        vertex.y * scale.y,
                        vertex.z * scale.z
                    );
                    updatedVertex = meshRotation * updatedVertex;
                    updatedVertex += offset;
                    var uv = uv1[indices[j]];

                    var maskColor = windMask.GetPixelBilinear(uv.x, uv.y);

                    var timeX = Mathf.Clamp01(bounds.NormalizeX(Mathf.Abs(updatedVertex.x)));
                    var timeY = Mathf.Clamp01(bounds.NormalizeY(Mathf.Abs(updatedVertex.y)));
                    var timeZ = Mathf.Clamp01(bounds.NormalizeZ(Mathf.Abs(updatedVertex.z)));

                    //var timeXYZ = Mathf.Max(timeX, Mathf.Max(timeY, timeZ));
                    var timeXZ = Mathf.Max(timeX, timeZ);

                    var generalNoise = Perlin.Noise(metadata.generalMotionNoiseScale * updatedVertex.xz());
                    var leafNoise = 1 - Perlin.Noise(metadata.leafMotionNoiseScale * updatedVertex);

                    var generalNoiseAmount = metadata.generalMotionNoiseRange.x +
                                             (generalNoise * metadata.generalMotionNoiseRange.y);

                    var leafNoiseAmount = metadata.leafMotionNoiseRange.x +
                                          (leafNoise * metadata.leafMotionNoiseRange.y);

                    var generalTime = timeY +
                                      ((componentData.windMaskXZInfluence * timeXZ) /
                                       (1 + componentData.windMaskXZInfluence));

                    var colorAugment = new Color(
                        componentData.disableGeneralMotion
                            ? 0f
                            : Mathf.SmoothStep(
                                metadata.grassFadeR.x,
                                metadata.grassFadeR.y,
                                generalNoiseAmount * generalTime
                            ),
                        0f,
                        componentData.disableLeafMotion
                            ? 0f
                            : Mathf.SmoothStep(
                                metadata.grassFadeB.x,
                                metadata.grassFadeB.y,
                                leafNoiseAmount * timeXZ
                            ),
                        componentData.disableVariationMotion
                            ? 0f
                            : componentData.invertVariationMotion
                                ? 1 -
                                  Mathf.SmoothStep(
                                      metadata.grassFadeA.x,
                                      metadata.grassFadeA.y,
                                      variationNoiseAmount
                                  )
                                : Mathf.SmoothStep(
                                    metadata.grassFadeA.x,
                                    metadata.grassFadeA.y,
                                    variationNoiseAmount
                                )
                    );

                    var finalColor = maskColor * colorAugment;

                    finalColor.r = Mathf.Clamp01(finalColor.r * componentData.windStrengthModifier);
                    finalColor.g = Mathf.Clamp01(finalColor.g * componentData.branchStrengthModifier);
                    finalColor.b = Mathf.Clamp01(finalColor.b * componentData.leafStrengthModifier);

                    colors[indices[j]] = finalColor;
                }
            }

            return colors;
        }

        private List<Color> AssignWindMetadata_TreeMaterials(
            Mesh mesh,
            Vector3 offset,
            Quaternion meshRotation,
            Vector3 scale,
            GameObject go,
            List<MeshWindComponentData.TreeMaterialSet> materials)
        {
            var tree = go.GetComponent<Tree>();

            if (tree != null)
            {
                var treeData = tree.data;

                if (treeData != null)
                {
                    return AssignWindMetadata_TreeMaterials_TreeCreator(
                        mesh,
                        offset,
                        meshRotation,
                        scale,
                        tree,
                        materials
                    );
                }
            }

            return AssignWindMetadata_TreeMaterials_NonTreeCreator(
                mesh,
                offset,
                meshRotation,
                scale,
                go,
                materials
            );
        }

        private List<Color> AssignWindMetadata_TreeMaterials_NonTreeCreator(
            Mesh mesh,
            Vector3 offset,
            Quaternion meshRotation,
            Vector3 scale,
            GameObject go,
            List<MeshWindComponentData.TreeMaterialSet> materials)
        {
            var bounds = new MeshBounds(mesh, offset, meshRotation, scale);

            var variationNoise = Perlin.Noise(mesh.bounds.size * metadata.variationNoiseScale);
            var variationNoiseAmount = metadata.variationNoiseRange.x +
                                       (variationNoise * metadata.variationNoiseRange.y);

            bounds.x.min = 0;
            bounds.z.min = 0;

            var vertices = new List<Vector3>();
            mesh.GetVertices(vertices);

            var indices = new List<int>();
            var uv1 = new List<Vector2>();
            var colors = new List<Color>();

            for (var i = 0; i < mesh.vertexCount; i++)
            {
                colors.Add(metadata.baseColor);
            }

            mesh.GetUVs(0, uv1);

            for (var i = mesh.subMeshCount - 1; i >= 0; i--)
            {
                mesh.GetIndices(indices, i);

                for (var j = 0; j < indices.Count; j++)
                {
                    var vertex = vertices[indices[j]];
                    var updatedVertex = new Vector3(
                        vertex.x * scale.x,
                        vertex.y * scale.y,
                        vertex.z * scale.z
                    );
                    updatedVertex = meshRotation * updatedVertex;
                    updatedVertex += offset;
                    var uv = uv1[indices[j]];

                    var maskColor = Color.black; //windMask.GetPixelBilinear(uv.x, uv.y);

                    var timeX = Mathf.Clamp01(bounds.NormalizeX(Mathf.Abs(updatedVertex.x)));
                    var timeY = Mathf.Clamp01(bounds.NormalizeY(Mathf.Abs(updatedVertex.y)));
                    var timeZ = Mathf.Clamp01(bounds.NormalizeZ(Mathf.Abs(updatedVertex.z)));

                    var timeXYZ = Mathf.Max(timeX, Mathf.Max(timeY, timeZ));
                    var timeXZ = Mathf.Max(timeX,  timeZ);

                    var generalNoise = Perlin.Noise(metadata.generalMotionNoiseScale * updatedVertex.xz());
                    var leafNoise = 1 - Perlin.Noise(metadata.leafMotionNoiseScale * updatedVertex);

                    var generalNoiseAmount = metadata.generalMotionNoiseRange.x +
                                             (generalNoise * metadata.generalMotionNoiseRange.y);

                    var leafNoiseAmount = metadata.leafMotionNoiseRange.x +
                                          (leafNoise * metadata.leafMotionNoiseRange.y);

                    var generalTime = timeY +
                                      ((componentData.windMaskXZInfluence * timeXZ) /
                                       (1 + componentData.windMaskXZInfluence));

                    var colorAugment = new Color(
                        componentData.disableGeneralMotion
                            ? 0f
                            : Mathf.SmoothStep(
                                metadata.grassFadeR.x,
                                metadata.grassFadeR.y,
                                generalNoiseAmount * generalTime
                            ),
                        0f,
                        componentData.disableLeafMotion
                            ? 0f
                            : Mathf.SmoothStep(
                                metadata.grassFadeB.x,
                                metadata.grassFadeB.y,
                                leafNoiseAmount * timeXZ
                            ),
                        componentData.disableVariationMotion
                            ? 0f
                            : componentData.invertVariationMotion
                                ? 1 -
                                  Mathf.SmoothStep(
                                      metadata.grassFadeA.x,
                                      metadata.grassFadeA.y,
                                      variationNoiseAmount
                                  )
                                : Mathf.SmoothStep(
                                    metadata.grassFadeA.x,
                                    metadata.grassFadeA.y,
                                    variationNoiseAmount
                                )
                    );

                    var finalColor = maskColor * colorAugment;

                    finalColor.r = Mathf.Clamp01(finalColor.r * componentData.windStrengthModifier);
                    finalColor.g = Mathf.Clamp01(finalColor.g * componentData.branchStrengthModifier);
                    finalColor.b = Mathf.Clamp01(finalColor.b * componentData.leafStrengthModifier);

                    colors[indices[j]] = finalColor;
                }
            }

            return colors;
        }

        private List<Color> AssignWindMetadata_TreeMaterials_TreeCreator(
            Mesh mesh,
            Vector3 offset,
            Quaternion meshRotation,
            Vector3 scale,
            Tree tree,

            // ReSharper disable once UnusedParameter.Local
            List<MeshWindComponentData.TreeMaterialSet> materials)
        {
            var treeOffset = new Vector3(offset.x, offset.y, offset.z);

#if UNITY_EDITOR
            var treeData = tree.data as TreeEditor.TreeData;
            treeOffset.y += treeData.root.groundOffset;
#endif

            var bounds = new MeshBounds(mesh, treeOffset, meshRotation, scale);
            bounds.x.min = 0;
            bounds.z.min = 0;

            var colors = new List<Color>();

            for (var i = 0; i < mesh.vertexCount; i++)
            {
                colors.Add(metadata.baseColor);
            }

            var variationNoise = Perlin.Noise(mesh.bounds.size * metadata.variationNoiseScale);
            var variationNoiseAmount = metadata.variationNoiseRange.x +
                                       (variationNoise * metadata.variationNoiseRange.y);

            var vertices = new List<Vector3>();
            mesh.GetVertices(vertices);

            var indices = new List<int>();
            var uv1 = new List<Vector2>();
            mesh.GetUVs(0, uv1);

            for (var i = mesh.subMeshCount - 1; i >= 0; i--)
            {
                mesh.GetIndices(indices, i);

                for (var j = 0; j < indices.Count; j++)
                {
                    var vertex = vertices[indices[j]];
                    var updatedVertex = new Vector3(
                        vertex.x * scale.x,
                        vertex.y * scale.y,
                        vertex.z * scale.z
                    );
                    updatedVertex = meshRotation * updatedVertex;
                    updatedVertex += offset;
                    var uv = uv1[indices[j]];

                    var maskColor = Color.black; //windMask.GetPixelBilinear(uv.x, uv.y);

                    var timeX = Mathf.Clamp01(bounds.NormalizeX(Mathf.Abs(updatedVertex.x)));
                    var timeY = Mathf.Clamp01(bounds.NormalizeY(Mathf.Abs(updatedVertex.y)));
                    var timeZ = Mathf.Clamp01(bounds.NormalizeZ(Mathf.Abs(updatedVertex.z)));

                    var timeXYZ = Mathf.Max(timeX, Mathf.Max(timeY, timeZ));
                    var timeXZ = Mathf.Max(timeX,  timeZ);

                    var generalNoise = Perlin.Noise(metadata.generalMotionNoiseScale * updatedVertex.xz());
                    var leafNoise = 1 - Perlin.Noise(metadata.leafMotionNoiseScale * updatedVertex);

                    var generalNoiseAmount = metadata.generalMotionNoiseRange.x +
                                             (generalNoise * metadata.generalMotionNoiseRange.y);

                    var leafNoiseAmount = metadata.leafMotionNoiseRange.x +
                                          (leafNoise * metadata.leafMotionNoiseRange.y);

                    var generalTime = timeY +
                                      ((componentData.windMaskXZInfluence * timeXZ) /
                                       (1 + componentData.windMaskXZInfluence));

                    var colorAugment = new Color(
                        componentData.disableGeneralMotion
                            ? 0f
                            : Mathf.SmoothStep(
                                metadata.grassFadeR.x,
                                metadata.grassFadeR.y,
                                generalNoiseAmount * generalTime
                            ),
                        0f,
                        componentData.disableLeafMotion
                            ? 0f
                            : Mathf.SmoothStep(
                                metadata.grassFadeB.x,
                                metadata.grassFadeB.y,
                                leafNoiseAmount * timeXZ
                            ),
                        componentData.disableVariationMotion
                            ? 0f
                            : componentData.invertVariationMotion
                                ? 1 -
                                  Mathf.SmoothStep(
                                      metadata.grassFadeA.x,
                                      metadata.grassFadeA.y,
                                      variationNoiseAmount
                                  )
                                : Mathf.SmoothStep(
                                    metadata.grassFadeA.x,
                                    metadata.grassFadeA.y,
                                    variationNoiseAmount
                                )
                    );

                    var finalColor = maskColor * colorAugment;

                    finalColor.r = Mathf.Clamp01(finalColor.r * componentData.windStrengthModifier);
                    finalColor.g = Mathf.Clamp01(finalColor.g * componentData.branchStrengthModifier);
                    finalColor.b = Mathf.Clamp01(finalColor.b * componentData.leafStrengthModifier);

                    colors[indices[j]] = finalColor;
                }
            }

            return colors;
        }

        #region Nested type: MeshBounds

        public class MeshBounds
        {
            public MeshBounds(Mesh mesh, Vector3 offset, Quaternion meshRotation, Vector3 scale)
            {
                var vertices = new List<Vector3>();
                mesh.GetVertices(vertices);

                x.min = 10000f;
                x.max = -10000f;
                y.min = 10000f;
                y.max = -10000f;
                z.min = 10000f;
                z.max = -10000f;

                for (var i = 0; i < vertices.Count; i++)
                {
                    var vertex = vertices[i];
                    var updatedVertex = new Vector3(
                        vertex.x * scale.x,
                        vertex.y * scale.y,
                        vertex.z * scale.z
                    );
                    updatedVertex = meshRotation * updatedVertex;
                    updatedVertex += offset;

                    x.min = updatedVertex.x < x.min ? updatedVertex.y : x.min;
                    x.max = updatedVertex.x > x.max ? updatedVertex.y : x.max;
                    y.min = updatedVertex.y < y.min ? updatedVertex.y : y.min;
                    y.max = updatedVertex.y > y.max ? updatedVertex.y : y.max;
                    z.min = updatedVertex.z < z.min ? updatedVertex.z : z.min;
                    z.max = updatedVertex.z > z.max ? updatedVertex.z : z.max;
                }
            }

            #region Fields and Autoproperties

            public MinMax x = new();
            public MinMax y = new();
            public MinMax z = new();

            #endregion

            public float NormalizeX(float x)
            {
                return Normalize(x, this.x.min, this.x.max);
            }

            public float NormalizeY(float y)
            {
                return Normalize(y, this.y.min, this.y.max);
            }

            public float NormalizeZ(float z)
            {
                return Normalize(z, this.z.min, this.z.max);
            }

            private float Normalize(float val, float min, float max)
            {
                return (val - min) / (max - min);
            }

            #region Nested type: MinMax

            public class MinMax
            {
                #region Fields and Autoproperties

                public float max;
                public float min;

                #endregion
            }

            #endregion
        }

        #endregion

        #region Profiling

        private static readonly ProfilerMarker _PRF_AssignWindMetadata =
            new(_PRF_PFX + nameof(AssignWindMetadata));

        #endregion

#if UNITY_EDITOR
        [Button]
        [ShowIf(nameof(_showAllButtons))]
        [FoldoutGroup("Batch Operations", Order = 2000, Expanded = false)]
        public void AssignAllWindMetadata()
        {
            using (_PRF_AssignAllWindMetadata.Auto())
            {
                var components = FindObjectsOfType<MeshWindComponent>();

                foreach (var comp in components)
                {
                    comp.AssignWindMetadata();
                }
            }
        }

        [Button]
        public void AssignWindMetadata()
        {
            using (_PRF_AssignWindMetadata.Auto())
            {
                AssignWindMetadata(true);
            }
        }
#endif

#if UNITY_EDITOR
        [Button]
        [ShowIf(nameof(showGenerateMaskButton))]
        public void GenerateDefaultWindMask()
        {
            var meshFilter = GetComponentsInChildren<MeshFilter>()
                            .OrderByDescending(mf => mf.sharedMesh.vertexCount)
                            .FirstOrDefault();

            var r = meshFilter.GetComponent<Renderer>();

            var material = r.sharedMaterials[0];

            var texture = (material.mainTexture
                ? material.mainTexture
                : material.GetTexture(
                    material.GetTexturePropertyNames()
                            .FirstOrDefault(
                                 m => m.ToLowerInvariant().Contains("color") ||
                                      m.ToLowerInvariant().Contains("albedo") ||
                                      m.ToLowerInvariant().Contains("diffuse") ||
                                      m.ToLowerInvariant().Contains("base") ||
                                      m.ToLowerInvariant().Contains("maint")
                             )
                )) as Texture2D;

            var texturePath = AssetDatabaseManager.GetAssetPath(texture);
            var importer = AssetImporter.GetAtPath(texturePath) as TextureImporter;
            var textureSettings = new TextureImporterSettings();
            importer.ReadTextureSettings(textureSettings);

            var newPath = ZString.Format(
                "{0}\\{1}_wind.png",
                AppaPath.GetDirectoryName(texturePath),
                AppaPath.GetFileNameWithoutExtension(texturePath)
            );

            var tex = new Texture2D(
                (int)generatedMaskSize,
                (int)generatedMaskSize,
                TextureFormat.ARGB32,
                true
            );

            AppaFile.WriteAllBytes(newPath, tex.EncodeToPNG());

            AssetDatabaseManager.Refresh();

            var textureImporter = (TextureImporter)AssetImporter.GetAtPath(newPath);

            textureSettings.sRGBTexture = false;
            textureSettings.textureType = TextureImporterType.Default;
            textureImporter.SetTextureSettings(textureSettings);
            textureImporter.SaveAndReimport();
        }

        [Button]
        [ShowIf(nameof(showPopulateTreeMaterialsButton))]
        public void PopulateTreeMaterials()
        {
            var renderers = GetComponentsInChildren<MeshRenderer>();

            var materials = renderers.SelectMany(rm => rm.sharedMaterials);

            foreach (var material in materials)
            {
                if (componentData.treeMaterials.Any(tm => (tm.material == material) && (tm.windMask != null)))
                {
                    continue;
                }

                var texture = (material.mainTexture
                    ? material.mainTexture
                    : material.GetTexture(
                        material.GetTexturePropertyNames()
                                .FirstOrDefault(
                                     m => m.ToLowerInvariant().Contains("color") ||
                                          m.ToLowerInvariant().Contains("albedo") ||
                                          m.ToLowerInvariant().Contains("diffuse") ||
                                          m.ToLowerInvariant().Contains("base") ||
                                          m.ToLowerInvariant().Contains("maint")
                                 )
                    )) as Texture2D;

                var texturePath = AssetDatabaseManager.GetAssetPath(texture);
                var importer = AssetImporter.GetAtPath(texturePath) as TextureImporter;
                var textureSettings = new TextureImporterSettings();
                importer.ReadTextureSettings(textureSettings);

                var newPath = ZString.Format(
                    "{0}\\{1}_wind.png",
                    AppaPath.GetDirectoryName(texturePath),
                    AppaPath.GetFileNameWithoutExtension(texturePath)
                );

                var tex = new Texture2D(
                    (int)generatedMaskSize,
                    (int)generatedMaskSize,
                    TextureFormat.ARGB32,
                    true
                );

                AppaFile.WriteAllBytes(newPath, tex.EncodeToPNG());

                AssetDatabaseManager.Refresh();

                var textureImporter = (TextureImporter)AssetImporter.GetAtPath(newPath);

                textureSettings.sRGBTexture = false;
                textureSettings.textureType = TextureImporterType.Default;
                textureImporter.SetTextureSettings(textureSettings);
                textureImporter.SaveAndReimport();

                tex = AssetDatabaseManager.LoadAssetAtPath<Texture2D>(newPath);

                var treeMaterial =
                    new MeshWindComponentData.TreeMaterialSet { material = material, windMask = tex };

                componentData.treeMaterials.Add(treeMaterial);
            }
        }

        [Button]
        [ShowIf(nameof(_showRevertButtons))]
        [FoldoutGroup("Revert", Order = 1000, Expanded = false)]
        public void Revert()
        {
            try
            {
                var renderers = GetComponentsInChildren<MeshRenderer>();

                foreach (var renderer_ in renderers)
                {
                    var currentMesh = renderer_.GetSharedMesh();

                    var matchingRecoveryInfo =
                        componentData.recoveryInfo.FirstOrDefault(ri => ri.updated == currentMesh);

                    if ((matchingRecoveryInfo != null) && (matchingRecoveryInfo.original != null))
                    {
                        var mf = renderer_.GetComponent<MeshFilter>();
                        mf.sharedMesh = matchingRecoveryInfo.original;
                    }
                    else if ((currentMesh != null) && currentMesh.name.Contains("_ADSP"))
                    {
                        var mf = renderer_.GetComponent<MeshFilter>();
                        mf.sharedMesh = null;
                    }

                    componentData.recoveryInfo.Clear();
                }
            }
            catch (Exception ex)
            {
                Context.Log.Error(ZString.Format("Failed to revert mesh wind data to {0}.", name), this);
                Context.Log.Error(ex,                                                              this);
            }
        }

        [Button]
        [ShowIf(nameof(_showBatchRevertButtons))]
        [FoldoutGroup("Batch Operations", Order = 2000, Expanded = false)]
        public void RevertMismatchedRecoveryData()
        {
            using (_PRF_RevertMismatchedRecoveryData.Auto())
            {
                var components = FindObjectsOfType<MeshWindComponent>();

                foreach (var comp in components)
                {
                    var renderers = comp.GetComponentsInChildren<MeshRenderer>();

                    if (comp.componentData.recoveryInfo.Count != renderers.Length)
                    {
                        comp.Revert();
                    }
                }
            }
        }

        [Button]
        [FoldoutGroup("Batch Operations", Order = 2000, Expanded = false)]
        public void ShowAllButtons()
        {
            _showAllButtons = !_showAllButtons;
        }

        [Button]
        [FoldoutGroup("Revert", Order = 1000, Expanded = false)]
        public void ShowRevertButtons()
        {
            _showRevertButtons = !_showRevertButtons;
        }
#endif

#if UNITY_EDITOR
        private static readonly ProfilerMarker _PRF_AssignAllWindMetadata =
            new(_PRF_PFX + nameof(AssignAllWindMetadata));

        private static readonly ProfilerMarker _PRF_RevertMismatchedRecoveryData =
            new(_PRF_PFX + nameof(RevertMismatchedRecoveryData));
#endif
    }
}
