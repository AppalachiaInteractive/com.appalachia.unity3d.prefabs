using UnityEngine;
using UnityEngine.Rendering;

namespace Appalachia.Core.Rendering.States
{
    public struct RendererLightData
    {
        public RendererLightData(
            ShadowCastingMode shadowCastingMode,
            bool isShadowReceiving,
            LightProbeUsage lightProbeUsage,
            GameObject lightProbeProxyVolumeOverride)
        {
            this.shadowCastingMode = shadowCastingMode;
            this.isShadowReceiving = isShadowReceiving;
            this.lightProbeUsage = lightProbeUsage;
            this.lightProbeProxyVolumeOverride = lightProbeProxyVolumeOverride;
        }

        public readonly ShadowCastingMode shadowCastingMode;
        public readonly bool isShadowReceiving;
        public readonly LightProbeUsage lightProbeUsage;
        public readonly GameObject lightProbeProxyVolumeOverride;
    }
}
