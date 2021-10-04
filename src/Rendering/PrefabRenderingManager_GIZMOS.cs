#region

using Appalachia.Editing.Debugging;
using Appalachia.Editing.Debugging.Handle;
using Appalachia.Editing.Preferences;
using Appalachia.Editing.Preferences.Globals;
using Appalachia.Prefabs.Rendering.Runtime;
using Appalachia.Spatial.MeshBurial.Processing;
using Unity.Profiling;
using UnityEditor;
using UnityEngine;

namespace Appalachia.Prefabs.Rendering
{

#endregion

    public partial class PrefabRenderingManager
    {

#if UNITY_EDITOR

        private const string G_ = "Prefab Rendering/Gizmos";
        private static PREF<float> gizmoRayShowTime;
        
        private Vector3[] points;
        private int[] indexPairs;

        private GameViewSelectionManager _selectionManager;

        private const string _PRF_PFX = nameof(PrefabRenderingManager) + ".";
        private static readonly ProfilerMarker _PRF_OnDrawGizmos = new ProfilerMarker(_PRF_PFX + nameof(OnDrawGizmos));
        private void OnDrawGizmos()
        {
            using (_PRF_OnDrawGizmos.Auto())
            {
                if (!GizmoCameraChecker.ShouldRenderGizmos())
                {
                    return;
                }
                
                var options = RenderingOptions;

                if (options.gizmos.burialGizmosEnabled)
                {
                    var b = MeshBurialExecutionManager.bounds;
                    SmartHandles.DrawWireCube(b.center, b.size, ColorPrefs.Instance.MeshBurialBounds.v);
                }


                if (gizmoRayShowTime == null)
                {
                    gizmoRayShowTime = PREFS.REG(G_, "Max Size", 1f, .1f, 10f);
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
                
                if (_selectionManager == null) _selectionManager = new GameViewSelectionManager();

                if (_selectionManager.TryGameViewSelection(gpui.cameraData.mainCamera, renderingOptions.global.layerMask, out var hit))
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
                            Selection.SetActiveObjectWithContext(comp.gameObject, this);
                        }
                    }
                }
            }
        }
        
#endif
    }
}