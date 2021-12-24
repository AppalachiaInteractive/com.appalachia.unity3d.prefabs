#region

using Appalachia.Core.Attributes;
using Appalachia.Core.Collections.Implementations.Lists;
using Appalachia.Core.Collections.Implementations.Lookups;
using Appalachia.Core.Collections.Interfaces;
using Appalachia.Core.Objects.Root;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Replacement
{
    [Critical]
    public class
        PrefabReplacementCollection : SingletonAppalachiaObject<
            PrefabReplacementCollection>
    {
        [SerializeField]
        [ListDrawerSettings(
            Expanded = true,
            DraggableItems = false,
            HideAddButton = true,
            HideRemoveButton = true,
            NumberOfItemsPerPage = 5
        )]
        private GameObjectReplacementLookup _state;

        public IAppaLookup<GameObject, GameObject, AppaList_GameObject> State
        {
            get
            {
                if (_state == null)
                {
                    _state = new GameObjectReplacementLookup();
#if UNITY_EDITOR
                   this.MarkAsModified();

                   _state.SetObjectOwnership(this);
#endif
                }

                return _state;
            }
        }

        protected override void WhenEnabled()
        {
            if (_state == null)
            {
                _state = new GameObjectReplacementLookup();
#if UNITY_EDITOR
               this.MarkAsModified();
#endif
            }

#if UNITY_EDITOR
            _state.SetObjectOwnership(this);
#endif
        }
    }
}
