using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using Appalachia.CI.Integration;
using Appalachia.CI.Integration.Assets;
using Appalachia.CI.Integration.FileSystem;
using Appalachia.Core.Scriptables;
using Sirenix.OdinInspector;
using UnityEditor;
using UnityEngine;

namespace Appalachia.Rendering.Shading.Features
{
    [CreateAssetMenu(fileName = "Appalachia Shader Features", menuName = "Appalachia/Data/Appalachia.Rendering.Shading/Appalachia Shader Features", order = 100)]
    public class AppalachiaShaderFeatures : SelfSavingSingletonScriptableObject<AppalachiaShaderFeatures>
    {
        public List<AppalachiaShaderFeature> features = new List<AppalachiaShaderFeature>();

        [Button(Name = "Compile")]
        private void InjectShaderFeature()
        {
            UpdateAllShaders();

            EditorUtility.SetDirty(this);
        }

        public void UpdateAllShaders()
        {
            //var build = new StringBuilder();
            //var build_Append = new StringBuilder();

            var paths = new List<string>();

            foreach (var feature in features)
            {
                foreach (var shader in feature.shaders)
                {
                    //UpdateShader(feature, shader, paths, build, build_Append);
                    UpdateShader(feature, shader, paths);
                }
            }

            ReimportShaders(paths);
        }

        public void ReimportShaders(List<string> paths)
        {
            AssetDatabaseManager.Refresh();

            foreach (var shaderPath in paths)
            {
                AssetDatabaseManager.ImportAsset(shaderPath);
            }
        }

        public void UpdateShader(
            AppalachiaShaderFeature feature,
            Shader shader,
            List<string> paths)
        {
            if ((feature == null) || (shader == null))
            {
                return;
            }

            if (paths == null)
            {
                paths = new List<string>();
            }

            var build = new StringBuilder();

            var shaderAssetPath = AssetDatabaseManager.GetAssetPath(shader);
            paths.Add(shaderAssetPath);

            var state = 0;

            using (var reader = new StreamReader(shaderAssetPath))
            {
                while (!reader.EndOfStream)
                {
                    var line = reader.ReadLine();

                    if (line == null)
                    {
                        continue;
                    }

                    if (state == 0)
                    {
                        if (line.Contains(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_START_searchterm))
                        {
                            state = 1;

                            build.Append(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_START);

                            if (feature.compatibility == AppalachiaShaderFeatureCompatability.GPUInstancer)
                            {
                                AddGPUICompatability(build);
                            }
                            else if (feature.compatibility == AppalachiaShaderFeatureCompatability.VegetationStudioPro)
                            {
                                AddVSPCompatability(shader, build);
                            }
                            else if (feature.compatibility ==
                                AppalachiaShaderFeatureCompatability.GPUInstancerAndVegetationStudioPro)
                            {
                                AddVSPAndGPUICompatability(shader, build);
                            }

                            if (feature.lodFade == AppalachiaShaderFeatureLODStyle.Dither)
                            {
                                build.Append(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_LODFADE_DITHER);
                            }
                            else if (feature.lodFade == AppalachiaShaderFeatureLODStyle.Scale)
                            {
                                build.Append(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_LODFADE_SCALE);
                            }

                            build.Append(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_END);
                        }
                        else
                        {
                            build.AppendLine(line);
                        }
                    }
                    else if (state == 1)
                    {
                        if (line.Contains(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_END_searchterm))
                        {
                            state = 0;
                        }
                    }
                }
            }

           AppaFile.WriteAllText(shaderAssetPath, build.ToString());
        }

        private void AddGPUICompatability(StringBuilder build)
        {
            build.Append(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_GPU_INSTANCER);
        }
        
        private void AddVSPCompatability(Shader shader, StringBuilder build)
        {
            var shaderName = shader.name.ToLower();

            if (shaderName.Contains("grass") || shaderName.Contains("plant"))
            {
                build.Append(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_VEGETATION_STUDIO_FOLIAGE);
            }
            else
            {
                build.Append(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_VEGETATION_STUDIO_GENERAL);
            }
        }
        
        
        private void AddVSPAndGPUICompatability(Shader shader, StringBuilder build)
        {
            build.Append(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_VEGETATION_STUDIO_ENABLED_IFDEF);
            AddVSPCompatability(shader, build);
            build.Append(APPALACHIA_SHADER_FEATURE_CONSTANTS.ELSE);
            AddGPUICompatability(build);
            build.Append(APPALACHIA_SHADER_FEATURE_CONSTANTS.ENDIF);
        }
        
        /*public void UpdateShader(
            AppalachiaShaderFeature feature,
            Shader shader,
            List<string> paths,
            StringBuilder build = null,
            StringBuilder build_Append = null)
        {
            if ((feature == null) || (shader == null))
            {
                return;
            }

            if (build == null)
            {
                build = new StringBuilder();
            }

            if (build_Append == null)
            {
                build_Append = new StringBuilder();
            }

            if (paths == null)
            {
                paths = new List<string>();
            }

            build.Clear();
            build_Append.Clear();

            var shaderAssetPath = AssetDatabaseManager.GetAssetPath(shader);
            paths.Add(shaderAssetPath);

            var state = 0;

            using (var reader = new AppaStreamReader(shaderAssetPath))
            {
                while (!reader.EndOfStream)
                {
                    var line = reader.ReadLine();

                    if (line == null)
                    {
                        continue;
                    }

                    if (line.Contains(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_START_searchterm))
                    {
                        state = 1;
                    }
                    else if (line.Contains(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_END_searchterm) && (state == 1))
                    {
                        state = 2;
                    }
                    else if (state == 0)
                    {
                        build.AppendLine(line);
                    }
                    else if (state == 2)
                    {
                        build_Append.AppendLine(line);
                    }
                }
            }

            if (state != 2)
            {
                return;
            }

            build.Append(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_START);

            if (feature.compatibility == AppalachiaShaderFeatureCompatability.GPUInstancer)
            {
                build.Append(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_GPU_INSTANCER);
            }
            else if (feature.compatibility == AppalachiaShaderFeatureCompatability.VegetationStudioPro)
            {
                var shaderName = shader.name.ToLower();

                if (shaderName.Contains("grass") || shaderName.Contains("plant"))
                {
                    build.Append(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_VEGETATION_STUDIO_FOLIAGE);
                }
                else if (shaderName.Contains("tree") ||
                    shaderName.Contains("leaves") ||
                    shaderName.Contains("leaf") ||
                    shaderName.Contains("bark"))
                {
                    build.Append(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_VEGETATION_STUDIO_GENERAL);
                }
            }

            if (feature.lodFade == AppalachiaShaderFeatureLODStyle.Dither)
            {
                build.Append(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_LODFADE_DITHER);
            }
            else if (feature.lodFade == AppalachiaShaderFeatureLODStyle.Scale)
            {
                build.Append(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_LODFADE_SCALE);
            }

            build.Append(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_END);

            build.Append(build_Append);

           AppaFile.WriteAllText(shaderAssetPath, build.ToString());
        }*/

        public Dictionary<string, Tuple<Shader, AppalachiaShaderFeature>> GetShaderLookup()
        {
            var lookup = new Dictionary<string, Tuple<Shader, AppalachiaShaderFeature>>();

            for (var i = features.Count - 1; i >= 0; i--)
            {
                for (var j = features[i].shaders.Count - 1; j >= 0; j--)
                {
                    if (features[i].shaders[j] == null)
                    {
                        features[i].shaders.RemoveAt(j);
                    }
                }

                if (features[i].shaders.Count == 0)
                {
                    features.RemoveAt(i);
                }
            }

            foreach (var feature in features)
            {
                foreach (var shader in feature.shaders)
                {
                    var path = AssetDatabaseManager.GetAssetPath(shader);

                    lookup.Add(path, new Tuple<Shader, AppalachiaShaderFeature>(shader, feature));
                }
            }

            return lookup;
        }

        /*private void InjectShaderFeature()
        {
            var build = new StringBuilder();
            var build_Append = new StringBuilder();

            var paths = new List<string>();

            foreach (var feature in features)
            {
                foreach (var shader in feature.shaders)
                {
                    if (shader == null)
                    {
                        continue;
                    }

                    build.Clear();
                    build_Append.Clear();

                    var shaderAssetPath = AssetDatabaseManager.GetAssetPath(shader);
                    paths.Add(shaderAssetPath);

                    var state = 0;

                    using (var reader = new AppaStreamReader(shaderAssetPath))
                    {
                        while (!reader.EndOfStream)
                        {
                            var line = reader.ReadLine();

                            if (line == null) continue;

                            if (line.Contains(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_START_searchterm))
                            {
                                state = 1;
                            }
                            else if (line.Contains(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_END_searchterm) && (state == 1))
                            {
                                state = 2;
                            }
                            else if (state == 0)
                            {
                                build.AppendLine(line);
                            }
                            else if (state == 2)
                            {
                                build_Append.AppendLine(line);
                            }
                        }
                    }

                    if (state != 2)
                    {
                        continue;
                    }

                    build.Append(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_START);
                    
                    if (feature.compatibility == AppalachiaShaderFeatureCompatability.GPUInstancer)
                    {
                        build.Append(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_GPU_INSTANCER);
                    }
                    else if (feature.compatibility == AppalachiaShaderFeatureCompatability.VegetationStudioPro)
                    {
                        var shaderName = shader.name.ToLower();

                        if (shaderName.Contains("grass") || shaderName.Contains("plant"))
                        {
                            build.Append(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_VEGETATION_STUDIO_FOLIAGE);
                        }
                        else if (shaderName.Contains("tree") ||
                            shaderName.Contains("leaves") ||
                            shaderName.Contains("leaf") ||
                            shaderName.Contains("bark"))
                        {
                            build.Append(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_VEGETATION_STUDIO_GENERAL);
                        }
                    }

                    if (feature.lodFade == AppalachiaShaderFeatureLODStyle.Dither)
                    {
                        build.Append(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_LODFADE_DITHER);
                    }
                    else if (feature.lodFade == AppalachiaShaderFeatureLODStyle.Scale)
                    {
                        build.Append(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_LODFADE_SCALE);
                    }

                    build.Append(APPALACHIA_SHADER_FEATURE_CONSTANTS.FEATURE_END);
                    
                    build.Append(build_Append);

                   AppaFile.WriteAllText(shaderAssetPath, build.ToString());
                }
            }


            AssetDatabaseManager.Refresh();
            
            foreach (var shaderPath in paths)
            {
                AssetDatabaseManager.ImportAsset(shaderPath);
            }
        }*/
    }
}
