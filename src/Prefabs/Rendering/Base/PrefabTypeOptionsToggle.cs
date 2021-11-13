#region

using System;
using Appalachia.Core.Attributes.Editing;
using Appalachia.Core.Collections;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.Base
{
    [Serializable]
    [HideReferenceObjectPicker]
    public abstract class PrefabTypeOptionsToggle<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE,
                                                  IL_TW, IL_TT>
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
        [HideInInspector]
        [SerializeField]
        public TW options;

        private Color _normalColor = Color.white;

        protected PrefabTypeOptionsToggle()
        {
        }

        protected PrefabTypeOptionsToggle(TW options)
        {
            this.options = options;
        }

        private string _label => options.options.isEnabled ? "Enabled" : "Disabled";

#if UNITY_EDITOR
        [SmartLabel]
        [SmartInlineButton(nameof(PingType),   bold: true, color: nameof(_normalColor))]
        [SmartInlineButton(nameof(SelectType), bold: true, color: nameof(_normalColor))]
        [SmartInlineButton(nameof(Mute),       bold: true, color: nameof(_muteColor))]
        [SmartInlineButton(nameof(Solo),       bold: true, color: nameof(_soloColor))]
        [SmartInlineButton(
            nameof(Enable),
            bold: true,
            color: nameof(_stateColor),
            label: "$" + nameof(_label)
        )]
        [ShowInInspector]
#endif
        public TE type
        {
            get => options.type;

            // ReSharper disable once ValueParameterNotUsed
            set { }
        }

        private Color _stateColor => options.options._stateColor;

        private Color _soloColor => options.options._soloColor;
        private Color _muteColor => options.options._muteColor;

        private void Enable()
        {
            options.Enable(!options.options.isEnabled);
        }

        private void Solo()
        {
            options.Solo(!options.options.Soloed);
        }

        private void Mute()
        {
            options.Mute(!options.options.Muted);
        }

#if UNITY_EDITOR
        private void PingType()
        {
            UnityEditor.EditorGUIUtility.PingObject(options);
        }

        private void SelectType()
        {
            UnityEditor.Selection.SetActiveObjectWithContext(options, options);
        }
#endif
    }
}
