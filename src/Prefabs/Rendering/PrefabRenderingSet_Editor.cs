#if UNITY_EDITOR

#region

using System;
using Appalachia.Core.Attributes.Editing;
using Appalachia.Core.Scriptables;
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
        protected override bool ShowIDProperties => false;

        #region Event Functions

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

        #endregion

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
        private void SetRenderingLocations()
        {
            if (locations == null)
            {
                locations = AppalachiaObject.LoadOrCreateNew<PrefabRenderingSetLocations>(name);
            }

            locations.SetFromInstance(this);
        }
    }
}

#endif
