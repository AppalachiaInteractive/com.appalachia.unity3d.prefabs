#region

using System;
using Appalachia.Core.Objects.Layers;
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
        #region Fields and Autoproperties

        private float _maximumStateChangeDistance;

        #endregion

        public AssetBurialOptions burialOptions =>
            _setOverrides.burialOptions.Overriding
                ? _setOverrides.burialOptions.Value
                : typeOptions.options.burialOptions;

        public AssetCullingSettings cullingSettings =>
            _setOverrides.cullingSettings.Overriding
                ? _setOverrides.cullingSettings.Value
                : typeOptions.options.cullingSettings;

        public AssetLightingSettings instancedLighting =>
            _setOverrides.instancedLighting.Overriding
                ? _setOverrides.instancedLighting.Value
                : typeOptions.options.instancedLighting;

        public AssetLightingSettings normalLighting =>
            _setOverrides.normalLighting.Overriding
                ? _setOverrides.normalLighting.Value
                : typeOptions.options.normalLighting;

        public AssetRangeSettings[] rangeSettings =>
            _setOverrides.rangeSettings.Overriding
                ? _setOverrides.rangeSettings.Value
                : typeOptions.options.rangeSettings;

        public DistanceFalloffSettings distanceFalloffSettings =>
            _setOverrides.distanceFalloffSettings.Overriding
                ? _setOverrides.distanceFalloffSettings.Value
                : typeOptions.options.distanceFalloffSettings;

        public float maximumRenderingDistance =>
            _setOverrides.maximumRenderingDistance.Overriding
                ? _setOverrides.maximumRenderingDistance.Value
                : typeOptions.options.maximumRenderingDistance;

        public float maximumStateChangeDistance => _maximumStateChangeDistance;

        public float minimumRenderingDistance =>
            _setOverrides.minimumRenderingDistance.Overriding
                ? _setOverrides.minimumRenderingDistance.Value
                : typeOptions.options.minimumRenderingDistance;

        public FrustumSettings frustum => typeOptions.options.frustum;

        public LayerSelection layer =>
            _setOverrides.layer.Overriding ? _setOverrides.layer.Value : typeOptions.options.layer;

        public LODFadeSettings lodFadeSettings =>
            _setOverrides.lodFadeSettings.Overriding
                ? _setOverrides.lodFadeSettings.Value
                : typeOptions.options.lodFadeSettings;

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
                    if (!o.minimumRenderingDistance.Overriding)
                    {
                        o.minimumRenderingDistance.Value = options.minimumRenderingDistance;
                    }

                    if (!o.maximumRenderingDistance.Overriding)
                    {
                        o.maximumRenderingDistance.Value = options.maximumRenderingDistance;
                    }
                }

                using (_PRF_SyncOverrides_RangeSettings.Auto())
                {
                    if (!o.rangeSettings.Overriding)
                    {
                        var ov = o.rangeSettings.Value;
                        var rs = options.rangeSettings;

                        var length = rs.Length;

                        if ((ov == null) || (ov.Length != length))
                        {
                            o.rangeSettings.Value = options.rangeSettings.Clone() as AssetRangeSettings[];
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
                    if (!o.normalLighting.Overriding)
                    {
                        o.normalLighting.Value = options.normalLighting;
                    }

                    if (!o.instancedLighting.Overriding)
                    {
                        o.instancedLighting.Value = options.instancedLighting;
                    }
                }

                using (_PRF_SyncOverrides_CullingSettings.Auto())
                {
                    if (!o.cullingSettings.Overriding)
                    {
                        o.cullingSettings.Value = options.cullingSettings;
                    }
                }

                using (_PRF_SyncOverrides_FalloffSettings.Auto())
                {
                    if (!o.distanceFalloffSettings.Overriding)
                    {
                        o.distanceFalloffSettings.Value = options.distanceFalloffSettings;
                    }
                }

                using (_PRF_SyncOverrides_FadeSettings.Auto())
                {
                    if (!o.lodFadeSettings.Overriding)
                    {
                        o.lodFadeSettings.Value = options.lodFadeSettings;
                    }
                }

                using (_PRF_SyncOverrides_BurialSettings.Auto())
                {
                    if (!o.burialOptions.Overriding)
                    {
                        o.burialOptions.Value = options.burialOptions;
                    }
                }

                using (_PRF_SyncOverrides_UpdateRangeLimits.Auto())
                {
                    var rs = o.rangeSettings.Value;

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
                    ((!o.rangeSettings.Overriding &&
                      (options.rangeSettings[0].interactions != InstanceInteractionState.Enabled)) ||
                    (o.rangeSettings.Overriding &&
                     (o.rangeSettings.Value[0].interactions != InstanceInteractionState.Enabled))))
                {
                    o.rangeSettings.Overriding = true;
                    o.rangeSettings.Value[0].interactions = InstanceInteractionState.Enabled;
                }

                if (hasColliders &&
                    ((!o.rangeSettings.Overriding &&
                      (options.rangeSettings[0].physics != InstancePhysicsState.Enabled)) ||
                     (o.rangeSettings.Overriding &&
                      (o.rangeSettings.Value[0].physics != InstancePhysicsState.Enabled))))
                {
                    o.rangeSettings.Overriding = true;
                    o.rangeSettings.Value[0].physics = InstancePhysicsState.Enabled;
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

        #region Profiling

        private static readonly ProfilerMarker _PRF_ApplyTo = new(_PRF_PFX + nameof(ApplyTo));

        private static readonly ProfilerMarker _PRF_SyncOverrides = new(_PRF_PFX + nameof(SyncOverrides));

        private static readonly ProfilerMarker _PRF_SyncOverrides_BurialSettings =
            new(_PRF_PFX + nameof(SyncOverrides) + ".BurialSettings");

        private static readonly ProfilerMarker _PRF_SyncOverrides_CullingSettings =
            new(_PRF_PFX + nameof(SyncOverrides) + ".CullingSettings");

        private static readonly ProfilerMarker _PRF_SyncOverrides_DistanceSettings =
            new(_PRF_PFX + nameof(SyncOverrides) + ".DistanceSettings");

        private static readonly ProfilerMarker _PRF_SyncOverrides_FadeSettings =
            new(_PRF_PFX + nameof(SyncOverrides) + ".FadeSettings");

        private static readonly ProfilerMarker _PRF_SyncOverrides_FalloffSettings =
            new(_PRF_PFX + nameof(SyncOverrides) + ".FalloffSettings");

        private static readonly ProfilerMarker _PRF_SyncOverrides_InitializeSync =
            new(_PRF_PFX + nameof(SyncOverrides) + ".InitializeSync");

        private static readonly ProfilerMarker _PRF_SyncOverrides_LightingSettings =
            new(_PRF_PFX + nameof(SyncOverrides) + ".LightingSettings");

        private static readonly ProfilerMarker _PRF_SyncOverrides_RangeSettings =
            new(_PRF_PFX + nameof(SyncOverrides) + ".RangeSettings");

        private static readonly ProfilerMarker _PRF_SyncOverrides_UpdateRangeLimits =
            new(_PRF_PFX + nameof(SyncOverrides) + ".UpdateRangeLimits");

        private static readonly ProfilerMarker _PRF_SyncOverridesFull =
            new(_PRF_PFX + nameof(SyncOverridesFull));

        #endregion
    }
}
