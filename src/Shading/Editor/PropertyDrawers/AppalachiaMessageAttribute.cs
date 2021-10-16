
using UnityEngine;

namespace Appalachia.Rendering.Shading.PropertyDrawers
{

    public class AppalachiaMessageAttribute : PropertyAttribute
    {

        public string Type;
        public string Message;
        public float Top;
        public float Down;

        public AppalachiaMessageAttribute(string t, string m, float top, float down)
        {
            Type = t;
            Message = m;
            Top = top;
            Down = down;
        }

    }

}

