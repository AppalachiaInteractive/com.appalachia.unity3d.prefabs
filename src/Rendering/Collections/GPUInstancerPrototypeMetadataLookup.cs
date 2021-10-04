#region

using System;
using Appalachia.Core.Collections;
using Appalachia.Core.Collections.Implementations.Lists;
using Appalachia.Prefabs.Rendering.GPUI;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Prefabs.Rendering.Collections
{
    [Serializable]
    [ListDrawerSettings(Expanded = true, DraggableItems = false, HideAddButton = true, HideRemoveButton = true, NumberOfItemsPerPage = 5)]
    public class GPUInstancerPrototypeMetadataLookup : AppaLookup<string, GPUInstancerPrototypeMetadata, AppaList_string,
        AppaList_GPUInstancerPrototypeMetadata>
    {
        protected override string GetDisplayTitle(string key, GPUInstancerPrototypeMetadata value)
        {
            return value.name;
        }

        protected override string GetDisplaySubtitle(string key, GPUInstancerPrototypeMetadata value)
        {
            return key;
        }

        protected override Color GetDisplayColor(string key, GPUInstancerPrototypeMetadata value)
        {
            return Color.white;
        }
    }
}
