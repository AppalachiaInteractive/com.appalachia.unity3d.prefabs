#region

using System;
using Appalachia.Core.Attributes.Editing;
using Appalachia.Core.Objects.Root;
using Appalachia.Rendering.Prefabs.Spawning.Sets;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Spawning.Data
{
    [Serializable]
    public class RandomPrefabSetElement : AppalachiaSimpleBase
    {
        [ToggleLeft]
        [HorizontalGroup("A", .05f)]
        [SmartLabel]
        [LabelText(" Enabled")]
        public bool enabled = true;

        [PropertyRange(1, 1000)]
        [HorizontalGroup("A", .95f)]
        [SmartLabel]
        [LabelText(" Spawn Limit")]
        [EnableIf(nameof(enabled))]
        public int spawnLimit = 50;

        [InlineEditor]
        [HideLabel]
        public RandomPrefabSet set;

        [HideInInspector] public Transform setTransform;

#if UNITY_EDITOR
        [Button]
        public void CreateNew()
        {
            set = AppalachiaObject.CreateNew<RandomPrefabSet>();
        }
#endif
    }
}
