#region

using System;
using System.Diagnostics;
using Appalachia.Core.Attributes;
using Appalachia.Core.Collections;
using Appalachia.Core.Objects.Root;
using Appalachia.Editing.Labels;
using Appalachia.Utility.Strings;
using Sirenix.OdinInspector;
using Unity.Profiling;
using UnityEngine;
using Object = UnityEngine.Object;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Base
{
    [Serializable]
    [CallStaticConstructorInEditor]
    public abstract class PrefabTypeOptionsWrapper<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW,
                                                   IL_TT> : AppalachiaObject<TW>
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
        static PrefabTypeOptionsWrapper()
        {
            PrefabRenderingManager.InstanceAvailable += i => _prefabRenderingManager = i;
        }

        #region Static Fields and Autoproperties

        private static PrefabRenderingManager _prefabRenderingManager;

        #endregion

        #region Fields and Autoproperties

        //[HideInInspector]
        [SerializeField] public TE type;

        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        [OnInspectorGUI(nameof(ConfirmValidity))]
        [SerializeField]
        protected TO _options;

#if UNITY_EDITOR
        [FoldoutGroup("$" + nameof(LabelHeader))]
        [PropertyOrder(1000)]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        [SerializeField]
        public LabelSearchSet labels;
#endif

        [SerializeField]
        [HideInInspector]
        protected bool _baseEnabledState;

        #endregion

        public abstract string Subtitle { get; }

        public abstract string Title { get; }

#if UNITY_EDITOR
        public virtual string LabelHeader => labels?.DisplayName ?? "Labels (None)";
#endif

        public bool Enabled => options.isEnabled;
        public bool Muted => options.Muted;
        public bool Soloed => options.Soloed;

        public TO options
        {
            get
            {
                if (_options == null)
                {
                    _options = new TO();
                    MarkAsModified();
                }

                return _options;
            }
        }

        [DebuggerStepThrough]
        public override string ToString()
        {
            return ZString.Format("{0}: {1}", Title, Subtitle);
        }

        public void Enable(bool enabled)
        {
            options.Enable(enabled);
#if UNITY_EDITOR
            MarkAsModified();
#endif
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

        public void Mute(bool muted)
        {
            options.Mute(muted);
#if UNITY_EDITOR
            MarkAsModified();
#endif
        }

        public void Refresh()
        {
            using (_PRF_Refresh.Auto())
            {
#if UNITY_EDITOR
                if (labels == null)
                {
                    labels = new LabelSearchSet(this);
                    MarkAsModified();
                }
#endif

                ConfirmValidity();
            }
        }
#if UNITY_EDITOR
        [HideInInlineEditors]
        [Button]
        [PropertyOrder(-100)]
        public void SelectPrefabRenderingManager()
        {
            UnityEditor.Selection.objects = new Object[] { _prefabRenderingManager };
        }
#endif

        public void Solo(bool soloed)
        {
            options.Solo(soloed);
#if UNITY_EDITOR
            MarkAsModified();
#endif
        }

        protected virtual void ConfirmValidity()
        {
            using (_PRF_ConfirmValidity.Auto())
            {
                if (_baseEnabledState && !options.isEnabled)
                {
                    MarkAsModified();
                }
                else if (!_baseEnabledState && options.isEnabled)
                {
                    MarkAsModified();
                }

                _options.type = type;
                _baseEnabledState = options.isEnabled;
                _options.UpdateForValidity();
            }
        }

        #region Profiling

        private const string _PRF_PFX =
            nameof(PrefabTypeOptionsWrapper<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW, IL_TT>) +
            ".";

        private static readonly ProfilerMarker _PRF_Initialize =
            new ProfilerMarker(_PRF_PFX + nameof(Initialize));

        private static readonly ProfilerMarker _PRF_ConfirmValidity = new(_PRF_PFX + nameof(ConfirmValidity));

        private static readonly ProfilerMarker _PRF_Refresh = new(_PRF_PFX + nameof(Refresh));

        #endregion
    }
}
