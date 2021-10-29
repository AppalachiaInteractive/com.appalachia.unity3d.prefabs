using Appalachia.Rendering.VFX.OutputEvents;
using UnityEditor;

namespace Appalachia.Rendering.Editor.VFX.OutputEvent
{
    [CustomEditor(typeof(VFXOutputEventCinemachineCameraShake))]
    class VFXOutputEventCinemachineCameraShakeEditor : VFXOutputEventHandlerEditor
    {
        SerializedProperty m_CinemachineImpulseSource;
        SerializedProperty m_AttributeSpace;

        protected override void OnEnable()
        {
            base.OnEnable();
            m_CinemachineImpulseSource = serializedObject.FindProperty(nameof(VFXOutputEventCinemachineCameraShake.cinemachineImpulseSource));
            m_AttributeSpace = serializedObject.FindProperty(nameof(VFXOutputEventCinemachineCameraShake.attributeSpace));
        }

        public override void OnInspectorGUI()
        {
            serializedObject.Update();
            EditorGUI.BeginChangeCheck();
			DrawOutputEventProperties();

            EditorGUILayout.PropertyField(m_CinemachineImpulseSource);
            EditorGUILayout.PropertyField(m_AttributeSpace);
            HelpBox("Attribute Usage", "- position : position of the camera impulse\n- velocity : impulse velocity");

            if (EditorGUI.EndChangeCheck())
                serializedObject.ApplyModifiedProperties();
        }
    }
}
