#region

using System;
using Appalachia.Core.Attributes.Editing;
using Appalachia.Rendering.Prefabs.Rendering.ModelType.Rendering;
using GPUInstancer;
using Sirenix.OdinInspector;
using Unity.Profiling;
using UnityEngine;
using UnityEngine.Rendering;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Options
{
    [Serializable]
    public class RenderPassSettings
    {
        private const string _PRF_PFX = nameof(RenderPassSettings) + ".";

        private static readonly ProfilerMarker _PRF_CopyTo = new(_PRF_PFX + nameof(CopyTo));

        private static readonly ProfilerMarker _PRF_GetOverrideLightingSettings =
            new(_PRF_PFX + nameof(GetOverrideLightingSettings));

        [HideLabel]
        [LabelWidth(0)]
        [HorizontalGroup("1", .05f)]
        [SerializeField]
        public bool overrideShadowCasting;

        [ToggleLeft]
        [HorizontalGroup("1", .95f)]
        [SerializeField]
        [EnableIf(nameof(overrideShadowCasting))]
        public bool isShadowCasting;

        [HideLabel]
        [LabelWidth(0)]
        [HorizontalGroup("4", .05f)]
        [SerializeField]
        public bool overrideReceiveShadows;

        [ToggleLeft]
        [HorizontalGroup("4", .95f)]
        [SerializeField]
        [EnableIf(nameof(overrideReceiveShadows))]
        public bool receiveShadows;

        [HideLabel]
        [LabelWidth(0)]
        [HorizontalGroup("2", .05f)]
        [SerializeField]
        public bool overrideLightProbeUsage;

        [SmartLabel]
        [HorizontalGroup("2", .95f)]
        [SerializeField]
        [EnableIf(nameof(overrideLightProbeUsage))]
        public LightProbeUsage lightProbeUsage = LightProbeUsage.Off;

        [HideLabel]
        [LabelWidth(0)]
        [HorizontalGroup("3", .05f)]
        [SerializeField]
        public bool overrideLightProxyVolume;

        [SmartLabel]
        [HorizontalGroup("3", .95f)]
        [SerializeField]
        [EnableIf(nameof(overrideLightProxyVolume))]
        public LightProbeProxyVolume proxyVolume;

        public void CopyTo(GPUIRenderPassSettings settings)
        {
            using (_PRF_CopyTo.Auto())
            {
                settings.proxyVolume = proxyVolume;
                settings.receiveShadows = receiveShadows;
                settings.isShadowCasting = isShadowCasting;
                settings.lightProbeUsage = lightProbeUsage;
                settings.overrideReceiveShadows = overrideReceiveShadows;
                settings.overrideShadowCasting = overrideShadowCasting;
                settings.overrideLightProbeUsage = overrideLightProbeUsage;
                settings.overrideLightProxyVolume = overrideLightProxyVolume;
            }
        }

        public void GetOverrideLightingSettings(
            AssetLightingSettings instanceSettings,
            ShadowCastingMode rendererShadowCasting,
            out ShadowCastingMode shadowCastingMode,
            out bool shadowReceiver,
            out LightProbeUsage usage,
            out LightProbeProxyVolume volume)
        {
            using (_PRF_GetOverrideLightingSettings.Auto())
            {
                shadowCastingMode = overrideShadowCasting
                    ? isShadowCasting
                        ? rendererShadowCasting
                        : ShadowCastingMode.Off
                    : instanceSettings.isShadowCasting
                        ? rendererShadowCasting
                        : ShadowCastingMode.Off;

                shadowReceiver = overrideReceiveShadows
                    ? receiveShadows
                    : instanceSettings.isShadowReceiving;
                usage = overrideLightProbeUsage
                    ? lightProbeUsage
                    : instanceSettings.lightProbeUsage;

                volume = proxyVolume;

                if ((usage == LightProbeUsage.UseProxyVolume) && (volume == null))
                {
                    if (overrideLightProbeUsage)
                    {
                        lightProbeUsage = LightProbeUsage.BlendProbes;
                    }
                    else
                    {
                        instanceSettings.lightProbeUsage = LightProbeUsage.BlendProbes;
                    }

                    usage = LightProbeUsage.BlendProbes;
                }
            }
        }
    }
}
