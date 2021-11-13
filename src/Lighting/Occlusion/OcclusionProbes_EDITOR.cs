#if UNITY_EDITOR
using System;
using System.Collections.Generic;
using Appalachia.CI.Integration.Assets;
using Appalachia.Core.Debugging;
using Appalachia.Utility.Logging;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace Appalachia.Rendering.Lighting.Occlusion
{
    public partial class OcclusionProbes
    {
        public const string OcclusionBake = "OcclusionBake";

        [Header("Resolution")] public int m_XCount = 10;

        public int m_YCount = 10;
        public int m_ZCount = 10;

        [Header("Settings")]
        [Range(0, 1)]
        [Tooltip(
            "Portion of rays allowed to hit backfaces of non-double-sided objects. If more rays hit, the probe will be considered invalid and possibly overwritten by dilation."
        )]
        public float m_BackfaceTolerance;

        [Range(0, 5)]
        [Tooltip(
            "Propagates valid probes over invalid ones located inside objects, to limit darkness leaks."
        )]
        public int m_DilateIterations = 3;

        [Range(0, 1)]
        [Tooltip(
            "Offsets rays away from the probe center to limit self occlusion. 1 will offset in all directions by the distance equal to the nearest probe in any direction."
        )]
        public float m_RayOffset = 0.8f;

        [Header("Detail Sets")] public List<OcclusionProbesDetail> m_OcclusionProbesDetail;

        [Header("Objects")] public GameObject occlusionBakeObjects;

        private Vector3i m_CountBaked = new(0, 0, 0);
        private Vector3i[] m_CountBakedDetail;
        private int m_SampleCountBaked;
        private Matrix4x4 m_WorldToLocal;
        private Matrix4x4[] m_WorldToLocalDetail;

        private void OnDrawGizmosSelected()
        {
            if (!GizmoCameraChecker.ShouldRenderGizmos())
            {
                return;
            }

            DrawGizmos(transform, m_XCount, m_YCount, m_ZCount);
        }

        private void OnValidate()
        {
            m_XCount = Mathf.Max(2, m_XCount);
            m_YCount = Mathf.Max(2, m_YCount);
            m_ZCount = Mathf.Max(2, m_ZCount);
        }

        private void AddLightmapperCallbacks()
        {
            UnityEditor.Lightmapping.bakeStarted += Started;
            UnityEditor.Lightmapping.bakeCompleted += Completed;
        }

        private void RemoveLightmapperCallbacks()
        {
            UnityEditor.Lightmapping.bakeStarted -= Started;
            UnityEditor.Lightmapping.bakeCompleted -= Completed;
        }

        private void Started()
        {
            if (!UnityEditor.Lightmapping.bakedGI)
            {
               AppaLog.Warn(
                    "Lightmapping started.  Occlusion probes will not bake as Baked GI is not enabled."
                );
                return;
            }

           AppaLog.Warn("Lightmapping & occlusion probes baking started.");

            VegetationStudioOcclusionProbeIntegration.BakeStarted(occlusionBakeObjects);

            var probeCount = m_XCount * m_YCount * m_ZCount;
            if (probeCount == 0)
            {
                return;
            }

            // TODO: skip null detail things

            var detailSetCount = 0;
            foreach (var detail in m_OcclusionProbesDetail)
            {
                if ((detail == null) || !detail.gameObject.activeSelf)
                {
                    continue;
                }

                probeCount += detail.m_XCount * detail.m_YCount * detail.m_ZCount;
                detailSetCount++;
            }

            var positions = new Vector4[probeCount];

            // Main
            var size = transform.localScale;
            var localToWorld = Matrix4x4.TRS(
                transform.position - (size * 0.5f),
                transform.rotation,
                size
            );
            m_WorldToLocal = localToWorld.inverse;
            m_CountBaked = new Vector3i(m_XCount, m_YCount, m_ZCount);

            var indexOffset = 0;
            GenerateProbePositions(
                ref positions,
                ref indexOffset,
                m_CountBaked,
                localToWorld,
                CalculateRayOffset(m_RayOffset, size, m_CountBaked)
            );

            // Detail
            m_CountBakedDetail = new Vector3i[detailSetCount];
            m_WorldToLocalDetail = new Matrix4x4[detailSetCount];

            var i = 0;
            foreach (var detail in m_OcclusionProbesDetail)
            {
                if ((detail == null) || !detail.gameObject.activeSelf)
                {
                    continue;
                }

                var t = detail.transform;
                var sizeDetail = t.localScale;
                var localToWorldDetail = Matrix4x4.TRS(
                    t.position - (sizeDetail * 0.5f),
                    t.rotation,
                    sizeDetail
                );
                m_WorldToLocalDetail[i] = localToWorldDetail.inverse;
                m_CountBakedDetail[i] = new Vector3i(
                    detail.m_XCount,
                    detail.m_YCount,
                    detail.m_ZCount
                );
                GenerateProbePositions(
                    ref positions,
                    ref indexOffset,
                    m_CountBakedDetail[i],
                    localToWorldDetail,
                    CalculateRayOffset(detail.m_RayOffset, sizeDetail, m_CountBakedDetail[i])
                );
                i++;
            }

            // TODO: Due to a buggy Hammersley sequence implementation,
            // 2048 is the only sample count that covers the entire sphere ;)
            // But 1024 just so happens to cover the upper hemisphere, and that's what we want.
            var sampleCount = 1024;

            if (!BakeDisabled)
            {
                UnityEditor.Experimental.Lightmapping.SetCustomBakeInputs(positions, sampleCount);

                // As long as this component is active, prevent light probes from
                // capturing direct sky light. That part will come from the ambient probe in the shader.
                UnityEditor.Experimental.Lightmapping.probesIgnoreDirectEnvironment = true;
            }

            m_SampleCountBaked = sampleCount;
        }

        private static float CalculateRayOffset(
            float rayOffsetRelative,
            Vector3 size,
            Vector3i count)
        {
            var minProbeDistance = Mathf.Min(
                Mathf.Min(size.x / (count.x - 1), size.y / (count.y - 1)),
                size.z / (count.z - 1)
            );

            // Clamp to [0.001, 1.0], because w = 0 is reserved for marking unused texels.
            return minProbeDistance * Mathf.Max(0.001f, rayOffsetRelative);
        }

        private static void GenerateProbePositions(
            ref Vector4[] positions,
            ref int indexOffset,
            Vector3i count,
            Matrix4x4 localToWorld,
            float rayOffset)
        {
            for (var z = 0; z < count.z; z++)
            {
                Vector3 localPos;
                localPos.z = (float) z / (count.z - 1);
                for (var y = 0; y < count.y; y++)
                {
                    localPos.y = (float) y / (count.y - 1);
                    for (var x = 0; x < count.x; x++)
                    {
                        localPos.x = (float) x / (count.x - 1);
                        var worldPos = localToWorld.MultiplyPoint3x4(localPos);
                        positions[indexOffset] = worldPos;
                        positions[indexOffset].w = rayOffset;
                        indexOffset++;
                    }
                }
            }
        }

        private void Completed()
        {
            if (!UnityEditor.Lightmapping.bakedGI)
            {
               AppaLog.Warn(
                    "Lightmapping completed.  Occlusion probes did not bake as Baked GI is not enabled."
                );
                return;
            }

           AppaLog.Warn("Lightmapping & occlusion probes baking completed.");

            VegetationStudioOcclusionProbeIntegration.BakeCompleted(occlusionBakeObjects);

            var count = m_CountBaked.x * m_CountBaked.y * m_CountBaked.z;
            if (count == 0)
            {
               AppaLog.Warn("No occlusion probes baked.");
                return;
            }

            foreach (var c in m_CountBakedDetail)
            {
                count += c.x * c.y * c.z;
            }

           AppaLog.Warn($"Baked {count} occlusion probes.");

            var results = new Vector4[count];

            if (!UnityEditor.Experimental.Lightmapping.GetCustomBakeResults(results))
            {
                AppaLog.Error("Failed to fetch the occlusion probe bake results.");
                return;
            }

           AppaLog.Warn($"Retrieved {count} custom baking results.");

            var dataPath = SceneToOcclusionProbeDataPath(gameObject.scene, "OcclusionProbeData");

            // We don't care where was the old asset we were referencing. The new one has to be at the
            // canonical path. So we check if it's there already.
            m_Data = AssetDatabaseManager.LoadMainAssetAtPath(dataPath) as OcclusionProbeData;

            if (m_Data == null)
            {
                // Assigning a new asset, dirty the scene that contains it, so that the user knows to save it.
                UnityEditor.SceneManagement.EditorSceneManager.MarkSceneDirty(gameObject.scene);
                m_Data = ScriptableObject.CreateInstance<OcclusionProbeData>();
                AssetDatabaseManager.CreateAsset(m_Data, dataPath);
            }
            else
            {
                // Clean up the old textures
                DestroyImmediate(m_Data.occlusion, true);
                if (m_Data.occlusionDetail != null)
                {
                    foreach (var tex in m_Data.occlusionDetail)
                    {
                        DestroyImmediate(tex, true);
                    }
                }
            }

            // Normalize
            for (var i = 0; i < count; ++i)
            {
                results[i] /= m_SampleCountBaked;
            }

            // Main occlusion probe set
            var indexOffset = 0;
            var dataCount = m_CountBaked.x * m_CountBaked.y * m_CountBaked.z;
            var data = new Vector4[dataCount];
            Array.Copy(results, indexOffset, data, 0, dataCount);
            indexOffset += dataCount;

            m_Data.occlusion = CreateOcclusionTexture(
                data,
                m_CountBaked,
                m_BackfaceTolerance,
                m_DilateIterations,
                "Sky Occlusion",
                true
            );
            m_Data.worldToLocal = m_WorldToLocal;

            AssetDatabaseManager.AddObjectToAsset(m_Data.occlusion, m_Data);

            // Detail occlusion probe sets
            var detailSetCount = m_CountBakedDetail.Length;
            m_Data.occlusionDetail = new Texture3D[detailSetCount];
            m_Data.worldToLocalDetail = new Matrix4x4[detailSetCount];
            for (var i = 0; i < detailSetCount; i++)
            {
                var dataCountDetail = m_CountBakedDetail[i].x *
                                      m_CountBakedDetail[i].y *
                                      m_CountBakedDetail[i].z;
                var dataDetail = new Vector4[dataCountDetail];
                Array.Copy(results, indexOffset, dataDetail, 0, dataCountDetail);
                indexOffset += dataCountDetail;

                m_Data.occlusionDetail[i] = CreateOcclusionTexture(
                    dataDetail,
                    m_CountBakedDetail[i],
                    m_BackfaceTolerance,
                    m_DilateIterations,
                    "Sky Occlusion Detail " + i
                );
                m_Data.worldToLocalDetail[i] = m_WorldToLocalDetail[i];

                AssetDatabaseManager.AddObjectToAsset(m_Data.occlusionDetail[i], m_Data);
            }

            // Ambient probe
            BakeAmbientProbe();

            AssetDatabaseManager.SaveAssets();

            m_CountBaked = new Vector3i(0, 0, 0);
            UnityEditor.Lightmapping.bakedGI = false;
        }

        private static Texture3D CreateOcclusionTexture(
            Vector4[] data,
            Vector3i count,
            float backfaceTolerance,
            int dilateIterations,
            string name,
            bool clampEdgesToWhite = false)
        {
            // For invalid probes (i.e. hitting more backfaces than the allowed backfaceTolerance percentage),
            // overwrite their value with the average value of their valid neighbours.
            DilateOverInvalidProbes(ref data, count, backfaceTolerance, dilateIterations);

            // Clamp edges to white, otherwise extrapolation doesn't make sense
            if (clampEdgesToWhite)
            {
                ClampEdgesToWhite(ref data, count);
            }

            // Create the 3D occlusion texture
            var tex = new Texture3D(count.x, count.y, count.z, TextureFormat.Alpha8, false);
            var length = count.x * count.y * count.z;
            var colorData = new Color32[length];
            for (var i = 0; i < length; ++i)
            {
                var occ = (byte) Mathf.Clamp((int) (data[i].x * 255), 0, 255);
                colorData[i] = new Color32(occ, occ, occ, occ);
            }

            tex.SetPixels32(colorData);
            tex.Apply();
            tex.wrapMode = TextureWrapMode.Clamp;

            // tex.filterMode = FilterMode.Point;
            tex.name = name;

            return tex;
        }

        public void BakeAmbientProbe()
        {
            var dataPath = SceneToOcclusionProbeDataPath(gameObject.scene, "AmbientProbeData");

            // We don't care where was the old asset we were referencing. The new one has to be at the
            // canonical path. So we check if it's there already.
            var oldData = m_AmbientProbeData;
            m_AmbientProbeData = AssetDatabaseManager.LoadMainAssetAtPath(dataPath) as AmbientProbeData;

            if ((m_AmbientProbeData == null) || (m_AmbientProbeData != oldData))
            {
                // Assigning a new asset, dirty the scene that contains it, so that the user knows to save it.
                UnityEditor.EditorUtility.SetDirty(this);
                UnityEditor.SceneManagement.EditorSceneManager.MarkSceneDirty(gameObject.scene);
            }

            if (m_AmbientProbeData == null)
            {
                m_AmbientProbeData = ScriptableObject.CreateInstance<AmbientProbeData>();
                AssetDatabaseManager.CreateAsset(m_AmbientProbeData, dataPath);
            }

            var ambientProbe = RenderSettings.ambientProbe;
            m_AmbientProbeData.sh = new Vector4[7];

            // LightProbes.GetShaderConstantsFromNormalizedSH(ref ambientProbe, m_AmbientProbeData.sh);
            GetShaderConstantsFromNormalizedSH(ref ambientProbe, m_AmbientProbeData.sh);
            UnityEditor.EditorUtility.SetDirty(m_AmbientProbeData);
        }

        private string SceneToOcclusionProbeDataPath(Scene scene, string name)
        {
            // Scene path: "Assets/Folder/Scene.unity"
            // We want: "Assets/Folder/Scene/OcclusionProbeData.asset"
            var suffixLength = 6;
            var path = scene.path;

            if (path.Substring(path.Length - suffixLength) != ".unity")
            {
                AppaLog.Error("Something's wrong with the path to the scene", this);
            }

            return path.Substring(0, path.Length - suffixLength) + "/" + name + ".asset";
        }

        private static void DrawEdgeSpheres(Vector3 size, float radius, int count, int axis)
        {
            for (var i = 0; i < count; i++)
            {
                var pos = Vector3.one * 0.5f;
                pos[axis] = 0.5f - ((float) i / (count - 1));
                Gizmos.DrawWireSphere(Vector3.Scale(size, pos), radius);
                pos[(axis + 1) % 3] *= -1;
                Gizmos.DrawWireSphere(Vector3.Scale(size, pos), radius);
                pos[(axis + 2) % 3] *= -1;
                Gizmos.DrawWireSphere(Vector3.Scale(size, pos), radius);
                pos[(axis + 1) % 3] *= -1;
                Gizmos.DrawWireSphere(Vector3.Scale(size, pos), radius);
            }
        }

        public static void DrawGizmos(Transform t, int x, int y, int z)
        {
            var mat = Matrix4x4.TRS(t.position, t.rotation, Vector3.one);
            Gizmos.matrix = t.localToWorldMatrix;
            Gizmos.matrix = mat;
            var size = t.localScale;
            Gizmos.DrawWireCube(Vector3.zero, size);

            var radius = 0.2f * Mathf.Min(size.x / x, Mathf.Min(size.y / y, size.z / z));
            DrawEdgeSpheres(size, radius, x, 0);
            DrawEdgeSpheres(size, radius, y, 1);
            DrawEdgeSpheres(size, radius, z, 2);
        }
    }
}
#endif
