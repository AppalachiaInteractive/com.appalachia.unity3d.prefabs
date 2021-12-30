using System;
using Appalachia.Core.Objects.Initialization;
using Appalachia.Core.Objects.Root;
using Appalachia.Utility.Async;
using Unity.Profiling;

namespace Appalachia.Rendering.Prefabs.Spawning.Data
{
    public sealed class PrefabSpawnMarker : AppalachiaBehaviour<PrefabSpawnMarker>
    {
        #region Fields and Autoproperties

        public string identifier;

        #endregion

        protected override async AppaTask Initialize(Initializer initializer)
        {
            using (_PRF_Initialize.Auto())
            {
                await base.Initialize(initializer);

                if (identifier == null)
                {
                    identifier = Guid.NewGuid().ToString("D");
                }
            }
        }

        #region Profiling

        private const string _PRF_PFX = nameof(PrefabSpawnMarker) + ".";

        private static readonly ProfilerMarker _PRF_Initialize =
            new ProfilerMarker(_PRF_PFX + nameof(Initialize));

        #endregion
    }
}
