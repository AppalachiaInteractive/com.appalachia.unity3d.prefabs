#region

using System;
using Appalachia.Core.Editing.Attributes;
using GPUInstancer;
using Sirenix.OdinInspector;
using Unity.Profiling;
using UnityEngine;

#endregion

namespace Appalachia.Core.Rendering.Options.Rendering
{
    [Serializable]
    public class GlobalRenderingOptions : RenderingOptionsBase<GlobalRenderingOptions>
    {
        private const string _PRF_PFX = nameof(GlobalRenderingOptions) + ".";
        
        [SmartLabel, SerializeField]
        [OnValueChanged(nameof(MarkDirty))]
        public LayerMask layerMask;

        [SmartLabel, SerializeField, PropertyRange(5f, 100f)]
        [OnValueChanged(nameof(MarkDirty))]
        public float maximumFrustrangeRange;

        [OnValueChanged(nameof(MarkDirty), true), SerializeField, InlineProperty, HideLabel, LabelWidth(0), Title("Defaults")]
        public RenderPassSettings defaultSettings;

        [OnValueChanged(nameof(MarkDirty), true), SerializeField, InlineProperty, HideLabel, LabelWidth(0), Title("Shadows")]
        public RenderPassSettings shadowSettings;


        private static readonly ProfilerMarker _PRF_ApplyTo = new ProfilerMarker(_PRF_PFX + nameof(ApplyTo));
        public bool ApplyTo(GPUIGlobalRenderSettings settings)
        {
            using (_PRF_ApplyTo.Auto())
            {
                if (_applied)
                {
                    return false;
                }

                _applied = true;

                settings.layerMask = layerMask;
                defaultSettings.CopyTo(settings.defaultSettings);
                shadowSettings.CopyTo(settings.shadowSettings);
                return true;
            }
        }
    }
}
