using Appalachia.Rendering.Shading.Inspectors;
using UnityEditor;
using UnityEngine;

namespace Appalachia.Rendering.Shading.PropertyDrawers
{
    public class AppalachiaBannerDrawer : MaterialPropertyDrawer
    {
        public AppalachiaBannerDrawer()
        {
            title = null;
            subtitle = null;
        }

        public AppalachiaBannerDrawer(string t)
        {
            title = t;
            subtitle = null;
        }

        public AppalachiaBannerDrawer(string t, string s)
        {
            title = t;
            subtitle = s;
        }

        #region Fields and Autoproperties

        protected Color bannerColor;
        protected string bannerSubText;
        protected string bannerText;
        protected string subtitle;

        protected string title;

        #endregion

        /// <inheritdoc />
        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
        {
            return 0;
        }

        /// <inheritdoc />
        public override void OnGUI(
            Rect position,
            MaterialProperty prop,
            string label,
            MaterialEditor materialEditor)
        {
            //EditorGUI.DrawRect(position, new Color(0, 1, 0, 0.05f));

            var material = materialEditor.target as Material;

            if ((title == null) && (subtitle == null))
            {
                title = prop.displayName;
                subtitle = null;
            }

            bannerText = title;
            bannerSubText = subtitle;

            if (EditorGUIUtility.isProSkin)
            {
                bannerColor = ShaderGUIStyles.ColorLightGray;
            }
            else
            {
                bannerColor = ShaderGUIStyles.ColorDarkGray;
            }

            AppalachiaShaderEditorGUI.DrawMaterialBanner(
                bannerColor,
                bannerText,
                bannerSubText,
                material.shader
            );
        }
    }
}
