#if UNITY_EDITOR
using Appalachia.Editing.Visualizers;
using Appalachia.Utility.Async;
using Sirenix.OdinInspector;
using UnityEngine;

namespace Appalachia.Rendering.Lighting.Occlusion.Visualizers
{
    [ExecuteAlways]
    public sealed class OcclusionProbeTester : InstancedIndirectVolumeVisualization<OcclusionProbeTester>
    {
        #region Fields and Autoproperties

        [OnValueChanged(nameof(Regenerate))]
        public OcclusionProbes probes;

        #endregion

        /// <inheritdoc />
        protected override bool CanGenerate => probes != null;

        /// <inheritdoc />
        protected override bool CanVisualize => probes != null;

        /// <inheritdoc />
        protected override bool ShouldRegenerate => false;

        /// <inheritdoc />
        protected override Bounds GetBounds()
        {
            if (probes == null)
            {
                probes = FindObjectOfType<OcclusionProbes>();
            }

            if (probes == null)
            {
                return default;
            }

            var probesTransform = probes.transform;

            var bounds = new Bounds
            {
                center = probesTransform.position,
                size = probesTransform.lossyScale + (Vector3.one * (visualizationSize * 3.0f))
            };

            return bounds;
        }

        /// <inheritdoc />
        protected override void PrepareInitialGeneration()
        {
            if (probes == null)
            {
                probes = FindObjectOfType<OcclusionProbes>();
            }
        }

        /// <inheritdoc />
        protected override void PrepareSubsequentGenerations()
        {
            if (probes == null)
            {
                probes = FindObjectOfType<OcclusionProbes>();
            }
        }

        /// <inheritdoc />
        protected override async AppaTask WhenDisabled()
        {
            await base.WhenDisabled();

            probes = null;
        }
    }
}

#endif
