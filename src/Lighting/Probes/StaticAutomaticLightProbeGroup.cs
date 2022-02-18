using System.Collections.Generic;
using Appalachia.Core.Collections;
using Appalachia.Utility.Strings;
using Sirenix.OdinInspector;
using UnityEngine;

namespace Appalachia.Rendering.Lighting.Probes
{
    public class StaticAutomaticLightProbeGroup : AutomaticLightProbeGroup
    {
#if UNITY_EDITOR

        protected readonly HashSet<MeshFilter> hash_meshFilters = new();

        /// <inheritdoc />
        protected override bool ConsiderCollidables => false;

        /// <inheritdoc />
        protected override float GeometryBackoff => .15f;

        /// <inheritdoc />
        protected override string LightProbeGroupName => "_STATIC_LIGHT_PROBE_GROUP";

        /// <inheritdoc />
        protected override int TargetCount => hash_meshFilters.Count;

        [BoxGroup("Vertex Placement")]
        [LabelText("Test Points Per Mesh")]
        [PropertyRange(4, 128)]
        public int maxVerticesPerMesh = 4;

        private bool _considerCollidables;

        /// <inheritdoc />
        protected override void RecreateTargetList()
        {
            // expand spawnObjects lists to include meshes, terrain, and colliders
            hash_meshFilters.Clear();
            colliders.Clear();

            var gos = FindObjectsOfType<Transform>();

            foreach (var go in gos)
            {
                if (cullingMask == (cullingMask | (1 << go.gameObject.layer)))
                {
                    var flags = UnityEditor.GameObjectUtility.GetStaticEditorFlags(go.gameObject);

                    if (flags.HasFlag(UnityEditor.StaticEditorFlags.ContributeGI))
                    {
                        var mr = go.GetComponent<MeshRenderer>();
                        var mf = go.GetComponent<MeshFilter>();

                        if ((mr != null) && (mf != null))
                        {
                            hash_meshFilters.Add(mf);

                            var cs = go.GetComponents<Collider>();

                            foreach (var c in cs)
                            {
                                if (cullingMask == (cullingMask | (1 << c.gameObject.layer)))
                                {
                                    colliders.Add(c);
                                }
                            }
                        }
                    }
                }
            }
        }

        /// <inheritdoc />
        protected override void GenerateProbesForTargets(AppaList<Vector3> points, ref bool canceled)
        {
            var count = 0;

            // if meshes are selected, spawn at their vertex positions and above them.
            foreach (var mf in hash_meshFilters)
            {
                canceled = UnityEditor.EditorUtility.DisplayCancelableProgressBar(
                    ZString.Format("AutoProbe: Generating Light Probes ({0})", gameObject.name),
                    ZString.Format(
                        "Adding points for mesh [{0}]:  Total [{1}]",
                        mf.name,
                        mf.sharedMesh.vertexCount
                    ),
                    count / (float)hash_meshFilters.Count
                );

                count += 1;

                if (canceled)
                {
                    UnityEditor.EditorUtility.ClearProgressBar();
                    return;
                }

                var verts = mf.sharedMesh.vertices;
                var normals = mf.sharedMesh.normals;

                int step;

                step = (int)((float)verts.Length / maxVerticesPerMesh);

                if (step < 1)
                {
                    step = 1;
                }

                for (var index = 0; index < verts.Length; index += step)
                {
                    var v = verts[index];
                    var n = normals[index];

                    var pos = mf.transform.TransformPoint(v); // put v into world space
                    var nor = mf.transform.TransformDirection(n);

                    pos += nor * heightOffset;

                    if (IsInsideBounds(pos, false))
                    {
                        points.Add(pos);
                        AddToSpatialHash(pos);
                    }
                }
            }
        }

#endif
    }
}
