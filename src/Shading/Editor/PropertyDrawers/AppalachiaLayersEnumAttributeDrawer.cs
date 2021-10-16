using UnityEditor;
using UnityEngine;

namespace Appalachia.Rendering.Shading.PropertyDrawers
{
    [CustomPropertyDrawer(typeof(AppalachiaLayersEnumAttribute))]
    public class AppalachiaLayersEnumAttributeDrawer : PropertyDrawer
    {
        //private AppalachiaLayersEnumAttribute a;
        private int index;

        public override void OnGUI(Rect position, SerializedProperty property, GUIContent label)
        {
            //a = (AppalachiaLayersEnumAttribute) attribute;
            index = property.intValue;

            var allLayers = new string[32];

            for (var i = 0; i < 32; i++)
            {
                if (LayerMask.LayerToName(i).Length < 1)
                {
                    allLayers[i] = "Missing";
                }
                else
                {
                    allLayers[i] = LayerMask.LayerToName(i);
                }
            }

            index = EditorGUILayout.Popup(property.displayName, index, allLayers);
            property.intValue = index;
        }

        public override float GetPropertyHeight(SerializedProperty property, GUIContent label)
        {
            return -2;
        }
    }
}
