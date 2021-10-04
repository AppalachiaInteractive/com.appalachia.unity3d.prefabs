#region

using System;
using Appalachia.Editing.Attributes;
using Sirenix.OdinInspector;
using UnityEditor;
using UnityEngine;

#endregion

namespace Appalachia.Prefabs.Rendering
{
    [Serializable, HideReferenceObjectPicker]
    public class PrefabRenderingSetToggle
    {
        private Color _normalColor = Color.red;

        [HideInInspector, SerializeField]
        public PrefabRenderingSet set;

        public PrefabRenderingSetToggle(PrefabRenderingSet set)
        {
            this.set = set;
        }

        private string _label => set.renderingEnabled ? "Enabled" : "Disabled";

        [SmartLabel]
        [SmartInlineButton(nameof(PingType),   bold: true, color: nameof(_normalColor))]
        [SmartInlineButton(nameof(SelectType), bold: true, color: nameof(_normalColor))]
        [SmartInlineButton(nameof(Mute),       bold: true, color: nameof(_muteColor))]
        [SmartInlineButton(nameof(Solo),       bold: true, color: nameof(_soloColor))]
        [SmartInlineButton(nameof(Enable),     bold: true, color: nameof(_stateColor), label: "$" + nameof(_label))]
        [ShowInInspector]
        public GameObject prefab
        {
            get => set.prefab;

            // ReSharper disable once ValueParameterNotUsed
            set { }
        }

        public Color _stateColor => set._stateColor;
        private Color _soloColor => set._soloColor;
        private Color _muteColor => set._muteColor;

        private void Enable()
        {
            set.Enable();
        }

        private void Solo()
        {
            set.Solo();
        }

        private void Mute()
        {
            set.Mute();
        }

#if UNITY_EDITOR
        private void PingType()
        {
            EditorGUIUtility.PingObject(set);
        }

        private void SelectType()
        {
            Selection.SetActiveObjectWithContext(set, set);
        }
#endif
    }
}
