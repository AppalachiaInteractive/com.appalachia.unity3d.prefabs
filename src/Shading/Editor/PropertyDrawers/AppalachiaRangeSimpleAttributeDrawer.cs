using UnityEditor;
using UnityEngine;

namespace Appalachia.Rendering.Shading.PropertyDrawers
{
    [CustomPropertyDrawer(typeof(AppalachiaRangeSimpleAttribute))]
    public class AppalachiaRangeSimpleAttributeDrawer : PropertyDrawer
    {
        #region Fields and Autoproperties

        private AppalachiaRangeSimpleAttribute a;
        private float max;

        private float min;
        private string[] options;

        #endregion

        /// <inheritdoc />
        public override float GetPropertyHeight(SerializedProperty property, GUIContent label)
        {
            return -2;
        }

        /// <inheritdoc />
        public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
        {
            a = (AppalachiaRangeSimpleAttribute)attribute;

            min = a.min;
            max = a.max;

            GUILayout.BeginHorizontal();
            GUILayout.Space(20);
            property.floatValue = GUILayout.HorizontalSlider(property.floatValue, min, max);
            GUILayout.Space(20);
            GUILayout.EndHorizontal();
        }
    }
}
