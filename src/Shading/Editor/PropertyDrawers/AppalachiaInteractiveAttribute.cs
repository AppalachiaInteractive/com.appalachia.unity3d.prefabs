
using UnityEngine;

namespace Appalachia.Rendering.Shading.PropertyDrawers
{

    public class AppalachiaInteractiveAttribute : PropertyAttribute
    {
        public int Value;
        public string Keyword;
        public int Type;

        public AppalachiaInteractiveAttribute(int v)
        {
            Type = 0;
            Value = v;
        }

        public AppalachiaInteractiveAttribute(string k)
        {
            Type = 1;
            Keyword = k;
        }
    }

}

