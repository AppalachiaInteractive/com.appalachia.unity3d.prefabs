using System;
using Appalachia.Core.Collections;
using UnityEngine;

namespace Appalachia.Rendering.Shading.Features
{
    [Serializable]
    public sealed class ShaderList : AppaList<Shader>
    {
        public ShaderList()
        {
        }

        public ShaderList(int capacity, float capacityIncreaseMultiplier = 2, bool noTracking = false) : base(
            capacity,
            capacityIncreaseMultiplier,
            noTracking
        )
        {
        }

        public ShaderList(AppaList<Shader> list) : base(list)
        {
        }

        public ShaderList(Shader[] values) : base(values)
        {
        }
    }
}
