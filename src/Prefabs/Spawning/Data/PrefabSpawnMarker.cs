using System;
using Appalachia.Core.Objects.Root;
using Unity.Profiling;

namespace Appalachia.Rendering.Prefabs.Spawning.Data
{
    public sealed class PrefabSpawnMarker : AppalachiaBehaviour<PrefabSpawnMarker>
    {
        #region Fields and Autoproperties

        public string identifier;

        #endregion

        #region Event Functions

        protected override void Awake()
        {
            using (_PRF_Awake.Auto())
            {
                base.Awake();

                if (identifier == null)
                {
                    identifier = Guid.NewGuid().ToString("D");
                }
            }
        }

        #endregion

        #region Profiling

        private const string _PRF_PFX = nameof(PrefabSpawnMarker) + ".";
        private static readonly ProfilerMarker _PRF_Awake = new ProfilerMarker(_PRF_PFX + nameof(Awake));

        #endregion
    }
}
