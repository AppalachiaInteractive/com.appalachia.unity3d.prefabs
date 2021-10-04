#region

using System;
using Appalachia.Core.Extensions;
using Appalachia.Jobs.Burstable;
using Appalachia.Prefabs.Rendering.ModelType.Instancing;
using Appalachia.Utility.Reflection.Delegated;
using Unity.Burst;
using Unity.Mathematics;
using Unity.Profiling;
using UnityEngine;

#endregion

namespace Appalachia.Prefabs.Rendering.Burstable
{
    [Serializable]
    public class FrustumPlanesWrapper
    {
        private const string _PRF_PFX = nameof(FrustumPlanesWrapper) + ".";
        

        [SerializeField] public float fieldOfView;

        [SerializeField] public float aspect;

        [SerializeField] public float nearClipPlane;

        [SerializeField] public float farClipPlane;

        [SerializeField] public FrustumPlanesBurst planes;

        [SerializeField] public Plane[] planesArray;

        [SerializeField] public float3[] cornersNear;

        [SerializeField] public float3[] cornersFar;

        [SerializeField] public float3 centerNear;

        [SerializeField] public float3 centerFar;

        private static readonly ProfilerMarker _PRF_FrustumPlanesWrapper = new ProfilerMarker(_PRF_PFX + nameof(FrustumPlanesWrapper));
        // Returns near- and far-corners in this order: leftBottom, leftTop, rightTop, rightBottom
        // Assumes input arrays are of length 4 (if allocated)
        public FrustumPlanesWrapper(Camera camera, Camera frustumCamera, FrustumSettings settings, float maxDistance)
        {
            using (_PRF_FrustumPlanesWrapper.Auto())
            {
                Update(camera, frustumCamera, settings, maxDistance);
            }
        }

        private static readonly ProfilerMarker _PRF_Update = new ProfilerMarker(_PRF_PFX + nameof(Update));
        public void Update(Camera camera, Camera frustumCamera, FrustumSettings settings, float maxDistance)
        {
            using (_PRF_Update.Auto())
            {
                var cameraT = camera.transform;
                var projectionMatrix = camera.projectionMatrix;
                var worldToCameraMatrix = camera.worldToCameraMatrix;
                var cameraToWorldMatrix = camera.cameraToWorldMatrix;

                fieldOfView = camera.fieldOfView + settings.fovOffset;
                aspect = camera.aspect * settings.aspectOffset;
                nearClipPlane = camera.nearClipPlane + settings.nearPlaneOffset;
                farClipPlane = camera.farClipPlane + settings.farPlaneOffset;

                fieldOfView = math.clamp(fieldOfView,     10f,  180f);
                aspect = math.clamp(aspect,               .1f,  10f);
                farClipPlane = math.clamp(farClipPlane,   .2f,  maxDistance);
                nearClipPlane = math.clamp(nearClipPlane, 0.1f, farClipPlane - .1f);

                //frustumCamera.cullingMask = 0;
                frustumCamera.fieldOfView = fieldOfView;
                frustumCamera.aspect = aspect;
                frustumCamera.nearClipPlane = nearClipPlane;
                frustumCamera.farClipPlane = farClipPlane;

                var copyT = frustumCamera.transform;
                copyT.rotation = cameraT.rotation;
                copyT.localScale = cameraT.lossyScale;

                var forward = copyT.forward;
                var right = copyT.right;
                var up = copyT.up;

                copyT.position = cameraT.position + (forward * settings.depthOffset);

                if ((planesArray == null) || (planesArray.Length != 6))
                {
                    planesArray = new Plane[6];
                }

                CalculateFrustumPlanes(projectionMatrix, worldToCameraMatrix, planesArray);

                planes = new FrustumPlanesBurst(planesArray);
                               
                if (GetFrustumPlaneSizeAt == null || GetLocalSpaceAim == null || _frustumCamera == null)
                {
                    GetFrustumPlaneSizeAt = new Function<Camera, float, Vector2>(frustumCamera, nameof(GetFrustumPlaneSizeAt));            
                    GetLocalSpaceAim = new Function<Camera, Vector3>(frustumCamera, nameof(GetLocalSpaceAim));        
                    _frustumCamera = frustumCamera;
                }

                var nearFrustumPlaneSize = GetFrustumPlaneSizeAt.Invoke(nearClipPlane);                
                var farFrustumPlaneSize = GetFrustumPlaneSizeAt.Invoke(farClipPlane);
                                
                var localSpaceAim = GetLocalSpaceAim.Invoke();
                
                if ((cornersNear == null) || (cornersNear.Length != 4))
                {
                    cornersNear = new float3[4];
                }

                if ((cornersFar == null) || (cornersFar.Length != 4))
                {
                    cornersFar = new float3[4];
                }

                GetFrustumCornersAt(nearClipPlane, nearFrustumPlaneSize, localSpaceAim, right, up, cameraToWorldMatrix, cornersNear);
                GetFrustumCornersAt(farClipPlane,  farFrustumPlaneSize,  localSpaceAim, right, up, cameraToWorldMatrix, cornersFar);

                centerNear = (cornersNear[0] + cornersNear[1] + cornersNear[2] + cornersNear[3]) / 4.0f;
                centerFar = (cornersFar[0] + cornersFar[1] + cornersFar[2] + cornersFar[3]) / 4.0f;
            }
        }

        private static Camera _frustumCamera;
        private static Function<Camera, float, Vector2> GetFrustumPlaneSizeAt;
        private static Function<Camera,  Vector3> GetLocalSpaceAim;
        private static StaticRoutine<GeometryUtility, Plane[], Matrix4x4> Internal_ExtractPlanes;

        private static readonly ProfilerMarker _PRF_CalculateFrustumPlanes = new ProfilerMarker(_PRF_PFX + nameof(CalculateFrustumPlanes));
        private static void CalculateFrustumPlanes(Matrix4x4 projectionMatrix, Matrix4x4 worldToCameraMatrix, Plane[] p)
        {
            using (_PRF_CalculateFrustumPlanes.Auto())
            {
                var matrix = projectionMatrix * worldToCameraMatrix;

                if (p == null)
                {
                    throw new ArgumentNullException(nameof(p));
                }

                if (p.Length != 6)
                {
                    throw new ArgumentException("Planes array must be of length 6.", nameof(p));
                }


                if (Internal_ExtractPlanes == null)
                {
                    Internal_ExtractPlanes = new StaticRoutine<GeometryUtility, Plane[], Matrix4x4>("Internal_ExtractPlanes");
                }

                Internal_ExtractPlanes.Invoke(p, matrix);
            }
        }

        private static readonly ProfilerMarker _PRF_GetFrustumCornersAt = new ProfilerMarker(_PRF_PFX + nameof(GetFrustumCornersAt));
        private static void GetFrustumCornersAt(
            float distance,
            float2 frustumPlaneSize,
            float3 localSpaceAim,
            float3 right,
            float3 up,
            float4x4 cameraToWorldMatrix,
            float3[] points)
        {
            using (_PRF_GetFrustumCornersAt.Auto())
            {
                var planeSize = frustumPlaneSize * .5f;
                var rightOffset = right * planeSize.x;
                var upOffset = up * planeSize.y;
                var localAim = localSpaceAim * distance;
                localAim.z = -localAim.z;

                var planePosition = cameraToWorldMatrix.MultiplyPoint(localAim);

                points[0] = planePosition - rightOffset - upOffset;   // leftBottom
                points[1] = (planePosition - rightOffset) + upOffset; // leftTop
                points[2] = planePosition + rightOffset + upOffset;   // rightTop
                points[3] = (planePosition + rightOffset) - upOffset; // rightBottom
            }
        }

        private static readonly ProfilerMarker _PRF_DrawFrustumGizmo = new ProfilerMarker(_PRF_PFX + nameof(DrawFrustumGizmo));
        public void DrawFrustumGizmo(Color c)
        {
            using (_PRF_DrawFrustumGizmo.Auto())
            {
                var orgColor = UnityEditor.Handles.color;
                UnityEditor.Handles.color = c;
                for (var i = 0; i < 4; ++i)
                {
                    UnityEditor.Handles.DrawLine(cornersNear[i], cornersNear[(i + 1) % 4]);
                    UnityEditor.Handles.DrawLine(cornersFar[i],  cornersFar[(i + 1) % 4]);
                    UnityEditor.Handles.DrawLine(cornersNear[i], cornersFar[i]);
                }

                UnityEditor.Handles.color = orgColor;
            }
        }

#region ToString

        [BurstDiscard]
        public override string ToString()
        {
            var range = centerFar - centerNear;
            var rangeMag = math.length(range);
            var dir = math.normalize(range);

            return $"From {Format(centerNear)} | Direction {Format(dir)} | Range {rangeMag:F1}m | FOV {fieldOfView:F1}";
        }

        private string Format(float3 f)
        {
            return $"({f.x},{f.y},{f.z})";
        }

#endregion
    }
}
