#region

using System;
using System.Collections.Generic;
using Appalachia.Core.Behaviours;
using Appalachia.Core.Collections;
using Appalachia.Core.Collections.Implementations.Lists;
using Appalachia.Core.Debugging;
using Appalachia.Core.Scriptables;
using Appalachia.Editing.Debugging;
using Appalachia.Editing.Debugging.Handle;
using Appalachia.Spatial.Octree;
using Appalachia.Utility.Logging;
using AwesomeTechnologies.Vegetation.PersistentStorage;
using AwesomeTechnologies.VegetationStudio;
using AwesomeTechnologies.VegetationSystem;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.Rendering;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Vegetation
{
    public class PersistentStorageObstacleMaskCreator : AppalachiaBehaviour
    {
        public ObstacleMaskQuality ObstacleMaskQuality = ObstacleMaskQuality.High4096;

        [InlineEditor(InlineEditorObjectFieldModes.Boxed)]
        public VegetationPrefabCollisionRemovalMetadata metadata;

        public Bounds itemBounds;

        public bool drawRemovals;

        [PropertyRange(1f, 100f)]
        public float removalDrawRadius = 10f;

        [PropertyRange(0, nameof(targetRemovalMax))]
        public int targetRemoval;

        private Dictionary<string, VegetationItemInfoPro> lookup = new();

        private BoundsOctree<string> octree;

        public List<VegetationRemovalInfo> removals = new(256);

        private int targetRemovalMax => metadata.collisionInfos.Count - 1;

#if UNITY_EDITOR
        private void OnDrawGizmosSelected()
        {
            if (!drawRemovals)
            {
                return;
            }

            if (!GizmoCameraChecker.ShouldRenderGizmos())
            {
                return;
            }

            var terrainPosition = Terrain.activeTerrain.GetPosition();
            var cameraPosition = Camera.current.transform.position;

            var target = metadata.collisionInfos[targetRemoval];

            foreach (var removalList in removals)
            {
                var targeted = removalList.info.VegetationItemID == target.vegetationItemID;

                for (var i = 0; i < removalList.removals.Count; i++)
                {
                    var removal = removalList.removals[i];

                    var item = removalList.info.VegetationItemList[removal];

                    var position = item.Position + terrainPosition;

                    if (targeted)
                    {
                        SmartHandles.DrawWireSphere(position, item.Scale.magnitude, Color.yellow);
                    }
                    else
                    {
                        var distance = (position - cameraPosition).magnitude;

                        if (distance < removalDrawRadius)
                        {
                            SmartHandles.DrawWireSphere(position, item.Scale.magnitude, Color.red);
                        }
                    }
                }
            }
        }
#endif

#if UNITY_EDITOR
        [Button]
        public void CreateNewMetadata()
        {
            metadata = AppalachiaObject.CreateNew<VegetationPrefabCollisionRemovalMetadata>();
        }
#endif

        public int GetObstacleMaskQualityPixelResolution(ObstacleMaskQuality obstacleMaskQuality)
        {
            switch (obstacleMaskQuality)
            {
                case ObstacleMaskQuality.Low1024:
                    return 1024;
                case ObstacleMaskQuality.Normal2048:
                    return 2048;
                case ObstacleMaskQuality.High4096:
                    return 4096;
                case ObstacleMaskQuality.Ultra8192:
                    return 8192;
                default:
                    return 1024;
            }
        }

        [Button]
        public void UpdateList()
        {
            try
            {
                metadata.collisionInfos.Clear();

                var manager = FindObjectOfType<VegetationStudioManager>();

                var systems = manager.VegetationSystemList;

                foreach (var system in systems)
                {
                    foreach (var package in system.VegetationPackageProList)
                    {
                        foreach (var item in package.VegetationInfoList)
                        {
                            if (item.VegetationPrefab == null)
                            {
                                continue;
                            }

                            var collisionInfo = new VegetationPrefabCollisionRemovalInfo
                            {
                                prefab = item.VegetationPrefab,
                                prefabType = item.VegetationType,
                                vegetationItemID = item.VegetationItemID,
                                scale = new Vector2(item.MinScale, item.MaxScale),
                                bounds = item.Bounds,
                                footprint00m = new Bounds(),
                                footprint01m = new Bounds(),
                                footprint02m = new Bounds(),
                                footprint04m = new Bounds(),
                                footprint06m = new Bounds(),
                                footprint10m = new Bounds(),
                                footprint15m = new Bounds(),
                                footprint20m = new Bounds()
                            };

                            var renderers = collisionInfo.prefab
                                                         .GetComponentsInChildren<MeshRenderer>();

                            foreach (var rndr in renderers)
                            {
                                if (rndr.shadowCastingMode == ShadowCastingMode.ShadowsOnly)
                                {
                                    continue;
                                }

                                var meshFilter = rndr.GetComponent<MeshFilter>();

                                var sharedMesh = meshFilter.sharedMesh;
                                var verts = sharedMesh.vertices;
                                var tris = sharedMesh.triangles;

                                bool TestVertexContained(
                                    Vector3 v0,
                                    float heightLow,
                                    float heightHigh)
                                {
                                    return (v0.y > heightLow) && (v0.y < heightHigh);
                                }

                                bool TestVertexAbove(Vector3 v0, float height)
                                {
                                    return v0.y > height;
                                }

                                bool TestTriangle(
                                    Vector3 v0,
                                    Vector3 v1,
                                    Vector3 v2,
                                    float heightLow,
                                    float heightHigh)
                                {
                                    if (TestVertexContained(v0, heightLow, heightHigh) ||
                                        TestVertexContained(v1, heightLow, heightHigh) ||
                                        TestVertexContained(v2, heightLow, heightHigh))
                                    {
                                        return true;
                                    }

                                    var v0A = TestVertexAbove(v0, (heightLow + heightHigh) / 2f);
                                    var v1A = TestVertexAbove(v0, (heightLow + heightHigh) / 2f);
                                    var v2A = TestVertexAbove(v0, (heightLow + heightHigh) / 2f);

                                    var sum = v0A ? 1 : 0;
                                    sum += v1A ? 1 : 0;
                                    sum += v2A ? 1 : 0;

                                    if ((sum == 1) || (sum == 2))
                                    {
                                        return true;
                                    }

                                    return false;
                                }

                                var range = .25f;

                                for (var i = 0; i < tris.Length; i += 3)
                                {
                                    var v0 = verts[tris[i + 0]] *
                                             ((collisionInfo.scale.x + collisionInfo.scale.y) / 2f);
                                    var v1 = verts[tris[i + 1]] *
                                             ((collisionInfo.scale.x + collisionInfo.scale.y) / 2f);
                                    var v2 = verts[tris[i + 2]] *
                                             ((collisionInfo.scale.x + collisionInfo.scale.y) / 2f);

                                    var testSize = 00;
                                    if (TestTriangle(
                                        v0,
                                        v1,
                                        v2,
                                        testSize - range,
                                        testSize + range
                                    ))
                                    {
                                        var point = (v0 + v1 + v2) / 3f;

                                        point.y = Mathf.Clamp(
                                            point.y,
                                            testSize - range,
                                            testSize + range
                                        );
                                        collisionInfo.footprint00m.Encapsulate(point);
                                    }

                                    testSize = 01;
                                    if (TestTriangle(
                                        v0,
                                        v1,
                                        v2,
                                        testSize - range,
                                        testSize + range
                                    ))
                                    {
                                        var point = (v0 + v1 + v2) / 3f;

                                        point.y = Mathf.Clamp(
                                            point.y,
                                            testSize - range,
                                            testSize + range
                                        );
                                        collisionInfo.footprint01m.Encapsulate(point);
                                    }

                                    testSize = 02;
                                    if (TestTriangle(
                                        v0,
                                        v1,
                                        v2,
                                        testSize - range,
                                        testSize + range
                                    ))
                                    {
                                        var point = (v0 + v1 + v2) / 3f;

                                        point.y = Mathf.Clamp(
                                            point.y,
                                            testSize - range,
                                            testSize + range
                                        );
                                        collisionInfo.footprint02m.Encapsulate(point);
                                    }

                                    testSize = 04;
                                    if (TestTriangle(
                                        v0,
                                        v1,
                                        v2,
                                        testSize - range,
                                        testSize + range
                                    ))
                                    {
                                        var point = (v0 + v1 + v2) / 3f;

                                        point.y = Mathf.Clamp(
                                            point.y,
                                            testSize - range,
                                            testSize + range
                                        );
                                        collisionInfo.footprint04m.Encapsulate(point);
                                    }

                                    testSize = 06;
                                    if (TestTriangle(
                                        v0,
                                        v1,
                                        v2,
                                        testSize - range,
                                        testSize + range
                                    ))
                                    {
                                        var point = (v0 + v1 + v2) / 3f;

                                        point.y = Mathf.Clamp(
                                            point.y,
                                            testSize - range,
                                            testSize + range
                                        );
                                        collisionInfo.footprint06m.Encapsulate(point);
                                    }

                                    testSize = 10;
                                    if (TestTriangle(
                                        v0,
                                        v1,
                                        v2,
                                        testSize - range,
                                        testSize + range
                                    ))
                                    {
                                        var point = (v0 + v1 + v2) / 3f;

                                        point.y = Mathf.Clamp(
                                            point.y,
                                            testSize - range,
                                            testSize + range
                                        );
                                        collisionInfo.footprint10m.Encapsulate(point);
                                    }

                                    testSize = 15;
                                    if (TestTriangle(
                                        v0,
                                        v1,
                                        v2,
                                        testSize - range,
                                        testSize + range
                                    ))
                                    {
                                        var point = (v0 + v1 + v2) / 3f;

                                        point.y = Mathf.Clamp(
                                            point.y,
                                            testSize - range,
                                            testSize + range
                                        );
                                        collisionInfo.footprint15m.Encapsulate(point);
                                    }

                                    testSize = 20;
                                    if (TestTriangle(
                                        v0,
                                        v1,
                                        v2,
                                        testSize - range,
                                        testSize + range
                                    ))
                                    {
                                        var point = (v0 + v1 + v2) / 3f;

                                        point.y = Mathf.Clamp(
                                            point.y,
                                            testSize - range,
                                            testSize + range
                                        );
                                        collisionInfo.footprint20m.Encapsulate(point);
                                    }
                                }
                            }

                            metadata.collisionInfos.Add(collisionInfo);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                AppaLog.Error(ex);
            }
        }

        [Button]
        public void OrderList()
        {
            var vtOrder = new[]
            {
                VegetationType.LargeObjects,
                VegetationType.Tree,
                VegetationType.Objects,
                VegetationType.Plant,
                VegetationType.Grass
            };

            metadata.collisionInfos.Sort(
                (ci, oci) =>
                {
                    var cii = 0;
                    var ocii = 0;

                    for (var i = 0; i < vtOrder.Length; i++)
                    {
                        if (vtOrder[i] == ci.prefabType)
                        {
                            cii = i;
                        }

                        if (vtOrder[i] == oci.prefabType)
                        {
                            ocii = i;
                        }
                    }

                    if (cii != ocii)
                    {
                        return cii.CompareTo(ocii);
                    }

                    return -1 *
                           (ci.bounds.size.magnitude * ci.scaleAverage).CompareTo(
                               oci.bounds.size.magnitude * oci.scaleAverage
                           );
                }
            );
        }

        [Button]
        public void OrderListByBounds()
        {
            metadata.collisionInfos.Sort(
                (ci, oci) =>
                    -1 *
                    (ci.bounds.size.magnitude * ci.scaleAverage).CompareTo(
                        oci.bounds.size.magnitude * oci.scaleAverage
                    )
            );
        }

        [Button]
        public void RebuildVegetationLookup()
        {
            try
            {
                if (lookup == null)
                {
                    lookup = new Dictionary<string, VegetationItemInfoPro>();
                }

                lookup.Clear();

                var manager = FindObjectOfType<VegetationStudioManager>();

                var systems = manager.VegetationSystemList;

                foreach (var system in systems)
                {
                    foreach (var package in system.VegetationPackageProList)
                    {
                        foreach (var item in package.VegetationInfoList)
                        {
                            lookup.Add(item.VegetationItemID, item);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                AppaLog.Error(ex);
            }
        }

        [Button]
        public void ExamineItemBounds()
        {
            try
            {
                itemBounds = new Bounds();

                foreach (var cell in metadata.persistentStorage.PersistentVegetationCellList)
                {
                    foreach (var persistent in cell.PersistentVegetationInfoList)
                    {
                        var ID = persistent.VegetationItemID;
                        var pro = lookup[ID];

                        foreach (var item in persistent.VegetationItemList)
                        {
                            var b = new Bounds(item.Position, pro.Bounds.size);

                            b.size = new Vector3(
                                b.size.x * item.Scale.x,
                                b.size.y * item.Scale.y,
                                b.size.z * item.Scale.z
                            );

                            var c = b.center;
                            c.y += b.min.y;

                            b.center = c;

                            itemBounds.Encapsulate(b);
                        }
                    }
                }

                itemBounds.size *= 1.1f;

                AppaLog.Info(itemBounds);
            }
            catch (Exception ex)
            {
                AppaLog.Error(ex);
            }
        }

        [Button]
        public void BuildOctree()
        {
            try
            {
                if (removals == null)
                {
                    removals = new List<VegetationRemovalInfo>();
                }

                removals.Clear();

                octree = new BoundsOctree<string>(OctreeStyle.FourDivisions, itemBounds);

                for (var cindex = 0; cindex < metadata.collisionInfos.Count; cindex++)
                {
                    var collisionInfo = metadata.collisionInfos[cindex];
                    collisionInfo.removals = 0;
                    collisionInfo.instances = 0;

                    foreach (var cell in metadata.persistentStorage.PersistentVegetationCellList)
                    {
                        foreach (var persistent in cell.PersistentVegetationInfoList)
                        {
                            var removal = new VegetationRemovalInfo
                            {
                                info = persistent, removals = new AppaList_int(2048)
                            };

                            removals.Add(removal);

                            if (persistent.VegetationItemID != collisionInfo.vegetationItemID)
                            {
                                continue;
                            }

                            for (var i = persistent.VegetationItemList.Count - 1; i >= 0; i--)
                            {
                                var item = persistent.VegetationItemList[i];

                                collisionInfo.instances += 1;

                                //var scale = (item.Scale.x+item.Scale.y+item.Scale.z)/3f;
                                //var originalScale = (collisionInfo.scale.x + collisionInfo.scale.y) / 2f;

                                //var updatedScale = scale / originalScale;

                                var scaled00 = collisionInfo.footprint00m;
                                var scaled01 = collisionInfo.footprint01m;
                                var scaled02 = collisionInfo.footprint02m;
                                var scaled04 = collisionInfo.footprint04m;
                                var scaled06 = collisionInfo.footprint06m;
                                var scaled10 = collisionInfo.footprint10m;
                                var scaled15 = collisionInfo.footprint15m;
                                var scaled20 = collisionInfo.footprint20m;

                                scaled00.size *= collisionInfo.adjustBounds;
                                scaled01.size *= collisionInfo.adjustBounds;
                                scaled02.size *= collisionInfo.adjustBounds;
                                scaled04.size *= collisionInfo.adjustBounds;
                                scaled06.size *= collisionInfo.adjustBounds;
                                scaled10.size *= collisionInfo.adjustBounds;
                                scaled15.size *= collisionInfo.adjustBounds;
                                scaled20.size *= collisionInfo.adjustBounds;

                                scaled00.center += item.Position;
                                scaled01.center += item.Position;
                                scaled02.center += item.Position;
                                scaled04.center += item.Position;
                                scaled06.center += item.Position;
                                scaled10.center += item.Position;
                                scaled15.center += item.Position;
                                scaled20.center += item.Position;

                                if ((scaled00.size.magnitude > .001f) &&
                                    octree.HasAny(OctreeQueryMode.InsideOrIntersecting, scaled00))
                                {
                                    collisionInfo.removals += 1;
                                    removal.removals.Add(i);
                                    continue;
                                }

                                if ((scaled01.size.magnitude > .001f) &&
                                    octree.HasAny(OctreeQueryMode.InsideOrIntersecting, scaled01))
                                {
                                    collisionInfo.removals += 1;
                                    removal.removals.Add(i);
                                    continue;
                                }

                                if ((scaled02.size.magnitude > .001f) &&
                                    octree.HasAny(OctreeQueryMode.InsideOrIntersecting, scaled02))
                                {
                                    collisionInfo.removals += 1;
                                    removal.removals.Add(i);
                                    continue;
                                }

                                if ((scaled04.size.magnitude > .001f) &&
                                    octree.HasAny(OctreeQueryMode.InsideOrIntersecting, scaled04))
                                {
                                    collisionInfo.removals += 1;
                                    removal.removals.Add(i);
                                    continue;
                                }

                                if ((scaled06.size.magnitude > .001f) &&
                                    octree.HasAny(OctreeQueryMode.InsideOrIntersecting, scaled06))
                                {
                                    collisionInfo.removals += 1;
                                    removal.removals.Add(i);
                                    continue;
                                }

                                if ((scaled10.size.magnitude > .001f) &&
                                    octree.HasAny(OctreeQueryMode.InsideOrIntersecting, scaled10))
                                {
                                    collisionInfo.removals += 1;
                                    removal.removals.Add(i);
                                    continue;
                                }

                                if ((scaled15.size.magnitude > .001f) &&
                                    octree.HasAny(OctreeQueryMode.InsideOrIntersecting, scaled15))
                                {
                                    collisionInfo.removals += 1;
                                    removal.removals.Add(i);
                                    continue;
                                }

                                if ((scaled20.size.magnitude > .001f) &&
                                    octree.HasAny(OctreeQueryMode.InsideOrIntersecting, scaled20))
                                {
                                    collisionInfo.removals += 1;
                                    removal.removals.Add(i);
                                    continue;
                                }

                                if (scaled00.size.magnitude > .001f)
                                {
                                    octree.Add(scaled00, collisionInfo.vegetationItemID);
                                }

                                if (scaled01.size.magnitude > .001f)
                                {
                                    octree.Add(scaled01, collisionInfo.vegetationItemID);
                                }

                                if (scaled02.size.magnitude > .001f)
                                {
                                    octree.Add(scaled02, collisionInfo.vegetationItemID);
                                }

                                if (scaled04.size.magnitude > .001f)
                                {
                                    octree.Add(scaled04, collisionInfo.vegetationItemID);
                                }

                                if (scaled06.size.magnitude > .001f)
                                {
                                    octree.Add(scaled06, collisionInfo.vegetationItemID);
                                }

                                if (scaled10.size.magnitude > .001f)
                                {
                                    octree.Add(scaled10, collisionInfo.vegetationItemID);
                                }

                                if (scaled15.size.magnitude > .001f)
                                {
                                    octree.Add(scaled15, collisionInfo.vegetationItemID);
                                }

                                if (scaled20.size.magnitude > .001f)
                                {
                                    octree.Add(scaled20, collisionInfo.vegetationItemID);
                                }
                            }
                        }
                    }
                }

                AppaLog.Info(itemBounds);
            }
            catch (Exception ex)
            {
                AppaLog.Error(ex);
            }
        }

        [Button]
        public void ExecuteRemovals()
        {
            try
            {
                foreach (var removalList in removals)
                {
                    for (var i = 0; i < removalList.removals.Count; i++)
                    {
                        var removal = removalList.removals[i];
                        removalList.info.RemovePersistentVegetationInstanceAtIndex(removal);
                    }
                }

                removals.Clear();
            }
            catch (Exception ex)
            {
                AppaLog.Error(ex);
            }
        }

        public class VegetationRemovalInfo
        {
            public PersistentVegetationInfo info;
            public AppaList<int> removals;
        }
    }
}
