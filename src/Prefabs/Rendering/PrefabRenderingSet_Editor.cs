#if UNITY_EDITOR

#region

using System;
using Appalachia.Core.Attributes.Editing;
using Appalachia.Rendering.Prefabs.Core;
using Appalachia.Rendering.Prefabs.Rendering.Collections;
using Appalachia.Rendering.Prefabs.Rendering.ContentType;
using Appalachia.Rendering.Prefabs.Rendering.Data;
using Appalachia.Rendering.Prefabs.Rendering.ModelType;
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
        #region Metadata Methods

        [TabGroup(_TABS, _META)]
        [SmartLabel]
        [Button]
        public void AssignPrefabTypes()
        {
            if (!_modelType.overrideEnabled || (modelType == PrefabModelType.None))
            {
                modelType = PrefabModelTypeOptionsLookup.instance.GetPrefabType(labels);
            }

            modelOptions.type = modelType;

            if (!_contentType.overrideEnabled || (contentType == PrefabContentType.None))
            {
                contentType = PrefabContentTypeOptionsLookup.instance.GetPrefabType(labels);
            }

            contentOptions.type = contentType;
        }

        #endregion

        #region Base Class

        private void OnEnable()
        {
            if (_externalParameters == null)
            {
                _externalParameters = new ExternalRenderingParametersLookup();
                SetDirty();
            }

            _externalParameters.SetDirtyAction(SetDirty);

            //_assetType = _assetType.CheckObsolete();
        }

        protected override bool ShowIDProperties => false;

        #endregion

        #region Fields & Properties

        private void ModelType()
        {
            UnityEditor.Selection.SetActiveObjectWithContext(modelOptions.typeOptions, this);
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
        private void SetRenderingLocations()
        {
            if (locations == null)
            {
                locations = PrefabRenderingSetLocations.LoadOrCreateNew(name);
            }

            locations.SetFromInstance(this);
        }

        [TabGroup(_TABS, _META)]
        [SmartLabel]
        [Button]
        private void BuryMeshes()
        {
            //MeshBurialManagementProcessor.EnqueuePrefabRenderingSet(this);
        }

        [TabGroup(_TABS, _META)]
        [SmartLabel]
        [Button]
        private void ResetBurials()
        {
            //MeshBurialAdjustmentCollection.instance.GetByPrefab(prefab).Reset();
        }

        [TabGroup(_TABS, _META)]
        [SmartLabel]
        [Button]
        private void ResetInstances()
        {
            TearDown(PrefabRenderingManager.instance.gpui);
        }

        [TabGroup(_TABS, _META)]
        [SmartLabel]
        [Button]
        private void DefaultPositions()
        {
            useLocations = false;
            ResetInstances();
        }

        #endregion
    }
}

#endif