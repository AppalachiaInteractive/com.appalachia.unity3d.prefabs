#region

using System;
using Appalachia.Core.Attributes.Editing;
using Appalachia.Core.Behaviours;
using Appalachia.Core.Extensions;
using Appalachia.Core.Filtering;
using Appalachia.Core.Labels;
using Appalachia.Core.Layers;
using Appalachia.Core.Layers.Extensions;
using Appalachia.Core.ObjectPooling;
using Appalachia.Rendering.Prefabs.Core.States;
using Appalachia.Rendering.Prefabs.Rendering.GPUI;
using Appalachia.Rendering.Prefabs.Rendering.ModelType.Rendering;
using Appalachia.Rendering.Prefabs.Rendering.Options.Rendering;
using Appalachia.Utility.Extensions;
using Appalachia.Utility.Logging;
using Sirenix.OdinInspector;
using Unity.Mathematics;
using Unity.Profiling;
using UnityEngine;
using Object = UnityEngine.Object;

// ReSharper disable PossiblyImpureMethodCallOnReadonlyVariable

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Runtime
{
    [Serializable]
    public class PrefabRenderingInstance : AppalachiaBase, IDisposable
    {
        private const string _PRF_PFX = nameof(PrefabRenderingInstance) + ".";

        private static readonly Matrix4x4 _matrix_zero = Matrix4x4.zero;

        private static readonly Matrix4x4 _matrix_trs_zero = Matrix4x4.TRS(
            Vector3.zero,
            Quaternion.identity,
            Vector3.one
        );

        private static readonly ProfilerMarker _PRF_CreatePrefabPool =
            new(_PRF_PFX + nameof(CreatePrefabPool));

        private static readonly ProfilerMarker _PRF_CreateModelInstance =
            new(_PRF_PFX + nameof(CreateModelInstance));

        /*[ReadOnly, SerializeField, SmartLabel(AlignWith = nameof(matrix_noGameObject_OWNED))]
        public float4x4 matrix_original;

        [ReadOnly, SerializeField, SmartLabel(AlignWith = nameof(matrix_noGameObject_OWNED))]
        public float4x4 matrix_current;

        [ReadOnly, SerializeField, SmartLabel]
        public Matrix4x4 matrix_noGameObject_OWNED;*/

        [ReadOnly]
        [SerializeField]
        [SmartLabel]
        [ToggleLeft]
        public bool inFrustum;

        [ReadOnly]
        [SerializeField]
        [SmartLabel]
        public float3 previousPosition;

        [ReadOnly]
        [SerializeField]
        [SmartLabel]
        public float primaryDistance;

        [ReadOnly]
        [SerializeField]
        [SmartLabel]
        public float secondaryDistance;

        [ReadOnly]
        [SerializeField]
        [InlineProperty]
        [SmartLabel]
        public InstanceState previousState;

        [ReadOnly]
        [SerializeField]
        [InlineProperty]
        [SmartLabel(AlignWith = nameof(previousState))]
        public InstanceState currentState;

        [ReadOnly]
        [SerializeField]
        [InlineProperty]
        [SmartLabel(AlignWith = nameof(previousState))]
        public InstanceState nextState;

        [ReadOnly]
        [SerializeField]
        [SmartLabel]
        [ToggleLeft]
        public bool hasChangedPosition;

        [ReadOnly]
        [SerializeField]
        [SmartLabel]
        public int parameterIndex;

        [ReadOnly]
        [SerializeField]
        [SmartLabel]
        [ToggleLeft]
        public bool instancesExcludedFromFrame;

        [ReadOnly]
        [SerializeField]
        [SmartLabel]
        public InstanceStateCode instancesStateCode;

        [ReadOnly]
        [SerializeField]
        [SmartLabel]
        [ToggleLeft]
        public bool delayed;

        [ReadOnly]
        [NonSerialized]
        [ShowInInspector]
        public readonly int instanceIndex;

        [ReadOnly]
        [NonSerialized]
        [ShowInInspector]
        public Collider firstInteractionCollider;

        [ReadOnly]
        [NonSerialized]
        [ShowInInspector]
        public Collider firstPhysicsCollider;

        [ReadOnly]
        [NonSerialized]
        public PrefabRenderingInstanceBehaviour instanceBehaviour;

        [ReadOnly]
        [NonSerialized]
        [ShowInInspector]
        public Collider[] interactionColliders;

        [ReadOnly]
        [NonSerialized]
        [ShowInInspector]
        public LODGroup lodGroup;

        [ReadOnly]
        [NonSerialized]
        [ShowInInspector]
        public Collider[] physicsColliders;

        [ReadOnly]
        [NonSerialized]
        [ShowInInspector]
        public Renderer[] renderers;

        [ReadOnly]
        [NonSerialized]
        [ShowInInspector]
        public Rigidbody rigidbody;

        [ReadOnly]
        [NonSerialized]
        [ShowInInspector]
        public Transform transform;

        public PrefabRenderingInstance(int index)
        {
            instanceIndex = index;
        }

        public bool alive => transform != null;

        public void Dispose()
        {
            using (_PRF_Dispose.Auto())
            {
                transform.DestroySafely();

                transform = null;
                instanceBehaviour = null;
                renderers = null;
                physicsColliders = null;
                interactionColliders = null;
                firstPhysicsCollider = null;
                firstInteractionCollider = null;
                lodGroup = null;
                rigidbody = null;
            }
        }

        private void AssignElementProperties(RuntimePrefabRenderingElement element)
        {
            using (_PRF_AssignElementProperties.Auto())
            {
                //matrix_original = element.matrices_original[instanceIndex];
                //matrix_current = element.matrices_current[instanceIndex];
                //matrix_noGameObject_OWNED = element.matrices_noGameObject_OWNED[instanceIndex];
                inFrustum = element.inFrustums[instanceIndex];
                previousPosition = element.previousPositions[instanceIndex];
                primaryDistance = element.primaryDistances[instanceIndex];
                secondaryDistance = element.secondaryDistances[instanceIndex];
                previousState = currentState;
                currentState = element.currentStates[instanceIndex];
                nextState = element.nextStates[instanceIndex];
                hasChangedPosition = element.hasChangedPositions[instanceIndex];
                parameterIndex = element.parameterIndices[instanceIndex];
                instancesExcludedFromFrame = element.instancesExcludedFromFrame[instanceIndex];
                instancesStateCode = element.instancesStateCodes[instanceIndex];
            }
        }

        public bool ApplyNewInstanceState(
            GameObject prefabInstanceRoot,
            RuntimePrefabRenderingElement element,
            PrefabRenderingSet renderingSet,
            GlobalRenderingOptions globalOptions,
            AssetLightingSettings normalLighting,
            GPUInstancerPrototypeMetadata metadata,
            out bool pushGpuiMatrices)
        {
            using (_PRF_ApplyNewInstanceState.Auto())
            {
                return ApplyNewInstanceState(
                    prefabInstanceRoot,
                    element,
                    renderingSet,
                    globalOptions,
                    normalLighting,
                    metadata,
                    default,
                    out pushGpuiMatrices
                );
            }
        }

        public bool ApplyNewInstanceState(
            GameObject prefabInstanceRoot,
            RuntimePrefabRenderingElement element,
            PrefabRenderingSet renderingSet,
            GlobalRenderingOptions globalOptions,
            AssetLightingSettings normalLighting,
            GPUInstancerPrototypeMetadata metadata,
            InstanceState forcedNext,
            out bool pushGpuiMatrices)
        {
            using (_PRF_ApplyNewInstanceState.Auto())
            {
                bool allowStateChange;

                try
                {
                    AssignElementProperties(element);

                    if (forcedNext != default)
                    {
                        nextState = forcedNext;
                    }

                    pushGpuiMatrices = false;

                    //CheckObjectTrackers(element);

                    ApplyStateChange(
                        prefabInstanceRoot,
                        element,
                        renderingSet,
                        globalOptions,
                        normalLighting,
                        metadata,
                        out allowStateChange,
                        out pushGpuiMatrices
                    );

                    if (allowStateChange)
                    {
                        element.currentStates[instanceIndex] = nextState;
                    }

                    return true;
                }
                catch (Exception ex)
                {
                    var name = metadata.prototype.prefabObject.name;
                    
                    AppaLog.Error($"Error moving [{name}] from [{currentState}] to [{nextState}]"                    );
                    Debug.LogException(ex);

                    pushGpuiMatrices = false;
                    return false;
                }
            }
        }

        private void ApplyStateChange(
            GameObject prefabInstanceRoot,
            RuntimePrefabRenderingElement element,
            PrefabRenderingSet renderingSet,
            GlobalRenderingOptions globalOptions,
            AssetLightingSettings normalLighting,
            GPUInstancerPrototypeMetadata metadata,
            out bool allowStateChange,
            out bool pushGpuiMatrices)
        {
            using (_PRF_ApplyStateChange.Auto())
            {
                var curr = currentState;
                var next = nextState;

                allowStateChange = true;
                pushGpuiMatrices = false;
                delayed = false;

                if ((previousState == curr) && (curr == next))
                {
                    return;
                }

                if (ShouldDelayStateChange())
                {
                    element.instancesStateCodes[instanceIndex] = instancesStateCode;
                    delayed = true;
                    allowStateChange = false;
                    return;
                }

                var curr_physx = curr.physics == InstancePhysicsState.Enabled
                    ? State.Enabled
                    : State.Disabled;
                var curr_inter = curr.interaction == InstanceInteractionState.Enabled
                    ? State.Enabled
                    : State.Disabled;
                var curr_rendr = curr.rendering != InstanceRenderingState.Disabled
                    ? State.Enabled
                    : State.Disabled;
                var curr_meshR = curr.rendering == InstanceRenderingState.MeshRenderers
                    ? State.Enabled
                    : State.Disabled;
                var curr_gpuiR = curr.rendering == InstanceRenderingState.GPUInstancing
                    ? State.Enabled
                    : State.Disabled;

                curr_physx =
                    curr_physx.on() ||
                    ((firstPhysicsCollider != null) && firstPhysicsCollider.enabled)
                        ? State.Enabled
                        : State.Disabled;
                curr_inter =
                    curr_inter.on() ||
                    (rigidbody != null) ||
                    ((firstInteractionCollider != null) && firstInteractionCollider.enabled)
                        ? State.Enabled
                        : State.Disabled;
                curr_rendr = curr_rendr.on() || ((lodGroup != null) && lodGroup.enabled)
                    ? State.Enabled
                    : State.Disabled;
                curr_meshR = curr_meshR.on() || ((lodGroup != null) && lodGroup.enabled)
                    ? State.Enabled
                    : State.Disabled;

                var next_physx = next.physics == InstancePhysicsState.Enabled
                    ? State.Enabled
                    : State.Disabled;
                var next_inter = next.interaction == InstanceInteractionState.Enabled
                    ? State.Enabled
                    : State.Disabled;
                var next_rendr = next.rendering != InstanceRenderingState.Disabled
                    ? State.Enabled
                    : State.Disabled;
                var next_meshR = next.rendering == InstanceRenderingState.MeshRenderers
                    ? State.Enabled
                    : State.Disabled;
                var next_gpuiR = next.rendering == InstanceRenderingState.GPUInstancing
                    ? State.Enabled
                    : State.Disabled;

                var change_physx = curr_physx.on()
                    ? next_physx.on()
                        ? StateChange.Ignore
                        : StateChange.Disable
                    : next_physx.on()
                        ? StateChange.Enable
                        : StateChange.Ignore;

                var change_inter = curr_inter.on()
                    ? next_inter.on()
                        ? StateChange.Ignore
                        : StateChange.Disable
                    : next_inter.on()
                        ? StateChange.Enable
                        : StateChange.Ignore;

                var change_rendr = curr_rendr.on()
                    ? next_rendr.on()
                        ? StateChange.Ignore
                        : StateChange.Disable
                    : next_rendr.on()
                        ? StateChange.Enable
                        : StateChange.Ignore;

                var change_meshR = curr_meshR.on()
                    ? next_meshR.on()
                        ? StateChange.Ignore
                        : StateChange.Disable
                    : next_meshR.on()
                        ? StateChange.Enable
                        : StateChange.Ignore;

                var change_gpuiR = curr_gpuiR.on()
                    ? next_gpuiR.on()
                        ? StateChange.Ignore
                        : StateChange.Disable
                    : next_gpuiR.on()
                        ? StateChange.Enable
                        : StateChange.Ignore;

                var instantiated = transform != null;

                var shouldInstantiate = !instantiated &&
                                        (change_physx.turnOn() ||
                                         change_inter.turnOn() ||
                                         change_rendr.turnOn());

                if (shouldInstantiate)
                {
                    Instantiate(renderingSet, element, metadata, prefabInstanceRoot);
                    InitializePhysics();
                    InitializeInteractions();
                    InitializeRendering();
                }

                if (change_physx.changing())
                {
                    if (!shouldInstantiate)
                    {
                        InitializePhysics();
                    }

                    UpdatePhysics(globalOptions, next.physics);
                }

                if (change_inter.changing())
                {
                    if (!shouldInstantiate)
                    {
                        InitializeInteractions();
                    }

                    UpdateInteractions(metadata, next.interaction);
                }

                if (change_meshR.changing())
                {
                    if (!shouldInstantiate)
                    {
                        InitializeRendering();
                    }

                    UpdateRendering(renderingSet, globalOptions, normalLighting, next.rendering);
                }

                var anyTurningOff = change_physx.turnOff() ||
                                    change_inter.turnOff() ||
                                    change_meshR.turnOff();
                var anyStayingOn = next_physx.on() || next_inter.on() || next_meshR.on();

                var shouldDestroy = instantiated && anyTurningOff && !anyStayingOn;

                if (shouldDestroy)
                {
                    var ltw = transform.localToWorldMatrix;
                    element.matrices_current[instanceIndex] = ltw;
                    pushGpuiMatrices = true;
                }

                if (change_gpuiR.changing())
                {
                    element.matrices_noGameObject_OWNED[instanceIndex] = change_gpuiR.turnOn()
                        ? element.matrices_current[instanceIndex]
                        : float4x4.zero;
                    pushGpuiMatrices = true;
                }

                if (shouldDestroy)
                {
                    ReturnInstanceToPool(element);
                }

                pushGpuiMatrices = pushGpuiMatrices ||
                                   (curr == InstanceState.NotSet) ||
                                   (next == InstanceState.NotSet);
            }
        }

        public bool ShouldDelayStateChange()
        {
            using (_PRF_ShouldDelayStateChange.Auto())
            {
                if ((rigidbody != null) && !rigidbody.IsSleeping())
                {
                    instancesStateCode = InstanceStateCode.Delayed;
                    return true;
                }

#if UNITY_EDITOR
                if (UnityEditor.Selection.activeTransform == transform)
                {
                    instancesStateCode = InstanceStateCode.DelayedBySelection;
                    return true;
                }
#endif
                return false;
            }
        }

        private void Instantiate(
            PrefabRenderingSet set,
            RuntimePrefabRenderingElement element,
            GPUInstancerPrototypeMetadata metadata,
            GameObject prefabInstanceRoot)
        {
            using (_PRF_Instantiate.Auto())
            {
                using (_PRF_Instantiate_Prototypes.Auto())
                {
                    if (element.prototypeTemplate == null)
                    {
                        element.prototypeTemplate = metadata.originalPrefab.InstantiatePrefab(
                            prefabInstanceRoot.transform,
                            _matrix_trs_zero
                        );
                        element.prototypeTemplate.SetActive(false);
                        element.prototypeTemplate.hideFlags |= HideFlags.HideInHierarchy;
                    }

                    if (element.prototypeTemplate == null)
                    {
                        throw new NotSupportedException(
                            $"Template prototype could not be instantiated for {metadata.prototype.name}."
                        );
                    }
                }

                using (_PRF_Instantiate_PrefabPool.Auto())
                {
                    if (element.prefabPool == null)
                    {
                        element.prefabPool = CreatePrefabPool(set, element, prefabInstanceRoot);
                    }
                }

                using (_PRF_Instantiate_Clone.Auto())
                {
                    var cloned = element.prefabPool.Get();
                    transform = cloned.transform;

                    var matrix = element.matrices_current[instanceIndex];

                    transform.float4x4ToTransform(matrix);

                    instanceBehaviour = cloned.GetComponent<PrefabRenderingInstanceBehaviour>();

                    if (instanceBehaviour == null)
                    {
                        instanceBehaviour = cloned.AddComponent<PrefabRenderingInstanceBehaviour>();
                    }

                    InitializePrefabRenderingInstanceBehaviour(instanceBehaviour, set);
                    instanceBehaviour.instance = this;

                    cloned.SetActive(true);
                    instanceBehaviour.Awaken();
                }
            }
        }

        private ObjectPool<GameObject> CreatePrefabPool(
            PrefabRenderingSet set,
            RuntimePrefabRenderingElement element,
            GameObject prefabInstanceRoot)
        {
            using (_PRF_CreatePrefabPool.Auto())
            {
                return ObjectPoolProvider.CreatePrefabPool(
                    CreateModelInstance(set, element, prefabInstanceRoot),
                    HideFlags.HideAndDontSave,
                    HideFlags.HideInHierarchy
                );
            }
        }

        private static GameObject CreateModelInstance(
            PrefabRenderingSet set,
            RuntimePrefabRenderingElement element,
            GameObject prefabInstanceRoot)
        {
            using (_PRF_CreateModelInstance.Auto())
            {
                var instance = Object.Instantiate(
                    element.prototypeTemplate,
                    prefabInstanceRoot.transform
                );

                var lod = instance.GetComponent<LODGroup>();
                var lods = lod.GetLODs();

                var renderers = instance.GetComponentsInChildren<MeshRenderer>();

                for (var i = renderers.Length - 1; i >= 0; i--)
                {
                    var testingRenderer = renderers[i];

                    var found = false;

                    for (var j = 0; j < lods.Length; j++)
                    {
                        var lodl = lods[j];

                        for (var k = 0; k < lodl.renderers.Length; k++)
                        {
                            var lodlr = lodl.renderers[k];

                            if (lodlr is MeshRenderer lodlmr && (lodlmr == testingRenderer))
                            {
                                found = true;
                                break;
                            }
                        }

                        if (found)
                        {
                            break;
                        }
                    }

                    if (!found)
                    {
                        testingRenderer.gameObject.DestroySafely();
                    }
                }

                instance.layer = set.modelOptions.layer;

                var colls = instance.FilterComponents<Collider>(true)
                                    .ExcludeLayers(Layers.ByName.Interactable)
                                    .ExcludeTags(TAGS.OcclusionBake)
                                    .RunFilter();

                for (var i = 0; i < colls.Length; i++)
                {
                    var collider = colls[i];
                    if (collider is MeshCollider mc)
                    {
                        mc.convex = true;
                    }
                }

                var ib = instance.GetComponent<PrefabRenderingInstanceBehaviour>();

                if (ib == null)
                {
                    ib = instance.AddComponent<PrefabRenderingInstanceBehaviour>();
                }

                InitializePrefabRenderingInstanceBehaviour(ib, set);

                instance.hideFlags &= ~HideFlags.HideInHierarchy;
                prefabInstanceRoot.hideFlags &= ~HideFlags.HideInHierarchy;

                return instance;
            }
        }

        private static void InitializePrefabRenderingInstanceBehaviour(
            PrefabRenderingInstanceBehaviour ib,
            PrefabRenderingSet set)
        {
            ib.set = set;
            ib.modelType = set.modelOptions.typeOptions;
            ib.modelOverrides = set.modelOptions;

            ib.contentType = set.contentOptions.typeOptions;
            ib.contentOverrides = set.contentOptions;
        }

        private void ReturnInstanceToPool(RuntimePrefabRenderingElement element)
        {
            using (_PRF_ReturnInstanceToPool.Auto())
            {
                var go = transform.gameObject;

                instanceBehaviour.Sleep();

                go.SetActive(false);
                element.prefabPool.Return(go);

                transform = null;
                instanceBehaviour = null;
                rigidbody = null;
                physicsColliders = null;
                interactionColliders = null;
                renderers = null;
                lodGroup = null;
                firstPhysicsCollider = null;
                firstInteractionCollider = null;
            }
        }

        private void InitializeRendering()
        {
            using (_PRF_InitializeRendering.Auto())
            {
                if (lodGroup == null)
                {
                    using (_PRF_InitializeRendering_LODGroup.Auto())
                    {
                        lodGroup = transform.GetComponent<LODGroup>();
                    }
                }

                if (renderers != null)
                {
                    var doInitialize = false;

                    for (var i = 0; i < renderers.Length; i++)
                    {
                        if (renderers[i] == null)
                        {
                            doInitialize = true;
                            break;
                        }
                    }

                    if (!doInitialize)
                    {
                        return;
                    }
                }

                using (_PRF_InitializeRendering_Renderers.Auto())
                {
                    if (lodGroup == null)
                    {
                        renderers = transform.GetComponentsInChildren<Renderer>(false);

                        for (var i = 0; i < renderers.Length; i++)
                        {
                            renderers[i].enabled = false;
                        }
                    }
                    else
                    {
                        var lods = lodGroup.GetLODs();

                        var rendererCount = 0;

                        for (var i = 0; i < lods.Length; i++)
                        {
                            rendererCount += lods[i].renderers.Length;
                        }

                        renderers = new Renderer[rendererCount];

                        var rendererIndex = 0;

                        for (var i = 0; i < lods.Length; i++)
                        {
                            var lod = lods[i];

                            for (var j = 0; j < lod.renderers.Length; j++)
                            {
                                var renderer = lod.renderers[j];

                                renderer.enabled = false;
                                renderers[rendererIndex] = renderer;
                                rendererIndex++;
                            }
                        }
                    }
                }
            }
        }

        private void UpdateRendering(
            PrefabRenderingSet renderingSet,
            GlobalRenderingOptions globalOptions,
            AssetLightingSettings normalLighting,
            InstanceRenderingState state)
        {
            using (_PRF_UpdateRendering.Auto())
            {
                var mask = globalOptions.layerMask;

                for (var i = 0; i < renderers.Length; i++)
                {
                    var renderer = renderers[i];

                    using (_PRF_UpdateRendering_CheckLayer.Auto())
                    {
                        if (!mask.IsLayerInMask(renderer.gameObject.layer))
                        {
                            continue;
                        }
                    }

                    using (_PRF_UpdateRendering_CheckEnabled.Auto())
                    {
                        renderer.enabled = state == InstanceRenderingState.MeshRenderers;

                        if (!renderer.enabled)
                        {
                        }
                    }
                }

                using (_PRF_UpdateRendering_OverrideLighting.Auto())
                {
                    for (var i = 0; i < renderers.Length; i++)
                    {
                        var renderer = renderers[i];

                        globalOptions.defaultSettings.GetOverrideLightingSettings(
                            normalLighting,
                            renderingSet.originalRendererLighting[i].shadowCastingMode,
                            out var shadowCastingMode,
                            out var receiveShadows,
                            out var lightProbeUsage,
                            out var lightProbeProxyVolumeOverride
                        );

                        renderer.shadowCastingMode = shadowCastingMode;
                        renderer.receiveShadows = receiveShadows;
                        renderer.lightProbeUsage = lightProbeUsage;
                        renderer.lightProbeProxyVolumeOverride =
                            lightProbeProxyVolumeOverride.gameObject;
                    }
                }

                using (_PRF_UpdateRendering_LODGroup.Auto())
                {
                    if (lodGroup != null)
                    {
                        if (mask.IsLayerInMask(lodGroup.gameObject.layer))
                        {
                            lodGroup.enabled = state == InstanceRenderingState.MeshRenderers;
                        }
                    }
                }
            }
        }

        private void InitializePhysics()
        {
            using (_PRF_InitializePhysics.Auto())
            {
                using (_PRF_InitializePhysics_NullCheck.Auto())
                {
                    var doInitialize = false;

                    if (physicsColliders != null)
                    {
                        for (var i = 0; i < physicsColliders.Length; i++)
                        {
                            if (physicsColliders[i] == null)
                            {
                                doInitialize = true;
                                break;
                            }
                        }

                        if (!doInitialize)
                        {
                            return;
                        }
                    }
                }

                using (_PRF_InitializePhysics_ColliderQuery.Auto())
                {
                    physicsColliders = transform.FilterComponents<Collider>(true)
                                                .ExcludeLayers(Layers.ByName.Interactable)
                                                .ExcludeTags(TAGS.OcclusionBake)
                                                .RunFilter();
                }

                firstPhysicsCollider = physicsColliders.Length > 0 ? physicsColliders[0] : null;
            }
        }

        private void UpdatePhysics(GlobalRenderingOptions globalOptions, InstancePhysicsState state)
        {
            using (_PRF_UpdatePhysics.Auto())
            {
                var mask = globalOptions.layerMask;

                for (var i = 0; i < physicsColliders.Length; i++)
                {
                    var collider = physicsColliders[i];

                    if (mask.IsLayerInMask(collider.gameObject.layer))
                    {
                        collider.enabled = state == InstancePhysicsState.Enabled;
                    }
                }
            }
        }

        private void InitializeInteractions()
        {
            using (_PRF_InitializeInteractions.Auto())
            {
                if (rigidbody == null)
                {
                    rigidbody = transform.GetComponent<Rigidbody>();
                }

                if (firstInteractionCollider == null)
                {
                    interactionColliders = transform.FilterComponents<Collider>(true)
                                                    .IncludeOnlyLayers(Layers.ByName.Interactable)
                                                    .ExcludeTags(TAGS.OcclusionBake)
                                                    .RunFilter();

                    firstInteractionCollider = interactionColliders.Length > 0
                        ? interactionColliders[0]
                        : null;
                }
            }
        }

        private void UpdateInteractions(
            GPUInstancerPrototypeMetadata metadata,
            InstanceInteractionState state)
        {
            using (_PRF_UpdateInteractions.Auto())
            {
                if (!metadata.hasRigidBody)
                {
                    return;
                }

                if (state == InstanceInteractionState.Enabled)
                {
                    var rigidbodyData = metadata.rigidbodyData;

                    if (rigidbody == null)
                    {
                        rigidbody = transform.gameObject.AddComponent<Rigidbody>();
                    }

                    rigidbody.useGravity = rigidbodyData.useGravity;
                    rigidbody.angularDrag = rigidbodyData.angularDrag;

                    //AppaLog.Info($"Setting mass from {rigidbody.mass} to {rigidbodyData.mass}.");
                    rigidbody.mass = rigidbodyData.mass;
                    rigidbody.constraints = rigidbodyData.constraints;
                    rigidbody.detectCollisions = true;
                    rigidbody.drag = rigidbodyData.drag;
                    rigidbody.isKinematic = rigidbodyData.isKinematic;
                    rigidbody.interpolation = rigidbodyData.interpolation;

                    if (firstInteractionCollider != null)
                    {
                        for (var i = 0; i < interactionColliders.Length; i++)
                        {
                            interactionColliders[i].enabled = true;
                        }
                    }
                }
                else
                {
                    rigidbody.DestroySafely();
                }
            }
        }

        public void Teardown(RuntimePrefabRenderingElement element)
        {
            using (_PRF_Teardown.Auto())
            {
                Dispose();

                element.matrices_noGameObject_OWNED[instanceIndex] = _matrix_zero;
            }
        }

#region ProfilerMarkers

        private static readonly ProfilerMarker _PRF_ApplyNewInstanceState =
            new(_PRF_PFX + nameof(ApplyNewInstanceState));

        private static readonly ProfilerMarker _PRF_ApplyStateChange =
            new(_PRF_PFX + nameof(ApplyStateChange));

        private static readonly ProfilerMarker _PRF_AssignElementProperties =
            new(_PRF_PFX + nameof(AssignElementProperties));

        private static readonly ProfilerMarker _PRF_Dispose = new(_PRF_PFX + nameof(Dispose));

        private static readonly ProfilerMarker _PRF_InitializeInteractions =
            new(_PRF_PFX + nameof(InitializeInteractions));

        private static readonly ProfilerMarker _PRF_InitializePhysics =
            new(_PRF_PFX + nameof(InitializePhysics));

        private static readonly ProfilerMarker _PRF_InitializePhysics_ColliderQuery =
            new(_PRF_PFX + nameof(InitializePhysics) + ".ColliderQuery");

        private static readonly ProfilerMarker _PRF_InitializePhysics_ConvexCheck =
            new(_PRF_PFX + nameof(InitializePhysics) + ".ConvexCheck");

        private static readonly ProfilerMarker _PRF_InitializePhysics_NullCheck =
            new(_PRF_PFX + nameof(InitializePhysics) + ".NullCheck");

        private static readonly ProfilerMarker _PRF_InitializeRendering =
            new(_PRF_PFX + nameof(InitializeRendering));

        private static readonly ProfilerMarker _PRF_InitializeRendering_LODGroup =
            new(_PRF_PFX + nameof(InitializeRendering) + ".LODGroup");

        private static readonly ProfilerMarker _PRF_InitializeRendering_Renderers =
            new(_PRF_PFX + nameof(InitializeRendering) + ".Renderers");

        private static readonly ProfilerMarker _PRF_Instantiate =
            new(_PRF_PFX + nameof(Instantiate));

        private static readonly ProfilerMarker _PRF_Instantiate_Clone =
            new(_PRF_PFX + nameof(Instantiate) + ".Clone");

        private static readonly ProfilerMarker _PRF_Instantiate_InstanceBehaviour =
            new(_PRF_PFX + nameof(Instantiate) + ".InstanceBehaviour");

        private static readonly ProfilerMarker _PRF_Instantiate_Integrate =
            new(_PRF_PFX + nameof(Instantiate) + ".Integrate");

        private static readonly ProfilerMarker _PRF_Instantiate_PrefabPool =
            new(_PRF_PFX + nameof(Instantiate) + ".PrefabPool");

        private static readonly ProfilerMarker _PRF_Instantiate_Prototypes =
            new(_PRF_PFX + nameof(Instantiate) + ".Prototypes");

        private static readonly ProfilerMarker _PRF_ReturnInstanceToPool =
            new(_PRF_PFX + nameof(ReturnInstanceToPool));

        private static readonly ProfilerMarker _PRF_ShouldDelayStateChange =
            new(_PRF_PFX + nameof(ShouldDelayStateChange));

        private static readonly ProfilerMarker _PRF_Teardown = new(_PRF_PFX + nameof(Teardown));

        private static readonly ProfilerMarker _PRF_UpdateInteractions =
            new(_PRF_PFX + nameof(UpdateInteractions));

        private static readonly ProfilerMarker _PRF_UpdatePhysics =
            new(_PRF_PFX + nameof(UpdatePhysics));

        private static readonly ProfilerMarker _PRF_UpdateRendering =
            new(_PRF_PFX + nameof(UpdateRendering));

        private static readonly ProfilerMarker _PRF_UpdateRendering_CheckEnabled =
            new(_PRF_PFX + nameof(UpdateRendering) + ".CheckEnabled");

        private static readonly ProfilerMarker _PRF_UpdateRendering_CheckLayer =
            new(_PRF_PFX + nameof(UpdateRendering) + ".CheckLayer");

        private static readonly ProfilerMarker _PRF_UpdateRendering_LODGroup =
            new(_PRF_PFX + nameof(UpdateRendering) + ".LODGroup");

        private static readonly ProfilerMarker _PRF_UpdateRendering_OverrideLighting =
            new(_PRF_PFX + nameof(UpdateRendering) + ".OverrideLighting");

#endregion
    }
}
