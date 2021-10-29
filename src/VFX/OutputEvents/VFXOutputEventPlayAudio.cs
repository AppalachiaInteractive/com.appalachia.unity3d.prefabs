using UnityEngine;
using UnityEngine.VFX;
using UnityEngine.VFX.Utility;

namespace Appalachia.Rendering.VFX.OutputEvents
{
    [ExecuteAlways]
    [RequireComponent(typeof(VisualEffect))]
    public class VFXOutputEventPlayAudio : VFXOutputEventAbstractHandler
    {
        public AudioSource audioSource;
        public override bool canExecuteInEditor => true;

        public override void OnVFXOutputEvent(VFXEventAttribute eventAttribute)
        {
            if (audioSource != null)
            {
                audioSource.Play();
            }
        }
    }
}
