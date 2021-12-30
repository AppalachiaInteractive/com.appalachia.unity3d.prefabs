using Appalachia.Core.Objects.Root;
using UnityEngine;

namespace Appalachia.Rendering.Lighting.Occlusion
{
    public class OcclusionProbeData : AppalachiaObject<OcclusionProbeData>
    {
        #region Fields and Autoproperties

        [Header("Baked Results")]
        [Tooltip("Affects grass occlusion as well.")]
        [Range(0, 1)]
        public float reflectionOcclusionAmount = 0.5f;

        [Header("Internal Data")]
        public Matrix4x4 worldToLocal;

        public Texture3D occlusion;
        public Matrix4x4[] worldToLocalDetail;
        public Texture3D[] occlusionDetail;

        #endregion
    }
}
