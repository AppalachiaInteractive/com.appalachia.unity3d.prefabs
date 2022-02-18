using System;
using UnityEditor;
using UnityEngine;

namespace Appalachia.Rendering.Shading.PropertyDrawers
{
    public class AppalachiaInteractiveDrawer : MaterialPropertyDrawer
    {
        public AppalachiaInteractiveDrawer(string k)
        {
            type = 0;
            keyword = k;
        }

        public AppalachiaInteractiveDrawer(string k, float v1)
        {
            type = 1;
            keyword = k;
            value1 = v1;
        }

        public AppalachiaInteractiveDrawer(string k, float v1, float v2)
        {
            type = 1;
            keyword = k;
            value1 = v1;
            value2 = v2;
        }

        public AppalachiaInteractiveDrawer(string k, float v1, float v2, float v3)
        {
            type = 1;
            keyword = k;
            value1 = v1;
            value2 = v2;
            value3 = v3;
        }

        #region Fields and Autoproperties

        protected float value1 = -1f;
        protected float value2 = -1f;
        protected float value3 = -1f;

        protected int type;
        protected string keyword;

        #endregion

        /// <inheritdoc />
        public override float GetPropertyHeight(MaterialProperty prop, string label, MaterialEditor editor)
        {
            return -2;
        }

        /// <inheritdoc />
        public override void OnGUI(
            Rect position,
            MaterialProperty prop,
            string label,
            MaterialEditor materialEditor)
        {
            var material = materialEditor.target as Material;

            if (type == 1)
            {
                if (material is not null && material.HasProperty(keyword))
                {
                    if ((Math.Abs(value1 - material.GetFloat(keyword)) < float.Epsilon) ||
                        (Math.Abs(value2 - material.GetFloat(keyword)) < float.Epsilon) ||
                        (Math.Abs(value3 - material.GetFloat(keyword)) < float.Epsilon))
                    {
                        GUI.enabled = true;
                    }
                    else
                    {
                        GUI.enabled = false;
                    }
                }
            }

            else if (type == 0)
            {
                if (keyword == "ON")
                {
                    GUI.enabled = true;
                }
                else if (keyword == "OFF")
                {
                    GUI.enabled = false;
                }
                else if (material.IsKeywordEnabled(keyword))
                {
                    GUI.enabled = true;
                }
                else
                {
                    GUI.enabled = false;
                }
            }
        }
    }
}
