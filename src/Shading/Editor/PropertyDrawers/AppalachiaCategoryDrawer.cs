using Appalachia.Rendering.Shading.Inspectors;
using UnityEditor;
using UnityEngine;

namespace Appalachia.Rendering.Shading.PropertyDrawers
{
    public class AppalachiaCategoryDrawer : MaterialPropertyDrawer
    {
        public AppalachiaCategoryDrawer(string c)
        {
            Category = c;
        }

        #region Fields and Autoproperties

        protected string Category;

        #endregion

        /// <inheritdoc />
        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
        {
            return 40;
        }

        /// <inheritdoc />
        public override void OnGUI(
            Rect position,
            MaterialProperty prop,
            string label,
            MaterialEditor materiaEditor)
        {
            //EditorGUI.DrawRect(position, new Color(0, 1, 0, 0.1f));

            GUI.enabled = true;
            AppalachiaShaderEditorGUI.DrawCategory(position, Category);
        }
    }
}
