#region

using System;
using Appalachia.Rendering.Prefabs.Rendering.Runtime;

#endregion

namespace Appalachia.Rendering.Prefabs.Rendering.MultiStage.Trees
{
    public class TreeGPUInstancerPrefab : MultiStageGPUInstancerPrefab<TreeStageType>
    {
        public PrefabRenderingInstance normal;
        public PrefabRenderingInstance stump;
        public PrefabRenderingInstance stumpRotted;
        public PrefabRenderingInstance felled;
        public PrefabRenderingInstance felledBare;
        public PrefabRenderingInstance felledBareRotted;
        public PrefabRenderingInstance dead;
        public PrefabRenderingInstance deadFelled;
        public PrefabRenderingInstance deadFelledRotted;
        public bool IsNormal => tree && HasStage(TreeStageType.Normal);
        public bool IsStump => tree && HasStage(TreeStageType.Stump);
        public bool IsStumpRotted => tree && HasStage(TreeStageType.StumpRotted);
        public bool IsFelled => tree && HasStage(TreeStageType.Felled);
        public bool IsFelledBare => tree && HasStage(TreeStageType.FelledBare);
        public bool IsFelledBareRotted => tree && HasStage(TreeStageType.FelledBareRotted);
        public bool IsDead => tree && HasStage(TreeStageType.Dead);
        public bool IsDeadFelled => tree && HasStage(TreeStageType.DeadFelled);
        public bool IsDeadFelledRotted => tree && HasStage(TreeStageType.DeadFelledRotted);

        protected override PrefabRenderingInstance GetInstanceForStage(TreeStageType stage)
        {
            switch (stage)
            {
                case TreeStageType.None:
                    return null;
                case TreeStageType.Normal:
                    return normal;
                case TreeStageType.Stump:
                    return stump;
                case TreeStageType.StumpRotted:
                    return stumpRotted;
                case TreeStageType.Felled:
                    return felled;
                case TreeStageType.FelledBare:
                    return felledBare;
                case TreeStageType.FelledBareRotted:
                    return felledBareRotted;
                case TreeStageType.Dead:
                    return dead;
                case TreeStageType.DeadFelled:
                    return deadFelled;
                case TreeStageType.DeadFelledRotted:
                    return deadFelledRotted;
                default:
                    throw new ArgumentOutOfRangeException(nameof(stage), stage, null);
            }
        }

        protected override bool CanEnableStage(TreeStageType stage)
        {
            switch (stage)
            {
                case TreeStageType.None:
                    return true;
                case TreeStageType.Normal:
                    return normal != null;
                case TreeStageType.Stump:
                    return stump != null;
                case TreeStageType.StumpRotted:
                    return stumpRotted != null;
                case TreeStageType.Felled:
                    return felled != null;
                case TreeStageType.FelledBare:
                    return felledBare != null;
                case TreeStageType.FelledBareRotted:
                    return felledBareRotted != null;
                case TreeStageType.Dead:
                    return dead != null;
                case TreeStageType.DeadFelled:
                    return deadFelled != null;
                case TreeStageType.DeadFelledRotted:
                    return deadFelledRotted != null;
                default:
                    throw new ArgumentOutOfRangeException(nameof(stage), stage, null);
            }
        }

        // X | Q       sets bit(s) Q
        // X & ~Q      clears bit(s) Q
        // ~X          flips/inverts all bits in X
        protected override void SetFlag(TreeStageType stage)
        {
            currentStages |= stage;
        }

        protected override void ClearFlag(TreeStageType stage)
        {
            currentStages &= ~stage;
        }
    }
}
