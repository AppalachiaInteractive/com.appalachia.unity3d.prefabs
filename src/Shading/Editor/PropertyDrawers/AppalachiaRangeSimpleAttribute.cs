using UnityEngine;

namespace Appalachia.Rendering.Shading.PropertyDrawers
{

    public class AppalachiaRangeSimpleAttribute : PropertyAttribute
    {

        public float min;
        public float max;

        public AppalachiaRangeSimpleAttribute(float m_min, float m_max)
        {
            min = m_min;
            max = m_max;
        }

    }

}

