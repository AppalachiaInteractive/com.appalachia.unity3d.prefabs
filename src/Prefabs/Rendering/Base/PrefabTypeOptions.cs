#region

using System;
using Appalachia.Core.Attributes;
using Appalachia.Core.Collections;
using Appalachia.Core.Collections.Special;
using Appalachia.Core.Objects.Root;
using Appalachia.Core.Preferences.Globals;
using Unity.Profiling;
using UnityEngine;
using UnityEngine.Serialization;
using Object = UnityEngine.Object;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Base
{
    [Serializable]
    [CallStaticConstructorInEditor]
    public abstract class
        PrefabTypeOptions<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW, IL_TT> : AppalachiaBase<TO>
        where TE : Enum
        where TO : PrefabTypeOptions<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW, IL_TT>, new()
        where TOO : PrefabTypeOptionsOverride<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW, IL_TT>
        where TSD : PrefabTypeOptionsSetData<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW, IL_TT>
        where TW : PrefabTypeOptionsWrapper<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW, IL_TT>
        where TL : PrefabTypeOptionsLookup<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW, IL_TT>
        where TI : AppaLookup<TE, TW, IL_TE, IL_TW>, new()
        where TT : PrefabTypeOptionsToggle<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW, IL_TT>, new()
        where TOGI : AppaLookup<TE, TT, IL_TE, IL_TT>, new()
        where IL_TE : AppaList<TE>, new()
        where IL_TT : AppaList<TT>, new()
        where IL_TW : AppaList<TW>, new()

    {
        static PrefabTypeOptions()
        {
            When.Object<TL>().IsAvailableThen(i => _prefabTypeOptionsLookup = i);
        }

        protected PrefabTypeOptions()
        {
        }

        protected PrefabTypeOptions(Object owner) : base(owner)
        {
        }

        #region Static Fields and Autoproperties

        public static bool AnyMute { get; set; }

        public static bool AnySolo { get; set; }

        private static PrefabTypeOptionsLookup<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW, IL_TT>
            _prefabTypeOptionsLookup;

        #endregion

        #region Fields and Autoproperties

        [FormerlySerializedAs("optionsEnabled")]
        [FormerlySerializedAs("renderingEnabled")]
        [SerializeField]
        [HideInInspector]
        public bool isEnabled;

        [HideInInspector]
        [SerializeField]
        public TE type;

        [SerializeField]
        [HideInInspector]
        protected bool _muted;

        [SerializeField]
        [HideInInspector]
        protected bool _soloed;

        [HideInInspector]
        [SerializeField]
        protected DirtyStringCollection _dirty;

        #endregion

        public bool Muted => _muted;

        public bool Soloed => _soloed;

        public Color _muteColor =>
            _muted
                ? ColorPrefs.Instance.MuteEnabled.v
                : AnyMute
                    ? ColorPrefs.Instance.MuteAny.v
                    : ColorPrefs.Instance.MuteDisabled.v;

        public Color _soloColor =>
            _soloed
                ? ColorPrefs.Instance.SoloEnabled.v
                : AnySolo
                    ? ColorPrefs.Instance.SoloAny.v
                    : ColorPrefs.Instance.SoloDisabled.v;

        public Color _stateColor =>
            isEnabled ? ColorPrefs.Instance.Enabled.v : ColorPrefs.Instance.DisabledImportant.v;

        public abstract bool UpdateForValidity();

        public void Enable(bool enabled)
        {
            using (_PRF_Enable.Auto())
            {
                isEnabled = enabled;
            }
        }

        public void Mute(bool muted)
        {
            using (_PRF_Mute.Auto())
            {
                _muted = muted;

                ReloadSoloAndMute();
            }
        }

        public void Solo(bool soloed)
        {
            using (_PRF_Solo.Auto())
            {
                _soloed = soloed;

                ReloadSoloAndMute();
            }
        }

        protected void Enable()
        {
            using (_PRF_Enable.Auto())
            {
                isEnabled = !isEnabled;
            }
        }

        protected void Mute()
        {
            using (_PRF_Mute.Auto())
            {
                _muted = !_muted;

                ReloadSoloAndMute();
            }
        }

        protected void Solo()
        {
            using (_PRF_Solo.Auto())
            {
                _soloed = !_soloed;

                ReloadSoloAndMute();
            }
        }

        private static void ReloadSoloAndMute()
        {
            using (_PRF_ReloadSoloAndMute.Auto())
            {
                var sets = _prefabTypeOptionsLookup.State;

                AnySolo = false;
                AnyMute = false;

                for (var i = 0; i < sets.Count; i++)
                {
                    var set = sets.at[i];

                    if (set.options._soloed)
                    {
                        AnySolo = true;
                    }

                    if (set.options._muted)
                    {
                        AnyMute = true;
                    }
                }
            }
        }

        #region Profiling

        private static readonly ProfilerMarker _PRF_Enable = new ProfilerMarker(_PRF_PFX + nameof(Enable));

        private static readonly ProfilerMarker _PRF_Mute = new ProfilerMarker(_PRF_PFX + nameof(Mute));

        private static readonly ProfilerMarker _PRF_Solo = new ProfilerMarker(_PRF_PFX + nameof(Solo));

        private static readonly ProfilerMarker _PRF_ReloadSoloAndMute =
            new ProfilerMarker(_PRF_PFX + nameof(ReloadSoloAndMute));

        #endregion
    }
}
