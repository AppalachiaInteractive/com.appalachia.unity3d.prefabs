using System;
using Appalachia.Core.Behaviours;
using Unity.Profiling;

namespace Appalachia.Rendering.Prefabs.Rendering.Options.Rendering
{
    [Serializable]
    public class RenderingOptionsBase<T> : InternalBase<T>
        where T : InternalBase<T>
    {
        private const string _PRF_PFX = nameof(RenderingOptionsBase<T>) + ".";

        private static readonly ProfilerMarker _PRF_MarkDirty = new(_PRF_PFX + nameof(MarkDirty));

        protected bool _applied;

        protected void MarkDirty()
        {
            using (_PRF_MarkDirty.Auto())
            {
                _applied = false;
            }
        }
    }
}
