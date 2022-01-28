#region

using System.Collections.Generic;
using System.Linq;
using Appalachia.Core.Attributes;
using Appalachia.Core.Objects.Availability;
using AwesomeTechnologies.VegetationSystem;
using Unity.Profiling;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering
{
    [CallStaticConstructorInEditor]
    public static class PrefabRenderingManagerModifier
    {
        static PrefabRenderingManagerModifier()
        {
            RegisterInstanceCallbacks.WithoutSorting().When.Behaviour<PrefabRenderingManager>().IsAvailableThen( i => _prefabRenderingManager = i);
        }

        #region Static Fields and Autoproperties

        private static PrefabRenderingManager _prefabRenderingManager;

        #endregion

        public static void UpdateVegetationItemRendering(string vegetationItemID)
        {
            using (_PRF_UpdateVegetationItemRendering.Auto())
            {
                var manager = _prefabRenderingManager;
                if (!manager.enabled)
                {
                    return;
                }

                for (var setIndex = 0; setIndex < manager.renderingSets.Sets.Count; setIndex++)
                {
                    var renderingSet = manager.renderingSets.Sets.at[setIndex];
                    var parameters = renderingSet.ExternalParameters;

                    var targetSet = false;

                    for (var parameterIndex = 0; parameterIndex < parameters.Count; parameterIndex++)
                    {
                        var parameter = parameters.at[parameterIndex];

                        if (parameter.vegetationItemID == vegetationItemID)
                        {
                            targetSet = true;
                            break;
                        }
                    }

                    if (!targetSet)
                    {
                        continue;
                    }

                    PrefabRenderingManagerDestroyer.ExecuteDataSetTeardown(renderingSet);
                }
            }
        }

        public static void UpdateVegetationItemsRendering(IEnumerable<string> vegetationItemIDs)
        {
            using (_PRF_UpdateVegetationItemsRendering.Auto())
            {
                var manager = _prefabRenderingManager;
                if (!manager.enabled)
                {
                    return;
                }

                var referencePoint = manager.distanceReferencePoint.transform.position;
                var IDs = vegetationItemIDs.ToHashSet();

                for (var setIndex = 0; setIndex < manager.renderingSets.Sets.Count; setIndex++)
                {
                    var renderingSet = manager.renderingSets.Sets.at[setIndex];

                    var parameters = renderingSet.ExternalParameters;

                    var updateSet = false;

                    for (var parameterIndex = 0; parameterIndex < parameters.Count; parameterIndex++)
                    {
                        var parameter = parameters.at[parameterIndex];

                        if (IDs.Contains(parameter.vegetationItemID))
                        {
                            updateSet = true;
                            break;
                        }
                    }

                    if (updateSet)
                    {
                        PrefabRenderingManagerDestroyer.ExecuteDataSetTeardown(renderingSet);
                    }
                }

#if UNITY_EDITOR
                manager.SetSceneDirty();
#endif
            }
        }

        public static void UpdateVegetationItemsRendering(VegetationPackagePro package)
        {
            using (_PRF_UpdateVegetationItemsRendering.Auto())
            {
                var manager = _prefabRenderingManager;
                if (!manager.enabled)
                {
                    return;
                }

                UpdateVegetationItemsRendering(package.VegetationInfoList.Select(vi => vi.VegetationItemID));
            }
        }

        #region ProfilerMarker

        private const string _PRF_PFX = nameof(PrefabRenderingManagerModifier) + ".";

        private static readonly ProfilerMarker _PRF_UpdateVegetationItemsRendering =
            new(_PRF_PFX + nameof(UpdateVegetationItemsRendering));

        private static readonly ProfilerMarker _PRF_UpdateVegetationItemRendering =
            new(_PRF_PFX + nameof(UpdateVegetationItemRendering));

        #endregion
    }
}
