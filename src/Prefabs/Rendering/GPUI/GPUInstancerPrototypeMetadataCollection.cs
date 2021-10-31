#region

using System.Collections.Generic;
using Appalachia.Core.Scriptables;
using Appalachia.Rendering.Prefabs.Rendering.Collections;
using GPUInstancer;
using Sirenix.OdinInspector;
using Unity.Profiling;
using UnityEngine;
using UnityEngine.Serialization;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.GPUI
{
    public class GPUInstancerPrototypeMetadataCollection : SingletonAppalachiaObject<
        GPUInstancerPrototypeMetadataCollection>
    {
        private const string _PRF_PFX = nameof(GPUInstancerPrototypeMetadataCollection) + ".";

        [FormerlySerializedAs("_metadatas")]
        [SerializeField]
        [ListDrawerSettings(
            Expanded = true,
            DraggableItems = false,
            HideAddButton = true,
            HideRemoveButton = true,
            NumberOfItemsPerPage = 3
        )]
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
        private static readonly ProfilerMarker _PRF_FindOrCreate =
            new(_PRF_PFX + nameof(FindOrCreate));

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

                var newPrototypePair = GPUInstancerPrototypeMetadata.LoadOrCreateNew(
                    gameObject.name,
                    true,
                    false
                );

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
