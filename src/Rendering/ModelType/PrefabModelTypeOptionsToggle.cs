#region

using System;
using Appalachia.Core.AssetMetadata.Options.Base;
using Sirenix.OdinInspector;

#endregion

namespace Appalachia.Core.AssetMetadata.Options.ModelType
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
