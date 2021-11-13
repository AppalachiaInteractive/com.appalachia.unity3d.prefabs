using System;
using Appalachia.Core.Behaviours;

namespace Appalachia.Rendering.Prefabs.Spawning.Data
{
    public class PrefabSpawnMarker : AppalachiaBehaviour
    {
        public string identifier;

        private void Awake()
        {
            if (identifier == null)
            {
                identifier = Guid.NewGuid().ToString("D");
            }
        }
    }
}