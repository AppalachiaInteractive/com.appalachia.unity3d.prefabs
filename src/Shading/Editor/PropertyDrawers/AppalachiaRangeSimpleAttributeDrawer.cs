﻿using UnityEditor;
using UnityEngine;

namespace Appalachia.Rendering.Shading.PropertyDrawers
{
    [CustomPropertyDrawer(typeof(AppalachiaRangeSimpleAttribute))]
    public class AppalachiaRangeSimpleAttributeDrawer : PropertyDrawer
    {
        private AppalachiaRangeSimpleAttribute a;

        private float min;
        private float max;
        private string[] options;

        public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
        {
            a = (AppalachiaRangeSimpleAttribute) attribute;

            min = a.min;
            max = a.max;

            GUILayout.BeginHorizontal();
            GUILayout.Space(20);
            property.floatValue = GUILayout.HorizontalSlider(property.floatValue, min, max);
            GUILayout.Space(20);
            GUILayout.EndHorizontal();
        }

        public override float GetPropertyHeight(SerializedProperty property, GUIContent label)
        {
            return -2;
        }
    }
}
