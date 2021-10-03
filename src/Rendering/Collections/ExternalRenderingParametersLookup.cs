#region

using System;
using Appalachia.Core.Collections.Implementations.Lists;
using Appalachia.Core.Rendering.Metadata;
using UnityEngine;

#endregion

namespace Appalachia.Core.Collections.Implementations.Lookups
{
    [Serializable]
    public class ExternalRenderingParametersLookup : AppaLookup<string, ExternalRenderingParameters, AppaList_string,
        AppaList_ExternalRenderingParameters>
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
