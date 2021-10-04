#region

using System;
using Sirenix.OdinInspector;

#endregion

namespace Appalachia.Prefabs.Spawning.Settings
{
    [Serializable]
    public class PrefabSpawnPhysicsSettings
    {
        [BoxGroup("Advanced")] public bool showAdvanced;

        [BoxGroup("Advanced")]
        [ShowIf(nameof(showAdvanced))]
        public float spawnLimitMax = 60.0f;

        [BoxGroup("Advanced")]
        [ShowIf(nameof(showAdvanced))]
        public int rigidbodyMax = 500;

        [BoxGroup("Advanced")]
        [ShowIf(nameof(showAdvanced))]
        public float rigidbodyVelocityActiveThreshold = .1f;

        public bool addRigidbodies = true;

        [EnableIf(nameof(addRigidbodies))]
        public bool modifyExistingRigidbodies;

        [ShowIf(nameof(addRigidbodies))]
        [PropertyRange(0.01f, 10.0f)]
        public float mass = 1.0f;

        [ShowIf(nameof(addRigidbodies))]
        [PropertyRange(0.01f, 4.0f)]
        public float drag = 1.0f;

        [ShowIf(nameof(addRigidbodies))]
        [PropertyRange(0.01f, 4.0f)]
        public float angularDrag = 1.0f;

        public bool removeRigidbodiesAtLimit;

        [ShowIf(nameof(removeRigidbodiesAtLimit))]
        [PropertyRange(1, nameof(rigidbodyMax))]
        public int rigidbodyLimit = 150;

        [ShowIf(nameof(removeRigidbodiesAtLimit))]
        public bool dontDeleteActiveRigidbodies = true;

        [ShowIf(nameof(showDelaySpawningRigidbodies))]
        public bool delaySpawningUntilRigidbodiesLimited = true;

        private bool showDelaySpawningRigidbodies => dontDeleteActiveRigidbodies && removeRigidbodiesAtLimit;
    }
}
