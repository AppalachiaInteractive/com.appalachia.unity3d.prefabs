#region

using System;
using Appalachia.Core.AssetMetadata.Options.ContentType;
using Appalachia.Core.AssetMetadata.Options.ModelType;
using Appalachia.Core.Collections.Implementations.Lists;
using Appalachia.Core.Collections.Implementations.Lookups;
using Appalachia.Core.Collections.Interfaces;
using Appalachia.Core.Editing.Coloring;
using Appalachia.Core.Scriptables;
using GPUInstancer;
using Sirenix.OdinInspector;
using Unity.Profiling;
using UnityEngine;

#endregion

namespace Appalachia.Core.Rendering.Metadata
{
    public class PrefabRenderingSetCollection : SelfSavingSingletonScriptableObject<PrefabRenderingSetCollection>
    {
        private const string _TAB = "TAB";
        private const string _QUICK = "Quick";
        private const string _QUICK_ = _TAB + "/" + _QUICK;
        private const string _QUICK_A = _QUICK_ + "/A";
        private const string _FULL = "Detailed";

        #region ProfilerMarkers

        private const string _PRF_PFX = nameof(PrefabRenderingSetCollection) + ".";
        private static readonly ProfilerMarker _PRF_Sets = new ProfilerMarker(_PRF_PFX + nameof(Sets));
        private static readonly ProfilerMarker _PRF_WhenEnabled = new ProfilerMarker(_PRF_PFX + nameof(WhenEnabled));
        private static readonly ProfilerMarker _PRF_RemoveInvalid = new ProfilerMarker(_PRF_PFX + nameof(RemoveInvalid));

        private static readonly ProfilerMarker _PRF_RebuildToggleList = new ProfilerMarker(_PRF_PFX + nameof(RebuildToggleList));

        private static readonly ProfilerMarker _PRF_DoForAll = new ProfilerMarker(_PRF_PFX + nameof(DoForAll));

        private static readonly ProfilerMarker _PRF_DoForAllIf = new ProfilerMarker(_PRF_PFX + nameof(DoForAllIf));

        private static readonly ProfilerMarker _PRF_TearDown = new ProfilerMarker(_PRF_PFX + nameof(TearDown));

#endregion

        [TabGroup(_TAB, _QUICK)]
        [SerializeField, ShowInInspector, HideLabel, LabelWidth(0)]
        [ListDrawerSettings(
            Expanded = true,
            DraggableItems = false,
            HideAddButton = true,
            HideRemoveButton = true,
            ShowPaging = true,
            NumberOfItemsPerPage = 25
        )]
        private PrefabRenderingSetToggleLookup _toggles;

        [TabGroup(_TAB, _FULL)]
        [SerializeField, InlineProperty, HideLabel, LabelWidth(0)]
        [ListDrawerSettings(Expanded = true, DraggableItems = false, HideAddButton = true, HideRemoveButton = true, NumberOfItemsPerPage = 2)]
        private PrefabRenderingSetLookup _state;

        /*[Button]
        public void Reset()
        {
            this.Clear();
        }*/
        /*static PrefabRenderingSetCollection()
        {
        }*/

        private bool _anyDisabled
        {
            get { return _state.Any(s => !s.renderingEnabled); }
        }

        private bool _anyEnabled
        {
            get { return _state.Any(s => s.renderingEnabled); }
        }

        private bool _anySoloed => PrefabRenderingSet.AnySolo;
        private bool _anyMuted => PrefabRenderingSet.AnyMute;

        private Color _enabledColor => _anyDisabled ? ColorPrefs.Instance.Enabled.v : Color.white;
        private Color _disabledColor => _anyEnabled ? ColorPrefs.Instance.DisabledImportant.v : Color.white;
        private Color _soloedColor => _anySoloed ? ColorPrefs.Instance.SoloEnabled.v : Color.white;
        private Color _mutedColor => _anyMuted ? ColorPrefs.Instance.MuteEnabled.v : Color.white;

        public IAppaLookupSafeUpdates<GameObject, PrefabRenderingSet, AppaList_PrefabRenderingSet> Sets
        {
            get
            {
                using (_PRF_Sets.Auto())
                {
                    if (_state == null)
                    {
                        _state = new PrefabRenderingSetLookup();
                        SetDirty();

                        _state.SetDirtyAction(SetDirty);
                    }

                    return _state;
                }
            }
        }
        
        private PrefabContentTypeCounts _contentTypeCounts;
        private PrefabModelTypeCounts _modelTypeCounts;

        public PrefabContentTypeCounts ContentTypeCounts
        {
            get
            {
                if (_contentTypeCounts == null)
                {
                    _contentTypeCounts = new PrefabContentTypeCounts();
                    _contentTypeCounts.RefreshRuntimeCounts();
                }

                return _contentTypeCounts;
            }
        }

        public PrefabModelTypeCounts ModelTypeCounts
        {
            get
            {
                if (_modelTypeCounts == null)
                {
                    _modelTypeCounts = new PrefabModelTypeCounts();
                    _modelTypeCounts.RefreshRuntimeCounts();
                }

                return _modelTypeCounts;
            }
        }
        
        public void RefreshRuntimeCounts()
        {
            if (_contentTypeCounts == null) _contentTypeCounts = new PrefabContentTypeCounts();
            if (_modelTypeCounts == null) _modelTypeCounts = new PrefabModelTypeCounts();
            
            _contentTypeCounts.RefreshRuntimeCounts();
            _modelTypeCounts.RefreshRuntimeCounts();
        }

        [TabGroup(_TAB, _QUICK)]
        [ResponsiveButtonGroup(_QUICK_A), EnableIf(nameof(_anyDisabled)), GUIColor(nameof(_enabledColor)), PropertyOrder(-10)]
        public void EnableAll()
        {
            for (var i = 0; i < _state.Count; i++)
            {
                _state.at[i].Enable(true);
                _state.at[i].SetDirty();
            }
        }

        [ResponsiveButtonGroup(_QUICK_A), EnableIf(nameof(_anyEnabled)), GUIColor(nameof(_disabledColor)), PropertyOrder(-10)]
        public void DisableAll()
        {
            for (var i = 0; i < _state.Count; i++)
            {
                _state.at[i].Enable(false);
                _state.at[i].SetDirty();
            }
        }

        [ResponsiveButtonGroup(_QUICK_A), EnableIf(nameof(_anySoloed)), GUIColor(nameof(_soloedColor)), PropertyOrder(-10)]
        public void UnsoloAll()
        {
            for (var i = 0; i < _state.Count; i++)
            {
                _state.at[i].Solo(false);
                _state.at[i].SetDirty();
            }
        }

        [ResponsiveButtonGroup(_QUICK_A), EnableIf(nameof(_anyMuted)), GUIColor(nameof(_mutedColor)), PropertyOrder(-10)]
        public void UnmuteAll()
        {
            for (var i = 0; i < _state.Count; i++)
            {
                _state.at[i].Mute(false);
                _state.at[i].SetDirty();
            }
        }

        private Color _baseColor = Color.white;
        
        [ResponsiveButtonGroup(_QUICK_A), GUIColor(nameof(_baseColor)), PropertyOrder(-10)]
        public void Types()
        {
            for (var i = 0; i < _state.Count; i++)
            {
                _state.at[i].AssignPrefabTypes();
                _state.at[i].SetDirty();
            }
        }

        protected override void WhenEnabled()
        {
            using (_PRF_WhenEnabled.Auto())
            {
                if (_state == null)
                {
                    _state = new PrefabRenderingSetLookup();
                    SetDirty();
                }

                _state.SetDirtyAction(SetDirty);

                if (_toggles == null)
                {
                    _toggles = new PrefabRenderingSetToggleLookup();
                    SetDirty();
                }

                RebuildToggleList();

                _toggles.SetDirtyAction(SetDirty);
            }
        }


        public void RemoveInvalid()
        {
            using (_PRF_RemoveInvalid.Auto())
            {
                for (var i = _state.Count - 1; i >= 0; i--)
                {
                    var renderingSet = _state.at[i];

                    if ((renderingSet == null) || (renderingSet.prefab == null))
                    {
                        _state.RemoveAt(i);
                    }
                }

                SetDirty();
            }
        }

        private void RebuildToggleList()
        {
            using (_PRF_RebuildToggleList.Auto())
            {
                if ((_toggles == null) || (_toggles.Count != _state.Count))
                {
                    _toggles = new PrefabRenderingSetToggleLookup();

                    for (var i = 0; i < _state.Count; i++)
                    {
                        var s = _state.at[i];

                        _toggles.Add(s.prefab, new PrefabRenderingSetToggle(s));
                    }
                }
            }
        }

        public void DoForAll(Action<PrefabRenderingSet> action)
        {
            using (_PRF_DoForAll.Auto())
            {
                var count = Sets.Count;

                for (var i = 0; i < count; i++)
                {
                    action(Sets.at[i]);
                }
            }
        }

        public void DoForAllIf(Predicate<PrefabRenderingSet> doIf, Action<PrefabRenderingSet> action)
        {
            using (_PRF_DoForAllIf.Auto())
            {
                var count = Sets.Count;

                for (var i = 0; i < count; i++)
                {
                    var set = Sets.at[i];

                    if (doIf(set))
                    {
                        action(set);
                    }
                }
            }
        }

        public void TearDown(GPUInstancerPrefabManager gpui, Action<string> progress)
        {
            using (_PRF_TearDown.Auto())
            {
                RemoveInvalid();

                for (var setIndex = _state.Count - 1; setIndex >= 0; setIndex--)
                {
                    var renderingSet = _state.at[setIndex];

                    if ((renderingSet == null) || (renderingSet.prefab == null))
                    {
                        progress(string.Empty);

                        _state.RemoveAt(setIndex);
                        continue;
                    }

                    progress(renderingSet.prefab.name);

                    renderingSet.TearDown(gpui);
                }
            }
        }
    }
}
