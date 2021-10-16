
using UnityEngine;

namespace Appalachia.Rendering.Shading.PropertyDrawers
{

    public class AppalachiaRangeOptionsAttribute : PropertyAttribute
    {

        public float min;
        public float max;
        public string[] options;

        public AppalachiaRangeOptionsAttribute(float m_min, float m_max, string[] m_options)
        {
            options = m_options;
            min = m_min;
            max = m_max;
        }

    }

}

