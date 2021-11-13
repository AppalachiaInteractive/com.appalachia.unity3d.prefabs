namespace Appalachia.Rendering.Prefabs.Core.States
{
    public enum RenderingStateReasonCode
    {
        NONE = 0,

        PREFAB_RENDER_SET_NULL = 10,
        PREFAB_RENDER_SET_EMPTY = 11,

        DISTANCE_REFERENCE_NULL = 20,

        GPUI_PREFAB_MANAGER_NULL = 30,
#if UNITY_EDITOR
        GPUI_SIMULATOR_NULL = 31,
#endif

        STATE_INVALID = 40,

        NOT_ENABLED = 50,
        NOT_ACTIVE_SELF = 51,
        NOT_ACTIVE_HIERARCHY = 52,

#if UNITY_EDITOR
        NOT_SIMULATING = 60,
#endif

        PREVENT_OPTIONS = 70,
        PREVENT_ERROR = 71
    }
}
