using Appalachia.Rendering.Shading.Inspectors;
using UnityEditor;
using UnityEngine;

namespace Appalachia.Rendering.Shading.PropertyDrawers
{
    [CustomPropertyDrawer(typeof(AppalachiaCategoryAttribute))]
    public class AppalachiaCategoryAttributeDrawer : PropertyDrawer
    {
        private AppalachiaCategoryAttribute a;
        private string category;

        public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
        {
            a = (AppalachiaCategoryAttribute) attribute;
            category = a.Category;

            GUI.enabled = true;
            AppalachiaShaderEditorGUI.DrawCategory(position, category);
        }

        public override float GetPropertyHeight(SerializedProperty property, GUIContent label)
        {
            return 40;
        }
    }
}
