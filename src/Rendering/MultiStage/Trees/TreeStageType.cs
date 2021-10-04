#region

using System;

#endregion

namespace Appalachia.Prefabs.Rendering.MultiStage.Trees
{
    [Flags]
    public enum TreeStageType
    {
        None = 0,
        Normal = 1 << 0,
        Stump = 1 << 1,
        StumpRotted = 1 << 3,
        Felled = 1 << 4,
        FelledBare = 1 << 5,
        FelledBareRotted = 1 << 6,
        Dead = 1 << 7,
        DeadFelled = 1 << 8,
        DeadFelledRotted = 1 << 9
    }
}
