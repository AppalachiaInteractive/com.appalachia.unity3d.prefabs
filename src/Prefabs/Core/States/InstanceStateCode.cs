namespace Appalachia.Rendering.Prefabs.Core.States
{
    public enum InstanceStateCode
    {
        NotSet = 0,
        Normal = 10,
        OutsideOfMaximumChangeRadius = 20,
        OutsideOfFrustum = 30,
        Delayed = 90,
        DelayedBySelection = 91,
        ForceDisabled = 100
    }
}
