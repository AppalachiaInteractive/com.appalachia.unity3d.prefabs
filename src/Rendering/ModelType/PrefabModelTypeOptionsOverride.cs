#region

using System;
using Appalachia.Core.Layers.Overrides;
using Appalachia.Core.Overrides.Implementations;
using Appalachia.Editing.Attributes;
using Appalachia.Prefabs.Core;
using Appalachia.Prefabs.Rendering.Base;
using Appalachia.Prefabs.Rendering.Overrides;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Prefabs.Rendering.ModelType
{
    [Serializable]
public class PrefabModelTypeOptionsOverride : PrefabTypeOptionsOverride<PrefabModelType, PrefabModelTypeOptions, PrefabModelTypeOptionsOverride,
                                                      PrefabModelTypeOptionsSetData, PrefabModelTypeOptionsWrapper, PrefabModelTypeOptionsLookup,
                                                      Index_PrefabModelTypeOptions, PrefabModelTypeOptionsToggle, Index_PrefabModelTypeOptionsToggle,
                                                      AppaList_PrefabModelType, AppaList_PrefabModelTypeOptionsWrapper,
                                                      AppaList_PrefabModelTypeOptionsToggle>,
                                                  IEquatable<PrefabModelTypeOptionsOverride>
    {
        [SerializeField]
        [InlineProperty, SmartLabel]
        public float_OVERRIDE minimumRenderingDistance;

        [SerializeField]
        [InlineProperty, SmartLabel]
        public float_OVERRIDE maximumRenderingDistance;

        [TabGroup("Runtime")]
        [SerializeField]
        [InlineProperty, SmartLabel]
        public LayerSelection_OVERRIDE layer;

        /*
        [TabGroup("Frustum")]
        [SerializeField]
        [InlineProperty, HideLabel, LabelWidth(0)]
        public FrustumSettings_OVERRIDE frustum;
        */

        [TabGroup("Ranges")]
        [SerializeField]
        [ListDrawerSettings(HideAddButton = true, HideRemoveButton = true, DraggableItems = false)]
        [InlineProperty, HideLabel, LabelWidth(0)]
        public AssetRangeSettingsArray_OVERRIDE rangeSettings;

        [TabGroup("Light")]
        [Title("Mesh Rendering")]
        [SerializeField]
        [InlineProperty, HideLabel, LabelWidth(0)]
        public AssetLightingSettings_OVERRIDE normalLighting;

        [TabGroup("Light")]
        [Title("Instancing")]
        [SerializeField]
        [InlineProperty, HideLabel, LabelWidth(0)]
        public AssetLightingSettings_OVERRIDE instancedLighting;

        [TabGroup("Cull")]
        [SerializeField]
        [InlineProperty, HideLabel, LabelWidth(0)]
        public AssetCullingSettings_OVERRIDE cullingSettings;

        [TabGroup("Falloff")]
        [SerializeField]
        [InlineProperty, HideLabel, LabelWidth(0)]
        public DistanceFalloffSettings_OVERRIDE distanceFalloffSettings;

        [TabGroup("LOD")]
        [SerializeField]
        [InlineProperty, HideLabel, LabelWidth(0)]
        public LODFadeSettings_OVERRIDE lodFadeSettings;

        [TabGroup("Burial")]
        [SerializeField]
        [InlineProperty, HideLabel, LabelWidth(0)]
        public AssetBurialOptions_OVERRIDE burialOptions;

        public override void Initialize(PrefabModelTypeOptions options)
        {
            if (minimumRenderingDistance == null)
            {
                minimumRenderingDistance = new float_OVERRIDE(true, false, options.minimumRenderingDistance);
            }

            if (maximumRenderingDistance == null)
            {
                maximumRenderingDistance = new float_OVERRIDE(true, false, options.maximumRenderingDistance);
            }

            if (layer == null)
            {
                layer = new LayerSelection_OVERRIDE(true, false, options.layer);
            }

            /*if (frustum == null)
            {
                frustum = new FrustumSettings_OVERRIDE(true, false, options.frustum);
            }*/

            if (rangeSettings == null)
            {
                rangeSettings = new AssetRangeSettingsArray_OVERRIDE(true, false, options.rangeSettings);
            }

            if (normalLighting == null)
            {
                normalLighting = new AssetLightingSettings_OVERRIDE(true, false, options.normalLighting);
            }

            if (instancedLighting == null)
            {
                instancedLighting = new AssetLightingSettings_OVERRIDE(true, false, options.instancedLighting);
            }

            if (cullingSettings == null)
            {
                cullingSettings = new AssetCullingSettings_OVERRIDE(true, false, options.cullingSettings);
            }

            if (distanceFalloffSettings == null)
            {
                distanceFalloffSettings = new DistanceFalloffSettings_OVERRIDE(true, false, options.distanceFalloffSettings);
            }

            if (lodFadeSettings == null)
            {
                lodFadeSettings = new LODFadeSettings_OVERRIDE(true, false, options.lodFadeSettings);
            }

            if (burialOptions == null)
            {
                burialOptions = new AssetBurialOptions_OVERRIDE(true, false, options.burialOptions);
            }
        }

#region IEquatable

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

            return Equals((PrefabModelTypeOptionsOverride) obj);
        }

        public override int GetHashCode()
        {
            unchecked
            {
                var hashCode = minimumRenderingDistance != null ? minimumRenderingDistance.GetHashCode() : 0;
                hashCode = (hashCode * 397) ^ (maximumRenderingDistance != null ? maximumRenderingDistance.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ (layer != null ? layer.GetHashCode() : 0);

                //hashCode = (hashCode * 397) ^ (frustum != null ? frustum.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ (rangeSettings != null ? rangeSettings.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ (normalLighting != null ? normalLighting.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ (instancedLighting != null ? instancedLighting.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ (cullingSettings != null ? cullingSettings.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ (distanceFalloffSettings != null ? distanceFalloffSettings.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ (lodFadeSettings != null ? lodFadeSettings.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ (burialOptions != null ? burialOptions.GetHashCode() : 0);
                return hashCode;
            }
        }

        public static bool operator ==(PrefabModelTypeOptionsOverride left, PrefabModelTypeOptionsOverride right)
        {
            return Equals(left, right);
        }

        public static bool operator !=(PrefabModelTypeOptionsOverride left, PrefabModelTypeOptionsOverride right)
        {
            return !Equals(left, right);
        }

#endregion
    }
}
