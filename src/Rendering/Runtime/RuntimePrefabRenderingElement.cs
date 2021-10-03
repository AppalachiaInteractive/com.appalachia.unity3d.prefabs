#region

using System;
using Appalachia.Core.AssetMetadata.Options.ModelType.Instancing;
using Appalachia.Core.Behaviours;
using Appalachia.Core.Collections.Native;
using Appalachia.Core.Extensions;
using Appalachia.Core.Pooling.Objects;
using Appalachia.Core.Rendering.States;
using GPUInstancer;
using Unity.Collections;
using Unity.Mathematics;
using Unity.Profiling;
using UnityEngine;
using Object = UnityEngine.Object;

#endregion

namespace Appalachia.Core.Rendering.Runtime
{
    public class RuntimePrefabRenderingElement : InternalBase<RuntimePrefabRenderingElement>, IDisposable
    {
        private const string _PRF_PFX = nameof(RuntimePrefabRenderingElement) + ".";
        
        public const int _INITIAL_INSTANCE_CAPACITY = 128;
        public const int _INITIAL_ACTIVE_CAPACITY = 128;

        public bool populated;

        public NativeList<float4x4> matrices_original;
        public NativeList<float4x4> matrices_current;
        public NativeList<Matrix4x4> matrices_noGameObject_OWNED;  // shared with GPUI
        public NativeList<Matrix4x4> matrices_noGameObject_SHARED; // shared with GPUI
        public NativeList<float3> positions;
        public NativeList<quaternion> rotations;
        public NativeList<float3> scales;
        public NativeList<bool> inFrustums;

        public NativeList<float3> previousPositions;
        public NativeList<float> primaryDistances;
        public NativeList<float> secondaryDistances;

        public NativeList<InstanceState> currentStates;
        public NativeList<InstanceState> nextStates;

        public NativeList<bool> hasChangedPositions;

        public NativeList<int> parameterIndices;

        public NativeList<bool> instancesExcludedFromFrame;
        public NativeList<InstanceStateCode> instancesStateCodes;

        public NativeList<AssetRangeSettings> assetRangeSettings;
        public NativeArray<InstanceStateCounts> _stateCounts;

        public GPUInstancerRuntimeData gpuInstancerRuntimeData_NoGO;
        public PrefabRenderingInstance[] instances;

        public GameObject prototypeTemplate;
        public ObjectPool<GameObject> prefabPool;
        public InstanceStateCounts stateCounts => _stateCounts.IsSafe() ? _stateCounts[0] : default;

        public int Count => instances?.Length ?? 0;

        private static readonly ProfilerMarker _PRF_Dispose = new ProfilerMarker(_PRF_PFX + nameof(Dispose));
        public void Dispose()
        {
            using (_PRF_Dispose.Auto())
            {
                SafeNative.SafeDispose(
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

                        SafeNative.SafeDispose(ref instance);
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

        private static readonly ProfilerMarker _PRF_Initialize = new ProfilerMarker(_PRF_PFX + nameof(Initialize));
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

        private static readonly ProfilerMarker _PRF_ResizeUninitialized = new ProfilerMarker(_PRF_PFX + nameof(ResizeUninitialized));
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
    }
}
