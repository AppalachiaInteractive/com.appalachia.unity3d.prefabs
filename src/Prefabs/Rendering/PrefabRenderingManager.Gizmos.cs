#if UNITY_EDITOR

#region

using Appalachia.Core.Debugging;
using Appalachia.Core.Preferences;
using Appalachia.Core.Preferences.Globals;
using Appalachia.Editing.Debugging.Handle;
using Appalachia.Rendering.Prefabs.Rendering.Runtime;
using Unity.Profiling;
using UnityEngine;

namespace Appalachia.Rendering.Prefabs.Rendering
{

    #endregion

    public partial class PrefabRenderingManager
    {
        #region Preferences

        private static PREF<float> gizmoRayShowTime;

        #endregion

        #region Fields and Autoproperties

        private GameViewSelectionManager _selectionManager;
        private int[] indexPairs;

        private Vector3[] points;

        #endregion

        #region Event Functions

        private void OnDrawGizmos()
        {
            using (_PRF_OnDrawGizmos.Auto())
            {
                if (!enabled) return;
                if (ShouldSkipUpdate) return;
                
                if (!GizmoCameraChecker.ShouldRenderGizmos())
                {
                    return;
                }

                var options = RenderingOptions;

                if (options.gizmos.burialGizmosEnabled)
                {
                    var b = _meshBurialExecutionManager.bounds;
                    SmartHandles.DrawWireCube(b.center, b.size, ColorPrefs.Instance.MeshBurialBounds.v);
                }

                if (gizmoRayShowTime == null)
                {
                    gizmoRayShowTime = PREFS.REG(PKG.Prefs.Gizmos.Base, "Max Size", 1f, .1f, 10f);
                }

                if (!options.gizmos.gizmosEnabled)
                {
                    return;
                }

                if (!gpuiRuntimeBuffersInitialized)
                {
                    return;
                }

                if (renderingSets.Sets.Count == 0)
                {
                    return;
                }

                if (_selectionManager == null)
                {
                    _selectionManager = new GameViewSelectionManager();
                }

                if (_selectionManager.TryGameViewSelection(
                        gpui.cameraData.mainCamera,
                        renderingOptions.global.layerMask,
                        out var hit
                    ))
                {
                    var parent = hit.transform.parent;

                    if (parent != null)
                    {
                        var comp = parent.GetComponentInChildren<PrefabRenderingInstanceBehaviour>();

                        if (comp == null)
                        {
                            parent = parent.parent;

                            if (parent != null)
                            {
                                comp = parent.GetComponentInChildren<PrefabRenderingInstanceBehaviour>();
                            }
                        }

                        if (comp != null)
                        {
                            UnityEditor.Selection.SetActiveObjectWithContext(comp.gameObject, this);
                        }
                    }
                }
            }
        }

        #endregion
    }
}

#endif
