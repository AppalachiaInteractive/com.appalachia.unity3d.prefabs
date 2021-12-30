#region

using System.Collections.Generic;
using Appalachia.Core.Objects.Root;
using Appalachia.Rendering.Prefabs.Rendering.Collections;
using Appalachia.Utility.Async;
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
        #region Fields and Autoproperties

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

        #endregion

        internal GPUInstancerPrototypeMetadataLookup State => _state;

        public void ConfirmPrototype(GPUInstancerPrototypeMetadata metadata)
        {
            State.AddIfKeyNotPresent(metadata.prototype.prefabObject.name, metadata);
        }

        protected override async AppaTask WhenEnabled()
        {
            await base.WhenEnabled();

            if (State == null)
            {
                _state = new GPUInstancerPrototypeMetadataLookup();
#if UNITY_EDITOR
                MarkAsModified();
#endif
            }

#if UNITY_EDITOR
            State.SetObjectOwnership(this);
#endif
        }

        #region Profiling

        private const string _PRF_PFX = nameof(GPUInstancerPrototypeMetadataCollection) + ".";

        #endregion

#if UNITY_EDITOR
        private static readonly ProfilerMarker _PRF_FindOrCreate = new(_PRF_PFX + nameof(FindOrCreate));

        public GPUInstancerPrototypeMetadata FindOrCreate(
            GameObject gameObject,
            GPUInstancerPrefabManager gpui,
            Dictionary<GPUInstancerPrefabPrototype, RegisteredPrefabsData> prototypeLookup)
        {
            using (_PRF_FindOrCreate.Auto())
            {
                if (State.ContainsKey(gameObject.name))
                {
                    var metadata = State[gameObject.name];

                    metadata.CreatePrototypeIfNecessary(gameObject, gpui, prototypeLookup);
                    return metadata;
                }

                var newPrototypePair =
                    GPUInstancerPrototypeMetadata.LoadOrCreateNew<GPUInstancerPrototypeMetadata>(
                        $"{nameof(GPUInstancerPrototypeMetadata)}_{gameObject.name}"
                    );

                newPrototypePair.CreatePrototypeIfNecessary(gameObject, gpui, prototypeLookup);

                State.AddOrUpdate(gameObject.name, newPrototypePair);

                newPrototypePair.MarkAsModified();
                MarkAsModified();

                return newPrototypePair;
            }
        }
#endif
    }
}
