using System.Collections.Generic;
using Appalachia.Core.Collections;
using Appalachia.Utility.Strings;
using AwesomeTechnologies.VegetationStudio;
using AwesomeTechnologies.VegetationSystem;
using UnityEngine;

namespace Appalachia.Rendering.Lighting.Probes
{
    public class PersistentVegetationAutomaticLightProbeGroup : AutomaticLightProbeGroup
    {
#if UNITY_EDITOR

        /// <inheritdoc />
        protected override float GeometryBackoff => .1f;

        /// <inheritdoc />
        protected override string LightProbeGroupName => "_VSP_STORAGE_LIGHT_PROBE_GROUP";

        /// <inheritdoc />
        protected override int TargetCount => 1;

        /// <inheritdoc />
        protected override bool ConsiderCollidables => false;

        /// <inheritdoc />
        protected override void RecreateTargetList()
        {
        }

        /// <inheritdoc />
        protected override void GenerateProbesForTargets(AppaList<Vector3> points, ref bool canceled)
        {
            var systemList = VegetationStudioManager.Instance.VegetationSystemList;
            if ((systemList == null) || (systemList.Count == 0))
            {
                return;
            }

            var system = systemList[0];

            if ((system == null) ||
                (system.PersistentVegetationStorage == null) ||
                (system.PersistentVegetationStorage.PersistentVegetationStoragePackage == null))
            {
                return;
            }

            var veggieInfos = new Dictionary<string, VegetationItemInfoPro>();

            for (var packageIndex = 0; packageIndex < system.VegetationPackageProList.Count; packageIndex++)
            {
                var package = system.VegetationPackageProList[packageIndex];
                for (var vegIndex = 0; vegIndex < package.VegetationInfoList.Count; vegIndex++)
                {
                    var info = package.VegetationInfoList[vegIndex];
                    veggieInfos.Add(info.VegetationItemID, info);
                }
            }

            foreach (var cell in system.PersistentVegetationStorage.PersistentVegetationStoragePackage
                                       .PersistentVegetationCellList)
            {
                foreach (var info in cell.PersistentVegetationInfoList)
                {
                    var veggie = veggieInfos[info.VegetationItemID];

                    var bounds = veggie.Bounds;
                    var center = bounds.center;
                    var top = bounds.max.y;

                    var point = new Vector3(center.x, top, center.y);

                    var itemCount = 0;
                    var items = info.VegetationItemList.Count;

                    foreach (var item in info.VegetationItemList)
                    {
                        itemCount += 1;

                        if ((itemCount % logStep) == 0)
                        {
                            canceled = UnityEditor.EditorUtility.DisplayCancelableProgressBar(
                                ZString.Format("AutoProbe: Generating Light Probes ({0})", gameObject.name),
                                ZString.Format(
                                    "Adding point for mesh [{0}]:  Instances [{1}]",
                                    veggie.VegetationPrefab.name,
                                    items
                                ),
                                itemCount / (float)items
                            );
                        }

                        if (canceled)
                        {
                            UnityEditor.EditorUtility.ClearProgressBar();
                            return;
                        }

                        var testPoint = item.Position + point;

                        if (IsInsideBounds(testPoint, false))
                        {
                            points.Add(testPoint);
                            AddToSpatialHash(testPoint);
                        }
                    }
                }
            }
        }
#endif
    }
}
