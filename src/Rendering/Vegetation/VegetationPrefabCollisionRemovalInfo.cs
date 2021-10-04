#region

using System;
using Appalachia.Editing.Attributes;
using AwesomeTechnologies.VegetationSystem;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Prefabs.Rendering.Vegetation
{
    [Serializable]
    public class VegetationPrefabCollisionRemovalInfo
    {
        [HorizontalGroup("A", .66f)]
        [SmartLabel]
        public GameObject prefab;

        [HorizontalGroup("B", .66f)]
        [SmartLabel]
        [PropertyRange(0f, 2f)]
        public float adjustBounds = .50f;

        [HorizontalGroup("A")]
        [SmartLabel]
        public int instances;

        [HorizontalGroup("B")]
        [SmartLabel]
        public int removals;

        [FoldoutGroup("Additional Data")]
        [BoxGroup("Additional Data/Metadata")]
        [SmartLabel]
        public VegetationType prefabType;

        [BoxGroup("Additional Data/Metadata")]
        [SmartLabel]
        public Vector2 scale;

        [BoxGroup("Additional Data/Metadata")]
        [SmartLabel]
        public string vegetationItemID;

        [BoxGroup("Additional Data/Footprint")]
        [SmartLabel]
        public Bounds bounds;

        [BoxGroup("Additional Data/Footprint")]
        [SmartLabel]
        public Bounds footprint00m;

        [BoxGroup("Additional Data/Footprint")]
        [SmartLabel]
        public Bounds footprint01m;

        [BoxGroup("Additional Data/Footprint")]
        [SmartLabel]
        public Bounds footprint02m;

        [BoxGroup("Additional Data/Footprint")]
        [SmartLabel]
        public Bounds footprint04m;

        [BoxGroup("Additional Data/Footprint")]
        [SmartLabel]
        public Bounds footprint06m;

        [BoxGroup("Additional Data/Footprint")]
        [SmartLabel]
        public Bounds footprint10m;

        [BoxGroup("Additional Data/Footprint")]
        [SmartLabel]
        public Bounds footprint15m;

        [BoxGroup("Additional Data/Footprint")]
        [SmartLabel]
        public Bounds footprint20m;

        public float scaleAverage => (scale.x + scale.y) / 2f;
    }
}
