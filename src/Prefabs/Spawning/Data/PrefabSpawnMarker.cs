using System;
using Appalachia.Core.Objects.Initialization;
using Appalachia.Core.Objects.Root;
using Appalachia.Utility.Async;

namespace Appalachia.Rendering.Prefabs.Spawning.Data
{
    public sealed class PrefabSpawnMarker : AppalachiaBehaviour<PrefabSpawnMarker>
    {
        #region Fields and Autoproperties

        public string identifier;

        #endregion

        /// <inheritdoc />
        protected override async AppaTask Initialize(Initializer initializer)
        {
            await base.Initialize(initializer);

            if (identifier == null)
            {
                identifier = Guid.NewGuid().ToString("D");
            }
        }
    }
}
