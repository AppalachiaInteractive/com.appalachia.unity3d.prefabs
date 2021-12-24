#if UNITY_EDITOR

#region

using System;
using System.Collections.Generic;
using Appalachia.Core.Objects.Root;
using Appalachia.Core.Preferences;
using Appalachia.Editing.Debugging.Handle;
using Appalachia.Utility.Colors;
using Appalachia.Utility.Extensions;
using Unity.Mathematics;
using Unity.Profiling;
using UnityEngine;
using UnityEngine.InputSystem;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering
{
    public class GameViewSelectionManager : AppalachiaSimpleBase
    {
        #region Profiling And Tracing Markers

        private const string _PRF_PFX = nameof(GameViewSelectionManager) + ".";

        private static readonly ProfilerMarker _PRF_TryGameViewSelection =
            new(_PRF_PFX + nameof(TryGameViewSelection));

        private static readonly ProfilerMarker _PRF_TrySelect = new(_PRF_PFX + nameof(TrySelect));
        private static readonly ProfilerMarker _PRF_Initialize = new(_PRF_PFX + nameof(Initialize));

        #endregion

        public GameViewSelectionManager(int hitDepth = 16, int minFrameInterval = 10)
        {
            _hitDepth = hitDepth;
            _minFrameInterval = minFrameInterval;
            _lastHitIndex = -1;
        }

        #region Preferences

        private static PREF<Color> gizmoColor;

        private static PREF<float> rayDuration;
        private static PREF<float> rayIndexResetDistance;

        #endregion

        private readonly int _hitDepth;
        private readonly int _minFrameInterval;

        [NonSerialized] private Dictionary<Camera, int> _cameraFrames;
        [NonSerialized] private float _lastRayAge;
        [NonSerialized] private int _debugStep;
        [NonSerialized] private int _lastHitIndex;
        [NonSerialized] private Ray _lastRay;

        [NonSerialized] private RaycastHit[] _rayHits;
        [NonSerialized] private Vector2 _lastMouseClickPosition = Vector2.zero;

        [NonSerialized] private Vector2 _mouseClickPosition = Vector2.zero;

        public bool TryGameViewSelection(
            Camera camera,
            int layerMask,
            out Collider c,
            float maxDistance = 64f,
            QueryTriggerInteraction queryTriggerInteraction = QueryTriggerInteraction.Ignore)
        {
            using (_PRF_TryGameViewSelection.Auto())
            {
                Initialize();
                DrawRayGizmo();

                if (!ShouldExecute(camera))
                {
                    c = null;
                    return false;
                }

                return TrySelect(camera, null, false, layerMask, maxDistance, queryTriggerInteraction, out c);
            }
        }

        public bool TryGameViewSelection(
            Camera camera,
            IEnumerable<Collider> explicitColliders,
            out Collider c,
            float maxDistance = 64f,
            QueryTriggerInteraction queryTriggerInteraction = QueryTriggerInteraction.Ignore)
        {
            using (_PRF_TryGameViewSelection.Auto())
            {
                Initialize();
                DrawRayGizmo();

                if (!ShouldExecute(camera))
                {
                    c = null;
                    return false;
                }

                return TrySelect(
                    camera,
                    explicitColliders,
                    true,
                    0,
                    maxDistance,
                    queryTriggerInteraction,
                    out c
                );
            }
        }

        private void DrawRayGizmo()
        {
            _lastRayAge += Time.deltaTime;

            var rayTime = 1.0f - math.clamp(_lastRayAge / rayDuration.v, 0f, 1f);
            var rayColor = gizmoColor.v;
            rayColor.a *= rayTime;

            SmartHandles.DrawRay(_lastRay, rayColor);
        }

        private void Initialize()
        {
            using (_PRF_Initialize.Auto())
            {
                if ((_rayHits == null) || (_rayHits.Length != _hitDepth))
                {
                    _rayHits = new RaycastHit[_hitDepth];
                }

                if (gizmoColor == null)
                {
                    gizmoColor = PREFS.REG(PKG.Prefs.Gizmos.GameView, nameof(gizmoColor), Colors.Cyan);
                }

                if (rayDuration == null)
                {
                    rayDuration = PREFS.REG(PKG.Prefs.Gizmos.GameView, nameof(rayDuration), 2f, .1f, 10f);
                }

                if (rayIndexResetDistance == null)
                {
                    rayIndexResetDistance = PREFS.REG(
                        PKG.Prefs.Gizmos.GameView,
                        nameof(rayIndexResetDistance),
                        25f,
                        5f,
                        250f
                    );
                }
            }
        }

        private bool ShouldExecute(Camera c)
        {
            var frame = Time.frameCount;

            if (_cameraFrames == null)
            {
                _cameraFrames = new Dictionary<Camera, int>();
            }

            if (!_cameraFrames.ContainsKey(c))
            {
                _cameraFrames.Add(c, 0);
            }

            var lastFrame = _cameraFrames[c];

            return (lastFrame + _minFrameInterval) <= frame;
        }

        private bool TrySelect(
            Camera camera,
            IEnumerable<Collider> explicitColliders,
            bool useExplicitColliders,
            int layerMask,
            float maxDistance,
            QueryTriggerInteraction queryTriggerInteraction,
            out Collider c)
        {
            using (_PRF_TrySelect.Auto())
            {
                var mouseDown = Mouse.current.leftButton.isPressed;
                var focusedWindow = UnityEditor.EditorWindow.focusedWindow;

                if (focusedWindow != null)
                {
                    var fwType = focusedWindow.GetType();

                    if (!fwType.Name.Contains("Game"))
                    {
                        c = null;
                        return false;
                    }
                }

                if (mouseDown)
                {
                    _lastMouseClickPosition = _mouseClickPosition;
                    _mouseClickPosition = Mouse.current.position.ReadValue();

                    var x = _mouseClickPosition.x;
                    var y = _mouseClickPosition.y;

                    if ((x < 0) || (y < 0) || (x > camera.pixelWidth) || (y > camera.pixelHeight))
                    {
                        c = null;
                        return false;
                    }

                    var diff = math.distance(_lastMouseClickPosition, _mouseClickPosition);

                    if (diff > rayIndexResetDistance.v)
                    {
                        _lastHitIndex = -1;
                    }

                    _cameraFrames.AddOrUpdate(camera, Time.frameCount);

                    _lastRay = camera.ScreenPointToRay(_mouseClickPosition);
                    _lastRayAge = 0f;

                    var hitCount = 0;

                    if (useExplicitColliders)
                    {
                        foreach (var collider in explicitColliders)
                        {
                            if (hitCount >= _hitDepth)
                            {
                                break;
                            }

                            if ((collider != null) && collider.Raycast(_lastRay, out var hit, maxDistance))
                            {
                                _rayHits[hitCount] = hit;
                                hitCount += 1;
                            }
                        }
                    }
                    else
                    {
                        hitCount = Physics.RaycastNonAlloc(
                            _lastRay,
                            _rayHits,
                            maxDistance,
                            layerMask,
                            queryTriggerInteraction
                        );
                    }

                    if (hitCount == 0)
                    {
                        c = null;
                        return false;
                    }

                    if (hitCount == 1)
                    {
                        c = _rayHits[0].collider;
                        return true;
                    }

                    _lastHitIndex += 1;

                    if (_lastHitIndex >= hitCount)
                    {
                        _lastHitIndex = 0;
                    }

                    c = _rayHits[_lastHitIndex].collider;
                    return true;
                }
            }

            c = null;
            return false;
        }
    }
}

#endif