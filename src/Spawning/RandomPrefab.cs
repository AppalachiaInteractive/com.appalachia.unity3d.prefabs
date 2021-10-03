#region

using System;
using Appalachia.Core.Editing.Attributes;
using Appalachia.Core.Probability;
using Appalachia.Core.Spawning.Data;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Core.Spawning
{
    [Serializable]
    public class RandomPrefab : IProbabilityProvider
    {
        [ToggleLeft]
        [HorizontalGroup("A", .05f), SmartLabel, LabelText(" Enabled")]
        public bool enabled = true;

        [HorizontalGroup("A", .65f), SmartLabel]
        [EnableIf(nameof(enabled))]
        [AssetsOnly]
        public GameObject prefab;

        [HorizontalGroup("A", .3f), SmartLabel]
        [EnableIf(nameof(enabled))]
        [PropertyRange(0.01f, 3.0f)]
        public double probability = 1.0f;

        [ToggleLeft, SmartLabel] public bool overridePositioning;

        [ShowIf(nameof(overridePositioning)), HideLabel]
        public RandomTransformData transformOverrideData;

        public RandomPrefab()
        {
            transformOverrideData = new RandomTransformData();
        }

        public bool Enabled => enabled;
        public double Probability => probability;
    }
}
