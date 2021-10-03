#region

using System.Collections.Generic;
using Appalachia.Core.Collections.Implementations.Lookups;
using Appalachia.Core.Scriptables;
using GPUInstancer;
using Sirenix.OdinInspector;
using Unity.Profiling;
using UnityEngine;
using UnityEngine.Serialization;

#endregion

namespace Appalachia.Core.Rendering.Metadata.GPUI
{
    public class GPUInstancerPrototypeMetadataCollection : SelfSavingSingletonScriptableObject<GPUInstancerPrototypeMetadataCollection>
    {
        private const string _PRF_PFX = nameof(GPUInstancerPrototypeMetadataCollection) + ".";
        
        [FormerlySerializedAs("_metadatas")]
        [SerializeField]
        [ListDrawerSettings(Expanded = true, DraggableItems = false, HideAddButton = true, HideRemoveButton = true, NumberOfItemsPerPage = 3)]
        private GPUInstancerPrototypeMetadataLookup _state;

        protected override void WhenEnabled()
        {
            if (_state == null)
            {
                _state = new GPUInstancerPrototypeMetadataLookup();
                SetDirty();
            }

            _state.SetDirtyAction(SetDirty);
        }

        public void ConfirmPrototype(GPUInstancerPrototypeMetadata metadata)
        {
            _state.AddIfKeyNotPresent(metadata.prototype.prefabObject.name, metadata);
        }

#if UNITY_EDITOR
        private static readonly ProfilerMarker _PRF_FindOrCreate = new ProfilerMarker(_PRF_PFX + nameof(FindOrCreate));
        public GPUInstancerPrototypeMetadata FindOrCreate(
            GameObject gameObject,
            GPUInstancerPrefabManager gpui,
            Dictionary<GPUInstancerPrefabPrototype, RegisteredPrefabsData> prototypeLookup)
        {
            using (_PRF_FindOrCreate.Auto())
            {
                if (_state.ContainsKey(gameObject.name))
                {
                    var metadata = _state[gameObject.name];

                    metadata.CreatePrototypeIfNecessary(gameObject, gpui, prototypeLookup);
                    return metadata;
                }

                var newPrototypePair = GPUInstancerPrototypeMetadata.LoadOrCreateNew(gameObject.name, true, true, false);

                newPrototypePair.CreatePrototypeIfNecessary(gameObject, gpui, prototypeLookup);

                _state.AddOrUpdate(gameObject.name, newPrototypePair);

                newPrototypePair.SetDirty();
                SetDirty();

                return newPrototypePair;
            }
        }
#endif
    }
}