using UnityEditor;
using UnityEngine;

namespace Appalachia.Rendering.Shading.Importers
{
    internal class DebugAssetPostProcessor : AssetPostprocessor
    {
        private const string NAME = "Toggle Asset Import Debugging";

        private static Camera _mainCamera;

        public static bool enabled;

        [MenuItem(PKG.Menu.Appalachia.Tools.Base + NAME, true, priority = PKG.Menu.Appalachia.Tools.Priority)]
        [UnityEditor.MenuItem(NAME, true)]
        public static bool ToggleAssetImportDebuggingValidate()
        {
            Menu.SetChecked(NAME, enabled);
            return true;
        }

        [MenuItem(PKG.Menu.Appalachia.Tools.Base + NAME, priority = PKG.Menu.Appalachia.Tools.Priority)]
        public static void ToggleAssetImportDebugging()
        {
            SetEnabled(!enabled);
        }

        private static void SetEnabled(bool e)
        {
            if (e && !enabled)
            {
                enabled = true;
            }
            else if (!e && enabled)
            {
                enabled = false;
            }
        }

        /*private static void OnPostprocessAllAssets(
            string[] importedAssets,
            string[] deletedAssets,
            string[] movedAssets,
            string[] movedFromAssetPaths)
        {
            if (!enabled)
            {
                return;
            }

            foreach (var str in importedAssets)
            {
                Context.Log.Info("Reimported Asset: " + str);
            }

            foreach (var str in deletedAssets)
            {
                Context.Log.Info("Deleted Asset: " + str);
            }

            for (var i = 0; i < movedAssets.Length; i++)
            {
                Context.Log.Info("Moved Asset: " + movedAssets[i] + " from: " + movedFromAssetPaths[i]);
            }
        }*/
    }
}
