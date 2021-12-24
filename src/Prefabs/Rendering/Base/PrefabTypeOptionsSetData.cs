#region

using System;
using Appalachia.Core.Attributes;
using Appalachia.Core.Collections;
using Appalachia.Core.Objects.Scriptables;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.Serialization;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Base
{
    [CallStaticConstructorInEditor]
    [Serializable]
    public abstract class PrefabTypeOptionsSetData<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW,
                                                   IL_TT> : IdentifiableAppalachiaObject<TSD>
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
        // [CallStaticConstructorInEditor] should be added to the class (initsingletonattribute)
        static PrefabTypeOptionsSetData()
        {
            PrefabTypeOptionsLookup<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW, IL_TT>
               .InstanceAvailable += i => _prefabTypeOptionsLookup = i;
        }

        #region Static Fields and Autoproperties

        private static PrefabTypeOptionsLookup<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW, IL_TT>
            _prefabTypeOptionsLookup;

        #endregion

        #region Fields and Autoproperties

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

#if UNITY_EDITOR
        protected override bool ShowIDProperties { get; }
#endif

        #endregion

        public TW typeOptions
        {
            get
            {
                if (_typeOptions == null)
                {
                    _typeOptions = _prefabTypeOptionsLookup.GetTypeOptions(type);
                }

                return _typeOptions;
            }
        }

        public abstract void SyncOverrides();

        public abstract void SyncOverridesFull(bool hasInteractions, bool hasColliders);

        #region Profiling

        private const string _PRF_PFX =
            nameof(PrefabTypeOptionsSetData<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW, IL_TT>) +
            ".";

        #endregion
    }
}
