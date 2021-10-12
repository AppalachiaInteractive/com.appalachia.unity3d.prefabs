#region

using System;
using Appalachia.Core.Attributes.Editing;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.ModelType.Positioning
{
    [Serializable]
    public struct AssetBurialOptions : IEquatable<AssetBurialOptions>,
                                       ISerializationCallbackReceiver
    {
        [ToggleLeft]
        [SmartLabel]
        [HorizontalGroup("A")]
        [SerializeField]
        public bool buryMesh;

        [ToggleLeft]
        [SmartLabel]
        [HorizontalGroup("A")]
        [EnableIf(nameof(buryMesh))]
        [SerializeField]
        public bool adoptTerrainNormal;

        [SmartLabel]
        [EnableIf(nameof(buryMesh))]
        [SerializeField]
        public float adjustmentStrength;

        public AssetBurialOptions(
            bool buryMesh = true,
            bool adoptTerrainNormal = true,
            float adjustmentStrength = 1.0f)
        {
            this.buryMesh = buryMesh;
            this.adoptTerrainNormal = adoptTerrainNormal;
            this.adjustmentStrength = adjustmentStrength;
        }

        public void OnBeforeSerialize()
        {
        }

        public void OnAfterDeserialize()
        {
            if (adjustmentStrength == 0f)
            {
                adjustmentStrength = 1.0f;
            }
        }

        public void CopyFrom(AssetBurialOptions other)
        {
            buryMesh = other.buryMesh;
            adoptTerrainNormal = other.adoptTerrainNormal;
            adjustmentStrength = other.adjustmentStrength;
        }

        public static AssetBurialOptions DoNotBury()
        {
            return new(false, false);
        }

        public static AssetBurialOptions BuryStraight()
        {
            return new(true, false);
        }

        public static AssetBurialOptions BuryAdjusted()
        {
            return new(true);
        }

#region IEquatable

        public bool Equals(AssetBurialOptions other)
        {
            return (buryMesh == other.buryMesh) && (adoptTerrainNormal == other.adoptTerrainNormal);
        }

        public override bool Equals(object obj)
        {
            return obj is AssetBurialOptions other && Equals(other);
        }

        public override int GetHashCode()
        {
            unchecked
            {
                return (buryMesh.GetHashCode() * 397) ^ adoptTerrainNormal.GetHashCode();
            }
        }

        public static bool operator ==(AssetBurialOptions left, AssetBurialOptions right)
        {
            return left.Equals(right);
        }

        public static bool operator !=(AssetBurialOptions left, AssetBurialOptions right)
        {
            return !left.Equals(right);
        }

#endregion
    }
}
