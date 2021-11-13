#region

using System;
using Appalachia.Core.Attributes.Editing;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering
{
    [Serializable]
    [HideReferenceObjectPicker]
    public class PrefabRenderingSetToggle
    {
        [HideInInspector]
        [SerializeField]
        public PrefabRenderingSet set;

        private Color _normalColor = Color.red;

        public PrefabRenderingSetToggle(PrefabRenderingSet set)
        {
            this.set = set;
        }

        private string _label => set.renderingEnabled ? "Enabled" : "Disabled";

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
            UnityEditor.EditorGUIUtility.PingObject(set);
        }

        private void SelectType()
        {
            UnityEditor.Selection.SetActiveObjectWithContext(set, set);
        }
#endif
    }
}
