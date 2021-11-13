#region

using System;
using System.Collections.Generic;
using Appalachia.Core.Attributes;
using Appalachia.Core.Collections;
using Appalachia.Core.Collections.Interfaces;
using Appalachia.Core.Preferences.Globals;
using Appalachia.Core.Scriptables;
using Appalachia.Utility.Enums;
using Appalachia.Utility.Logging;
using Sirenix.OdinInspector;
using Unity.Profiling;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Base
{
    [Serializable]
    [AlwaysInitializeOnLoad]
    public abstract class PrefabTypeOptionsLookup<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE,
                                                  IL_TW, IL_TT> :
        SingletonAppalachiaObject<TL>
        where TE : Enum
        where TO : PrefabTypeOptions<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW, IL_TT>,
        new()
        where TOO : PrefabTypeOptionsOverride<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW,
            IL_TT>
        where TSD : PrefabTypeOptionsSetData<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW,
            IL_TT>
        where TW : PrefabTypeOptionsWrapper<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW,
            IL_TT>
        where TL : PrefabTypeOptionsLookup<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW,
            IL_TT>
        where TI : AppaLookup<TE, TW, IL_TE, IL_TW>, new()
        where TT : PrefabTypeOptionsToggle<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW,
            IL_TT>, new()
        where TOGI : AppaLookup<TE, TT, IL_TE, IL_TT>, new()
        where IL_TE : AppaList<TE>, new()
        where IL_TT : AppaList<TT>, new()
        where IL_TW : AppaList<TW>, new()

    {
        private const string _PRF_PFX =
            nameof(PrefabTypeOptionsLookup<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW,
                IL_TT>) +
            ".";

        protected const string _TAB = "TAB";
        protected const string _QUICK = "Quick";
        protected const string _QUICK_ = _TAB + "/" + _QUICK;
        protected const string _QUICK_A = _QUICK_ + "/A";
        protected const string _FULL = "Detailed";

        [NonSerialized] protected static EnumValuesCollection<TE> _types;

        private static readonly ProfilerMarker _PRF_Initialize = new(_PRF_PFX + nameof(Initialize));

#if UNITY_EDITOR
        private static readonly ProfilerMarker _PRF_GetPrefabType =
            new(_PRF_PFX + nameof(GetPrefabType));
#endif

        private static readonly ProfilerMarker _PRF_GetTypeOptions =
            new(_PRF_PFX + nameof(GetTypeOptions));

        [TabGroup(_TAB, _QUICK)]
        [SerializeField]
        [ShowInInspector]
        [HideLabel]
        [LabelWidth(0)]
        [ListDrawerSettings(
            Expanded = true,
            DraggableItems = false,
            HideAddButton = true,
            HideRemoveButton = true,
            ShowPaging = false,
            ShowItemCount = false
        )]
        protected TOGI _toggles;

        [TabGroup(_TAB, _FULL)]
        [SerializeField]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        [ListDrawerSettings(
            Expanded = true,
            DraggableItems = false,
            HideAddButton = true,
            HideRemoveButton = true,
            NumberOfItemsPerPage = 2
        )]
        protected TI _state;

        protected bool _anyDisabled
        {
            get { return _state.Any(s => !s.Enabled); }
        }

        protected bool _anyEnabled
        {
            get { return _state.Any(s => s.Enabled); }
        }

        protected abstract bool _anySoloed { get; }
        protected abstract bool _anyMuted { get; }

        protected Color _enabledColor =>
            _anyDisabled ? ColorPrefs.Instance.Enabled.v : ColorPrefs.Instance.EnabledDisabled.v;

        protected Color _disabledColor =>
            _anyEnabled
                ? ColorPrefs.Instance.DisabledImportant.v
                : ColorPrefs.Instance.DisabledImportantDisabled.v;

        protected Color _soloedColor =>
            _anySoloed ? ColorPrefs.Instance.SoloEnabled.v : ColorPrefs.Instance.SoloDisabled.v;

        protected Color _mutedColor =>
            _anyMuted ? ColorPrefs.Instance.MuteEnabled.v : ColorPrefs.Instance.MuteDisabled.v;

        public IAppaLookup<TE, TW, IL_TW> State
        {
            get
            {
                if (_state == null)
                {
                    _state = new TI();
#if UNITY_EDITOR
                    SetDirty();

                    _state.SetDirtyAction(SetDirty);
#endif
                }

                return _state;
            }
        }

        public TL GetInstance()
        {
            return instance;
        }

        [TabGroup(_TAB, _QUICK)]
        [ResponsiveButtonGroup(_QUICK_A)]
        [EnableIf(nameof(_anyDisabled))]
        [GUIColor(nameof(_enabledColor))]
        [PropertyOrder(-10)]
        public void EnableAll()
        {
            for (var i = 0; i < _state.Count; i++)
            {
                _state.at[i].Enable(true);
#if UNITY_EDITOR
                _state.at[i].SetDirty();
#endif
            }

#if UNITY_EDITOR
            SetDirty();
#endif
        }

        [ResponsiveButtonGroup(_QUICK_A)]
        [EnableIf(nameof(_anyEnabled))]
        [GUIColor(nameof(_disabledColor))]
        [PropertyOrder(-10)]
        public void DisableAll()
        {
            for (var i = 0; i < _state.Count; i++)
            {
                _state.at[i].Enable(false);
#if UNITY_EDITOR
                _state.at[i].SetDirty();
#endif
            }

#if UNITY_EDITOR
            SetDirty();
#endif
        }

        [ResponsiveButtonGroup(_QUICK_A)]
        [EnableIf(nameof(_anySoloed))]
        [GUIColor(nameof(_soloedColor))]
        [PropertyOrder(-10)]
        public void UnsoloAll()
        {
            for (var i = 0; i < _state.Count; i++)
            {
                _state.at[i].Solo(false);
#if UNITY_EDITOR
                _state.at[i].SetDirty();
#endif
            }

#if UNITY_EDITOR
            SetDirty();
#endif
        }

        [ResponsiveButtonGroup(_QUICK_A)]
        [EnableIf(nameof(_anyMuted))]
        [GUIColor(nameof(_mutedColor))]
        [PropertyOrder(-10)]
        public void UnmuteAll()
        {
            for (var i = 0; i < _state.Count; i++)
            {
                _state.at[i].Mute(false);
#if UNITY_EDITOR
                _state.at[i].SetDirty();
#endif
            }

#if UNITY_EDITOR
            SetDirty();
#endif
        }

        protected override void WhenEnabled()
        {
            Initialize();
        }

        public void Initialize()
        {
            using (_PRF_Initialize.Auto())
            {
                if (_state == null)
                {
                    _state = new TI();

#if UNITY_EDITOR
                    SetDirty();
#endif
                }

#if UNITY_EDITOR
                _state.SetDirtyAction(SetDirty);
#endif

                if (_toggles == null)
                {
                    _toggles = new TOGI();
#if UNITY_EDITOR
                    SetDirty();
#endif
                }

#if UNITY_EDITOR
                _toggles.SetDirtyAction(SetDirty);
#endif

                for (var i = _state.Count - 1; i >= 0; i--)
                {
                    var value = _state.at[i];

                    if (!Enum.IsDefined(typeof(TE), value.type))
                    {
                        _state.RemoveAt(i);
#if UNITY_EDITOR
                        SetDirty();
#endif
                    }
                }

                if ((_state.Count == _types.Length) && (_state.Count > 0))
                {
                    return;
                }

#if UNITY_EDITOR
                InitializeState();
#endif

                _toggles.Clear();

                for (var i = 0; i < _state.Count; i++)
                {
                    var s = _state.at[i];

                    var toggle = new TT {options = s};

                    _toggles.Add(s.type, toggle);
                }


#if UNITY_EDITOR
                SetDirty();
#endif
            }
        }

#if UNITY_EDITOR
        protected abstract void InitializeState();

        public TE GetPrefabType(IEnumerable<string> labels)
        {
            using (_PRF_GetPrefabType.Auto())
            {
                for (var i = 0; i < _state.Count; i++)
                {
                    var type = _state.at[i];

                    if (type.labels.CanSearch && type.labels.Matches(labels))
                    {
                        return type.type;
                    }
                }

                AppaLog.Warn("Could not find match...now logging.");

                Initialize();

                for (var i = 0; i < _state.Count; i++)
                {
                    var type = _state.at[i];

                    if (type.labels.CanSearch && type.labels.Matches(labels, true))
                    {
                        return type.type;
                    }
                }

                return default;
            }
        }
#endif

        public TW GetTypeOptions(TE type)
        {
            using (_PRF_GetTypeOptions.Auto())
            {
                //type = type.CheckObsolete();

                var options = _state[type];

                options.Refresh();

                return options;
            }
        }
    }
}
