#region

using System;
using Appalachia.Core.Attributes;
using Appalachia.Rendering.Prefabs.Core;
using Appalachia.Rendering.Prefabs.Rendering.Base;
using Appalachia.Rendering.Prefabs.Rendering.ModelType.Instancing;
using Appalachia.Rendering.Prefabs.Rendering.ModelType.Positioning;
using Appalachia.Rendering.Prefabs.Rendering.ModelType.Rendering;
using Appalachia.Utility.Enums;
using UnityEngine.Rendering;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.ModelType
{
    [Serializable]
    [CallStaticConstructorInEditor]
    public class PrefabModelTypeOptionsLookup : PrefabTypeOptionsLookup<PrefabModelType,
        PrefabModelTypeOptions, PrefabModelTypeOptionsOverride, PrefabModelTypeOptionsSetData,
        PrefabModelTypeOptionsWrapper, PrefabModelTypeOptionsLookup, Index_PrefabModelTypeOptions,
        PrefabModelTypeOptionsToggle, Index_PrefabModelTypeOptionsToggle, AppaList_PrefabModelType,
        AppaList_PrefabModelTypeOptionsWrapper, AppaList_PrefabModelTypeOptionsToggle>
    {
        static PrefabModelTypeOptionsLookup()
        {
            _types = new EnumValuesCollection<PrefabModelType>(PrefabModelType.None);
        }

        protected override bool _anyMuted => PrefabModelTypeOptions.AnyMute;

        protected override bool _anySoloed => PrefabModelTypeOptions.AnySolo;

#if UNITY_EDITOR
        protected override void InitializeState()
        {
            for (var i = 0; i < _types.Length; i++)
            {
                var value = _types.Values[i];
                if (!_state.ContainsKey(value) ||
                    (_state[value] == null) ||
                    (_state[value].options == default) ||
                    (_state[value].options.rangeSettings == null) ||
                    (_state[value].options.rangeSettings.Length == 0))
                {
                    var options = PrefabModelTypeOptionsWrapper.LoadOrCreateNew(value.ToString());

                    switch (value)
                    {
                        case PrefabModelType.VegetationVerySmall:
                            options = options.Initialize(
                                value,
                                PrefabModelTypeOptions.InstancedOnly(
                                    50f,
                                    FrustumSettings.MatchCamera(),
                                    AssetLightingSettings.LitAndShadowed(),
                                    AssetCullingSettings.CompletelyCulled(),
                                    DistanceFalloffSettings.Fast(),
                                    LODFadeSettings.NoFade(),
                                    AssetBurialOptions.DoNotBury()
                                )
                            );
                            break;
                        case PrefabModelType.VegetationSmall:
                            options = options.Initialize(
                                value,
                                PrefabModelTypeOptions.InstancedOnly(
                                    100f,
                                    FrustumSettings.MatchCamera(),
                                    AssetLightingSettings.LitAndShadowed(),
                                    AssetCullingSettings.CompletelyCulled(),
                                    DistanceFalloffSettings.Fast(),
                                    LODFadeSettings.NoFade(),
                                    AssetBurialOptions.DoNotBury()
                                )
                            );
                            break;
                        case PrefabModelType.VegetationMedium:
                            options = options.Initialize(
                                value,
                                PrefabModelTypeOptions.InstancedOnly(
                                    125f,
                                    FrustumSettings.MatchCamera(),
                                    AssetLightingSettings.LitAndShadowed(),
                                    AssetCullingSettings.CompletelyCulled(),
                                    DistanceFalloffSettings.Fast(),
                                    LODFadeSettings.NoFade(),
                                    AssetBurialOptions.DoNotBury()
                                )
                            );
                            break;
                        case PrefabModelType.VegetationLarge:
                            options = options.Initialize(
                                value,
                                PrefabModelTypeOptions.InstancedOnly(
                                    150f,
                                    FrustumSettings.MatchCamera(),
                                    AssetLightingSettings.LitAndShadowed(),
                                    AssetCullingSettings.CompletelyCulled(),
                                    DistanceFalloffSettings.Fast(),
                                    LODFadeSettings.NoFade(),
                                    AssetBurialOptions.DoNotBury()
                                )
                            );
                            break;
                        case PrefabModelType.VegetationVeryLarge:
                            options = options.Initialize(
                                value,
                                PrefabModelTypeOptions.InstancedOnly(
                                    200,
                                    FrustumSettings.MatchCamera(),
                                    AssetLightingSettings.LitAndShadowed(),
                                    AssetCullingSettings.CompletelyCulled(),
                                    DistanceFalloffSettings.Fast(),
                                    LODFadeSettings.NoFade(),
                                    AssetBurialOptions.DoNotBury()
                                )
                            );
                            break;

                        case PrefabModelType.Scatter:
                            options = options.Initialize(
                                value,
                                PrefabModelTypeOptions.InstancedOnly(
                                    128f,
                                    FrustumSettings.MatchCamera(),
                                    AssetLightingSettings.LitAndShadowed(),
                                    AssetCullingSettings.CompletelyCulled(),
                                    DistanceFalloffSettings.Fast(),
                                    LODFadeSettings.NoFade(),
                                    AssetBurialOptions.DoNotBury()
                                )
                            );
                            break;

                        case PrefabModelType.TreeSmall:
                            options = options.Initialize(
                                value,
                                PrefabModelTypeOptions.Tree(
                                    128f,
                                    FrustumSettings.Wide(),
                                    AssetLightingSettings.LitAndShadowed(),
                                    AssetLightingSettings.LitAndShadowed(),
                                    AssetCullingSettings.CompletelyCulled(),
                                    DistanceFalloffSettings.Normal(),
                                    LODFadeSettings.FadeNarrow(),
                                    AssetRangeSettings.MeshRendered(5f, true, true),
                                    AssetRangeSettings.GPUInstanced(25f,   true, false),
                                    AssetRangeSettings.GPUInstanced(false, false)
                                )
                            );
                            break;

                        case PrefabModelType.TreeMedium:
                            options = options.Initialize(
                                value,
                                PrefabModelTypeOptions.Tree(
                                    256f,
                                    FrustumSettings.Wide(),
                                    AssetLightingSettings.LitAndShadowed(LightProbeUsage.UseProxyVolume),
                                    AssetLightingSettings.LitAndShadowed(),
                                    AssetCullingSettings.CompletelyCulled(),
                                    DistanceFalloffSettings.Slow(),
                                    LODFadeSettings.FadeNarrow(),
                                    AssetRangeSettings.MeshRendered(5f, true, true),
                                    AssetRangeSettings.GPUInstanced(30f,   true, false),
                                    AssetRangeSettings.GPUInstanced(false, false)
                                )
                            );
                            break;
                        case PrefabModelType.TreeLarge:
                            options = options.Initialize(
                                value,
                                PrefabModelTypeOptions.Tree(
                                    512f,
                                    FrustumSettings.Wide(),
                                    AssetLightingSettings.LitAndShadowed(LightProbeUsage.UseProxyVolume),
                                    AssetLightingSettings.LitAndShadowed(),
                                    AssetCullingSettings.CompletelyCulled(),
                                    DistanceFalloffSettings.VerySlow(),
                                    LODFadeSettings.FadeNarrow(),
                                    AssetRangeSettings.MeshRendered(5f, true, true),
                                    AssetRangeSettings.GPUInstanced(35f,   true, false),
                                    AssetRangeSettings.GPUInstanced(false, false)
                                )
                            );
                            break;
                        case PrefabModelType.ObjectVerySmall:
                            options = options.Initialize(
                                value,
                                PrefabModelTypeOptions.InteractableObject(
                                    64f,
                                    FrustumSettings.Wide(),
                                    AssetLightingSettings.LitAndShadowed(distance: 32f),
                                    AssetLightingSettings.LitAndShadowed(distance: 32f),
                                    AssetCullingSettings.CompletelyCulled(),
                                    DistanceFalloffSettings.Immediate(),
                                    LODFadeSettings.NoFade(),
                                    AssetRangeSettings.MeshRendered(5f, true, true),
                                    AssetRangeSettings.GPUInstanced(15f,   true, false),
                                    AssetRangeSettings.GPUInstanced(false, false)
                                )
                            );
                            break;
                        case PrefabModelType.ObjectSmall:
                            options = options.Initialize(
                                value,
                                PrefabModelTypeOptions.InteractableObject(
                                    128f,
                                    FrustumSettings.Wide(),
                                    AssetLightingSettings.LitAndShadowed(distance: 64f),
                                    AssetLightingSettings.LitAndShadowed(distance: 64f),
                                    AssetCullingSettings.CompletelyCulled(),
                                    DistanceFalloffSettings.Fast(),
                                    LODFadeSettings.FadeNarrow(),
                                    AssetRangeSettings.MeshRendered(5f, true, true),
                                    AssetRangeSettings.GPUInstanced(25f,   true, false),
                                    AssetRangeSettings.GPUInstanced(false, false)
                                )
                            );
                            break;
                        case PrefabModelType.ObjectMedium:
                            options = options.Initialize(
                                value,
                                PrefabModelTypeOptions.InteractableObject(
                                    256f,
                                    FrustumSettings.Wide(),
                                    AssetLightingSettings.LitAndShadowed(distance: 128f),
                                    AssetLightingSettings.LitAndShadowed(distance: 128f),
                                    AssetCullingSettings.CompletelyCulled(),
                                    DistanceFalloffSettings.Normal(),
                                    LODFadeSettings.FadeNarrow(),
                                    AssetRangeSettings.MeshRendered(5f, true, true),
                                    AssetRangeSettings.GPUInstanced(35f,   true, false),
                                    AssetRangeSettings.GPUInstanced(false, false)
                                )
                            );
                            break;
                        case PrefabModelType.ObjectLarge:
                            options = options.Initialize(
                                value,
                                PrefabModelTypeOptions.Object(
                                    384f,
                                    FrustumSettings.Wide(),
                                    AssetLightingSettings.LitAndShadowed(distance: 192f),
                                    AssetCullingSettings.CompletelyCulled(),
                                    DistanceFalloffSettings.Slow(),
                                    LODFadeSettings.FadeNormal(),
                                    AssetRangeSettings.GPUInstanced(35f,   true, false),
                                    AssetRangeSettings.GPUInstanced(false, false)
                                )
                            );
                            break;
                        case PrefabModelType.ObjectHuge:
                            options = options.Initialize(
                                value,
                                PrefabModelTypeOptions.Object(
                                    512f,
                                    FrustumSettings.Wide(),
                                    AssetLightingSettings.LitAndShadowed(distance: 256f),
                                    AssetCullingSettings.CompletelyCulled(),
                                    DistanceFalloffSettings.VerySlow(),
                                    LODFadeSettings.FadeWide(),
                                    AssetRangeSettings.GPUInstanced(25f,   true, false),
                                    AssetRangeSettings.GPUInstanced(false, false)
                                )
                            );
                            break;

                        case PrefabModelType.AssemblySmall:
                            options = options.Initialize(
                                value,
                                PrefabModelTypeOptions.Assembly(
                                    128f,
                                    FrustumSettings.Wide(),
                                    AssetLightingSettings.LitAndShadowed(distance: 64f),
                                    AssetCullingSettings.CompletelyCulled(),
                                    DistanceFalloffSettings.Normal(),
                                    LODFadeSettings.NoFade(),
                                    AssetBurialOptions.BuryAdjusted(),
                                    AssetRangeSettings.GPUInstanced(25f,   true, false),
                                    AssetRangeSettings.GPUInstanced(false, false)
                                )
                            );
                            break;
                        case PrefabModelType.AssemblyMedium:
                            options = options.Initialize(
                                value,
                                PrefabModelTypeOptions.Assembly(
                                    256f,
                                    FrustumSettings.Wide(),
                                    AssetLightingSettings.LitAndShadowed(distance: 128f),
                                    AssetCullingSettings.CompletelyCulled(),
                                    DistanceFalloffSettings.Slow(),
                                    LODFadeSettings.FadeNarrow(),
                                    AssetBurialOptions.BuryAdjusted(),
                                    AssetRangeSettings.GPUInstanced(35f,   true, false),
                                    AssetRangeSettings.GPUInstanced(false, false)
                                )
                            );
                            break;
                        case PrefabModelType.AssemblyLarge:
                            options = options.Initialize(
                                value,
                                PrefabModelTypeOptions.Assembly(
                                    512f,
                                    FrustumSettings.MatchCamera(),
                                    AssetLightingSettings.LitAndShadowed(distance: 256f),
                                    AssetCullingSettings.CompletelyCulled(),
                                    DistanceFalloffSettings.VerySlow(),
                                    LODFadeSettings.FadeNormal(),
                                    AssetBurialOptions.BuryAdjusted(),
                                    AssetRangeSettings.GPUInstanced(35f,   true, false),
                                    AssetRangeSettings.GPUInstanced(false, false)
                                )
                            );
                            break;
                        case PrefabModelType.AssemblyHuge:
                            options = options.Initialize(
                                value,
                                PrefabModelTypeOptions.Assembly(
                                    1024f,
                                    FrustumSettings.MatchCamera(),
                                    AssetLightingSettings.LitAndShadowed(distance: 512f),
                                    AssetCullingSettings.CompletelyCulled(),
                                    DistanceFalloffSettings.Off(),
                                    LODFadeSettings.FadeWide(),
                                    AssetBurialOptions.BuryAdjusted(),
                                    AssetRangeSettings.GPUInstanced(35f,   true, false),
                                    AssetRangeSettings.GPUInstanced(false, false)
                                )
                            );
                            break;
                        default:
                            throw new ArgumentOutOfRangeException();
                    }

                    _state.AddIfKeyNotPresent(value, options);
                }
            }
        }
#endif
    }
}
