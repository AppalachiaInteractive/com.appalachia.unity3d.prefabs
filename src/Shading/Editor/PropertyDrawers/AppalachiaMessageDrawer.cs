using System;
using UnityEditor;
using UnityEngine;

namespace Appalachia.Rendering.Shading.PropertyDrawers
{
    public class AppalachiaMessageDrawer : MaterialPropertyDrawer
    {
        protected string Type;
        protected string Message;
        protected string Keyword;
        protected float Value;
        protected float Top;
        protected float Down;

        private MessageType mType;
        private bool enabled;

        public AppalachiaMessageDrawer(string t, string m, float top, float down)
        {
            Type = t;
            Message = m;
            Keyword = null;

            Top = top;
            Down = down;
        }

        public AppalachiaMessageDrawer(
            string t,
            string m,
            string k,
            float v,
            float top,
            float down)
        {
            Type = t;
            Message = m;
            Keyword = k;
            Value = v;

            Top = top;
            Down = down;
        }

        public override void OnGUI(Rect position, MaterialProperty prop, string label, MaterialEditor materialEditor)
        {
            var material = materialEditor.target as Material;

            if (Type == "None")
            {
                mType = MessageType.None;
            }
            else if (Type == "Info")
            {
                mType = MessageType.Info;
            }
            else if (Type == "Warning")
            {
                mType = MessageType.Warning;
            }
            else if (Type == "Error")
            {
                mType = MessageType.Error;
            }

            if (Keyword != null)
            {
                if (material is not null && material.HasProperty(Keyword))
                {
                    if (Math.Abs(material.GetFloat(Keyword) - Value) < float.Epsilon)
                    {
                        GUILayout.Space(Top);

                        //EditorGUI.DrawRect(new Rect(position.x, position.y + Top, position.width, position.height), new Color(1,0,0,0.3f));
                        EditorGUI.HelpBox(
                            new Rect(position.x, position.y + Top, position.width, position.height),
                            Message,
                            mType
                        );
                        GUILayout.Space(Down);
                        enabled = true;
                    }
                    else
                    {
                        enabled = false;
                    }
                }
            }
            else
            {
                GUILayout.Space(Top);
                EditorGUI.HelpBox(
                    new Rect(position.x, position.y + Top, position.width, position.height),
                    Message,
                    mType
                );
                GUILayout.Space(Down);
                enabled = true;
            }
        }

        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
        {
            if (enabled)
            {
                return 40;
            }

            return -2;
        }
    }
}
