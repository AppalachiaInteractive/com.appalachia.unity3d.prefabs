#region

using System;
using Appalachia.Core.Collections;
using Appalachia.Core.Collections.Implementations.Lists;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Collections
{
    [Serializable]
    public class ExternalRenderingParametersLookup : AppaLookup<string, ExternalRenderingParameters,
        AppaList_string, AppaList_ExternalRenderingParameters>
    {
        protected override string GetDisplayTitle(string key, ExternalRenderingParameters value)
        {
            return key;
        }

        protected override string GetDisplaySubtitle(string key, ExternalRenderingParameters value)
        {
            return value.name;
        }

        protected override Color GetDisplayColor(string key, ExternalRenderingParameters value)
        {
            return Color.white;
        }
    }
}
