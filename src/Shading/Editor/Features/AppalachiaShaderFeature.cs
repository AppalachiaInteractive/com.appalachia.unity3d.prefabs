using System;
using Appalachia.Core.Objects.Root;
using Sirenix.OdinInspector;

namespace Appalachia.Rendering.Shading.Features
{
    [Serializable]
    public class AppalachiaShaderFeature : AppalachiaSimpleBase
    {
        [ListDrawerSettings] public ShaderList shaders = new();

        public AppalachiaShaderFeatureCompatability compatibility = 0;

        public AppalachiaShaderFeatureLODStyle lodFade = 0;
    }
}
