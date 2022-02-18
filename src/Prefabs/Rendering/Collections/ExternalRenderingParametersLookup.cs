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
        stringList, AppaList_ExternalRenderingParameters>
    {
        /// <inheritdoc />
        protected override Color GetDisplayColor(string key, ExternalRenderingParameters value)
        {
            return Color.white;
        }

        /// <inheritdoc />
        protected override string GetDisplaySubtitle(string key, ExternalRenderingParameters value)
        {
            return value.name;
        }

        /// <inheritdoc />
        protected override string GetDisplayTitle(string key, ExternalRenderingParameters value)
        {
            return key;
        }
    }
}
