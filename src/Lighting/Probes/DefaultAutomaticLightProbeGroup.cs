using System.Collections.Generic;
using Appalachia.Core.Collections;
using Appalachia.Utility.Strings;
using Sirenix.OdinInspector;
using UnityEngine;

namespace Appalachia.Rendering.Lighting.Probes
{
    public class DefaultAutomaticLightProbeGroup : AutomaticLightProbeGroup
    {
#if UNITY_EDITOR

        protected readonly HashSet<MeshFilter> hash_meshFilters = new();

        /// <inheritdoc />
        protected override bool ConsiderCollidables => true;

        /// <inheritdoc />
        protected override float GeometryBackoff => .02f;

        /// <inheritdoc />
        protected override string LightProbeGroupName => "_DEFAULT_LIGHT_PROBE_GROUP";

        /// <inheritdoc />
        protected override int TargetCount => hash_meshFilters.Count;

        [BoxGroup("Vertex Placement")]
        [LabelText("# of Vertices By Bounds")]
        public bool maxVerticesByBounds;

        [BoxGroup("Vertex Placement")]
        [LabelText("Points per Mesh")]
        [PropertyRange(4, 128)]
        [HideIf(nameof(maxVerticesByBounds))]
        public int maxVerticesPerMesh = 8;

        [BoxGroup("Vertex Placement")]
        [LabelText("Points per (m) Mult.")]
        [PropertyRange(0.1f, 3.0f)]
        [ShowIf(nameof(maxVerticesByBounds))]
        public float maxVerticesSizeMultiplier = 1.0f;

        /// <inheritdoc />
        protected override void RecreateTargetList()
        {
            // expand spawnObjects lists to include meshes, terrain, and colliders
            hash_meshFilters.Clear();
            colliders.Clear();

            for (var i = 0; i < collidables.Count; i++)
            {
                var collidable = boundsColliders[i];

                var mfs = collidable.GetComponents<MeshFilter>();
                var cs = collidable.GetComponents<Collider>();

                foreach (var mf in mfs)
                {
                    if (cullingMask == (cullingMask | (1 << mf.gameObject.layer)))
                    {
                        hash_meshFilters.Add(mf);
                    }
                }

                foreach (var c in cs)
                {
                    if (cullingMask == (cullingMask | (1 << c.gameObject.layer)))
                    {
                        colliders.Add(c);
                    }
                }

                mfs = collidable.GetComponentsInChildren<MeshFilter>();
                cs = collidable.GetComponentsInChildren<Collider>();

                foreach (var mf in mfs)
                {
                    if (cullingMask == (cullingMask | (1 << mf.gameObject.layer)))
                    {
                        hash_meshFilters.Add(mf);
                    }
                }

                foreach (var c in cs)
                {
                    if (cullingMask == (cullingMask | (1 << c.gameObject.layer)))
                    {
                        colliders.Add(c);
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
                if ((count % logStep) == 0)
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
                }

                count += 1;

                if (canceled)
                {
                    UnityEditor.EditorUtility.ClearProgressBar();
                    return;
                }

                var verts = mf.sharedMesh.vertices;
                var normals = mf.sharedMesh.normals;

                var step = 1;

                if (verts.Length < maxVerticesPerMesh)
                {
                }
                else if (maxVerticesByBounds)
                {
                    var mr = mf.GetComponent<MeshRenderer>();
                    var mag = mr.bounds.size.magnitude;
                    step = (int)(verts.Length / (mag * maxVerticesSizeMultiplier));
                }
                else
                {
                    step = (int)((float)verts.Length / maxVerticesPerMesh);
                }

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
