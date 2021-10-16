using UnityEditor;
using UnityEngine;

namespace Appalachia.Rendering.Shading.Inspectors
{
    public static class ShaderGUIStyles
    {
        public static Texture2D LogoImage
        {
            get
            {
                if (EditorGUIUtility.isProSkin)
                {
                    return Resources.Load("ShaderGUI - LogoDark") as Texture2D;
                }

                return Resources.Load("ShaderGUI - LogoLight") as Texture2D;
            }
        }

        public static Texture2D BannerImageBegin => Resources.Load("ShaderGUI - BannerBegin") as Texture2D;

        public static Texture2D BannerImageMiddle => Resources.Load("ShaderGUI - BannerMiddle") as Texture2D;

        public static Texture2D BannerImageEnd => Resources.Load("ShaderGUI - BannerEnd") as Texture2D;

        public static Texture2D CategoryImageBegin => Resources.Load("ShaderGUI - CategoryBegin") as Texture2D;

        public static Texture2D CategoryImageMiddle => Resources.Load("ShaderGUI - CategoryMiddle") as Texture2D;

        public static Texture2D CategoryImageEnd => Resources.Load("ShaderGUI - CategoryEnd") as Texture2D;

        public static Texture2D IconEdit => Resources.Load("ShaderGUI - IconEdit") as Texture2D;

        public static Texture2D IconFile => Resources.Load("ShaderGUI - IconFile") as Texture2D;

        public static Texture2D IconHelp => Resources.Load("ShaderGUI - IconHelp") as Texture2D;

        public static Color ColorStandard
        {
            get
            {
                Color color;

                if (EditorGUIUtility.isProSkin)
                {
                    color = new Color(0.87f, 0.87f, 0.87f);
                }
                else
                {
                    color = Color.black;
                }

                return color;
            }
        }

        public static Color ColorDarkGray => new Color(0.27f, 0.27f, 0.27f);

        public static Color ColorLightGray => new Color(0.87f, 0.87f, 0.87f);

        public static Color ColorStandardDim
        {
            get
            {
                Color color;

                if (EditorGUIUtility.isProSkin)
                {
                    color = new Color(0.27f, 0.27f, 0.27f);
                }
                else
                {
                    color = new Color(0.83f, 0.83f, 0.83f);
                }

                return color;
            }
        }

        public static GUIStyle BannerTitleStyle
        {
            get
            {
                var guiStyle = new GUIStyle {richText = true, alignment = TextAnchor.MiddleCenter};

                return guiStyle;
            }
        }

        public static GUIStyle TitleStyle
        {
            get
            {
                var guiStyle = new GUIStyle();

                guiStyle.normal.textColor = ColorStandard;
                guiStyle.alignment = TextAnchor.MiddleCenter;
                guiStyle.fontStyle = FontStyle.Bold;

                return guiStyle;
            }
        }
    }
}
