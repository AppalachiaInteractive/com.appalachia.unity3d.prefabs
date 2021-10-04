#region

using System;
using Appalachia.Prefabs.Core;
using Appalachia.Prefabs.Rendering.Base;
using Sirenix.OdinInspector;

#endregion

namespace Appalachia.Prefabs.Rendering.ModelType
{
    [Serializable, HideReferenceObjectPicker]

public class PrefabModelTypeOptionsToggle : PrefabTypeOptionsToggle<PrefabModelType, PrefabModelTypeOptions, PrefabModelTypeOptionsOverride,
        PrefabModelTypeOptionsSetData, PrefabModelTypeOptionsWrapper, PrefabModelTypeOptionsLookup, Index_PrefabModelTypeOptions,
        PrefabModelTypeOptionsToggle, Index_PrefabModelTypeOptionsToggle, AppaList_PrefabModelType, AppaList_PrefabModelTypeOptionsWrapper,
        AppaList_PrefabModelTypeOptionsToggle>
    {
        public PrefabModelTypeOptionsToggle()
        {
        }

        public PrefabModelTypeOptionsToggle(PrefabModelTypeOptionsWrapper options)
        {
            this.options = options;
        }
    }
}
