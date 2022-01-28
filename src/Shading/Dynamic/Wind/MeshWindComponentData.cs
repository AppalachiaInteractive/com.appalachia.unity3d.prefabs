#region

using System;
using System.Collections.Generic;
using Appalachia.Core.Objects.Root;
using Appalachia.Core.Objects.Scriptables;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Shading.Dynamic.Wind
{
    public class MeshWindComponentData : EmbeddedAppalachiaObject<MeshWindComponentData>
    {
        
        
        public enum MeshWindStyle
        {
            FadeUp,
            Material,
            Texture2D,
            TreeMaterials
        }

        public enum TextureSize
        {
            k4096 = 4096,
            k2048 = 2048,
            k1024 = 1024,
            k512 = 512,
            k256 = 256,
            k128 = 128,
            k64 = 64,
            k32 = 32
        }

        public bool disableGeneralMotion;
        public bool disableBranchMotion;
        public bool disableLeafMotion;
        public bool disableVariationMotion;
        public bool invertVariationMotion = true;

        public MeshWindStyle style;

        [ShowIf(nameof(showMaterial))]
        public MeshWindMetadata.MeshWindModel windModel = new();

        [ShowIf(nameof(showWindMask))]
        public Texture2D windMask;

        [ShowIf(nameof(showTreeMaterials))]
        public List<TreeMaterialSet> treeMaterials = new();

        [ShowIf(nameof(showWindMask))]
        [PropertyRange(0f, 1f)]
        public float windMaskXZInfluence = .25f;

        [PropertyRange(0.1f, 2f)] public float windStrengthModifier = 1f;

        [PropertyRange(0.1f, 2f)] public float branchStrengthModifier = 1f;

        [PropertyRange(0.1f, 2f)] public float leafStrengthModifier = 1f;

        [HideInInspector] public List<WindMeshSet> recoveryInfo = new();

        private bool showGrassFade => style == MeshWindStyle.FadeUp;

        private bool showMaterial => style == MeshWindStyle.Material;

        private bool showWindMask => style == MeshWindStyle.Texture2D;

        private bool showTreeMaterials => style == MeshWindStyle.TreeMaterials;

        [Serializable]
        public class WindMeshSet : AppalachiaSimpleBase
        {
            public Mesh original;
            public List<Material> originalMaterials = new();
            public Mesh updated;
        }

        [Serializable]
        public class TreeMaterialSet : AppalachiaSimpleBase
        {
            public Material material;
            public Texture2D windMask;
        }
    }
}
