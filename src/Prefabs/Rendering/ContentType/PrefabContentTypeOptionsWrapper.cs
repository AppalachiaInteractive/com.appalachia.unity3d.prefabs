#region

using System;
using Appalachia.Core.Attributes;
using Appalachia.Rendering.Prefabs.Core;
using Appalachia.Rendering.Prefabs.Core.States;
using Appalachia.Rendering.Prefabs.Rendering.Base;
using Appalachia.Utility.Extensions;
using Appalachia.Utility.Strings;
using Sirenix.OdinInspector;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.ContentType
{
    [Serializable]
    [InlineEditor(Expanded = true, ObjectFieldMode = InlineEditorObjectFieldModes.Foldout)]
    [InlineProperty]
    [CallStaticConstructorInEditor]
    public class PrefabContentTypeOptionsWrapper : PrefabTypeOptionsWrapper<PrefabContentType,
        PrefabContentTypeOptions, PrefabContentTypeOptionsOverride, PrefabContentTypeOptionsSetData,
        PrefabContentTypeOptionsWrapper, PrefabContentTypeOptionsLookup, Index_PrefabContentTypeOptions,
        PrefabContentTypeOptionsToggle, Index_PrefabContentTypeOptionsToggle, AppaList_PrefabContentType,
        AppaList_PrefabContentTypeOptionsWrapper, AppaList_PrefabContentTypeOptionsToggle>
    {
        static PrefabContentTypeOptionsWrapper()
        {
            When.Behaviour<PrefabRenderingManager>().IsAvailableThen(i => _prefabRenderingManager = i);
        }

        #region Static Fields and Autoproperties

        private static PrefabRenderingManager _prefabRenderingManager;

        #endregion

        //public string Subtitle => $"{prefabCount} prefabs | {instanceCounts.total} instances";
        /// <inheritdoc />
        public override string Subtitle =>
            ZString.Format("{0} prefabs | {1}", prefabCount, instanceCounts.ToString());

        /// <inheritdoc />
        public override string Title => type.ToString().SeperateWords();

        private InstanceStateCounts instanceCounts =>
            _prefabRenderingManager.renderingSets == null
                ? default
                : _prefabRenderingManager.renderingSets.ContentTypeCounts.GetInstanceCount(type);

        private int prefabCount =>
            _prefabRenderingManager.renderingSets == null
                ? 0
                : _prefabRenderingManager.renderingSets.ContentTypeCounts.GetPrefabTypeCount(type);
    }
}
