#region

using System;
using Appalachia.Core.Extensions;
using Appalachia.Rendering.Prefabs.Core;
using Appalachia.Rendering.Prefabs.Core.States;
using Appalachia.Rendering.Prefabs.Rendering.Base;
using Appalachia.Rendering.Prefabs.Rendering.Burstable;
using Appalachia.Utility.Extensions;
using Sirenix.OdinInspector;
using Unity.Profiling;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.ModelType
{
    [Serializable]
    [InlineEditor(Expanded = true, ObjectFieldMode = InlineEditorObjectFieldModes.Foldout)]
    [InlineProperty]
    public class PrefabModelTypeOptionsWrapper : PrefabTypeOptionsWrapper<PrefabModelType,
        PrefabModelTypeOptions, PrefabModelTypeOptionsOverride, PrefabModelTypeOptionsSetData,
        PrefabModelTypeOptionsWrapper, PrefabModelTypeOptionsLookup, Index_PrefabModelTypeOptions,
        PrefabModelTypeOptionsToggle, Index_PrefabModelTypeOptionsToggle, AppaList_PrefabModelType,
        AppaList_PrefabModelTypeOptionsWrapper, AppaList_PrefabModelTypeOptionsToggle>
    {
        private const string _PRF_PFX = nameof(PrefabModelTypeOptionsWrapper) + ".";

        private static readonly ProfilerMarker _PRF_OnEnable = new(_PRF_PFX + nameof(OnEnable));

        private static readonly ProfilerMarker _PRF_GetFrustum = new(_PRF_PFX + nameof(GetFrustum));

        private static readonly ProfilerMarker _PRF_GetFrustum_RetrieveCache =
            new(_PRF_PFX + nameof(GetFrustum) + ".RetrieveCache");

        private static readonly ProfilerMarker _PRF_GetFrustum_RetrieveCache_GetCameras =
            new(_PRF_PFX + nameof(GetFrustum) + ".RetrieveCache.GetCameras");

        private static readonly ProfilerMarker _PRF_GetFrustum_RetrieveCache_AssignProperties =
            new(_PRF_PFX + nameof(GetFrustum) + ".RetrieveCache.AssignProperties");

        private static readonly ProfilerMarker _PRF_GetFrustum_RetrieveCache_CreatePlanes =
            new(_PRF_PFX + nameof(GetFrustum) + ".RetrieveCache.CreatePlanes");

        private Camera _cam;

        private FrustumPlanesWrapper _frustum;
        private Camera _frustumCam;

        private int prefabCount =>
            PrefabRenderingManager.instance.renderingSets == null
                ? 0
                : PrefabRenderingManager.instance.renderingSets.ModelTypeCounts.GetPrefabTypeCount(
                    type
                );

        private InstanceStateCounts instanceCounts =>
            PrefabRenderingManager.instance.renderingSets == null
                ? default
                : PrefabRenderingManager.instance.renderingSets.ModelTypeCounts.GetInstanceCount(
                    type
                );

        public override string Title => type.ToString().SeperateWords();

        //public string Subtitle => $"{prefabCount} prefabs | {instanceCounts.total} instances";
        public override string Subtitle => $"{prefabCount} prefabs | {instanceCounts.ToString()}";

        protected override void OnEnable()
        {
            using (_PRF_OnEnable.Auto())
            {
                base.OnEnable();
                var ranges = _options.rangeSettings;

                if ((ranges == null) || (ranges.Length <= 0))
                {
                    return;
                }

                for (var i = 0; i < (ranges.Length - 2); i++)
                {
                    if (!ranges[i].showRangeLimit)
                    {
                        ranges[i].showRangeLimit = true;
                       this.MarkAsModified();
                    }
                }

                if (ranges[ranges.Length - 1].showRangeLimit)
                {
                    ranges[ranges.Length - 1].showRangeLimit = false;
                   this.MarkAsModified();
                }
            }
        }

        public FrustumPlanesWrapper GetFrustum(Camera camera, Camera frustumCamera)
        {
            using (_PRF_GetFrustum.Auto())
            {
                _cam = camera;
                _frustumCam = frustumCamera;

                using (_PRF_GetFrustum_RetrieveCache.Auto())
                {
                    using (_PRF_GetFrustum_RetrieveCache_GetCameras.Auto())
                    {
                        if (_cam == null)
                        {
                            _cam = Camera.main;
                        }

                        if (_frustumCam == null)
                        {
                            _frustumCam = PrefabRenderingManager.instance.frustumCamera;
                        }
                    }

                    using (_PRF_GetFrustum_RetrieveCache_AssignProperties.Auto())
                    {
                        _frustumCam.cullingMask = -1;
                        _frustumCam.clearFlags = CameraClearFlags.SolidColor;
                        _frustumCam.backgroundColor = Color.red;
                        _frustumCam.depth = -100;
                        _frustumCam.useOcclusionCulling = false;
                        _frustumCam.enabled = false;
                        _frustumCam.allowHDR = false;
                        _frustumCam.allowMSAA = false;
                    }

                    using (_PRF_GetFrustum_RetrieveCache_CreatePlanes.Auto())
                    {
                        options.CreateFrustumPlanes(_cam, _frustumCam, ref _frustum);
                    }

                    return _frustum;
                }
            }
        }
    }
}
