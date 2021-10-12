#region

using System;
using Appalachia.Core.Collections;
using Appalachia.Core.Scriptables;
using Appalachia.Editing.Labels;
using Sirenix.OdinInspector;
using Unity.Profiling;
using UnityEditor;
using UnityEngine;
using Object = UnityEngine.Object;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Base
{
    [Serializable]
    public abstract class PrefabTypeOptionsWrapper<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE,
                                                   IL_TW, IL_TT> : SelfSavingScriptableObject<TW>
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
            nameof(PrefabTypeOptionsWrapper<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW,
                IL_TT>) +
            ".";

        private static readonly ProfilerMarker _PRF_ConfirmValidity =
            new(_PRF_PFX + nameof(ConfirmValidity));

        private static readonly ProfilerMarker _PRF_Initialize = new(_PRF_PFX + nameof(Initialize));

        private static readonly ProfilerMarker _PRF_Refresh = new(_PRF_PFX + nameof(Refresh));

        //[HideInInspector]
        [SerializeField] public TE type;

        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        [OnInspectorGUI(nameof(ConfirmValidity))]
        [SerializeField]
        protected TO _options;

        [FoldoutGroup("$" + nameof(LabelHeader))]
        [PropertyOrder(1000)]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        [SerializeField]
        public LabelSearchSet labels = new();

        [SerializeField]
        [HideInInspector]
        protected bool _baseEnabledState;

        public TO options
        {
            get
            {
                if (_options == null)
                {
                    _options = new TO();
                    SetDirty();
                }

                return _options;
            }
        }

        public abstract string Title { get; }
        public abstract string Subtitle { get; }

        public virtual string LabelHeader => labels?.DisplayName ?? "Labels (None)";

        public bool Enabled => options.isEnabled;
        public bool Soloed => options.Soloed;
        public bool Muted => options.Muted;
#if UNITY_EDITOR
        [HideInInlineEditors]
        [Button]
        [PropertyOrder(-100)]
        public void SelectPrefabRenderingManager()
        {
            Selection.objects = new Object[] {PrefabRenderingManager.instance};
        }
#endif
        protected virtual void ConfirmValidity()
        {
            using (_PRF_ConfirmValidity.Auto())
            {
                if (_baseEnabledState && !options.isEnabled)
                {
                    SetDirty();
                }
                else if (!_baseEnabledState && options.isEnabled)
                {
                    SetDirty();
                }

                _options.type = type;
                _baseEnabledState = options.isEnabled;
                _options.UpdateForValidity();
            }
        }

        public TW Initialize(TE te, TO to)
        {
            using (_PRF_Initialize.Auto())
            {
                type = te; //.CheckObsolete();
                _options = to;

                ConfirmValidity();

                return this as TW;
            }
        }

        public override string ToString()
        {
            return $"{Title}: {Subtitle}";
        }

        public void Enable(bool enabled)
        {
            options.Enable(enabled);
            SetDirty();
        }

        public void Solo(bool soloed)
        {
            options.Solo(soloed);
            SetDirty();
        }

        public void Mute(bool muted)
        {
            options.Mute(muted);
            SetDirty();
        }

        public void Refresh()
        {
            using (_PRF_Refresh.Auto())
            {
                if (labels == null)
                {
                    labels = new LabelSearchSet();
                    SetDirty();
                }

                ConfirmValidity();
            }
        }
    }
}
