#region

using System;
using Appalachia.Core.Extensions;
using Appalachia.Rendering.Prefabs.Core;
using Appalachia.Rendering.Prefabs.Core.States;
using Appalachia.Rendering.Prefabs.Rendering.Base;
using Sirenix.OdinInspector;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.ContentType
{
    [Serializable]
    [InlineEditor(Expanded = true, ObjectFieldMode = InlineEditorObjectFieldModes.Foldout)]
    [InlineProperty]
    public class PrefabContentTypeOptionsWrapper : PrefabTypeOptionsWrapper<PrefabContentType,
        PrefabContentTypeOptions, PrefabContentTypeOptionsOverride, PrefabContentTypeOptionsSetData,
        PrefabContentTypeOptionsWrapper, PrefabContentTypeOptionsLookup,
        Index_PrefabContentTypeOptions, PrefabContentTypeOptionsToggle,
        Index_PrefabContentTypeOptionsToggle, AppaList_PrefabContentType,
        AppaList_PrefabContentTypeOptionsWrapper, AppaList_PrefabContentTypeOptionsToggle>
    {
        private int prefabCount =>
            PrefabRenderingManager.instance.renderingSets == null
                ? 0
                : PrefabRenderingManager.instance.renderingSets.ContentTypeCounts
                                        .GetPrefabTypeCount(type);

        private InstanceStateCounts instanceCounts =>
            PrefabRenderingManager.instance.renderingSets == null
                ? default
                : PrefabRenderingManager.instance.renderingSets.ContentTypeCounts.GetInstanceCount(
                    type
                );

        public override string Title => type.ToString().SeperateWords();

        //public string Subtitle => $"{prefabCount} prefabs | {instanceCounts.total} instances";
        public override string Subtitle => $"{prefabCount} prefabs | {instanceCounts.ToString()}";
    }
}
