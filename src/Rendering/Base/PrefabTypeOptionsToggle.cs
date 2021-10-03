#region

using System;
using Appalachia.Core.Collections;
using Appalachia.Core.Editing.Attributes;
using Sirenix.OdinInspector;
using UnityEditor;
using UnityEngine;

#endregion

namespace Appalachia.Core.AssetMetadata.Options.Base
{
    [Serializable, HideReferenceObjectPicker]

public abstract class PrefabTypeOptionsToggle<TE, TO, TOO, TSD, TW, TL, TI, TT, TOGI, IL_TE, IL_TW, IL_TT>
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
        private Color _normalColor = Color.white;

        [HideInInspector, SerializeField]
        public TW options;

        protected PrefabTypeOptionsToggle()
        {
        }

        protected PrefabTypeOptionsToggle(TW options)
        {
            this.options = options;
        }

        private string _label => options.options.isEnabled ? "Enabled" : "Disabled";

        [SmartLabel]
        [SmartInlineButton(nameof(PingType),   bold: true, color: nameof(_normalColor))]
        [SmartInlineButton(nameof(SelectType), bold: true, color: nameof(_normalColor))]
        [SmartInlineButton(nameof(Mute),       bold: true, color: nameof(_muteColor))]
        [SmartInlineButton(nameof(Solo),       bold: true, color: nameof(_soloColor))]
        [SmartInlineButton(nameof(Enable),     bold: true, color: nameof(_stateColor), label: "$" + nameof(_label))]
        [ShowInInspector]
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

        private void PingType()
        {
            EditorGUIUtility.PingObject(options);
        }

        private void SelectType()
        {
            Selection.SetActiveObjectWithContext(options, options);
        }
    }
}
