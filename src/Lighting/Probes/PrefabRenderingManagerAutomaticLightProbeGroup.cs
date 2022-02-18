using Appalachia.Core.Attributes;
using Appalachia.Core.Collections;
using Appalachia.Rendering.Prefabs.Core;
using Appalachia.Rendering.Prefabs.Rendering;
using Appalachia.Rendering.Prefabs.Rendering.Runtime;
using Appalachia.Utility.Strings;
using UnityEngine;

namespace Appalachia.Rendering.Lighting.Probes
{
    [CallStaticConstructorInEditor]
    public class PrefabRenderingManagerAutomaticLightProbeGroup : AutomaticLightProbeGroup
    {
        static PrefabRenderingManagerAutomaticLightProbeGroup()
        {
            RegisterDependency<PrefabRenderingManager>(i => _prefabRenderingManager = i);
        }

        #region Static Fields and Autoproperties

        private static PrefabRenderingManager _prefabRenderingManager;

        #endregion

#if UNITY_EDITOR

        /// <inheritdoc />
        protected override float GeometryBackoff => .1f;

        /// <inheritdoc />
        protected override string LightProbeGroupName => "_PREFAB_REN_MAN_LIGHT_PROBE_GROUP";

        /// <inheritdoc />
        protected override int TargetCount => 1;

        /// <inheritdoc />
        protected override bool ConsiderCollidables => false;

        /// <inheritdoc />
        protected override void RecreateTargetList()
        {
        }

        private readonly PrefabModelType[] _allowedTypes =
        {
            PrefabModelType.ObjectHuge,
            PrefabModelType.AssemblyHuge,
            PrefabModelType.AssemblyLarge,
            PrefabModelType.ObjectLarge,
            PrefabModelType.TreeLarge,
            PrefabModelType.TreeMedium
        };

        /// <inheritdoc />
        protected override void GenerateProbesForTargets(AppaList<Vector3> points, ref bool canceled)
        {
            if (!_prefabRenderingManager.enabled ||
                (_prefabRenderingManager.gpui == null) ||
                !_prefabRenderingManager.gpui.gpuiSimulator.simulateAtEditor)
            {
                return;
            }

            var renderingSets = _prefabRenderingManager.renderingSets;

            for (var i = 0; i < renderingSets.Sets.Count; i++)
            {
                var data = renderingSets.Sets.at[i];

                if (data.instanceManager.currentState != RuntimeStateCode.Enabled)
                {
                    continue;
                }

                var found = false;
                for (var j = 0; j < _allowedTypes.Length; j++)
                {
                    if (_allowedTypes[j] == data.modelType)
                    {
                        found = true;
                        break;
                    }
                }

                if (!found)
                {
                    continue;
                }

                var bounds = data.bounds;

                if (bounds.size.magnitude < 1.0)
                {
                    continue;
                }

                var center = bounds.center;
                var top = bounds.max.y;

                var point = new Vector3(center.x, top, center.y);

                var itemCount = 0;

                if ((data.instanceManager.element?.instances == null) ||
                    (data.instanceManager.element.instances.Length <= 0))
                {
                    continue;
                }

                var items = data.instanceManager.element.instances.Length;

                foreach (var position in data.instanceManager.element.positions)
                {
                    itemCount += 1;

                    if ((itemCount % logStep) == 0)
                    {
                        canceled = UnityEditor.EditorUtility.DisplayCancelableProgressBar(
                            ZString.Format("AutoProbe: Generating Light Probes ({0})", gameObject.name),
                            ZString.Format(
                                "Adding point for mesh [{0}]:  Instances [{1}]",
                                data.prefab.name,
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

                    var testPoint = (Vector3)position + point;

                    if (IsInsideBounds(testPoint, false))
                    {
                        points.Add(testPoint);
                        AddToSpatialHash(testPoint);
                    }
                }
            }
        }
#endif
    }
}
