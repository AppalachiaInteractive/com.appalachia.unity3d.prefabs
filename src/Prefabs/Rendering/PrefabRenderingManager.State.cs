#region

using System;
using Appalachia.Core.Attributes.Editing;
using Appalachia.Core.Preferences.Globals;
using Appalachia.Rendering.Prefabs.Core.Collections;
using Appalachia.Rendering.Prefabs.Core.States;
using Appalachia.Rendering.Prefabs.Rendering.ModelType;
using Appalachia.Utility.Execution;
using Appalachia.Utility.Extensions;
using Appalachia.Utility.Timing;
using GPUInstancer;
using Sirenix.OdinInspector;
using Unity.Mathematics;
using Unity.Profiling;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering
{
    public partial class PrefabRenderingManager
    {
        #region Static Fields and Autoproperties

        private static RenderingStateReasonCodeLookup _reasonCodes = new();

        #endregion

        #region Fields and Autoproperties

        [HideInInspector] public bool hideButtons;

        [HideInInspector] public bool hideHeader;
        [HideInInspector] public bool hideTabs;

        [HideInInspector] public RenderingState currentState;

        [HideIf(nameof(hideHeader))]
        [PropertyOrder(-100)]
        [SmartLabel(Text = "State")]
        [SmartTitleGroup(
            "$" + nameof(_title),
            "$" + nameof(_title),
            "$" + nameof(_stateReason),
            titleColor: nameof(_stateColor)
        )]

        //[HorizontalGroup("$"+nameof(_title)+"/A", .7f)]
        [NonSerialized]
        [ShowInInspector]
        [EnableIf(nameof(_canChangeState))]
        [SmartInlineButton(
            nameof(FixState),
            bold: false,
            color: nameof(_fixColor),
            DisableIf = nameof(_disableFix)
        )]
        [SmartInlineButton(
            nameof(UnsoloAll),
            bold: false,
            color: nameof(_unsoloAllColor),
            DisableIf = nameof(_disableUnsoloAll)
        )]
        [SmartInlineButton(
            nameof(UnmuteAll),
            bold: false,
            color: nameof(_unmuteAllColor),
            DisableIf = nameof(_disableUnmuteAll)
        )]
        [SmartInlineButton(
            nameof(Stop),
            bold: false,
            color: nameof(_stopColor),
            DisableIf = nameof(_disableStop)
        )]
        [SmartInlineButton(
            nameof(Start),
            bold: false,
            color: nameof(_startColor),
            DisableIf = nameof(_disableStart)
        )]
        [SmartTitle(
            "$" + nameof(_cycleTitle),
            "$" + nameof(_cycleSubtitle),
            titleColor: nameof(_cycleColor),
            below: true
        )]
        public RenderingState nextState;

        [HideIf(nameof(hideHeader))]
        [PropertyOrder(-99)]
        [HorizontalGroup("Z", .49f)]
        [SmartLabel]
        [ReadOnly]
        [GUIColor(nameof(_updateCodeColors))]
        public RenderLoopBreakCode lateUpdateBreak;

        [HideIf(nameof(hideHeader))]
        [PropertyOrder(-99)]
        [HorizontalGroup("Z", .49f)]
        [SmartLabel]
        [ReadOnly]
        [GUIColor(nameof(_updateCodeColors))]
        public RenderLoopBreakCode updateBreak;

        private readonly int _frameCacheLength = 15;
        private bool _simulationCache;

        /*private UnityObjectTracker _renderingSetsTracker;
        private UnityObjectTracker _distanceReferenceTracker;
        private UnityObjectTracker _gpuiTracker;*/
        //private int _trackingCache = 1500;

        private int _editorCheckFrame;

        private RenderingStateReasonCode _stateReasonCode;

        #endregion

        private bool _canChangeState => string.IsNullOrEmpty(_stateReason);

        private bool _canFix => _stateReasonCode != RenderingStateReasonCode.NONE;
        private bool _disableFix => !_canFix;
        private bool _disableStart => currentState == RenderingState.Rendering;
        private bool _disableStop => currentState != RenderingState.Rendering;
        private bool _disableUnmuteAll => !_enableUnmuteAll;
        private bool _disableUnsoloAll => !_enableUnsoloAll;
        private bool _enableUnmuteAll => _showTypeMuteBox || _showSetMuteBox;
        private bool _enableUnsoloAll => _showTypeSoloBox || _showSetSoloBox;
        private bool _showSetMuteBox => PrefabRenderingSet.AnyMute;
        private bool _showSetSoloBox => PrefabRenderingSet.AnySolo;
        private bool _showTypeMuteBox => PrefabModelTypeOptions.AnyMute;

        private bool _showTypeSoloBox => PrefabModelTypeOptions.AnySolo;

        private bool IsEditorSimulating
        {
            get
            {
                using (_PRF_IsEditorSimulating.Auto())
                {
#if UNITY_EDITOR
                    var frame = CoreClock.Instance.FrameCount;
                    try
                    {
                        if (CoreClock.Instance.FrameCount < (_editorCheckFrame + _frameCacheLength))
                        {
                            return _simulationCache;
                        }

                        if (!AppalachiaApplication.IsPlayingOrWillPlay && gpui.gpuiSimulator.simulateAtEditor)
                        {
                            _simulationCache = true;
                            _editorCheckFrame = frame;
                        }
                    }
                    catch (NullReferenceException)
                    {
                        _simulationCache = false;
                        _editorCheckFrame = frame;
                    }

                    return _simulationCache;
#else
                    return false;
#endif
                }
            }
        }

        private Color _cycleColor =>
            ColorPrefs.Instance.Quality_BadToGood.v.Evaluate(1.0f - (float)_cycleQuality01);

        private Color _fixColor => _canFix ? ColorPrefs.Instance.Enabled.v : ColorPrefs.Instance.Disabled.v;

        private Color _startColor =>
            currentState != RenderingState.Rendering
                ? ColorPrefs.Instance.Enabled.v
                : ColorPrefs.Instance.EnabledSubdued.v;

        private Color _stateColor =>
            currentState == RenderingState.Rendering
                ? ColorPrefs.Instance.Enabled.v
                : ColorPrefs.Instance.DisabledImportant.v;

        private Color _stopColor =>
            currentState == RenderingState.Rendering
                ? ColorPrefs.Instance.DisabledImportant.v
                : ColorPrefs.Instance.DisabledImportantDisabled.v;

        private Color _unmuteAllColor =>
            _enableUnmuteAll ? ColorPrefs.Instance.MuteEnabled.v : ColorPrefs.Instance.MuteDisabled.v;

        private Color _unsoloAllColor =>
            _enableUnsoloAll ? ColorPrefs.Instance.SoloEnabled.v : ColorPrefs.Instance.SoloDisabled.v;

        private Color _updateCodeColors => ColorPrefs.Instance.BackgroundInfo.v;

        private double _cycleQuality01
        {
            get
            {
                if (_cycleManager == null)
                {
                    return 0;
                }

                if (!_cycleManager.AnyActive)
                {
                    return 0;
                }

                if (_cycleManager.ActiveCount == 1)
                {
                    return 0;
                }

                var exeo = RenderingOptions.execution;
                var time = _cycleManager?.TimeTracker;

                if (time == null)
                {
                    return 0;
                }

                var t = time.Average / exeo.idealCycleTimeMilliseconds;

                return math.clamp(t, 0.0, 1.0);
            }
        }

        private string _cycleSubtitle => _cycleManager?.TimingsString() ?? string.Empty;
        private string _cycleTitle => _cycleManager?.CountsString() ?? string.Empty;

        private string _startText => "Start";

        private string _stateReason
        {
            get
            {
                if (_reasonCodes == null)
                {
                    _reasonCodes = new RenderingStateReasonCodeLookup();
                }

                _reasonCodes.Changed.Event +=(MarkAsModified);

                if (_reasonCodes.Count == 0)
                {
                    _reasonCodes.InitializeLookup();
                }

                return _reasonCodes[_stateReasonCode];
            }
        }

        private string _stopText => "Stop";

        private string _title => currentState.ToString().SeperateWords();

        private void ChangeRuntimeRenderingState(bool enable)
        {
            using (_PRF_ChangeRuntimeRenderingState.Auto())
            {
                if (enable)
                {
                    Context.Log.Info("Attempting to start runtime rendering.", this);

                    _updateLoopCount = 0;
                    _updateLoopStopped = false;

                    try
                    {
                        if (!gpui.gameObject.activeSelf)
                        {
                            gpui.gameObject.SetActive(true);
                        }

                        if (!gpui.enabled)
                        {
                            gpui.enabled = true;
                        }

                        Bounce();
                    }
                    catch (Exception ex)
                    {
                        Context.Log.Error(ex, this);
                    }
                }
                else
                {
                    Context.Log.Info("Attempting to end runtime rendering.", this);

                    gpui.enabled = false;
                }
            }
        }

        private void ConfirmExecutionState()
        {
            using (_PRF_ConfirmExecutionState.Auto())
            {
                //CheckStateCache();

                _stateReasonCode = RenderingStateReasonCode.NONE;

                if (_renderingSets == null)
                {
                    if (currentState != RenderingState.NotRendering)
                    {
                        nextState = RenderingState.NotRendering;
                    }

                    _stateReasonCode = RenderingStateReasonCode.PREFAB_RENDER_SET_NULL;
                    return;
                }

                if (renderingSets.Sets.Count == 0)
                {
                    if (currentState != RenderingState.NotRendering)
                    {
                        nextState = RenderingState.NotRendering;
                    }

                    _stateReasonCode = RenderingStateReasonCode.PREFAB_RENDER_SET_EMPTY;
                    return;
                }

                if (distanceReferencePoint == null)
                {
                    if (currentState != RenderingState.NotRendering)
                    {
                        nextState = RenderingState.NotRendering;
                    }

                    _stateReasonCode = RenderingStateReasonCode.DISTANCE_REFERENCE_NULL;
                    return;
                }

                if (gpui == null)
                {
                    if (currentState != RenderingState.NotRendering)
                    {
                        nextState = RenderingState.NotRendering;
                    }

                    _stateReasonCode = RenderingStateReasonCode.GPUI_PREFAB_MANAGER_NULL;
                    return;
                }

#if UNITY_EDITOR
                if (gpui.gpuiSimulator == null)
                {
                    if (currentState != RenderingState.NotRendering)
                    {
                        nextState = RenderingState.NotRendering;
                    }

                    _stateReasonCode = RenderingStateReasonCode.GPUI_SIMULATOR_NULL;
                    return;
                }
#endif

                if (currentState == RenderingState.BounceState)
                {
                    if (AppalachiaApplication.IsPlayingOrWillPlay || IsEditorSimulating)
                    {
                        currentState = RenderingState.Rendering;
                    }
                    else
                    {
                        currentState = RenderingState.NotRendering;
                    }
                }

                if (currentState == RenderingState.UnchangedState)
                {
                    currentState = RenderingState.NotRendering;
                    _stateReasonCode = RenderingStateReasonCode.STATE_INVALID;
                    return;
                }

                if (!enabled)
                {
                    if (currentState != RenderingState.NotRendering)
                    {
                        nextState = RenderingState.NotRendering;
                    }

                    _stateReasonCode = RenderingStateReasonCode.NOT_ENABLED;
                    return;
                }

                if (!gameObject.activeSelf)
                {
                    if (currentState != RenderingState.NotRendering)
                    {
                        nextState = RenderingState.NotRendering;
                    }

                    _stateReasonCode = RenderingStateReasonCode.NOT_ACTIVE_SELF;
                    return;
                }

                if (!gameObject.activeInHierarchy)
                {
                    if (currentState != RenderingState.NotRendering)
                    {
                        nextState = RenderingState.NotRendering;
                    }

                    _stateReasonCode = RenderingStateReasonCode.NOT_ACTIVE_HIERARCHY;
                    return;
                }

#if UNITY_EDITOR
                if (!AppalachiaApplication.IsPlayingOrWillPlay &&
                    (currentState == RenderingState.Rendering) &&
                    !IsEditorSimulating)
                {
                    nextState = RenderingState.NotRendering;
                    _stateReasonCode = RenderingStateReasonCode.NOT_SIMULATING;
                    return;
                }
#endif

                if (!RenderingOptions.execution.allowUpdates)
                {
                    if (currentState != RenderingState.NotRendering)
                    {
                        nextState = RenderingState.NotRendering;
                    }
                    else
                    {
                        nextState = RenderingState.UnchangedState;
                    }

                    _stateReasonCode = stoppedDueToErrors
                        ? RenderingStateReasonCode.PREVENT_ERROR
                        : RenderingStateReasonCode.PREVENT_OPTIONS;
                    return;
                }

                if (nextState == currentState)
                {
                    nextState = RenderingState.UnchangedState;
                }
            }
        }

        private void ExecuteNecessaryStateChanges()
        {
            using (_PRF_ExecuteNecessaryStateChanges.Auto())
            {
                ConfirmExecutionState();

                /*
                if (nextState != currentState)
                {
                    _distanceReferenceTracker.Refresh();
                    _renderingSetsTracker.Refresh();
                    _gpuiTracker.Refresh();
                }
                */

                switch (currentState)
                {
                    case RenderingState.NotRendering:
                    {
                        switch (nextState)
                        {
                            case RenderingState.Rendering:
                            {
                                if (AppalachiaApplication.IsPlayingOrWillPlay)
                                {
                                    ChangeRuntimeRenderingState(true);
                                }
#if UNITY_EDITOR
                                else
                                {
                                    ChangeEditorSimulationState(true);
                                }
#endif

                                currentState = RenderingState.Rendering;
                                break;
                            }
                            case RenderingState.BounceState:
                            {
                                Bounce();
                                nextState = RenderingState.UnchangedState;
                                break;
                            }
                            case RenderingState.NotRendering:
                            case RenderingState.UnchangedState:
                                break;
                            default:
                                throw new ArgumentOutOfRangeException();
                        }

                        break;
                    }
                    case RenderingState.Rendering:
                    {
                        switch (nextState)
                        {
                            case RenderingState.NotRendering:
                            {
                                if (AppalachiaApplication.IsPlayingOrWillPlay)
                                {
                                    ChangeRuntimeRenderingState(false);
                                }
#if UNITY_EDITOR
                                else
                                {
                                    ChangeEditorSimulationState(false);
                                }

                                SetSceneDirty();
#endif
                                currentState = RenderingState.NotRendering;
                                break;
                            }
                            case RenderingState.BounceState:
                            {
                                Bounce();
                                nextState = RenderingState.UnchangedState;
                                break;
                            }
                            case RenderingState.Rendering:
                            case RenderingState.UnchangedState:
                                break;
                            default:
                                throw new ArgumentOutOfRangeException();
                        }

                        break;
                    }
                    default:
                        throw new ArgumentOutOfRangeException();
                }

                nextState = RenderingState.UnchangedState;
            }
        }

        private void FixState()
        {
            switch (_stateReasonCode)
            {
                case RenderingStateReasonCode.NONE:
                    break;
                case RenderingStateReasonCode.PREFAB_RENDER_SET_NULL:
                    renderingSets = _prefabRenderingSetCollection;
#if UNITY_EDITOR
                    renderingSets.MarkAsModified();
#endif
                    break;
                case RenderingStateReasonCode.PREFAB_RENDER_SET_EMPTY:
                    PrefabRenderingManagerInitializer.InitializeAllPrefabRenderingSets();
                    break;
                case RenderingStateReasonCode.DISTANCE_REFERENCE_NULL:
                case RenderingStateReasonCode.GPUI_PREFAB_MANAGER_NULL:
#if UNITY_EDITOR
                case RenderingStateReasonCode.GPUI_SIMULATOR_NULL:
#endif
                    PrefabRenderingManagerInitializer.CheckNulls();
                    break;
                case RenderingStateReasonCode.STATE_INVALID:
                    nextState = RenderingState.Rendering;
                    break;
                case RenderingStateReasonCode.NOT_ENABLED:
                    enabled = true;
                    break;
                case RenderingStateReasonCode.NOT_ACTIVE_SELF:
                case RenderingStateReasonCode.NOT_ACTIVE_HIERARCHY:
                    gameObject.SetActive(true);
                    break;
#if UNITY_EDITOR
                case RenderingStateReasonCode.NOT_SIMULATING:
                    ChangeEditorSimulationState(true);
                    break;
#endif
                case RenderingStateReasonCode.PREVENT_OPTIONS:
                case RenderingStateReasonCode.PREVENT_ERROR:
                    renderingOptions.execution.allowUpdates = true;
                    break;
                default:
                    throw new ArgumentOutOfRangeException();
            }

#if UNITY_EDITOR
            renderingOptions.MarkAsModified();
#endif
            nextState = RenderingState.Rendering;
        }

        private void Stop()
        {
            nextState = RenderingState.NotRendering;
        }

        private void UnmuteAll()
        {
            for (var i = 0; i < AssetModelTypeLookup.State.Count; i++)
            {
                var state = AssetModelTypeLookup.State.at[i];
                state.Mute(false);
#if UNITY_EDITOR
                state.MarkAsModified();
#endif
            }

            for (var i = 0; i < renderingSets.Sets.Count; i++)
            {
                var set = renderingSets.Sets.at[i];
                set.Muted = false;
#if UNITY_EDITOR
                set.MarkAsModified();
#endif
            }

            PrefabRenderingSet.AnyMute = false;
            PrefabModelTypeOptions.AnyMute = false;

#if UNITY_EDITOR
            renderingSets.MarkAsModified();
            AssetModelTypeLookup.MarkAsModified();
#endif
        }

        private void UnsoloAll()
        {
            for (var i = 0; i < AssetModelTypeLookup.State.Count; i++)
            {
                var state = AssetModelTypeLookup.State.at[i];
                state.Solo(false);
#if UNITY_EDITOR
                state.MarkAsModified();
#endif
            }

            for (var i = 0; i < renderingSets.Sets.Count; i++)
            {
                var set = renderingSets.Sets.at[i];
                set.Soloed = false;
#if UNITY_EDITOR
                set.MarkAsModified();
#endif
            }

            PrefabRenderingSet.AnySolo = false;
            PrefabModelTypeOptions.AnySolo = false;

#if UNITY_EDITOR
            renderingSets.MarkAsModified();
            AssetModelTypeLookup.MarkAsModified();
#endif
        }

        #region Profiling

        private static readonly ProfilerMarker _PRF_IsEditorSimulating =
            new(_PRF_PFX + nameof(IsEditorSimulating));

        private static readonly ProfilerMarker _PRF_ConfirmExecutionState =
            new(_PRF_PFX + nameof(ConfirmExecutionState));

        private static readonly ProfilerMarker _PRF_ExecuteNecessaryStateChanges =
            new(_PRF_PFX + nameof(ExecuteNecessaryStateChanges));

        private static readonly ProfilerMarker _PRF_ChangeRuntimeRenderingState =
            new(_PRF_PFX + nameof(ChangeRuntimeRenderingState));

        #endregion

#if UNITY_EDITOR
        private static readonly ProfilerMarker _PRF_ChangeEditorSimulationState =
            new(_PRF_PFX + nameof(ChangeEditorSimulationState));

        private void ChangeEditorSimulationState(bool enable)
        {
            using (_PRF_ChangeEditorSimulationState.Auto())
            {
                if (enable)
                {
                    Context.Log.Info("Attempting to start GPUI simulation.", this);

                    _updateLoopCount = 0;
                    _updateLoopStopped = false;

                    try
                    {
                        if (!gpui.gameObject.activeSelf)
                        {
                            gpui.gameObject.SetActive(true);
                        }

                        if (!gpui.enabled)
                        {
                            gpui.enabled = true;
                        }

                        Bounce();

                        GPUInstancerAPI.StartEditorSimulation(gpui);
                    }
                    catch (Exception ex)
                    {
                        Context.Log.Error("Failed to start simulation", this);
                        Context.Log.Error(ex,                           this);
                    }
                }
                else
                {
                    Context.Log.Info("Attempting to end GPUI simulation.", this);

                    GPUInstancerAPI.StopEditorSimulation(gpui);
                }
            }
        }
#endif

#if UNITY_EDITOR

        private bool _queueToggleSimulation;

        [UnityEditor.MenuItem(
            PKG.Menu.Appalachia.Tools.Enable.Base,
            true,
            priority = PKG.Menu.Appalachia.Tools.Enable.Priority
        )]
        private static bool _M_ENABLE_VALIDATE()
        {
            UnityEditor.Menu.SetChecked(PKG.Menu.Appalachia.Tools.Enable.Base, instance.enabled);
            return true;
        }

        [UnityEditor.MenuItem(
            PKG.Menu.Appalachia.Tools.Enable.Base,
            priority = PKG.Menu.Appalachia.Tools.Enable.Priority
        )]
        private static void _M_ENABLE()
        {
            instance.enabled = !instance.enabled;
        }

        [UnityEditor.MenuItem(
            PKG.Menu.Appalachia.Tools.RuntimeRendering.Base,
            true,
            priority = PKG.Menu.Appalachia.Tools.RuntimeRendering.Priority
        )]
        private static bool _M_RUNTIME_VALIDATE()
        {
            UnityEditor.Menu.SetChecked(
                PKG.Menu.Appalachia.Tools.RuntimeRendering.Base,
                instance.currentState == RenderingState.Rendering
            );
            return instance.enabled;
        }

        [UnityEditor.MenuItem(
            PKG.Menu.Appalachia.Tools.RuntimeRendering.Base,
            priority = PKG.Menu.Appalachia.Tools.RuntimeRendering.Priority
        )]
        public static void _M_RUNTIME()
        {
            instance.nextState = instance.currentState == RenderingState.Rendering
                ? RenderingState.NotRendering
                : RenderingState.Rendering;
        }

        [UnityEditor.MenuItem(
            PKG.Menu.Appalachia.Tools.Simulate.Base,
            true,
            priority = PKG.Menu.Appalachia.Tools.Simulate.Priority
        )]
        private static bool _M_SIMULATE_VALIDATE()
        {
            UnityEditor.Menu.SetChecked(PKG.Menu.Appalachia.Tools.Simulate.Base, instance.IsEditorSimulating);
            return instance.enabled;
        }

        [UnityEditor.MenuItem(
            PKG.Menu.Appalachia.Tools.Simulate.Base,
            priority = PKG.Menu.Appalachia.Tools.Simulate.Priority
        )]
        public static void _M_SIMULATE()
        {
            instance.nextState = instance.IsEditorSimulating
                ? RenderingState.NotRendering
                : RenderingState.Rendering;
        }

        [UnityEditor.MenuItem(
            PKG.Menu.Appalachia.Tools.AllowUpdates.Base,
            true,
            priority = PKG.Menu.Appalachia.Tools.AllowUpdates.Priority
        )]
        private static bool _M_UPDATES_VALIDATE()
        {
            UnityEditor.Menu.SetChecked(
                PKG.Menu.Appalachia.Tools.AllowUpdates.Base,
                instance.RenderingOptions.execution.allowUpdates
            );
            return instance.enabled;
        }

        [UnityEditor.MenuItem(
            PKG.Menu.Appalachia.Tools.AllowUpdates.Base,
            priority = PKG.Menu.Appalachia.Tools.AllowUpdates.Priority
        )]
        public static void _M_UPDATES()
        {
            instance.RenderingOptions.execution.allowUpdates =
                !instance.RenderingOptions.execution.allowUpdates;
        }

        [UnityEditor.MenuItem(
            PKG.Menu.Appalachia.Tools.Bounce.Base,
            true,
            priority = PKG.Menu.Appalachia.Tools.Bounce.Priority
        )]
        private static bool _M_BOUNCE_VALIDATE()
        {
            return instance.enabled && (instance.nextState != RenderingState.BounceState);
        }

        [UnityEditor.MenuItem(
            PKG.Menu.Appalachia.Tools.Bounce.Base,
            priority = PKG.Menu.Appalachia.Tools.Bounce.Priority
        )]
        private static void _M_BOUNCE()
        {
            instance.nextState = RenderingState.BounceState;
        }

        private static readonly ProfilerMarker _PRF_ReBuryMeshes = new(_PRF_PFX + nameof(ReBuryMeshes));

        [HideIf(nameof(hideButtons))]
        [Button]
        [ButtonGroup("Bottom")]
        [EnableIf(nameof(IsEditorSimulating))]
        private void ReBuryMeshes()
        {
            using (_PRF_ReBuryMeshes.Auto())
            {
                //MeshBurialManagementProcessor.RefreshPrefabRenderingSets();
            }
        }

        [HideIf(nameof(hideButtons))]
        private static readonly ProfilerMarker _PRF_RunOnce = new(_PRF_PFX + nameof(RunOnce));

        [Button]
        [ButtonGroup("Bottom")]
        [EnableIf(nameof(enabled))]
        private void RunOnce()
        {
            using (_PRF_RunOnce.Auto())
            {
                Update();
                LateUpdate();
            }
        }
#endif
    }
}
