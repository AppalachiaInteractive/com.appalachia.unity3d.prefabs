#region

using System;
using System.Diagnostics;
using Appalachia.Core.Attributes.Editing;
using Appalachia.Utility.Constants;
using Sirenix.OdinInspector;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.ModelType.Positioning
{
    [Serializable]
    public struct AssetBurialOptions : IEquatable<AssetBurialOptions>, ISerializationCallbackReceiver
    {
        public AssetBurialOptions(
            bool buryMesh = true,
            bool adoptTerrainNormal = true,
            float adjustmentStrength = 1.0f)
        {
            this.buryMesh = buryMesh;
            this.adoptTerrainNormal = adoptTerrainNormal;
            this.adjustmentStrength = adjustmentStrength;
        }

        #region Fields and Autoproperties

        [ToggleLeft]
        [SmartLabel]
        [HorizontalGroup("A")]
        [EnableIf(nameof(buryMesh))]
        [SerializeField]
        public bool adoptTerrainNormal;

        [ToggleLeft]
        [SmartLabel]
        [HorizontalGroup("A")]
        [SerializeField]
        public bool buryMesh;

        [SmartLabel]
        [EnableIf(nameof(buryMesh))]
        [SerializeField]
        public float adjustmentStrength;

        #endregion

        public static AssetBurialOptions BuryAdjusted()
        {
            return new(true);
        }

        public static AssetBurialOptions BuryStraight()
        {
            return new(true, false);
        }

        public static AssetBurialOptions DoNotBury()
        {
            return new(false, false);
        }

        public void CopyFrom(AssetBurialOptions other)
        {
            buryMesh = other.buryMesh;
            adoptTerrainNormal = other.adoptTerrainNormal;
            adjustmentStrength = other.adjustmentStrength;
        }

        #region ISerializationCallbackReceiver Members

        public void OnBeforeSerialize()
        {
            using var scope = APPASERIALIZE.OnBeforeSerialize();
        }

        public void OnAfterDeserialize()
        {
            using var scope = APPASERIALIZE.OnAfterDeserialize();

            if (adjustmentStrength == 0f)
            {
                adjustmentStrength = 1.0f;
            }
        }

        #endregion

        #region IEquatable

        [DebuggerStepThrough]
        public bool Equals(AssetBurialOptions other)
        {
            return (buryMesh == other.buryMesh) && (adoptTerrainNormal == other.adoptTerrainNormal);
        }

        [DebuggerStepThrough]
        public override bool Equals(object obj)
        {
            return obj is AssetBurialOptions other && Equals(other);
        }

        [DebuggerStepThrough]
        public override int GetHashCode()
        {
            unchecked
            {
                return (buryMesh.GetHashCode() * 397) ^ adoptTerrainNormal.GetHashCode();
            }
        }

        [DebuggerStepThrough]
        public static bool operator ==(AssetBurialOptions left, AssetBurialOptions right)
        {
            return left.Equals(right);
        }

        [DebuggerStepThrough]
        public static bool operator !=(AssetBurialOptions left, AssetBurialOptions right)
        {
            return !left.Equals(right);
        }

        #endregion
    }
}
