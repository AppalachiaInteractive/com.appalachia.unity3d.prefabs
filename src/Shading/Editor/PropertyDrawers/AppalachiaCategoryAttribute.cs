
using UnityEngine;

namespace Appalachia.Rendering.Shading.PropertyDrawers
{

    public class AppalachiaCategoryAttribute : PropertyAttribute
    {
        public string Category;

        public AppalachiaCategoryAttribute(string c)
        {
            Category = c;
        }
    }

}

