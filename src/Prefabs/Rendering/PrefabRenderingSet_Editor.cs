#if UNITY_EDITOR

#region

using System;
using Appalachia.Core.Attributes.Editing;
using Appalachia.Rendering.Prefabs.Core;
using Appalachia.Rendering.Prefabs.Rendering.Collections;
using Appalachia.Rendering.Prefabs.Rendering.Data;
using Appalachia.Utility.Async;
using Sirenix.OdinInspector;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering
{
    [Serializable]
    [InlineEditor(Expanded = true, ObjectFieldMode = InlineEditorObjectFieldModes.Hidden)]
    [InlineProperty]
    [HideLabel]
    [LabelWidth(0)]
    public partial class PrefabRenderingSet
    {
        protected override bool ShowIDProperties => false;

        [TabGroup(_TABS, _META)]
        [SmartLabel]
        [Button]
        public void AssignPrefabTypes()
        {
            if (!_modelType.Overriding || (modelType == PrefabModelType.None))
            {
                modelType = _prefabModelTypeOptionsLookup.GetPrefabType(labels);
            }

            modelOptions.type = modelType;

            if (!_contentType.Overriding || (contentType == PrefabContentType.None))
            {
                contentType = _prefabContentTypeOptionsLookup.GetPrefabType(labels);
            }

            contentOptions.type = contentType;
        }

        protected override async AppaTask WhenEnabled()
        {
            await base.WhenEnabled();
            if (_externalParameters == null)
            {
                _externalParameters = new ExternalRenderingParametersLookup();
                MarkAsModified();
            }

            _externalParameters.SetSerializationOwner(this);

            //_assetType = _assetType.CheckObsolete();
        }

        [TabGroup(_TABS, _META)]
        [SmartLabel]
        [Button]
        private void BuryMeshes()
        {
            //MeshBurialManagementProcessor.EnqueuePrefabRenderingSet(this);
        }

        /*
        private void PingType()
        {
            EditorGUIUtility.PingObject(options.ModelTypeOptions);
        }
        */

        private void ContentType()
        {
            UnityEditor.Selection.SetActiveObjectWithContext(contentOptions.typeOptions, this);
        }

        [TabGroup(_TABS, _META)]
        [SmartLabel]
        [Button]
        private void DefaultPositions()
        {
            useLocations = false;
            ResetInstances();
        }

        private void ModelType()
        {
            UnityEditor.Selection.SetActiveObjectWithContext(modelOptions.typeOptions, this);
        }

        [TabGroup(_TABS, _META)]
        [SmartLabel]
        [Button]
        private void ResetBurials()
        {
            //_meshBurialAdjustmentCollection.GetByPrefab(prefab).Reset();
        }

        [TabGroup(_TABS, _META)]
        [SmartLabel]
        [Button]
        private void ResetInstances()
        {
            TearDown(_prefabRenderingManager.gpui);
        }

        [TabGroup(_TABS, _META)]
        [SmartLabel]
        [Button]
        private void SetRenderingLocations()
        {
            if (locations == null)
            {
                locations = PrefabRenderingSetLocations.LoadOrCreateNew(name);
            }

            locations.SetFromInstance(this);
        }
    }
}

#endif
