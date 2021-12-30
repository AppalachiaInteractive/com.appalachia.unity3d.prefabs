#region

using System;
using System.Diagnostics;
using Appalachia.Core.Attributes.Editing;
using Appalachia.Core.Layers.Overrides;
using Appalachia.Core.Overrides.Implementations;
using Appalachia.Rendering.Prefabs.Core;
using Appalachia.Rendering.Prefabs.Rendering.Base;
using Appalachia.Rendering.Prefabs.Rendering.Overrides;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.ModelType
{
    [Serializable]
    public class PrefabModelTypeOptionsOverride :
        PrefabTypeOptionsOverride<PrefabModelType, PrefabModelTypeOptions, PrefabModelTypeOptionsOverride,
            PrefabModelTypeOptionsSetData, PrefabModelTypeOptionsWrapper, PrefabModelTypeOptionsLookup,
            Index_PrefabModelTypeOptions, PrefabModelTypeOptionsToggle, Index_PrefabModelTypeOptionsToggle,
            AppaList_PrefabModelType, AppaList_PrefabModelTypeOptionsWrapper,
            AppaList_PrefabModelTypeOptionsToggle>,
        IEquatable<PrefabModelTypeOptionsOverride>
    {
        #region Fields and Autoproperties

        [TabGroup("Burial")]
        [SerializeField]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        public OverridableAssetBurialOptions burialOptions;

        [TabGroup("Cull")]
        [SerializeField]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        public OverridableAssetCullingSettings cullingSettings;

        [TabGroup("Light")]
        [Title("Instancing")]
        [SerializeField]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        public OverridableAssetLightingSettings instancedLighting;

        [TabGroup("Light")]
        [Title("Mesh Rendering")]
        [SerializeField]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        public OverridableAssetLightingSettings normalLighting;

        /*
        [TabGroup("Frustum")]
        [SerializeField]
        [InlineProperty, HideLabel, LabelWidth(0)]
        public OverridableFrustumSettings frustum;
        */

        [TabGroup("Ranges")]
        [SerializeField]
        [ListDrawerSettings(HideAddButton = true, HideRemoveButton = true, DraggableItems = false)]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        public OverridableAssetRangeSettingsArray rangeSettings;

        [TabGroup("Falloff")]
        [SerializeField]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        public OverridableDistanceFalloffSettings distanceFalloffSettings;

        [SerializeField]
        [InlineProperty]
        [SmartLabel]
        public OverridableFloat maximumRenderingDistance;

        [SerializeField]
        [InlineProperty]
        [SmartLabel]
        public OverridableFloat minimumRenderingDistance;

        [TabGroup("Runtime")]
        [SerializeField]
        [InlineProperty]
        [SmartLabel]
        public OverridableLayerSelection layer;

        [TabGroup("LOD")]
        [SerializeField]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        public OverridableLODFadeSettings lodFadeSettings;

        #endregion

        public override void Initialize(PrefabModelTypeOptions options)
        {
            if (minimumRenderingDistance == null)
            {
                minimumRenderingDistance = new OverridableFloat(false, options.minimumRenderingDistance);
            }

            if (maximumRenderingDistance == null)
            {
                maximumRenderingDistance = new OverridableFloat(false, options.maximumRenderingDistance);
            }

            if (layer == null)
            {
                layer = new OverridableLayerSelection(true, false, options.layer);
            }

            /*if (frustum == null)
            {
                frustum = new OverridableFrustumSettings(true, false, options.frustum);
            }*/

            if (rangeSettings == null)
            {
                rangeSettings = new OverridableAssetRangeSettingsArray(true, false, options.rangeSettings);
            }

            if (normalLighting == null)
            {
                normalLighting = new OverridableAssetLightingSettings(true, false, options.normalLighting);
            }

            if (instancedLighting == null)
            {
                instancedLighting = new OverridableAssetLightingSettings(
                    true,
                    false,
                    options.instancedLighting
                );
            }

            if (cullingSettings == null)
            {
                cullingSettings = new OverridableAssetCullingSettings(true, false, options.cullingSettings);
            }

            if (distanceFalloffSettings == null)
            {
                distanceFalloffSettings = new OverridableDistanceFalloffSettings(
                    true,
                    false,
                    options.distanceFalloffSettings
                );
            }

            if (lodFadeSettings == null)
            {
                lodFadeSettings = new OverridableLODFadeSettings(true, false, options.lodFadeSettings);
            }

            if (burialOptions == null)
            {
                burialOptions = new OverridableAssetBurialOptions(true, false, options.burialOptions);
            }
        }

        #region IEquatable

        [DebuggerStepThrough]
        public bool Equals(PrefabModelTypeOptionsOverride other)
        {
            if (ReferenceEquals(null, other))
            {
                return false;
            }

            if (ReferenceEquals(this, other))
            {
                return true;
            }

            return Equals(minimumRenderingDistance, other.minimumRenderingDistance) &&
                   Equals(maximumRenderingDistance, other.maximumRenderingDistance) &&
                   Equals(layer,                    other.layer) /* && Equals(frustum, other.frustum)*/ &&
                   Equals(rangeSettings,            other.rangeSettings) &&
                   Equals(normalLighting,           other.normalLighting) &&
                   Equals(instancedLighting,        other.instancedLighting) &&
                   Equals(cullingSettings,          other.cullingSettings) &&
                   Equals(distanceFalloffSettings,  other.distanceFalloffSettings) &&
                   Equals(lodFadeSettings,          other.lodFadeSettings) &&
                   Equals(burialOptions,            other.burialOptions);
        }

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

            return Equals((PrefabModelTypeOptionsOverride)obj);
        }

        [DebuggerStepThrough]
        public override int GetHashCode()
        {
            unchecked
            {
                var hashCode = minimumRenderingDistance != null ? minimumRenderingDistance.GetHashCode() : 0;
                hashCode = (hashCode * 397) ^
                           (maximumRenderingDistance != null ? maximumRenderingDistance.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ (layer != null ? layer.GetHashCode() : 0);

                //hashCode = (hashCode * 397) ^ (frustum != null ? frustum.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ (rangeSettings != null ? rangeSettings.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ (normalLighting != null ? normalLighting.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^
                           (instancedLighting != null ? instancedLighting.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ (cullingSettings != null ? cullingSettings.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^
                           (distanceFalloffSettings != null ? distanceFalloffSettings.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ (lodFadeSettings != null ? lodFadeSettings.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ (burialOptions != null ? burialOptions.GetHashCode() : 0);
                return hashCode;
            }
        }

        [DebuggerStepThrough]
        public static bool operator ==(
            PrefabModelTypeOptionsOverride left,
            PrefabModelTypeOptionsOverride right)
        {
            return Equals(left, right);
        }

        [DebuggerStepThrough]
        public static bool operator !=(
            PrefabModelTypeOptionsOverride left,
            PrefabModelTypeOptionsOverride right)
        {
            return !Equals(left, right);
        }

        #endregion
    }
}
