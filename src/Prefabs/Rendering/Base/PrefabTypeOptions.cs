#region

using System;
using Appalachia.Core.Attributes;
using Appalachia.Core.Collections;
using Appalachia.Core.Collections.Special;
using Appalachia.Core.Objects.Root;
using Appalachia.Core.Preferences.Globals;
using UnityEngine;
using UnityEngine.Serialization;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Base
{
    [Serializable]
    [CallStaticConstructorInEditor]
    public abstract class
        PrefabTypeOptions<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW, IL_TT> : AppalachiaSimpleBase
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
            PrefabTypeOptionsLookup<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW, IL_TT>
               .InstanceAvailable += i => _prefabTypeOptionsLookup = i;
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
            isEnabled = enabled;
        }

        public void Mute(bool muted)
        {
            _muted = muted;

            ReloadSoloAndMute();
        }

        public void Solo(bool soloed)
        {
            _soloed = soloed;

            ReloadSoloAndMute();
        }

        protected void Enable()
        {
            isEnabled = !isEnabled;
        }

        protected void Mute()
        {
            _muted = !_muted;

            ReloadSoloAndMute();
        }

        protected void Solo()
        {
            _soloed = !_soloed;

            ReloadSoloAndMute();
        }

        private static void ReloadSoloAndMute()
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

        #region Profiling

        private const string _PRF_PFX =
            nameof(PrefabTypeOptions<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW, IL_TT>) + ".";

        #endregion
    }
}
