#region

using Appalachia.Core.Objects.Initialization;
using Appalachia.Core.Objects.Root;
using Appalachia.Simulation.Core;
using Appalachia.Utility.Async;
using Appalachia.Utility.Extensions;
using Unity.Profiling;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Spawning.Physical
{
    public sealed class RigidbodyRestorer : AppalachiaBehaviour<RigidbodyRestorer>
    {
        #region Fields and Autoproperties

        public bool destroyOnRestore;

        public Rigidbody rb;
        public RigidbodyData originalData;

        #endregion

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

        protected override async AppaTask Initialize(Initializer initializer)
        {
            await base.Initialize(initializer);

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

        #region Profiling

        private static readonly ProfilerMarker _PRF_Awake = new(_PRF_PFX + nameof(Awake));

        

        private static readonly ProfilerMarker _PRF_RestoreRigidbody =
            new(_PRF_PFX + nameof(RestoreRigidbody));

        #endregion
    }
}
