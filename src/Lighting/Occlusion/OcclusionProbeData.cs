using Appalachia.Core.Scriptables;
using UnityEngine;

namespace Appalachia.Rendering.Lighting.Occlusion
{
    public class OcclusionProbeData :AppalachiaObject
    {
        [Header("Baked Results")]
        [Tooltip("Affects grass occlusion as well.")]
        [Range(0, 1)]
        public float reflectionOcclusionAmount = 0.5f;

        [Header("Internal Data")]
        public Matrix4x4 worldToLocal;

        public Texture3D occlusion;
        public Matrix4x4[] worldToLocalDetail;
        public Texture3D[] occlusionDetail;
    }
}
