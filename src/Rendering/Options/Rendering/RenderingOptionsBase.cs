using System;
using Appalachia.Base.Behaviours;
using Unity.Profiling;

namespace Appalachia.Prefabs.Rendering.Options.Rendering
{
    [Serializable]
    public class RenderingOptionsBase<T> : InternalBase<T>
        where T : InternalBase<T>
    {
        private const string _PRF_PFX = nameof(RenderingOptionsBase<T>) + ".";
        
        protected bool _applied = false;
        
        private static readonly ProfilerMarker _PRF_MarkDirty = new ProfilerMarker(_PRF_PFX + nameof(MarkDirty));
        protected void MarkDirty()
        {
            using (_PRF_MarkDirty.Auto())
            {
                _applied = false;
            }
        }
        
    }
}
