using System;
using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;

namespace Appalachia.Rendering.Shading.Features
{
    [Serializable]
    public class AppalachiaShaderFeature
    {
        [ListDrawerSettings] public List<Shader> shaders = new List<Shader>();

        public AppalachiaShaderFeatureCompatability compatibility = 0;

        public AppalachiaShaderFeatureLODStyle lodFade = 0;
    }
}
