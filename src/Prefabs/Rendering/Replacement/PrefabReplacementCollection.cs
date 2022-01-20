#region

using Appalachia.Core.Attributes;
using Appalachia.Core.Collections.Implementations.Lists;
using Appalachia.Core.Collections.Implementations.Lookups;
using Appalachia.Core.Collections.Interfaces;
using Appalachia.Core.Objects.Root;
using Appalachia.Utility.Async;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Replacement
{
    public class PrefabReplacementCollection : SingletonAppalachiaObject<PrefabReplacementCollection>
    {
        #region Fields and Autoproperties

        [SerializeField]
        [ListDrawerSettings(
            Expanded = true,
            DraggableItems = false,
            HideAddButton = true,
            HideRemoveButton = true,
            NumberOfItemsPerPage = 5
        )]
        private GameObjectReplacementLookup _state;

        #endregion

        public IAppaLookup<GameObject, GameObject, AppaList_GameObject> State
        {
            get
            {
                if (_state == null)
                {
                    _state = new GameObjectReplacementLookup();
#if UNITY_EDITOR
                    MarkAsModified();

                    _state.SetSerializationOwner(this);
#endif
                }

                return _state;
            }
        }

        protected override async AppaTask WhenEnabled()
        {
            using (_PRF_WhenEnabled.Auto())
            {
                await base.WhenEnabled();
                if (_state == null)
                {
                    _state = new GameObjectReplacementLookup();
#if UNITY_EDITOR
                    MarkAsModified();
#endif
                }

#if UNITY_EDITOR
                _state.SetSerializationOwner(this);
#endif
            }
        }

        #region Profiling

        

        #endregion
    }
}
