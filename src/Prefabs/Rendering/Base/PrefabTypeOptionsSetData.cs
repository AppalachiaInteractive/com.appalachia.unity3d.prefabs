#region

using System;
using Appalachia.Core.Collections;
using Appalachia.Core.Scriptables;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.Serialization;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Base
{
    [Serializable]
    public abstract class PrefabTypeOptionsSetData<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE,
                                                   IL_TW, IL_TT> :
        SelfSavingAndIdentifyingScriptableObject<TSD>
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
            nameof(PrefabTypeOptionsSetData<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW,
                IL_TT>) +
            ".";

        [FormerlySerializedAs("modelType")]
        [FormerlySerializedAs("prefabType")]
        [SerializeField]
        [HideInInspector]
        public TE type;

        [SerializeField]
        [InlineProperty]
        [HideLabel]
        [LabelWidth(0)]
        protected TOO _setOverrides;

        [FormerlySerializedAs("modelTypeOptions")]
        [SerializeField]
        [HideInInspector]
        protected TW _typeOptions;

        protected override bool ShowIDProperties { get; } = false;

        public TW typeOptions
        {
            get
            {
                if (_typeOptions == null)
                {
                    _typeOptions =
                        PrefabTypeOptionsLookup<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW
                            , IL_TT>.instance.GetTypeOptions(type);
                }

                return _typeOptions;
            }
        }

        public abstract void SyncOverridesFull(bool hasInteractions, bool hasColliders);
        public abstract void SyncOverrides();
    }
}
