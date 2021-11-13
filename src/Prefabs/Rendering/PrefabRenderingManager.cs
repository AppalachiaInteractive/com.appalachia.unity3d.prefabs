//using System.Linq;

#region

using System;
using System.Collections.Generic;
using Appalachia.CI.Integration.Assets;
using Appalachia.Core.Aspects.Profiling;
using Appalachia.Core.Attributes;
using Appalachia.Core.Attributes.Editing;
using Appalachia.Core.Behaviours;
using Appalachia.Core.Collections.Implementations.Lookups;
using Appalachia.Core.Collections.Native;
using Appalachia.Core.Collections.NonSerialized;
using Appalachia.Core.Execution.RateLimiting;
using Appalachia.Core.Extensions;
using Appalachia.Jobs.Concurrency;
using Appalachia.Rendering.Prefabs.Core.States;
using Appalachia.Rendering.Prefabs.Rendering.ContentType;
using Appalachia.Rendering.Prefabs.Rendering.External;
using Appalachia.Rendering.Prefabs.Rendering.GPUI;
using Appalachia.Rendering.Prefabs.Rendering.ModelType;
using Appalachia.Rendering.Prefabs.Rendering.Options;
using Appalachia.Rendering.Prefabs.Rendering.Runtime;
using Appalachia.Utility.Extensions;
using Appalachia.Utility.Logging;
using AwesomeTechnologies.VegetationSystem;
using GPUInstancer;
using Pathfinding.Voxels;
using Sirenix.OdinInspector;
using Unity.Collections;
using Unity.Jobs;
using Unity.Mathematics;
using Unity.Profiling;
using UnityEngine;
using UnityEngine.Serialization;
using Object = UnityEngine.Object;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering
{
    [ExecuteAlways]
    [DisallowMultipleComponent]
    [ExecutionOrder(-10000)]
    public partial class PrefabRenderingManager : SingletonAppalachiaBehaviour<PrefabRenderingManager>
    {
        #region Profiling And Tracing Markers

        private const string _PRF_PFX = nameof(PrefabRenderingManager) + ".";

        private static readonly ProfilerMarker _PRF_RenderingOptions =
            new(_PRF_PFX + nameof(RenderingOptions));

        private static readonly ProfilerMarker _PRF_UpdateReferencePositions =
            new(_PRF_PFX + nameof(UpdateReferencePositions));

        private static readonly ProfilerMarker _PRF_Bounce = new(_PRF_PFX + nameof(Bounce));

        private static readonly ProfilerMarker _PRF_InitializeStructureInPlace =
            new(_PRF_PFX + nameof(InitializeStructureInPlace));

        private static readonly ProfilerMarker _PRF_GetInstanceRootForPrefab =
            new(_PRF_PFX + nameof(GetInstanceRootForPrefab));

        private static readonly ProfilerMarker _PRF_AddDistanceReferenceObject =
            new(_PRF_PFX + nameof(AddDistanceReferenceObject));

        private static readonly ProfilerMarker _PRF_RemoveDistanceReferenceObject =
            new(_PRF_PFX + nameof(RemoveDistanceReferenceObject));

        /*
        [Button, DisableIf(nameof(IsEditorSimulating))]
        private void ResetRenderingSets()
        {
            
using(ASPECT.Many(ASPECT.Profile(), ASPECT.Trace()))
            {
                runtimeRenderingDataSets.Clear();
            }
        }*/

        #endregion

        #region Properties

        public RuntimeRenderingOptions RenderingOptions
        {
            get
            {
                using (_PRF_RenderingOptions.Auto())
                {
                    if (renderingOptions == null)
                    {
                        renderingOptions = RuntimeRenderingOptions.instance;
                    }

                    return renderingOptions;
                }
            }
            set
            {
                using (_PRF_RenderingOptions.Auto())
                {
                    renderingOptions = value;
                }
            }
        }

        #endregion

        public void AddDistanceReferenceObject(GameObject go)
        {
            using (_PRF_AddDistanceReferenceObject.Auto())
            {
                _additionalReferences.AddOrUpdate(go.GetInstanceID(), go);
            }
        }

        public GameObject GetInstanceRootForPrefab(GameObject prefab)
        {
            using (_PRF_GetInstanceRootForPrefab.Auto())
            {
                if (structure == null)
                {
                    PrefabRenderingManagerInitializer.InitializeStructure();
                }

                if (structure == null)
                {
                    throw new NotSupportedException();
                }

                return structure.FindRootForPrefab(prefab);
            }
        }

        public void InitializeStructureInPlace(PrefabRenderingRuntimeStructure s)
        {
            using (_PRF_InitializeStructureInPlace.Auto())
            {
                for (var i = transform.childCount - 1; i >= 0; i--)
                {
                    var child = transform.GetChild(i);

                    child.gameObject.DestroySafely();
                }

                s.instanceRoot = new GameObject("Runtime Instances");
                s.instanceRoot.transform.SetParent(transform, false);
            }
        }

        public void RemoveDistanceReferenceObject(GameObject go)
        {
            using (_PRF_RemoveDistanceReferenceObject.Auto())
            {
                _additionalReferences.RemoveByKey(go.GetInstanceID());
            }
        }

        private void Bounce()
        {
            using (_PRF_Bounce.Auto())
            {
                HandleDisableLogic(true);
                HandleEnableLogic(true);
            }
        }

        private void UpdateReferencePositions(int index)
        {
            using (_PRF_UpdateReferencePositions.Auto())
            {
                var primaryPosition = distanceReferencePoint.transform.position;

                if (referencePointsCollection == null)
                {
                    referencePointsCollection = new NativeList<float3>[renderingSets.Sets.Count];
                }

                if (referencePointsCollection[index].ShouldAllocate())
                {
                    referencePointsCollection[index] =
                        new NativeList<float3>(24, Allocator.Persistent) {primaryPosition};
                }

                if (referencePointsCollection[index].Length == 0)
                {
                    referencePointsCollection[index].Add(primaryPosition);
                }
                else
                {
                    referencePointsCollection[index][0] = primaryPosition;
                }

                if (_additionalReferences == null)
                {
                    _additionalReferences = new GameObjectLookup();
                }
                else
                {
                    _additionalReferences.RemoveNulls();

                    for (var i = 0; i < _additionalReferences.Count; i++)
                    {
                        var pos = _additionalReferences[i].transform.position;

                        var refIndex = i + 1;

                        if (referencePointsCollection[index].Length > refIndex)
                        {
                            referencePointsCollection[index][refIndex] = pos;
                        }
                        else
                        {
                            referencePointsCollection[index].Add(pos);
                        }
                    }
                }

                referencePointsCollection[index].Length = _additionalReferences.Count + 1;
            }
        }

        #region Fields

        private const string _HIDETABS = nameof(hideTabs);
        private const string _TABGROUP = _HIDETABS + "/TABS";
        private const string _META = "Meta and Refs";
        private const string _SETTINGS = "Settings";
        private const string _MODEL = "Model Types";
        private const string _CONTENT = "Content Types";
        private const string _PREFABS = "Prefabs";

        [HideIfGroup(_HIDETABS)]
        [TabGroup(_TABGROUP, _META)]
        [SmartLabel]
        [SerializeField]
        public ShaderVariantCollection shaderVariants;

        [TabGroup(_TABGROUP, _META)]
        [SmartLabel]
        [NonSerialized]
        public GPUInstancerPrefabManager gpui;

        [TabGroup(_TABGROUP, _META)]
        [SmartLabel]
        [NonSerialized]
        public VegetationSystemPro vegetationSystem;

        [TabGroup(_TABGROUP, _META)]
        [SmartLabel]
        [SerializeField]
        public PrefabLocationSource prefabSource;

        [TabGroup(_TABGROUP, _META)]
        [SmartLabel]
        [SerializeField]
        public GPUInstancerPrototypeMetadataCollection metadatas;

        [TabGroup(_TABGROUP, _META)]
        [SmartLabel]
        [SerializeField]
        public PrefabRenderingRuntimeStructure structure;

        [TabGroup(_TABGROUP, _META)]
        [SmartLabel]
        [SerializeField]
        public GameObject distanceReferencePoint;

        [HideInInspector]
        [SerializeField]
        private GameObjectLookup _additionalReferences;

        [TabGroup(_TABGROUP, _META)]
        [SmartLabel]
        [HideInInspector]
        private NativeList<float3>[] referencePointsCollection;

        [TabGroup(_TABGROUP, _META)]
        [SmartLabel]
        [HideInInspector]
        [SerializeField]
        public bool gpuiRuntimeBuffersInitialized;

        [TabGroup(_TABGROUP, _META)]
        [SmartLabel]
        [SerializeField]
        public new Bounds renderingBounds;

        public bool ActiveNow { get; private set; }

        [TabGroup(_TABGROUP, _META)]
        [SmartLabel]
        [SerializeField]
        public Camera frustumCamera;

        [TabGroup(_TABGROUP, _META)]
        [SmartLabel]
        [SerializeField]
        public AstarPath pathFinder;

        [FormerlySerializedAs("_options")]
        [TabGroup(_TABGROUP, _SETTINGS, Order = 4)]
        [SmartLabel]
        [SerializeField]
        [InlineEditor(Expanded = true, ObjectFieldMode = InlineEditorObjectFieldModes.CompletelyHidden)]
        [InlineProperty]
        private RuntimeRenderingOptions renderingOptions;

        private bool stoppedDueToErrors;

        [FormerlySerializedAs("_assetTypeLookup")]
        [SerializeField]
        [HideInInspector]
        private PrefabModelTypeOptionsLookup assetModelTypeLookup;

        [TabGroup(_TABGROUP, _MODEL, Order = 6)]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        [ShowInInspector]
        [InlineEditor(ObjectFieldMode = InlineEditorObjectFieldModes.Boxed)]
        public PrefabModelTypeOptionsLookup AssetModelTypeLookup
        {
            get
            {
                if (assetModelTypeLookup == null)
                {
                    assetModelTypeLookup = PrefabModelTypeOptionsLookup.instance;
                }

                return assetModelTypeLookup;
            }
            set => assetModelTypeLookup = value;
        }

        [SerializeField]
        [HideInInspector]
        private PrefabContentTypeOptionsLookup contentTypeLookup;

        [TabGroup(_TABGROUP, _CONTENT, Order = 8)]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        [ShowInInspector]
        [InlineEditor(ObjectFieldMode = InlineEditorObjectFieldModes.Boxed)]
        public PrefabContentTypeOptionsLookup ContentTypeLookup
        {
            get
            {
                if (contentTypeLookup == null)
                {
                    contentTypeLookup = PrefabContentTypeOptionsLookup.instance;
                }

                return contentTypeLookup;
            }
            set => contentTypeLookup = value;
        }

        [NonSerialized]
        [HideInInspector]
        private PrefabRenderingSetCollection _renderingSets;

        [TabGroup(_TABGROUP, _PREFABS, Order = 10)]
        [SmartLabel]
        [InlineEditor(Expanded = true, ObjectFieldMode = InlineEditorObjectFieldModes.CompletelyHidden)]
        [InlineProperty]
        [ShowInInspector]
        public PrefabRenderingSetCollection renderingSets
        {
            get
            {
                if (_renderingSets == null)
                {
                    _renderingSets = PrefabRenderingSetCollection.instance;
                }

                return _renderingSets;
            }
            set => _renderingSets = value;
        }

        #endregion

        #region Unity Events

        private static readonly ProfilerMarker _PRF_OnAwake = new(_PRF_PFX + nameof(OnAwake));

        protected override void OnAwake()
        {
            using (_PRF_OnAwake.Auto())
            {
                currentState = RenderingState.NotRendering;

                nextState = Application.isPlaying
                    ? RenderingOptions.execution.startOnPlay
                        ? RenderingState.Rendering
                        : RenderingState.NotRendering
                    : RenderingOptions.execution.startInEditor
                        ? RenderingState.Rendering
                        : RenderingState.NotRendering;

                ConfirmExecutionState();

                PrefabRenderingManagerInitializer.OnAwake();
            }
        }

        private void OnEnable()
        {
            HandleEnableLogic(false);
        }

        private static readonly ProfilerMarker _PRF_HandleEnableLogic =
            new(_PRF_PFX + nameof(HandleEnableLogic));

        private void HandleEnableLogic(bool bouncing)
        {
#if UNITY_EDITOR
            if (!bouncing &&
                !Application.isPlaying &&
                !UnityEditorInternal.ProfilerDriver.enabled &&
                RenderingOptions.profiling.enableProfilingOnStart)
            {
                UnityEditorInternal.ProfilerDriver.enabled = true;
            }
#endif
            using (_PRF_HandleEnableLogic.Auto())
            {
                currentState = RenderingState.NotRendering;

                nextState = Application.isPlaying
                    ? RenderingOptions.execution.startOnPlay
                        ? RenderingState.Rendering
                        : RenderingState.NotRendering
                    : RenderingOptions.execution.startInEditor
                        ? RenderingState.Rendering
                        : RenderingState.NotRendering;

                ConfirmExecutionState();

                PrefabRenderingManagerInitializer.OnEnable();
            }

#if UNITY_EDITOR
            if (!bouncing &&
                !Application.isPlaying &&
                UnityEditorInternal.ProfilerDriver.enabled &&
                RenderingOptions.profiling.disableProfilingAfterInitializationLoop)
            {
                UnityEditorInternal.ProfilerDriver.enabled = false;
            }
#endif
        }

        private void OnDisable()
        {
            HandleDisableLogic(false);
        }

        private static readonly ProfilerMarker _PRF_HandleDisableLogic =
            new(_PRF_PFX + nameof(HandleDisableLogic));

        private void HandleDisableLogic(bool bouncing)
        {
            using (_PRF_HandleDisableLogic.Auto())
            {
                currentState = RenderingState.NotRendering;
                nextState = RenderingState.NotRendering;

                _cycleManager?.ForceCompleteAll();
                _cycleManager?.Dispose();

                //_updateJobList.SafeDispose();
                referencePointsCollection.SafeDispose();
#if UNITY_EDITOR
                if (!bouncing && !Application.isPlaying)
                {
                    PrefabRenderingSet.UpdateAllIDs();
                    GPUInstancerPrototypeMetadata.UpdateAllIDs();
                }
#endif

                PrefabRenderingManagerDestroyer.ResetExistingRuntimeStateInstances();

                PrefabRenderingManagerDestroyer.Dispose();
#if UNITY_EDITOR
                SetSceneDirty();
                if (!bouncing &&
                    !UnityEditor.EditorApplication.isCompiling &&
                    !UnityEditor.EditorApplication.isPlayingOrWillChangePlaymode &&
                    !Application.isPlaying)
                {
                    RateLimiter.DoXTimesEvery(
                        nameof(HandleDisableLogic),
                        AssetDatabaseManager.SaveAssets,
                        1,
                        1000 * 60,
                        Time.time
                    );
                }
#endif
            }
        }

        private static readonly ProfilerMarker _PRF_RecastGraphOnOnCollectSceneMeshes =
            new(_PRF_PFX + nameof(RecastGraphOnOnCollectSceneMeshes));

        public void RecastGraphOnOnCollectSceneMeshes(
            List<RasterizationMesh> meshes,
            LayerMask mask,
            List<string> tags,
            Bounds pathBounds)
        {
            using (_PRF_RecastGraphOnOnCollectSceneMeshes.Auto())
            {
                var setCount = renderingSets.Sets.Count;
                for (var i = 0; i < setCount; i++)
                {
                    var set = renderingSets.Sets.at[i];

                    if (!set.modelOptions.layer.IsLayerInMask(mask))
                    {
                        continue;
                    }

                    if (tags.Count > 0)
                    {
                        var tagMatch = false;
                        for (var tagI = 0; tagI < tags.Count; tagI++)
                        {
                            var t = tags[tagI];

                            if (set.prefab.CompareTag(t))
                            {
                                tagMatch = true;
                                break;
                            }
                        }

                        if (!tagMatch)
                        {
                            continue;
                        }
                    }

                    var instanceManager = set.instanceManager;

                    var instanceCount = instanceManager.element.Count;

                    for (var j = 0; j < instanceCount; j++)
                    {
                        var matrix = instanceManager.element.matrices_original[j];

                        var bounds = matrix.TranslateAndScaleBounds(set.bounds);
                        var rasterizationMesh = new RasterizationMesh(
                            set.cheapestMeshVerts,
                            set.cheapestMeshTris,
                            bounds,
                            matrix
                        );

                        meshes.Add(rasterizationMesh);
                    }
                }
            }
        }

        private static readonly ProfilerMarker _PRF_PrepareToExecuteUpdateLoop =
            new(_PRF_PFX + nameof(PrepareToExecuteUpdateLoop));

        private void PrepareToExecuteUpdateLoop()
        {
            using (_PRF_PrepareToExecuteUpdateLoop.Auto())
            {
                if (_cycleManager == null)
                {
                    _cycleManager = new JobCycleQueueManager();
                }

                if (_cycleManager.RequiresPopulation)
                {
                    _cycleManager.Populate(
                        renderingSets.Sets.Count,
                        RenderingOptions.execution.fastestAllowedSetCycleMilliseconds
                    );
                }

#if UNITY_EDITOR
                if (RenderingOptions.profiling.disableProfilingAfterUpdateLoop &&
                    (_updateLoopCount > RenderingOptions.profiling.updateLoopProfilingCount))
                {
                    if (!Application.isPlaying &&
                        UnityEditorInternal.ProfilerDriver.enabled &&
                        !_updateLoopStopped)
                    {
                        PROFILING.Profiling_Disable();
                        _updateLoopStopped = true;
                    }
                }

                RenderingOptions.editor.ApplyTo(gpui.gpuiSimulator);
#endif
                if (RenderingOptions.global.ApplyTo(gpui.renderSettings))
                {
                    gpui.layerMask = RenderingOptions.global.layerMask;
                }
            }
        }

        [NonSerialized] private int _updateLoopCount;
        [NonSerialized] private bool _updateLoopStopped;
        [NonSerialized] private DateTime _frameStart;
        [NonSerialized] private JobCycleQueueManager _cycleManager;
        [NonSerialized] private readonly bool _loopSafetyBreak = false;
        [NonSerialized] private NonSerializedList<int> _lateUpdateIndices;

        private static readonly ProfilerMarker _PRF_Update = new(_PRF_PFX + nameof(Update));

        private static readonly ProfilerMarker _PRF_Update_ProcessingLoop =
            new(_PRF_PFX + nameof(Update) + ".ProcessingLoop");

        private static readonly ProfilerMarker _PRF_Update_ScheduleJobs =
            new(_PRF_PFX + nameof(Update) + ".ScheduleJobs");

        private void Update()
        {
            using (_PRF_Update.Auto())
            {
                try
                {
                    _frameStart = DateTime.UtcNow;
                    ActiveNow = true;

                    ExecuteNecessaryStateChanges();

                    PrefabRenderingManagerInitializer.Update();

                    if (currentState == RenderingState.NotRendering)
                    {
                        return;
                    }

                    PrepareToExecuteUpdateLoop();

                    var processed = 0;
                    var cycles = 0;
                    var prefabCount = renderingSets.Sets.Count;

                    var exeo = renderingOptions.execution;
                    var setUpdateLimit = exeo.useExplicitFrameCounts ? exeo.setUpdatesPerFrame : prefabCount;

                    using (_PRF_Update_ProcessingLoop.Auto())
                    {
                        _cycleManager.CheckTiming();
                        _cycleManager.CheckWork();

                        var hasAlreadyChecked = false;
                        while (ShouldContinueUpdate(
                            cycles,
                            processed,
                            setUpdateLimit,
                            prefabCount,
                            exeo,
                            ref hasAlreadyChecked
                        ))
                        {
                            _updateLoopCount += 1;
                            processed += 1;
                            cycles += 1;

                            var dataSetIndex = _cycleManager.NextInactive;

                            JobHandle handle = default;
                            try
                            {
                                var renderingSet = renderingSets.Sets.at[dataSetIndex];

                                UpdateReferencePositions(dataSetIndex);

                                if (renderingSet.OnUpdate(
                                    gpui,
                                    prefabSource,
                                    referencePointsCollection[dataSetIndex],
                                    gpui.cameraData.mainCamera,
                                    frustumCamera,
                                    RenderingOptions,
                                    out handle
                                ))
                                {
                                    _cycleManager.SetActive(dataSetIndex, handle);
                                }
                                else
                                {
                                    _cycleManager.Skip(dataSetIndex);
                                }
                            }
                            catch (InvalidOperationException iox)
                            {
                                AppaLog.Error($"Exception while updating index {dataSetIndex}.");
                                AppaLog.Exception(iox);
                                renderingOptions.execution.allowUpdates = false;
                                stoppedDueToErrors = true;
                            }
                            catch (Exception ex)
                            {
                                var identifier = $"index {dataSetIndex}";
                                Object context = this;

                                try
                                {
                                    var set = renderingSets.Sets.at[dataSetIndex];
                                    context = set;
                                    identifier = set.setName;
                                }

                                // ReSharper disable once EmptyGeneralCatchClause
                                catch
                                {
                                }

                                AppaLog.Error($"Failed to assign mesh wind data to {name}.");
                                AppaLog.Exception(ex);
                                AppaLog.Error($"Exception while updating {identifier}.", context);
                                handle.Complete();
                            }
                        }
                    }

                    using (_PRF_Update_ScheduleJobs.Auto())
                    {
                        JobHandle.ScheduleBatchedJobs();
                    }
                }
                finally
                {
                    ActiveNow = false;
                }
            }
        }

        private static readonly ProfilerMarker _PRF_ShouldContinueUpdate =
            new(_PRF_PFX + nameof(ShouldContinueUpdate));

        private bool ShouldContinueUpdate(
            int cycles,
            int processed,
            int setUpdateLimit,
            int prefabCount,
            RuntimeRenderingExecutionOptions exeo,
            ref bool hasAlreadyChecked)
        {
            using (_PRF_ShouldContinueUpdate.Auto())
            {
                if (_loopSafetyBreak)
                {
                    updateBreak = RenderLoopBreakCode.LoopSafetyBreak;
                    return false;
                }

                if (!RenderingOptions.execution.allowUpdates)
                {
                    updateBreak = RenderLoopBreakCode.OptionsDoNotAllowUpdates;
                    return false;
                }

                if (currentState == RenderingState.NotRendering)
                {
                    updateBreak = RenderLoopBreakCode.CurrentStateNotRendering;
                    return false;
                }

                if (nextState == RenderingState.NotRendering)
                {
                    updateBreak = RenderLoopBreakCode.NextStateNotRendering;
                    return false;
                }

                if (cycles >= prefabCount)
                {
                    updateBreak = RenderLoopBreakCode.CyclesGreaterThanPrefabCount;
                    return false;
                }

                if (!hasAlreadyChecked)
                {
                    _cycleManager.CheckTiming();
                    hasAlreadyChecked = true;
                }

                if (!_cycleManager.AnyInactive)
                {
                    updateBreak = RenderLoopBreakCode.CycleManagerNoneWaiting;
                    return false;
                }

                if (_cycleManager.CompletedCount > 10)
                {
                    updateBreak = RenderLoopBreakCode.CycleManagerCompletedQueueDepth;
                    return false;
                }

                if (exeo.useExplicitFrameCounts)
                {
                    if (processed >= setUpdateLimit)
                    {
                        updateBreak = RenderLoopBreakCode.ProcessedMoreThanExplicitLimit;
                        return false;
                    }
                }
                else
                {
                    var elapsed = (DateTime.UtcNow - _frameStart).TotalMilliseconds;

                    if ((cycles > 0) && (elapsed > exeo.setUpdateMillisecondsPerFrame))
                    {
                        updateBreak = RenderLoopBreakCode.ExceededAllowedTime;
                        return false;
                    }
                }

                return true;
            }
        }

        private static readonly ProfilerMarker _PRF_LateUpdate = new(_PRF_PFX + nameof(LateUpdate));

        private static readonly ProfilerMarker _PRF_LateUpdate_ProcessingLoop =
            new(_PRF_PFX + nameof(LateUpdate) + ".ProcessingLoop");

        private void LateUpdate()
        {
            using (_PRF_LateUpdate.Auto())
            {
                if (currentState == RenderingState.NotRendering)
                {
                    return;
                }

                try
                {
                    ActiveNow = true;

                    if (_lateUpdateIndices == null)
                    {
                        _lateUpdateIndices = new NonSerializedList<int>(16);
                    }

                    var processed = 0;
                    var cycles = 0;
                    var prefabCount = renderingSets.Sets.Count;

                    var exeo = renderingOptions.execution;
                    var setUpdateLimit = exeo.useExplicitFrameCounts ? exeo.setUpdatesPerFrame : prefabCount;

                    using (_PRF_LateUpdate_ProcessingLoop.Auto())
                    {
                        _cycleManager.CheckWork();
                        var dataSetIndex = _cycleManager.NextCompleted;

                        try
                        {
                            var hasAlreadyLooped = false;
                            while (ShouldContinueLateUpdate(
                                cycles,
                                processed,
                                setUpdateLimit,
                                prefabCount,
                                exeo,
                                ref hasAlreadyLooped
                            ))
                            {
                                processed += 1;
                                cycles += 1;

                                dataSetIndex = _cycleManager.NextCompleted;
                                _cycleManager.EnsureCompleted(dataSetIndex);

                                var renderingSet = renderingSets.Sets.at[dataSetIndex];

                                if (dataSetIndex == 0 /* && !Application.isPlaying*/)
                                {
                                    renderingSets.RefreshRuntimeCounts();
                                }

                                if (renderingSet.OnLateUpdate(gpui, RenderingOptions))
                                {
                                    stoppedDueToErrors = false;
                                    _lateUpdateIndices.Add(dataSetIndex);
                                }
                                else
                                {
                                    renderingOptions.execution.allowUpdates = false;
                                    stoppedDueToErrors = true;
                                }

                                _cycleManager.ResetCompleted(dataSetIndex);
                            }
                        }
                        catch (InvalidOperationException iox)
                        {
                            AppaLog.Error($"Exception while late updating index {dataSetIndex}.");
                            AppaLog.Exception(iox);
                            renderingOptions.execution.allowUpdates = false;
                            stoppedDueToErrors = true;
                        }
                        catch (Exception ex)
                        {
                            AppaLog.Error($"Exception while late updating index {dataSetIndex}.");
                            AppaLog.Exception(ex);
                        }

                        JobTracker.CompleteAll(PrefabRenderingJobKeys._PRSIM_LATEUPDATE_PUSHMATRICES);

                        var lateI = 0;
                        try
                        {
                            for (lateI = 0; lateI < _lateUpdateIndices.Count; lateI++)
                            {
                                var index = _lateUpdateIndices[lateI];

                                var renderingSet = renderingSets.Sets.at[index];

                                if (renderingSet.gpuMatrixPushPending)
                                {
                                    renderingSet.PushAllGPUMatrices();
                                }
                            }
                        }
                        catch (InvalidOperationException iox)
                        {
                            AppaLog.Error($"Exception while pushing GPUI matrices for index {lateI}.");
                            AppaLog.Exception(iox);
                            renderingOptions.execution.allowUpdates = false;
                            stoppedDueToErrors = true;
                        }
                        catch (Exception ex)
                        {
                            AppaLog.Error($"Exception while pushing GPUI matrices for index {lateI}.");
                            AppaLog.Exception(ex);
                        }
                        finally
                        {
                            _lateUpdateIndices?.ClearFast();
                        }
                    }
                }
                finally
                {
                    ActiveNow = false;
                }
            }
        }

        private static readonly ProfilerMarker _PRF_ShouldContinueLateUpdate =
            new(_PRF_PFX + nameof(ShouldContinueLateUpdate));

        private bool ShouldContinueLateUpdate(
            int cycles,
            int processed,
            int setUpdateLimit,
            int prefabCount,
            RuntimeRenderingExecutionOptions exeo,
            ref bool hasAlreadyChecked)
        {
            using (_PRF_ShouldContinueLateUpdate.Auto())
            {
                if (_loopSafetyBreak)
                {
                    lateUpdateBreak = RenderLoopBreakCode.LoopSafetyBreak;
                    return false;
                }

                if (!RenderingOptions.execution.allowUpdates)
                {
                    lateUpdateBreak = RenderLoopBreakCode.OptionsDoNotAllowUpdates;
                    return false;
                }

                if (currentState == RenderingState.NotRendering)
                {
                    lateUpdateBreak = RenderLoopBreakCode.CurrentStateNotRendering;
                    return false;
                }

                if (nextState == RenderingState.NotRendering)
                {
                    lateUpdateBreak = RenderLoopBreakCode.NextStateNotRendering;
                    return false;
                }

                if (cycles >= prefabCount)
                {
                    lateUpdateBreak = RenderLoopBreakCode.CyclesGreaterThanPrefabCount;
                    return false;
                }

                if (!hasAlreadyChecked)
                {
                    _cycleManager.CheckTiming();
                    hasAlreadyChecked = true;
                }

                if (!_cycleManager.AnyCompleted)
                {
                    lateUpdateBreak = RenderLoopBreakCode.CycleManagerNoneCompleted;
                    return false;
                }

                if (exeo.useExplicitFrameCounts)
                {
                    if (processed >= setUpdateLimit)
                    {
                        lateUpdateBreak = RenderLoopBreakCode.ProcessedMoreThanExplicitLimit;
                        return false;
                    }
                }
                else
                {
                    var elapsed = (DateTime.UtcNow - _frameStart).TotalMilliseconds;

                    if ((cycles > 0) && (elapsed > exeo.setUpdateMillisecondsPerFrame))
                    {
                        lateUpdateBreak = RenderLoopBreakCode.ExceededAllowedTime;
                        return false;
                    }
                }

                return true;
            }
        }

        #endregion
    }
}