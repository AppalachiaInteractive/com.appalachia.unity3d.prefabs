namespace Appalachia.Rendering.Prefabs.Core.States
{
    public enum RenderLoopBreakCode
    {
        LoopSafetyBreak = 10,
        OptionsDoNotAllowUpdates = 20,
        CurrentStateNotRendering = 30,
        NextStateNotRendering = 40,
        CyclesGreaterThanPrefabCount = 50,
        CycleManagerNoneWaiting = 60,
        CycleManagerNoneCompleted = 61,
        CycleManagerCompletedQueueDepth = 65,
        ProcessedMoreThanExplicitLimit = 70,
        ExceededAllowedTime = 80
    }
}
