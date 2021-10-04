#region

using System.Collections.Generic;
using System.Linq;
using Appalachia.Core.Extensions;
using AwesomeTechnologies.VegetationSystem;
using Unity.Profiling;

#endregion

namespace Appalachia.Prefabs.Rendering
{
    public static class PrefabRenderingManagerModifier
    {
        public static void UpdateVegetationItemsRendering(IEnumerable<string> vegetationItemIDs)
        {
            using (_PRF_UpdateVegetationItemsRendering.Auto())
            {
                var manager = PrefabRenderingManager.instance;
                if (!manager.enabled)
                {
                    return;
                }

                var referencePoint = manager.distanceReferencePoint.transform.position;
                var IDs = vegetationItemIDs.ToHashSet2();

                for (var setIndex = 0; setIndex < manager.renderingSets.Sets.Count; setIndex++)
                {
                    var renderingSet = manager.renderingSets.Sets.at[setIndex];

                    var parameters = renderingSet.ExternalParameters;

                    var updateSet = false;

                    for (var parameterIndex = 0;
                        parameterIndex < parameters.Count;
                        parameterIndex++)
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

                manager.SetSceneDirty();
            }
        }

        public static void UpdateVegetationItemsRendering(VegetationPackagePro package)
        {
            using (_PRF_UpdateVegetationItemsRendering.Auto())
            {
                var manager = PrefabRenderingManager.instance;
                if (!manager.enabled)
                {
                    return;
                }

                UpdateVegetationItemsRendering(
                    package.VegetationInfoList.Select(vi => vi.VegetationItemID)
                );
            }
        }

        public static void UpdateVegetationItemRendering(string vegetationItemID)
        {
            using (_PRF_UpdateVegetationItemRendering.Auto())
            {
                var manager = PrefabRenderingManager.instance;
                if (!manager.enabled)
                {
                    return;
                }

                for (var setIndex = 0; setIndex < manager.renderingSets.Sets.Count; setIndex++)
                {
                    var renderingSet = manager.renderingSets.Sets.at[setIndex];
                    var parameters = renderingSet.ExternalParameters;

                    var targetSet = false;

                    for (var parameterIndex = 0;
                        parameterIndex < parameters.Count;
                        parameterIndex++)
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

#region ProfilerMarker

        private const string _PRF_PFX = nameof(PrefabRenderingManagerModifier) + ".";

        private static readonly ProfilerMarker _PRF_UpdateVegetationItemsRendering =
            new(_PRF_PFX + nameof(UpdateVegetationItemsRendering));

        private static readonly ProfilerMarker _PRF_UpdateVegetationItemRendering =
            new(_PRF_PFX + nameof(UpdateVegetationItemRendering));

#endregion
    }
}
