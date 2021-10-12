#region

using System;
using Appalachia.Core.Attributes.Editing;
using Appalachia.Core.Behaviours;
using Appalachia.Core.Collections.Native;
using Appalachia.Jobs.Burstable;
using Appalachia.Jobs.Concurrency;
using Appalachia.Jobs.InitializeJob;
using Appalachia.Jobs.Transfers;
using Appalachia.Rendering.Prefabs.Core.States;
using Appalachia.Rendering.Prefabs.Rendering.Burstable;
using Appalachia.Rendering.Prefabs.Rendering.ContentType;
using Appalachia.Rendering.Prefabs.Rendering.External;
using Appalachia.Rendering.Prefabs.Rendering.GPUI;
using Appalachia.Rendering.Prefabs.Rendering.Jobs;
using Appalachia.Rendering.Prefabs.Rendering.ModelType;
using Appalachia.Rendering.Prefabs.Rendering.ModelType.Instancing;
using Appalachia.Rendering.Prefabs.Rendering.Options;
using Appalachia.Rendering.Prefabs.Rendering.Options.Rendering;
using GPUInstancer;
using Sirenix.OdinInspector;
using Unity.Collections;
using Unity.Collections.NotBurstCompatible;
using Unity.Jobs;
using Unity.Mathematics;
using Unity.Profiling;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Runtime
{
    [Serializable]
    public class PrefabRenderingInstanceManager : InternalBase<PrefabRenderingInstanceManager>,
                                                  IDisposable
    {
        private const string _PRF_PFX = nameof(PrefabRenderingInstanceManager) + ".";

        private const int BaseSize = 1024;

        private static readonly ProfilerMarker _PRF_Dispose = new(_PRF_PFX + nameof(Dispose));

        private static readonly ProfilerMarker
            _PRF_ResetExternalParameterCollectionsBeforeExecution =
                new(_PRF_PFX + nameof(ResetExternalParameterCollectionsBeforeExecution));

        private static readonly ProfilerMarker _PRF_InstantiateNewInstances =
            new(_PRF_PFX + nameof(InstantiateNewInstances));

        private static readonly ProfilerMarker _PRF_IsExternalStateValidForExecution =
            new(_PRF_PFX + nameof(IsExternalStateValidForExecution));

        private static readonly ProfilerMarker _PRF_UpdateNextState =
            new(_PRF_PFX + nameof(UpdateNextState));

        private static readonly ProfilerMarker _PRF_OnUpdate_Initialize =
            new(_PRF_PFX + nameof(OnUpdate_Initialize));

        private static readonly ProfilerMarker _PRF_OnUpdate_Initialize_Data =
            new(_PRF_PFX + nameof(OnUpdate_Initialize_Data));

        private static readonly ProfilerMarker _PRF_OnUpdate_Initialize_Jobs =
            new(_PRF_PFX + nameof(OnUpdate_Initialize_Jobs));

        private static readonly ProfilerMarker _PRF_OnUpdate_Execute =
            new(_PRF_PFX + nameof(OnUpdate_Execute));

        private static readonly ProfilerMarker _PRF_OnUpdate_Execute_Frustum =
            new(_PRF_PFX + nameof(OnUpdate_Execute) + ".Frustum");

        private static readonly ProfilerMarker _PRF_OnUpdate_Execute_Jobs =
            new(_PRF_PFX + nameof(OnUpdate_Execute_Jobs));

        private static readonly ProfilerMarker _PRF_OnUpdate_Execute_Jobs_Prepare =
            new(_PRF_PFX + nameof(OnUpdate_Execute_Jobs) + ".Prepare");

        private static readonly ProfilerMarker _PRF_OnUpdate_Execute_Jobs_CopySettings =
            new(_PRF_PFX + nameof(OnUpdate_Execute_Jobs) + ".CopySettings");

        private static readonly ProfilerMarker _PRF_OnUpdate_Execute_Jobs_HandleTransfer =
            new(_PRF_PFX + nameof(OnUpdate_Execute_Jobs) + ".HandleTransfer");

        private static readonly ProfilerMarker _PRF_OnUpdate_Execute_Jobs_HandleEnabled =
            new(_PRF_PFX + nameof(OnUpdate_Execute_Jobs) + ".HandleEnabled");

        private static readonly ProfilerMarker _PRF_OnUpdate_Execute_Jobs_HandleDisabled =
            new(_PRF_PFX + nameof(OnUpdate_Execute_Jobs) + ".HandleDisabled");

        private static readonly ProfilerMarker _PRF_OnUpdate_Execute_Jobs_HandleCounts =
            new(_PRF_PFX + nameof(OnUpdate_Execute_Jobs) + ".HandleCounts");

        private static readonly ProfilerMarker _PRF_OnLateUpdate_Initialize =
            new(_PRF_PFX + nameof(OnLateUpdate_Initialize));

        private static readonly ProfilerMarker _PRF_OnLateUpdate_Initialize_InitializeNative =
            new(_PRF_PFX + nameof(OnLateUpdate_Initialize) + ".InitializeNative");

        private static readonly ProfilerMarker _PRF_OnLateUpdate_Execute =
            new(_PRF_PFX + nameof(OnLateUpdate_Execute));

        private static readonly ProfilerMarker _PRF_OnLateUpdate_Execute_CheckDisabled =
            new(_PRF_PFX + nameof(OnLateUpdate_Execute) + ".CheckDisabled");

        private static readonly ProfilerMarker _PRF_OnLateUpdate_Execute_Processing =
            new(_PRF_PFX + nameof(OnLateUpdate_Execute) + ".Processing");

        private static readonly ProfilerMarker _PRF_OnLateUpdate_Execute_GPUMatrixPush =
            new(_PRF_PFX + nameof(OnLateUpdate_Execute) + ".GPUMatrixPush");

        private static readonly ProfilerMarker _PRF_OnLateUpdate_Execute_GetInstanceAndState =
            new(_PRF_PFX + nameof(OnLateUpdate_Execute) + ".GetInstanceAndState");

        private static readonly ProfilerMarker _PRF_OnLateUpdate_Execute_FinalErrorCheck =
            new(_PRF_PFX + nameof(OnLateUpdate_Execute) + ".FinalErrorCheck");

        private static readonly ProfilerMarker _PRF_OnLateUpdate_Execute_CheckErrors =
            new(_PRF_PFX + nameof(OnLateUpdate_Execute) + ".CheckErrors");

        private static readonly ProfilerMarker _PRF_OnLateUpdate_Execute_SetCounts =
            new(_PRF_PFX + nameof(OnLateUpdate_Execute) + ".SetCounts");

        private static readonly ProfilerMarker _PRF_PushAllGPUMatrices =
            new(_PRF_PFX + nameof(PushAllGPUMatrices));

        private static readonly ProfilerMarker _PRF_TearDownInstances =
            new(_PRF_PFX + nameof(TearDownInstances));

        private static readonly ProfilerMarker _PRF_TearDownInstances_UpdateInstancesAndPush =
            new(_PRF_PFX + nameof(TearDownInstances) + ".UpdateInstancesAndPush");

        [SerializeField] private int _adoptedBaseSize = BaseSize;

        /// <summary>
        ///     The value as the beginning of the current frame;
        /// </summary>
        [NonSerialized]
        [ShowInInspector]
        [SmartLabel]
        [Sirenix.OdinInspector.ReadOnly]
        private RuntimeStateCode _currentState = RuntimeStateCode.NotReady;

        [NonSerialized]
        [ShowInInspector]
        [SmartLabel]
        [Sirenix.OdinInspector.ReadOnly]
        private RuntimeSupplementalStateCode _currentSupplementalStateCode;

        [NonSerialized] private RuntimePrefabRenderingElement _element;
        [NonSerialized] private NativeList<bool> _externalParameterEnabledState;

        /// <summary>
        ///     The value at the beginning of the next frame.
        /// </summary>
        [NonSerialized]
        [ShowInInspector]
        [SmartLabel]
        [Sirenix.OdinInspector.ReadOnly]
        private RuntimeStateCode _nextState = RuntimeStateCode.NotReady;

        [NonSerialized]
        [ShowInInspector]
        [SmartLabel]
        [Sirenix.OdinInspector.ReadOnly]
        private RuntimeSupplementalStateCode _nextSupplementalStateCode;

        [NonSerialized] private GameObject _prefabInstanceRoot;

        /// <summary>
        ///     The value at the beginning of the previous frame.
        /// </summary>
        [NonSerialized]
        [ShowInInspector]
        [SmartLabel]
        [Sirenix.OdinInspector.ReadOnly]
        private RuntimeStateCode _previousState = RuntimeStateCode.NotReady;

        [NonSerialized]
        [ShowInInspector]
        [SmartLabel]
        [Sirenix.OdinInspector.ReadOnly]
        private RuntimeSupplementalStateCode _previousSupplementalStateCode;

        [NonSerialized] private int _realActiveInstances;
        [NonSerialized] private RuntimePrefabRenderingSetTemporary _temp;

        //[NonSerialized] private bool _forceDisabled;

        [NonSerialized] private bool _transferOriginalToCurrent;

        public bool StateChanged => _currentState != _previousState;
        public bool StateChanging => _currentState != _nextState;

        public bool ShouldProcess =>
            (_previousState == RuntimeStateCode.Enabled) ||
            (_currentState == RuntimeStateCode.Enabled) ||
            (_nextState == RuntimeStateCode.Enabled);

        public RuntimeStateCode previousState
        {
            get => _previousState;
            set => _previousState = value;
        }

        public RuntimeStateCode currentState
        {
            get => _currentState;
            set => _currentState = value;
        }

        public RuntimeStateCode nextState
        {
            get => _nextState;
            set => _nextState = value;
        }

        public RuntimeSupplementalStateCode previousSupplementalStateCode
        {
            get => _previousSupplementalStateCode;
            set => _previousSupplementalStateCode = value;
        }

        public RuntimeSupplementalStateCode currentSupplementalStateCode
        {
            get => _currentSupplementalStateCode;
            set => _currentSupplementalStateCode = value;
        }

        public RuntimeSupplementalStateCode nextSupplementalStateCode
        {
            get => _nextSupplementalStateCode;
            set => _nextSupplementalStateCode = value;
        }

        [field: NonSerialized] public bool gpuiInitialized { get; private set; }

        [field: NonSerialized] public bool initializationStarted { get; private set; }

        [field: NonSerialized] public bool initializationCompleted { get; private set; }

        [field: NonSerialized] public bool gpuMatrixPushPending { get; private set; }

        public bool transferOriginalToCurrent
        {
            get => _transferOriginalToCurrent;
            set => _transferOriginalToCurrent = value;
        }

        public RuntimePrefabRenderingElement element => _element;

        public void Dispose()
        {
            using (_PRF_Dispose.Auto())
            {
                SafeNative.SafeDispose(ref _element, ref _temp, ref _externalParameterEnabledState);
            }
        }

        public InstanceStateCounts GetStateCounts()
        {
            return _element?.stateCounts ?? default;
        }

        private void ResetExternalParameterCollectionsBeforeExecution(
            PrefabRenderingSet renderingSet)
        {
            using (_PRF_ResetExternalParameterCollectionsBeforeExecution.Auto())
            {
                if (!_externalParameterEnabledState.IsCreated)
                {
                    _externalParameterEnabledState = new NativeList<bool>(
                        renderingSet.ExternalParameters.Count,
                        Allocator.Persistent
                    );
                }

                _externalParameterEnabledState.ResizeUninitialized(
                    renderingSet.ExternalParameters.Count
                );

                for (var i = 0; i < renderingSet.ExternalParameters.Count; i++)
                {
                    var parameters = renderingSet.ExternalParameters.at[i];

                    _externalParameterEnabledState[i] = parameters.enabled;
                }
            }
        }

        private void InstantiateNewInstances(int instanceSum)
        {
            using (_PRF_InstantiateNewInstances.Auto())
            {
                _element.instances = new PrefabRenderingInstance[instanceSum];

                for (var index = 0; index < _element.instances.Length; index++)
                {
                    _element.instances[index] = new PrefabRenderingInstance(index);
                }
            }
        }

        public bool IsExternalStateValidForExecution(
            PrefabRenderingSet renderingSet,
            GPUInstancerPrefabManager gpui)
        {
            using (_PRF_IsExternalStateValidForExecution.Auto())
            {
                var noGameObjectPrototype = renderingSet.prototypeMetadata.prototype;

                var noGameObjectRuntimeData = gpui.GetRuntimeData(noGameObjectPrototype);

                var nogoRequiresInitialization = noGameObjectRuntimeData == null;

                if (nogoRequiresInitialization)
                {
                    gpuiInitialized = false;
                }

                if (!gpuiInitialized)
                {
                    if (nogoRequiresInitialization)
                    {
                        noGameObjectRuntimeData =
                            gpui.InitializeRuntimeDataForPrefabPrototype(noGameObjectPrototype);

                        GPUInstancerUtility.InitializeGPUBuffer(noGameObjectRuntimeData);
                    }

                    gpuiInitialized = true;
                }

                if (noGameObjectRuntimeData == null)
                {
                    return false;
                }

                return true;
            }
        }

        public void UpdateNextState(PrefabRenderingSet renderingSet)
        {
            using (_PRF_UpdateNextState.Auto())
            {
                _previousSupplementalStateCode = _currentSupplementalStateCode;
                _currentSupplementalStateCode = _nextSupplementalStateCode;
                _nextSupplementalStateCode = RuntimeSupplementalStateCode.NotReady;

                _previousState = _currentState;
                _currentState = _nextState;
                _nextState = RuntimeStateCode.NotReady;

                if (renderingSet.Muted)
                {
                    _nextState = RuntimeStateCode.Disabled;
                    _nextSupplementalStateCode =
                        RuntimeSupplementalStateCode.PrefabRenderingSetIsMuted;
                    return;
                }

                if (renderingSet.modelOptions.typeOptions.options.Muted)
                {
                    _nextState = RuntimeStateCode.Disabled;
                    _nextSupplementalStateCode = RuntimeSupplementalStateCode.ModelTypeIsMuted;
                    return;
                }

                if (renderingSet.contentOptions.typeOptions.options.Muted)
                {
                    _nextState = RuntimeStateCode.Disabled;
                    _nextSupplementalStateCode = RuntimeSupplementalStateCode.ContentTypeIsMuted;
                    return;
                }

                if (renderingSet.Soloed)
                {
                    _nextState = RuntimeStateCode.Enabled;
                    _nextSupplementalStateCode =
                        RuntimeSupplementalStateCode.PrefabRenderingSetIsSoloed;
                    return;
                }

                if (renderingSet.modelOptions.typeOptions.options.Soloed)
                {
                    _nextState = RuntimeStateCode.Enabled;
                    _nextSupplementalStateCode = RuntimeSupplementalStateCode.ModelTypeIsSoloed;
                    return;
                }

                if (renderingSet.contentOptions.typeOptions.options.Soloed)
                {
                    _nextState = RuntimeStateCode.Enabled;
                    _nextSupplementalStateCode = RuntimeSupplementalStateCode.ContentTypeIsSoloed;
                    return;
                }

                if (PrefabRenderingSet.AnySolo)
                {
                    _nextState = RuntimeStateCode.Disabled;
                    _nextSupplementalStateCode =
                        RuntimeSupplementalStateCode.AnotherPrefabRenderingSetIsSoloed;
                    return;
                }

                if (PrefabModelTypeOptions.AnySolo)
                {
                    _nextState = RuntimeStateCode.Disabled;
                    _nextSupplementalStateCode =
                        RuntimeSupplementalStateCode.AnotherModelTypeIsSoloed;
                    return;
                }

                if (PrefabContentTypeOptions.AnySolo)
                {
                    _nextState = RuntimeStateCode.Disabled;
                    _nextSupplementalStateCode =
                        RuntimeSupplementalStateCode.AnotherContentTypeIsSoloed;
                    return;
                }

                if (!renderingSet.modelOptions.typeOptions.options.isEnabled)
                {
                    _nextState = RuntimeStateCode.Disabled;
                    _nextSupplementalStateCode = RuntimeSupplementalStateCode.ModelTypeDisabled;
                    return;
                }

                if (!renderingSet.contentOptions.typeOptions.options.isEnabled)
                {
                    _nextState = RuntimeStateCode.Disabled;
                    _nextSupplementalStateCode = RuntimeSupplementalStateCode.ContentTypeDisabled;
                    return;
                }

                if (!renderingSet.renderingEnabled)
                {
                    _nextState = RuntimeStateCode.Disabled;
                    _nextSupplementalStateCode =
                        RuntimeSupplementalStateCode.PrefabRenderingSetDisabled;
                    return;
                }

                if (renderingSet.useLocations)
                {
                    if ((renderingSet.locations == null) ||
                        (renderingSet.locations.locations == null) ||
                        (renderingSet.locations.locations.Length == 0))
                    {
                        _nextState = RuntimeStateCode.Disabled;
                        _nextSupplementalStateCode = RuntimeSupplementalStateCode.NoLocationsSaved;
                    }
                    else
                    {
                        _nextState = RuntimeStateCode.Enabled;
                        _nextSupplementalStateCode =
                            RuntimeSupplementalStateCode.UsingSavedLocations;
                    }
                }
                else
                {
                    if (renderingSet.ExternalParameters.Count == 0)
                    {
                        _nextState = RuntimeStateCode.Enabled;
                        _nextSupplementalStateCode =
                            RuntimeSupplementalStateCode.NoExternalParameters;
                        return;
                    }

                    _nextState = RuntimeStateCode.Disabled;
                    _nextSupplementalStateCode =
                        RuntimeSupplementalStateCode.ExternalParametersDisabled;

                    for (var parameterIndex = 0;
                        parameterIndex < renderingSet.ExternalParameters.Count;
                        parameterIndex++)
                    {
                        var parameters = renderingSet.ExternalParameters.at[parameterIndex];

                        if (parameters.vegetationItemID == null)
                        {
                            _nextState = RuntimeStateCode.Enabled;
                            _nextSupplementalStateCode = RuntimeSupplementalStateCode
                               .ExternalParametersEnabledByDefault;
                            return;
                        }

                        if (!parameters.veggie.EnableRuntimeSpawn ||
                            !parameters.veggie.EnableExternalRendering)
                        {
                            continue;
                        }

                        _nextState = RuntimeStateCode.Enabled;
                        _nextSupplementalStateCode = RuntimeSupplementalStateCode
                           .ExternalParameterExplicitlyEnabled;
                        return;
                    }
                }
            }
        }

        public JobHandle OnUpdate_Initialize(
            PrefabRenderingSet renderingSet,
            GPUInstancerPrefabManager gpui,
            PrefabLocationSource prefabSource,
            NativeList<float3> referencePoints,
            RuntimeRenderingOptions globalRenderingOptions)
        {
            using (_PRF_OnUpdate_Initialize.Auto())
            {
                if ((renderingSet == null) || !renderingSet.renderingEnabled)
                {
                    return default;
                }

                if (_prefabInstanceRoot == null)
                {
                    _prefabInstanceRoot =
                        PrefabRenderingManager.instance.GetInstanceRootForPrefab(
                            renderingSet.prefab
                        );
                }

                if ((_element != null) && _element.populated)
                {
                    TearDownInstances(gpui, renderingSet.prototypeMetadata);
                }

                ResetExternalParameterCollectionsBeforeExecution(renderingSet);

                var newHandle = OnUpdate_Initialize_Data(
                    renderingSet,
                    prefabSource,
                    referencePoints,
                    globalRenderingOptions
                );

                if (_element.populated)
                {
                    initializationStarted = true;
                }

                return newHandle;
            }
        }

        private JobHandle OnUpdate_Initialize_Data(
            PrefabRenderingSet renderingSet,
            PrefabLocationSource prefabSource,
            NativeList<float3> referencePoints,
            RuntimeRenderingOptions globalRenderingOptions)
        {
            using (_PRF_OnUpdate_Initialize_Data.Auto())
            {
                if (_element == null)
                {
                    _element = new RuntimePrefabRenderingElement();
                }

                _element.Initialize(
                    _adoptedBaseSize,
                    renderingSet.ExternalParameters.Count,
                    false,
                    _prefabInstanceRoot
                );

                if (_temp == null)
                {
                    _temp = new RuntimePrefabRenderingSetTemporary();
                }

                _temp.MakeReady(_adoptedBaseSize, Allocator.Persistent);

                if (!_element.parameterIndices.ShouldAllocate())
                {
                    SafeNative.SafeDispose(ref _element.parameterIndices);
                }

                _element.parameterIndices = new NativeList<int>(Allocator.Persistent);

                int positionOffset;
                int instanceSum;

                if (renderingSet.useLocations)
                {
                    _temp.matrices.CopyFromNBC(renderingSet.locations.locations);

                    instanceSum = _temp.matrices.Length;
                    positionOffset = instanceSum;

                    _element.ResizeUninitialized(_temp.matrices.Length);

                    new InitializeJob_int_NA {input = -1, output = _element.parameterIndices}.Run(
                        _temp.matrices.Length
                    );
                }
                else
                {
                    for (var parameterIndex = 0;
                        parameterIndex < renderingSet.ExternalParameters.Count;
                        parameterIndex++)
                    {
                        var parameters = renderingSet.ExternalParameters.at[parameterIndex];

                        prefabSource.UpdateRuntimeRenderingParameters(
                            parameters,
                            out var packageIndex,
                            out var itemIndex,
                            out _
                        );

                        if (packageIndex == -1)
                        {
                            continue;
                        }

                        if (prefabSource.sourceFromActiveVegetationSystems)
                        {
                            prefabSource.GetMatricesFromVegetationSystem(
                                parameters,
                                packageIndex,
                                itemIndex,
                                _temp.matrices,
                                parameterIndex,
                                _element.parameterIndices
                            );
                        }

                        for (var storagePackageIndex = 0;
                            storagePackageIndex < prefabSource.storagePackages.Count;
                            storagePackageIndex++)
                        {
                            var storagePackage = prefabSource.storagePackages[storagePackageIndex];

                            prefabSource.GetTRSFromVegetationStorage(
                                storagePackage,
                                parameters,
                                _temp.positions,
                                _temp.rotations,
                                _temp.scales,
                                parameterIndex,
                                _element.parameterIndices
                            );
                        }
                    }

                    positionOffset = _temp.matrices.Length;
                    instanceSum = positionOffset + _temp.positions.Length;
                }

                if (instanceSum == 0)
                {
                    return default;
                }

                if (instanceSum > _adoptedBaseSize)
                {
                    _adoptedBaseSize = instanceSum;
                }

                _element.ResizeUninitialized(instanceSum);

                var newHandle = OnUpdate_Initialize_Jobs(
                    renderingSet,
                    globalRenderingOptions,
                    referencePoints,
                    instanceSum,
                    positionOffset
                );

                InstantiateNewInstances(instanceSum);

                _element.populated = true;

                return newHandle;
            }
        }

        private JobHandle OnUpdate_Initialize_Jobs(
            PrefabRenderingSet renderingSet,
            RuntimeRenderingOptions globalRenderingOptions,
            NativeList<float3> referencePoints,
            int instanceSum,
            int positionOffset)
        {
            using (_PRF_OnUpdate_Initialize_Jobs.Auto())
            {
                var handle = new InitializeElementArraysJob
                {
                    matrices_original = _element.matrices_original,
                    matrices_current = _element.matrices_current,
                    matrices_noGameObject_OWNED = _element.matrices_noGameObject_OWNED,
                    matrices_noGameObject_SHARED = _element.matrices_noGameObject_SHARED,
                    positions = _element.positions,
                    rotations = _element.rotations,
                    scales = _element.scales,
                    inFrustums = _element.inFrustums,
                    previousPositions = _element.previousPositions,
                    primaryDistances = _element.primaryDistances,
                    secondaryDistances = _element.secondaryDistances,
                    currentStates = _element.currentStates,
                    pendingStates = _element.nextStates,
                    instancesExcludedFromFrame = _element.instancesExcludedFromFrame,
                    instancesStateCodes = _element.instancesStateCodes.AsDeferredJobArray()

                    //hasForcedStatePending = _element.hasForcedStatePending
                }.Schedule(instanceSum, globalRenderingOptions.execution.updateJobSize);

                handle = new ConvertMatricesJob
                {
                    tempMatrices = _temp.matrices,
                    matrices_current = _element.matrices_current.AsDeferredJobArray(),
                    positions = _element.positions.AsDeferredJobArray(),
                    rotations = _element.rotations.AsDeferredJobArray(),
                    scales = _element.scales.AsDeferredJobArray(),
                    limit = positionOffset
                }.Schedule(instanceSum, globalRenderingOptions.execution.updateJobSize, handle);

                handle = new ConvertTRSJob
                {
                    tempPositions = _temp.positions,
                    tempRotations = _temp.rotations,
                    tempScales = _temp.scales,
                    matrices_current = _element.matrices_current.AsDeferredJobArray(),
                    positions = _element.positions.AsDeferredJobArray(),
                    rotations = _element.rotations.AsDeferredJobArray(),
                    scales = _element.scales.AsDeferredJobArray(),
                    limit = positionOffset
                }.Schedule(instanceSum, globalRenderingOptions.execution.updateJobSize, handle);

                handle = new RecordInitialMatrixStateJob
                {
                    matrices_original = _element.matrices_original.AsDeferredJobArray(),
                    matrices_current = _element.matrices_current.AsDeferredJobArray(),
                    matrices_noGameObject_OWNED =
                        _element.matrices_noGameObject_OWNED.AsDeferredJobArray(),
                    matrices_noGameObject_SHARED =
                        _element.matrices_noGameObject_SHARED.AsDeferredJobArray()
                }.Schedule(instanceSum, globalRenderingOptions.execution.updateJobSize, handle);

                handle = new CalculateDistanceJob
                {
                    currentStates = _element.currentStates.AsDeferredJobArray(),
                    primaryDistances = _element.primaryDistances.AsDeferredJobArray(),
                    secondaryDistances = _element.secondaryDistances.AsDeferredJobArray(),
                    positions = _element.positions.AsDeferredJobArray(),
                    referencePoints = referencePoints,
                    maximumDistance = float.MaxValue,
                    instancesExcludedFromFrame =
                        _element.instancesExcludedFromFrame.AsDeferredJobArray(),
                    instancesStateCodes = _element.instancesStateCodes.AsDeferredJobArray()
                }.Schedule(instanceSum, globalRenderingOptions.execution.updateJobSize, handle);

                if (_element.assetRangeSettings.IsCreated)
                {
                    _element.SafeDispose();
                }

                _element.assetRangeSettings = new NativeList<AssetRangeSettings>(
                    renderingSet.modelOptions.rangeSettings.Length,
                    Allocator.Persistent
                );
                _element.assetRangeSettings.CopyFromNBC(renderingSet.modelOptions.rangeSettings);

                handle = new UpdatePendingStateJob
                {
                    primaryDistances = _element.primaryDistances.AsDeferredJobArray(),
                    secondaryDistances = _element.secondaryDistances.AsDeferredJobArray(),
                    currentStates = _element.currentStates.AsDeferredJobArray(),
                    pendingStates = _element.nextStates.AsDeferredJobArray(),
                    inFrustums = _element.inFrustums.AsDeferredJobArray(),
                    assetRangeSettings = _element.assetRangeSettings,
                    instancesExcludedFromFrame =
                        _element.instancesExcludedFromFrame.AsDeferredJobArray()
                }.Schedule(instanceSum, globalRenderingOptions.execution.updateJobSize, handle);

                return handle;
            }
        }

        public bool OnUpdate_Execute(
            PrefabRenderingSet renderingSet,
            GPUInstancerPrefabManager gpui,
            Camera camera,
            Camera frustumCamera,
            NativeList<float3> referencePoints,
            RuntimeRenderingExecutionOptions executionOptions,
            out JobHandle handle)
        {
            using (_PRF_OnUpdate_Execute.Auto())
            {
                if (!IsExternalStateValidForExecution(renderingSet, gpui))
                {
                    handle = default;
                    return false;
                }

                FrustumPlanesWrapper frustum;

                using (_PRF_OnUpdate_Execute_Frustum.Auto())
                {
                    frustum = renderingSet.modelOptions.typeOptions.GetFrustum(
                        camera,
                        frustumCamera
                    );
                }

                ResetExternalParameterCollectionsBeforeExecution(renderingSet);

                handle = OnUpdate_Execute_Jobs(
                    renderingSet,
                    referencePoints,
                    frustum.planes,
                    executionOptions
                );

                return true;
            }
        }

        private JobHandle OnUpdate_Execute_Jobs(
            PrefabRenderingSet renderingSet,
            NativeList<float3> referencePoints,
            FrustumPlanesBurst frustumPlanes,
            RuntimeRenderingExecutionOptions executionOptions)
        {
            using (_PRF_OnUpdate_Execute_Jobs.Auto())
            {
                using (_PRF_OnUpdate_Execute_Jobs_Prepare.Auto())
                {
                    if ((_element.instances == null) || (_element.instances.Length == 0))
                    {
                        return default;
                    }

                    _element.matrices_noGameObject_SHARED =
                        _element.gpuInstancerRuntimeData_NoGO.instanceDataArray;

                    if (_element.instances.Length !=
                        _element.gpuInstancerRuntimeData_NoGO.instanceCount)
                    {
                        throw new NotSupportedException("Instance count does not match!");
                    }
                }

                using (_PRF_OnUpdate_Execute_Jobs_CopySettings.Auto())
                {
                    _element.assetRangeSettings.CopyFromNBC(
                        renderingSet.modelOptions.rangeSettings
                    );
                }

                JobHandle handle = default;

                if (_transferOriginalToCurrent)
                {
                    using (_PRF_OnUpdate_Execute_Jobs_HandleTransfer.Auto())
                    {
                        handle = new TransferOriginalMatricesToCurrentJob
                        {
                            matrices_current = _element.matrices_current,
                            matrices_original = _element.matrices_original,
                            matrices_noGameObject_OWNED = _element.matrices_noGameObject_OWNED
                        }.Schedule(
                            _element.instances.Length,
                            executionOptions.updateJobSize,
                            handle
                        );

                        _transferOriginalToCurrent = false;
                    }
                }

                if (_nextState == RuntimeStateCode.Enabled)
                {
                    using (_PRF_OnUpdate_Execute_Jobs_HandleEnabled.Auto())
                    {
                        handle = new ResetStateChecksJob
                        {
                            //hasForcedStatePending = _element.hasForcedStatePending,
                            instancesExcludedFromFrame = _element.instancesExcludedFromFrame,
                            instancesStateCodes = _element.instancesStateCodes.AsDeferredJobArray(),
                            inFrustums = _element.inFrustums
                        }.Schedule(
                            _element.instances.Length,
                            executionOptions.updateJobSize,
                            handle
                        );

                        handle = new UnifyTransformArraysJob
                        {
                            matrices_current = _element.matrices_current.AsDeferredJobArray(),
                            positions = _element.positions,
                            previousPositions = _element.previousPositions,
                            rotations = _element.rotations,
                            scales = _element.scales
                        }.Schedule(
                            _element.instances.Length,
                            executionOptions.updateJobSize,
                            handle
                        );

                        handle = new CalculateDistanceJob
                        {
                            currentStates = _element.currentStates,
                            primaryDistances = _element.primaryDistances,
                            secondaryDistances = _element.secondaryDistances,
                            positions = _element.positions.AsDeferredJobArray(),
                            referencePoints = referencePoints,
                            maximumDistance =
                                renderingSet.modelOptions.maximumStateChangeDistance * 1.1f,
                            instancesExcludedFromFrame =
                                _element.instancesExcludedFromFrame.AsDeferredJobArray(),
                            instancesStateCodes =
                                _element.instancesStateCodes.AsDeferredJobArray()
                        }.Schedule(
                            _element.instances.Length,
                            executionOptions.updateJobSize,
                            handle
                        );

                        handle = new CalculateFrustumInclusionJob
                        {
                            positions = _element.positions.AsDeferredJobArray(),
                            scales = _element.scales.AsDeferredJobArray(),
                            instancesExcludedFromFrame =
                                _element.instancesExcludedFromFrame.AsDeferredJobArray(),
                            frustum = frustumPlanes,
                            objectBounds = new BoundsBurst(renderingSet.bounds),
                            inFrustums = _element.inFrustums.AsDeferredJobArray(),
                            instancesStateCodes =
                                _element.instancesStateCodes.AsDeferredJobArray()
                        }.Schedule(
                            _element.instances.Length,
                            executionOptions.updateJobSize,
                            handle
                        );

                        handle = new UpdatePendingStateJob
                        {
                            currentStates = _element.currentStates,
                            instancesExcludedFromFrame =
                                _element.instancesExcludedFromFrame.AsDeferredJobArray(),
                            assetRangeSettings = element.assetRangeSettings,
                            pendingStates = _element.nextStates,
                            primaryDistances = _element.primaryDistances.AsDeferredJobArray(),
                            secondaryDistances =
                                _element.secondaryDistances.AsDeferredJobArray(),
                            inFrustums = _element.inFrustums.AsDeferredJobArray(),
                            stateChanging = StateChanging
                        }.Schedule(
                            _element.instances.Length,
                            executionOptions.updateJobSize,
                            handle
                        );
                    }
                }
                else if (_currentState == RuntimeStateCode.Enabled)
                {
                    using (_PRF_OnUpdate_Execute_Jobs_HandleDisabled.Auto())
                    {
                        handle = new DisableAllJob
                        {
                            instancesExcludedFromFrame =
                                _element.instancesExcludedFromFrame.AsDeferredJobArray(),
                            instancesStateCodes =
                                _element.instancesStateCodes.AsDeferredJobArray(),
                            matrices_noGameObject_OWNED =
                                _element.matrices_noGameObject_OWNED.AsDeferredJobArray(),
                            pendingStates = _element.nextStates
                        }.Schedule(
                            _element.instances.Length,
                            executionOptions.updateJobSize,
                            handle
                        );
                    }
                }

                using (_PRF_OnUpdate_Execute_Jobs_HandleCounts.Auto())
                {
                    handle = new CountStatesJob
                    {
                        currentStates = _element.currentStates, counts = _element._stateCounts
                    }.Schedule(handle);
                }

                return handle;
            }
        }

        public void OnLateUpdate_Initialize(
            PrefabRenderingSet renderingSet,
            GPUInstancerPrefabManager gpui)
        {
            using (_PRF_OnLateUpdate_Initialize.Auto())
            {
                using (_PRF_OnLateUpdate_Initialize_InitializeNative.Auto())
                {
                    GPUInstancerAPI.InitializeWithNativeList(
                        gpui,
                        renderingSet.prototypeMetadata.prototype,
                        _element.matrices_noGameObject_SHARED
                    );
                }

                _element.gpuInstancerRuntimeData_NoGO = gpui.GetRuntimeData(
                    renderingSet.prototypeMetadata.prototype,
                    true
                );

#if UNITY_EDITOR
                if (!renderingSet.useLocations && renderingSet.modelOptions.burialOptions.buryMesh)
                {
                    //MeshBurialManagementProcessor.EnqueuePrefabRenderingSet(renderingSet);
                }
#endif

                _temp.SafeDispose();

                initializationCompleted = true;
            }
        }

        public bool OnLateUpdate_Execute(
            PrefabRenderingSet renderingSet,
            GlobalRenderingOptions globalOptions,
            RuntimeRenderingExecutionOptions executionOptions)
        {
            using (_PRF_OnLateUpdate_Execute.Auto())
            {
                using (_PRF_OnLateUpdate_Execute_CheckDisabled.Auto())
                {
                    if (!_element.populated ||
                        (_element.instances == null) ||
                        (_element.instances.Length == 0))
                    {
                        return true;
                    }

                    var staleDisabled = (_previousState == RuntimeStateCode.Disabled) &&
                                        (_currentState == RuntimeStateCode.Disabled);

                    if (staleDisabled && (_realActiveInstances == 0))
                    {
                        element.gpuInstancerRuntimeData_NoGO.activeCount = 0;
                        return true;
                    }
                }

                var errorCount = 0;

                using (_PRF_OnLateUpdate_Execute_Processing.Auto())
                {
                    gpuMatrixPushPending = StateChanged || StateChanging;

                    for (var i = 0; i < _element.instances.Length; i++)
                    {
                        PrefabRenderingInstance instance;

                        using (_PRF_OnLateUpdate_Execute_GetInstanceAndState.Auto())
                        {
                            instance = _element.instances[i];

                            if (instance == null)
                            {
                                continue;
                            }

                            var currentStates = _element.currentStates[i];
                            var nextStates = _element.nextStates[i];

                            if (!instance.delayed &&
                                !StateChanging &&
                                !StateChanged &&
                                (currentStates == nextStates))
                            {
                                if (_element.instancesExcludedFromFrame[i] && !instance.alive)
                                {
                                    continue;
                                }
                            }
                        }

                        var instancePushGpuiMatrices = false;

                        var appliedSuccessfully = _currentState == RuntimeStateCode.Enabled
                            ? instance.ApplyNewInstanceState(
                                _prefabInstanceRoot,
                                _element,
                                renderingSet,
                                globalOptions,
                                renderingSet.modelOptions.normalLighting,
                                renderingSet.prototypeMetadata,
                                out instancePushGpuiMatrices
                            )
                            : instance.ApplyNewInstanceState(
                                _prefabInstanceRoot,
                                _element,
                                renderingSet,
                                globalOptions,
                                renderingSet.modelOptions.normalLighting,
                                renderingSet.prototypeMetadata,
                                InstanceState.Disabled,
                                out _
                            );

                        gpuMatrixPushPending = gpuMatrixPushPending || instancePushGpuiMatrices;

                        using (_PRF_OnLateUpdate_Execute_CheckErrors.Auto())
                        {
                            if (!appliedSuccessfully)
                            {
                                errorCount += 1;
                            }

                            if (errorCount >= 10)
                            {
                                Debug.LogError(
                                    $"Skipping instancing validation for {renderingSet.prefab.name} as it reached the error limit of {errorCount}."
                                );

                                break;
                            }
                        }
                    }
                }

                using (_PRF_OnLateUpdate_Execute_FinalErrorCheck.Auto())
                {
                    if (errorCount >= 10)
                    {
                        return false;
                    }
                }

                if (gpuMatrixPushPending)
                {
                    using (_PRF_OnLateUpdate_Execute_GPUMatrixPush.Auto())
                    {
                        var handle1 = new TransferJob_Matrix4x4_NA_Matrix4x4_NA
                        {
                            input = element.matrices_noGameObject_OWNED,
                            output = element.matrices_noGameObject_SHARED
                        }.Schedule(element.Count, executionOptions.updateJobSize);

                        var handle2 = new CountStatesJob
                        {
                            currentStates = _element.currentStates,
                            counts = _element._stateCounts
                        }.Schedule();

                        var joinedHandle = JobHandle.CombineDependencies(handle1, handle2);

                        JobTracker.Track(
                            PrefabRenderingJobKeys._PRSIM_LATEUPDATE_PUSHMATRICES,
                            joinedHandle
                        );
                    }
                }
                else
                {
                    using (_PRF_OnLateUpdate_Execute_SetCounts.Auto())
                    {
                        var counts = element.stateCounts.rendering;
                        _realActiveInstances =
                            counts.gpuInstancingCount + counts.meshRenderingCount;
                    }
                }

                return true;
            }
        }

        public void PushAllGPUMatrices()
        {
            using (_PRF_PushAllGPUMatrices.Auto())
            {
                gpuMatrixPushPending = false;

                var counts = element.stateCounts.rendering;
                _realActiveInstances = counts.gpuInstancingCount + counts.meshRenderingCount;

                element.gpuInstancerRuntimeData_NoGO.activeCount =
                    element.stateCounts.rendering.gpuInstancingCount;

                element.gpuInstancerRuntimeData_NoGO.transformationMatrixVisibilityBuffer.SetData(
                    element.gpuInstancerRuntimeData_NoGO.instanceDataArray.AsArray()
                );
            }
        }

        public void TearDownInstances(
            GPUInstancerPrefabManager gpui,
            GPUInstancerPrototypeMetadata prototypeMetadata)
        {
            using (_PRF_TearDownInstances.Auto())
            {
                var teardownNogo = !gpui.RequiresRuntimeInitialization(prototypeMetadata.prototype);

                var nogoProto = prototypeMetadata.prototype;

                if (teardownNogo)
                {
                    gpui.RemovePrefabInstances(nogoProto);
                }

                if ((_element == null) ||
                    !_element.populated ||
                    (_element.instances == null) ||
                    (_element.gpuInstancerRuntimeData_NoGO == null))
                {
                    return;
                }

                using (_PRF_TearDownInstances_UpdateInstancesAndPush.Auto())
                {
                    if (teardownNogo)
                    {
                        var pushGPUI = false;

                        for (var instanceIndex = 0;
                            instanceIndex < _element.instances.Length;
                            instanceIndex++)
                        {
                            var instance = _element.instances[instanceIndex];

                            if (instance == null)
                            {
                                continue;
                            }

                            var currentState = _element.currentStates[instanceIndex];

                            if (currentState.rendering == InstanceRenderingState.GPUInstancing)
                            {
                                instance.Teardown(_element);
                                pushGPUI = true;
                            }
                        }

                        if (pushGPUI && !element.gpuInstancerRuntimeData_NoGO.IsDisposed)
                        {
                            element.gpuInstancerRuntimeData_NoGO
                                   .transformationMatrixVisibilityBuffer.SetData(
                                        element.gpuInstancerRuntimeData_NoGO.instanceDataArray
                                               .AsArray()
                                    );
                        }
                    }
                }

                Dispose();

                initializationStarted = false;
                initializationCompleted = false;
                gpuiInitialized = false;
            }
        }
    }
}
