#region

using System;
using System.Diagnostics;
using Appalachia.Core.Attributes;
using Appalachia.Core.Attributes.Editing;
using Appalachia.Core.Collections.Special;
using Appalachia.Core.Objects.Layers;
using Appalachia.Rendering.Prefabs.Core;
using Appalachia.Rendering.Prefabs.Rendering.Base;
using Appalachia.Rendering.Prefabs.Rendering.Burstable;
using Appalachia.Rendering.Prefabs.Rendering.ModelType.Instancing;
using Appalachia.Rendering.Prefabs.Rendering.ModelType.Positioning;
using Appalachia.Rendering.Prefabs.Rendering.ModelType.Rendering;
using Sirenix.OdinInspector;
using Unity.Mathematics;
using Unity.Profiling;
using UnityEngine;
using Object = UnityEngine.Object;

// ReSharper disable NonReadonlyMemberInGetHashCode

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.ModelType
{
    [Serializable]
    [CallStaticConstructorInEditor]
    public class PrefabModelTypeOptions :

        // PrefabTypeOptionsLookup<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW, IL_TT>
        PrefabTypeOptions<PrefabModelType, PrefabModelTypeOptions, PrefabModelTypeOptionsOverride,
            PrefabModelTypeOptionsSetData, PrefabModelTypeOptionsWrapper, PrefabModelTypeOptionsLookup,
            Index_PrefabModelTypeOptions, PrefabModelTypeOptionsToggle, Index_PrefabModelTypeOptionsToggle,
            AppaList_PrefabModelType, AppaList_PrefabModelTypeOptionsWrapper,
            AppaList_PrefabModelTypeOptionsToggle>,
        IEquatable<PrefabModelTypeOptions>
    {
        #region Constants and Static Readonly

        private const float MAX_RENDER = 4096f;

        #endregion

        static PrefabModelTypeOptions()
        {
            When.Object<PrefabRenderingSetCollection>()
                .IsAvailableThen(i => _prefabRenderingSetCollection = i);
            When.Behaviour<PrefabRenderingManager>().IsAvailableThen(i => _prefabRenderingManager = i);
        }

        public PrefabModelTypeOptions()
        {
        }

        public PrefabModelTypeOptions(Object owner) : base(owner)
        {
        }

        #region Static Fields and Autoproperties

        private static PrefabRenderingManager _prefabRenderingManager;

        private static PrefabRenderingSetCollection _prefabRenderingSetCollection;

        #endregion

        #region Fields and Autoproperties

        [TabGroup("Burial")]
        [SerializeField]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        [OnValueChanged(nameof(HandleUpdate), true)]
        public AssetBurialOptions burialOptions;

        [TabGroup("Cull")]
        [SerializeField]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        [OnValueChanged(nameof(HandleUpdate), true)]
        public AssetCullingSettings cullingSettings;

        [TabGroup("Light")]
        [SerializeField]
        [Title("Instancing")]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        [OnValueChanged(nameof(HandleUpdate), true)]
        public AssetLightingSettings instancedLighting;

        [TabGroup("Light")]
        [SerializeField]
        [Title("Mesh Rendering")]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        [OnValueChanged(nameof(HandleUpdate), true)]
        public AssetLightingSettings normalLighting;

        [TabGroup("Ranges")]
        [SerializeField]
        [InlineProperty]
        [LabelWidth(0)]
        [ListDrawerSettings(HideAddButton = false, HideRemoveButton = false, DraggableItems = false)]
        [OnInspectorGUI(nameof(HandleUpdate))]
        public AssetRangeSettings[] rangeSettings;

        [TabGroup("Falloff")]
        [SerializeField]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        [OnValueChanged(nameof(HandleUpdate), true)]
        public DistanceFalloffSettings distanceFalloffSettings;

        [SerializeField]
        [HideInInspector]
        public float maximumRenderingDistance;

        [SerializeField]
        [HideInInspector]
        public float minimumRenderingDistance;

        [TabGroup("Frustum")]
        [SerializeField]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        [OnValueChanged(nameof(HandleUpdate), true)]
        public FrustumSettings frustum;

        [TabGroup("Runtime")]
        [SerializeField]
        [InlineProperty]
        [OnValueChanged(nameof(HandleUpdate), true)]
        public LayerSelection layer;

        [TabGroup("LOD")]
        [SerializeField]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        [OnValueChanged(nameof(HandleUpdate), true)]
        public LODFadeSettings lodFadeSettings;

        #endregion

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
            get => new(minimumRenderingDistance, maximumRenderingDistance);
            set
            {
                minimumRenderingDistance = value.x;
                maximumRenderingDistance = value.y;
            }
        }

        public static PrefabModelTypeOptions Assembly(
            Object owner,
            float max,
            FrustumSettings frustum,
            AssetLightingSettings instancingSettings,
            AssetCullingSettings assetCullingSettings,
            DistanceFalloffSettings distanceFalloffSettings,
            LODFadeSettings lodFadeSettings,
            AssetBurialOptions assetBurialOptions,
            params AssetRangeSettings[] rangeSettings)
        {
            return new(owner)
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
            Object owner,
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
            return new(owner)
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
            Object owner,
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
            return new(owner)
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

        public static PrefabModelTypeOptions InstancedOnly(
            Object owner,
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
            return new(owner)
            {
                frustum = frustum,
                minimumRenderingDistance = 0f,
                maximumRenderingDistance = max,
                cullingSettings = assetCullingSettings,
                distanceFalloffSettings = distanceFalloffSettings,
                instancedLighting = instancingSettings,
                normalLighting = default,
                lodFadeSettings = lodFadeSettings,
                rangeSettings = new[] { AssetRangeSettings.GPUInstanced(physics, interactions) },
                burialOptions = assetBurialOptions
            };
        }

        public static PrefabModelTypeOptions InteractableObject(
            Object owner,
            float max,
            FrustumSettings frustum,
            AssetLightingSettings normalSettings,
            AssetLightingSettings instancingSettings,
            AssetCullingSettings assetCullingSettings,
            DistanceFalloffSettings distanceFalloffSettings,
            LODFadeSettings lodFadeSettings,
            params AssetRangeSettings[] rangeSettings)
        {
            return new(owner)
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
            Object owner,
            float max,
            FrustumSettings frustum,
            AssetLightingSettings instancingSettings,
            AssetCullingSettings assetCullingSettings,
            DistanceFalloffSettings distanceFalloffSettings,
            LODFadeSettings lodFadeSettings,
            params AssetRangeSettings[] rangeSettings)
        {
            return new(owner)
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

        public static PrefabModelTypeOptions Tree(
            Object owner,
            float max,
            FrustumSettings frustum,
            AssetLightingSettings normalSettings,
            AssetLightingSettings instancingSettings,
            AssetCullingSettings assetCullingSettings,
            DistanceFalloffSettings distanceFalloffSettings,
            LODFadeSettings lodFadeSettings,
            params AssetRangeSettings[] rangeSettings)
        {
            return new(owner)
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

        /*[TabGroup("Positions")]
        [Button]
        public void BuryMeshes()
        {
            _prefabRenderingSetCollection.DoForAllIf(set => set.modelType == type, MeshBurialManagementProcessor.EnqueuePrefabRenderingSet);
        }*/

        /// <inheritdoc />
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
                    minimumRenderingDistance = math.clamp(
                        minimumRenderingDistance,
                        0f,
                        maximumRenderingDistance
                    );
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

        public void CreateFrustumPlanes(Camera camera, Camera frustumCamera, ref FrustumPlanesWrapper planes)
        {
            using (_PRF_CreateFrustumPlanes.Auto())
            {
                var farRange = rangeSettings.Length == 1
                    ? rangeSettings[0]
                    : rangeSettings[rangeSettings.Length - 2];

                frustum.Confirm();

                var limit = math.min(
                    _prefabRenderingManager.RenderingOptions.global.maximumFrustrangeRange,
                    farRange.rangeLimit + 5.0f
                );

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

        [TabGroup("Positions")]
        [Button]
        public void SetLocations()
        {
            _prefabRenderingSetCollection.DoForAllIf(
                set => set.modelType == type,
                set =>
                {
                    set.useLocations = true;
                    set.locations.SetFromInstance(set);
                    set.MarkAsModified();
                }
            );
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

        #region Profiling

        private static readonly ProfilerMarker _PRF_CreateFrustumPlanes =
            new(_PRF_PFX + nameof(CreateFrustumPlanes));

        private static readonly ProfilerMarker _PRF_HandleUpdate = new(_PRF_PFX + nameof(HandleUpdate));

        private static readonly ProfilerMarker _PRF_HandleUpdate_MarkDirty =
            new(_PRF_PFX + nameof(HandleUpdate) + ".MarkDirty");

        private static readonly ProfilerMarker _PRF_UpdateForValidity =
            new(_PRF_PFX + nameof(UpdateForValidity));

        #endregion

        #region IEquatable

        [DebuggerStepThrough]
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

        /// <inheritdoc />
        [DebuggerStepThrough]
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

            return Equals((PrefabModelTypeOptions)obj);
        }

        /// <inheritdoc />
        [DebuggerStepThrough]
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
                hashCode = (hashCode * 397) ^
                           (instancedLighting != null ? instancedLighting.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ (cullingSettings != null ? cullingSettings.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^
                           (distanceFalloffSettings != null ? distanceFalloffSettings.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ (lodFadeSettings != null ? lodFadeSettings.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ burialOptions.GetHashCode();
                return hashCode;
            }
        }

        [DebuggerStepThrough]
        public static bool operator ==(PrefabModelTypeOptions left, PrefabModelTypeOptions right)
        {
            return Equals(left, right);
        }

        [DebuggerStepThrough]
        public static bool operator !=(PrefabModelTypeOptions left, PrefabModelTypeOptions right)
        {
            return !Equals(left, right);
        }

        #endregion
    }
}
