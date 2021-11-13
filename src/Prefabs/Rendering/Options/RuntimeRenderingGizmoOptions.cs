#region

using System;
using Sirenix.OdinInspector;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Options
{
    [Serializable]
    public class RuntimeRenderingGizmoOptions
    {
#if UNITY_EDITOR
        [ToggleLeft] public bool burialGizmosEnabled = true;

        [ToggleLeft] public bool gizmosEnabled;

        [ToggleLeft] public bool gizmosLimitedToSelected;

        [ValueDropdown(nameof(gizmoSelections), AppendNextDrawer = false)]
        [EnableIf(nameof(_gizmoSelectionEnabled))]
        public int gizmoSelectionID;

        private ValueDropdownList<int> _gizmoSelectionIDs;

        private bool _gizmoSelectionEnabled => gizmosEnabled && gizmosLimitedToSelected;

        private ValueDropdownList<int> gizmoSelections
        {
            get
            {
                if ((_gizmoSelectionIDs == null) || (_gizmoSelectionIDs.Count == 0))
                {
                    var renderingSets = PrefabRenderingManager.instance.renderingSets;

                    if (_gizmoSelectionIDs == null)
                    {
                        _gizmoSelectionIDs = new ValueDropdownList<int>();
                    }

                    if ((renderingSets == null) || (renderingSets.Sets.Count == 0))
                    {
                        return _gizmoSelectionIDs;
                    }

                    for (var i = 0; i < renderingSets.Sets.Count; i++)
                    {
                        var set = renderingSets.Sets.at[i];

                        if (set.instanceManager.initializationCompleted)
                        {
                            _gizmoSelectionIDs.Add(new ValueDropdownItem<int>(set.prefab.name, i));
                        }
                    }
                }

                return _gizmoSelectionIDs;
            }
        }
#endif
    }
}
