#region

using System;
using Appalachia.Core.Collections;
using Appalachia.Core.Collections.Implementations.Lists;
using Appalachia.Rendering.Prefabs.Core.States;
using UnityEngine;

#endregion

namespace Appalachia.Rendering.Prefabs.Core.Collections
{
    [Serializable]
    public class RenderingStateReasonCodeLookup : AppaLookup<RenderingStateReasonCode, string,
        AppaList_RenderingStateReasonCode, stringList>
    {
        /// <inheritdoc />
        protected override bool NoTracking => true;

        public void InitializeLookup()
        {
            AddOrUpdate(RenderingStateReasonCode.NONE, "");
            AddOrUpdate(
                RenderingStateReasonCode.PREFAB_RENDER_SET_NULL,
                "Prefab Rendering Sets Collection Is Not Set"
            );
            AddOrUpdate(
                RenderingStateReasonCode.PREFAB_RENDER_SET_EMPTY,
                "Prefab Rendering Sets Collection Is Empty"
            );
            AddOrUpdate(
                RenderingStateReasonCode.DISTANCE_REFERENCE_NULL,
                "Distance Reference Point Is Not Set"
            );
            AddOrUpdate(RenderingStateReasonCode.GPUI_PREFAB_MANAGER_NULL, "GPUI Prefab Manager Is Not Set");
#if UNITY_EDITOR
            AddOrUpdate(RenderingStateReasonCode.GPUI_SIMULATOR_NULL, "GPUI Editor Simulator Is Not Created");
#endif
            AddOrUpdate(RenderingStateReasonCode.STATE_INVALID, "Pending State Was Invalid");
            AddOrUpdate(RenderingStateReasonCode.NOT_ENABLED,   "Prefab Rendering Manager Is Not Enabled");
            AddOrUpdate(
                RenderingStateReasonCode.NOT_ACTIVE_SELF,
                "Prefab Rendering Manager Is Not Active (Game Object)"
            );
            AddOrUpdate(
                RenderingStateReasonCode.NOT_ACTIVE_HIERARCHY,
                "Prefab Rendering Manager Is Not Active In Hierarchy(Game Object)"
            );
#if UNITY_EDITOR
            AddOrUpdate(RenderingStateReasonCode.NOT_SIMULATING, "Editor Simulation Is Not Started");
#endif
            AddOrUpdate(RenderingStateReasonCode.PREVENT_OPTIONS, "Execution Options Prohibit Rendering");
            AddOrUpdate(RenderingStateReasonCode.PREVENT_ERROR,   "Execution Was Stopped Due To Errors");
        }

        /// <inheritdoc />
        protected override Color GetDisplayColor(RenderingStateReasonCode key, string value)
        {
            return Color.white;
        }

        /// <inheritdoc />
        protected override string GetDisplaySubtitle(RenderingStateReasonCode key, string value)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc />
        protected override string GetDisplayTitle(RenderingStateReasonCode key, string value)
        {
            throw new NotImplementedException();
        }
    }
}
