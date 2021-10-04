#region

using System;
using Appalachia.Core.Collections;
using Appalachia.Core.Collections.Implementations.Lists;
using Appalachia.Core.Collections.Mathematics.List;
using Appalachia.Core.Extensions;
using Appalachia.Core.Types;
using Unity.Mathematics;
using UnityEngine;

#endregion

namespace Appalachia.Prefabs.Rendering.Data
{
    [Serializable]
    public class PrefabRenderingSetLocationModificationLookup :
        AppaLookup<int, float4x4, AppaList_int, AppaList_float4x4>,
        IGameDataComponent
    {
        protected override string GetDisplayTitle(int key, float4x4 value)
        {
            return $"Instance {key}";
        }

        protected override string GetDisplaySubtitle(int key, float4x4 value)
        {
            return value.ToStringTRS();
        }

        protected override Color GetDisplayColor(int key, float4x4 value)
        {
            return Color.white;
        }
    }
}
