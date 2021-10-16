using Appalachia.Rendering.Shading.Inspectors;
using UnityEditor;
using UnityEngine;

namespace Appalachia.Rendering.Shading.PropertyDrawers
{
    public class AppalachiaCategoryDrawer : MaterialPropertyDrawer
    {
        protected string Category;

        public AppalachiaCategoryDrawer(string c)
        {
            Category = c;
        }

        public override void OnGUI(Rect position, MaterialProperty prop, string label, MaterialEditor materiaEditor)
        {
            //EditorGUI.DrawRect(position, new Color(0, 1, 0, 0.1f));

            GUI.enabled = true;
            AppalachiaShaderEditorGUI.DrawCategory(position, Category);
        }

        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
        {
            return 40;
        }
    }
}
