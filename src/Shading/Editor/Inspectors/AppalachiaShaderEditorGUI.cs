using AmplifyShaderEditor;
using Appalachia.CI.Integration.Assets;
using UnityEditor;
using UnityEngine;

namespace Appalachia.Rendering.Shading.Inspectors
{
    public static class AppalachiaShaderEditorGUI
    {
        public static void DrawBanner(Color bannerColor, string bannerText, string helpURL)
        {
            GUILayout.Space(20);
            var bannerFullRect = GUILayoutUtility.GetRect(0, 0, 40, 0);
            var bannerBeginRect = new Rect(bannerFullRect.position.x, bannerFullRect.position.y, 20, 40);
            var bannerMiddleRect = new Rect(
                bannerFullRect.position.x + 20,
                bannerFullRect.position.y,
                bannerFullRect.xMax - 54,
                40
            );
            var bannerEndRect = new Rect(bannerFullRect.xMax - 20, bannerFullRect.position.y, 20, 40);
            var iconRect = new Rect(bannerFullRect.xMax - 36, bannerFullRect.position.y + 5, 30, 30);

            GUI.color = new Color(bannerColor.r, bannerColor.g, bannerColor.b, 0.6f);

            GUI.DrawTexture(bannerBeginRect, ShaderGUIStyles.BannerImageBegin, ScaleMode.StretchToFill, true);
            GUI.DrawTexture(bannerMiddleRect, ShaderGUIStyles.BannerImageMiddle, ScaleMode.StretchToFill, true);
            GUI.DrawTexture(bannerEndRect, ShaderGUIStyles.BannerImageEnd, ScaleMode.StretchToFill, true);

            GUI.color = bannerColor;

            GUI.Label(
                bannerFullRect,
                "<size=14><color=#" +
                ColorUtility.ToHtmlStringRGB(bannerColor) +
                "><b>" +
                bannerText +
                "</b></color></size>",
                ShaderGUIStyles.BannerTitleStyle
            );

            if (GUI.Button(iconRect, ShaderGUIStyles.IconHelp, new GUIStyle {alignment = TextAnchor.MiddleCenter}))
            {
                Application.OpenURL(helpURL);
            }

            GUI.color = Color.white;
            GUILayout.Space(10);
        }

        public static void DrawWindowBanner(Color bannerColor, string bannerText, string helpURL)
        {
            GUILayout.Space(20);
            var bannerFullRect = GUILayoutUtility.GetRect(0, 0, 40, 0);
            var bannerBeginRect = new Rect(bannerFullRect.position.x + 20, bannerFullRect.position.y, 20, 40);
            var bannerMiddleRect = new Rect(
                bannerFullRect.position.x + 40,
                bannerFullRect.position.y,
                bannerFullRect.xMax - 75,
                40
            );
            var bannerEndRect = new Rect(bannerFullRect.xMax - 36, bannerFullRect.position.y, 20, 40);
            var iconRect = new Rect(bannerFullRect.xMax - 53, bannerFullRect.position.y + 5, 30, 30);

            GUI.color = new Color(bannerColor.r, bannerColor.g, bannerColor.b, 0.6f);

            GUI.DrawTexture(bannerBeginRect, ShaderGUIStyles.BannerImageBegin, ScaleMode.StretchToFill, true);
            GUI.DrawTexture(bannerMiddleRect, ShaderGUIStyles.BannerImageMiddle, ScaleMode.StretchToFill, true);
            GUI.DrawTexture(bannerEndRect, ShaderGUIStyles.BannerImageEnd, ScaleMode.StretchToFill, true);

            GUI.color = bannerColor;

            GUI.Label(
                bannerFullRect,
                "<size=14><color=#" +
                ColorUtility.ToHtmlStringRGB(bannerColor) +
                "><b>" +
                bannerText +
                "</b></color></size>",
                ShaderGUIStyles.BannerTitleStyle
            );

            if (GUI.Button(iconRect, ShaderGUIStyles.IconHelp, new GUIStyle {alignment = TextAnchor.MiddleCenter}))
            {
                Application.OpenURL(helpURL);
            }

            GUI.color = Color.white;
            GUILayout.Space(20);
        }

        public static void DrawMaterialBanner(Color bannerColor, string bannerText, string bannerSubText, Shader shader)
        {
            GUILayout.Space(10);
            var bannerFullRect = GUILayoutUtility.GetRect(0, 0, 40, 0);
            var bannerBeginRect = new Rect(bannerFullRect.position.x, bannerFullRect.position.y, 20, 40);
            var bannerMiddleRect = new Rect(
                bannerFullRect.position.x + 20,
                bannerFullRect.position.y,
                bannerFullRect.xMax - 54,
                40
            );
            var bannerEndRect = new Rect(bannerFullRect.xMax - 20, bannerFullRect.position.y, 20, 40);
            var iconRect = new Rect(bannerFullRect.xMax - 36, bannerFullRect.position.y + 5, 30, 30);

            GUI.color = new Color(bannerColor.r, bannerColor.g, bannerColor.b, 0.6f);

            GUI.DrawTexture(bannerBeginRect, ShaderGUIStyles.BannerImageBegin, ScaleMode.StretchToFill, true);
            GUI.DrawTexture(bannerMiddleRect, ShaderGUIStyles.BannerImageMiddle, ScaleMode.StretchToFill, true);
            GUI.DrawTexture(bannerEndRect, ShaderGUIStyles.BannerImageEnd, ScaleMode.StretchToFill, true);

            GUI.color = bannerColor;

            GUI.Label(
                bannerFullRect,
                "<size=14><color=#" +
                ColorUtility.ToHtmlStringRGB(bannerColor) +
                "><b>" +
                bannerText +
                "</b> " +
                bannerSubText +
                "</color></size>",
                ShaderGUIStyles.BannerTitleStyle
            );

#if AMPLIFY_SHADER_EDITOR
            if (GUI.Button(iconRect, ShaderGUIStyles.IconEdit, new GUIStyle {alignment = TextAnchor.MiddleCenter}))
            {
                AmplifyShaderEditorWindow.ConvertShaderToASE(shader);
            }
#else
            if (GUI.Button(iconRect, ShaderGUIStyles.IconFile, new GUIStyle { alignment = TextAnchor.MiddleCenter }))
            {                
                AssetDatabaseManager.OpenAsset(shader, 1);
            }
#endif

            GUI.color = Color.white;
            GUILayout.Space(10);
        }

        public static void DrawCategory(Rect position, string bannerText)
        {
            var categoryFullRect = new Rect(
                position.position.x,
                position.position.y + 10,
                position.width,
                position.height
            );
            var categoryBeginRect = new Rect(categoryFullRect.position.x, categoryFullRect.position.y, 10, 20);
            var categoryMiddleRect = new Rect(
                categoryFullRect.position.x + 10,
                categoryFullRect.position.y,
                categoryFullRect.xMax - 32,
                20
            );
            var categoryEndRect = new Rect(categoryFullRect.xMax - 10, categoryFullRect.position.y, 10, 20);
            var titleRect = new Rect(
                categoryFullRect.position.x,
                categoryFullRect.position.y,
                categoryFullRect.width,
                18
            );

            GUI.color = ShaderGUIStyles.ColorStandardDim;

            //GUI.DrawTexture(categoryBeginRect, ShaderGUIStyles.CategoryImageBegin, ScaleMode.StretchToFill, true);
            //GUI.DrawTexture(categoryMiddleRect, ShaderGUIStyles.CategoryImageMiddle, ScaleMode.StretchToFill, true);
            //GUI.DrawTexture(categoryEndRect, ShaderGUIStyles.CategoryImageEnd, ScaleMode.StretchToFill, true);

            //Workaround for flickering images in CustomInspector with Attribute
            var styleB = new GUIStyle();
            styleB.normal.background = ShaderGUIStyles.CategoryImageBegin;
            EditorGUI.LabelField(categoryBeginRect, GUIContent.none, styleB);

            var styleM = new GUIStyle();
            styleM.normal.background = ShaderGUIStyles.CategoryImageMiddle;
            EditorGUI.LabelField(categoryMiddleRect, GUIContent.none, styleM);

            var styleE = new GUIStyle();
            styleE.normal.background = ShaderGUIStyles.CategoryImageEnd;
            EditorGUI.LabelField(categoryEndRect, GUIContent.none, styleE);

            GUI.color = Color.white;
            GUI.Label(titleRect, bannerText, ShaderGUIStyles.TitleStyle);
        }

        public static void DrawWindowCategory(string bannerText)
        {
            var position = GUILayoutUtility.GetRect(0, 0, 40, 0);
            var categoryFullRect = new Rect(
                position.position.x,
                position.position.y + 10,
                position.width,
                position.height
            );
            var categoryBeginRect = new Rect(categoryFullRect.position.x, categoryFullRect.position.y, 10, 20);
            var categoryMiddleRect = new Rect(
                categoryFullRect.position.x + 10,
                categoryFullRect.position.y,
                categoryFullRect.xMax - 39,
                20
            );
            var categoryEndRect = new Rect(categoryFullRect.xMax - 10, categoryFullRect.position.y, 10, 20);
            var titleRect = new Rect(
                categoryFullRect.position.x,
                categoryFullRect.position.y,
                categoryFullRect.width,
                18
            );

            GUI.color = ShaderGUIStyles.ColorStandardDim;

            //GUI.DrawTexture(categoryBeginRect, ShaderGUIStyles.CategoryImageBegin, ScaleMode.StretchToFill, true);
            //GUI.DrawTexture(categoryMiddleRect, ShaderGUIStyles.CategoryImageMiddle, ScaleMode.StretchToFill, true);
            //GUI.DrawTexture(categoryEndRect, ShaderGUIStyles.CategoryImageEnd, ScaleMode.StretchToFill, true);

            //Workaround for flickering images in CustomInspector with Attribute
            var styleB = new GUIStyle();
            styleB.normal.background = ShaderGUIStyles.CategoryImageBegin;
            EditorGUI.LabelField(categoryBeginRect, GUIContent.none, styleB);

            var styleM = new GUIStyle();
            styleM.normal.background = ShaderGUIStyles.CategoryImageMiddle;
            EditorGUI.LabelField(categoryMiddleRect, GUIContent.none, styleM);

            var styleE = new GUIStyle();
            styleE.normal.background = ShaderGUIStyles.CategoryImageEnd;
            EditorGUI.LabelField(categoryEndRect, GUIContent.none, styleE);

            GUI.color = Color.white;
            GUI.Label(titleRect, bannerText, ShaderGUIStyles.TitleStyle);
        }

        public static void DrawLogo()
        {
            GUILayout.BeginHorizontal();
            GUILayout.Label("");

            if (GUILayout.Button(ShaderGUIStyles.LogoImage, GUI.skin.label))
            {
                Application.OpenURL("https://boxophobic.com/");
            }

            GUILayout.EndHorizontal();
            GUILayout.Space(20);
        }
    }
}
