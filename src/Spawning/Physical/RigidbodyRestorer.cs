#region

using Appalachia.Base.Behaviours;
using Appalachia.Core.Extensions;
using Appalachia.Simulation.Core;
using Unity.Profiling;
using UnityEngine;

#endregion

namespace Appalachia.Prefabs.Spawning.Physical
{
    public class RigidbodyRestorer : InternalMonoBehaviour
    {
        private const string _PRF_PFX = nameof(RigidbodyRestorer) + ".";

        private static readonly ProfilerMarker _PRF_Awake = new(_PRF_PFX + nameof(Awake));

        private static readonly ProfilerMarker _PRF_RestoreRigidbody =
            new(_PRF_PFX + nameof(RestoreRigidbody));

        public bool destroyOnRestore;

        public Rigidbody rb;
        public RigidbodyData originalData;

        public void Awake()
        {
            using (_PRF_Awake.Auto())
            {
                if (rb != null)
                {
                    return;
                }

                rb = GetComponent<Rigidbody>();

                if (rb == null)
                {
                    return;
                }

                originalData = new RigidbodyData(rb);
            }
        }

        public void RestoreRigidbody(bool forceDestroy)
        {
            using (_PRF_RestoreRigidbody.Auto())
            {
                if (originalData == null)
                {
                    return;
                }

                if (rb == null)
                {
                    rb = gameObject.AddComponent<Rigidbody>();
                }

                originalData.ApplyTo(rb);

                if (destroyOnRestore || forceDestroy)
                {
                    this.DestroySafely();
                }
            }
        }
    }
}
