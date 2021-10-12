#region

using System;
using Appalachia.Core.Layers;
using Appalachia.Rendering.Prefabs.Core;
using Appalachia.Rendering.Prefabs.Core.States;
using Appalachia.Rendering.Prefabs.Rendering.Base;
using Appalachia.Rendering.Prefabs.Rendering.ModelType.Instancing;
using Appalachia.Rendering.Prefabs.Rendering.ModelType.Positioning;
using Appalachia.Rendering.Prefabs.Rendering.ModelType.Rendering;
using GPUInstancer;
using Unity.Profiling;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.ModelType
{
    [Serializable]
    public class PrefabModelTypeOptionsSetData : PrefabTypeOptionsSetData<PrefabModelType,
        PrefabModelTypeOptions, PrefabModelTypeOptionsOverride, PrefabModelTypeOptionsSetData,
        PrefabModelTypeOptionsWrapper, PrefabModelTypeOptionsLookup, Index_PrefabModelTypeOptions,
        PrefabModelTypeOptionsToggle, Index_PrefabModelTypeOptionsToggle, AppaList_PrefabModelType,
        AppaList_PrefabModelTypeOptionsWrapper, AppaList_PrefabModelTypeOptionsToggle>
    {
        private const string _PRF_PFX = nameof(PrefabModelTypeOptionsSetData) + ".";

        private static readonly ProfilerMarker _PRF_SyncOverrides =
            new(_PRF_PFX + nameof(SyncOverrides));

        private static readonly ProfilerMarker _PRF_SyncOverrides_InitializeSync =
            new(_PRF_PFX + nameof(SyncOverrides) + ".InitializeSync");

        private static readonly ProfilerMarker _PRF_SyncOverrides_DistanceSettings =
            new(_PRF_PFX + nameof(SyncOverrides) + ".DistanceSettings");

        private static readonly ProfilerMarker _PRF_SyncOverrides_RangeSettings =
            new(_PRF_PFX + nameof(SyncOverrides) + ".RangeSettings");

        private static readonly ProfilerMarker _PRF_SyncOverrides_LightingSettings =
            new(_PRF_PFX + nameof(SyncOverrides) + ".LightingSettings");

        private static readonly ProfilerMarker _PRF_SyncOverrides_CullingSettings =
            new(_PRF_PFX + nameof(SyncOverrides) + ".CullingSettings");

        private static readonly ProfilerMarker _PRF_SyncOverrides_FalloffSettings =
            new(_PRF_PFX + nameof(SyncOverrides) + ".FalloffSettings");

        private static readonly ProfilerMarker _PRF_SyncOverrides_FadeSettings =
            new(_PRF_PFX + nameof(SyncOverrides) + ".FadeSettings");

        private static readonly ProfilerMarker _PRF_SyncOverrides_BurialSettings =
            new(_PRF_PFX + nameof(SyncOverrides) + ".BurialSettings");

        private static readonly ProfilerMarker _PRF_SyncOverrides_UpdateRangeLimits =
            new(_PRF_PFX + nameof(SyncOverrides) + ".UpdateRangeLimits");

        private static readonly ProfilerMarker _PRF_SyncOverridesFull =
            new(_PRF_PFX + nameof(SyncOverridesFull));

        private static readonly ProfilerMarker _PRF_ApplyTo = new(_PRF_PFX + nameof(ApplyTo));

        private float _maximumStateChangeDistance;

        public float maximumStateChangeDistance => _maximumStateChangeDistance;

        public float minimumRenderingDistance =>
            _setOverrides.minimumRenderingDistance.overrideEnabled
                ? _setOverrides.minimumRenderingDistance.value
                : typeOptions.options.minimumRenderingDistance;

        public float maximumRenderingDistance =>
            _setOverrides.maximumRenderingDistance.overrideEnabled
                ? _setOverrides.maximumRenderingDistance.value
                : typeOptions.options.maximumRenderingDistance;

        public LayerSelection layer =>
            _setOverrides.layer.overrideEnabled
                ? _setOverrides.layer.value
                : typeOptions.options.layer;

        public FrustumSettings frustum => typeOptions.options.frustum;

        public AssetRangeSettings[] rangeSettings =>
            _setOverrides.rangeSettings.overrideEnabled
                ? _setOverrides.rangeSettings.value
                : typeOptions.options.rangeSettings;

        public AssetLightingSettings normalLighting =>
            _setOverrides.normalLighting.overrideEnabled
                ? _setOverrides.normalLighting.value
                : typeOptions.options.normalLighting;

        public AssetLightingSettings instancedLighting =>
            _setOverrides.instancedLighting.overrideEnabled
                ? _setOverrides.instancedLighting.value
                : typeOptions.options.instancedLighting;

        public AssetCullingSettings cullingSettings =>
            _setOverrides.cullingSettings.overrideEnabled
                ? _setOverrides.cullingSettings.value
                : typeOptions.options.cullingSettings;

        public DistanceFalloffSettings distanceFalloffSettings =>
            _setOverrides.distanceFalloffSettings.overrideEnabled
                ? _setOverrides.distanceFalloffSettings.value
                : typeOptions.options.distanceFalloffSettings;

        public LODFadeSettings lodFadeSettings =>
            _setOverrides.lodFadeSettings.overrideEnabled
                ? _setOverrides.lodFadeSettings.value
                : typeOptions.options.lodFadeSettings;

        public AssetBurialOptions burialOptions =>
            _setOverrides.burialOptions.overrideEnabled
                ? _setOverrides.burialOptions.value
                : typeOptions.options.burialOptions;

        public override void SyncOverrides()
        {
            using (_PRF_SyncOverrides.Auto())
            {
                var options = typeOptions.options;

                ref var o = ref _setOverrides;

                using (_PRF_SyncOverrides_InitializeSync.Auto())
                {
                    o.Initialize(options);
                }

                using (_PRF_SyncOverrides_DistanceSettings.Auto())
                {
                    if (!o.minimumRenderingDistance.overrideEnabled)
                    {
                        o.minimumRenderingDistance.value = options.minimumRenderingDistance;
                    }

                    if (!o.maximumRenderingDistance.overrideEnabled)
                    {
                        o.maximumRenderingDistance.value = options.maximumRenderingDistance;
                    }
                }

                using (_PRF_SyncOverrides_RangeSettings.Auto())
                {
                    if (!o.rangeSettings.overrideEnabled)
                    {
                        var ov = o.rangeSettings.value;
                        var rs = options.rangeSettings;

                        var length = rs.Length;

                        if ((ov == null) || (ov.Length != length))
                        {
                            o.rangeSettings.value =
                                options.rangeSettings.Clone() as AssetRangeSettings[];
                        }
                        else
                        {
                            for (var i = 0; i < length; i++)
                            {
                                var rsi = rs[i];
                                var ovi = ov[i];

                                rsi.CopyTo(ref ovi);

                                ov[i] = ovi;
                            }
                        }
                    }
                }

                using (_PRF_SyncOverrides_LightingSettings.Auto())
                {
                    if (!o.normalLighting.overrideEnabled)
                    {
                        o.normalLighting.value = options.normalLighting;
                    }

                    if (!o.instancedLighting.overrideEnabled)
                    {
                        o.instancedLighting.value = options.instancedLighting;
                    }
                }

                using (_PRF_SyncOverrides_CullingSettings.Auto())
                {
                    if (!o.cullingSettings.overrideEnabled)
                    {
                        o.cullingSettings.value = options.cullingSettings;
                    }
                }

                using (_PRF_SyncOverrides_FalloffSettings.Auto())
                {
                    if (!o.distanceFalloffSettings.overrideEnabled)
                    {
                        o.distanceFalloffSettings.value = options.distanceFalloffSettings;
                    }
                }

                using (_PRF_SyncOverrides_FadeSettings.Auto())
                {
                    if (!o.lodFadeSettings.overrideEnabled)
                    {
                        o.lodFadeSettings.value = options.lodFadeSettings;
                    }
                }

                using (_PRF_SyncOverrides_BurialSettings.Auto())
                {
                    if (!o.burialOptions.overrideEnabled)
                    {
                        o.burialOptions.value = options.burialOptions;
                    }
                }

                using (_PRF_SyncOverrides_UpdateRangeLimits.Auto())
                {
                    var rs = o.rangeSettings.value;

                    for (var i = 0; i < (rs.Length - 1); i++)
                    {
                        var rangeSetting = rs[i];

                        rangeSetting.showRangeLimit = true;

                        _maximumStateChangeDistance = rangeSetting.rangeLimit;
                    }
                }
            }
        }

        public override void SyncOverridesFull(bool hasInteractions, bool hasColliders)
        {
            using (_PRF_SyncOverridesFull.Auto())
            {
                SyncOverrides();

                var options = typeOptions.options;

                ref var o = ref _setOverrides;

                o.Initialize(options);

                if (hasInteractions &&
                    ((!o.rangeSettings.overrideEnabled &&
                      (options.rangeSettings[0].interactions !=
                       InstanceInteractionState.Enabled)) ||
                     (o.rangeSettings.overrideEnabled &&
                      (o.rangeSettings.value[0].interactions != InstanceInteractionState.Enabled))))
                {
                    o.rangeSettings.overrideEnabled = true;
                    o.rangeSettings.value[0].interactions = InstanceInteractionState.Enabled;
                }

                if (hasColliders &&
                    ((!o.rangeSettings.overrideEnabled &&
                      (options.rangeSettings[0].physics != InstancePhysicsState.Enabled)) ||
                     (o.rangeSettings.overrideEnabled &&
                      (o.rangeSettings.value[0].physics != InstancePhysicsState.Enabled))))
                {
                    o.rangeSettings.overrideEnabled = true;
                    o.rangeSettings.value[0].physics = InstancePhysicsState.Enabled;
                }
            }
        }

        public void ApplyTo(GPUInstancerPrefabPrototype prototype)
        {
            using (_PRF_ApplyTo.Auto())
            {
                prototype.maxDistance = maximumRenderingDistance;
                prototype.lightProbeUsage = instancedLighting.lightProbeUsage;
                prototype.isShadowReceiving = instancedLighting.isShadowReceiving;
                prototype.isShadowCasting = instancedLighting.isShadowCasting;
                prototype.useCustomShadowDistance = instancedLighting.useCustomShadowDistance;
                prototype.shadowDistance = instancedLighting.shadowRenderingDistance;
                prototype.useOriginalShaderForShadow = instancedLighting.useOriginalShaderForShadow;
                prototype.cullShadows = instancedLighting.cullShadows;
                prototype.isFrustumCulling = cullingSettings.isFrustumCulling;
                prototype.isOcclusionCulling = cullingSettings.isOcclusionCulling;
                prototype.frustumOffset = cullingSettings.frustumOffset;
                prototype.minCullingDistance = cullingSettings.minCullingDistance;
                prototype.occlusionOffset = cullingSettings.occlusionOffset;
                prototype.occlusionAccuracy = cullingSettings.occlusionAccuracy;
                prototype.isLODCrossFade = lodFadeSettings.useLODCrossFade;
                prototype.isLODCrossFadeAnimate = lodFadeSettings.animateLODCrossFade;
                prototype.lodFadeTransitionWidth = lodFadeSettings.lodFadeTransitionWidth;
                prototype.lodBiasAdjustment = lodFadeSettings.lodBiasAdjustment;
            }
        }
    }
}
