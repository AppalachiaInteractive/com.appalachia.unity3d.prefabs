using System;
using System.Collections.Generic;
using Appalachia.Core.Attributes.Editing;
using Appalachia.Core.Comparisons;
using Appalachia.Core.Objects.Scriptables;
using Appalachia.Utility.Async;
using Appalachia.Utility.Enums;
using Appalachia.Utility.Strings;
using Sirenix.OdinInspector;

namespace Appalachia.Rendering.PostProcessing.AutoFocus
{
    [Serializable]
    public class
        DepthOfFieldStateSettingCollection : AutonamedIdentifiableAppalachiaObject<
            DepthOfFieldStateSettingCollection>
    {
        #region Fields and Autoproperties

        [FoldoutGroup("Defaults")]
        [PropertyRange(0.0f, 128.0f)]
        [SmartLabel]
        public float aperture = 16f;

        [FoldoutGroup("Defaults")]
        [PropertyRange(0.1f, 50.0f)]
        [SmartLabel]
        public float focusDistance = 15f;

        [FoldoutGroup("Defaults")]
        [PropertyRange(0.01f, 1.0f)]
        [SmartLabel]
        public float velocitySmoothing = .2f;

        [InlineEditor] public List<DepthOfFieldStateSettings> settings;

        private IComparer<DepthOfFieldStateSettings> _comparison;

        #endregion

        #region Event Functions

        protected override async AppaTask WhenEnabled()
        {
#if UNITY_EDITOR
            var values = EnumValueManager.GetAllValues<DepthOfFieldState>();

            if (settings == null)
            {
                settings = new List<DepthOfFieldStateSettings>();
                MarkAsModified();
            }

            while (settings.Count < values.Length)
            {
                var targetname = ZString.Format("{0}_{1}", name, values[settings.Count]);

                settings.Add(DepthOfFieldStateSettings.LoadOrCreateNew(targetname));
                MarkAsModified();
            }

            while (settings.Count > values.Length)
            {
                settings.RemoveAt(settings.Count - 1);
                MarkAsModified();
            }

            if (_comparison == null)
            {
                _comparison =
                    new ComparisonWrapper<DepthOfFieldStateSettings>((a, b) => a.state.CompareTo(b.state));
            }

            settings.Sort(_comparison);

            for (var i = 0; i < settings.Count; i++)
            {
                var targetName = ZString.Format("{0}_{1}", name, values[i]);

                if (settings[i].name != targetName)
                {
                    settings[i].Rename(targetName);
                }
            }

            for (var i = 0; i < settings.Count; i++)
            {
                var setting = settings[i];

                if (setting.nearPlane == null)
                {
                    setting.nearPlane = new DepthOfFieldStatePlaneSettings();
                    setting.MarkAsModified();
                }

                if (setting.farPlane == null)
                {
                    setting.farPlane = new DepthOfFieldStatePlaneSettings();
                    setting.MarkAsModified();
                }
            }
#endif
        }

        #endregion

        [Button]
        private void Refresh()
        {
            OnEnable();
        }
    }
}
