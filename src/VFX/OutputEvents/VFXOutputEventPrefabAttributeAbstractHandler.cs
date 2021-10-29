using UnityEngine;
using UnityEngine.VFX;

namespace Appalachia.Rendering.VFX.OutputEvents
{
    public abstract class VFXOutputEventPrefabAttributeAbstractHandler : MonoBehaviour
    {
        public abstract void OnVFXEventAttribute(VFXEventAttribute eventAttribute, VisualEffect visualEffect);
    }
}
