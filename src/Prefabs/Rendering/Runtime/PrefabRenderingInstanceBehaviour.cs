#region

using System;
using Appalachia.Core.Behaviours;
using Appalachia.Core.Debugging;
using Appalachia.Core.Preferences;
using Appalachia.Core.Preferences.Globals;
using Appalachia.Editing.Debugging;
using Appalachia.Editing.Debugging.Handle;
using Appalachia.Rendering.Prefabs.Core.States;
using Appalachia.Rendering.Prefabs.Rendering.ContentType;
using Appalachia.Rendering.Prefabs.Rendering.ModelType;
using Sirenix.OdinInspector;
using Unity.Mathematics;
using Unity.Profiling;
using UnityEditor;
using UnityEngine;
using UnityEngine.Serialization;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Runtime
{
    [ExecuteAlways]
    public class PrefabRenderingInstanceBehaviour : AppalachiaMonoBehaviour
    {
        private const string _PRF_PFX = nameof(PrefabRenderingInstanceBehaviour) + ".";

        private const string G_ = "Appalachia/Prefab Rendering/Gizmos/Instance";
        private static PREF<float> gizmoRadius;
        private static PREF<float> gizmoIncrement;
        private static PREF<int> gizmoLimit;
        private static PREF<bool> drawHandleLabels;
        private static PREF<float> handleRadius;
        private static int _cachedFrame;

        private static int _drawCount;

        //private static int _lastDrawCount;
        //private static int _additiveRadius;
        //private static bool _brokeEarly;
        private static Vector3 _cameraPosition;

        private static int _cachedFrameLocal;

        [TabGroup("Data")]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        public PrefabRenderingInstance instance;

        [TabGroup("Set")] public PrefabRenderingSet set;

        [FormerlySerializedAs("type")]
        [TabGroup("Model Options")]
        [InlineEditor(Expanded = true, ObjectFieldMode = InlineEditorObjectFieldModes.Hidden)]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        public PrefabModelTypeOptionsWrapper modelType;

        [FormerlySerializedAs("overrides")]
        [TabGroup("Model Overrides")]
        [InlineEditor(Expanded = true, ObjectFieldMode = InlineEditorObjectFieldModes.Hidden)]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        public PrefabModelTypeOptionsSetData modelOverrides;

        [FormerlySerializedAs("type")]
        [TabGroup("Content Options")]
        [InlineEditor(Expanded = true, ObjectFieldMode = InlineEditorObjectFieldModes.Hidden)]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        public PrefabContentTypeOptionsWrapper contentType;

        [TabGroup("Content Overrides")]
        [InlineEditor(Expanded = true, ObjectFieldMode = InlineEditorObjectFieldModes.Hidden)]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        public PrefabContentTypeOptionsSetData contentOverrides;

        private Bounds _bounds;
        private int _drawGizmoAt;
        private float _increment = .5f;
        private readonly int _pointCount = 4;
        private Vector3[] _points;
        private float _radius = .5f;
        private Matrix4x4 _stored;
        private Matrix4x4 ltw;
        private Vector3 p;
        private Quaternion r;
        private Vector3 s;
        private Transform t;

        /*private void OnDrawGizmos()
        {
            var t = transform;
            var ltw = t.localToWorldMatrix;
            var p = t.position;
            var r = t.rotation;
            var s = t.lossyScale;
            
            UnityEditor.Handles.PositionHandle(p, r);
        }*/

        public void Awaken()
        {
        }

        public void Sleep()
        {
        }
#if UNITY_EDITOR

        private static readonly ProfilerMarker _PRF_OnDrawGizmosSelected =
            new(_PRF_PFX + nameof(OnDrawGizmosSelected));

        private void OnDrawGizmosSelected()
        {
            using (_PRF_OnDrawGizmosSelected.Auto())
            {
                if (!GizmoCameraChecker.ShouldRenderGizmos())
                {
                    return;
                }

                var selections = Selection.gameObjects;

                var gizmoOptions = PrefabRenderingManager.instance.RenderingOptions.gizmos;

                if (!gizmoOptions.gizmosEnabled)
                {
                    return;
                }

                if (gizmoOptions.gizmosLimitedToSelected)
                {
                    if ((selections == null) || (selections.Length == 0) || (selections.Length > 1))
                    {
                        var id = gizmoOptions.gizmoSelectionID;

                        if (set.id != id)
                        {
                            return;
                        }
                    }

                    var selected = selections[0];

                    if ((selected != gameObject) && (selected.transform != transform.parent))
                    {
                        var id = gizmoOptions.gizmoSelectionID;

                        if (set.id != id)
                        {
                            return;
                        }
                    }
                }

                var frame = Time.frameCount;

                if (frame > _cachedFrame)
                {
                    if (gizmoRadius == null)
                    {
                        gizmoRadius = PREFS.REG(G_, "Max Size", .25f, .1f, 2f);
                    }

                    if (gizmoIncrement == null)
                    {
                        gizmoIncrement = PREFS.REG(G_, "Vertical", .5f, .1f, 2f);
                    }

                    if (gizmoLimit == null)
                    {
                        gizmoLimit = PREFS.REG(G_, "Limit", 25, 1, 150);
                    }

                    if (drawHandleLabels == null)
                    {
                        drawHandleLabels = PREFS.REG(G_, "Draw Labels", true);
                    }

                    if (handleRadius == null)
                    {
                        handleRadius = PREFS.REG(G_, "HandleRadius", 4f);
                    }

                    _cachedFrame = frame;
                    _drawCount = 0;

                    var gpui = PrefabRenderingManager.instance.gpui;
                    var options = PrefabModelTypeOptionsLookup.instance.State[set.modelType];

                    var cam = gpui.cameraData.mainCamera;

                    Gizmos.color = ColorPrefs.Instance.PRIIC_Gizmos.v;

                    var ct = cam.transform;
                    _cameraPosition = ct.position;

                    Handles.PositionHandle(_cameraPosition, ct.rotation);
                    Handles.Label(_cameraPosition, "Camera");

                    var frustum = options.GetFrustum(
                        gpui.cameraData.mainCamera,
                        PrefabRenderingManager.instance.frustumCamera
                    );

                    frustum.DrawFrustumGizmo(ColorPrefs.Instance.PRIIC_Gizmos.v);
                }

                if (_drawGizmoAt != frame)
                {
                    if (_cachedFrameLocal == frame)
                    {
                        return;
                    }

                    _cachedFrameLocal = frame;

                    if (!instance.inFrustum)
                    {
                        return;
                    }

                    if (_drawCount > gizmoLimit.v)
                    {
                        return;
                    }

                    t = transform;
                    ltw = t.localToWorldMatrix;
                    p = t.position;
                    r = t.rotation;
                    s = t.lossyScale;

                    var distance = math.distance(_cameraPosition, p);

                    if (distance > handleRadius.v)
                    {
                        return;
                    }

                    _drawGizmoAt = frame;
                    _drawCount += 1;
                }

                Handles.PositionHandle(p, r);

                if ((ltw != _stored) || (Math.Abs(_increment - gizmoIncrement.v) > float.Epsilon))
                {
                    if (_bounds == default)
                    {
                        if ((instance.renderers != null) && (instance.renderers.Length > 0))
                        {
                            _bounds = instance.renderers[0].bounds;
                        }
                    }

                    if (_bounds == default)
                    {
                        _increment = gizmoIncrement.v;
                        _radius = 1.0f;
                    }
                    else
                    {
                        _increment = _bounds.size.y / _pointCount;
                        _radius = (_bounds.size.x + _bounds.size.z) / 2.0f;
                    }

                    _increment = math.clamp(_increment, .1f, gizmoIncrement.v);
                    _radius = math.clamp(_radius,       .1f, 3.0f);

                    if ((_points == null) || (_points.Length != _pointCount))
                    {
                        _points = new Vector3[_pointCount];
                    }

                    for (var i = 0; i < _points.Length; i++)
                    {
                        _points[i] = ltw.MultiplyPoint3x4(Vector3.up * (_increment * i));
                    }

                    _stored = ltw;
                }

                var physx = instance.nextState.physics;
                var inter = instance.currentState.interaction;
                var rend = instance.currentState.rendering;
                var isc = instance.instancesStateCode;

                var physxColor = physx switch
                {
                    InstancePhysicsState.NotSet   => ColorPrefs.Instance.PRI_PHYS_NotSet,
                    InstancePhysicsState.Disabled => ColorPrefs.Instance.PRI_PHYS_Disabled,
                    _                             => ColorPrefs.Instance.PRI_PHYS_Enabled
                };

                var interColor = inter switch
                {
                    InstanceInteractionState.NotSet   => ColorPrefs.Instance.PRI_INT_NotSet,
                    InstanceInteractionState.Disabled => ColorPrefs.Instance.PRI_INT_Disabled,
                    _                                 => ColorPrefs.Instance.PRI_INT_Enabled
                };

                var rendColor = rend switch
                {
                    InstanceRenderingState.NotSet        => ColorPrefs.Instance.PRI_REND_NotSet,
                    InstanceRenderingState.Disabled      => ColorPrefs.Instance.PRI_REND_Disabled,
                    InstanceRenderingState.MeshRenderers => ColorPrefs.Instance.PRI_REND_Mesh,
                    _                                    => ColorPrefs.Instance.PRI_REND_GPU
                };

                var iscColor = isc switch
                {
                    InstanceStateCode.NotSet                       => ColorPrefs.Instance.PRIIC_NotSet,
                    InstanceStateCode.OutsideOfMaximumChangeRadius => ColorPrefs.Instance.PRIIC_OutsideOfMaximumChangeRadius,
                    InstanceStateCode.Delayed                      => ColorPrefs.Instance.PRIIC_Delayed,
                    InstanceStateCode.ForceDisabled                => ColorPrefs.Instance.PRIIC_ForceDisabled,
                    _ => ColorPrefs.Instance.PRIIC_Normal
                };

                var sz = s.magnitude * _radius;

                sz = math.clamp(sz, .05f, gizmoRadius.v);

                var lastPoint = ltw.MultiplyPoint3x4(Vector3.up * (_increment * _points.Length));
                SmartHandles.DrawHandleLine(
                    _points[0],
                    _points[1],
                    HandleCapType.Sphere,
                    Vector3.up,
                    Vector3.forward,
                    sz,
                    physxColor.v
                );
                SmartHandles.DrawHandleLine(
                    _points[1],
                    _points[2],
                    HandleCapType.Sphere,
                    Vector3.up,
                    Vector3.forward,
                    sz,
                    interColor.v
                );
                SmartHandles.DrawHandleLine(
                    _points[2],
                    _points[3],
                    HandleCapType.Sphere,
                    Vector3.up,
                    Vector3.forward,
                    sz,
                    rendColor.v
                );
                SmartHandles.DrawHandleLine(
                    _points[3],
                    lastPoint,
                    HandleCapType.Sphere,
                    Vector3.up,
                    Vector3.forward,
                    sz,
                    iscColor.v
                );

                if (drawHandleLabels.v)
                {
                    var offsetDirection = _cameraPosition - p;
                    var labelOffset = offsetDirection * 0.2f;
                    labelOffset.y -= .2f;

                    Handles.Label(_points[1] + labelOffset, $"Physx: {physx}");
                    Handles.Label(_points[2] + labelOffset, $"Inter: {inter}");
                    Handles.Label(_points[3] + labelOffset, $"Rendr: {rend}");
                    Handles.Label(lastPoint + labelOffset,  $"State: {isc}");
                }
            }
        }
#endif
    }
}
