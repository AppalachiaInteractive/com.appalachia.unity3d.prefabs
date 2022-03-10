#region

using System;
using System.Collections.Generic;
using Appalachia.Core.Objects.Root;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Shading.Dynamic
{
    public class MeshShadingMetadata : AppalachiaObject
    {
        public enum MeshChannelValueType
        {
            None,
            MeshLocalCenter,
            MeshBounds,
            Explicit
        }

        public enum MeshDataChannel
        {
            UV = 0,
            UV2 = 1,
            UV3 = 2,
            UV4 = 3,
            UV5 = 4,
            UV6 = 5,
            UV7 = 6,
            UV8 = 7
        }

        public enum MeshFieldValueType
        {
            None,
            MaterialTextureArrayOverride,
            TextureArrayIndex,
            ShaderSet,
            Explicit
        }

        #region Fields and Autoproperties

        [ListDrawerSettings(IsReadOnly = false)]
        public List<SubmeshShadingMetadata> submeshMetadata = new();

        #endregion

        public Vector4[][] Calculate(Mesh mesh, Vector3 meshCenterOffset)
        {
            var results = new Vector4[submeshMetadata.Count][];

            for (var i = 0; i < submeshMetadata.Count; i++)
            {
                results[i] = submeshMetadata[i].Calculate(mesh, meshCenterOffset);
            }

            return results;
        }

        #region Nested type: SubmeshShadingChannelMetadata

        [Serializable]
        public class SubmeshShadingChannelMetadata : AppalachiaSimpleBase
        {
            #region Fields and Autoproperties

            public bool enabled = true;

            [EnableIf(nameof(enabled))]
            public MeshChannelValueType channelValueType = MeshChannelValueType.None;

            public MeshDataChannel channel;

            [EnableIf(nameof(enabled))]
            [ShowIf(nameof(showFields))]
            public SubmeshShadingFieldMetadata w;

            [EnableIf(nameof(enabled))]
            [ShowIf(nameof(showFields))]
            public SubmeshShadingFieldMetadata x;

            [EnableIf(nameof(enabled))]
            [ShowIf(nameof(showFields))]
            public SubmeshShadingFieldMetadata y;

            [EnableIf(nameof(enabled))]
            [ShowIf(nameof(showFields))]
            public SubmeshShadingFieldMetadata z;

            [EnableIf(nameof(enabled))]
            [ShowIf(nameof(showExplicit))]
            public Vector4 explicitValue;

            #endregion

            private bool showExplicit => channelValueType == MeshChannelValueType.Explicit;
            private bool showFields => channelValueType == MeshChannelValueType.None;

            public Vector4 Calculate(Mesh mesh, Vector3 meshCenterOffset)
            {
                if (!enabled)
                {
                    return Vector4.zero;
                }

                switch (channelValueType)
                {
                    case MeshChannelValueType.None:

                        var result = Vector4.zero;

                        result.x = x.CalculateValue();
                        result.y = y.CalculateValue();
                        result.z = z.CalculateValue();
                        result.w = w.CalculateValue();

                        return result;

                    case MeshChannelValueType.MeshLocalCenter:

                        var size = mesh.bounds.size;
                        return new Vector3(
                            size.x * meshCenterOffset.x,
                            size.y * meshCenterOffset.y,
                            size.z * meshCenterOffset.z
                        );

                    case MeshChannelValueType.MeshBounds:
                        return mesh.bounds.size;

                    case MeshChannelValueType.Explicit:
                        return explicitValue;

                    default:
                        throw new ArgumentOutOfRangeException();
                }
            }
        }

        #endregion

        #region Nested type: SubmeshShadingFieldMetadata

        [Serializable]
        public class SubmeshShadingFieldMetadata : AppalachiaSimpleBase
        {
            #region Fields and Autoproperties

            [OnValueChanged(nameof(UpdateArrayConfig))]
            [EnableIf(nameof(enabled))]
            [HideIf(nameof(HideConfigArray))]
            public AppalachiaTextureArrayConfig arrayConfig;

            public bool enabled = true;

            [EnableIf(nameof(enabled))]
            [HideIf(nameof(HideExplicit))]
            public float value;

            [EnableIf(nameof(enabled))]
            [HideIf(nameof(HideShaderTextureSetId))]
            [PropertyRange(0, nameof(ShaderSetMax))]
            public int shaderTextureSetId;

            [EnableIf(nameof(enabled))]
            [HideIf(nameof(HideTextureArrayIndex))]
            [PropertyRange(0, nameof(ArrayRangeMax))]
            public int textureArrayIndex;

            [EnableIf(nameof(enabled))]
            public MeshFieldValueType fieldValueType = MeshFieldValueType.None;

            [EnableIf(nameof(enabled))]
            [HideIf(nameof(HideShaderTextureSet))]
            public ShaderTextureSet shaderTextureSet;

            [ReadOnly]
            [HideIf(nameof(HideConfigArray))]
            public Texture2DArray textureArray;

            #endregion

            private bool HideConfigArray =>
                fieldValueType is not (MeshFieldValueType.MaterialTextureArrayOverride
                    or MeshFieldValueType.TextureArrayIndex or MeshFieldValueType.ShaderSet);

            private bool HideExplicit => fieldValueType != MeshFieldValueType.Explicit;

            private bool HideShaderTextureSet => fieldValueType != MeshFieldValueType.ShaderSet;

            private bool HideShaderTextureSetId => fieldValueType != MeshFieldValueType.ShaderSet;

            private bool HideTextureArrayIndex => fieldValueType != MeshFieldValueType.TextureArrayIndex;

            private int ArrayRangeMax =>
                textureArray == null
                    ? 0
                    : arrayConfig == null
                        ? 0
                        : arrayConfig.diffuseArray == null
                            ? 0
                            : arrayConfig.diffuseArray.depth - 1;

            private int ShaderSetMax =>
                shaderTextureSet == null
                    ? 0
                    : shaderTextureSet.textureSets == null
                        ? 0
                        : shaderTextureSet.textureSets.Count == 0
                            ? 0
                            : shaderTextureSet.textureSets.Count - 1;

            [ReadOnly]
            [HideIf(nameof(HideShaderTextureSet))]
            [ShowInInspector]
            private string ShaderTextureSetName =>
                shaderTextureSet == null ? string.Empty : shaderTextureSet.NameByIndex(shaderTextureSetId);

            public float CalculateValue()
            {
                switch (fieldValueType)
                {
                    case MeshFieldValueType.MaterialTextureArrayOverride:
                    case MeshFieldValueType.TextureArrayIndex:
                        return textureArrayIndex;

                    case MeshFieldValueType.ShaderSet:
                        return shaderTextureSetId;

                    case MeshFieldValueType.Explicit:
                        return value;

                    default:
                        return 0f;
                }
            }

            private void UpdateArrayConfig()
            {
                textureArray = arrayConfig.diffuseArray;
            }
        }

        #endregion

        #region Nested type: SubmeshShadingMetadata

        [Serializable]
        public class SubmeshShadingMetadata : AppalachiaSimpleBase
        {
            #region Fields and Autoproperties

            public bool enabled = true;
            public int submesh;

            [EnableIf(nameof(enabled))]
            public List<SubmeshShadingChannelMetadata> channels = new();

            [EnableIf(nameof(enabled))]
            public Material material;

            #endregion

            public Vector4[] Calculate(Mesh mesh, Vector3 meshCenterOffset)
            {
                var results = new Vector4[channels.Count];

                for (var i = 0; i < results.Length; i++)
                {
                    results[i] = channels[i].Calculate(mesh, meshCenterOffset);
                }

                return results;
            }
        }

        #endregion

        #region Menu Items

#if UNITY_EDITOR
        [UnityEditor.MenuItem(PKG.Menu.Assets.Base + nameof(MeshShadingMetadata), priority = PKG.Menu.Assets.Priority)]
        public static void CreateAsset()
        {
            CreateNew<MeshShadingMetadata>();
        }
#endif

        #endregion
    }
}
