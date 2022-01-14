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
        #region Fields and Autoproperties

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

        #endregion

        protected override void ResetActual()
        {
            using (_PRF_Reset.Auto())
            {
                base.ResetActual();

                if (!CheckManager())
                {
                    return;
                }

                _currentSettings.Reset();
            }
        }

        protected override async AppaTask WhenDisabled()
        {
            await base.WhenDisabled();

            using (_PRF_WhenDisabled.Auto())
            {
                _currentSettings?.ReleaseBuffers();
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

        #region IDepthOfFieldAutoFocus Members

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

        #endregion

        #region Profiling


        private static readonly ProfilerMarker _PRF_SetUpAutoFocusParams =
            new(_PRF_PFX + nameof(SetUpAutoFocusParams));

        private static readonly ProfilerMarker _PRF_Reset = new(_PRF_PFX + nameof(Reset));
        private static readonly ProfilerMarker _PRF_OnDisable = new(_PRF_PFX + nameof(OnDisable));

        #endregion

#if UNITY_EDITOR
        private void Update()
        {
            using (_PRF_Update.Auto())
            {
                if (ShouldSkipUpdate)
                {
                    return;
                }

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
