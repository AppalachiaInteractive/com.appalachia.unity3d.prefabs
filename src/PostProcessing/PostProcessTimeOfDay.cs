using Appalachia.Core.Objects.Root;
using Appalachia.Globals.Environment;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;
using UnityEngine.Serialization;

namespace Appalachia.Rendering.PostProcessing
{
    [ExecuteAlways]
    public sealed class PostProcessTimeOfDay : AppalachiaBehaviour<PostProcessTimeOfDay>
    {
        #region Fields and Autoproperties

        public PostProcessVolume morning;
        public PostProcessVolume daytime;
        public PostProcessVolume evening;

        [FormerlySerializedAs("nightime")]
        public PostProcessVolume nighttime;

        #endregion

        [BoxGroup("Strengths")]
        [ShowInInspector]
        [ReadOnly]
        [PropertyRange(0f, 1.0f)]
        public float daytimeStrength => daytime.weight;

        [BoxGroup("Strengths")]
        [ShowInInspector]
        [ReadOnly]
        [PropertyRange(0f, 1.0f)]
        public float eveningStrength => evening.weight;

        [BoxGroup("Time")]
        [ShowInInspector]
        [ReadOnly]
        [PropertyRange(0f, 1.0f)]
        public float lunarTime => ENVIRONMENT.lunarTime;

        [BoxGroup("Strengths")]
        [ShowInInspector]
        [ReadOnly]
        [PropertyRange(0f, 1.0f)]
        public float morningStrength => morning.weight;

        [BoxGroup("Strengths")]
        [ShowInInspector]
        [ReadOnly]
        [PropertyRange(0f, 1.0f)]
        public float nighttimeStrength => nighttime.weight;

        [BoxGroup("Time")]
        [ShowInInspector]
        [ReadOnly]
        [PropertyRange(0f, 1.0f)]
        public float solarTime => ENVIRONMENT.solarTime;

        #region Event Functions

        private void Update()
        {
            if (!DependenciesAreReady || !FullyInitialized)
            {
                return;
            }

            if (!EnviroTimeManager.Valid)
            {
                return;
            }

            var isMorning = EnviroTimeManager.Morning();

            var twilight = isMorning ? morning : evening;
            var otherTwilight = isMorning ? evening : morning;

            otherTwilight.weight = 0.0f;

            if (solarTime >= 0.5f)
            {
                nighttime.weight = 0.0f;

                var blend = (solarTime * 2.0f) - 1.0f;
                twilight.weight = 1.0f - blend;
                daytime.weight = blend;
            }
            else
            {
                daytime.weight = 0.0f;

                var blend = solarTime * 2.0f;
                nighttime.weight = 1.0f - blend;
                twilight.weight = blend;
            }
        }

        #endregion
    }
}
