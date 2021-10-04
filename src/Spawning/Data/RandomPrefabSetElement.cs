#region

using System;
using Appalachia.Editing.Attributes;
using Appalachia.Prefabs.Spawning.Sets;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Prefabs.Spawning.Data
{
    [Serializable]
    public class RandomPrefabSetElement
    {
        [ToggleLeft]
        [HorizontalGroup("A", .05f), SmartLabel, LabelText(" Enabled")]
        public bool enabled = true;

        [PropertyRange(1, 1000)]
        [HorizontalGroup("A", .95f), SmartLabel, LabelText(" Spawn Limit")]
        [EnableIf(nameof(enabled))]
        public int spawnLimit = 50;

        [InlineEditor]
        [HideLabel]
        public RandomPrefabSet set;

        [HideInInspector] public Transform setTransform;

        [Button]
        public void CreateNew()
        {
            set = RandomPrefabSet.CreateNew();
        }
    }
}
