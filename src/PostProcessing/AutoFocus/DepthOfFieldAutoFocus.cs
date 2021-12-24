using System;
using Appalachia.Core.Attributes.Editing;
using Appalachia.Core.Objects.Root;
using Appalachia.Utility.Async;
using Sirenix.OdinInspector;
using Unity.Profiling;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.PostProcessing;
using UnityEngine.Serialization;

namespace Appalachia.Rendering.PostProcessing.AutoFocus
{
    // ExecuteAlways needed to run OnDisable() after DoF made us allocate the buffer in edit mode.
    [DisallowMultipleComponent]
    [ExecuteAlways]
    public sealed class DepthOfFieldAutoFocus : AppalachiaBehaviour<DepthOfFieldAutoFocus>,
                                                IDepthOfFieldAutoFocus
    {
        private const string _PRF_PFX = nameof(DepthOfFieldAutoFocus) + ".";

        private static readonly ProfilerMarker _PRF_SetUpAutoFocusParams =
            new(_PRF_PFX + nameof(SetUpAutoFocusParams));

        private static readonly ProfilerMarker _PRF_Reset = new(_PRF_PFX + nameof(Reset));

        private static readonly ProfilerMarker _PRF_OnDisable = new(_PRF_PFX + nameof(OnDisable));

        [FormerlySerializedAs("m_Compute")]
        [SmartLabel]
        [HideInInspector]
        public ComputeShader computeShader;

        [SmartLabel]
        [InlineEditor]
        public DepthOfFieldStateSettingCollection settingsCollection;

        [NonSerialized] private ComputeBuffer _autoFocusOutputBuffer;
        [NonSerialized] private ComputeBuffer _autoFocusParametersBuffer;

        [ShowInInspector]
        [InlineProperty]
        [HideLabel]
        [BoxGroup("Settings Manager")]
        [HideReferenceObjectPicker]
        private DepthOfFieldActiveSettingsManager _currentSettings;

        protected override void Reset()
        {
            using (_PRF_Reset.Auto())
            {
                base.Reset();
                
                if (!CheckManager())
                {
                    return;
                }

                _currentSettings.Reset();
            }
        }

        protected override async AppaTask WhenDisabled()

        {
            using (_PRF_OnDisable.Auto())
            {
                await base.WhenDisabled();
                
                _currentSettings?.ReleaseBuffers();
            }
        }

        public void SetUpAutoFocusParams(
            CommandBuffer cmd,
            float focalLength /*in meters*/,
            float filmHeight,
            Camera cam,
            bool resetHistory)
        {
            using (_PRF_SetUpAutoFocusParams.Auto())
            {
                if (!CheckManager())
                {
                    return;
                }

                _currentSettings.Update(
                    enabled,
                    computeShader,
                    cmd,
                    focalLength,
                    filmHeight,
                    cam,
                    resetHistory
                );
            }
        }

        private bool CheckManager()
        {
            if (settingsCollection == null)
            {
                return false;
            }

            if (_currentSettings == null)
            {
                _currentSettings = new DepthOfFieldActiveSettingsManager(settingsCollection);
            }

            if ((_currentSettings.settingsCollection == null) ||
                (_currentSettings.settingsCollection != settingsCollection))
            {
                _currentSettings.settingsCollection = settingsCollection;
            }

            return true;
        }

#if UNITY_EDITOR
        private static readonly ProfilerMarker _PRF_Update = new(_PRF_PFX + nameof(Update));
        private void Update()
        {
            using (_PRF_Update.Auto())
            {
                if (!CheckManager())
                {
                    return;
                }

                _currentSettings.RetrieveDisplayData();
            }
        }
#endif
    }
}
