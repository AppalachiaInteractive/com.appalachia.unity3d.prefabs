using System.Collections.Generic;
using System.Security.Cryptography;
using Appalachia.CI.Integration.FileSystem;
using Appalachia.Core.Attributes;
using Appalachia.Rendering.Shading.Features;
using UnityEditor;
using UnityEngine;

namespace Appalachia.Rendering.Shading.Importers
{
    [CallStaticConstructorInEditor]
    public sealed class AppalachiaShaderPostProcessor : AssetPostprocessor
    {
        #region Constants and Static Readonly

        private const string NAME = "Shader Feature Compilation";

        #endregion

        // [CallStaticConstructorInEditor] should be added to the class (initsingletonattribute)
        static AppalachiaShaderPostProcessor()
        {
            AppalachiaShaderFeatures.InstanceAvailable += i => _appalachiaShaderFeatures = i;
        }

        #region Static Fields and Autoproperties

        public static bool enabled = true;

        private static AppalachiaShaderFeatures _appalachiaShaderFeatures;

        private static Dictionary<string, byte[]> processed = new Dictionary<string, byte[]>();
        private static HashAlgorithm _hasher;

        #endregion

        #region Event Functions

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

            if (processed == null)
            {
                processed = new Dictionary<string, byte[]>();
            }

            if (_hasher == null)
            {
                _hasher = HashAlgorithm.Create();
            }

            var features = _appalachiaShaderFeatures;
            var lookup = features.GetShaderLookup();
            var paths = new List<string>();

            foreach (var importedAsset in importedAssets)
            {
                if (!importedAsset.EndsWith(".shader"))
                {
                    continue;
                }

                if (!lookup.ContainsKey(importedAsset))
                {
                    continue;
                }

                var fullPath = importedAsset.Replace("Assets", Application.dataPath);

                byte[] hash;

                using (var stream = AppaFile.OpenRead(fullPath))
                {
                    hash = _hasher.ComputeHash(stream);
                }

                var process = false;

                if (processed.ContainsKey(importedAsset))
                {
                    var existingHash = processed[importedAsset];

                    for (var i = 0; i < existingHash.Length; i++)
                    {
                        var a = existingHash[i];
                        var b = hash[i];

                        if (a != b)
                        {
                            process = true;
                            break;
                        }
                    }

                    if (!process)
                    {
                        continue;
                    }
                }

                var value = lookup[importedAsset];

                features.UpdateShader(value.Item2, value.Item1, paths);
            }

            if (paths.Count > 0)
            {
                features.ReimportShaders(paths);
            }

            foreach (var asset in paths)
            {
                var fullPath = asset.Replace("Assets", Application.dataPath);

                byte[] hash;

                using (var stream = AppaFile.OpenRead(fullPath))
                {
                    hash = _hasher.ComputeHash(stream);
                }

                if (processed.ContainsKey(asset))
                {
                    processed[asset] = hash;
                }
                else
                {
                    processed.Add(asset, hash);
                }
            }
        }

        #endregion

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

        #region Menu Items

        [MenuItem(PKG.Menu.Appalachia.Tools.Base + NAME, priority = PKG.Menu.Appalachia.Tools.Priority)]
        public static void ToggleShaderFeatureCompilation()
        {
            SetEnabled(!enabled);
        }

        [MenuItem(PKG.Menu.Appalachia.Tools.Base + NAME, true)]
        public static bool ToggleShaderFeatureCompilationValidate()
        {
            Menu.SetChecked(PKG.Menu.Appalachia.Tools.Base + NAME, enabled);
            return true;
        }

        #endregion
    }
}
