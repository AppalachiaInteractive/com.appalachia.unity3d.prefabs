using Appalachia.Core.Objects.Root;
using Sirenix.OdinInspector;
using UnityEngine;

namespace Appalachia.Rendering.Lighting.Occlusion
{
    public class OcclusionProbeData : AppalachiaObject<OcclusionProbeData>
    {
        #region Fields and Autoproperties

        [Header("Baked Results")]
        [PropertyTooltip("Affects grass occlusion as well.")]
        [PropertyRange(0, 1)]
        public float reflectionOcclusionAmount = 0.5f;

        [Header("Internal Data")]
        public Matrix4x4 worldToLocal;

        public Texture3D occlusion;
        public Matrix4x4[] worldToLocalDetail;
        public Texture3D[] occlusionDetail;

        #endregion
    }
}
