#region

using System;
using Appalachia.Core.Editing.Attributes;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Core.AssetMetadata.Options.ModelType.Positioning
{
    [Serializable]
    public struct AssetBurialOptions : IEquatable<AssetBurialOptions>, ISerializationCallbackReceiver
    {
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

        public AssetBurialOptions(bool buryMesh = true, bool adoptTerrainNormal = true, float adjustmentStrength = 1.0f)
        {
            this.buryMesh = buryMesh;
            this.adoptTerrainNormal = adoptTerrainNormal;
            this.adjustmentStrength = adjustmentStrength;
        }

        [ToggleLeft, SmartLabel]
        [HorizontalGroup("A")]
        [SerializeField]
        public bool buryMesh;

        [ToggleLeft, SmartLabel]
        [HorizontalGroup("A")]
        [EnableIf(nameof(buryMesh))]
        [SerializeField]
        public bool adoptTerrainNormal;

        [SmartLabel]
        [EnableIf(nameof(buryMesh))]
        [SerializeField]
        public float adjustmentStrength;

        public void CopyFrom(AssetBurialOptions other)
        {
            buryMesh = other.buryMesh;
            adoptTerrainNormal = other.adoptTerrainNormal;
            adjustmentStrength = other.adjustmentStrength;
        }

        public static AssetBurialOptions DoNotBury()
        {
            return new AssetBurialOptions(false, false);
        }

        public static AssetBurialOptions BuryStraight()
        {
            return new AssetBurialOptions(true, false);
        }

        public static AssetBurialOptions BuryAdjusted()
        {
            return new AssetBurialOptions(true);
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
    }
}
