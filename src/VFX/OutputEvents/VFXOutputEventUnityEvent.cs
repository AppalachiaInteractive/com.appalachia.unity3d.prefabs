using UnityEngine;
using UnityEngine.Events;
using UnityEngine.VFX;
using UnityEngine.VFX.Utility;

namespace Appalachia.Rendering.VFX.OutputEvents
{
    [ExecuteAlways]
    [RequireComponent(typeof(VisualEffect))]
    public class VFXOutputEventUnityEvent : VFXOutputEventAbstractHandler
    {
        public UnityEvent onEvent;
        public override bool canExecuteInEditor => false;

        public override void OnVFXOutputEvent(VFXEventAttribute eventAttribute)
        {
            onEvent?.Invoke();
        }
    }
}
