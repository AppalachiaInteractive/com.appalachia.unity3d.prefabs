#region

using System;
using Appalachia.Core.Collections.Native;
using Appalachia.Core.Objects.Root;
using Appalachia.Rendering.Prefabs.Core.States;
using Appalachia.Rendering.Prefabs.Rendering.ModelType.Instancing;
using Appalachia.Utility.Extensions;
using Appalachia.Utility.Pooling.Objects;
using GPUInstancer;
using Unity.Collections;
using Unity.Mathematics;
using Unity.Profiling;
using UnityEngine;
using Object = UnityEngine.Object;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Runtime
{
    [Serializable]
    public class RuntimePrefabRenderingElement : AppalachiaSimpleBase, IDisposable
    {
        #region Constants and Static Readonly

        public const int _INITIAL_ACTIVE_CAPACITY = 128;

        public const int _INITIAL_INSTANCE_CAPACITY = 128;

        #endregion

        #region Fields and Autoproperties

        public NativeArray<InstanceStateCounts> _stateCounts;

        public NativeList<AssetRangeSettings> assetRangeSettings;

        public NativeList<InstanceState> currentStates;

        public GPUInstancerRuntimeData gpuInstancerRuntimeData_NoGO;

        public NativeList<bool> hasChangedPositions;
        public NativeList<bool> inFrustums;
        public PrefabRenderingInstance[] instances;

        public NativeList<bool> instancesExcludedFromFrame;
        public NativeList<InstanceStateCode> instancesStateCodes;
        public NativeList<float4x4> matrices_current;
        public NativeList<Matrix4x4> matrices_noGameObject_OWNED;  // shared with GPUI
        public NativeList<Matrix4x4> matrices_noGameObject_SHARED; // shared with GPUI

        public NativeList<float4x4> matrices_original;
        public NativeList<InstanceState> nextStates;

        public NativeList<int> parameterIndices;

        public bool populated;
        public NativeList<float3> positions;
        public ObjectPool<GameObject> prefabPool;

        public NativeList<float3> previousPositions;
        public NativeList<float> primaryDistances;

        public GameObject prototypeTemplate;
        public NativeList<quaternion> rotations;
        public NativeList<float3> scales;
        public NativeList<float> secondaryDistances;

        #endregion

        public InstanceStateCounts stateCounts => _stateCounts.IsSafe() ? _stateCounts[0] : default;

        public int Count => instances?.Length ?? 0;

        public void Initialize(int size, int parameterSize, bool force, GameObject root)
        {
            using (_PRF_Initialize.Auto())
            {
                if (force)
                {
                    Dispose();
                }

                if ((prefabPool == null) || prefabPool.IsDisposed)
                {
                    prefabPool = ObjectPoolProvider.CreatePrefabPool(
                        () => Object.Instantiate(prototypeTemplate, root.transform),
                        HideFlags.HideAndDontSave,
                        HideFlags.HideInHierarchy
                    );
                }

                if (matrices_original.ShouldAllocate())
                {
                    matrices_original = new NativeList<float4x4>(size, Allocator.Persistent);
                }

                if (matrices_current.ShouldAllocate())
                {
                    matrices_current = new NativeList<float4x4>(size, Allocator.Persistent);
                }

                if (matrices_noGameObject_OWNED.ShouldAllocate())
                {
                    matrices_noGameObject_OWNED = new NativeList<Matrix4x4>(size, Allocator.Persistent);
                }

                if (matrices_noGameObject_SHARED.ShouldAllocate())
                {
                    matrices_noGameObject_SHARED = new NativeList<Matrix4x4>(size, Allocator.Persistent);
                }

                if (positions.ShouldAllocate())
                {
                    positions = new NativeList<float3>(size, Allocator.Persistent);
                }

                if (rotations.ShouldAllocate())
                {
                    rotations = new NativeList<quaternion>(size, Allocator.Persistent);
                }

                if (scales.ShouldAllocate())
                {
                    scales = new NativeList<float3>(size, Allocator.Persistent);
                }

                if (inFrustums.ShouldAllocate())
                {
                    inFrustums = new NativeList<bool>(size, Allocator.Persistent);
                }

                if (previousPositions.ShouldAllocate())
                {
                    previousPositions = new NativeList<float3>(size, Allocator.Persistent);
                }

                if (primaryDistances.ShouldAllocate())
                {
                    primaryDistances = new NativeList<float>(size, Allocator.Persistent);
                }

                if (secondaryDistances.ShouldAllocate())
                {
                    secondaryDistances = new NativeList<float>(size, Allocator.Persistent);
                }

                if (currentStates.ShouldAllocate())
                {
                    currentStates = new NativeList<InstanceState>(size, Allocator.Persistent);
                }

                if (nextStates.ShouldAllocate())
                {
                    nextStates = new NativeList<InstanceState>(size, Allocator.Persistent);
                }

                if (hasChangedPositions.ShouldAllocate())
                {
                    hasChangedPositions = new NativeList<bool>(size, Allocator.Persistent);
                }

                if (parameterIndices.ShouldAllocate())
                {
                    parameterIndices = new NativeList<int>(parameterSize, Allocator.Persistent);
                }

                if (instancesExcludedFromFrame.ShouldAllocate())
                {
                    instancesExcludedFromFrame = new NativeList<bool>(size, Allocator.Persistent);
                }

                if (instancesStateCodes.ShouldAllocate())
                {
                    instancesStateCodes = new NativeList<InstanceStateCode>(size, Allocator.Persistent);
                }

                if (_stateCounts.ShouldAllocate())
                {
                    _stateCounts = new NativeArray<InstanceStateCounts>(1, Allocator.Persistent);
                }
            }
        }

        public void ResizeUninitialized(int length)
        {
            using (_PRF_ResizeUninitialized.Auto())
            {
                matrices_original.ResizeUninitialized(length);
                matrices_current.ResizeUninitialized(length);
                matrices_noGameObject_OWNED.ResizeUninitialized(length);
                matrices_noGameObject_SHARED.ResizeUninitialized(length);
                positions.ResizeUninitialized(length);
                rotations.ResizeUninitialized(length);
                scales.ResizeUninitialized(length);
                inFrustums.ResizeUninitialized(length);
                previousPositions.ResizeUninitialized(length);
                primaryDistances.ResizeUninitialized(length);
                secondaryDistances.ResizeUninitialized(length);
                currentStates.ResizeUninitialized(length);
                nextStates.ResizeUninitialized(length);
                hasChangedPositions.ResizeUninitialized(length);
                parameterIndices.ResizeUninitialized(length);
                instancesExcludedFromFrame.ResizeUninitialized(length);
                instancesStateCodes.ResizeUninitialized(length);
            }
        }

        #region IDisposable Members

        public void Dispose()
        {
            using (_PRF_Dispose.Auto())
            {
                IDisposableExtensions.SafeDispose(
                    ref matrices_original,
                    ref matrices_current,
                    ref matrices_noGameObject_OWNED,
                    ref matrices_noGameObject_SHARED,
                    ref positions,
                    ref rotations,
                    ref scales,
                    ref inFrustums,
                    ref previousPositions,
                    ref primaryDistances,
                    ref secondaryDistances,
                    ref currentStates,
                    ref nextStates,
                    ref hasChangedPositions,
                    ref parameterIndices,
                    ref instancesExcludedFromFrame,
                    ref instancesStateCodes,
                    ref _stateCounts,
                    ref assetRangeSettings,
                    ref prefabPool
                );

                if (!gpuInstancerRuntimeData_NoGO?.IsDisposed ?? false)
                {
                    gpuInstancerRuntimeData_NoGO?.Dispose();
                }

                if (instances != null)
                {
                    for (var i = 0; i < instances.Length; i++)
                    {
                        var instance = instances[i];

                        IDisposableExtensions.SafeDispose(ref instance);
                    }
                }

                instances = null;

                if (prototypeTemplate != null)
                {
                    prototypeTemplate.DestroySafely();
                }

                prototypeTemplate = null;
            }
        }

        #endregion

        #region Profiling

        private const string _PRF_PFX = nameof(RuntimePrefabRenderingElement) + ".";

        private static readonly ProfilerMarker _PRF_Dispose = new(_PRF_PFX + nameof(Dispose));

        private static readonly ProfilerMarker _PRF_Initialize = new(_PRF_PFX + nameof(Initialize));

        private static readonly ProfilerMarker _PRF_ResizeUninitialized =
            new(_PRF_PFX + nameof(ResizeUninitialized));

        #endregion
    }
}
