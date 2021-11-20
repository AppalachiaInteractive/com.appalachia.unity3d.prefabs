#region

using System;
using System.Linq;
using Appalachia.Core.Assets;
using Appalachia.Core.Behaviours;
using Appalachia.Core.Debugging;
using Appalachia.Core.Scriptables;
using Appalachia.Editing.Debugging;
using Appalachia.Editing.Debugging.Handle;
using Appalachia.Rendering.Prefabs.Spawning.Data;
using Appalachia.Rendering.Prefabs.Spawning.Sets;
using Appalachia.Rendering.Prefabs.Spawning.Settings;
using Appalachia.Simulation.Core;
using Sirenix.OdinInspector;
using Unity.Profiling;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Spawning
{
    [ExecuteAlways]
    public class RandomPrefabSpawner : AppalachiaBehaviour
    {
        private const string _PRF_PFX = nameof(RandomPrefabSpawner) + ".";

        private static readonly ProfilerMarker _PRF_OnEnable = new(_PRF_PFX + nameof(OnEnable));

        private static readonly ProfilerMarker _PRF_EnableSpawning =
            new(_PRF_PFX + nameof(EnableSpawning));

        private static readonly ProfilerMarker _PRF_DisableSpawning =
            new(_PRF_PFX + nameof(DisableSpawning));

        private static readonly ProfilerMarker _PRF_Update = new(_PRF_PFX + nameof(Update));

#if UNITY_EDITOR
        private static readonly ProfilerMarker _PRF_OnDrawGizmos =
            new(_PRF_PFX + nameof(OnDrawGizmos));

        private static readonly ProfilerMarker _PRF_CreateNewSettings =
            new(_PRF_PFX + nameof(CreateNewSettings));
#endif

        [InlineProperty]
        [InlineEditor]
        [HideLabel]
        public PrefabSpawnSettings settings;

        [InlineProperty]
        [HideLabel]
        public RandomPrefabSetCollectionState state;

        public PrefabSpawnerRigidbodyManager rigidbodyManager;

        [NonSerialized] private bool _spawning;
        private Bounds bounds;

        private Bounds previousBounds;

        [BoxGroup("Spawning")]
        [ShowInInspector]
        [ReadOnly]
        public bool spawning => _spawning;

        private void Update()
        {
            using (_PRF_Update.Auto())
            {
                previousBounds = bounds;

                if (!spawning)
                {
                    return;
                }

                if (settings.timing.prefabSpawnStyle == PrefabSpawnStyle.Disabled)
                {
                    return;
                }

                if (settings.timing.prefabSpawnStyle == PrefabSpawnStyle.OnDemand)
                {
                    return;
                }

                state.ConfirmStructure(transform);

                var current = Time.time;

                var spawnDuration = 1.0f / settings.timing.spawnsPerSecond;
                var nextSpawnTime = state.lastSpawnTime + spawnDuration;

                if (nextSpawnTime > current)
                {
                    return;
                }

                state.lastSpawnTime = current;

                var newBounds = new Bounds();

                if (!rigidbodyManager.EligibleForActivation(settings, out var limit))
                {
                    return;
                }

                var count = Mathf.Max(1, (int) (Time.deltaTime * settings.timing.spawnsPerSecond));
                count = Mathf.Min(count, limit);

                if (count > 0)
                {
                    state.SpawnMany(settings, rigidbodyManager, count, ref newBounds);
                }

                if (newBounds != default)
                {
                    bounds = newBounds;
                }
            }
        }

        protected override void OnEnable()
        {
            using (_PRF_OnEnable.Auto())
            {
                base.OnEnable();
                
#if UNITY_EDITOR
                settings.UpdateAllIDs();
                state.collection.UpdateAllIDs();
                state.collection.prefabSets?.FirstOrDefault()?.set?.UpdateAllIDs();
#endif
                if (rigidbodyManager == null)
                {
                    rigidbodyManager = new PrefabSpawnerRigidbodyManager();
                }
            }
        }

#if UNITY_EDITOR
        private void OnDrawGizmos()
        {
            using (_PRF_OnDrawGizmos.Auto())
            {
                if (!GizmoCameraChecker.ShouldRenderGizmos())
                {
                    return;
                }

                SmartHandles.DrawWireCube(previousBounds,          Color.green);
                SmartHandles.DrawWireCube(rigidbodyManager.bounds, Color.cyan);
            }
        }
#endif

        [Button]
        [ButtonGroup("Spawning/B")]
        [DisableIf(nameof(spawning))]
        public void EnableSpawning()
        {
            using (_PRF_EnableSpawning.Auto())
            {
                state.lastSpawnTime = 0.0f;

                _spawning = true;

#if UNITY_EDITOR
                if (!PhysicsSimulator.IsSimulationActive)
                {
                    PhysicsSimulator.SetEnabled(true);
                }
#endif
            }
        }

        [Button]
        [ButtonGroup("Spawning/B")]
        [EnableIf(nameof(spawning))]
        public void DisableSpawning()
        {
            using (_PRF_DisableSpawning.Auto())
            {
                _spawning = false;

#if UNITY_EDITOR
                if (PhysicsSimulator.IsSimulationActive)
                {
                    PhysicsSimulator.SetEnabled(false);
                }
#endif
            }
        }
#if UNITY_EDITOR
        [Button]
        [ButtonGroup("A")]
        public void CreateNewSettings()
        {
            using (_PRF_CreateNewSettings.Auto())
            {
                settings = AppalachiaObject.CreateNew<PrefabSpawnSettings>();
                AssetDatabaseSaveManager.SaveAssetsNextFrame();
            }
        }

        private static readonly ProfilerMarker _PRF_CreateNewState =
            new(_PRF_PFX + nameof(CreateNewState));

        [Button]
        [ButtonGroup("A")]
        public void CreateNewState()
        {
            using (_PRF_CreateNewState.Auto())
            {
                var collection = AppalachiaObject.CreateNew<RandomPrefabSetCollection>();
                RandomPrefabMasterCollection.instance.collections.Add(collection);
                state = new RandomPrefabSetCollectionState(transform, collection);
                AssetDatabaseSaveManager.SaveAssetsNextFrame();
            }
        }
#endif

/*
#if UNITY_EDITOR

        [BoxGroup("Advanced")]
        public bool showAdvanced = false;

        [BoxGroup("Advanced")]
        [ShowIf(nameof(showAdvanced))]
        public float offsetMax = 5.0f;
        
        [FormerlySerializedAs("spawnMax")]
        [BoxGroup("Advanced")]
        [ShowIf(nameof(showAdvanced))]
        public float spawnLimitMax = 60.0f;
        
        [BoxGroup("Advanced")]
        [ShowIf(nameof(showAdvanced))]
        public int rigidbodyMax = 500;

        [BoxGroup("Advanced")]
        [ShowIf(nameof(showAdvanced))]
        public float rigidbodyVelocityActiveThreshold = .1f;
        
        
        [BoxGroup("Setup")]
        [AssetsOnly]
        public List<GameObject> prefabs = new List<GameObject>();

        
        [BoxGroup("Positioning")]
        [PropertyRange(0.0f, nameof(offsetMax))]
        public float randomOffset = 1.0f;

        [BoxGroup("Positioning")]
        public bool circularOffset = true;
        
        [BoxGroup("Positioning")]
        public Vector3 minEulerRotation = new Vector3(-180, -180, -180);
        [BoxGroup("Positioning")]
        public Vector3 maxEulerRotation = new Vector3(180, 180, 180);
        
        [BoxGroup("Positioning")]
        public bool uniformScale = true;
        
        [BoxGroup("Positioning")]
        [OnValueChanged(nameof(OnScaleUpdate))]
        public Vector3 minScale = new Vector3(0.9f, 0.9f, 0.9f);
        
        [BoxGroup("Positioning")]
        [OnValueChanged(nameof(OnScaleUpdate))]
        public Vector3 maxScale = new Vector3(1.1f, 1.1f, 1.1f);

        private void OnScaleUpdate()
        {
            if (!uniformScale) return;

            minScale.y = minScale.x;
            minScale.z = minScale.x;

            maxScale.y = maxScale.x;
            maxScale.z = maxScale.x;
        }
        
        [BoxGroup("Spawning")]
        public PrefabSpawnStyle PrefabSpawnStyle;
        
        private bool showTimerSettings => PrefabSpawnStyle == PrefabSpawnStyle.Timed;
        
        private bool showOnDemandSettings => PrefabSpawnStyle == PrefabSpawnStyle.OnDemand;

        [BoxGroup("Spawning")]
        [ShowIf(nameof(showTimerSettings)), PropertyRange(0.1f, nameof(spawnLimitMax))] 
        public float spawnsPerSecond = 1.0f;

        [BoxGroup("Spawning")]
        public Vector3 spawnPointOffset = new Vector3(0f, 1f, 0f);

        [BoxGroup("Spawning")]
        public LayerSelection spawnLayer;
        
        private bool isRunning => Application.isPlaying;

        [BoxGroup("Spawning")]
        public bool enableSpawnLimiting;
        
        [BoxGroup("Spawning")]
        [ShowIf(nameof(enableSpawnLimiting))] 
        public int spawnLimit = 100;
        
        [BoxGroup("Spawning")]
        [ShowIf(nameof(isRunning)), Sirenix.OdinInspector.ReadOnly]
        public int spawned = 0;

        [BoxGroup("Spawning")]
        public int frameDelay = 60;
        private int frameCount = 0;
        private float _pendingSpawns = 0f;

        [BoxGroup("Physics")]
        public bool addRigidbodies = true;
        
        [BoxGroup("Physics")]
        [ShowIf(nameof(addRigidbodies)), PropertyRange(0.01f, 4.0f)]
        public float mass = 1.0f;
        
        [BoxGroup("Physics")]
        [ShowIf(nameof(addRigidbodies)), PropertyRange(0.01f, 4.0f)]
        public float drag = 1.0f;
        
        [BoxGroup("Physics")]
        [ShowIf(nameof(addRigidbodies)), PropertyRange(0.01f, 4.0f)]
        public float angularDrag = 1.0f;
        
        [BoxGroup("Physics")]
        public bool ensureConvex = true;
        
        [FormerlySerializedAs("removeRigidbodies")]
        [BoxGroup("Physics")]
        public bool removeRigidbodiesAtLimit;
        
        [BoxGroup("Physics")]
        [ShowIf(nameof(removeRigidbodiesAtLimit)), PropertyRange(1, nameof(rigidbodyMax))] 
        public int rigidbodyLimit = 20;
        
        [BoxGroup("Physics")]
        [ShowIf(nameof(removeRigidbodiesAtLimit))]
        public bool dontDeleteActiveRigidbodies = true;

        private bool showDelaySpawningRigidbodies => dontDeleteActiveRigidbodies && removeRigidbodiesAtLimit;
        
        [BoxGroup("Physics")]
        [ShowIf(nameof(showDelaySpawningRigidbodies))]
        public bool delaySpawningUntilRigidbodiesLimited = true;
        
        private readonly Queue<Rigidbody> _rigidbodies = new Queue<Rigidbody>();
        
        private Dictionary<GameObject, GameObject> prefabInstanceLookup;
        
        public void FixedUpdate()
        {
            if (frameCount < frameDelay)
            {
                frameCount += 1;
                return;
            }
            
            if (spawned == 0)
            {
                _rigidbodies.Clear();
            }            
            
            if (!enabled || (PrefabSpawnStyle != PrefabSpawnStyle.Timed) || (enableSpawnLimiting && spawned >= spawnLimit))
            {
                return;
            }

            if (removeRigidbodiesAtLimit && delaySpawningUntilRigidbodiesLimited && _rigidbodies.Count > rigidbodyLimit)
            {
                HandleRigidbodyRemoval();
                return;
            }

            var spawns = Time.fixedDeltaTime * spawnsPerSecond;

            _pendingSpawns += spawns;

            if (_pendingSpawns < 1)
            {
                return;
            }
            
            for (var i = 0f; i < spawns && _pendingSpawns >= 0; i++)
            {
                Spawn();
                _pendingSpawns -= 1;
            }
        }

        private void BuildPrefabLookupDictionary()
        {
            if (prefabInstanceLookup != null && prefabInstanceLookup.Count == prefabs.Count)
            {
                return;
            }
            
            if (prefabInstanceLookup == null)
            {
                prefabInstanceLookup = new Dictionary<GameObject, GameObject>();
            }

            prefabInstanceLookup.Clear();
            
            foreach (var prefab in prefabs)
            {
                var instance = PrefabUtility.InstantiatePrefab(prefab) as GameObject;

                instance.layer = spawnLayer;
                var transforms = instance.GetComponentsInChildren<Transform>();

                foreach (var transform in transforms)
                {
                    transform.gameObject.layer = spawnLayer;
                }
                
                var rigidbodies = instance.GetComponentsInChildren<Rigidbody>();
                var meshColliders = instance.GetComponentsInChildren<MeshCollider>();
                var rigidbodyDragModifier = instance.GetComponent<RigidbodyDragModifier>();

                if (ensureConvex)
                {
                    foreach (var mc in meshColliders)
                    {

                        ResetMeshCollidedrProperties(mc);
                    }
                }

                if (addRigidbodies && rigidbodies.Length == 0)
                {
                    var rb = instance.AddComponent<Rigidbody>();

                    ResetRigidbodyProperties(rb);
                    

                    if (rigidbodyDragModifier == null)
                    {
                        rigidbodyDragModifier = rb.gameObject.AddComponent<RigidbodyDragModifier>();
                        rigidbodyDragModifier.removeOnSleep = false;
                    }
                }

                instance.SetActive(false);

                prefabInstanceLookup.Add(prefab, instance);
            }
        }

        [Button]
        public void ResetPhysicsProperties()
        {
            if (prefabInstanceLookup == null || prefabInstanceLookup.Count == 0)
            {
                return;
            }

            foreach (var keyvalue in prefabInstanceLookup)
            {
                var rigidbodies = keyvalue.Value.GetComponents<Rigidbody>();
                foreach (var rigidbody in rigidbodies)
                {
                    ResetRigidbodyProperties(rigidbody);
                }
                
                var colliders = keyvalue.Value.GetComponentsInChildren<MeshCollider>();
                
                foreach (var collider in colliders)
                {
                    ResetMeshCollidedrProperties(collider);
                }
            }
        }
        
        private void ResetRigidbodyProperties(Rigidbody rb)
        {
            rb.drag = drag;
            rb.angularDrag = angularDrag;
            rb.interpolation = RigidbodyInterpolation.Interpolate;
            rb.isKinematic = false;
            rb.detectCollisions = true;
            rb.useGravity = true;
            rb.collisionDetectionMode = CollisionDetectionMode.ContinuousDynamic;
        }
        
        private void ResetMeshCollidedrProperties(MeshCollider mc)
        {
            mc.convex = true;
        }

        private void HandleRigidbodyRemoval()
        {
            var terrain = Terrain.activeTerrain;
            var bounds = terrain.terrainData.bounds;
            bounds.center += terrain.transform.position;
            
            if (removeRigidbodiesAtLimit)
            {
                if (!dontDeleteActiveRigidbodies)
                {
                    while (_rigidbodies.Count > rigidbodyLimit)
                    {
                        Destroy(_rigidbodies.Dequeue());
                    } 
                }
                else
                {
                    for (var i = 0; i < _rigidbodies.Count; i++)
                    {
                        if (_rigidbodies.Count < rigidbodyLimit)
                        {
                            break;
                        }
                        
                        var deq = _rigidbodies.Dequeue();

                        if (deq == null)
                        {
                            continue;
                        }


                        if (!bounds.Contains(deq.transform.position))
                        {
                            var rdm = deq.GetComponentInParent<RigidbodyDragModifier>();
                            Destroy(rdm.gameObject);
                        }
                        else if (deq.velocity.magnitude > rigidbodyVelocityActiveThreshold)
                        {
                            _rigidbodies.Enqueue(deq);
                        }
                        else
                        {
                            Destroy(deq);
                        }
                    }
                }
            }
        }
        
        [ShowIf(nameof(showOnDemandSettings)), Button]
        public void Spawn()
        {
            if (prefabs == null || prefabs.Count == 0)
            {
                return;
            }
            
            BuildPrefabLookupDictionary();

            if (removeRigidbodiesAtLimit && delaySpawningUntilRigidbodiesLimited && _rigidbodies.Count >= rigidbodyLimit)
            {
                HandleRigidbodyRemoval();
                return;
            }
            
            var terrains = Terrain.activeTerrains;
            
            var random = Random.Range(0, prefabs.Count);
            var prefab = prefabs[random];
            
            var additiveX = Random.Range(-1.0f, 1.0f);
            var additiveZ = Random.Range(-1.0f, 1.0f);

            Vector3 additive;
            
            if (circularOffset)
            {
                var additiveMagnitudeX = Random.Range(0.0f, randomOffset);
                var additiveMagnitudeZ = Random.Range(0.0f, randomOffset);
                var additiveDirection = new Vector3(additiveX, 0.0f, additiveZ).normalized;

                additive.x = additiveDirection.x * additiveMagnitudeX;
                additive.y = 0.0f;
                additive.z = additiveDirection.z * additiveMagnitudeZ;
            }
            else
            {
                additive = new Vector3(additiveX, 0.0f, additiveZ) * randomOffset;
            }


            var position = transform.position + additive;
            position.y = terrains.GetWorldHeightAtPosition(position);
            
            var rotation = new Vector3(
                Random.Range(minEulerRotation.x, maxEulerRotation.x),
                Random.Range(minEulerRotation.y, maxEulerRotation.y),
                Random.Range(minEulerRotation.z, maxEulerRotation.z));

            Vector3 scale;
            if (uniformScale)
            {
                scale = new Vector3(Random.Range(minScale.x, maxScale.x), 0.0f, 0.0f);
                scale.y = scale.x;
                scale.z = scale.x;
            }
            else
            {
                scale = new Vector3(
                    Random.Range(minScale.x, maxScale.x),
                    Random.Range(minScale.y, maxScale.y),
                    Random.Range(minScale.z, maxScale.z));
            }

            var localScale = Vector3.Scale(prefab.transform.localScale, scale);


            var go = GameObject.Instantiate(prefabInstanceLookup[prefab], transform, true);
            go.SetActive(true);
            
            go.transform.position = position + spawnPointOffset;
            go.transform.rotation = Quaternion.Euler(rotation);
            go.transform.localScale = localScale;

            HandleRigidbodyRemoval();
            
            var rbc = go.GetComponentsInChildren<Rigidbody>();

            foreach (var rb in rbc)
            {
                ResetRigidbodyProperties(rb);
                rb.mass = mass * localScale.x;
                _rigidbodies.Enqueue(rb);
            }

            var rbm = go.GetComponent<RigidbodyDragModifier>();

            if (rbm != null)
            {
                rbm.removeOnSleep = true;
            }

            spawned += 1;
        }

        private bool showReset => Application.isPlaying;
        [Button, ShowIf(nameof(showReset))]
        public void Reset()
        {
            for (var i = transform.childCount-1; i >= 0; i--)
            {
                Destroy(transform.GetChild(i).gameObject);
            }

            spawned = 0;
        }       
        
        private bool showCombineReset => spawned > 0 && Application.isPlaying;

        [ShowIf(nameof(showCombineReset))] public bool removeRigidbodiesWhileCombining = true;
        [ShowIf(nameof(showCombineReset))] public bool removeCollidersWhileCombining = true;
        [ShowIf(nameof(showCombineReset))] public bool disableAfterCombining = true;
        
        
        [Button, ShowIf(nameof(showCombineReset))]
        public void CombineAndReset()
        {
            var template = prefabs.First();

            var assetPath = AssetDatabaseManager.GetAssetPath(template);
            var folder = AppaPath.GetDirectoryName(assetPath);
            var newName = $"{template.name}_{spawned}_COMBINED";

            var newPrefab = new GameObject(newName);
            newPrefab.transform.position = Vector3.zero;
            newPrefab.transform.rotation = Quaternion.identity;
            newPrefab.transform.localScale = Vector3.one;
            
            var newPrefabFile = $"{folder}\\{newName}.prefab";

            for (var i = transform.childCount-1; i >= 0; i--)
            {
                transform.GetChild(i).SetParent(newPrefab.transform, true);
            }

            if (removeRigidbodiesWhileCombining)
            {
                var rigidbodies = newPrefab.GetComponentsInChildren<Rigidbody>();
                for (var i = rigidbodies.Length - 1; i >= 0; i--)
                {
                    Destroy(rigidbodies[i]);
                }
            }

            if (removeCollidersWhileCombining)
            {
                var colliders = newPrefab.GetComponentsInChildren<Collider>();
                for (var i = colliders.Length - 1; i >= 0; i--)
                {
                    Destroy(colliders[i]);
                }
            }
            
            PrefabUtility.SaveAsPrefabAssetAndConnect(newPrefab, newPrefabFile, InteractionMode.AutomatedAction);
            
            if (disableAfterCombining)
            {
                newPrefab.SetActive(false);
            }
            
            spawned = 0;
            PrefabSpawnStyle = PrefabSpawnStyle.Disabled;
        }
#endif*/
    }
}
