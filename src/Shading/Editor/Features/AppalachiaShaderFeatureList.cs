using System;
using Appalachia.Core.Collections;

namespace Appalachia.Rendering.Shading.Features
{
    [Serializable]
    public sealed class AppalachiaShaderFeatureList : AppaList<AppalachiaShaderFeature>
    {
        public AppalachiaShaderFeatureList()
        {
        }

        public AppalachiaShaderFeatureList(
            int capacity,
            float capacityIncreaseMultiplier = 2,
            bool noTracking = false) : base(capacity, capacityIncreaseMultiplier, noTracking)
        {
        }

        public AppalachiaShaderFeatureList(AppaList<AppalachiaShaderFeature> list) : base(list)
        {
        }

        public AppalachiaShaderFeatureList(AppalachiaShaderFeature[] values) : base(values)
        {
        }
    }
}
