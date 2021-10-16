using UnityEditor;
using UnityEngine;

namespace Appalachia.Rendering.Shading.Importers
{
    internal class DebugAssetPostProcessor : AssetPostprocessor
    {
        private const string k_MenuName = "Tools/Toggle Asset Import Debugging";

        private static Camera _mainCamera;

        public static bool enabled;

        [MenuItem(k_MenuName, true)]
        public static bool ToggleAssetImportDebuggingValidate()
        {
            Menu.SetChecked(k_MenuName, enabled);
            return true;
        }

        [MenuItem(k_MenuName, priority = 1050)]
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

        private static void OnPostprocessAllAssets(
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
                Debug.Log("Reimported Asset: " + str);
            }

            foreach (var str in deletedAssets)
            {
                Debug.Log("Deleted Asset: " + str);
            }

            for (var i = 0; i < movedAssets.Length; i++)
            {
                Debug.Log("Moved Asset: " + movedAssets[i] + " from: " + movedFromAssetPaths[i]);
            }
        }
    }
}
