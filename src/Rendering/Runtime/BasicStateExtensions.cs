namespace Appalachia.Prefabs.Rendering.Runtime
{
    internal static class BasicStateExtensions
    {
        internal static bool on(this State state)
        {
            return state == State.Enabled;
        }

        internal static bool off(this State state)
        {
            return state == State.Disabled;
        }

        internal static bool enabled(this State state)
        {
            return state == State.Enabled;
        }

        internal static bool disabled(this State state)
        {
            return state == State.Disabled;
        }

        internal static bool doEnable(this StateChange state)
        {
            return state == StateChange.Enable;
        }

        internal static bool doDisable(this StateChange state)
        {
            return state == StateChange.Disable;
        }

        internal static bool doIgnore(this StateChange state)
        {
            return state == StateChange.Ignore;
        }

        internal static bool turnOn(this StateChange state)
        {
            return state == StateChange.Enable;
        }

        internal static bool turnOff(this StateChange state)
        {
            return state == StateChange.Disable;
        }

        internal static bool ignore(this StateChange state)
        {
            return state == StateChange.Ignore;
        }

        internal static bool changing(this StateChange state)
        {
            return state != StateChange.Ignore;
        }
    }
}
