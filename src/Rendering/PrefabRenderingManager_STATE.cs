#region

using System;
using Appalachia.Core.AssetMetadata.Options.ModelType;
using Appalachia.Core.Constants;
using Appalachia.Core.Editing.Attributes;
using Appalachia.Core.Editing.Coloring;
using Appalachia.Core.Extensions;
using Appalachia.Core.Helpers;
using Appalachia.Core.Rendering.Metadata;
using Appalachia.Core.Rendering.States;
using Appalachia.Spatial.MeshBurial.Processing;
using Appalachia.Utility.Constants;
using GPUInstancer;
using Sirenix.OdinInspector;
using Unity.Mathematics;
using Unity.Profiling;
using UnityEditor;
using UnityEngine;

#endregion

namespace Appalachia.Core.Rendering
{
    public partial class PrefabRenderingManager
    {
        [HideInInspector]public bool hideHeader;
        [HideInInspector]public bool hideTabs;
        [HideInInspector]public bool hideButtons;
        
        private static RenderingStateReasonCodeLookup _reasonCodes = new RenderingStateReasonCodeLookup();


        [HideInInspector] public RenderingState currentState;

        [HideIf(nameof(hideHeader))]
        [PropertyOrder(-100)]
        [SmartLabel(Text = "State")]
        [SmartTitleGroup("$" + nameof(_title), "$" + nameof(_stateReason), TitleAlignments.Split, color: nameof(_stateColor))]
        //[HorizontalGroup("$"+nameof(_title)+"/A", .7f)]
        [NonSerialized, ShowInInspector, EnableIf(nameof(_canChangeState))]
        [SmartInlineButton(nameof(FixState),  bold: false, color: nameof(_fixColor), DisableIf = nameof(_disableFix))]
        [SmartInlineButton(nameof(UnsoloAll), bold: false, color: nameof(_unsoloAllColor), DisableIf = nameof(_disableUnsoloAll))]
        [SmartInlineButton(nameof(UnmuteAll), bold: false, color: nameof(_unmuteAllColor), DisableIf = nameof(_disableUnmuteAll))]
        [SmartInlineButton(nameof(Stop),      bold: false, color: nameof(_stopColor), DisableIf = nameof(_disableStop))]
        [SmartInlineButton(nameof(Start),     bold: false, color: nameof(_startColor), DisableIf = nameof(_disableStart))]
        [SmartTitle("$" + nameof(_cycleTitle), "$" + nameof(_cycleSubtitle), TitleAlignments.Split, color: nameof(_cycleColor), below: true)]
        public RenderingState nextState;

        private RenderingStateReasonCode _stateReasonCode;

        private Color _updateCodeColors => ColorPrefs.Instance.BackgroundInfo.v;
        
        [HideIf(nameof(hideHeader))]
        [PropertyOrder(-99)]
        [HorizontalGroup("Z", .49f), SmartLabel, ReadOnly, GUIColor(nameof(_updateCodeColors))]
        public RenderLoopBreakCode updateBreak;

        [HideIf(nameof(hideHeader))]
        [PropertyOrder(-99)]
        [HorizontalGroup("Z", .49f), SmartLabel, ReadOnly, GUIColor(nameof(_updateCodeColors))]
        public RenderLoopBreakCode lateUpdateBreak;

        /*private UnityObjectTracker _renderingSetsTracker;
        private UnityObjectTracker _distanceReferenceTracker;
        private UnityObjectTracker _gpuiTracker;*/
        //private int _trackingCache = 1500;

        private int _editorCheckFrame;
        private int _frameCacheLength = 15;
        private bool _simulationCache;
        private Color _stateColor => currentState == RenderingState.Rendering ? ColorPrefs.Instance.Enabled.v : ColorPrefs.Instance.DisabledImportant.v;

        private string _title => currentState.ToString().SeperateWords();

        private string _stateReason
        {
            get
            {
                if (_reasonCodes == null)
                {
                    _reasonCodes = new RenderingStateReasonCodeLookup();
                }

                if (_reasonCodes.Count == 0)
                {
                    _reasonCodes.InitializeLookup();
                }

                return _reasonCodes[_stateReasonCode];
            }
        }

        private bool _canChangeState => string.IsNullOrEmpty(_stateReason);
        private string _cycleTitle => _cycleManager?.CountsString() ?? string.Empty;
        private string _cycleSubtitle => _cycleManager?.TimingsString() ?? string.Empty;

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

        private string _startText => "Start";
        private string _stopText => "Stop";
        private Color _startColor => currentState != RenderingState.Rendering ? ColorPrefs.Instance.Enabled.v : ColorPrefs.Instance.EnabledSubdued.v;

        private Color _stopColor =>
            currentState == RenderingState.Rendering ? ColorPrefs.Instance.DisabledImportant.v : ColorPrefs.Instance.DisabledImportantDisabled.v;

        private Color _fixColor => _canFix ? ColorPrefs.Instance.Enabled.v : ColorPrefs.Instance.Disabled.v;
        private Color _cycleColor => ColorPrefs.Instance.Quality_BadToGood.v.Evaluate(1.0f - (float) _cycleQuality01);
        private bool _canFix => _stateReasonCode != RenderingStateReasonCode.NONE;
        private bool _disableFix => !_canFix;

        private bool _showTypeSoloBox => PrefabModelTypeOptions.AnySolo;
        private bool _showTypeMuteBox => PrefabModelTypeOptions.AnyMute;
        private bool _showSetSoloBox => PrefabRenderingSet.AnySolo;
        private bool _showSetMuteBox => PrefabRenderingSet.AnyMute;
        private bool _enableUnsoloAll => _showTypeSoloBox || _showSetSoloBox;
        private bool _enableUnmuteAll => _showTypeMuteBox || _showSetMuteBox;
        private bool _disableUnsoloAll => !_enableUnsoloAll;
        private bool _disableUnmuteAll => !_enableUnmuteAll;
        private bool _disableStop => currentState != RenderingState.Rendering;
        private bool _disableStart => currentState == RenderingState.Rendering;
        private Color _unsoloAllColor => _enableUnsoloAll ? ColorPrefs.Instance.SoloEnabled.v : ColorPrefs.Instance.SoloDisabled.v;
        private Color _unmuteAllColor => _enableUnmuteAll ? ColorPrefs.Instance.MuteEnabled.v : ColorPrefs.Instance.MuteDisabled.v;

        private static readonly ProfilerMarker _PRF_IsEditorSimulating = new ProfilerMarker(_PRF_PFX + nameof(IsEditorSimulating));
        private bool IsEditorSimulating
        {
            get
            {
                using (_PRF_IsEditorSimulating.Auto())
                {
#if UNITY_EDITOR
                    var frame = Time.frameCount;
                    try
                    {
                        if (Time.frameCount < (_editorCheckFrame + _frameCacheLength))
                        {
                            return _simulationCache;
                        }

                        if (!Application.isPlaying && gpui.gpuiSimulator.simulateAtEditor)
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

        private void FixState()
        {
            switch (_stateReasonCode)
            {
                case RenderingStateReasonCode.NONE:
                    break;
                case RenderingStateReasonCode.PREFAB_RENDER_SET_NULL:
                    renderingSets = PrefabRenderingSetCollection.instance;
                    renderingSets.SetDirty();
                    break;
                case RenderingStateReasonCode.PREFAB_RENDER_SET_EMPTY:
                    PrefabRenderingManagerInitializer.InitializeAllPrefabRenderingSets();
                    break;
                case RenderingStateReasonCode.DISTANCE_REFERENCE_NULL:
                case RenderingStateReasonCode.GPUI_PREFAB_MANAGER_NULL:
                case RenderingStateReasonCode.GPUI_SIMULATOR_NULL:
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
                case RenderingStateReasonCode.NOT_SIMULATING:
                    ChangeEditorSimulationState(true);
                    break;
                case RenderingStateReasonCode.PREVENT_OPTIONS:
                case RenderingStateReasonCode.PREVENT_ERROR:
                    renderingOptions.execution.allowUpdates = true;
                    break;
                default:
                    throw new ArgumentOutOfRangeException();
            }

            renderingOptions.SetDirty();
            nextState = RenderingState.Rendering;
        }

        private void UnsoloAll()
        {
            for (var i = 0; i < AssetModelTypeLookup.State.Count; i++)
            {
                var state = AssetModelTypeLookup.State.at[i];
                state.Solo(false);
                state.SetDirty();
            }

            for (var i = 0; i < renderingSets.Sets.Count; i++)
            {
                var set = renderingSets.Sets.at[i];
                set.Soloed = false;
                set.SetDirty();
            }

            PrefabRenderingSet.AnySolo = false;
            PrefabModelTypeOptions.AnySolo = false;

            renderingSets.SetDirty();
            AssetModelTypeLookup.SetDirty();
        }

        private void UnmuteAll()
        {
            for (var i = 0; i < AssetModelTypeLookup.State.Count; i++)
            {
                var state = AssetModelTypeLookup.State.at[i];
                state.Mute(false);
                state.SetDirty();
            }

            for (var i = 0; i < renderingSets.Sets.Count; i++)
            {
                var set = renderingSets.Sets.at[i];
                set.Muted = false;
                set.SetDirty();
            }

            PrefabRenderingSet.AnyMute = false;
            PrefabModelTypeOptions.AnyMute = false;

            renderingSets.SetDirty();
            AssetModelTypeLookup.SetDirty();
        }

        private void Start()
        {
            nextState = RenderingState.Rendering;
        }

        private void Stop()
        {
            nextState = RenderingState.NotRendering;
        }
        
        private static readonly ProfilerMarker _PRF_ConfirmExecutionState = new ProfilerMarker(_PRF_PFX + nameof(ConfirmExecutionState));
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
                    if (Application.isPlaying || IsEditorSimulating)
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

                if (!Application.isPlaying && (currentState == RenderingState.Rendering) && !IsEditorSimulating)
                {
                    nextState = RenderingState.NotRendering;
                    _stateReasonCode = RenderingStateReasonCode.NOT_SIMULATING;
                    return;
                }

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

                    _stateReasonCode = stoppedDueToErrors ? RenderingStateReasonCode.PREVENT_ERROR : RenderingStateReasonCode.PREVENT_OPTIONS;
                    return;
                }

                if (nextState == currentState)
                {
                    nextState = RenderingState.UnchangedState;
                }
            }
        }

        private static readonly ProfilerMarker _PRF_ExecuteNecessaryStateChanges = new ProfilerMarker(_PRF_PFX + nameof(ExecuteNecessaryStateChanges));

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
                                if (Application.isPlaying)
                                {
                                    ChangeRuntimeRenderingState(true);
                                }
                                else
                                {
                                    ChangeEditorSimulationState(true);
                                }

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
                                if (Application.isPlaying)
                                {
                                    ChangeRuntimeRenderingState(false);
                                }
                                else
                                {
                                    ChangeEditorSimulationState(false);
                                }

                                SetSceneDirty();
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

        private static readonly ProfilerMarker _PRF_ChangeRuntimeRenderingState = new ProfilerMarker(_PRF_PFX + nameof(ChangeRuntimeRenderingState));
        private void ChangeRuntimeRenderingState(bool enable)
        {
            using (_PRF_ChangeRuntimeRenderingState.Auto())
            {
                if (enable)
                {
                    DebugHelper.Log("Attempting to start runtime rendering.", this);

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
                        DebugHelper.LogException("Failed to start runtime rendering", ex, this);
                    }
                }
                else
                {
                    DebugHelper.Log("Attempting to end runtime rendering.", this);

                    gpui.enabled = false;
                }
            }
        }

#if UNITY_EDITOR
        private static readonly ProfilerMarker _PRF_ChangeEditorSimulationState = new ProfilerMarker(_PRF_PFX + nameof(ChangeEditorSimulationState));
        private void ChangeEditorSimulationState(bool enable)
        {
            using (_PRF_ChangeEditorSimulationState.Auto())
            {
                if (enable)
                {
                    DebugHelper.Log("Attempting to start GPUI simulation.", this);

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
                        DebugHelper.LogException("Failed to start simulation", ex, this);
                    }
                }
                else
                {
                    DebugHelper.Log("Attempting to end GPUI simulation.", this);

                    GPUInstancerAPI.StopEditorSimulation(gpui);
                }
            }
        }
#endif

#if UNITY_EDITOR

        private const int _P = MENU_P.TOOLS.PREFAB_RENDER.PRIORITY;
        private const string _MENU = "Tools/Prefab Rendering/";
        private const string _M_ENABLE_ = _MENU + "Enable" + SHC.CTRL_ALT_1;
        private const string _M_RUNTIME_ = _MENU + "Runtime Rendering" + SHC.CTRL_ALT_2;
        private const string _M_SIMULATE_ = _MENU + "Simulate" + SHC.CTRL_ALT_3;
        private const string _M_UPDATES_ = _MENU + "Allow Updates" + SHC.CTRL_ALT_4;
        private const string _M_BOUNCE_ = _MENU + "Bounce" + SHC.CTRL_ALT_5;

        private bool _queueToggleSimulation;

        [MenuItem(_M_ENABLE_, true)]
        private static bool _M_ENABLE_VALIDATE()
        {
            Menu.SetChecked(_M_ENABLE_, instance.enabled);
            return true;
        }

        [MenuItem(_M_ENABLE_, priority = _P)]
        private static void _M_ENABLE()
        {
            instance.enabled = !instance.enabled;
        }

        [MenuItem(_M_RUNTIME_, true)]
        private static bool _M_RUNTIME_VALIDATE()
        {
            Menu.SetChecked(_M_RUNTIME_, instance.currentState == RenderingState.Rendering);
            return instance.enabled;
        }

        [MenuItem(_M_RUNTIME_, priority = _P)]
        public static void _M_RUNTIME()
        {
            instance.nextState = instance.currentState == RenderingState.Rendering ? RenderingState.NotRendering : RenderingState.Rendering;
        }

        [MenuItem(_M_SIMULATE_, true)]
        private static bool _M_SIMULATE_VALIDATE()
        {
            Menu.SetChecked(_M_SIMULATE_, instance.IsEditorSimulating);
            return instance.enabled;
        }

        [MenuItem(_M_SIMULATE_, priority = _P)]
        public static void _M_SIMULATE()
        {
            instance.nextState = instance.IsEditorSimulating ? RenderingState.NotRendering : RenderingState.Rendering;
        }

        [MenuItem(_M_UPDATES_, true)]
        private static bool _M_UPDATES_VALIDATE()
        {
            Menu.SetChecked(_M_UPDATES_, instance.RenderingOptions.execution.allowUpdates);
            return instance.enabled;
        }

        [MenuItem(_M_UPDATES_, priority = _P)]
        public static void _M_UPDATES()
        {
            instance.RenderingOptions.execution.allowUpdates = !instance.RenderingOptions.execution.allowUpdates;
        }

        [MenuItem(_M_BOUNCE_, true)]
        private static bool _M_BOUNCE_VALIDATE()
        {
            return instance.enabled && (instance.nextState != RenderingState.BounceState);
        }

        [MenuItem(_M_BOUNCE_, priority = _P)]
        private static void _M_BOUNCE()
        {
            instance.nextState = RenderingState.BounceState;
        }

        private static readonly ProfilerMarker _PRF_ReBuryMeshes = new ProfilerMarker(_PRF_PFX + nameof(ReBuryMeshes));

        [HideIf(nameof(hideButtons))]
        [Button, ButtonGroup("Bottom"), EnableIf(nameof(IsEditorSimulating))]
        private void ReBuryMeshes()
        {
            using (_PRF_ReBuryMeshes.Auto())
            {
                //MeshBurialManagementProcessor.RefreshPrefabRenderingSets();
            }
        }
        
        [HideIf(nameof(hideButtons))]
        private static readonly ProfilerMarker _PRF_RunOnce = new ProfilerMarker(_PRF_PFX + nameof(RunOnce));
        [Button, ButtonGroup("Bottom"), EnableIf(nameof(enabled))]
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
