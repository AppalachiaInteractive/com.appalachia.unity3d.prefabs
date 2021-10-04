#region

using System;
using Appalachia.Core.Collections.Special;
using Appalachia.Core.Layers;
using Appalachia.Editing.Attributes;
using Appalachia.Prefabs.Core;
using Appalachia.Prefabs.Rendering.Base;
using Appalachia.Prefabs.Rendering.Burstable;
using Appalachia.Prefabs.Rendering.ModelType.Instancing;
using Appalachia.Prefabs.Rendering.ModelType.Positioning;
using Appalachia.Prefabs.Rendering.ModelType.Rendering;
using Sirenix.OdinInspector;
using Unity.Mathematics;
using Unity.Profiling;
using UnityEngine;

#endregion

namespace Appalachia.Prefabs.Rendering.ModelType
{
    [Serializable]
public class PrefabModelTypeOptions :

        // PrefabTypeOptionsLookup<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW, IL_TT>
        PrefabTypeOptions<PrefabModelType, PrefabModelTypeOptions, PrefabModelTypeOptionsOverride, PrefabModelTypeOptionsSetData,
            PrefabModelTypeOptionsWrapper, PrefabModelTypeOptionsLookup, Index_PrefabModelTypeOptions, PrefabModelTypeOptionsToggle,
            Index_PrefabModelTypeOptionsToggle, AppaList_PrefabModelType, AppaList_PrefabModelTypeOptionsWrapper,
            AppaList_PrefabModelTypeOptionsToggle>,
        IEquatable<PrefabModelTypeOptions>
    {
        private const string _PRF_PFX = nameof(PrefabModelTypeOptions) + ".";

        private const float MAX_RENDER = 4096f;

        private static readonly ProfilerMarker _PRF_UpdateForValidity = new ProfilerMarker(_PRF_PFX + nameof(UpdateForValidity));

        private static readonly ProfilerMarker _PRF_HandleUpdate = new ProfilerMarker(_PRF_PFX + nameof(HandleUpdate));
        private static readonly ProfilerMarker _PRF_HandleUpdate_MarkDirty = new ProfilerMarker(_PRF_PFX + nameof(HandleUpdate) + ".MarkDirty");

        private static readonly ProfilerMarker _PRF_CreateFrustumPlanes = new ProfilerMarker(_PRF_PFX + nameof(CreateFrustumPlanes));

        [SerializeField]
        [HideInInspector]
        public float minimumRenderingDistance;

        [SerializeField]
        [HideInInspector]
        public float maximumRenderingDistance;

        [TabGroup("Runtime")]
        [SerializeField]
        [InlineProperty]
        [OnValueChanged(nameof(HandleUpdate), true)]
        public LayerSelection layer;

        [TabGroup("Frustum")]
        [SerializeField]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        [OnValueChanged(nameof(HandleUpdate), true)]
        public FrustumSettings frustum;

        [TabGroup("Ranges")]
        [SerializeField]
        [InlineProperty]
        [LabelWidth(0)]
        [ListDrawerSettings(HideAddButton = false, HideRemoveButton = false, DraggableItems = false)]
        [OnInspectorGUI(nameof(HandleUpdate))]
        public AssetRangeSettings[] rangeSettings;

        [TabGroup("Light")]
        [SerializeField]
        [Title("Mesh Rendering")]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        [OnValueChanged(nameof(HandleUpdate), true)]
        public AssetLightingSettings normalLighting;

        [TabGroup("Light")]
        [SerializeField]
        [Title("Instancing")]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        [OnValueChanged(nameof(HandleUpdate), true)]
        public AssetLightingSettings instancedLighting;

        [TabGroup("Cull")]
        [SerializeField]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        [OnValueChanged(nameof(HandleUpdate), true)]
        public AssetCullingSettings cullingSettings;

        [TabGroup("Falloff")]
        [SerializeField]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        [OnValueChanged(nameof(HandleUpdate), true)]
        public DistanceFalloffSettings distanceFalloffSettings;

        [TabGroup("LOD")]
        [SerializeField]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        [OnValueChanged(nameof(HandleUpdate), true)]
        public LODFadeSettings lodFadeSettings;

        [TabGroup("Burial")]
        [SerializeField]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        [OnValueChanged(nameof(HandleUpdate), true)]
        public AssetBurialOptions burialOptions;

        [ShowInInspector]
        [PropertyOrder(-100)]
        [SmartLabel]
        [MinMaxSlider(0, MAX_RENDER, true)]

        //[HorizontalGroup("0", .85f)]
        [OnValueChanged(nameof(HandleUpdate), true)]
#if UNITY_EDITOR
        [SmartInlineButton(nameof(Enable), bold: true, color: nameof(_stateColor), before: true)]
        [SmartInlineButton(nameof(Solo),   bold: true, color: nameof(_soloColor))]
        [SmartInlineButton(nameof(Mute),   bold: true, color: nameof(_muteColor))]
#endif
        private Vector2 renderingDistance
        {
            get => new Vector2(minimumRenderingDistance, maximumRenderingDistance);
            set
            {
                minimumRenderingDistance = value.x;
                maximumRenderingDistance = value.y;
            }
        }

        [TabGroup("Positions")]
        [Button]
        public void SetLocations()
        {
            PrefabRenderingSetCollection.instance.DoForAllIf(
                set => set.modelType == type,
                set =>
                {
                    set.useLocations = true;
                    set.locations.SetFromInstance(set);
                    set.SetDirty();
                }
            );
        }

        /*[TabGroup("Positions")]
        [Button]
        public void BuryMeshes()
        {
            PrefabRenderingSetCollection.instance.DoForAllIf(set => set.modelType == type, MeshBurialManagementProcessor.EnqueuePrefabRenderingSet);
        }*/

        public override bool UpdateForValidity()
        {
            using (_PRF_UpdateForValidity.Auto())
            {
                var changed = false;

                if (cullingSettings == null)
                {
                    cullingSettings = new AssetCullingSettings();
                    changed = true;
                }

                if (normalLighting == null)
                {
                    normalLighting = new AssetLightingSettings();
                    changed = true;
                }

                if (instancedLighting == null)
                {
                    instancedLighting = new AssetLightingSettings();
                    changed = true;
                }

                if (cullingSettings.isCulling)
                {
                    if (!normalLighting.instancedShader)
                    {
                        normalLighting.instancedShader = true;
                        changed = true;
                    }

                    if (!instancedLighting.instancedShader)
                    {
                        instancedLighting.instancedShader = true;
                        changed = true;
                    }
                }

                if ((maximumRenderingDistance > MAX_RENDER) || (maximumRenderingDistance < 0F))
                {
                    maximumRenderingDistance = math.clamp(maximumRenderingDistance, 0f, MAX_RENDER);
                    changed = true;
                }

                if ((minimumRenderingDistance > maximumRenderingDistance) || (minimumRenderingDistance < 0F))
                {
                    minimumRenderingDistance = math.clamp(minimumRenderingDistance, 0f, maximumRenderingDistance);
                    changed = true;
                }

                if (rangeSettings == null)
                {
                    rangeSettings = new AssetRangeSettings[1];
                    changed = true;
                }

                if (rangeSettings.Length == 0)
                {
                    rangeSettings = new AssetRangeSettings[1];
                    changed = true;
                }

                for (var i = 0; i < rangeSettings.Length; i++)
                {
                    if (rangeSettings[i].outOfFrustumRangeLimit == 0f)
                    {
                        rangeSettings[i].frustumOverridesRange = true;
                        rangeSettings[i].outOfFrustumRangeLimit = rangeSettings[i].rangeLimit * .25f;
                    }

                    if (i == (rangeSettings.Length - 1))
                    {
                        if (rangeSettings[i].showRangeLimit)
                        {
                            rangeSettings[i].showRangeLimit = false;
                            changed = true;
                        }
                    }
                    else
                    {
                        if (!rangeSettings[i].showRangeLimit)
                        {
                            rangeSettings[i].showRangeLimit = true;
                            changed = true;
                        }
                    }
                }

                return changed;
            }
        }

        private void HandleUpdate()
        {
            using (_PRF_HandleUpdate.Auto())
            {
                if (UpdateForValidity())
                {
                    using (_PRF_HandleUpdate_MarkDirty.Auto())
                    {
                        if (_dirty == null)
                        {
                            _dirty = new DirtyStringCollection();
                        }

                        _dirty.DirtyAll();
                    }
                }
            }
        }

        public void CreateFrustumPlanes(Camera camera, Camera frustumCamera, ref FrustumPlanesWrapper planes)
        {
            using (_PRF_CreateFrustumPlanes.Auto())
            {
                var farRange = rangeSettings.Length == 1 ? rangeSettings[0] : rangeSettings[rangeSettings.Length - 2];

                frustum.Confirm();

                var limit = math.min(PrefabRenderingManager.instance.RenderingOptions.global.maximumFrustrangeRange, farRange.rangeLimit + 5.0f);

                if (planes == null)
                {
                    planes = new FrustumPlanesWrapper(camera, frustumCamera, frustum, limit);
                }
                else
                {
                    planes.Update(camera, frustumCamera, frustum, limit);
                }
            }
        }

        public static PrefabModelTypeOptions InstancedOnly(
            float max,
            FrustumSettings frustum,
            AssetLightingSettings instancingSettings,
            AssetCullingSettings assetCullingSettings,
            DistanceFalloffSettings distanceFalloffSettings,
            LODFadeSettings lodFadeSettings,
            AssetBurialOptions assetBurialOptions,
            bool physics = false,
            bool interactions = false)
        {
            return new PrefabModelTypeOptions
            {
                frustum = frustum,
                minimumRenderingDistance = 0f,
                maximumRenderingDistance = max,
                cullingSettings = assetCullingSettings,
                distanceFalloffSettings = distanceFalloffSettings,
                instancedLighting = instancingSettings,
                normalLighting = default,
                lodFadeSettings = lodFadeSettings,
                rangeSettings = new[] {AssetRangeSettings.GPUInstanced(physics, interactions)},
                burialOptions = assetBurialOptions
            };
        }

        public static PrefabModelTypeOptions Tree(
            float max,
            FrustumSettings frustum,
            AssetLightingSettings normalSettings,
            AssetLightingSettings instancingSettings,
            AssetCullingSettings assetCullingSettings,
            DistanceFalloffSettings distanceFalloffSettings,
            LODFadeSettings lodFadeSettings,
            params AssetRangeSettings[] rangeSettings)
        {
            return new PrefabModelTypeOptions
            {
                frustum = frustum,
                minimumRenderingDistance = 0f,
                maximumRenderingDistance = max,
                cullingSettings = assetCullingSettings,
                distanceFalloffSettings = distanceFalloffSettings,
                instancedLighting = instancingSettings,
                normalLighting = normalSettings,
                lodFadeSettings = lodFadeSettings,
                rangeSettings = rangeSettings,
                burialOptions = AssetBurialOptions.DoNotBury()
            };
        }

        public static PrefabModelTypeOptions InteractableObject(
            float max,
            FrustumSettings frustum,
            AssetLightingSettings normalSettings,
            AssetLightingSettings instancingSettings,
            AssetCullingSettings assetCullingSettings,
            DistanceFalloffSettings distanceFalloffSettings,
            LODFadeSettings lodFadeSettings,
            params AssetRangeSettings[] rangeSettings)
        {
            return new PrefabModelTypeOptions
            {
                frustum = frustum,
                minimumRenderingDistance = 0f,
                maximumRenderingDistance = max,
                cullingSettings = assetCullingSettings,
                distanceFalloffSettings = distanceFalloffSettings,
                instancedLighting = instancingSettings,
                normalLighting = normalSettings,
                lodFadeSettings = lodFadeSettings,
                rangeSettings = rangeSettings,
                burialOptions = AssetBurialOptions.DoNotBury()
            };
        }

        public static PrefabModelTypeOptions Object(
            float max,
            FrustumSettings frustum,
            AssetLightingSettings instancingSettings,
            AssetCullingSettings assetCullingSettings,
            DistanceFalloffSettings distanceFalloffSettings,
            LODFadeSettings lodFadeSettings,
            params AssetRangeSettings[] rangeSettings)
        {
            return new PrefabModelTypeOptions
            {
                frustum = frustum,
                minimumRenderingDistance = 0f,
                maximumRenderingDistance = max,
                cullingSettings = assetCullingSettings,
                distanceFalloffSettings = distanceFalloffSettings,
                instancedLighting = instancingSettings,
                normalLighting = instancingSettings,
                lodFadeSettings = lodFadeSettings,
                rangeSettings = rangeSettings,
                burialOptions = AssetBurialOptions.DoNotBury()
            };
        }

        public static PrefabModelTypeOptions Assembly(
            float max,
            FrustumSettings frustum,
            AssetLightingSettings instancingSettings,
            AssetCullingSettings assetCullingSettings,
            DistanceFalloffSettings distanceFalloffSettings,
            LODFadeSettings lodFadeSettings,
            AssetBurialOptions assetBurialOptions,
            params AssetRangeSettings[] rangeSettings)
        {
            return new PrefabModelTypeOptions
            {
                frustum = frustum,
                minimumRenderingDistance = 0f,
                maximumRenderingDistance = max,
                cullingSettings = assetCullingSettings,
                distanceFalloffSettings = distanceFalloffSettings,
                normalLighting = instancingSettings,
                instancedLighting = instancingSettings,
                lodFadeSettings = lodFadeSettings,
                rangeSettings = rangeSettings,
                burialOptions = assetBurialOptions
            };
        }

        public static PrefabModelTypeOptions Create(
            float max,
            FrustumSettings frustum,
            AssetLightingSettings normalSettings,
            AssetLightingSettings instancingSettings,
            AssetCullingSettings assetCullingSettings,
            DistanceFalloffSettings distanceFalloffSettings,
            LODFadeSettings lodFadeSettings,
            AssetBurialOptions assetBurialOptions,
            params AssetRangeSettings[] rangeSettings)
        {
            return new PrefabModelTypeOptions
            {
                frustum = frustum,
                minimumRenderingDistance = 0f,
                maximumRenderingDistance = max,
                cullingSettings = assetCullingSettings,
                distanceFalloffSettings = distanceFalloffSettings,
                instancedLighting = instancingSettings,
                normalLighting = normalSettings,
                lodFadeSettings = lodFadeSettings,
                rangeSettings = rangeSettings,
                burialOptions = assetBurialOptions
            };
        }

        public static PrefabModelTypeOptions Create(
            float min,
            float max,
            FrustumSettings frustum,
            AssetLightingSettings normalSettings,
            AssetLightingSettings instancingSettings,
            AssetCullingSettings assetCullingSettings,
            DistanceFalloffSettings distanceFalloffSettings,
            LODFadeSettings lodFadeSettings,
            AssetBurialOptions assetBurialOptions,
            params AssetRangeSettings[] rangeSettings)
        {
            return new PrefabModelTypeOptions
            {
                frustum = frustum,
                minimumRenderingDistance = min,
                maximumRenderingDistance = max,
                cullingSettings = assetCullingSettings,
                distanceFalloffSettings = distanceFalloffSettings,
                instancedLighting = instancingSettings,
                normalLighting = normalSettings,
                lodFadeSettings = lodFadeSettings,
                rangeSettings = rangeSettings,
                burialOptions = assetBurialOptions
            };
        }

#region IEquatable

        public bool Equals(PrefabModelTypeOptions other)
        {
            if (ReferenceEquals(null, other))
            {
                return false;
            }

            if (ReferenceEquals(this, other))
            {
                return true;
            }

            return minimumRenderingDistance.Equals(other.minimumRenderingDistance) &&
                   maximumRenderingDistance.Equals(other.maximumRenderingDistance) &&
                   layer.Equals(other.layer) &&
                   Equals(frustum,                 other.frustum) &&
                   Equals(rangeSettings,           other.rangeSettings) &&
                   Equals(normalLighting,          other.normalLighting) &&
                   Equals(instancedLighting,       other.instancedLighting) &&
                   Equals(cullingSettings,         other.cullingSettings) &&
                   Equals(distanceFalloffSettings, other.distanceFalloffSettings) &&
                   Equals(lodFadeSettings,         other.lodFadeSettings) &&
                   burialOptions.Equals(other.burialOptions);
        }

        public override bool Equals(object obj)
        {
            if (ReferenceEquals(null, obj))
            {
                return false;
            }

            if (ReferenceEquals(this, obj))
            {
                return true;
            }

            if (obj.GetType() != GetType())
            {
                return false;
            }

            return Equals((PrefabModelTypeOptions) obj);
        }

        public override int GetHashCode()
        {
            unchecked
            {
                var hashCode = minimumRenderingDistance.GetHashCode();
                hashCode = (hashCode * 397) ^ maximumRenderingDistance.GetHashCode();
                hashCode = (hashCode * 397) ^ layer.GetHashCode();
                hashCode = (hashCode * 397) ^ (frustum != null ? frustum.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ (rangeSettings != null ? rangeSettings.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ (normalLighting != null ? normalLighting.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ (instancedLighting != null ? instancedLighting.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ (cullingSettings != null ? cullingSettings.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ (distanceFalloffSettings != null ? distanceFalloffSettings.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ (lodFadeSettings != null ? lodFadeSettings.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ burialOptions.GetHashCode();
                return hashCode;
            }
        }

        public static bool operator ==(PrefabModelTypeOptions left, PrefabModelTypeOptions right)
        {
            return Equals(left, right);
        }

        public static bool operator !=(PrefabModelTypeOptions left, PrefabModelTypeOptions right)
        {
            return !Equals(left, right);
        }

#endregion
    }
}
