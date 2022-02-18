using Appalachia.Rendering.Shading.Inspectors;
using UnityEditor;
using UnityEngine;

namespace Appalachia.Rendering.Shading.PropertyDrawers
{
    [CustomPropertyDrawer(typeof(AppalachiaCategoryAttribute))]
    public class AppalachiaCategoryAttributeDrawer : PropertyDrawer
    {
        #region Fields and Autoproperties

        private AppalachiaCategoryAttribute a;
        private string category;

        #endregion

        /// <inheritdoc />
        public override float GetPropertyHeight(SerializedProperty property, GUIContent label)
        {
            return 40;
        }

        /// <inheritdoc />
        public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
        {
            a = (AppalachiaCategoryAttribute)attribute;
            category = a.Category;

            GUI.enabled = true;
            AppalachiaShaderEditorGUI.DrawCategory(position, category);
        }
    }
}
