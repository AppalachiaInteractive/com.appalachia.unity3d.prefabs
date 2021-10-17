/*
using AwesomeTechnologies.Shaders;
using AwesomeTechnologies.VegetationSystem;

using UnityEngine;


namespace Appalachia.Shaders
{
    public class InternalVSPShaderController : IShaderController
    {
        public bool MatchShader(string shaderName)
        {
            if (string.IsNullOrEmpty(shaderName))
            {
                return false;
            }

            return shaderName.StartsWith("appalachia/");
        }

        
        
        public ShaderControllerSettings Settings { get; set; }
        
        public void CreateDefaultSettings(Material[] materials)
        {
            Settings = new ShaderControllerSettings
            {
                Heading = "Internal Tree Shader",
                Description = "",
                SupportsInstantIndirect = true,
                LODFadeCrossfade = true,
                LODFadePercentage = false,
                SampleWind = false,
                UpdateWind = false,
                DynamicHUE = false,
                BillboardSnow = false,
                BillboardHDWind = false,
                BillboardRenderMode = BillboardRenderMode.Standard,
            };
           }

        public void UpdateMaterial(Material material, EnvironmentSettings environmentSettings)
        {
            if (Settings == null) return;

            /*Shader.SetGlobalFloat("_Lux_SnowAmount", environmentSettings.SnowAmount);
            Shader.SetGlobalColor("_Lux_SnowColor", environmentSettings.SnowColor);
            Shader.SetGlobalColor("_Lux_SnowSpecColor", environmentSettings.SnowSpecularColor);
            Shader.SetGlobalVector("_Lux_RainfallRainSnowIntensity",new Vector3(environmentSettings.RainAmount, environmentSettings.RainAmount, environmentSettings.SnowAmount));
            Shader.SetGlobalVector("_Lux_WaterFloodlevel",new Vector4(environmentSettings.RainAmount, environmentSettings.RainAmount, environmentSettings.RainAmount,environmentSettings.RainAmount));


            if (ShaderControllerSettings.HasShader(material, FoliageShaderNames))
            {
                material.SetColor("_HueVariation", Settings.GetColorPropertyValue("ColorVariation"));
                material.SetFloat("_TranslucencyStrength", Settings.GetFloatPropertyValue("TranslucencyStrength"));
                material.SetFloat("_Cutoff", Settings.GetFloatPropertyValue("AlphaCutoff"));  
            }
            else
            {
                material.SetColor("_HueVariation", Settings.GetColorPropertyValue("BarkColorVariation"));
                material.SetFloat("_TranslucencyStrength", Settings.GetFloatPropertyValue("BarkTranslucencyStrength"));
                material.SetFloat("_Cutoff", Settings.GetFloatPropertyValue("BarkAlphaCutoff"));
            }


            material.SetFloat("_TumbleStrength", Settings.GetFloatPropertyValue("TumbleStrength"));
            material.SetFloat("_TumbleFrequency", Settings.GetFloatPropertyValue("TumbleFrequency"));
            material.SetFloat("_TimeOffset", Settings.GetFloatPropertyValue("TimeOffset"));
            material.SetFloat("_LeafTurbulence", Settings.GetFloatPropertyValue("LeafTurbulence"));
            material.SetFloat("_EdgeFlutterInfluence", Settings.GetFloatPropertyValue("EdgeFlutterInfluence"));#1#
        }

        public void UpdateWind(Material material, WindSettings windSettings)
        {
           
        }

        public bool MatchBillboardShader(Material[] materials)
        {
            return false;
        }
    }
}
*/
