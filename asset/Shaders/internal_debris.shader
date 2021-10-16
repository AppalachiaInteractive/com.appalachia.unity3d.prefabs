// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "internal/debris"
{
	Properties
	{
		_NormalZReconstructionStyle("Normal Z Reconstruction Style", Range( 0 , 2)) = 0.02
		_UsePositionAsDeterminant("Use Position As Determinant", Range( 0 , 1)) = 1
		_DeterminantMultipliers("Determinant Multipliers", Vector) = (1000,2000,3000,0)
		_MainTriplanarContrast("Main Triplanar Contrast", Range( 1 , 50)) = 4
		_FinalSaturationMultiplier("Final Saturation Multiplier", Range( 0 , 5)) = 1.1
		_FinalValueMultiplier("Final Value Multiplier", Range( 0 , 5)) = 1.1
		_FinalColorContrast("Final Color Contrast", Range( 0 , 5)) = 1.1
		_FinalAlbedoMatch("Final Albedo Match", Range( 0 , 0.5)) = 1
		_FinalNormalScale("Final Normal Scale", Range( 0.1 , 5)) = 1
		_FinalAOMultiplier("Final AO Multiplier", Range( 0 , 5)) = 1
		_FinalDetailMultiplier("Final Detail Multiplier", Range( 0 , 5)) = 1
		[NoScaleOffset]_MainBaseColorArray("Main Base Color Array", 2DArray) = "white" {}
		[NoScaleOffset]_MainNormalArray("Main Normal Array", 2DArray) = "bump" {}
		_MainTextureScale("Main Texture Scale", Range( 0 , 30)) = 1
		_MainObjectScaleFactor("Main Object Scale Factor", Range( 0 , 1)) = 0.25
		_MainTint("Main Tint", Color) = (1,1,1,1)
		_MainNormalScale("Main Normal Scale", Range( 0.1 , 5)) = 1
		_MainSaturationMultiplier("Main Saturation Multiplier", Range( 0.1 , 2)) = 1
		_MainValueMultiplier("Main Value Multiplier", Range( 0.1 , 2)) = 1
		_MainContrast("Main Contrast", Range( 0.1 , 2)) = 1
		_MainAOTextureStrength("Main AO Texture Strength", Range( 0 , 4)) = 1
		_TerrainAOTextureStrength("Terrain AO Texture Strength", Range( 0 , 4)) = 1
		[NoScaleOffset]_CoverBaseColorArray("Cover Base Color Array", 2DArray) = "white" {}
		[NoScaleOffset]_CoverNormSAOArray("Cover NormSAO Array", 2DArray) = "bump" {}
		_CoverObjectScaleFactor("Cover Object Scale Factor", Range( 0 , 1)) = 0.1
		_CoverAOTextureStrength("Cover AO Texture Strength", Range( 0 , 4)) = 1
		_BottomCoverTextureScale("Bottom Cover Texture Scale", Range( 0 , 30)) = 1
		_BottomCoverNormalScale("Bottom Cover Normal Scale", Range( 0.1 , 5)) = 1
		_BottomCoverTriplanarContrast("Bottom Cover Triplanar Contrast", Range( 1 , 50)) = 4
		_BottomCoverSaturationMultiplier("Bottom Cover Saturation Multiplier", Range( 0.1 , 2)) = 1
		_BottomCoverValueMultiplier("Bottom Cover Value Multiplier", Range( 0.1 , 2)) = 1
		_BottomCoverContrast("Bottom Cover Contrast", Range( 0.1 , 2)) = 1
		_BottomCoverAlbedoMatch("Bottom Cover Albedo Match", Range( 0 , 0.5)) = 1
		_BottomCoverCoverageBasis("Bottom Cover Coverage Basis", Vector) = (0,-0.5,0,0)
		_BottomCoverPeakCoverageRange("Bottom Cover Peak Coverage Range", Vector) = (1,0.5,1,0)
		_BottomCoverBaseCoverageRange("Bottom Cover Base Coverage Range", Vector) = (1,0.5,1,0)
		_BottomCoverAreaNormalStrength("Bottom Cover Area Normal Strength", Range( 0 , 1)) = 1
		_BottomCoverMinimumVerticalRange("Bottom Cover Minimum Vertical Range", Range( 0 , 100)) = 1
		_BottomCoverTargetPercentage("Bottom Cover Target Percentage", Range( 0 , 1)) = 1
		_BottomCoverMaximumVerticalRange("Bottom Cover Maximum Vertical Range", Range( 0 , 250)) = 1
		_BottomCoverFadeSmoothness("Bottom Cover Fade Smoothness", Range( 0 , 1)) = 0.05
		_BottomCoverFadePercentage("Bottom Cover Fade Percentage", Range( 0 , 1)) = 0.2
		_BottomCoverMaskTolerance("Bottom Cover Mask Tolerance", Range( 0 , 0.5)) = 0.02
		_BottomCoverColorLowThreshold("Bottom Cover Color Low Threshold", Range( 0 , 0.5)) = 0.02
		_BottomCoverFinalContrast("Bottom Cover Final Contrast", Range( 0 , 3)) = 1
		_BottomCoverFinalStrength("Bottom Cover Final Strength", Range( 0 , 3)) = 1
		_MiddleCoverTextureScale("Middle Cover Texture Scale", Range( 0 , 30)) = 1
		_MiddleCoverNormalScale("Middle Cover Normal Scale", Range( 0.1 , 5)) = 1
		_MiddleCoverTriplanarContrast("Middle Cover Triplanar Contrast", Range( 1 , 50)) = 4
		_MiddleCoverSaturationMultiplier("Middle Cover Saturation Multiplier", Range( 0.1 , 2)) = 1
		_MiddleCoverValueMultiplier("Middle Cover Value Multiplier", Range( 0.1 , 2)) = 1
		_MiddleCoverContrast("Middle Cover Contrast", Range( 0.1 , 2)) = 1
		_MiddleCoverAlbedoMatch("Middle Cover Albedo Match", Range( 0 , 0.5)) = 1
		_TopCoverMaskScale("Top Cover Mask Scale", Range( 0 , 500)) = 1
		_CoverAlphaMaskMultiplier("Cover Alpha Mask Multiplier", Range( 0.1 , 5)) = 1
		_CoverAlphaMaskContrast("Cover Alpha Mask Contrast", Range( 0.1 , 5)) = 1
		_TopCoverTextureScale("Top Cover Texture Scale", Range( 0 , 30)) = 1
		_TopCoverNormalScale("Top Cover Normal Scale", Range( 0.1 , 5)) = 1
		_TopCoverTriplanarContrast("Top Cover Triplanar Contrast", Range( 1 , 50)) = 4
		_TopCoverSaturationMultiplier("Top Cover Saturation Multiplier", Range( 0.1 , 2)) = 1
		_TopCoverValueMultiplier("Top Cover Value Multiplier", Range( 0.1 , 2)) = 1
		_TopCoverContrast("Top Cover Contrast", Range( 0.1 , 2)) = 1
		_TopCoverAlbedoMatch("Top Cover Albedo Match", Range( 0 , 0.5)) = 1
		_TopCoverCoverageBasis("Top Cover Coverage Basis", Vector) = (0,-0.5,0,0)
		_TopCoverPeakCoverageRange("Top Cover Peak Coverage Range", Vector) = (1,0.5,1,0)
		_TopCoverBaseCoverageRange("Top Cover Base Coverage Range", Vector) = (1,0.5,1,0)
		_TopCoverAreaNormalStrength("Top Cover Area Normal Strength", Range( 0 , 1)) = 1
		_TopCoverMinimumVerticalRange("Top Cover Minimum Vertical Range", Range( 0 , 100)) = 1
		_TopCoverTargetPercentage("Top Cover Target Percentage", Range( 0 , 1)) = 1
		_TopCoverMaximumVerticalRange("Top Cover Maximum Vertical Range", Range( 0 , 250)) = 1
		_TopCoverFadeSmoothness("Top Cover Fade Smoothness", Range( 0 , 1)) = 0.05
		_TopCoverFadePercentage("Top Cover Fade Percentage", Range( 0 , 1)) = 0.2
		_TopCoverMaskTolerance("Top Cover Mask Tolerance", Range( 0 , 0.5)) = 0.02
		_TopCoverColorLowThreshold("Top Cover Color Low Threshold", Range( 0 , 0.5)) = 0.02
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		_TopCoverFinalStrength("Top Cover Final Strength", Range( 0 , 3)) = 1
		_TopCoverFinalContrast("Top Cover Final Contrast", Range( 0 , 3)) = 1
		_TerrainOverlayTriplanarContrast("Terrain Overlay Triplanar Contrast", Range( 1 , 50)) = 4
		_TerrainOverlayCoverMaskTolerance("Terrain Overlay Cover Mask Tolerance", Range( 0 , 0.5)) = 0.02
		_TerarinCoverColorLowThreshold("Terarin Cover Color Low Threshold", Range( 0 , 0.5)) = 0.02
		_TerrainOverlay1TextureScale("Terrain Overlay 1 Texture Scale", Range( 0 , 30)) = 1
		_TerrainOverlayNormalScale("Terrain Overlay Normal Scale", Range( 0.1 , 5)) = 1
		_TerrainOverlaySaturationMultiplier("Terrain Overlay Saturation Multiplier", Range( 0.1 , 2)) = 1
		_TerrainOverlayValueMultiplier("Terrain Overlay Value Multiplier", Range( 0.1 , 2)) = 1
		_TerrainOverlayContrast("Terrain Overlay Contrast", Range( 0.1 , 2)) = 1
		_TerrainOverlayAlbedoMatch("Terrain Overlay Albedo Match", Range( 0 , 0.5)) = 0.5
		_TerrainOverlay1CoverageBasis("Terrain Overlay 1 Coverage Basis", Vector) = (0,-0.5,0,0)
		_TerrainOverlay1PeakCoverageRange("Terrain Overlay 1 Peak Coverage Range", Vector) = (1,0.5,1,0)
		_TerrainOverlay1BaseCoverageRange("Terrain Overlay 1 Base Coverage Range", Vector) = (1,0.5,1,0)
		_TerrainOverlay1AreaNormalStrength("Terrain Overlay 1 Area Normal Strength", Range( 0 , 1)) = 1
		_TerrainOverlay1MinimumVerticalRange("Terrain Overlay 1 Minimum Vertical Range", Range( 0 , 100)) = 1
		_TerrainOverlay1TargetPercentage("Terrain Overlay 1 Target Percentage", Range( 0 , 1)) = 1
		_TerrainOverlay1MaximumVerticalRange("Terrain Overlay 1 Maximum Vertical Range", Range( 0 , 100)) = 1
		_TerrainOverlay1FadeSmoothness("Terrain Overlay 1 Fade Smoothness", Range( 0 , 1)) = 0.05
		_TerrainOverlay1FadePercentage("Terrain Overlay 1 Fade Percentage", Range( 0 , 1)) = 0.2
		_TerrainOverlay1FinalStrength("Terrain Overlay 1 Final Strength", Range( 0 , 3)) = 1
		_TerrainOverlay1FinalContrast("Terrain Overlay 1 Final Contrast", Range( 0 , 3)) = 1
		[NoScaleOffset]_DetailNormalArray("Detail Normal Array", 2D) = "bump" {}
		_InvertDetails("Invert Details", Range( 0 , 1)) = 0
		_DetailTiling("Detail Tiling", Range( 0.1 , 20)) = 1
		_DetailBaseColorStrength("Detail Base Color Strength", Range( 0 , 1)) = 0.25
		_DetailContrast("Detail Contrast", Range( 0.1 , 2)) = 1
		_DetailNormalScale("Detail Normal Scale", Range( 0.1 , 5)) = 1.15
		_DetailViewFadeStart("Detail View Fade Start", Range( 1 , 50)) = 3
		_DetailViewFadeDistance("Detail View Fade Distance", Range( 0 , 50)) = 5
		_WaterHeightOffset("Water Height Offset", Range( -5 , 10)) = 0.1
		_WaterDirectContactArea("Water Direct Contact Area", Range( 0 , 10)) = 1
		_WaterFadeRange("Water Fade Range", Range( 0 , 10)) = 1
		_WaterRangeScaleIncrease("Water Range Scale Increase", Range( 0.01 , 1)) = 1
		_RainYRangeLowHigh("Rain Y Range (Low High)", Vector) = (0,0,0,0)
		_WaterNeighborImpact("Water Neighbor Impact", Range( 0 , 2)) = 1
		_SurfacePorosity("Surface Porosity", Range( 0.01 , 1)) = 0.01
		_CoverSurfacePorosity("Cover Surface Porosity", Range( 0.01 , 1)) = 0.01
		_WaterDarkeningPower("Water Darkening Power", Range( 0.25 , 1)) = 1
		_CoverWaterDarknessModifier("Cover Water Darkness Modifier", Range( 0.2 , 2)) = 0.01
		_WaterSmoothnessPower("Water Smoothness Power", Range( 0.25 , 1)) = 1
		_CoverWaterSmoothnessMultiplier("Cover Water Smoothness Multiplier", Range( 0.2 , 2)) = 0.01
		_MeshAOContrast("Mesh AO Contrast", Range( 0 , 2)) = 1
		_MeshAODarknessBoost("MeshAO Darkness Boost", Range( 0 , 0.5)) = 0
		_OnlyBoostDarkMeshAO("Only Boost Dark Mesh AO", Range( 0 , 1)) = 0
		_MeshAOStrength("Mesh AO Strength", Range( 0 , 4)) = 1
		_TerrainOverlayNoiseScale("Terrain Overlay Noise Scale", Range( 0.001 , 100)) = 0
		_WetnessTerrainNoiseStrength("Wetness Terrain Noise Strength", Range( 0 , 2)) = 0
		_CoverFadeNoiseScale("Cover Fade Noise Scale", Range( 0.001 , 100)) = 0
		_CoverFadeNoiseStrength("Cover Fade Noise Strength", Range( 0 , 1)) = 1
		_TerrainMapOffset("Terrain Map Offset", Vector) = (2048,2048,0,0)
		_TerrainMapSize("Terrain Map Size", Vector) = (2048,2048,0,0)
		[NoScaleOffset]_TerrainSupplementalShadingMap("Terrain Supplemental Shading Map", 2D) = "white" {}
		[NoScaleOffset]_TerrainWetnessData("Terrain Wetness Data", 2D) = "white" {}
		_TerrainOverlayTextureSet1("Terrain Overlay Texture Set 1", Vector) = (4,4,4,4)
		_TerrainOverlayTextureSet2("Terrain Overlay Texture Set 2", Vector) = (4,5,6,7)
		_TerrainOverlayTextureSet3("Terrain Overlay Texture Set 3", Vector) = (7,9,10,11)
		_TerrainOverlayTextureSet4("Terrain Overlay Texture Set 4", Vector) = (12,13,4,-1)
		_LockBaseColorAndNormalIndices("Lock Base Color And Normal Indices", Range( 0 , 1)) = 0
		_UseMeshTextureIndices("Use Mesh Texture Indices", Range( 0 , 1)) = 0
		_TopCoverTextureIndices("Top Cover Texture Indices", Vector) = (0,0,0,0)
		_MiddleCoverTextureIndices("Middle Cover Texture Indices", Vector) = (0,0,0,0)
		_BottomCoverTextureIndices("Bottom Cover Texture Indices", Vector) = (0,0,0,0)
		_MainTextureIndices("Main Texture Indices", Vector) = (0,0,0,0)
		_EnableUVDebugging("Enable UV Debugging", Range( 0 , 1)) = 0
		_DebugUV8Overrides("Debug UV8 Overrides", Vector) = (0,0,0,0)
		_DebugWetness("Debug Wetness", Range( 0 , 1)) = 0
		_EnableUV1WWetness("Enable UV1 W Wetness", Range( 0 , 1)) = 0
		_DebugMode("Debug Mode", Range( 0 , 3)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		ZTest LEqual
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.5
		#pragma multi_compile_instancing
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)

		struct appdata_full_custom
		{
			float4 vertex : POSITION;
			float4 tangent : TANGENT;
			float3 normal : NORMAL;
			float4 texcoord : TEXCOORD0;
			float4 texcoord1 : TEXCOORD1;
			float4 texcoord2 : TEXCOORD2;
			float4 texcoord3 : TEXCOORD3;
			fixed4 color : COLOR;
			UNITY_VERTEX_INPUT_INSTANCE_ID
			float4 ase_texcoord4 : TEXCOORD4;
			float4 ase_texcoord5 : TEXCOORD5;
			float4 ase_texcoord6 : TEXCOORD6;
			float4 ase_texcoord7 : TEXCOORD7;
		};
		struct Input
		{
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldPos;
			float3 ase_texcoord5;
			float4 ase_texcoord7;
			float3 ase_texcoord4;
			float4 uv2_tex4coord2;
			float4 vertexColor : COLOR;
		};

		uniform float _NormalZReconstructionStyle;
		uniform float _FinalNormalScale;
		uniform float _MainNormalScale;
		uniform float _MainTriplanarContrast;
		uniform UNITY_DECLARE_TEX2DARRAY( _MainNormalArray );
		uniform float _MainTextureScale;
		uniform float _MainObjectScaleFactor;
		uniform float _LockBaseColorAndNormalIndices;
		uniform float _UseMeshTextureIndices;
		uniform float _UsePositionAsDeterminant;
		uniform float3 _DeterminantMultipliers;
		uniform float _EnableUVDebugging;
		uniform float4 _DebugUV8Overrides;
		uniform float _GLOBAL_SHADER_SET_INDICES[1000];
		uniform float2 _MainTextureIndices;
		uniform float2 _BottomCoverTextureIndices;
		uniform float _BottomCoverNormalScale;
		uniform float _BottomCoverTriplanarContrast;
		uniform UNITY_DECLARE_TEX2DARRAY( _CoverNormSAOArray );
		uniform float _CoverObjectScaleFactor;
		uniform float _BottomCoverTextureScale;
		uniform float _BottomCoverContrast;
		uniform UNITY_DECLARE_TEX2DARRAY( _CoverBaseColorArray );
		uniform float _BottomCoverSaturationMultiplier;
		uniform float _BottomCoverValueMultiplier;
		uniform float4 _MainTint;
		uniform float _MainContrast;
		uniform UNITY_DECLARE_TEX2DARRAY( _MainBaseColorArray );
		uniform float _MainSaturationMultiplier;
		uniform float _MainValueMultiplier;
		uniform float _BottomCoverAlbedoMatch;
		uniform float _BottomCoverColorLowThreshold;
		uniform float _BottomCoverMaskTolerance;
		uniform float _BottomCoverFinalContrast;
		uniform float _BottomCoverFinalStrength;
		uniform sampler2D _TerrainSupplementalShadingMap;
		uniform float2 _TerrainMapOffset;
		uniform float2 _TerrainMapSize;
		uniform float _BottomCoverTargetPercentage;
		uniform float _BottomCoverMinimumVerticalRange;
		uniform float _BottomCoverMaximumVerticalRange;
		uniform float _BottomCoverFadePercentage;
		uniform float3 _BottomCoverBaseCoverageRange;
		uniform float3 _BottomCoverPeakCoverageRange;
		uniform float _BottomCoverAreaNormalStrength;
		uniform float3 _BottomCoverCoverageBasis;
		uniform float _BottomCoverFadeSmoothness;
		uniform float _CoverFadeNoiseScale;
		uniform float _CoverFadeNoiseStrength;
		uniform float _MiddleCoverNormalScale;
		uniform float _MiddleCoverTriplanarContrast;
		uniform float _MiddleCoverTextureScale;
		uniform float2 _MiddleCoverTextureIndices;
		uniform float2 _TopCoverTextureIndices;
		uniform float _TopCoverNormalScale;
		uniform float _TopCoverTriplanarContrast;
		uniform float _TopCoverTextureScale;
		uniform float _TopCoverContrast;
		uniform float _TopCoverSaturationMultiplier;
		uniform float _TopCoverValueMultiplier;
		uniform float _TopCoverAlbedoMatch;
		uniform float _TopCoverColorLowThreshold;
		uniform float _CoverAlphaMaskContrast;
		uniform float _TopCoverMaskScale;
		uniform float _CoverAlphaMaskMultiplier;
		uniform float _TopCoverMaskTolerance;
		uniform float _TopCoverFinalContrast;
		uniform float _TopCoverFinalStrength;
		uniform float _TopCoverTargetPercentage;
		uniform float _TopCoverMinimumVerticalRange;
		uniform float _TopCoverMaximumVerticalRange;
		uniform float _TopCoverFadePercentage;
		uniform float3 _TopCoverBaseCoverageRange;
		uniform float3 _TopCoverPeakCoverageRange;
		uniform float _TopCoverAreaNormalStrength;
		uniform float3 _TopCoverCoverageBasis;
		uniform float _TopCoverFadeSmoothness;
		uniform float _TerrainOverlayNormalScale;
		uniform float _TerrainOverlayTriplanarContrast;
		uniform float _TerrainOverlay1TextureScale;
		uniform float _TerrainOverlayNoiseScale;
		uniform float4 _TerrainOverlayTextureSet1;
		uniform float4 _TerrainOverlayTextureSet2;
		uniform float4 _TerrainOverlayTextureSet3;
		uniform float4 _TerrainOverlayTextureSet4;
		uniform float _TerrainOverlayContrast;
		uniform float _TerrainOverlaySaturationMultiplier;
		uniform float _TerrainOverlayValueMultiplier;
		uniform float _TerrainOverlayAlbedoMatch;
		uniform float _TerarinCoverColorLowThreshold;
		uniform float _TerrainOverlayCoverMaskTolerance;
		uniform float _TerrainOverlay1FinalContrast;
		uniform float _TerrainOverlay1FinalStrength;
		uniform float _TerrainOverlay1TargetPercentage;
		uniform float _TerrainOverlay1MinimumVerticalRange;
		uniform float _TerrainOverlay1MaximumVerticalRange;
		uniform float _TerrainOverlay1FadePercentage;
		uniform float3 _TerrainOverlay1BaseCoverageRange;
		uniform float3 _TerrainOverlay1PeakCoverageRange;
		uniform float _TerrainOverlay1AreaNormalStrength;
		uniform float3 _TerrainOverlay1CoverageBasis;
		uniform float _TerrainOverlay1FadeSmoothness;
		uniform float _DetailNormalScale;
		uniform sampler2D _DetailNormalArray;
		uniform float _DetailTiling;
		uniform float _FinalDetailMultiplier;
		uniform float _DetailViewFadeStart;
		uniform float _DetailViewFadeDistance;
		uniform float _FinalColorContrast;
		uniform float _MiddleCoverContrast;
		uniform float _MiddleCoverSaturationMultiplier;
		uniform float _MiddleCoverValueMultiplier;
		uniform float _MiddleCoverAlbedoMatch;
		uniform float _FinalAlbedoMatch;
		uniform float _InvertDetails;
		uniform float _DetailContrast;
		uniform float _DetailBaseColorStrength;
		uniform float _FinalSaturationMultiplier;
		uniform float _FinalValueMultiplier;
		uniform float _WaterDarkeningPower;
		uniform float _CoverWaterDarknessModifier;
		uniform float _SurfacePorosity;
		uniform float _CoverSurfacePorosity;
		uniform sampler2D _TerrainWetnessData;
		uniform float _WetnessTerrainNoiseStrength;
		uniform float _WaterHeightOffset;
		uniform float _WaterDirectContactArea;
		uniform float _WaterFadeRange;
		uniform float _WaterRangeScaleIncrease;
		uniform float _WaterNeighborImpact;
		uniform half2 _Global_PuddleParams;
		uniform float _DebugWetness;
		uniform float _EnableUV1WWetness;
		uniform half2 _Global_WetnessParams;
		uniform float2 _RainYRangeLowHigh;
		uniform float _DebugMode;
		uniform float _WaterSmoothnessPower;
		uniform float _CoverWaterSmoothnessMultiplier;
		uniform float _MainAOTextureStrength;
		uniform float _CoverAOTextureStrength;
		uniform float _TerrainAOTextureStrength;
		uniform float _MeshAOStrength;
		uniform float _MeshAOContrast;
		uniform float _MeshAODarknessBoost;
		uniform float _OnlyBoostDarkMeshAO;
		uniform float _FinalAOMultiplier;


		float3 HSVToRGB( float3 c )
		{
			float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
			float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
			return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
		}


		float3 RGBToHSV(float3 c)
		{
			float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
			float4 p = lerp( float4( c.bg, K.wz ), float4( c.gb, K.xy ), step( c.b, c.g ) );
			float4 q = lerp( float4( p.xyw, c.r ), float4( c.r, p.yzx ), step( p.x, c.r ) );
			float d = q.x - min( q.w, q.y );
			float e = 1.0e-10;
			return float3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
		}

		float4 CalculateContrast( float contrastValue, float4 colorTarget )
		{
			float t = 0.5 * ( 1.0 - contrastValue );
			return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
		}

		float3 mod3D289( float3 x ) { return x - floor( x / 289.0 ) * 289.0; }

		float4 mod3D289( float4 x ) { return x - floor( x / 289.0 ) * 289.0; }

		float4 permute( float4 x ) { return mod3D289( ( x * 34.0 + 1.0 ) * x ); }

		float4 taylorInvSqrt( float4 r ) { return 1.79284291400159 - r * 0.85373472095314; }

		float snoise( float3 v )
		{
			const float2 C = float2( 1.0 / 6.0, 1.0 / 3.0 );
			float3 i = floor( v + dot( v, C.yyy ) );
			float3 x0 = v - i + dot( i, C.xxx );
			float3 g = step( x0.yzx, x0.xyz );
			float3 l = 1.0 - g;
			float3 i1 = min( g.xyz, l.zxy );
			float3 i2 = max( g.xyz, l.zxy );
			float3 x1 = x0 - i1 + C.xxx;
			float3 x2 = x0 - i2 + C.yyy;
			float3 x3 = x0 - 0.5;
			i = mod3D289( i);
			float4 p = permute( permute( permute( i.z + float4( 0.0, i1.z, i2.z, 1.0 ) ) + i.y + float4( 0.0, i1.y, i2.y, 1.0 ) ) + i.x + float4( 0.0, i1.x, i2.x, 1.0 ) );
			float4 j = p - 49.0 * floor( p / 49.0 );  // mod(p,7*7)
			float4 x_ = floor( j / 7.0 );
			float4 y_ = floor( j - 7.0 * x_ );  // mod(j,N)
			float4 x = ( x_ * 2.0 + 0.5 ) / 7.0 - 1.0;
			float4 y = ( y_ * 2.0 + 0.5 ) / 7.0 - 1.0;
			float4 h = 1.0 - abs( x ) - abs( y );
			float4 b0 = float4( x.xy, y.xy );
			float4 b1 = float4( x.zw, y.zw );
			float4 s0 = floor( b0 ) * 2.0 + 1.0;
			float4 s1 = floor( b1 ) * 2.0 + 1.0;
			float4 sh = -step( h, 0.0 );
			float4 a0 = b0.xzyw + s0.xzyw * sh.xxyy;
			float4 a1 = b1.xzyw + s1.xzyw * sh.zzww;
			float3 g0 = float3( a0.xy, h.x );
			float3 g1 = float3( a0.zw, h.y );
			float3 g2 = float3( a1.xy, h.z );
			float3 g3 = float3( a1.zw, h.w );
			float4 norm = taylorInvSqrt( float4( dot( g0, g0 ), dot( g1, g1 ), dot( g2, g2 ), dot( g3, g3 ) ) );
			g0 *= norm.x;
			g1 *= norm.y;
			g2 *= norm.z;
			g3 *= norm.w;
			float4 m = max( 0.6 - float4( dot( x0, x0 ), dot( x1, x1 ), dot( x2, x2 ), dot( x3, x3 ) ), 0.0 );
			m = m* m;
			m = m* m;
			float4 px = float4( dot( x0, g0 ), dot( x1, g1 ), dot( x2, g2 ), dot( x3, g3 ) );
			return 42.0 * dot( m, px);
		}


		void vertexDataFunc( inout appdata_full_custom v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.ase_texcoord5 = v.ase_texcoord5;
			o.ase_texcoord7 = v.ase_texcoord7;
			o.ase_texcoord4 = v.ase_texcoord4;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float normalZReconstructionStyle2681 = _NormalZReconstructionStyle;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float mainTriplanarBlendSharpness2537 = _MainTriplanarContrast;
			float3 temp_cast_0 = (mainTriplanarBlendSharpness2537).xxx;
			float3 temp_output_42_0_g20932 = pow( abs( ase_worldNormal ) , temp_cast_0 );
			float3 break2_g20941 = temp_output_42_0_g20932;
			float3 temp_output_836_0_g20912 = ( temp_output_42_0_g20932 / ( break2_g20941.x + break2_g20941.y + break2_g20941.z ) );
			float3 break141_g20915 = temp_output_836_0_g20912;
			float3 break127_g20915 = abs( ase_worldNormal );
			float3 appendResult123_g20915 = (float3(ase_worldNormal.z , ase_worldNormal.y , break127_g20915.x));
			float3 temp_output_4_0_g20927 = ( appendResult123_g20915 + float3( 0,0,1 ) );
			float3 break6_g20940 = sign( ase_worldNormal );
			float3 appendResult7_g20940 = (float3((( break6_g20940.x < 0.0 ) ? -1.0 :  1.0 ) , (( break6_g20940.y < 0.0 ) ? -1.0 :  1.0 ) , (( break6_g20940.z < 0.0 ) ? -1.0 :  1.0 )));
			float3 temp_output_57_0_g20932 = appendResult7_g20940;
			float3 appendResult53_g20932 = (float3((temp_output_57_0_g20932).xy , ( (temp_output_57_0_g20932).z * -1.0 )));
			float3 axisSigns54_g20932 = appendResult53_g20932;
			float3 temp_output_99_0_g20915 = axisSigns54_g20932;
			float3 break113_g20915 = temp_output_99_0_g20915;
			float2 appendResult116_g20915 = (float2(break113_g20915.x , 1.0));
			float temp_output_74_0_g20932 = 1.0;
			float3 ase_worldPos = i.worldPos;
			float2 temp_output_1_0_g20933 = (ase_worldPos).zy;
			float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
			float3 bounds2557 = i.ase_texcoord5;
			float3 break1312 = ( ase_objectScale * bounds2557 );
			float scaleMultiplier1313 = max( 1.0 , max( max( break1312.x , break1312.y ) , break1312.z ) );
			float mainObjectScale1273 = max( _MainTextureScale , ( _MainTextureScale + ( _MainObjectScaleFactor * scaleMultiplier1313 ) ) );
			float2 temp_output_31_0_g20932 = (mainObjectScale1273).xx;
			float2 temp_output_2_0_g20933 = temp_output_31_0_g20932;
			float2 temp_output_30_0_g20932 = float2( 0,0 );
			float3 break89_g20932 = axisSigns54_g20932;
			float2 appendResult6_g20937 = (float2(break89_g20932.x , 1.0));
			float2 temp_output_84_0_g20932 = ( ( (( temp_output_74_0_g20932 > 0.0 ) ? ( temp_output_1_0_g20933 / temp_output_2_0_g20933 ) :  ( temp_output_1_0_g20933 * temp_output_2_0_g20933 ) ) + temp_output_30_0_g20932 ) * appendResult6_g20937 );
			float2 temp_output_833_0_g20912 = temp_output_84_0_g20932;
			float lockIndices2132 = _LockBaseColorAndNormalIndices;
			float positionAsDeterminant712 = _UsePositionAsDeterminant;
			float temp_output_142_0_g20898 = positionAsDeterminant712;
			float temp_output_151_0_g20898 = (( temp_output_142_0_g20898 > 0.5 ) ? 100.0 :  1000.0 );
			half localunity_ObjectToWorld0w1_g20899 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g20899 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g20899 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g20899 = (float3(localunity_ObjectToWorld0w1_g20899 , localunity_ObjectToWorld1w2_g20899 , localunity_ObjectToWorld2w3_g20899));
			float3 determinantOffset715 = float3(0,0,0);
			float3 break144_g20898 = ( (( temp_output_142_0_g20898 > 0.5 ) ? appendResult6_g20899 :  ase_objectScale ) + determinantOffset715 );
			float3 determinantMultipliers714 = _DeterminantMultipliers;
			float3 break103_g20898 = determinantMultipliers714;
			float temp_output_222_0_g20898 = round( ( round( ( ( temp_output_151_0_g20898 * break144_g20898.x ) * break103_g20898.x ) ) + round( ( ( temp_output_151_0_g20898 * break144_g20898.y ) * break103_g20898.y ) ) + round( ( ( temp_output_151_0_g20898 * break144_g20898.z ) * break103_g20898.z ) ) ) );
			float debugUVOverrides713 = _EnableUVDebugging;
			float temp_output_175_0_g20898 = ( _GLOBAL_SHADER_SET_INDICES[(int)0.0] - 1.0 );
			float4 appendResult113_g20898 = (float4(temp_output_175_0_g20898 , temp_output_175_0_g20898 , temp_output_175_0_g20898 , temp_output_175_0_g20898));
			float4 clampResult174_g20898 = clamp( (( debugUVOverrides713 > 0.5 ) ? _DebugUV8Overrides :  round( i.ase_texcoord7 ) ) , float4( 0,0,0,0 ) , appendResult113_g20898 );
			float4 texCoords242_g20898 = ( float4( 1,1,1,1 ) + ( clampResult174_g20898 * float4( 2,2,2,2 ) ) );
			float4 break195_g20898 = ( texCoords242_g20898 + float4( 1,1,1,1 ) );
			float4 break32_g20898 = texCoords242_g20898;
			float clampResult197_g20898 = clamp( ( round( fmod( temp_output_222_0_g20898 , _GLOBAL_SHADER_SET_INDICES[(int)break195_g20898.x] ) ) + _GLOBAL_SHADER_SET_INDICES[(int)break32_g20898.x] ) , _GLOBAL_SHADER_SET_INDICES[(int)break32_g20898.x] , ( _GLOBAL_SHADER_SET_INDICES[(int)break32_g20898.x] + -1.0 + _GLOBAL_SHADER_SET_INDICES[(int)break195_g20898.x] ) );
			float2 appendResult104_g20898 = (float2(_GLOBAL_SHADER_SET_INDICES[(int)clampResult197_g20898] , _GLOBAL_SHADER_SET_INDICES[(int)( clampResult197_g20898 + 1.0 )]));
			float clampResult199_g20898 = clamp( ( round( fmod( temp_output_222_0_g20898 , _GLOBAL_SHADER_SET_INDICES[(int)break195_g20898.y] ) ) + _GLOBAL_SHADER_SET_INDICES[(int)break32_g20898.y] ) , _GLOBAL_SHADER_SET_INDICES[(int)break32_g20898.y] , ( _GLOBAL_SHADER_SET_INDICES[(int)break32_g20898.y] + -1.0 + _GLOBAL_SHADER_SET_INDICES[(int)break195_g20898.y] ) );
			float2 appendResult105_g20898 = (float2(_GLOBAL_SHADER_SET_INDICES[(int)clampResult199_g20898] , _GLOBAL_SHADER_SET_INDICES[(int)( clampResult199_g20898 + 1.0 )]));
			float4 appendResult731 = (float4(round( appendResult104_g20898 ) , round( appendResult105_g20898 )));
			float4 appendResult738 = (float4(_MainTextureIndices.x , (( lockIndices2132 > 0.5 ) ? _MainTextureIndices.x :  _MainTextureIndices.y ) , _BottomCoverTextureIndices.x , (( lockIndices2132 > 0.5 ) ? _BottomCoverTextureIndices.x :  _BottomCoverTextureIndices.y )));
			float4 break745 = (( _UseMeshTextureIndices > 0.5 ) ? appendResult731 :  appendResult738 );
			float mainNormalIndex751 = (( lockIndices2132 > 0.5 ) ? break745.x :  break745.y );
			float temp_output_895_0_g20912 = mainNormalIndex751;
			float4 texArray891_g20912 = UNITY_SAMPLE_TEX2DARRAY(_MainNormalArray, float3(temp_output_833_0_g20912, temp_output_895_0_g20912)  );
			float4 unpaciked14_g20913 = (texArray891_g20912).garb;
			float2 temp_cast_10 = (1.0).xx;
			float3 appendResult117_g20915 = (float3(( appendResult116_g20915 * ( ( (unpaciked14_g20913).xy * 2.0 ) - temp_cast_10 ) ) , 1.0));
			float3 temp_output_7_0_g20927 = ( appendResult117_g20915 * float3( -1,0,0 ) );
			float dotResult9_g20927 = dot( temp_output_4_0_g20927 , temp_output_7_0_g20927 );
			float3 axisSigns133_g20915 = temp_output_99_0_g20915;
			float3 break135_g20915 = axisSigns133_g20915;
			float3 appendResult6_g20916 = (float3(1.0 , 1.0 , break135_g20915.x));
			float3 appendResult128_g20915 = (float3(ase_worldNormal.x , ase_worldNormal.z , break127_g20915.y));
			float3 temp_output_4_0_g20920 = ( appendResult128_g20915 + float3( 0,0,1 ) );
			float2 appendResult115_g20915 = (float2(break113_g20915.y , 1.0));
			float2 temp_output_1_0_g20936 = (ase_worldPos).xz;
			float2 temp_output_2_0_g20936 = temp_output_31_0_g20932;
			float2 _Vector0 = float2(0.33,0.33);
			float2 appendResult6_g20934 = (float2(break89_g20932.y , 1.0));
			float2 temp_output_87_0_g20932 = ( ( (( temp_output_74_0_g20932 > 0.0 ) ? ( temp_output_1_0_g20936 / temp_output_2_0_g20936 ) :  ( temp_output_1_0_g20936 * temp_output_2_0_g20936 ) ) + ( temp_output_30_0_g20932 + ( 0.0 * _Vector0 ) ) ) * appendResult6_g20934 );
			float2 temp_output_834_0_g20912 = temp_output_87_0_g20932;
			float4 texArray890_g20912 = UNITY_SAMPLE_TEX2DARRAY(_MainNormalArray, float3(temp_output_834_0_g20912, temp_output_895_0_g20912)  );
			float4 unpaciked14_g20930 = (texArray890_g20912).garb;
			float2 temp_cast_11 = (1.0).xx;
			float3 appendResult120_g20915 = (float3(( appendResult115_g20915 * ( ( (unpaciked14_g20930).xy * 2.0 ) - temp_cast_11 ) ) , 1.0));
			float3 temp_output_7_0_g20920 = ( appendResult120_g20915 * float3( -1,0,0 ) );
			float dotResult9_g20920 = dot( temp_output_4_0_g20920 , temp_output_7_0_g20920 );
			float3 appendResult6_g20918 = (float3(1.0 , 1.0 , break135_g20915.y));
			float3 appendResult129_g20915 = (float3(ase_worldNormal.x , ase_worldNormal.y , break127_g20915.z));
			float3 temp_output_4_0_g20922 = ( appendResult129_g20915 + float3( 0,0,1 ) );
			float2 appendResult114_g20915 = (float2(break113_g20915.z , 1.0));
			float2 temp_output_1_0_g20942 = (ase_worldPos).xy;
			float2 temp_output_2_0_g20942 = temp_output_31_0_g20932;
			float2 appendResult6_g20938 = (float2(break89_g20932.z , 1.0));
			float2 temp_output_88_0_g20932 = ( ( (( temp_output_74_0_g20932 > 0.0 ) ? ( temp_output_1_0_g20942 / temp_output_2_0_g20942 ) :  ( temp_output_1_0_g20942 * temp_output_2_0_g20942 ) ) + ( temp_output_30_0_g20932 + ( 0.0 * _Vector0 * 2.0 ) ) ) * appendResult6_g20938 );
			float2 temp_output_832_0_g20912 = temp_output_88_0_g20932;
			float4 texArray889_g20912 = UNITY_SAMPLE_TEX2DARRAY(_MainNormalArray, float3(temp_output_832_0_g20912, temp_output_895_0_g20912)  );
			float4 unpaciked14_g20914 = (texArray889_g20912).garb;
			float2 temp_cast_12 = (1.0).xx;
			float3 appendResult121_g20915 = (float3(( appendResult114_g20915 * ( ( (unpaciked14_g20914).xy * 2.0 ) - temp_cast_12 ) ) , 1.0));
			float3 temp_output_7_0_g20922 = ( appendResult121_g20915 * float3( -1,0,0 ) );
			float dotResult9_g20922 = dot( temp_output_4_0_g20922 , temp_output_7_0_g20922 );
			float3 appendResult6_g20917 = (float3(1.0 , 1.0 , ( break135_g20915.z * -1.0 )));
			float2 temp_output_2_0_g20929 = mul( float3x3((WorldNormalVector( i , float3(1,0,0) )), (WorldNormalVector( i , float3(0,1,0) )), (WorldNormalVector( i , float3(0,0,1) ))), ( ( break141_g20915.x * (( ( ( ( temp_output_4_0_g20927 * dotResult9_g20927 ) / (temp_output_4_0_g20927).z ) - temp_output_7_0_g20927 ) * appendResult6_g20916 )).zyx ) + ( break141_g20915.y * (( ( ( ( temp_output_4_0_g20920 * dotResult9_g20920 ) / (temp_output_4_0_g20920).z ) - temp_output_7_0_g20920 ) * appendResult6_g20918 )).xzy ) + ( break141_g20915.z * (( ( ( ( temp_output_4_0_g20922 * dotResult9_g20922 ) / (temp_output_4_0_g20922).z ) - temp_output_7_0_g20922 ) * appendResult6_g20917 )).xyz ) ) ).xy;
			float dotResult42_g20929 = dot( temp_output_2_0_g20929 , temp_output_2_0_g20929 );
			float3 appendResult38_g20929 = (float3(temp_output_2_0_g20929 , sqrt( ( 1.0 - saturate( dotResult42_g20929 ) ) )));
			float3 normalizeResult39_g20929 = normalize( appendResult38_g20929 );
			float3 temp_output_2_0_g22030 = normalizeResult39_g20929;
			float3 temp_output_36_0_g22030 = ( _MainNormalScale * temp_output_2_0_g22030 );
			float3 appendResult38_g22030 = (float3(temp_output_36_0_g22030.xy , (temp_output_2_0_g22030).z));
			float2 temp_output_2_0_g22032 = temp_output_36_0_g22030.xy;
			float dotResult42_g22032 = dot( temp_output_2_0_g22032 , temp_output_2_0_g22032 );
			float3 appendResult38_g22032 = (float3(temp_output_2_0_g22032 , sqrt( ( 1.0 - saturate( dotResult42_g22032 ) ) )));
			float3 normalizeResult39_g22032 = normalize( appendResult38_g22032 );
			float2 break30_g22031 = temp_output_36_0_g22030.xy;
			float3 appendResult38_g22031 = (float3(break30_g22031.x , break30_g22031.y , sqrt( ( 1.0 - ( ( break30_g22031.x * break30_g22031.x ) + ( break30_g22031.y * break30_g22031.y ) ) ) )));
			float3 normalizeResult39_g22031 = normalize( appendResult38_g22031 );
			float3 temp_output_2679_0 = (( normalZReconstructionStyle2681 < 1.0 ) ? appendResult38_g22030 :  (( 2.0 > 0.0 ) ? normalizeResult39_g22032 :  normalizeResult39_g22031 ) );
			float3 normalizeResult2112 = normalize( temp_output_2679_0 );
			float3 mainNormal786 = normalizeResult2112;
			float BottomCoverTriplanarContrast2716 = _BottomCoverTriplanarContrast;
			float3 temp_cast_17 = (BottomCoverTriplanarContrast2716).xxx;
			float3 temp_output_42_0_g22198 = pow( abs( ase_worldNormal ) , temp_cast_17 );
			float3 break2_g22207 = temp_output_42_0_g22198;
			float3 temp_output_836_0_g22178 = ( temp_output_42_0_g22198 / ( break2_g22207.x + break2_g22207.y + break2_g22207.z ) );
			float3 break141_g22181 = temp_output_836_0_g22178;
			float3 break127_g22181 = abs( ase_worldNormal );
			float3 appendResult123_g22181 = (float3(ase_worldNormal.z , ase_worldNormal.y , break127_g22181.x));
			float3 temp_output_4_0_g22193 = ( appendResult123_g22181 + float3( 0,0,1 ) );
			float3 break6_g22206 = sign( ase_worldNormal );
			float3 appendResult7_g22206 = (float3((( break6_g22206.x < 0.0 ) ? -1.0 :  1.0 ) , (( break6_g22206.y < 0.0 ) ? -1.0 :  1.0 ) , (( break6_g22206.z < 0.0 ) ? -1.0 :  1.0 )));
			float3 temp_output_57_0_g22198 = appendResult7_g22206;
			float3 appendResult53_g22198 = (float3((temp_output_57_0_g22198).xy , ( (temp_output_57_0_g22198).z * -1.0 )));
			float3 axisSigns54_g22198 = appendResult53_g22198;
			float3 temp_output_99_0_g22181 = axisSigns54_g22198;
			float3 break113_g22181 = temp_output_99_0_g22181;
			float2 appendResult116_g22181 = (float2(break113_g22181.x , 1.0));
			float temp_output_74_0_g22198 = 1.0;
			float2 temp_output_1_0_g22199 = (ase_worldPos).zy;
			float temp_output_1322_0 = ( _CoverObjectScaleFactor * scaleMultiplier1313 );
			float coverObjectScale1274 = max( ( temp_output_1322_0 + temp_output_1322_0 ) , 1.0 );
			float bottomCoverScale1275 = ( coverObjectScale1274 + _BottomCoverTextureScale );
			float2 temp_output_31_0_g22198 = (bottomCoverScale1275).xx;
			float2 temp_output_2_0_g22199 = temp_output_31_0_g22198;
			float2 temp_output_30_0_g22198 = float2( 0,0 );
			float3 break89_g22198 = axisSigns54_g22198;
			float2 appendResult6_g22203 = (float2(break89_g22198.x , 1.0));
			float2 temp_output_84_0_g22198 = ( ( (( temp_output_74_0_g22198 > 0.0 ) ? ( temp_output_1_0_g22199 / temp_output_2_0_g22199 ) :  ( temp_output_1_0_g22199 * temp_output_2_0_g22199 ) ) + temp_output_30_0_g22198 ) * appendResult6_g22203 );
			float2 temp_output_833_0_g22178 = temp_output_84_0_g22198;
			float bottomCoverNormalIndex741 = (( lockIndices2132 > 0.5 ) ? break745.z :  break745.w );
			float temp_output_895_0_g22178 = bottomCoverNormalIndex741;
			float4 texArray891_g22178 = UNITY_SAMPLE_TEX2DARRAY(_CoverNormSAOArray, float3(temp_output_833_0_g22178, temp_output_895_0_g22178)  );
			float4 unpaciked14_g22179 = (texArray891_g22178).garb;
			float2 temp_cast_18 = (1.0).xx;
			float3 appendResult117_g22181 = (float3(( appendResult116_g22181 * ( ( (unpaciked14_g22179).xy * 2.0 ) - temp_cast_18 ) ) , 1.0));
			float3 temp_output_7_0_g22193 = ( appendResult117_g22181 * float3( -1,0,0 ) );
			float dotResult9_g22193 = dot( temp_output_4_0_g22193 , temp_output_7_0_g22193 );
			float3 axisSigns133_g22181 = temp_output_99_0_g22181;
			float3 break135_g22181 = axisSigns133_g22181;
			float3 appendResult6_g22182 = (float3(1.0 , 1.0 , break135_g22181.x));
			float3 appendResult128_g22181 = (float3(ase_worldNormal.x , ase_worldNormal.z , break127_g22181.y));
			float3 temp_output_4_0_g22186 = ( appendResult128_g22181 + float3( 0,0,1 ) );
			float2 appendResult115_g22181 = (float2(break113_g22181.y , 1.0));
			float2 temp_output_1_0_g22202 = (ase_worldPos).xz;
			float2 temp_output_2_0_g22202 = temp_output_31_0_g22198;
			float2 appendResult6_g22200 = (float2(break89_g22198.y , 1.0));
			float2 temp_output_87_0_g22198 = ( ( (( temp_output_74_0_g22198 > 0.0 ) ? ( temp_output_1_0_g22202 / temp_output_2_0_g22202 ) :  ( temp_output_1_0_g22202 * temp_output_2_0_g22202 ) ) + ( temp_output_30_0_g22198 + ( 0.0 * _Vector0 ) ) ) * appendResult6_g22200 );
			float2 temp_output_834_0_g22178 = temp_output_87_0_g22198;
			float4 texArray890_g22178 = UNITY_SAMPLE_TEX2DARRAY(_CoverNormSAOArray, float3(temp_output_834_0_g22178, temp_output_895_0_g22178)  );
			float4 unpaciked14_g22196 = (texArray890_g22178).garb;
			float2 temp_cast_19 = (1.0).xx;
			float3 appendResult120_g22181 = (float3(( appendResult115_g22181 * ( ( (unpaciked14_g22196).xy * 2.0 ) - temp_cast_19 ) ) , 1.0));
			float3 temp_output_7_0_g22186 = ( appendResult120_g22181 * float3( -1,0,0 ) );
			float dotResult9_g22186 = dot( temp_output_4_0_g22186 , temp_output_7_0_g22186 );
			float3 appendResult6_g22184 = (float3(1.0 , 1.0 , break135_g22181.y));
			float3 appendResult129_g22181 = (float3(ase_worldNormal.x , ase_worldNormal.y , break127_g22181.z));
			float3 temp_output_4_0_g22188 = ( appendResult129_g22181 + float3( 0,0,1 ) );
			float2 appendResult114_g22181 = (float2(break113_g22181.z , 1.0));
			float2 temp_output_1_0_g22208 = (ase_worldPos).xy;
			float2 temp_output_2_0_g22208 = temp_output_31_0_g22198;
			float2 appendResult6_g22204 = (float2(break89_g22198.z , 1.0));
			float2 temp_output_88_0_g22198 = ( ( (( temp_output_74_0_g22198 > 0.0 ) ? ( temp_output_1_0_g22208 / temp_output_2_0_g22208 ) :  ( temp_output_1_0_g22208 * temp_output_2_0_g22208 ) ) + ( temp_output_30_0_g22198 + ( 0.0 * _Vector0 * 2.0 ) ) ) * appendResult6_g22204 );
			float2 temp_output_832_0_g22178 = temp_output_88_0_g22198;
			float4 texArray889_g22178 = UNITY_SAMPLE_TEX2DARRAY(_CoverNormSAOArray, float3(temp_output_832_0_g22178, temp_output_895_0_g22178)  );
			float4 unpaciked14_g22180 = (texArray889_g22178).garb;
			float2 temp_cast_20 = (1.0).xx;
			float3 appendResult121_g22181 = (float3(( appendResult114_g22181 * ( ( (unpaciked14_g22180).xy * 2.0 ) - temp_cast_20 ) ) , 1.0));
			float3 temp_output_7_0_g22188 = ( appendResult121_g22181 * float3( -1,0,0 ) );
			float dotResult9_g22188 = dot( temp_output_4_0_g22188 , temp_output_7_0_g22188 );
			float3 appendResult6_g22183 = (float3(1.0 , 1.0 , ( break135_g22181.z * -1.0 )));
			float2 temp_output_2_0_g22195 = mul( float3x3((WorldNormalVector( i , float3(1,0,0) )), (WorldNormalVector( i , float3(0,1,0) )), (WorldNormalVector( i , float3(0,0,1) ))), ( ( break141_g22181.x * (( ( ( ( temp_output_4_0_g22193 * dotResult9_g22193 ) / (temp_output_4_0_g22193).z ) - temp_output_7_0_g22193 ) * appendResult6_g22182 )).zyx ) + ( break141_g22181.y * (( ( ( ( temp_output_4_0_g22186 * dotResult9_g22186 ) / (temp_output_4_0_g22186).z ) - temp_output_7_0_g22186 ) * appendResult6_g22184 )).xzy ) + ( break141_g22181.z * (( ( ( ( temp_output_4_0_g22188 * dotResult9_g22188 ) / (temp_output_4_0_g22188).z ) - temp_output_7_0_g22188 ) * appendResult6_g22183 )).xyz ) ) ).xy;
			float dotResult42_g22195 = dot( temp_output_2_0_g22195 , temp_output_2_0_g22195 );
			float3 appendResult38_g22195 = (float3(temp_output_2_0_g22195 , sqrt( ( 1.0 - saturate( dotResult42_g22195 ) ) )));
			float3 normalizeResult39_g22195 = normalize( appendResult38_g22195 );
			float3 temp_output_2_0_g22378 = normalizeResult39_g22195;
			float3 temp_output_36_0_g22378 = ( _BottomCoverNormalScale * temp_output_2_0_g22378 );
			float3 appendResult38_g22378 = (float3(temp_output_36_0_g22378.xy , (temp_output_2_0_g22378).z));
			float2 temp_output_2_0_g22380 = temp_output_36_0_g22378.xy;
			float dotResult42_g22380 = dot( temp_output_2_0_g22380 , temp_output_2_0_g22380 );
			float3 appendResult38_g22380 = (float3(temp_output_2_0_g22380 , sqrt( ( 1.0 - saturate( dotResult42_g22380 ) ) )));
			float3 normalizeResult39_g22380 = normalize( appendResult38_g22380 );
			float2 break30_g22379 = temp_output_36_0_g22378.xy;
			float3 appendResult38_g22379 = (float3(break30_g22379.x , break30_g22379.y , sqrt( ( 1.0 - ( ( break30_g22379.x * break30_g22379.x ) + ( break30_g22379.y * break30_g22379.y ) ) ) )));
			float3 normalizeResult39_g22379 = normalize( appendResult38_g22379 );
			float3 bottomCoverNormal2163 = (( normalZReconstructionStyle2681 < 1.0 ) ? appendResult38_g22378 :  (( 2.0 > 0.0 ) ? normalizeResult39_g22380 :  normalizeResult39_g22379 ) );
			float bottomCoverBaseColorIndex740 = break745.z;
			float temp_output_896_0_g22178 = bottomCoverBaseColorIndex740;
			float4 texArray894_g22178 = UNITY_SAMPLE_TEX2DARRAY(_CoverBaseColorArray, float3(temp_output_833_0_g22178, temp_output_896_0_g22178)  );
			float4 texArray893_g22178 = UNITY_SAMPLE_TEX2DARRAY(_CoverBaseColorArray, float3(temp_output_834_0_g22178, temp_output_896_0_g22178)  );
			float4 texArray892_g22178 = UNITY_SAMPLE_TEX2DARRAY(_CoverBaseColorArray, float3(temp_output_832_0_g22178, temp_output_896_0_g22178)  );
			float3 weightedBlendVar840_g22178 = temp_output_836_0_g22178;
			float4 weightedAvg840_g22178 = ( ( weightedBlendVar840_g22178.x*texArray894_g22178 + weightedBlendVar840_g22178.y*texArray893_g22178 + weightedBlendVar840_g22178.z*texArray892_g22178 )/( weightedBlendVar840_g22178.x + weightedBlendVar840_g22178.y + weightedBlendVar840_g22178.z ) );
			float4 temp_output_2668_899 = weightedAvg840_g22178;
			float3 hsvTorgb427_g22209 = RGBToHSV( temp_output_2668_899.rgb );
			float3 hsvTorgb428_g22209 = HSVToRGB( float3(( 0.0 + hsvTorgb427_g22209.x ),( _BottomCoverSaturationMultiplier * hsvTorgb427_g22209.y ),( _BottomCoverValueMultiplier * hsvTorgb427_g22209.z )) );
			float mainBaseColorIndex750 = break745.x;
			float temp_output_896_0_g20912 = mainBaseColorIndex750;
			float4 texArray894_g20912 = UNITY_SAMPLE_TEX2DARRAY(_MainBaseColorArray, float3(temp_output_833_0_g20912, temp_output_896_0_g20912)  );
			float4 texArray893_g20912 = UNITY_SAMPLE_TEX2DARRAY(_MainBaseColorArray, float3(temp_output_834_0_g20912, temp_output_896_0_g20912)  );
			float4 texArray892_g20912 = UNITY_SAMPLE_TEX2DARRAY(_MainBaseColorArray, float3(temp_output_832_0_g20912, temp_output_896_0_g20912)  );
			float3 weightedBlendVar840_g20912 = temp_output_836_0_g20912;
			float4 weightedAvg840_g20912 = ( ( weightedBlendVar840_g20912.x*texArray894_g20912 + weightedBlendVar840_g20912.y*texArray893_g20912 + weightedBlendVar840_g20912.z*texArray892_g20912 )/( weightedBlendVar840_g20912.x + weightedBlendVar840_g20912.y + weightedBlendVar840_g20912.z ) );
			float3 hsvTorgb427_g22029 = RGBToHSV( weightedAvg840_g20912.rgb );
			float3 hsvTorgb428_g22029 = HSVToRGB( float3(( 0.0 + hsvTorgb427_g22029.x ),( _MainSaturationMultiplier * hsvTorgb427_g22029.y ),( _MainValueMultiplier * hsvTorgb427_g22029.z )) );
			float4 mainBaseColor789 = ( _MainTint * CalculateContrast(_MainContrast,float4( hsvTorgb428_g22029 , 0.0 )) );
			float4 lerpResult2995 = lerp( CalculateContrast(_BottomCoverContrast,float4( hsvTorgb428_g22209 , 0.0 )) , mainBaseColor789 , _BottomCoverAlbedoMatch);
			float4 bottomCoverBaseColor2160 = lerpResult2995;
			float3 break2_g22316 = bottomCoverBaseColor2160.rgb;
			float bottomCoverColorSum2459 = ( break2_g22316.x + break2_g22316.y + break2_g22316.z );
			float BottomCoverColorLowThreshold2720 = _BottomCoverColorLowThreshold;
			float bottomCoverAlphaMask2307 = (temp_output_2668_899).a;
			float BottomCoverMaskTolerance2718 = _BottomCoverMaskTolerance;
			float boundsYObjectSpace270_g22264 = ( ase_objectScale.y * i.ase_texcoord5.y );
			float4 tex2DNode8_g20908 = tex2D( _TerrainSupplementalShadingMap, ( ( _TerrainMapOffset + ( 1.0 + (ase_worldPos).xz ) ) / _TerrainMapSize ) );
			float terrainHeight1480 = ( 255.0 * tex2DNode8_g20908.g );
			float temp_output_303_0_g22264 = terrainHeight1480;
			half localunity_ObjectToWorld1w2_g22265 = ( unity_ObjectToWorld[1].w );
			float temp_output_299_0_g22264 = ( ( ase_objectScale.y * i.ase_texcoord4.y ) + localunity_ObjectToWorld1w2_g22265 );
			float temp_output_266_0_g22264 = ( boundsYObjectSpace270_g22264 / 2.0 );
			float bottomYWorldSpace274_g22264 = (( temp_output_303_0_g22264 < -100.0 ) ? ( temp_output_299_0_g22264 - temp_output_266_0_g22264 ) :  temp_output_303_0_g22264 );
			float topYWorldSpace276_g22264 = ( temp_output_299_0_g22264 + temp_output_266_0_g22264 );
			float clampResult304_g22264 = clamp( ase_worldPos.y , bottomYWorldSpace274_g22264 , topYWorldSpace276_g22264 );
			float temp_output_7_0_g22266 = bottomYWorldSpace274_g22264;
			float yTime278_g22264 = ( ( clampResult304_g22264 - temp_output_7_0_g22266 ) / ( topYWorldSpace276_g22264 - temp_output_7_0_g22266 ) );
			float temp_output_24_0_g22268 = ( boundsYObjectSpace270_g22264 * yTime278_g22264 );
			float clampResult253_g22264 = clamp( ( boundsYObjectSpace270_g22264 * _BottomCoverTargetPercentage ) , _BottomCoverMinimumVerticalRange , _BottomCoverMaximumVerticalRange );
			float temp_output_21_0_g22268 = clampResult253_g22264;
			float temp_output_31_0_g22268 = ( temp_output_21_0_g22268 + min( clampResult253_g22264 , ( abs( temp_output_21_0_g22268 ) * _BottomCoverFadePercentage ) ) );
			float temp_output_7_0_g22270 = temp_output_31_0_g22268;
			float smoothstepResult29_g22267 = smoothstep( 0.0 , 1.0 , (( temp_output_24_0_g22268 < temp_output_21_0_g22268 ) ? 1.0 :  (( temp_output_24_0_g22268 < temp_output_31_0_g22268 ) ? ( ( temp_output_24_0_g22268 - temp_output_7_0_g22270 ) / ( temp_output_21_0_g22268 - temp_output_7_0_g22270 ) ) :  0.0 ) ));
			float3 lerpResult311_g22264 = lerp( _BottomCoverBaseCoverageRange , _BottomCoverPeakCoverageRange , yTime278_g22264);
			float3 break14_g22272 = lerpResult311_g22264;
			float temp_output_28_0_g22272 = saturate( break14_g22272.x );
			float temp_output_6_0_g22274 = temp_output_28_0_g22272;
			float range69_g22274 = temp_output_6_0_g22274;
			float3 lerpResult2925 = lerp( float3( 0,0,1 ) , mainNormal786 , _BottomCoverAreaNormalStrength);
			float3 break6_g22272 = (WorldNormalVector( i , lerpResult2925 ));
			float value64_g22274 = break6_g22272.x;
			float3 break18_g22272 = _BottomCoverCoverageBasis;
			float clampResult31_g22272 = clamp( break18_g22272.x , -1.0 , 1.0 );
			float temp_output_42_0_g22274 = clampResult31_g22272;
			float temp_output_47_0_g22274 = ( temp_output_42_0_g22274 - temp_output_6_0_g22274 );
			float bottom_fade_start63_g22274 = temp_output_47_0_g22274;
			float temp_output_45_0_g22274 = ( temp_output_42_0_g22274 + temp_output_6_0_g22274 );
			float top_fade_start61_g22274 = temp_output_45_0_g22274;
			float temp_output_17_0_g22272 = saturate( _BottomCoverFadeSmoothness );
			float temp_output_36_0_g22274 = ( temp_output_28_0_g22272 * temp_output_17_0_g22272 );
			float top_fade_end60_g22274 = ( temp_output_45_0_g22274 + temp_output_36_0_g22274 );
			float temp_output_7_0_g22276 = top_fade_end60_g22274;
			float bottom_fade_end62_g22274 = ( temp_output_47_0_g22274 - temp_output_36_0_g22274 );
			float temp_output_7_0_g22275 = bottom_fade_end62_g22274;
			float smoothstepResult64_g22273 = smoothstep( 0.0 , 1.0 , (( range69_g22274 >= -0.001 && range69_g22274 <= 0.001 ) ? 0.0 :  (( value64_g22274 >= bottom_fade_start63_g22274 && value64_g22274 <= top_fade_start61_g22274 ) ? 1.0 :  (( value64_g22274 >= top_fade_start61_g22274 && value64_g22274 <= top_fade_end60_g22274 ) ? ( ( value64_g22274 - temp_output_7_0_g22276 ) / ( top_fade_start61_g22274 - temp_output_7_0_g22276 ) ) :  (( value64_g22274 >= bottom_fade_end62_g22274 && value64_g22274 <= bottom_fade_start63_g22274 ) ? ( ( value64_g22274 - temp_output_7_0_g22275 ) / ( bottom_fade_start63_g22274 - temp_output_7_0_g22275 ) ) :  0.0 ) ) ) ));
			float temp_output_29_0_g22272 = saturate( break14_g22272.y );
			float temp_output_6_0_g22284 = temp_output_29_0_g22272;
			float range69_g22284 = temp_output_6_0_g22284;
			float value64_g22284 = break6_g22272.y;
			float clampResult32_g22272 = clamp( break18_g22272.y , -1.0 , 1.0 );
			float temp_output_42_0_g22284 = clampResult32_g22272;
			float temp_output_47_0_g22284 = ( temp_output_42_0_g22284 - temp_output_6_0_g22284 );
			float bottom_fade_start63_g22284 = temp_output_47_0_g22284;
			float temp_output_45_0_g22284 = ( temp_output_42_0_g22284 + temp_output_6_0_g22284 );
			float top_fade_start61_g22284 = temp_output_45_0_g22284;
			float temp_output_36_0_g22284 = ( temp_output_29_0_g22272 * temp_output_17_0_g22272 );
			float top_fade_end60_g22284 = ( temp_output_45_0_g22284 + temp_output_36_0_g22284 );
			float temp_output_7_0_g22286 = top_fade_end60_g22284;
			float bottom_fade_end62_g22284 = ( temp_output_47_0_g22284 - temp_output_36_0_g22284 );
			float temp_output_7_0_g22285 = bottom_fade_end62_g22284;
			float smoothstepResult64_g22283 = smoothstep( 0.0 , 1.0 , (( range69_g22284 >= -0.001 && range69_g22284 <= 0.001 ) ? 0.0 :  (( value64_g22284 >= bottom_fade_start63_g22284 && value64_g22284 <= top_fade_start61_g22284 ) ? 1.0 :  (( value64_g22284 >= top_fade_start61_g22284 && value64_g22284 <= top_fade_end60_g22284 ) ? ( ( value64_g22284 - temp_output_7_0_g22286 ) / ( top_fade_start61_g22284 - temp_output_7_0_g22286 ) ) :  (( value64_g22284 >= bottom_fade_end62_g22284 && value64_g22284 <= bottom_fade_start63_g22284 ) ? ( ( value64_g22284 - temp_output_7_0_g22285 ) / ( bottom_fade_start63_g22284 - temp_output_7_0_g22285 ) ) :  0.0 ) ) ) ));
			float temp_output_30_0_g22272 = saturate( break14_g22272.z );
			float temp_output_6_0_g22279 = temp_output_30_0_g22272;
			float range69_g22279 = temp_output_6_0_g22279;
			float value64_g22279 = break6_g22272.z;
			float clampResult33_g22272 = clamp( break18_g22272.z , -1.0 , 1.0 );
			float temp_output_42_0_g22279 = clampResult33_g22272;
			float temp_output_47_0_g22279 = ( temp_output_42_0_g22279 - temp_output_6_0_g22279 );
			float bottom_fade_start63_g22279 = temp_output_47_0_g22279;
			float temp_output_45_0_g22279 = ( temp_output_42_0_g22279 + temp_output_6_0_g22279 );
			float top_fade_start61_g22279 = temp_output_45_0_g22279;
			float temp_output_36_0_g22279 = ( temp_output_30_0_g22272 * temp_output_17_0_g22272 );
			float top_fade_end60_g22279 = ( temp_output_45_0_g22279 + temp_output_36_0_g22279 );
			float temp_output_7_0_g22281 = top_fade_end60_g22279;
			float bottom_fade_end62_g22279 = ( temp_output_47_0_g22279 - temp_output_36_0_g22279 );
			float temp_output_7_0_g22280 = bottom_fade_end62_g22279;
			float smoothstepResult64_g22278 = smoothstep( 0.0 , 1.0 , (( range69_g22279 >= -0.001 && range69_g22279 <= 0.001 ) ? 0.0 :  (( value64_g22279 >= bottom_fade_start63_g22279 && value64_g22279 <= top_fade_start61_g22279 ) ? 1.0 :  (( value64_g22279 >= top_fade_start61_g22279 && value64_g22279 <= top_fade_end60_g22279 ) ? ( ( value64_g22279 - temp_output_7_0_g22281 ) / ( top_fade_start61_g22279 - temp_output_7_0_g22281 ) ) :  (( value64_g22279 >= bottom_fade_end62_g22279 && value64_g22279 <= bottom_fade_start63_g22279 ) ? ( ( value64_g22279 - temp_output_7_0_g22280 ) / ( bottom_fade_start63_g22279 - temp_output_7_0_g22280 ) ) :  0.0 ) ) ) ));
			float smoothstepResult218_g22264 = smoothstep( 0.0 , 1.0 , saturate( ( _BottomCoverFinalStrength * ( smoothstepResult29_g22267 * saturate( saturate( min( min( smoothstepResult64_g22273 , smoothstepResult64_g22283 ) , smoothstepResult64_g22278 ) ) ) ) ) ));
			float simplePerlin3D2764 = snoise( ase_worldPos*_CoverFadeNoiseScale );
			simplePerlin3D2764 = simplePerlin3D2764*0.5 + 0.5;
			float coverFadeNoise2771 = ( (-1.0 + (simplePerlin3D2764 - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) * _CoverFadeNoiseStrength );
			float bottomCoverAlpha851 = (( bottomCoverColorSum2459 > BottomCoverColorLowThreshold2720 ) ? (( bottomCoverAlphaMask2307 > BottomCoverMaskTolerance2718 ) ? (( bottomCoverAlphaMask2307 < (CalculateContrast(_BottomCoverFinalContrast,(saturate( smoothstepResult218_g22264 )).xxxx)).r ) ? 1.0 :  0.0 ) :  coverFadeNoise2771 ) :  0.0 );
			float3 lerpResult7_g22393 = lerp( mainNormal786 , bottomCoverNormal2163 , bottomCoverAlpha851);
			float MiddleCoverTriplanarContrast2710 = _MiddleCoverTriplanarContrast;
			float3 temp_cast_31 = (MiddleCoverTriplanarContrast2710).xxx;
			float3 temp_output_42_0_g22133 = pow( abs( ase_worldNormal ) , temp_cast_31 );
			float3 break2_g22142 = temp_output_42_0_g22133;
			float3 temp_output_836_0_g22113 = ( temp_output_42_0_g22133 / ( break2_g22142.x + break2_g22142.y + break2_g22142.z ) );
			float3 break141_g22116 = temp_output_836_0_g22113;
			float3 break127_g22116 = abs( ase_worldNormal );
			float3 appendResult123_g22116 = (float3(ase_worldNormal.z , ase_worldNormal.y , break127_g22116.x));
			float3 temp_output_4_0_g22128 = ( appendResult123_g22116 + float3( 0,0,1 ) );
			float3 break6_g22141 = sign( ase_worldNormal );
			float3 appendResult7_g22141 = (float3((( break6_g22141.x < 0.0 ) ? -1.0 :  1.0 ) , (( break6_g22141.y < 0.0 ) ? -1.0 :  1.0 ) , (( break6_g22141.z < 0.0 ) ? -1.0 :  1.0 )));
			float3 temp_output_57_0_g22133 = appendResult7_g22141;
			float3 appendResult53_g22133 = (float3((temp_output_57_0_g22133).xy , ( (temp_output_57_0_g22133).z * -1.0 )));
			float3 axisSigns54_g22133 = appendResult53_g22133;
			float3 temp_output_99_0_g22116 = axisSigns54_g22133;
			float3 break113_g22116 = temp_output_99_0_g22116;
			float2 appendResult116_g22116 = (float2(break113_g22116.x , 1.0));
			float temp_output_74_0_g22133 = 1.0;
			float2 temp_output_1_0_g22134 = (ase_worldPos).zy;
			float middleCoverScale2193 = ( coverObjectScale1274 + _MiddleCoverTextureScale );
			float2 temp_output_31_0_g22133 = (middleCoverScale2193).xx;
			float2 temp_output_2_0_g22134 = temp_output_31_0_g22133;
			float2 temp_output_30_0_g22133 = float2( 0,0 );
			float3 break89_g22133 = axisSigns54_g22133;
			float2 appendResult6_g22138 = (float2(break89_g22133.x , 1.0));
			float2 temp_output_84_0_g22133 = ( ( (( temp_output_74_0_g22133 > 0.0 ) ? ( temp_output_1_0_g22134 / temp_output_2_0_g22134 ) :  ( temp_output_1_0_g22134 * temp_output_2_0_g22134 ) ) + temp_output_30_0_g22133 ) * appendResult6_g22138 );
			float2 temp_output_833_0_g22113 = temp_output_84_0_g22133;
			float clampResult200_g20898 = clamp( ( round( fmod( temp_output_222_0_g20898 , _GLOBAL_SHADER_SET_INDICES[(int)break195_g20898.z] ) ) + _GLOBAL_SHADER_SET_INDICES[(int)break32_g20898.z] ) , _GLOBAL_SHADER_SET_INDICES[(int)break32_g20898.z] , ( _GLOBAL_SHADER_SET_INDICES[(int)break32_g20898.z] + -1.0 + _GLOBAL_SHADER_SET_INDICES[(int)break195_g20898.z] ) );
			float2 appendResult106_g20898 = (float2(_GLOBAL_SHADER_SET_INDICES[(int)clampResult200_g20898] , _GLOBAL_SHADER_SET_INDICES[(int)( clampResult200_g20898 + 1.0 )]));
			float clampResult201_g20898 = clamp( ( round( fmod( temp_output_222_0_g20898 , _GLOBAL_SHADER_SET_INDICES[(int)break195_g20898.w] ) ) + _GLOBAL_SHADER_SET_INDICES[(int)break32_g20898.w] ) , _GLOBAL_SHADER_SET_INDICES[(int)break32_g20898.w] , ( _GLOBAL_SHADER_SET_INDICES[(int)break32_g20898.w] + -1.0 + _GLOBAL_SHADER_SET_INDICES[(int)break195_g20898.w] ) );
			float2 appendResult107_g20898 = (float2(_GLOBAL_SHADER_SET_INDICES[(int)clampResult201_g20898] , _GLOBAL_SHADER_SET_INDICES[(int)( clampResult201_g20898 + 1.0 )]));
			float4 appendResult732 = (float4(round( appendResult106_g20898 ) , round( appendResult107_g20898 )));
			float4 appendResult2138 = (float4(_MiddleCoverTextureIndices.x , (( lockIndices2132 > 0.5 ) ? _MiddleCoverTextureIndices.x :  _MiddleCoverTextureIndices.y ) , _TopCoverTextureIndices.x , (( lockIndices2132 > 0.5 ) ? _TopCoverTextureIndices.x :  _TopCoverTextureIndices.y )));
			float4 break744 = (( _UseMeshTextureIndices > 0.5 ) ? appendResult732 :  appendResult2138 );
			float middleCoverNormalIndex2245 = (( lockIndices2132 > 0.5 ) ? break744.x :  break744.y );
			float temp_output_895_0_g22113 = middleCoverNormalIndex2245;
			float4 texArray891_g22113 = UNITY_SAMPLE_TEX2DARRAY(_CoverNormSAOArray, float3(temp_output_833_0_g22113, temp_output_895_0_g22113)  );
			float4 unpaciked14_g22114 = (texArray891_g22113).garb;
			float2 temp_cast_40 = (1.0).xx;
			float3 appendResult117_g22116 = (float3(( appendResult116_g22116 * ( ( (unpaciked14_g22114).xy * 2.0 ) - temp_cast_40 ) ) , 1.0));
			float3 temp_output_7_0_g22128 = ( appendResult117_g22116 * float3( -1,0,0 ) );
			float dotResult9_g22128 = dot( temp_output_4_0_g22128 , temp_output_7_0_g22128 );
			float3 axisSigns133_g22116 = temp_output_99_0_g22116;
			float3 break135_g22116 = axisSigns133_g22116;
			float3 appendResult6_g22117 = (float3(1.0 , 1.0 , break135_g22116.x));
			float3 appendResult128_g22116 = (float3(ase_worldNormal.x , ase_worldNormal.z , break127_g22116.y));
			float3 temp_output_4_0_g22121 = ( appendResult128_g22116 + float3( 0,0,1 ) );
			float2 appendResult115_g22116 = (float2(break113_g22116.y , 1.0));
			float2 temp_output_1_0_g22137 = (ase_worldPos).xz;
			float2 temp_output_2_0_g22137 = temp_output_31_0_g22133;
			float2 appendResult6_g22135 = (float2(break89_g22133.y , 1.0));
			float2 temp_output_87_0_g22133 = ( ( (( temp_output_74_0_g22133 > 0.0 ) ? ( temp_output_1_0_g22137 / temp_output_2_0_g22137 ) :  ( temp_output_1_0_g22137 * temp_output_2_0_g22137 ) ) + ( temp_output_30_0_g22133 + ( 0.0 * _Vector0 ) ) ) * appendResult6_g22135 );
			float2 temp_output_834_0_g22113 = temp_output_87_0_g22133;
			float4 texArray890_g22113 = UNITY_SAMPLE_TEX2DARRAY(_CoverNormSAOArray, float3(temp_output_834_0_g22113, temp_output_895_0_g22113)  );
			float4 unpaciked14_g22131 = (texArray890_g22113).garb;
			float2 temp_cast_41 = (1.0).xx;
			float3 appendResult120_g22116 = (float3(( appendResult115_g22116 * ( ( (unpaciked14_g22131).xy * 2.0 ) - temp_cast_41 ) ) , 1.0));
			float3 temp_output_7_0_g22121 = ( appendResult120_g22116 * float3( -1,0,0 ) );
			float dotResult9_g22121 = dot( temp_output_4_0_g22121 , temp_output_7_0_g22121 );
			float3 appendResult6_g22119 = (float3(1.0 , 1.0 , break135_g22116.y));
			float3 appendResult129_g22116 = (float3(ase_worldNormal.x , ase_worldNormal.y , break127_g22116.z));
			float3 temp_output_4_0_g22123 = ( appendResult129_g22116 + float3( 0,0,1 ) );
			float2 appendResult114_g22116 = (float2(break113_g22116.z , 1.0));
			float2 temp_output_1_0_g22143 = (ase_worldPos).xy;
			float2 temp_output_2_0_g22143 = temp_output_31_0_g22133;
			float2 appendResult6_g22139 = (float2(break89_g22133.z , 1.0));
			float2 temp_output_88_0_g22133 = ( ( (( temp_output_74_0_g22133 > 0.0 ) ? ( temp_output_1_0_g22143 / temp_output_2_0_g22143 ) :  ( temp_output_1_0_g22143 * temp_output_2_0_g22143 ) ) + ( temp_output_30_0_g22133 + ( 0.0 * _Vector0 * 2.0 ) ) ) * appendResult6_g22139 );
			float2 temp_output_832_0_g22113 = temp_output_88_0_g22133;
			float4 texArray889_g22113 = UNITY_SAMPLE_TEX2DARRAY(_CoverNormSAOArray, float3(temp_output_832_0_g22113, temp_output_895_0_g22113)  );
			float4 unpaciked14_g22115 = (texArray889_g22113).garb;
			float2 temp_cast_42 = (1.0).xx;
			float3 appendResult121_g22116 = (float3(( appendResult114_g22116 * ( ( (unpaciked14_g22115).xy * 2.0 ) - temp_cast_42 ) ) , 1.0));
			float3 temp_output_7_0_g22123 = ( appendResult121_g22116 * float3( -1,0,0 ) );
			float dotResult9_g22123 = dot( temp_output_4_0_g22123 , temp_output_7_0_g22123 );
			float3 appendResult6_g22118 = (float3(1.0 , 1.0 , ( break135_g22116.z * -1.0 )));
			float2 temp_output_2_0_g22130 = mul( float3x3((WorldNormalVector( i , float3(1,0,0) )), (WorldNormalVector( i , float3(0,1,0) )), (WorldNormalVector( i , float3(0,0,1) ))), ( ( break141_g22116.x * (( ( ( ( temp_output_4_0_g22128 * dotResult9_g22128 ) / (temp_output_4_0_g22128).z ) - temp_output_7_0_g22128 ) * appendResult6_g22117 )).zyx ) + ( break141_g22116.y * (( ( ( ( temp_output_4_0_g22121 * dotResult9_g22121 ) / (temp_output_4_0_g22121).z ) - temp_output_7_0_g22121 ) * appendResult6_g22119 )).xzy ) + ( break141_g22116.z * (( ( ( ( temp_output_4_0_g22123 * dotResult9_g22123 ) / (temp_output_4_0_g22123).z ) - temp_output_7_0_g22123 ) * appendResult6_g22118 )).xyz ) ) ).xy;
			float dotResult42_g22130 = dot( temp_output_2_0_g22130 , temp_output_2_0_g22130 );
			float3 appendResult38_g22130 = (float3(temp_output_2_0_g22130 , sqrt( ( 1.0 - saturate( dotResult42_g22130 ) ) )));
			float3 normalizeResult39_g22130 = normalize( appendResult38_g22130 );
			float3 temp_output_2_0_g22381 = normalizeResult39_g22130;
			float3 temp_output_36_0_g22381 = ( _MiddleCoverNormalScale * temp_output_2_0_g22381 );
			float3 appendResult38_g22381 = (float3(temp_output_36_0_g22381.xy , (temp_output_2_0_g22381).z));
			float2 temp_output_2_0_g22383 = temp_output_36_0_g22381.xy;
			float dotResult42_g22383 = dot( temp_output_2_0_g22383 , temp_output_2_0_g22383 );
			float3 appendResult38_g22383 = (float3(temp_output_2_0_g22383 , sqrt( ( 1.0 - saturate( dotResult42_g22383 ) ) )));
			float3 normalizeResult39_g22383 = normalize( appendResult38_g22383 );
			float2 break30_g22382 = temp_output_36_0_g22381.xy;
			float3 appendResult38_g22382 = (float3(break30_g22382.x , break30_g22382.y , sqrt( ( 1.0 - ( ( break30_g22382.x * break30_g22382.x ) + ( break30_g22382.y * break30_g22382.y ) ) ) )));
			float3 normalizeResult39_g22382 = normalize( appendResult38_g22382 );
			float3 middleCoverNormal2148 = (( normalZReconstructionStyle2681 < 1.0 ) ? appendResult38_g22381 :  (( 2.0 > 0.0 ) ? normalizeResult39_g22383 :  normalizeResult39_g22382 ) );
			float3 lerpResult8_g22393 = lerp( lerpResult7_g22393 , middleCoverNormal2148 , 0);
			float TopCoverTriplanarContrast1057 = _TopCoverTriplanarContrast;
			float3 temp_cast_47 = (TopCoverTriplanarContrast1057).xxx;
			float3 temp_output_42_0_g22165 = pow( abs( ase_worldNormal ) , temp_cast_47 );
			float3 break2_g22174 = temp_output_42_0_g22165;
			float3 temp_output_836_0_g22145 = ( temp_output_42_0_g22165 / ( break2_g22174.x + break2_g22174.y + break2_g22174.z ) );
			float3 break141_g22148 = temp_output_836_0_g22145;
			float3 break127_g22148 = abs( ase_worldNormal );
			float3 appendResult123_g22148 = (float3(ase_worldNormal.z , ase_worldNormal.y , break127_g22148.x));
			float3 temp_output_4_0_g22160 = ( appendResult123_g22148 + float3( 0,0,1 ) );
			float3 break6_g22173 = sign( ase_worldNormal );
			float3 appendResult7_g22173 = (float3((( break6_g22173.x < 0.0 ) ? -1.0 :  1.0 ) , (( break6_g22173.y < 0.0 ) ? -1.0 :  1.0 ) , (( break6_g22173.z < 0.0 ) ? -1.0 :  1.0 )));
			float3 temp_output_57_0_g22165 = appendResult7_g22173;
			float3 appendResult53_g22165 = (float3((temp_output_57_0_g22165).xy , ( (temp_output_57_0_g22165).z * -1.0 )));
			float3 axisSigns54_g22165 = appendResult53_g22165;
			float3 temp_output_99_0_g22148 = axisSigns54_g22165;
			float3 break113_g22148 = temp_output_99_0_g22148;
			float2 appendResult116_g22148 = (float2(break113_g22148.x , 1.0));
			float temp_output_74_0_g22165 = 1.0;
			float2 temp_output_1_0_g22166 = (ase_worldPos).zy;
			float topCoverScale2194 = ( coverObjectScale1274 + _TopCoverTextureScale );
			float2 temp_output_31_0_g22165 = (topCoverScale2194).xx;
			float2 temp_output_2_0_g22166 = temp_output_31_0_g22165;
			float2 temp_output_30_0_g22165 = float2( 0,0 );
			float3 break89_g22165 = axisSigns54_g22165;
			float2 appendResult6_g22170 = (float2(break89_g22165.x , 1.0));
			float2 temp_output_84_0_g22165 = ( ( (( temp_output_74_0_g22165 > 0.0 ) ? ( temp_output_1_0_g22166 / temp_output_2_0_g22166 ) :  ( temp_output_1_0_g22166 * temp_output_2_0_g22166 ) ) + temp_output_30_0_g22165 ) * appendResult6_g22170 );
			float2 temp_output_833_0_g22145 = temp_output_84_0_g22165;
			float topCoverNormalIndex2122 = (( lockIndices2132 > 0.5 ) ? break744.z :  break744.w );
			float temp_output_895_0_g22145 = topCoverNormalIndex2122;
			float4 texArray891_g22145 = UNITY_SAMPLE_TEX2DARRAY(_CoverNormSAOArray, float3(temp_output_833_0_g22145, temp_output_895_0_g22145)  );
			float4 unpaciked14_g22146 = (texArray891_g22145).garb;
			float2 temp_cast_48 = (1.0).xx;
			float3 appendResult117_g22148 = (float3(( appendResult116_g22148 * ( ( (unpaciked14_g22146).xy * 2.0 ) - temp_cast_48 ) ) , 1.0));
			float3 temp_output_7_0_g22160 = ( appendResult117_g22148 * float3( -1,0,0 ) );
			float dotResult9_g22160 = dot( temp_output_4_0_g22160 , temp_output_7_0_g22160 );
			float3 axisSigns133_g22148 = temp_output_99_0_g22148;
			float3 break135_g22148 = axisSigns133_g22148;
			float3 appendResult6_g22149 = (float3(1.0 , 1.0 , break135_g22148.x));
			float3 appendResult128_g22148 = (float3(ase_worldNormal.x , ase_worldNormal.z , break127_g22148.y));
			float3 temp_output_4_0_g22153 = ( appendResult128_g22148 + float3( 0,0,1 ) );
			float2 appendResult115_g22148 = (float2(break113_g22148.y , 1.0));
			float2 temp_output_1_0_g22169 = (ase_worldPos).xz;
			float2 temp_output_2_0_g22169 = temp_output_31_0_g22165;
			float2 appendResult6_g22167 = (float2(break89_g22165.y , 1.0));
			float2 temp_output_87_0_g22165 = ( ( (( temp_output_74_0_g22165 > 0.0 ) ? ( temp_output_1_0_g22169 / temp_output_2_0_g22169 ) :  ( temp_output_1_0_g22169 * temp_output_2_0_g22169 ) ) + ( temp_output_30_0_g22165 + ( 0.0 * _Vector0 ) ) ) * appendResult6_g22167 );
			float2 temp_output_834_0_g22145 = temp_output_87_0_g22165;
			float4 texArray890_g22145 = UNITY_SAMPLE_TEX2DARRAY(_CoverNormSAOArray, float3(temp_output_834_0_g22145, temp_output_895_0_g22145)  );
			float4 unpaciked14_g22163 = (texArray890_g22145).garb;
			float2 temp_cast_49 = (1.0).xx;
			float3 appendResult120_g22148 = (float3(( appendResult115_g22148 * ( ( (unpaciked14_g22163).xy * 2.0 ) - temp_cast_49 ) ) , 1.0));
			float3 temp_output_7_0_g22153 = ( appendResult120_g22148 * float3( -1,0,0 ) );
			float dotResult9_g22153 = dot( temp_output_4_0_g22153 , temp_output_7_0_g22153 );
			float3 appendResult6_g22151 = (float3(1.0 , 1.0 , break135_g22148.y));
			float3 appendResult129_g22148 = (float3(ase_worldNormal.x , ase_worldNormal.y , break127_g22148.z));
			float3 temp_output_4_0_g22155 = ( appendResult129_g22148 + float3( 0,0,1 ) );
			float2 appendResult114_g22148 = (float2(break113_g22148.z , 1.0));
			float2 temp_output_1_0_g22175 = (ase_worldPos).xy;
			float2 temp_output_2_0_g22175 = temp_output_31_0_g22165;
			float2 appendResult6_g22171 = (float2(break89_g22165.z , 1.0));
			float2 temp_output_88_0_g22165 = ( ( (( temp_output_74_0_g22165 > 0.0 ) ? ( temp_output_1_0_g22175 / temp_output_2_0_g22175 ) :  ( temp_output_1_0_g22175 * temp_output_2_0_g22175 ) ) + ( temp_output_30_0_g22165 + ( 0.0 * _Vector0 * 2.0 ) ) ) * appendResult6_g22171 );
			float2 temp_output_832_0_g22145 = temp_output_88_0_g22165;
			float4 texArray889_g22145 = UNITY_SAMPLE_TEX2DARRAY(_CoverNormSAOArray, float3(temp_output_832_0_g22145, temp_output_895_0_g22145)  );
			float4 unpaciked14_g22147 = (texArray889_g22145).garb;
			float2 temp_cast_50 = (1.0).xx;
			float3 appendResult121_g22148 = (float3(( appendResult114_g22148 * ( ( (unpaciked14_g22147).xy * 2.0 ) - temp_cast_50 ) ) , 1.0));
			float3 temp_output_7_0_g22155 = ( appendResult121_g22148 * float3( -1,0,0 ) );
			float dotResult9_g22155 = dot( temp_output_4_0_g22155 , temp_output_7_0_g22155 );
			float3 appendResult6_g22150 = (float3(1.0 , 1.0 , ( break135_g22148.z * -1.0 )));
			float2 temp_output_2_0_g22162 = mul( float3x3((WorldNormalVector( i , float3(1,0,0) )), (WorldNormalVector( i , float3(0,1,0) )), (WorldNormalVector( i , float3(0,0,1) ))), ( ( break141_g22148.x * (( ( ( ( temp_output_4_0_g22160 * dotResult9_g22160 ) / (temp_output_4_0_g22160).z ) - temp_output_7_0_g22160 ) * appendResult6_g22149 )).zyx ) + ( break141_g22148.y * (( ( ( ( temp_output_4_0_g22153 * dotResult9_g22153 ) / (temp_output_4_0_g22153).z ) - temp_output_7_0_g22153 ) * appendResult6_g22151 )).xzy ) + ( break141_g22148.z * (( ( ( ( temp_output_4_0_g22155 * dotResult9_g22155 ) / (temp_output_4_0_g22155).z ) - temp_output_7_0_g22155 ) * appendResult6_g22150 )).xyz ) ) ).xy;
			float dotResult42_g22162 = dot( temp_output_2_0_g22162 , temp_output_2_0_g22162 );
			float3 appendResult38_g22162 = (float3(temp_output_2_0_g22162 , sqrt( ( 1.0 - saturate( dotResult42_g22162 ) ) )));
			float3 normalizeResult39_g22162 = normalize( appendResult38_g22162 );
			float3 temp_output_2_0_g22375 = normalizeResult39_g22162;
			float3 temp_output_36_0_g22375 = ( _TopCoverNormalScale * temp_output_2_0_g22375 );
			float3 appendResult38_g22375 = (float3(temp_output_36_0_g22375.xy , (temp_output_2_0_g22375).z));
			float2 temp_output_2_0_g22377 = temp_output_36_0_g22375.xy;
			float dotResult42_g22377 = dot( temp_output_2_0_g22377 , temp_output_2_0_g22377 );
			float3 appendResult38_g22377 = (float3(temp_output_2_0_g22377 , sqrt( ( 1.0 - saturate( dotResult42_g22377 ) ) )));
			float3 normalizeResult39_g22377 = normalize( appendResult38_g22377 );
			float2 break30_g22376 = temp_output_36_0_g22375.xy;
			float3 appendResult38_g22376 = (float3(break30_g22376.x , break30_g22376.y , sqrt( ( 1.0 - ( ( break30_g22376.x * break30_g22376.x ) + ( break30_g22376.y * break30_g22376.y ) ) ) )));
			float3 normalizeResult39_g22376 = normalize( appendResult38_g22376 );
			float3 topCoverNormal700 = (( normalZReconstructionStyle2681 < 1.0 ) ? appendResult38_g22375 :  (( 2.0 > 0.0 ) ? normalizeResult39_g22377 :  normalizeResult39_g22376 ) );
			float topCoverBaseColorIndex2121 = break744.z;
			float temp_output_896_0_g22145 = topCoverBaseColorIndex2121;
			float4 texArray894_g22145 = UNITY_SAMPLE_TEX2DARRAY(_CoverBaseColorArray, float3(temp_output_833_0_g22145, temp_output_896_0_g22145)  );
			float4 texArray893_g22145 = UNITY_SAMPLE_TEX2DARRAY(_CoverBaseColorArray, float3(temp_output_834_0_g22145, temp_output_896_0_g22145)  );
			float4 texArray892_g22145 = UNITY_SAMPLE_TEX2DARRAY(_CoverBaseColorArray, float3(temp_output_832_0_g22145, temp_output_896_0_g22145)  );
			float3 weightedBlendVar840_g22145 = temp_output_836_0_g22145;
			float4 weightedAvg840_g22145 = ( ( weightedBlendVar840_g22145.x*texArray894_g22145 + weightedBlendVar840_g22145.y*texArray893_g22145 + weightedBlendVar840_g22145.z*texArray892_g22145 )/( weightedBlendVar840_g22145.x + weightedBlendVar840_g22145.y + weightedBlendVar840_g22145.z ) );
			float3 hsvTorgb427_g22210 = RGBToHSV( weightedAvg840_g22145.rgb );
			float3 hsvTorgb428_g22210 = HSVToRGB( float3(( 0.0 + hsvTorgb427_g22210.x ),( _TopCoverSaturationMultiplier * hsvTorgb427_g22210.y ),( _TopCoverValueMultiplier * hsvTorgb427_g22210.z )) );
			float4 lerpResult2989 = lerp( CalculateContrast(_TopCoverContrast,float4( hsvTorgb428_g22210 , 0.0 )) , mainBaseColor789 , _TopCoverAlbedoMatch);
			float4 topCoverBaseColor702 = lerpResult2989;
			float3 break2_g22342 = topCoverBaseColor702.rgb;
			float topCoverColorSum2463 = ( break2_g22342.x + break2_g22342.y + break2_g22342.z );
			float TopCoverColorLowThreshold2498 = _TopCoverColorLowThreshold;
			float3 temp_cast_58 = (TopCoverTriplanarContrast1057).xxx;
			float3 temp_output_42_0_g22034 = pow( abs( ase_worldNormal ) , temp_cast_58 );
			float3 break2_g22043 = temp_output_42_0_g22034;
			float temp_output_74_0_g22034 = 1.0;
			float2 temp_output_1_0_g22035 = (ase_worldPos).zy;
			float topCoverMaskScale2516 = ( coverObjectScale1274 + _TopCoverMaskScale );
			float2 temp_output_31_0_g22034 = ( (topCoverMaskScale2516).xx * scaleMultiplier1313 );
			float2 temp_output_2_0_g22035 = temp_output_31_0_g22034;
			float2 temp_output_30_0_g22034 = float2( 0,0 );
			float3 break6_g22042 = sign( ase_worldNormal );
			float3 appendResult7_g22042 = (float3((( break6_g22042.x < 0.0 ) ? -1.0 :  1.0 ) , (( break6_g22042.y < 0.0 ) ? -1.0 :  1.0 ) , (( break6_g22042.z < 0.0 ) ? -1.0 :  1.0 )));
			float3 temp_output_57_0_g22034 = appendResult7_g22042;
			float3 appendResult53_g22034 = (float3((temp_output_57_0_g22034).xy , ( (temp_output_57_0_g22034).z * -1.0 )));
			float3 axisSigns54_g22034 = appendResult53_g22034;
			float3 break89_g22034 = axisSigns54_g22034;
			float2 appendResult6_g22039 = (float2(break89_g22034.x , 1.0));
			float2 temp_output_84_0_g22034 = ( ( (( temp_output_74_0_g22034 > 0.0 ) ? ( temp_output_1_0_g22035 / temp_output_2_0_g22035 ) :  ( temp_output_1_0_g22035 * temp_output_2_0_g22035 ) ) + temp_output_30_0_g22034 ) * appendResult6_g22039 );
			float temp_output_899_0_g22033 = topCoverBaseColorIndex2121;
			float4 texArray896_g22033 = UNITY_SAMPLE_TEX2DARRAY(_CoverBaseColorArray, float3(temp_output_84_0_g22034, temp_output_899_0_g22033)  );
			float2 temp_output_1_0_g22038 = (ase_worldPos).xz;
			float2 temp_output_2_0_g22038 = temp_output_31_0_g22034;
			float2 appendResult6_g22036 = (float2(break89_g22034.y , 1.0));
			float2 temp_output_87_0_g22034 = ( ( (( temp_output_74_0_g22034 > 0.0 ) ? ( temp_output_1_0_g22038 / temp_output_2_0_g22038 ) :  ( temp_output_1_0_g22038 * temp_output_2_0_g22038 ) ) + ( temp_output_30_0_g22034 + ( 0.0 * _Vector0 ) ) ) * appendResult6_g22036 );
			float4 texArray897_g22033 = UNITY_SAMPLE_TEX2DARRAY(_CoverBaseColorArray, float3(temp_output_87_0_g22034, temp_output_899_0_g22033)  );
			float2 temp_output_1_0_g22044 = (ase_worldPos).xy;
			float2 temp_output_2_0_g22044 = temp_output_31_0_g22034;
			float2 appendResult6_g22040 = (float2(break89_g22034.z , 1.0));
			float2 temp_output_88_0_g22034 = ( ( (( temp_output_74_0_g22034 > 0.0 ) ? ( temp_output_1_0_g22044 / temp_output_2_0_g22044 ) :  ( temp_output_1_0_g22044 * temp_output_2_0_g22044 ) ) + ( temp_output_30_0_g22034 + ( 0.0 * _Vector0 * 2.0 ) ) ) * appendResult6_g22040 );
			float4 texArray898_g22033 = UNITY_SAMPLE_TEX2DARRAY(_CoverBaseColorArray, float3(temp_output_88_0_g22034, temp_output_899_0_g22033)  );
			float3 weightedBlendVar840_g22033 = ( temp_output_42_0_g22034 / ( break2_g22043.x + break2_g22043.y + break2_g22043.z ) );
			float4 weightedAvg840_g22033 = ( ( weightedBlendVar840_g22033.x*texArray896_g22033 + weightedBlendVar840_g22033.y*texArray897_g22033 + weightedBlendVar840_g22033.z*texArray898_g22033 )/( weightedBlendVar840_g22033.x + weightedBlendVar840_g22033.y + weightedBlendVar840_g22033.z ) );
			float temp_output_2308_0 = (CalculateContrast(_CoverAlphaMaskContrast,( (weightedAvg840_g22033).aaaa * _CoverAlphaMaskMultiplier ))).r;
			float topCoverAlphaMask2311 = temp_output_2308_0;
			float TopCoverMaskTolerance2456 = _TopCoverMaskTolerance;
			float boundsYObjectSpace270_g22288 = ( ase_objectScale.y * i.ase_texcoord5.y );
			float temp_output_303_0_g22288 = terrainHeight1480;
			half localunity_ObjectToWorld1w2_g22289 = ( unity_ObjectToWorld[1].w );
			float temp_output_299_0_g22288 = ( ( ase_objectScale.y * i.ase_texcoord4.y ) + localunity_ObjectToWorld1w2_g22289 );
			float temp_output_266_0_g22288 = ( boundsYObjectSpace270_g22288 / 2.0 );
			float bottomYWorldSpace274_g22288 = (( temp_output_303_0_g22288 < -100.0 ) ? ( temp_output_299_0_g22288 - temp_output_266_0_g22288 ) :  temp_output_303_0_g22288 );
			float topYWorldSpace276_g22288 = ( temp_output_299_0_g22288 + temp_output_266_0_g22288 );
			float clampResult304_g22288 = clamp( ase_worldPos.y , bottomYWorldSpace274_g22288 , topYWorldSpace276_g22288 );
			float temp_output_7_0_g22290 = bottomYWorldSpace274_g22288;
			float yTime278_g22288 = ( ( clampResult304_g22288 - temp_output_7_0_g22290 ) / ( topYWorldSpace276_g22288 - temp_output_7_0_g22290 ) );
			float temp_output_24_0_g22292 = ( boundsYObjectSpace270_g22288 * yTime278_g22288 );
			float clampResult253_g22288 = clamp( ( boundsYObjectSpace270_g22288 * _TopCoverTargetPercentage ) , _TopCoverMinimumVerticalRange , _TopCoverMaximumVerticalRange );
			float temp_output_21_0_g22292 = clampResult253_g22288;
			float temp_output_31_0_g22292 = ( temp_output_21_0_g22292 + min( clampResult253_g22288 , ( abs( temp_output_21_0_g22292 ) * _TopCoverFadePercentage ) ) );
			float temp_output_7_0_g22294 = temp_output_31_0_g22292;
			float smoothstepResult29_g22291 = smoothstep( 0.0 , 1.0 , (( temp_output_24_0_g22292 < temp_output_21_0_g22292 ) ? 1.0 :  (( temp_output_24_0_g22292 < temp_output_31_0_g22292 ) ? ( ( temp_output_24_0_g22292 - temp_output_7_0_g22294 ) / ( temp_output_21_0_g22292 - temp_output_7_0_g22294 ) ) :  0.0 ) ));
			float3 lerpResult311_g22288 = lerp( _TopCoverBaseCoverageRange , _TopCoverPeakCoverageRange , yTime278_g22288);
			float3 break14_g22296 = lerpResult311_g22288;
			float temp_output_28_0_g22296 = saturate( break14_g22296.x );
			float temp_output_6_0_g22298 = temp_output_28_0_g22296;
			float range69_g22298 = temp_output_6_0_g22298;
			float3 lerpResult2926 = lerp( float3( 0,0,1 ) , mainNormal786 , _TopCoverAreaNormalStrength);
			float3 break6_g22296 = (WorldNormalVector( i , lerpResult2926 ));
			float value64_g22298 = break6_g22296.x;
			float3 break18_g22296 = _TopCoverCoverageBasis;
			float clampResult31_g22296 = clamp( break18_g22296.x , -1.0 , 1.0 );
			float temp_output_42_0_g22298 = clampResult31_g22296;
			float temp_output_47_0_g22298 = ( temp_output_42_0_g22298 - temp_output_6_0_g22298 );
			float bottom_fade_start63_g22298 = temp_output_47_0_g22298;
			float temp_output_45_0_g22298 = ( temp_output_42_0_g22298 + temp_output_6_0_g22298 );
			float top_fade_start61_g22298 = temp_output_45_0_g22298;
			float temp_output_17_0_g22296 = saturate( _TopCoverFadeSmoothness );
			float temp_output_36_0_g22298 = ( temp_output_28_0_g22296 * temp_output_17_0_g22296 );
			float top_fade_end60_g22298 = ( temp_output_45_0_g22298 + temp_output_36_0_g22298 );
			float temp_output_7_0_g22300 = top_fade_end60_g22298;
			float bottom_fade_end62_g22298 = ( temp_output_47_0_g22298 - temp_output_36_0_g22298 );
			float temp_output_7_0_g22299 = bottom_fade_end62_g22298;
			float smoothstepResult64_g22297 = smoothstep( 0.0 , 1.0 , (( range69_g22298 >= -0.001 && range69_g22298 <= 0.001 ) ? 0.0 :  (( value64_g22298 >= bottom_fade_start63_g22298 && value64_g22298 <= top_fade_start61_g22298 ) ? 1.0 :  (( value64_g22298 >= top_fade_start61_g22298 && value64_g22298 <= top_fade_end60_g22298 ) ? ( ( value64_g22298 - temp_output_7_0_g22300 ) / ( top_fade_start61_g22298 - temp_output_7_0_g22300 ) ) :  (( value64_g22298 >= bottom_fade_end62_g22298 && value64_g22298 <= bottom_fade_start63_g22298 ) ? ( ( value64_g22298 - temp_output_7_0_g22299 ) / ( bottom_fade_start63_g22298 - temp_output_7_0_g22299 ) ) :  0.0 ) ) ) ));
			float temp_output_29_0_g22296 = saturate( break14_g22296.y );
			float temp_output_6_0_g22308 = temp_output_29_0_g22296;
			float range69_g22308 = temp_output_6_0_g22308;
			float value64_g22308 = break6_g22296.y;
			float clampResult32_g22296 = clamp( break18_g22296.y , -1.0 , 1.0 );
			float temp_output_42_0_g22308 = clampResult32_g22296;
			float temp_output_47_0_g22308 = ( temp_output_42_0_g22308 - temp_output_6_0_g22308 );
			float bottom_fade_start63_g22308 = temp_output_47_0_g22308;
			float temp_output_45_0_g22308 = ( temp_output_42_0_g22308 + temp_output_6_0_g22308 );
			float top_fade_start61_g22308 = temp_output_45_0_g22308;
			float temp_output_36_0_g22308 = ( temp_output_29_0_g22296 * temp_output_17_0_g22296 );
			float top_fade_end60_g22308 = ( temp_output_45_0_g22308 + temp_output_36_0_g22308 );
			float temp_output_7_0_g22310 = top_fade_end60_g22308;
			float bottom_fade_end62_g22308 = ( temp_output_47_0_g22308 - temp_output_36_0_g22308 );
			float temp_output_7_0_g22309 = bottom_fade_end62_g22308;
			float smoothstepResult64_g22307 = smoothstep( 0.0 , 1.0 , (( range69_g22308 >= -0.001 && range69_g22308 <= 0.001 ) ? 0.0 :  (( value64_g22308 >= bottom_fade_start63_g22308 && value64_g22308 <= top_fade_start61_g22308 ) ? 1.0 :  (( value64_g22308 >= top_fade_start61_g22308 && value64_g22308 <= top_fade_end60_g22308 ) ? ( ( value64_g22308 - temp_output_7_0_g22310 ) / ( top_fade_start61_g22308 - temp_output_7_0_g22310 ) ) :  (( value64_g22308 >= bottom_fade_end62_g22308 && value64_g22308 <= bottom_fade_start63_g22308 ) ? ( ( value64_g22308 - temp_output_7_0_g22309 ) / ( bottom_fade_start63_g22308 - temp_output_7_0_g22309 ) ) :  0.0 ) ) ) ));
			float temp_output_30_0_g22296 = saturate( break14_g22296.z );
			float temp_output_6_0_g22303 = temp_output_30_0_g22296;
			float range69_g22303 = temp_output_6_0_g22303;
			float value64_g22303 = break6_g22296.z;
			float clampResult33_g22296 = clamp( break18_g22296.z , -1.0 , 1.0 );
			float temp_output_42_0_g22303 = clampResult33_g22296;
			float temp_output_47_0_g22303 = ( temp_output_42_0_g22303 - temp_output_6_0_g22303 );
			float bottom_fade_start63_g22303 = temp_output_47_0_g22303;
			float temp_output_45_0_g22303 = ( temp_output_42_0_g22303 + temp_output_6_0_g22303 );
			float top_fade_start61_g22303 = temp_output_45_0_g22303;
			float temp_output_36_0_g22303 = ( temp_output_30_0_g22296 * temp_output_17_0_g22296 );
			float top_fade_end60_g22303 = ( temp_output_45_0_g22303 + temp_output_36_0_g22303 );
			float temp_output_7_0_g22305 = top_fade_end60_g22303;
			float bottom_fade_end62_g22303 = ( temp_output_47_0_g22303 - temp_output_36_0_g22303 );
			float temp_output_7_0_g22304 = bottom_fade_end62_g22303;
			float smoothstepResult64_g22302 = smoothstep( 0.0 , 1.0 , (( range69_g22303 >= -0.001 && range69_g22303 <= 0.001 ) ? 0.0 :  (( value64_g22303 >= bottom_fade_start63_g22303 && value64_g22303 <= top_fade_start61_g22303 ) ? 1.0 :  (( value64_g22303 >= top_fade_start61_g22303 && value64_g22303 <= top_fade_end60_g22303 ) ? ( ( value64_g22303 - temp_output_7_0_g22305 ) / ( top_fade_start61_g22303 - temp_output_7_0_g22305 ) ) :  (( value64_g22303 >= bottom_fade_end62_g22303 && value64_g22303 <= bottom_fade_start63_g22303 ) ? ( ( value64_g22303 - temp_output_7_0_g22304 ) / ( bottom_fade_start63_g22303 - temp_output_7_0_g22304 ) ) :  0.0 ) ) ) ));
			float smoothstepResult218_g22288 = smoothstep( 0.0 , 1.0 , saturate( ( _TopCoverFinalStrength * ( smoothstepResult29_g22291 * saturate( saturate( min( min( smoothstepResult64_g22297 , smoothstepResult64_g22307 ) , smoothstepResult64_g22302 ) ) ) ) ) ));
			float topCoverAlpha2274 = (( topCoverColorSum2463 > TopCoverColorLowThreshold2498 ) ? (( topCoverAlphaMask2311 > TopCoverMaskTolerance2456 ) ? (( topCoverAlphaMask2311 < (CalculateContrast(_TopCoverFinalContrast,(saturate( smoothstepResult218_g22288 )).xxxx)).r ) ? 1.0 :  0.0 ) :  coverFadeNoise2771 ) :  0.0 );
			float3 lerpResult12_g22393 = lerp( lerpResult8_g22393 , topCoverNormal700 , topCoverAlpha2274);
			float3 lerpResult9_g22393 = lerp( lerpResult12_g22393 , 0 , 0);
			float TerrainOverlayTriplanarContrast2722 = _TerrainOverlayTriplanarContrast;
			float3 temp_cast_61 = (TerrainOverlayTriplanarContrast2722).xxx;
			float3 temp_output_42_0_g22098 = pow( abs( ase_worldNormal ) , temp_cast_61 );
			float3 break2_g22107 = temp_output_42_0_g22098;
			float3 temp_output_836_0_g22078 = ( temp_output_42_0_g22098 / ( break2_g22107.x + break2_g22107.y + break2_g22107.z ) );
			float3 break141_g22081 = temp_output_836_0_g22078;
			float3 break127_g22081 = abs( ase_worldNormal );
			float3 appendResult123_g22081 = (float3(ase_worldNormal.z , ase_worldNormal.y , break127_g22081.x));
			float3 temp_output_4_0_g22093 = ( appendResult123_g22081 + float3( 0,0,1 ) );
			float3 break6_g22106 = sign( ase_worldNormal );
			float3 appendResult7_g22106 = (float3((( break6_g22106.x < 0.0 ) ? -1.0 :  1.0 ) , (( break6_g22106.y < 0.0 ) ? -1.0 :  1.0 ) , (( break6_g22106.z < 0.0 ) ? -1.0 :  1.0 )));
			float3 temp_output_57_0_g22098 = appendResult7_g22106;
			float3 appendResult53_g22098 = (float3((temp_output_57_0_g22098).xy , ( (temp_output_57_0_g22098).z * -1.0 )));
			float3 axisSigns54_g22098 = appendResult53_g22098;
			float3 temp_output_99_0_g22081 = axisSigns54_g22098;
			float3 break113_g22081 = temp_output_99_0_g22081;
			float2 appendResult116_g22081 = (float2(break113_g22081.x , 1.0));
			float temp_output_74_0_g22098 = 1.0;
			float2 temp_output_1_0_g22099 = (ase_worldPos).zy;
			float terrainOverlay1Scale2195 = ( coverObjectScale1274 + _TerrainOverlay1TextureScale );
			float2 temp_output_31_0_g22098 = (terrainOverlay1Scale2195).xx;
			float2 temp_output_2_0_g22099 = temp_output_31_0_g22098;
			float2 temp_output_30_0_g22098 = float2( 0,0 );
			float3 break89_g22098 = axisSigns54_g22098;
			float2 appendResult6_g22103 = (float2(break89_g22098.x , 1.0));
			float2 temp_output_84_0_g22098 = ( ( (( temp_output_74_0_g22098 > 0.0 ) ? ( temp_output_1_0_g22099 / temp_output_2_0_g22099 ) :  ( temp_output_1_0_g22099 * temp_output_2_0_g22099 ) ) + temp_output_30_0_g22098 ) * appendResult6_g22103 );
			float2 temp_output_833_0_g22078 = temp_output_84_0_g22098;
			float temp_output_142_0_g20909 = positionAsDeterminant712;
			float temp_output_151_0_g20909 = (( temp_output_142_0_g20909 > 0.5 ) ? 100.0 :  1000.0 );
			half localunity_ObjectToWorld0w1_g20910 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g20910 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g20910 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g20910 = (float3(localunity_ObjectToWorld0w1_g20910 , localunity_ObjectToWorld1w2_g20910 , localunity_ObjectToWorld2w3_g20910));
			float3 break144_g20909 = ( (( temp_output_142_0_g20909 > 0.5 ) ? appendResult6_g20910 :  ase_objectScale ) + determinantOffset715 );
			float3 break103_g20909 = determinantMultipliers714;
			float temp_output_222_0_g20909 = round( ( round( ( ( temp_output_151_0_g20909 * break144_g20909.x ) * break103_g20909.x ) ) + round( ( ( temp_output_151_0_g20909 * break144_g20909.y ) * break103_g20909.y ) ) + round( ( ( temp_output_151_0_g20909 * break144_g20909.z ) * break103_g20909.z ) ) ) );
			float simplePerlin3D2752 = snoise( ase_worldPos*_TerrainOverlayNoiseScale );
			simplePerlin3D2752 = simplePerlin3D2752*0.5 + 0.5;
			float terrainOverlayNoise2767 = (-1.0 + (simplePerlin3D2752 - 0.0) * (1.0 - -1.0) / (1.0 - 0.0));
			float4 tex2DNode8_g20886 = tex2D( _TerrainSupplementalShadingMap, ( ( _TerrainMapOffset + ( terrainOverlayNoise2767 + (ase_worldPos).xz ) ) / _TerrainMapSize ) );
			float terrainSplat1928 = round( ( 255.0 * tex2DNode8_g20886.r ) );
			float temp_output_2201_0 = round( terrainSplat1928 );
			float temp_output_2202_0 = fmod( temp_output_2201_0 , 4.0 );
			float temp_output_7_0_g20906 = temp_output_2202_0;
			float lerpResult4_g20906 = lerp( _TerrainOverlayTextureSet1.x , _TerrainOverlayTextureSet1.y , saturate( temp_output_7_0_g20906 ));
			float lerpResult6_g20906 = lerp( lerpResult4_g20906 , _TerrainOverlayTextureSet1.z , step( 2.0 , temp_output_7_0_g20906 ));
			float lerpResult12_g20906 = lerp( lerpResult6_g20906 , _TerrainOverlayTextureSet1.w , step( 3.0 , temp_output_7_0_g20906 ));
			half FOUR16_g20906 = lerpResult12_g20906;
			float temp_output_7_0_g20905 = temp_output_2202_0;
			float lerpResult4_g20905 = lerp( _TerrainOverlayTextureSet2.x , _TerrainOverlayTextureSet2.y , saturate( temp_output_7_0_g20905 ));
			float lerpResult6_g20905 = lerp( lerpResult4_g20905 , _TerrainOverlayTextureSet2.z , step( 2.0 , temp_output_7_0_g20905 ));
			float lerpResult12_g20905 = lerp( lerpResult6_g20905 , _TerrainOverlayTextureSet2.w , step( 3.0 , temp_output_7_0_g20905 ));
			half FOUR16_g20905 = lerpResult12_g20905;
			float temp_output_7_0_g20901 = temp_output_2202_0;
			float lerpResult4_g20901 = lerp( _TerrainOverlayTextureSet3.x , _TerrainOverlayTextureSet3.y , saturate( temp_output_7_0_g20901 ));
			float lerpResult6_g20901 = lerp( lerpResult4_g20901 , _TerrainOverlayTextureSet3.z , step( 2.0 , temp_output_7_0_g20901 ));
			float lerpResult12_g20901 = lerp( lerpResult6_g20901 , _TerrainOverlayTextureSet3.w , step( 3.0 , temp_output_7_0_g20901 ));
			half FOUR16_g20901 = lerpResult12_g20901;
			float temp_output_7_0_g20900 = temp_output_2202_0;
			float lerpResult4_g20900 = lerp( _TerrainOverlayTextureSet4.x , _TerrainOverlayTextureSet4.y , saturate( temp_output_7_0_g20900 ));
			float lerpResult6_g20900 = lerp( lerpResult4_g20900 , _TerrainOverlayTextureSet4.z , step( 2.0 , temp_output_7_0_g20900 ));
			float lerpResult12_g20900 = lerp( lerpResult6_g20900 , _TerrainOverlayTextureSet4.w , step( 3.0 , temp_output_7_0_g20900 ));
			half FOUR16_g20900 = lerpResult12_g20900;
			float temp_output_2210_0 = (( temp_output_2201_0 >= 0.0 && temp_output_2201_0 <= 3.0 ) ? FOUR16_g20906 :  (( temp_output_2201_0 >= 4.0 && temp_output_2201_0 <= 7.0 ) ? FOUR16_g20905 :  (( temp_output_2201_0 >= 8.0 && temp_output_2201_0 <= 11.0 ) ? FOUR16_g20901 :  (( temp_output_2201_0 >= 12.0 && temp_output_2201_0 <= 15.0 ) ? FOUR16_g20900 :  -1.0 ) ) ) );
			float4 appendResult2240 = (float4(temp_output_2210_0 , 0.0 , 0.0 , 0.0));
			float temp_output_175_0_g20909 = ( _GLOBAL_SHADER_SET_INDICES[(int)0.0] - 1.0 );
			float4 appendResult113_g20909 = (float4(temp_output_175_0_g20909 , temp_output_175_0_g20909 , temp_output_175_0_g20909 , temp_output_175_0_g20909));
			float4 clampResult174_g20909 = clamp( appendResult2240 , float4( 0,0,0,0 ) , appendResult113_g20909 );
			float4 texCoords242_g20909 = ( float4( 1,1,1,1 ) + ( clampResult174_g20909 * float4( 2,2,2,2 ) ) );
			float4 break195_g20909 = ( texCoords242_g20909 + float4( 1,1,1,1 ) );
			float4 break32_g20909 = texCoords242_g20909;
			float clampResult197_g20909 = clamp( ( round( fmod( temp_output_222_0_g20909 , _GLOBAL_SHADER_SET_INDICES[(int)break195_g20909.x] ) ) + _GLOBAL_SHADER_SET_INDICES[(int)break32_g20909.x] ) , _GLOBAL_SHADER_SET_INDICES[(int)break32_g20909.x] , ( _GLOBAL_SHADER_SET_INDICES[(int)break32_g20909.x] + -1.0 + _GLOBAL_SHADER_SET_INDICES[(int)break195_g20909.x] ) );
			float2 appendResult104_g20909 = (float2(_GLOBAL_SHADER_SET_INDICES[(int)clampResult197_g20909] , _GLOBAL_SHADER_SET_INDICES[(int)( clampResult197_g20909 + 1.0 )]));
			float textureOverlay1Index2211 = (round( appendResult104_g20909 )).x;
			float temp_output_895_0_g22078 = textureOverlay1Index2211;
			float4 texArray891_g22078 = UNITY_SAMPLE_TEX2DARRAY(_CoverNormSAOArray, float3(temp_output_833_0_g22078, temp_output_895_0_g22078)  );
			float4 unpaciked14_g22079 = (texArray891_g22078).garb;
			float2 temp_cast_67 = (1.0).xx;
			float3 appendResult117_g22081 = (float3(( appendResult116_g22081 * ( ( (unpaciked14_g22079).xy * 2.0 ) - temp_cast_67 ) ) , 1.0));
			float3 temp_output_7_0_g22093 = ( appendResult117_g22081 * float3( -1,0,0 ) );
			float dotResult9_g22093 = dot( temp_output_4_0_g22093 , temp_output_7_0_g22093 );
			float3 axisSigns133_g22081 = temp_output_99_0_g22081;
			float3 break135_g22081 = axisSigns133_g22081;
			float3 appendResult6_g22082 = (float3(1.0 , 1.0 , break135_g22081.x));
			float3 appendResult128_g22081 = (float3(ase_worldNormal.x , ase_worldNormal.z , break127_g22081.y));
			float3 temp_output_4_0_g22086 = ( appendResult128_g22081 + float3( 0,0,1 ) );
			float2 appendResult115_g22081 = (float2(break113_g22081.y , 1.0));
			float2 temp_output_1_0_g22102 = (ase_worldPos).xz;
			float2 temp_output_2_0_g22102 = temp_output_31_0_g22098;
			float2 appendResult6_g22100 = (float2(break89_g22098.y , 1.0));
			float2 temp_output_87_0_g22098 = ( ( (( temp_output_74_0_g22098 > 0.0 ) ? ( temp_output_1_0_g22102 / temp_output_2_0_g22102 ) :  ( temp_output_1_0_g22102 * temp_output_2_0_g22102 ) ) + ( temp_output_30_0_g22098 + ( 0.0 * _Vector0 ) ) ) * appendResult6_g22100 );
			float2 temp_output_834_0_g22078 = temp_output_87_0_g22098;
			float4 texArray890_g22078 = UNITY_SAMPLE_TEX2DARRAY(_CoverNormSAOArray, float3(temp_output_834_0_g22078, temp_output_895_0_g22078)  );
			float4 unpaciked14_g22096 = (texArray890_g22078).garb;
			float2 temp_cast_68 = (1.0).xx;
			float3 appendResult120_g22081 = (float3(( appendResult115_g22081 * ( ( (unpaciked14_g22096).xy * 2.0 ) - temp_cast_68 ) ) , 1.0));
			float3 temp_output_7_0_g22086 = ( appendResult120_g22081 * float3( -1,0,0 ) );
			float dotResult9_g22086 = dot( temp_output_4_0_g22086 , temp_output_7_0_g22086 );
			float3 appendResult6_g22084 = (float3(1.0 , 1.0 , break135_g22081.y));
			float3 appendResult129_g22081 = (float3(ase_worldNormal.x , ase_worldNormal.y , break127_g22081.z));
			float3 temp_output_4_0_g22088 = ( appendResult129_g22081 + float3( 0,0,1 ) );
			float2 appendResult114_g22081 = (float2(break113_g22081.z , 1.0));
			float2 temp_output_1_0_g22108 = (ase_worldPos).xy;
			float2 temp_output_2_0_g22108 = temp_output_31_0_g22098;
			float2 appendResult6_g22104 = (float2(break89_g22098.z , 1.0));
			float2 temp_output_88_0_g22098 = ( ( (( temp_output_74_0_g22098 > 0.0 ) ? ( temp_output_1_0_g22108 / temp_output_2_0_g22108 ) :  ( temp_output_1_0_g22108 * temp_output_2_0_g22108 ) ) + ( temp_output_30_0_g22098 + ( 0.0 * _Vector0 * 2.0 ) ) ) * appendResult6_g22104 );
			float2 temp_output_832_0_g22078 = temp_output_88_0_g22098;
			float4 texArray889_g22078 = UNITY_SAMPLE_TEX2DARRAY(_CoverNormSAOArray, float3(temp_output_832_0_g22078, temp_output_895_0_g22078)  );
			float4 unpaciked14_g22080 = (texArray889_g22078).garb;
			float2 temp_cast_69 = (1.0).xx;
			float3 appendResult121_g22081 = (float3(( appendResult114_g22081 * ( ( (unpaciked14_g22080).xy * 2.0 ) - temp_cast_69 ) ) , 1.0));
			float3 temp_output_7_0_g22088 = ( appendResult121_g22081 * float3( -1,0,0 ) );
			float dotResult9_g22088 = dot( temp_output_4_0_g22088 , temp_output_7_0_g22088 );
			float3 appendResult6_g22083 = (float3(1.0 , 1.0 , ( break135_g22081.z * -1.0 )));
			float2 temp_output_2_0_g22095 = mul( float3x3((WorldNormalVector( i , float3(1,0,0) )), (WorldNormalVector( i , float3(0,1,0) )), (WorldNormalVector( i , float3(0,0,1) ))), ( ( break141_g22081.x * (( ( ( ( temp_output_4_0_g22093 * dotResult9_g22093 ) / (temp_output_4_0_g22093).z ) - temp_output_7_0_g22093 ) * appendResult6_g22082 )).zyx ) + ( break141_g22081.y * (( ( ( ( temp_output_4_0_g22086 * dotResult9_g22086 ) / (temp_output_4_0_g22086).z ) - temp_output_7_0_g22086 ) * appendResult6_g22084 )).xzy ) + ( break141_g22081.z * (( ( ( ( temp_output_4_0_g22088 * dotResult9_g22088 ) / (temp_output_4_0_g22088).z ) - temp_output_7_0_g22088 ) * appendResult6_g22083 )).xyz ) ) ).xy;
			float dotResult42_g22095 = dot( temp_output_2_0_g22095 , temp_output_2_0_g22095 );
			float3 appendResult38_g22095 = (float3(temp_output_2_0_g22095 , sqrt( ( 1.0 - saturate( dotResult42_g22095 ) ) )));
			float3 normalizeResult39_g22095 = normalize( appendResult38_g22095 );
			float3 temp_output_2_0_g22390 = normalizeResult39_g22095;
			float3 temp_output_36_0_g22390 = ( _TerrainOverlayNormalScale * temp_output_2_0_g22390 );
			float3 appendResult38_g22390 = (float3(temp_output_36_0_g22390.xy , (temp_output_2_0_g22390).z));
			float2 temp_output_2_0_g22392 = temp_output_36_0_g22390.xy;
			float dotResult42_g22392 = dot( temp_output_2_0_g22392 , temp_output_2_0_g22392 );
			float3 appendResult38_g22392 = (float3(temp_output_2_0_g22392 , sqrt( ( 1.0 - saturate( dotResult42_g22392 ) ) )));
			float3 normalizeResult39_g22392 = normalize( appendResult38_g22392 );
			float2 break30_g22391 = temp_output_36_0_g22390.xy;
			float3 appendResult38_g22391 = (float3(break30_g22391.x , break30_g22391.y , sqrt( ( 1.0 - ( ( break30_g22391.x * break30_g22391.x ) + ( break30_g22391.y * break30_g22391.y ) ) ) )));
			float3 normalizeResult39_g22391 = normalize( appendResult38_g22391 );
			float3 terrainOverlay1Normal770 = (( normalZReconstructionStyle2681 < 1.0 ) ? appendResult38_g22390 :  (( 2.0 > 0.0 ) ? normalizeResult39_g22392 :  normalizeResult39_g22391 ) );
			float noTerrainOverlay12562 = (( temp_output_2210_0 < 0.0 ) ? 0.0 :  1.0 );
			float temp_output_896_0_g22078 = textureOverlay1Index2211;
			float4 texArray894_g22078 = UNITY_SAMPLE_TEX2DARRAY(_CoverBaseColorArray, float3(temp_output_833_0_g22078, temp_output_896_0_g22078)  );
			float4 texArray893_g22078 = UNITY_SAMPLE_TEX2DARRAY(_CoverBaseColorArray, float3(temp_output_834_0_g22078, temp_output_896_0_g22078)  );
			float4 texArray892_g22078 = UNITY_SAMPLE_TEX2DARRAY(_CoverBaseColorArray, float3(temp_output_832_0_g22078, temp_output_896_0_g22078)  );
			float3 weightedBlendVar840_g22078 = temp_output_836_0_g22078;
			float4 weightedAvg840_g22078 = ( ( weightedBlendVar840_g22078.x*texArray894_g22078 + weightedBlendVar840_g22078.y*texArray893_g22078 + weightedBlendVar840_g22078.z*texArray892_g22078 )/( weightedBlendVar840_g22078.x + weightedBlendVar840_g22078.y + weightedBlendVar840_g22078.z ) );
			float4 temp_output_2664_899 = weightedAvg840_g22078;
			float3 hsvTorgb427_g22110 = RGBToHSV( temp_output_2664_899.rgb );
			float3 hsvTorgb428_g22110 = HSVToRGB( float3(( 0.0 + hsvTorgb427_g22110.x ),( _TerrainOverlaySaturationMultiplier * hsvTorgb427_g22110.y ),( _TerrainOverlayValueMultiplier * hsvTorgb427_g22110.z )) );
			float4 lerpResult2986 = lerp( CalculateContrast(_TerrainOverlayContrast,float4( hsvTorgb428_g22110 , 0.0 )) , mainBaseColor789 , _TerrainOverlayAlbedoMatch);
			float4 terrainOverlay1BaseColor773 = lerpResult2986;
			float3 break2_g22262 = terrainOverlay1BaseColor773.rgb;
			float terrainOverlay1ColorSum2465 = ( break2_g22262.x + break2_g22262.y + break2_g22262.z );
			float TerarinCoverColorLowThreshold2726 = _TerarinCoverColorLowThreshold;
			float terrainOverlay1AlphaMask2313 = (temp_output_2664_899).a;
			float TerrainOverlayCoverMaskTolerance2724 = _TerrainOverlayCoverMaskTolerance;
			float boundsYObjectSpace270_g22213 = ( ase_objectScale.y * i.ase_texcoord5.y );
			float temp_output_303_0_g22213 = terrainHeight1480;
			half localunity_ObjectToWorld1w2_g22214 = ( unity_ObjectToWorld[1].w );
			float temp_output_299_0_g22213 = ( ( ase_objectScale.y * i.ase_texcoord4.y ) + localunity_ObjectToWorld1w2_g22214 );
			float temp_output_266_0_g22213 = ( boundsYObjectSpace270_g22213 / 2.0 );
			float bottomYWorldSpace274_g22213 = (( temp_output_303_0_g22213 < -100.0 ) ? ( temp_output_299_0_g22213 - temp_output_266_0_g22213 ) :  temp_output_303_0_g22213 );
			float topYWorldSpace276_g22213 = ( temp_output_299_0_g22213 + temp_output_266_0_g22213 );
			float clampResult304_g22213 = clamp( ase_worldPos.y , bottomYWorldSpace274_g22213 , topYWorldSpace276_g22213 );
			float temp_output_7_0_g22215 = bottomYWorldSpace274_g22213;
			float yTime278_g22213 = ( ( clampResult304_g22213 - temp_output_7_0_g22215 ) / ( topYWorldSpace276_g22213 - temp_output_7_0_g22215 ) );
			float temp_output_24_0_g22217 = ( boundsYObjectSpace270_g22213 * yTime278_g22213 );
			float clampResult253_g22213 = clamp( ( boundsYObjectSpace270_g22213 * _TerrainOverlay1TargetPercentage ) , _TerrainOverlay1MinimumVerticalRange , _TerrainOverlay1MaximumVerticalRange );
			float temp_output_21_0_g22217 = clampResult253_g22213;
			float temp_output_31_0_g22217 = ( temp_output_21_0_g22217 + min( clampResult253_g22213 , ( abs( temp_output_21_0_g22217 ) * _TerrainOverlay1FadePercentage ) ) );
			float temp_output_7_0_g22219 = temp_output_31_0_g22217;
			float smoothstepResult29_g22216 = smoothstep( 0.0 , 1.0 , (( temp_output_24_0_g22217 < temp_output_21_0_g22217 ) ? 1.0 :  (( temp_output_24_0_g22217 < temp_output_31_0_g22217 ) ? ( ( temp_output_24_0_g22217 - temp_output_7_0_g22219 ) / ( temp_output_21_0_g22217 - temp_output_7_0_g22219 ) ) :  0.0 ) ));
			float3 lerpResult311_g22213 = lerp( _TerrainOverlay1BaseCoverageRange , _TerrainOverlay1PeakCoverageRange , yTime278_g22213);
			float3 break14_g22221 = lerpResult311_g22213;
			float temp_output_28_0_g22221 = saturate( break14_g22221.x );
			float temp_output_6_0_g22223 = temp_output_28_0_g22221;
			float range69_g22223 = temp_output_6_0_g22223;
			float3 lerpResult2927 = lerp( float3( 0,0,1 ) , mainNormal786 , _TerrainOverlay1AreaNormalStrength);
			float3 break6_g22221 = (WorldNormalVector( i , lerpResult2927 ));
			float value64_g22223 = break6_g22221.x;
			float3 break18_g22221 = _TerrainOverlay1CoverageBasis;
			float clampResult31_g22221 = clamp( break18_g22221.x , -1.0 , 1.0 );
			float temp_output_42_0_g22223 = clampResult31_g22221;
			float temp_output_47_0_g22223 = ( temp_output_42_0_g22223 - temp_output_6_0_g22223 );
			float bottom_fade_start63_g22223 = temp_output_47_0_g22223;
			float temp_output_45_0_g22223 = ( temp_output_42_0_g22223 + temp_output_6_0_g22223 );
			float top_fade_start61_g22223 = temp_output_45_0_g22223;
			float temp_output_17_0_g22221 = saturate( _TerrainOverlay1FadeSmoothness );
			float temp_output_36_0_g22223 = ( temp_output_28_0_g22221 * temp_output_17_0_g22221 );
			float top_fade_end60_g22223 = ( temp_output_45_0_g22223 + temp_output_36_0_g22223 );
			float temp_output_7_0_g22225 = top_fade_end60_g22223;
			float bottom_fade_end62_g22223 = ( temp_output_47_0_g22223 - temp_output_36_0_g22223 );
			float temp_output_7_0_g22224 = bottom_fade_end62_g22223;
			float smoothstepResult64_g22222 = smoothstep( 0.0 , 1.0 , (( range69_g22223 >= -0.001 && range69_g22223 <= 0.001 ) ? 0.0 :  (( value64_g22223 >= bottom_fade_start63_g22223 && value64_g22223 <= top_fade_start61_g22223 ) ? 1.0 :  (( value64_g22223 >= top_fade_start61_g22223 && value64_g22223 <= top_fade_end60_g22223 ) ? ( ( value64_g22223 - temp_output_7_0_g22225 ) / ( top_fade_start61_g22223 - temp_output_7_0_g22225 ) ) :  (( value64_g22223 >= bottom_fade_end62_g22223 && value64_g22223 <= bottom_fade_start63_g22223 ) ? ( ( value64_g22223 - temp_output_7_0_g22224 ) / ( bottom_fade_start63_g22223 - temp_output_7_0_g22224 ) ) :  0.0 ) ) ) ));
			float temp_output_29_0_g22221 = saturate( break14_g22221.y );
			float temp_output_6_0_g22233 = temp_output_29_0_g22221;
			float range69_g22233 = temp_output_6_0_g22233;
			float value64_g22233 = break6_g22221.y;
			float clampResult32_g22221 = clamp( break18_g22221.y , -1.0 , 1.0 );
			float temp_output_42_0_g22233 = clampResult32_g22221;
			float temp_output_47_0_g22233 = ( temp_output_42_0_g22233 - temp_output_6_0_g22233 );
			float bottom_fade_start63_g22233 = temp_output_47_0_g22233;
			float temp_output_45_0_g22233 = ( temp_output_42_0_g22233 + temp_output_6_0_g22233 );
			float top_fade_start61_g22233 = temp_output_45_0_g22233;
			float temp_output_36_0_g22233 = ( temp_output_29_0_g22221 * temp_output_17_0_g22221 );
			float top_fade_end60_g22233 = ( temp_output_45_0_g22233 + temp_output_36_0_g22233 );
			float temp_output_7_0_g22235 = top_fade_end60_g22233;
			float bottom_fade_end62_g22233 = ( temp_output_47_0_g22233 - temp_output_36_0_g22233 );
			float temp_output_7_0_g22234 = bottom_fade_end62_g22233;
			float smoothstepResult64_g22232 = smoothstep( 0.0 , 1.0 , (( range69_g22233 >= -0.001 && range69_g22233 <= 0.001 ) ? 0.0 :  (( value64_g22233 >= bottom_fade_start63_g22233 && value64_g22233 <= top_fade_start61_g22233 ) ? 1.0 :  (( value64_g22233 >= top_fade_start61_g22233 && value64_g22233 <= top_fade_end60_g22233 ) ? ( ( value64_g22233 - temp_output_7_0_g22235 ) / ( top_fade_start61_g22233 - temp_output_7_0_g22235 ) ) :  (( value64_g22233 >= bottom_fade_end62_g22233 && value64_g22233 <= bottom_fade_start63_g22233 ) ? ( ( value64_g22233 - temp_output_7_0_g22234 ) / ( bottom_fade_start63_g22233 - temp_output_7_0_g22234 ) ) :  0.0 ) ) ) ));
			float temp_output_30_0_g22221 = saturate( break14_g22221.z );
			float temp_output_6_0_g22228 = temp_output_30_0_g22221;
			float range69_g22228 = temp_output_6_0_g22228;
			float value64_g22228 = break6_g22221.z;
			float clampResult33_g22221 = clamp( break18_g22221.z , -1.0 , 1.0 );
			float temp_output_42_0_g22228 = clampResult33_g22221;
			float temp_output_47_0_g22228 = ( temp_output_42_0_g22228 - temp_output_6_0_g22228 );
			float bottom_fade_start63_g22228 = temp_output_47_0_g22228;
			float temp_output_45_0_g22228 = ( temp_output_42_0_g22228 + temp_output_6_0_g22228 );
			float top_fade_start61_g22228 = temp_output_45_0_g22228;
			float temp_output_36_0_g22228 = ( temp_output_30_0_g22221 * temp_output_17_0_g22221 );
			float top_fade_end60_g22228 = ( temp_output_45_0_g22228 + temp_output_36_0_g22228 );
			float temp_output_7_0_g22230 = top_fade_end60_g22228;
			float bottom_fade_end62_g22228 = ( temp_output_47_0_g22228 - temp_output_36_0_g22228 );
			float temp_output_7_0_g22229 = bottom_fade_end62_g22228;
			float smoothstepResult64_g22227 = smoothstep( 0.0 , 1.0 , (( range69_g22228 >= -0.001 && range69_g22228 <= 0.001 ) ? 0.0 :  (( value64_g22228 >= bottom_fade_start63_g22228 && value64_g22228 <= top_fade_start61_g22228 ) ? 1.0 :  (( value64_g22228 >= top_fade_start61_g22228 && value64_g22228 <= top_fade_end60_g22228 ) ? ( ( value64_g22228 - temp_output_7_0_g22230 ) / ( top_fade_start61_g22228 - temp_output_7_0_g22230 ) ) :  (( value64_g22228 >= bottom_fade_end62_g22228 && value64_g22228 <= bottom_fade_start63_g22228 ) ? ( ( value64_g22228 - temp_output_7_0_g22229 ) / ( bottom_fade_start63_g22228 - temp_output_7_0_g22229 ) ) :  0.0 ) ) ) ));
			float smoothstepResult218_g22213 = smoothstep( 0.0 , 1.0 , saturate( ( _TerrainOverlay1FinalStrength * ( smoothstepResult29_g22216 * saturate( saturate( min( min( smoothstepResult64_g22222 , smoothstepResult64_g22232 ) , smoothstepResult64_g22227 ) ) ) ) ) ));
			float terrainOverlay1Alpha2288 = ( noTerrainOverlay12562 * (( textureOverlay1Index2211 < 0.0 ) ? 0.0 :  (( terrainOverlay1ColorSum2465 > TerarinCoverColorLowThreshold2726 ) ? (( terrainOverlay1AlphaMask2313 > TerrainOverlayCoverMaskTolerance2724 ) ? (( terrainOverlay1AlphaMask2313 < (CalculateContrast(_TerrainOverlay1FinalContrast,(saturate( smoothstepResult218_g22213 )).xxxx)).r ) ? 1.0 :  0.0 ) :  coverFadeNoise2771 ) :  0.0 ) ) );
			float3 lerpResult11_g22393 = lerp( lerpResult9_g22393 , terrainOverlay1Normal770 , terrainOverlay1Alpha2288);
			float3 lerpResult10_g22393 = lerp( lerpResult11_g22393 , 0 , 0);
			float3 temp_output_2_0_g22395 = lerpResult10_g22393;
			float3 temp_output_36_0_g22395 = ( _FinalNormalScale * temp_output_2_0_g22395 );
			float3 appendResult38_g22395 = (float3(temp_output_36_0_g22395.xy , (temp_output_2_0_g22395).z));
			float2 temp_output_2_0_g22397 = temp_output_36_0_g22395.xy;
			float dotResult42_g22397 = dot( temp_output_2_0_g22397 , temp_output_2_0_g22397 );
			float3 appendResult38_g22397 = (float3(temp_output_2_0_g22397 , sqrt( ( 1.0 - saturate( dotResult42_g22397 ) ) )));
			float3 normalizeResult39_g22397 = normalize( appendResult38_g22397 );
			float2 break30_g22396 = temp_output_36_0_g22395.xy;
			float3 appendResult38_g22396 = (float3(break30_g22396.x , break30_g22396.y , sqrt( ( 1.0 - ( ( break30_g22396.x * break30_g22396.x ) + ( break30_g22396.y * break30_g22396.y ) ) ) )));
			float3 normalizeResult39_g22396 = normalize( appendResult38_g22396 );
			float3 normalizeResult2077 = normalize( (( normalZReconstructionStyle2681 < 1.0 ) ? appendResult38_g22395 :  (( 2.0 > 0.0 ) ? normalizeResult39_g22397 :  normalizeResult39_g22396 ) ) );
			float3 preDetailNormals2024 = normalizeResult2077;
			float3 temp_cast_81 = (TopCoverTriplanarContrast1057).xxx;
			float3 temp_output_42_0_g22430 = pow( abs( ase_worldNormal ) , temp_cast_81 );
			float3 break2_g22439 = temp_output_42_0_g22430;
			float3 blendWeights69_g22404 = ( temp_output_42_0_g22430 / ( break2_g22439.x + break2_g22439.y + break2_g22439.z ) );
			float3 break141_g22409 = blendWeights69_g22404;
			float3 break127_g22409 = abs( ase_worldNormal );
			float3 appendResult123_g22409 = (float3(ase_worldNormal.z , ase_worldNormal.y , break127_g22409.x));
			float3 temp_output_4_0_g22421 = ( appendResult123_g22409 + float3( 0,0,1 ) );
			float3 break6_g22438 = sign( ase_worldNormal );
			float3 appendResult7_g22438 = (float3((( break6_g22438.x < 0.0 ) ? -1.0 :  1.0 ) , (( break6_g22438.y < 0.0 ) ? -1.0 :  1.0 ) , (( break6_g22438.z < 0.0 ) ? -1.0 :  1.0 )));
			float3 temp_output_57_0_g22430 = appendResult7_g22438;
			float3 appendResult53_g22430 = (float3((temp_output_57_0_g22430).xy , ( (temp_output_57_0_g22430).z * -1.0 )));
			float3 axisSigns54_g22430 = appendResult53_g22430;
			float3 axisSigns99_g22404 = axisSigns54_g22430;
			float3 temp_output_99_0_g22409 = axisSigns99_g22404;
			float3 break113_g22409 = temp_output_99_0_g22409;
			float2 appendResult116_g22409 = (float2(break113_g22409.x , 1.0));
			float temp_output_74_0_g22430 = 1.0;
			float2 temp_output_1_0_g22431 = (ase_worldPos).zy;
			float mainObjectScaleF1378 = _MainObjectScaleFactor;
			float temp_output_1379_0 = ( ( mainObjectScaleF1378 * scaleMultiplier1313 ) + _DetailTiling );
			float2 appendResult588 = (float2(temp_output_1379_0 , temp_output_1379_0));
			float2 textureScale80_g22404 = appendResult588;
			float2 temp_output_31_0_g22430 = textureScale80_g22404;
			float2 temp_output_2_0_g22431 = temp_output_31_0_g22430;
			float2 textureOffset71_g22404 = float2( 0,0 );
			float2 temp_output_30_0_g22430 = textureOffset71_g22404;
			float3 break89_g22430 = axisSigns54_g22430;
			float2 appendResult6_g22435 = (float2(break89_g22430.x , 1.0));
			float2 temp_output_84_0_g22430 = ( ( (( temp_output_74_0_g22430 > 0.0 ) ? ( temp_output_1_0_g22431 / temp_output_2_0_g22431 ) :  ( temp_output_1_0_g22431 * temp_output_2_0_g22431 ) ) + temp_output_30_0_g22430 ) * appendResult6_g22435 );
			float2 temp_output_149_0_g22404 = temp_output_84_0_g22430;
			float4 unpaciked14_g22408 = (tex2D( _DetailNormalArray, temp_output_149_0_g22404 )).garb;
			float2 temp_cast_82 = (1.0).xx;
			float3 appendResult117_g22409 = (float3(( appendResult116_g22409 * ( ( (unpaciked14_g22408).xy * 2.0 ) - temp_cast_82 ) ) , 1.0));
			float3 temp_output_7_0_g22421 = ( appendResult117_g22409 * float3( -1,0,0 ) );
			float dotResult9_g22421 = dot( temp_output_4_0_g22421 , temp_output_7_0_g22421 );
			float3 axisSigns133_g22409 = temp_output_99_0_g22409;
			float3 break135_g22409 = axisSigns133_g22409;
			float3 appendResult6_g22410 = (float3(1.0 , 1.0 , break135_g22409.x));
			float3 appendResult128_g22409 = (float3(ase_worldNormal.x , ase_worldNormal.z , break127_g22409.y));
			float3 temp_output_4_0_g22414 = ( appendResult128_g22409 + float3( 0,0,1 ) );
			float2 appendResult115_g22409 = (float2(break113_g22409.y , 1.0));
			float2 temp_output_1_0_g22434 = (ase_worldPos).xz;
			float2 temp_output_2_0_g22434 = temp_output_31_0_g22430;
			float2 appendResult6_g22432 = (float2(break89_g22430.y , 1.0));
			float2 temp_output_87_0_g22430 = ( ( (( temp_output_74_0_g22430 > 0.0 ) ? ( temp_output_1_0_g22434 / temp_output_2_0_g22434 ) :  ( temp_output_1_0_g22434 * temp_output_2_0_g22434 ) ) + ( temp_output_30_0_g22430 + ( 0.0 * _Vector0 ) ) ) * appendResult6_g22432 );
			float2 temp_output_149_20_g22404 = temp_output_87_0_g22430;
			float4 unpaciked14_g22406 = (tex2D( _DetailNormalArray, temp_output_149_20_g22404 )).garb;
			float2 temp_cast_83 = (1.0).xx;
			float3 appendResult120_g22409 = (float3(( appendResult115_g22409 * ( ( (unpaciked14_g22406).xy * 2.0 ) - temp_cast_83 ) ) , 1.0));
			float3 temp_output_7_0_g22414 = ( appendResult120_g22409 * float3( -1,0,0 ) );
			float dotResult9_g22414 = dot( temp_output_4_0_g22414 , temp_output_7_0_g22414 );
			float3 appendResult6_g22412 = (float3(1.0 , 1.0 , break135_g22409.y));
			float3 appendResult129_g22409 = (float3(ase_worldNormal.x , ase_worldNormal.y , break127_g22409.z));
			float3 temp_output_4_0_g22416 = ( appendResult129_g22409 + float3( 0,0,1 ) );
			float2 appendResult114_g22409 = (float2(break113_g22409.z , 1.0));
			float2 temp_output_1_0_g22440 = (ase_worldPos).xy;
			float2 temp_output_2_0_g22440 = temp_output_31_0_g22430;
			float2 appendResult6_g22436 = (float2(break89_g22430.z , 1.0));
			float2 temp_output_88_0_g22430 = ( ( (( temp_output_74_0_g22430 > 0.0 ) ? ( temp_output_1_0_g22440 / temp_output_2_0_g22440 ) :  ( temp_output_1_0_g22440 * temp_output_2_0_g22440 ) ) + ( temp_output_30_0_g22430 + ( 0.0 * _Vector0 * 2.0 ) ) ) * appendResult6_g22436 );
			float2 temp_output_149_21_g22404 = temp_output_88_0_g22430;
			float4 unpaciked14_g22425 = (tex2D( _DetailNormalArray, temp_output_149_21_g22404 )).garb;
			float2 temp_cast_84 = (1.0).xx;
			float3 appendResult121_g22409 = (float3(( appendResult114_g22409 * ( ( (unpaciked14_g22425).xy * 2.0 ) - temp_cast_84 ) ) , 1.0));
			float3 temp_output_7_0_g22416 = ( appendResult121_g22409 * float3( -1,0,0 ) );
			float dotResult9_g22416 = dot( temp_output_4_0_g22416 , temp_output_7_0_g22416 );
			float3 appendResult6_g22411 = (float3(1.0 , 1.0 , ( break135_g22409.z * -1.0 )));
			float2 temp_output_2_0_g22423 = mul( float3x3((WorldNormalVector( i , float3(1,0,0) )), (WorldNormalVector( i , float3(0,1,0) )), (WorldNormalVector( i , float3(0,0,1) ))), ( ( break141_g22409.x * (( ( ( ( temp_output_4_0_g22421 * dotResult9_g22421 ) / (temp_output_4_0_g22421).z ) - temp_output_7_0_g22421 ) * appendResult6_g22410 )).zyx ) + ( break141_g22409.y * (( ( ( ( temp_output_4_0_g22414 * dotResult9_g22414 ) / (temp_output_4_0_g22414).z ) - temp_output_7_0_g22414 ) * appendResult6_g22412 )).xzy ) + ( break141_g22409.z * (( ( ( ( temp_output_4_0_g22416 * dotResult9_g22416 ) / (temp_output_4_0_g22416).z ) - temp_output_7_0_g22416 ) * appendResult6_g22411 )).xyz ) ) ).xy;
			float dotResult42_g22423 = dot( temp_output_2_0_g22423 , temp_output_2_0_g22423 );
			float3 appendResult38_g22423 = (float3(temp_output_2_0_g22423 , sqrt( ( 1.0 - saturate( dotResult42_g22423 ) ) )));
			float3 normalizeResult39_g22423 = normalize( appendResult38_g22423 );
			float3 temp_output_172_105_g22399 = normalizeResult39_g22423;
			float3 temp_output_2_0_g22443 = temp_output_172_105_g22399;
			float3 temp_output_36_0_g22443 = ( _DetailNormalScale * temp_output_2_0_g22443 );
			float3 appendResult38_g22443 = (float3(temp_output_36_0_g22443.xy , (temp_output_2_0_g22443).z));
			float2 temp_output_2_0_g22445 = temp_output_36_0_g22443.xy;
			float dotResult42_g22445 = dot( temp_output_2_0_g22445 , temp_output_2_0_g22445 );
			float3 appendResult38_g22445 = (float3(temp_output_2_0_g22445 , sqrt( ( 1.0 - saturate( dotResult42_g22445 ) ) )));
			float3 normalizeResult39_g22445 = normalize( appendResult38_g22445 );
			float2 break30_g22444 = temp_output_36_0_g22443.xy;
			float3 appendResult38_g22444 = (float3(break30_g22444.x , break30_g22444.y , sqrt( ( 1.0 - ( ( break30_g22444.x * break30_g22444.x ) + ( break30_g22444.y * break30_g22444.y ) ) ) )));
			float3 normalizeResult39_g22444 = normalize( appendResult38_g22444 );
			float3 normalizeResult171_g22399 = normalize( (( normalZReconstructionStyle2681 < 1.0 ) ? appendResult38_g22443 :  (( 2.0 > 0.0 ) ? normalizeResult39_g22445 :  normalizeResult39_g22444 ) ) );
			float3 postDetailNormal886 = BlendNormals( preDetailNormals2024 , normalizeResult171_g22399 );
			float distance22_g22398 = distance( ase_worldPos , _WorldSpaceCameraPos );
			float temp_output_14_0_g22398 = _DetailViewFadeStart;
			float temp_output_11_0_g22398 = _DetailViewFadeDistance;
			float fadeEnd20_g22398 = ( temp_output_14_0_g22398 + temp_output_11_0_g22398 );
			float fadeStart19_g22398 = temp_output_14_0_g22398;
			float fadeLength23_g22398 = temp_output_11_0_g22398;
			float detailFadeAlpha938 = saturate( ( _FinalDetailMultiplier * saturate( (( distance22_g22398 > fadeEnd20_g22398 ) ? 0.0 :  (( distance22_g22398 < fadeStart19_g22398 ) ? 1.0 :  ( 1.0 - ( ( distance22_g22398 - fadeStart19_g22398 ) / fadeLength23_g22398 ) ) ) ) ) ) );
			float3 lerpResult2006 = lerp( preDetailNormals2024 , postDetailNormal886 , detailFadeAlpha938);
			float3 finalNormal962 = lerpResult2006;
			o.Normal = finalNormal962;
			float4 lerpResult7_g22394 = lerp( mainBaseColor789 , bottomCoverBaseColor2160 , bottomCoverAlpha851);
			float middleCoverBaseColorIndex2244 = break744.x;
			float temp_output_896_0_g22113 = middleCoverBaseColorIndex2244;
			float4 texArray894_g22113 = UNITY_SAMPLE_TEX2DARRAY(_CoverBaseColorArray, float3(temp_output_833_0_g22113, temp_output_896_0_g22113)  );
			float4 texArray893_g22113 = UNITY_SAMPLE_TEX2DARRAY(_CoverBaseColorArray, float3(temp_output_834_0_g22113, temp_output_896_0_g22113)  );
			float4 texArray892_g22113 = UNITY_SAMPLE_TEX2DARRAY(_CoverBaseColorArray, float3(temp_output_832_0_g22113, temp_output_896_0_g22113)  );
			float3 weightedBlendVar840_g22113 = temp_output_836_0_g22113;
			float4 weightedAvg840_g22113 = ( ( weightedBlendVar840_g22113.x*texArray894_g22113 + weightedBlendVar840_g22113.y*texArray893_g22113 + weightedBlendVar840_g22113.z*texArray892_g22113 )/( weightedBlendVar840_g22113.x + weightedBlendVar840_g22113.y + weightedBlendVar840_g22113.z ) );
			float3 hsvTorgb427_g22212 = RGBToHSV( weightedAvg840_g22113.rgb );
			float3 hsvTorgb428_g22212 = HSVToRGB( float3(( 0.0 + hsvTorgb427_g22212.x ),( _MiddleCoverSaturationMultiplier * hsvTorgb427_g22212.y ),( _MiddleCoverValueMultiplier * hsvTorgb427_g22212.z )) );
			float4 lerpResult2992 = lerp( CalculateContrast(_MiddleCoverContrast,float4( hsvTorgb428_g22212 , 0.0 )) , mainBaseColor789 , _MiddleCoverAlbedoMatch);
			float4 middleCoverBaseColor2145 = lerpResult2992;
			float4 lerpResult8_g22394 = lerp( lerpResult7_g22394 , middleCoverBaseColor2145 , 0);
			float4 lerpResult12_g22394 = lerp( lerpResult8_g22394 , topCoverBaseColor702 , topCoverAlpha2274);
			float4 lerpResult9_g22394 = lerp( lerpResult12_g22394 , 0 , 0);
			float4 lerpResult11_g22394 = lerp( lerpResult9_g22394 , terrainOverlay1BaseColor773 , terrainOverlay1Alpha2288);
			float4 lerpResult10_g22394 = lerp( lerpResult11_g22394 , 0 , 0);
			float4 lerpResult2553 = lerp( lerpResult10_g22394 , mainBaseColor789 , _FinalAlbedoMatch);
			float4 preDetailBaseColor2025 = lerpResult2553;
			float4 color210_g22399 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
			float3 break212_g22399 = ( ( temp_output_172_105_g22399 * 0.5 ) + 0.5 );
			float4 temp_output_204_0_g22399 = saturate( CalculateContrast(_DetailContrast,(min( min( break212_g22399.x , break212_g22399.y ) , break212_g22399.z )).xxxx) );
			float clampResult115_g22399 = clamp( _DetailBaseColorStrength , 1E-05 , 1.0 );
			float4 lerpResult207_g22399 = lerp( color210_g22399 , (( _InvertDetails > 0.0 ) ? ( 1.0 - temp_output_204_0_g22399 ) :  temp_output_204_0_g22399 ) , clampResult115_g22399);
			float temp_output_9_0_g22401 = color210_g22399.r;
			float temp_output_18_0_g22401 = ( 1.0 - temp_output_9_0_g22401 );
			float3 appendResult16_g22401 = (float3(temp_output_18_0_g22401 , temp_output_18_0_g22401 , temp_output_18_0_g22401));
			float3 postDetailBaseColor885 = ( preDetailBaseColor2025.rgb * ( ( ( lerpResult207_g22399.rgb * (unity_ColorSpaceDouble).rgb ) * temp_output_9_0_g22401 ) + appendResult16_g22401 ) );
			float4 lerpResult939 = lerp( preDetailBaseColor2025 , float4( postDetailBaseColor885 , 0.0 ) , detailFadeAlpha938);
			float4 postFadeBaseColor943 = lerpResult939;
			float3 hsvTorgb427_g22447 = RGBToHSV( postFadeBaseColor943.rgb );
			float3 hsvTorgb428_g22447 = HSVToRGB( float3(( 0.0 + hsvTorgb427_g22447.x ),( _FinalSaturationMultiplier * hsvTorgb427_g22447.y ),( _FinalValueMultiplier * hsvTorgb427_g22447.z )) );
			float4 preWetnessAlbedo959 = CalculateContrast(_FinalColorContrast,float4( hsvTorgb428_g22447 , 0.0 ));
			float totalCoverAlpha2584 = saturate( ( bottomCoverAlpha851 + 0 + topCoverAlpha2274 + 0 + terrainOverlay1Alpha2288 + 0 ) );
			float lerpResult2702 = lerp( _WaterDarkeningPower , ( _WaterDarkeningPower * _CoverWaterDarknessModifier ) , totalCoverAlpha2584);
			float darkeningPower82_g22452 = ( 1.0 - lerpResult2702 );
			float3 weightedBlendVar854_g20912 = temp_output_836_0_g20912;
			float weightedBlend854_g20912 = ( weightedBlendVar854_g20912.x*(unpaciked14_g20913).z + weightedBlendVar854_g20912.y*(unpaciked14_g20930).z + weightedBlendVar854_g20912.z*(unpaciked14_g20914).z );
			float mainSmoothness1417 = weightedBlend854_g20912;
			float3 weightedBlendVar854_g22178 = temp_output_836_0_g22178;
			float weightedBlend854_g22178 = ( weightedBlendVar854_g22178.x*(unpaciked14_g22179).z + weightedBlendVar854_g22178.y*(unpaciked14_g22196).z + weightedBlendVar854_g22178.z*(unpaciked14_g22180).z );
			float bottomCoverSmoothness2164 = weightedBlend854_g22178;
			float lerpResult7_g22450 = lerp( mainSmoothness1417 , bottomCoverSmoothness2164 , bottomCoverAlpha851);
			float3 weightedBlendVar854_g22113 = temp_output_836_0_g22113;
			float weightedBlend854_g22113 = ( weightedBlendVar854_g22113.x*(unpaciked14_g22114).z + weightedBlendVar854_g22113.y*(unpaciked14_g22131).z + weightedBlendVar854_g22113.z*(unpaciked14_g22115).z );
			float middleCoverSmoothness2149 = weightedBlend854_g22113;
			float lerpResult8_g22450 = lerp( lerpResult7_g22450 , middleCoverSmoothness2149 , 0);
			float3 weightedBlendVar854_g22145 = temp_output_836_0_g22145;
			float weightedBlend854_g22145 = ( weightedBlendVar854_g22145.x*(unpaciked14_g22146).z + weightedBlendVar854_g22145.y*(unpaciked14_g22163).z + weightedBlendVar854_g22145.z*(unpaciked14_g22147).z );
			float topCoverSmoothness1401 = weightedBlend854_g22145;
			float lerpResult12_g22450 = lerp( lerpResult8_g22450 , topCoverSmoothness1401 , topCoverAlpha2274);
			float lerpResult9_g22450 = lerp( lerpResult12_g22450 , 0 , 0);
			float3 weightedBlendVar854_g22078 = temp_output_836_0_g22078;
			float weightedBlend854_g22078 = ( weightedBlendVar854_g22078.x*(unpaciked14_g22079).z + weightedBlendVar854_g22078.y*(unpaciked14_g22096).z + weightedBlendVar854_g22078.z*(unpaciked14_g22080).z );
			float terrainOverlay1Smoothness1414 = weightedBlend854_g22078;
			float lerpResult11_g22450 = lerp( lerpResult9_g22450 , terrainOverlay1Smoothness1414 , terrainOverlay1Alpha2288);
			float lerpResult10_g22450 = lerp( lerpResult11_g22450 , 0 , 0);
			float postFadeSmoothness951 = lerpResult10_g22450;
			float temp_output_10_0_g22452 = postFadeSmoothness951;
			float lerpResult2587 = lerp( _SurfacePorosity , _CoverSurfacePorosity , totalCoverAlpha2584);
			float porosity31_g22452 = saturate( ( ( ( 1.0 - temp_output_10_0_g22452 ) - 0.5 ) / max( lerpResult2587 , 0.001 ) ) );
			float lerpResult18_g22452 = lerp( 1.0 , darkeningPower82_g22452 , ( ( 1.0 - 0.0 ) * porosity31_g22452 ));
			float darkeningFactor34_g22452 = lerpResult18_g22452;
			float4 tex2DNode8_g22451 = tex2D( _TerrainWetnessData, ( ( _TerrainMapOffset + ( ( _WetnessTerrainNoiseStrength * terrainOverlayNoise2767 ) + (ase_worldPos).xz ) ) / _TerrainMapSize ) );
			float terrainWater1481 = ( 255.0 * tex2DNode8_g22451.b );
			float waterLevelM69_g22452 = ( terrainWater1481 + _WaterHeightOffset );
			float terrainLevel100_g22452 = terrainHeight1480;
			float waterDirectContactArea94_g22452 = _WaterDirectContactArea;
			float temp_output_111_0_g22452 = ( waterLevelM69_g22452 + waterDirectContactArea94_g22452 );
			float submersionFadeStart110_g22452 = temp_output_111_0_g22452;
			float waterFadeRange71_g22452 = ( _WaterFadeRange + ( scaleMultiplier1313 * _WaterRangeScaleIncrease ) );
			float submersionFadeEnd120_g22452 = ( temp_output_111_0_g22452 + waterFadeRange71_g22452 );
			float temp_output_7_0_g22455 = submersionFadeEnd120_g22452;
			float temp_output_125_0_g22452 = ( ( ase_worldPos.y - temp_output_7_0_g22455 ) / ( submersionFadeStart110_g22452 - temp_output_7_0_g22455 ) );
			float2 appendResult156_g22452 = (float2(temp_output_125_0_g22452 , temp_output_125_0_g22452));
			float temp_output_7_0_g22456 = ( waterFadeRange71_g22452 + terrainLevel100_g22452 );
			float terrainWetness1918 = ( 1.0 * tex2DNode8_g22451.r );
			float wetnessLevel186_g22452 = terrainWetness1918;
			float2 temp_cast_106 = (( ( ( ase_worldPos.y - temp_output_7_0_g22456 ) / ( terrainLevel100_g22452 - temp_output_7_0_g22456 ) ) * wetnessLevel186_g22452 )).xx;
			float2 break152_g22452 = (( waterLevelM69_g22452 > terrainLevel100_g22452 ) ? (( ase_worldPos.y < waterLevelM69_g22452 ) ? float2( 1,-5 ) :  (( ase_worldPos.y < submersionFadeStart110_g22452 ) ? float2( 1,1 ) :  (( ase_worldPos.y < submersionFadeEnd120_g22452 ) ? appendResult156_g22452 :  float2( 0,0 ) ) ) ) :  temp_cast_106 );
			float baseColorStrength104_g22452 = break152_g22452.x;
			float terrainNeighoringWaterData1927 = ( 1.0 * tex2DNode8_g22451.a );
			float temp_output_87_0_g22452 = ( _WaterNeighborImpact * terrainNeighoringWaterData1927 );
			float waterNeighborColorStrength98_g22452 = temp_output_87_0_g22452;
			float terrainPuddles1926 = ( 1.0 * tex2DNode8_g22451.g );
			float puddles76_g22452 = ( max( 0.0 , _Global_PuddleParams.x ) * terrainPuddles1926 );
			float puddleFadeEnd144_g22452 = ( terrainLevel100_g22452 + waterFadeRange71_g22452 );
			float temp_output_7_0_g22457 = puddleFadeEnd144_g22452;
			float temp_output_135_0_g22452 = (( puddles76_g22452 > 0.0 ) ? ( ( ase_worldPos.y - temp_output_7_0_g22457 ) / ( terrainLevel100_g22452 - temp_output_7_0_g22457 ) ) :  0.0 );
			float puddleColorStrength148_g22452 = temp_output_135_0_g22452;
			float openAirWetness73_g22452 = max( saturate( max( _DebugWetness , saturate( (( _EnableUV1WWetness > 0.5 ) ? i.uv2_tex4coord2.w :  0.0 ) ) ) ) , _Global_WetnessParams.x );
			float2 break167_g22452 = _RainYRangeLowHigh;
			float temp_output_7_0_g22454 = break167_g22452.x;
			float temp_output_129_0_g22452 = (( openAirWetness73_g22452 > 0.0 ) ? ( openAirWetness73_g22452 * ( ( ase_worldNormal.y - temp_output_7_0_g22454 ) / ( break167_g22452.y - temp_output_7_0_g22454 ) ) ) :  0.0 );
			float rainColorStrength169_g22452 = temp_output_129_0_g22452;
			float wetnessColorStrength39_g22452 = saturate( ( baseColorStrength104_g22452 + waterNeighborColorStrength98_g22452 + puddleColorStrength148_g22452 + rainColorStrength169_g22452 ) );
			float lerpResult22_g22452 = lerp( 1.0 , darkeningFactor34_g22452 , wetnessColorStrength39_g22452);
			float4 finalAlbedo987 = ( preWetnessAlbedo959 * lerpResult22_g22452 );
			float temp_output_7_0_g22460 = round( _DebugMode );
			float4 lerpResult4_g22460 = lerp( saturate( finalAlbedo987 ) , float4( ( ( finalNormal962 * 0.5 ) + 0.5 ) , 0.0 ) , saturate( temp_output_7_0_g22460 ));
			float4 terrainSupplementalData2442 = tex2DNode8_g20908;
			float4 lerpResult6_g22460 = lerp( lerpResult4_g22460 , terrainSupplementalData2442 , step( 2.0 , temp_output_7_0_g22460 ));
			float4 terrainWetnessData2441 = tex2DNode8_g22451;
			float4 lerpResult12_g22460 = lerp( lerpResult6_g22460 , terrainWetnessData2441 , step( 3.0 , temp_output_7_0_g22460 ));
			half4 FOUR16_g22460 = lerpResult12_g22460;
			o.Albedo = FOUR16_g22460.rgb;
			o.Metallic = 0.0;
			float smoothness41_g22452 = temp_output_10_0_g22452;
			float lerpResult2700 = lerp( _WaterSmoothnessPower , ( _WaterSmoothnessPower * _CoverWaterSmoothnessMultiplier ) , totalCoverAlpha2584);
			float smoothnessPower217_g22452 = saturate( lerpResult2700 );
			float baseSmoothnessStrength117_g22452 = break152_g22452.y;
			float waterNeighborSmoothnessStrength172_g22452 = temp_output_87_0_g22452;
			float puddleSmoothnessStrength171_g22452 = temp_output_135_0_g22452;
			float rainSmoothnessStrength170_g22452 = temp_output_129_0_g22452;
			float wetnessSmoothnessStrength185_g22452 = (( baseSmoothnessStrength117_g22452 < 0.01 ) ? 0.0 :  saturate( ( baseSmoothnessStrength117_g22452 + waterNeighborSmoothnessStrength172_g22452 + puddleSmoothnessStrength171_g22452 + rainSmoothnessStrength170_g22452 ) ) );
			float lerpResult24_g22452 = lerp( smoothness41_g22452 , smoothnessPower217_g22452 , wetnessSmoothnessStrength185_g22452);
			float finalSmoothness988 = saturate( lerpResult24_g22452 );
			o.Smoothness = saturate( finalSmoothness988 );
			float3 weightedBlendVar856_g20912 = temp_output_836_0_g20912;
			float weightedBlend856_g20912 = ( weightedBlendVar856_g20912.x*(unpaciked14_g20913).w + weightedBlendVar856_g20912.y*(unpaciked14_g20930).w + weightedBlendVar856_g20912.z*(unpaciked14_g20914).w );
			float mainAO1416 = weightedBlend856_g20912;
			float3 weightedBlendVar856_g22178 = temp_output_836_0_g22178;
			float weightedBlend856_g22178 = ( weightedBlendVar856_g22178.x*(unpaciked14_g22179).w + weightedBlendVar856_g22178.y*(unpaciked14_g22196).w + weightedBlendVar856_g22178.z*(unpaciked14_g22180).w );
			float bottomCoverAO2165 = weightedBlend856_g22178;
			float lerpResult7_g22446 = lerp( ( mainAO1416 * _MainAOTextureStrength ) , ( bottomCoverAO2165 * _CoverAOTextureStrength ) , bottomCoverAlpha851);
			float3 weightedBlendVar856_g22113 = temp_output_836_0_g22113;
			float weightedBlend856_g22113 = ( weightedBlendVar856_g22113.x*(unpaciked14_g22114).w + weightedBlendVar856_g22113.y*(unpaciked14_g22131).w + weightedBlendVar856_g22113.z*(unpaciked14_g22115).w );
			float middleCoverAO2150 = weightedBlend856_g22113;
			float lerpResult8_g22446 = lerp( lerpResult7_g22446 , ( middleCoverAO2150 * _CoverAOTextureStrength ) , 0);
			float3 weightedBlendVar856_g22145 = temp_output_836_0_g22145;
			float weightedBlend856_g22145 = ( weightedBlendVar856_g22145.x*(unpaciked14_g22146).w + weightedBlendVar856_g22145.y*(unpaciked14_g22163).w + weightedBlendVar856_g22145.z*(unpaciked14_g22147).w );
			float topCoverAO1400 = weightedBlend856_g22145;
			float lerpResult12_g22446 = lerp( lerpResult8_g22446 , ( topCoverAO1400 * _CoverAOTextureStrength ) , topCoverAlpha2274);
			float lerpResult9_g22446 = lerp( lerpResult12_g22446 , ( 0 * _TerrainAOTextureStrength ) , 0);
			float3 weightedBlendVar856_g22078 = temp_output_836_0_g22078;
			float weightedBlend856_g22078 = ( weightedBlendVar856_g22078.x*(unpaciked14_g22079).w + weightedBlendVar856_g22078.y*(unpaciked14_g22096).w + weightedBlendVar856_g22078.z*(unpaciked14_g22080).w );
			float terrainOverlay1AO1415 = weightedBlend856_g22078;
			float lerpResult11_g22446 = lerp( lerpResult9_g22446 , ( terrainOverlay1AO1415 * _CoverAOTextureStrength ) , terrainOverlay1Alpha2288);
			float lerpResult10_g22446 = lerp( lerpResult11_g22446 , ( 0 * _CoverAOTextureStrength ) , 0);
			float postFadeAO2336 = lerpResult10_g22446;
			float temp_output_17_0_g22448 = ( 1.0 - (( i.vertexColor.a > 0.5 ) ? (CalculateContrast(_MeshAOContrast,i.vertexColor)).r :  1.0 ) );
			float temp_output_15_0_g22448 = 0.0;
			float temp_output_7_0_g22448 = _MeshAODarknessBoost;
			float ifLocalVar13_g22448 = 0;
			if( _OnlyBoostDarkMeshAO <= temp_output_15_0_g22448 )
				ifLocalVar13_g22448 = temp_output_7_0_g22448;
			else
				ifLocalVar13_g22448 = temp_output_15_0_g22448;
			float ifLocalVar14_g22448 = 0;
			if( temp_output_17_0_g22448 <= temp_output_15_0_g22448 )
				ifLocalVar14_g22448 = ifLocalVar13_g22448;
			else
				ifLocalVar14_g22448 = temp_output_7_0_g22448;
			float temp_output_2652_0 = ( 1.0 - saturate( ( _MeshAOStrength * ( temp_output_17_0_g22448 + ifLocalVar14_g22448 ) ) ) );
			float finalAO865 = ( ( postFadeAO2336 * (( temp_output_2652_0 < 0.01 ) ? 1.0 :  temp_output_2652_0 ) ) * _FinalAOMultiplier );
			o.Occlusion = saturate( finalAO865 );
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.5
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float3 customPack1 : TEXCOORD1;
				float4 customPack2 : TEXCOORD2;
				float3 customPack3 : TEXCOORD3;
				float4 customPack4 : TEXCOORD4;
				float4 tSpace0 : TEXCOORD5;
				float4 tSpace1 : TEXCOORD6;
				float4 tSpace2 : TEXCOORD7;
				half4 color : COLOR0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full_custom v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xyz = customInputData.ase_texcoord5;
				o.customPack2.xyzw = customInputData.ase_texcoord7;
				o.customPack3.xyz = customInputData.ase_texcoord4;
				o.customPack4.xyzw = customInputData.uv2_tex4coord2;
				o.customPack4.xyzw = v.texcoord1;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.color = v.color;
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.ase_texcoord5 = IN.customPack1.xyz;
				surfIN.ase_texcoord7 = IN.customPack2.xyzw;
				surfIN.ase_texcoord4 = IN.customPack3.xyz;
				surfIN.uv2_tex4coord2 = IN.customPack4.xyzw;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				surfIN.vertexColor = IN.color;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17000
0;-864;1536;843;20175.18;2676.984;2.769901;True;False
Node;AmplifyShaderEditor.CommentaryNode;2020;-19124.68,-2827.106;Float;False;5475.341;9031.65;Comment;7;2759;755;726;711;1505;1297;2755;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;2755;-15782.83,3215.077;Float;False;1697.312;895.1063;;11;2771;2772;2750;2773;2764;2763;2767;2753;2752;2757;2756;World Noise;0,0,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;2756;-15626.47,3550.879;Float;False;Property;_TerrainOverlayNoiseScale;Terrain Overlay Noise Scale;148;0;Create;True;0;0;False;0;0;6.5;0.001;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;2757;-15482.47,3376.879;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;1297;-17543.7,139.8372;Float;False;2357.196;1899.291;;43;1310;1283;1378;2516;1275;2194;2193;1292;2195;2175;2190;2515;2196;1043;2514;2192;2191;2172;1273;1042;2174;2189;2173;1323;1274;1288;1324;1281;756;2434;1278;1320;1314;1322;1279;1318;1313;1662;1362;1361;1312;1311;2557;Scaling;1,1,1,1;0;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;2752;-15098.47,3376.879;Float;False;Simplex3D;True;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;2753;-14842.47,3376.879;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1310;-17383.15,462.5822;Float;False;5;3;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;2557;-17144.86,454.9781;Float;False;bounds;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ObjectScaleNode;1283;-17383.15,302.582;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;2767;-14589.35,3348.326;Float;False;terrainOverlayNoise;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1505;-18618.07,2989.111;Float;False;2610.076;3103.925;;24;2441;2442;1926;1927;1918;1481;2760;1925;2770;1480;2780;2779;2761;2452;2762;2440;1922;1475;2439;2768;1921;2769;1928;2198;Terrain Awareness;1,0.9176471,0,1;0;0
Node;AmplifyShaderEditor.TexturePropertyNode;1922;-18471.19,3298.429;Float;True;Property;_TerrainSupplementalShadingMap;Terrain Supplemental Shading Map;154;1;[NoScaleOffset];Create;True;0;0;False;0;None;cfe65d2e95540e243bf5dda7543a0684;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.Vector2Node;1921;-18444.8,3688.915;Float;False;Property;_TerrainMapSize;Terrain Map Size;153;0;Create;True;0;0;False;0;2048,2048;4096,4096;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1311;-16849.35,411.0731;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector2Node;1475;-18450.13,3541.054;Float;False;Property;_TerrainMapOffset;Terrain Map Offset;152;0;Create;True;0;0;False;0;2048,2048;2048,2048;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;2440;-18471.64,3837.007;Float;False;Constant;_Float7;Float 7;179;0;Create;True;0;0;False;0;255;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2768;-17961.64,3142.819;Float;False;2767;terrainOverlayNoise;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2439;-18446.64,3935.007;Float;False;Constant;_Float6;Float 6;179;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2762;-17464.8,3218.2;Float;False;Terrain Awareness Map;-1;;20886;c3df2b1a31343934bb908013141a0a1c;0;8;15;SAMPLER2D;0;False;23;FLOAT2;4096,4096;False;39;FLOAT;1;False;14;FLOAT2;2048,2048;False;18;FLOAT;255;False;19;FLOAT;255;False;20;FLOAT;255;False;21;FLOAT;255;False;5;COLOR;30;FLOAT;24;FLOAT;25;FLOAT;26;FLOAT;27
Node;AmplifyShaderEditor.BreakToComponentsNode;1312;-16709.25,386.3741;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RoundOpNode;2452;-16649.19,3191.982;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;1361;-16438.59,370.8892;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;2198;-18400.72,4733.154;Float;False;2071.182;1181.137;;15;2215;2214;2213;2212;2210;2209;2208;2207;2206;2205;2204;2203;2202;2201;2199;Terrain Overlay Texture;1,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;711;-18869.49,-2356.855;Float;False;630.0128;705.3502;;8;715;714;713;712;660;1013;640;1014;Deterministic Indices;1,0,0.8998737,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1928;-16479.54,3179.636;Float;False;terrainSplat;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;726;-17867.38,-1907.682;Float;False;2702.776;1812.966;Comment;41;2123;2243;2617;741;2244;2245;2122;740;2121;2606;2605;2604;744;751;1009;750;732;2138;2603;2433;745;2607;1003;2432;1008;727;731;738;2436;1012;2135;736;729;2133;737;2136;735;734;746;2132;1011;Textures Indices (U8 >>> Cover);0,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;1362;-16295.59,405.8892;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1011;-17800.88,-287.5261;Float;False;Property;_LockBaseColorAndNormalIndices;Lock Base Color And Normal Indices;160;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;640;-18837.6,-2033.337;Float;False;Property;_DeterminantMultipliers;Determinant Multipliers;26;0;Create;True;0;0;False;0;1000,2000,3000;100,200,300;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;1014;-18849.88,-2171.818;Float;False;Property;_EnableUVDebugging;Enable UV Debugging;166;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;660;-18837.6,-1873.337;Float;False;Constant;_DeterminantOffset;Determinant Offset;56;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMaxOpNode;1662;-16126.43,389.2772;Float;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2199;-18336.71,4797.154;Float;False;1928;terrainSplat;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1013;-18849.88,-2299.818;Float;False;Property;_UsePositionAsDeterminant;Use Position As Determinant;25;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1313;-15979.42,400.957;Float;False;scaleMultiplier;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;712;-18517.6,-2289.337;Float;False;positionAsDeterminant;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2132;-17430.75,-283.6511;Float;False;lockIndices;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;713;-18517.6,-2161.336;Float;False;debugUVOverrides;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;715;-18517.6,-1873.337;Float;False;determinantOffset;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;714;-18517.6,-2033.337;Float;False;determinantMultipliers;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RoundOpNode;2201;-17905.71,4818.154;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;2215;-17968.71,5677.155;Float;False;Property;_TerrainOverlayTextureSet4;Terrain Overlay Texture Set 4;159;0;Create;True;0;0;False;0;12,13,4,-1;0,0,7,-1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1279;-17130.06,928.8402;Float;False;Property;_CoverObjectScaleFactor;Cover Object Scale Factor;49;0;Create;True;0;0;False;0;0.1;0.01;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1318;-17130.06,1008.84;Float;False;1313;scaleMultiplier;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;734;-17835.38,-1647.233;Float;False;713;debugUVOverrides;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleRemainderNode;2202;-17784.71,4971.154;Float;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;736;-17844.38,-1492.233;Float;False;714;determinantMultipliers;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector4Node;729;-17835.38,-1823.233;Float;False;Property;_DebugUV8Overrides;Debug UV8 Overrides;167;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;2136;-17788.88,-1159.147;Float;False;Property;_MainTextureIndices;Main Texture Indices;165;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;2133;-17667.28,-1253.547;Float;False;2132;lockIndices;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;746;-17808.88,-1034.147;Float;False;Property;_BottomCoverTextureIndices;Bottom Cover Texture Indices;164;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;735;-17835.38,-1567.233;Float;False;712;positionAsDeterminant;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;737;-17817.38,-1395.233;Float;False;715;determinantOffset;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector4Node;2214;-17952.71,5485.154;Float;False;Property;_TerrainOverlayTextureSet3;Terrain Overlay Texture Set 3;158;0;Create;True;0;0;False;0;7,9,10,11;-1,-1,6,4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1278;-16518.46,704.2032;Float;False;Property;_MainObjectScaleFactor;Main Object Scale Factor;39;0;Create;True;0;0;False;0;0.25;0.082;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1314;-16454.46,800.2032;Float;False;1313;scaleMultiplier;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2203;-17410.44,5588.479;Float;False;Enum Switch;-1;;20900;d0ffb2eb7ab9dbe45bba7a4f97d686ac;1,34,2;12;25;FLOAT;0;False;7;FLOAT;0;False;29;FLOAT;0;False;8;FLOAT;0;False;18;FLOAT;0;False;28;FLOAT;0;False;17;FLOAT;0;False;10;FLOAT;0;False;30;FLOAT;0;False;11;FLOAT;0;False;20;FLOAT;0;False;15;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareGreater;1012;-17313.48,-934.5469;Float;False;4;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareGreater;2135;-17308.88,-1207.147;Float;False;4;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1322;-16842.06,928.8402;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2617;-17490.21,-1643.842;Float;False;Global ShaderSet Index (Mesh UV);-1;;20897;d83042538c51f5544bd269e6cfbe59c4;1,231,4;5;214;FLOAT4;0,0,0,0;False;216;FLOAT;0;False;142;FLOAT;1;False;102;FLOAT3;1000,2000,3000;False;220;FLOAT3;0,0,0;False;4;FLOAT2;0;FLOAT2;95;FLOAT2;97;FLOAT2;96
Node;AmplifyShaderEditor.RangedFloatNode;2436;-17052.87,-1286.315;Float;False;Property;_UseMeshTextureIndices;Use Mesh Texture Indices;161;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;756;-16514.46,625.2032;Float;False;Property;_MainTextureScale;Main Texture Scale;38;0;Create;True;0;0;False;0;1;2.5;0;30;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1281;-16208.53,781.0872;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1320;-16698.06,928.8402;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2434;-16657.32,1073.786;Float;False;const;-1;;20903;5b64729fb717c5f49a1bc2dab81d5e1c;1,3,1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;2213;-17952.71,5293.154;Float;False;Property;_TerrainOverlayTextureSet2;Terrain Overlay Texture Set 2;157;0;Create;True;0;0;False;0;4,5,6,7;-1,9,3,6;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;731;-16969.61,-1675.979;Float;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;2205;-17410.44,5412.479;Float;False;Enum Switch;-1;;20901;d0ffb2eb7ab9dbe45bba7a4f97d686ac;1,34,2;12;25;FLOAT;0;False;7;FLOAT;0;False;29;FLOAT;0;False;8;FLOAT;0;False;18;FLOAT;0;False;28;FLOAT;0;False;17;FLOAT;0;False;10;FLOAT;0;False;30;FLOAT;0;False;11;FLOAT;0;False;20;FLOAT;0;False;15;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareWithRange;2204;-17120.72,5533.154;Float;False;5;0;FLOAT;0;False;1;FLOAT;12;False;2;FLOAT;15;False;3;FLOAT;0;False;4;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;738;-17020.88,-1031.147;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;1324;-16554.06,928.8402;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1288;-16000.53,774.0872;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2206;-17410.44,5236.479;Float;False;Enum Switch;-1;;20905;d0ffb2eb7ab9dbe45bba7a4f97d686ac;1,34,2;12;25;FLOAT;0;False;7;FLOAT;0;False;29;FLOAT;0;False;8;FLOAT;0;False;18;FLOAT;0;False;28;FLOAT;0;False;17;FLOAT;0;False;10;FLOAT;0;False;30;FLOAT;0;False;11;FLOAT;0;False;20;FLOAT;0;False;15;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;2212;-17952.71,5101.154;Float;False;Property;_TerrainOverlayTextureSet1;Terrain Overlay Texture Set 1;156;0;Create;True;0;0;False;0;4,4,4,4;-1,-1,-1,-1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCCompareWithRange;2207;-17120.72,5357.154;Float;False;5;0;FLOAT;0;False;1;FLOAT;8;False;2;FLOAT;11;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareGreater;1008;-16509.92,-1147.829;Float;False;4;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TFHCCompareWithRange;2208;-17120.72,5181.154;Float;False;5;0;FLOAT;0;False;1;FLOAT;4;False;2;FLOAT;7;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1274;-16426.06,928.8402;Float;False;coverObjectScale;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;2432;-17800.71,-727.9609;Float;False;Property;_MiddleCoverTextureIndices;Middle Cover Texture Indices;163;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;727;-17792.78,-567.8469;Float;False;Property;_TopCoverTextureIndices;Top Cover Texture Indices;162;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.FunctionNode;2209;-17410.44,5060.479;Float;False;Enum Switch;-1;;20906;d0ffb2eb7ab9dbe45bba7a4f97d686ac;1,34,2;12;25;FLOAT;0;False;7;FLOAT;0;False;29;FLOAT;0;False;8;FLOAT;0;False;18;FLOAT;0;False;28;FLOAT;0;False;17;FLOAT;0;False;10;FLOAT;0;False;30;FLOAT;0;False;11;FLOAT;0;False;20;FLOAT;0;False;15;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2607;-16231.82,-1323.961;Float;False;2132;lockIndices;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;755;-18987.66,-839.1927;Float;False;938.9467;2086.156;;28;2498;2497;2456;2455;1057;2681;2537;1055;2680;2536;2709;2710;2711;2712;2713;2714;2715;2716;2717;2718;2719;2720;2721;2722;2723;2725;2726;2724;Inputs;1,0.5102247,0,1;0;0
Node;AmplifyShaderEditor.BreakToComponentsNode;745;-16231.82,-1115.961;Float;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMaxOpNode;1323;-15840.53,698.1871;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;2022;-12638.14,-1314.259;Float;False;3642.205;8709.568;Comment;8;2142;768;783;2157;287;290;2999;2998;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TFHCCompareGreater;2603;-15751.82,-1547.961;Float;False;4;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareGreater;1003;-17319.82,-753.1608;Float;False;4;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareWithRange;2210;-17120.72,5005.154;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;3;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;2759;-15806.46,4839.618;Float;False;1993.482;990.9458;Comment;11;2618;2211;2229;2241;2242;2395;2397;2396;2240;2567;2562;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;2536;-18882.22,-797.2828;Float;False;Property;_MainTriplanarContrast;Main Triplanar Contrast;27;0;Create;True;0;0;False;0;4;50;1;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2514;-17106.91,1453.137;Float;False;Property;_TopCoverMaskScale;Top Cover Mask Scale;80;0;Create;True;0;0;False;0;1;2;0;500;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1273;-15664.53,806.0872;Float;False;mainObjectScale;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2189;-16986.06,1104.84;Float;False;1274;coverObjectScale;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareGreater;2433;-17319.82,-507.9609;Float;False;4;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;783;-12316.89,-1068.716;Float;False;2183.137;1282.957;;23;1417;1416;789;786;1330;1328;2696;2112;2699;2697;2698;2113;2679;2670;788;2682;189;1056;188;792;795;1663;1327;Main Texture;1,0,0,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2515;-16642.91,1453.137;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2173;-17110.23,1544.505;Float;False;Property;_TerrainOverlay1TextureScale;Terrain Overlay 1 Texture Scale;106;0;Create;True;0;0;False;0;1;6;0;30;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;2240;-15328.56,5298.11;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;1327;-12242.43,-1001.992;Float;False;1273;mainObjectScale;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;2138;-16911.82,-648.7609;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;732;-16976.89,-1545.884;Float;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;2395;-15398.33,5615.021;Float;False;714;determinantMultipliers;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;750;-15751.82,-795.9608;Float;False;mainBaseColorIndex;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2397;-15398.33,5695.021;Float;False;715;determinantOffset;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2396;-15398.33,5535.021;Float;False;712;positionAsDeterminant;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;751;-15463.82,-1547.961;Float;False;mainNormalIndex;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2537;-18553.22,-779.2829;Float;False;mainTriplanarBlendSharpness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2618;-14983.56,5507.818;Float;False;Global ShaderSet Index (Explicit);-1;;20909;32ec1cae486522d46b28bb4d54470ca2;0;4;245;FLOAT4;0,0,0,0;False;142;FLOAT;1;False;102;FLOAT3;1000,2000,3000;False;220;FLOAT3;0,0,0;False;4;FLOAT2;0;FLOAT2;95;FLOAT2;97;FLOAT2;96
Node;AmplifyShaderEditor.CommentaryNode;2998;-11841.42,3768.672;Float;False;2034.661;563.4524;Comment;16;2958;2309;2311;2308;2735;2739;2736;2738;2737;2662;2996;2741;1058;2517;2740;2518;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;795;-12235.57,-532.174;Float;False;750;mainBaseColorIndex;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;1663;-11996.05,-948.0546;Float;False;FLOAT2;0;1;2;3;1;0;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1056;-12231.76,-117.8602;Float;False;2537;mainTriplanarBlendSharpness;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2680;-18864.6,1060.599;Float;False;Property;_NormalZReconstructionStyle;Normal Z Reconstruction Style;24;0;Create;True;0;0;False;0;0.02;1.704;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;189;-12268.57,-454.174;Float;True;Property;_MainNormalArray;Main Normal Array;37;1;[NoScaleOffset];Create;True;0;0;False;0;865c86ad4eedcb74882054c43f92fb5d;df6a4a101cffdfa4eaba98bbcc6f61ee;False;bump;LockedToTexture2DArray;Texture2DArray;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TFHCCompareGreater;1009;-16517.27,-940.4777;Float;False;4;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2191;-16646.23,1560.505;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2516;-16386.91,1453.137;Float;False;topCoverMaskScale;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;188;-12268.57,-774.1737;Float;True;Property;_MainBaseColorArray;Main Base Color Array;36;1;[NoScaleOffset];Create;True;0;0;False;0;8a0820cf6d5f4574489e41c01cf2d37b;f4e67b3c1ea4f8041abf9a46d6b24957;False;white;LockedToTexture2DArray;Texture2DArray;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode;792;-12233.76,-212.8602;Float;False;751;mainNormalIndex;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2195;-16390.23,1560.505;Float;False;terrainOverlay1Scale;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1042;-17113.23,1369.99;Float;False;Property;_TopCoverTextureScale;Top Cover Texture Scale;83;0;Create;True;0;0;False;0;1;2;0;30;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1043;-17115.36,1185.441;Float;False;Property;_BottomCoverTextureScale;Bottom Cover Texture Scale;51;0;Create;True;0;0;False;0;1;7.5;0;30;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;744;-16231.82,-955.9608;Float;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;2721;-18901.08,362.0405;Float;False;Property;_TerrainOverlayTriplanarContrast;Terrain Overlay Triplanar Contrast;103;0;Create;True;0;0;False;0;4;50;1;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2697;-11724.71,-826.5452;Float;False;Property;_MainSaturationMultiplier;Main Saturation Multiplier;42;0;Create;True;0;0;False;0;1;1;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2698;-11728,-752;Float;False;Property;_MainValueMultiplier;Main Value Multiplier;43;0;Create;True;0;0;False;0;1;0.814;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2699;-11728,-672;Float;False;Property;_MainContrast;Main Contrast;44;0;Create;True;0;0;False;0;1;0.85;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;768;-12073.23,6067.112;Float;False;2609.095;937.9061;;23;773;2627;2465;2313;2312;770;772;2687;2673;1415;1414;2936;2935;2937;2934;2664;1059;1665;779;1293;2984;2985;2986;Terrain Overlay Texture;1,1,0,1;0;0
Node;AmplifyShaderEditor.ComponentMaskNode;2241;-14510.07,5481.301;Float;False;True;False;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2518;-11824.74,3949.11;Float;False;2516;topCoverMaskScale;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2670;-11847.67,-482.5944;Float;False;Triplanar NormSAO Array Material;0;;20911;2ae230feac7e920499683efd4613d3c2;0;7;835;SAMPLER2D;0;False;938;FLOAT;0;False;837;SAMPLER2D;0;False;939;FLOAT;0;False;927;FLOAT2;0,0;False;926;FLOAT2;1,1;False;925;FLOAT;1;False;5;COLOR;899;FLOAT3;898;FLOAT;900;FLOAT;897;FLOAT;896
Node;AmplifyShaderEditor.RangedFloatNode;1055;-18901.57,-705.9164;Float;False;Property;_TopCoverTriplanarContrast;Top Cover Triplanar Contrast;85;0;Create;True;0;0;False;0;4;29.1;1;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2681;-18496.6,1060.599;Float;False;normalZReconstructionStyle;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2190;-16649.23,1369.99;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2175;-16650.06,1184.841;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1328;-11291.68,-827.067;Float;False;Property;_MainTint;Main Tint;40;0;Create;True;0;0;False;0;1,1,1,1;0.8018868,0.8018868,0.8018868,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;788;-11674.83,-235.6555;Float;False;Property;_MainNormalScale;Main Normal Scale;41;0;Create;True;0;0;False;0;1;2;0.1;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2682;-11717.98,-124.188;Float;False;2681;normalZReconstructionStyle;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2740;-11756.02,4039.179;Float;False;1313;scaleMultiplier;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;2517;-11574.65,3950.177;Float;False;FLOAT2;0;1;2;3;1;0;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1293;-12052.6,6525.24;Float;False;2195;terrainOverlay1Scale;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2696;-11407.12,-609.7024;Float;False;Material Modification;-1;;22029;a3c4b501064391643b3102d29050d33f;0;5;410;COLOR;0,0,0,0;False;430;FLOAT;0;False;431;FLOAT;1;False;432;FLOAT;1;False;443;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1057;-18581.57,-687.9164;Float;False;TopCoverTriplanarContrast;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;290;-12712.08,3979.741;Float;True;Property;_CoverBaseColorArray;Cover Base Color Array;47;1;[NoScaleOffset];Create;True;0;0;False;0;26e2a512463c8b2478ae90f3d95fe115;a216b00a53d524146b21b7993c527348;False;white;LockedToTexture2DArray;Texture2DArray;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2211;-14302.07,5481.301;Float;False;textureOverlay1Index;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2722;-18580.08,380.0405;Float;False;TerrainOverlayTriplanarContrast;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2121;-15751.82,-507.9609;Float;False;topCoverBaseColorIndex;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;287;-12703.67,4465.197;Float;True;Property;_CoverNormSAOArray;Cover NormSAO Array;48;1;[NoScaleOffset];Create;True;0;0;False;0;c34942e9dbe8a034fa9400de52ca52a9;ae39838eca598d0498952cd0089f0832;False;bump;LockedToTexture2DArray;Texture2DArray;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FunctionNode;2679;-11175.43,-390.0164;Float;False;Normal Scale (Unpacked);-1;;22030;6838fae5b50a0ea4b95a3b9f9a4c53ea;0;3;2;FLOAT3;0,0,0;False;37;FLOAT;1;False;43;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode;1665;-11798.61,6498.964;Float;False;FLOAT2;0;1;2;3;1;0;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;2715;-18888.82,39.77847;Float;False;Property;_BottomCoverTriplanarContrast;Bottom Cover Triplanar Contrast;53;0;Create;True;0;0;False;0;4;1;1;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;779;-12040.91,6387.995;Float;False;2211;textureOverlay1Index;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;2157;-12492.5,541.9932;Float;False;3063.125;940.4172;;24;2164;2165;2160;2163;2161;2459;2307;2305;2158;2170;2167;2166;2169;2668;2685;2949;2950;2951;2952;2676;2632;2993;2994;2995;Bottom Cover Texture;0,0,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;1059;-12024.87,6635.527;Float;False;2722;TerrainOverlayTriplanarContrast;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1330;-10997.58,-644.6446;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1058;-11657.52,4123.876;Float;False;1057;TopCoverTriplanarContrast;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2996;-11727.95,3851.044;Float;False;2121;topCoverBaseColorIndex;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2741;-11420.02,3968.179;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2194;-16393.23,1369.99;Float;False;topCoverScale;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1275;-16394.06,1184.841;Float;False;bottomCoverScale;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareGreater;2604;-15751.82,-1403.961;Float;False;4;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2958;-11634.64,3809;Float;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.CommentaryNode;2999;-11918.26,4861.687;Float;False;2567.168;752.1602;Comment;24;1291;760;761;2953;1666;2955;2944;2946;2667;2948;2945;2988;2947;2987;2989;2633;2463;282;2686;2671;700;1400;1401;702;Top Cover;1,1,1,1;0;0
Node;AmplifyShaderEditor.TFHCCompareGreater;2606;-15751.82,-1115.961;Float;False;4;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;2139;-6616.552,-2248.765;Float;False;3536.678;6229.302;Comment;3;2261;819;2275;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2122;-15463.82,-1115.961;Float;False;topCoverNormalIndex;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1291;-11863.68,5395.724;Float;False;2194;topCoverScale;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;2112;-10686.67,-356.6675;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2935;-11646.81,6318.36;Float;False;Property;_TerrainOverlayContrast;Terrain Overlay Contrast;110;0;Create;True;0;0;False;0;1;0.733;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2937;-11646.81,6238.36;Float;False;Property;_TerrainOverlayValueMultiplier;Terrain Overlay Value Multiplier;109;0;Create;True;0;0;False;0;1;0.646;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2664;-11571.74,6411.127;Float;False;Triplanar NormSAO Array Material;0;;22077;2ae230feac7e920499683efd4613d3c2;0;7;835;SAMPLER2D;0;False;938;FLOAT;0;False;837;SAMPLER2D;0;False;939;FLOAT;0;False;927;FLOAT2;0,0;False;926;FLOAT2;1,1;False;925;FLOAT;1;False;5;COLOR;899;FLOAT3;898;FLOAT;900;FLOAT;897;FLOAT;896
Node;AmplifyShaderEditor.RangedFloatNode;2763;-15610.47,3696.879;Float;False;Property;_CoverFadeNoiseScale;Cover Fade Noise Scale;150;0;Create;True;0;0;False;0;0;25.8;0.001;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;741;-15463.82,-1403.961;Float;False;bottomCoverNormalIndex;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2716;-18567.82,57.77847;Float;False;BottomCoverTriplanarContrast;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;740;-15751.82,-699.9609;Float;False;bottomCoverBaseColorIndex;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2169;-12460.86,686.1221;Float;False;1275;bottomCoverScale;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2934;-11646.81,6158.36;Float;False;Property;_TerrainOverlaySaturationMultiplier;Terrain Overlay Saturation Multiplier;108;0;Create;True;0;0;False;0;1;0.7;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2662;-11243.06,3896.039;Float;False;Triplanar Simple Array Sampler;8;;22033;3ed0410ccb2e77c47a08c2b80e4350c8;0;5;835;SAMPLER2D;0;False;899;FLOAT;0;False;891;FLOAT2;0,0;False;890;FLOAT2;1,1;False;889;FLOAT;1;False;1;COLOR;846
Node;AmplifyShaderEditor.RegisterLocalVarNode;789;-10833.58,-633.6447;Float;False;mainBaseColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SwizzleNode;2737;-10890.29,3899.306;Float;False;FLOAT4;3;3;3;3;1;0;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;2166;-12430.18,959.877;Float;False;740;bottomCoverBaseColorIndex;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2936;-11166.81,6126.36;Float;False;Material Modification;-1;;22110;a3c4b501064391643b3102d29050d33f;0;5;410;COLOR;0,0,0,0;False;430;FLOAT;0;False;431;FLOAT;1;False;432;FLOAT;1;False;443;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;786;-10496.27,-357.6035;Float;False;mainNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2984;-10951.56,6304.842;Float;False;789;mainBaseColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2985;-10999.56,6384.842;Float;False;Property;_TerrainOverlayAlbedoMatch;Terrain Overlay Albedo Match;111;0;Create;True;0;0;False;0;0.5;0.02;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;2275;-6456.491,2039.331;Float;False;3202.351;1767.839;;28;2970;2288;2572;2392;2571;2387;2491;2370;2492;2734;2382;2733;2775;2324;2278;2279;2285;2284;2282;2283;2927;2286;2277;2281;2280;2276;2922;2980;Terrain Overlay 1 Area;1,1,0,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;2167;-12430.18,1039.877;Float;False;741;bottomCoverNormalIndex;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2761;-17461.36,3482.705;Float;False;Terrain Awareness Map;-1;;20908;c3df2b1a31343934bb908013141a0a1c;0;8;15;SAMPLER2D;0;False;23;FLOAT2;4096,4096;False;39;FLOAT;1;False;14;FLOAT2;2048,2048;False;18;FLOAT;255;False;19;FLOAT;255;False;20;FLOAT;255;False;21;FLOAT;255;False;5;COLOR;30;FLOAT;24;FLOAT;25;FLOAT;26;FLOAT;27
Node;AmplifyShaderEditor.GetLocalVarNode;2158;-12426.14,1137.408;Float;False;2716;BottomCoverTriplanarContrast;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;2764;-15098.47,3632.879;Float;False;Simplex3D;True;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;2170;-12178.88,681.8443;Float;False;FLOAT2;0;1;2;3;1;0;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;2944;-11553.69,5073.022;Float;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode;761;-11795.9,5222.081;Float;False;2122;topCoverNormalIndex;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2953;-11787.82,5307.636;Float;False;1057;TopCoverTriplanarContrast;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;1666;-11644.06,5385.671;Float;False;FLOAT2;0;1;2;3;1;0;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;2955;-11604.53,5075.504;Float;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode;760;-11794.36,5128.412;Float;False;2121;topCoverBaseColorIndex;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2738;-11211.5,4067.731;Float;False;Property;_CoverAlphaMaskMultiplier;Cover Alpha Mask Multiplier;81;0;Create;True;0;0;False;0;1;1.19;0.1;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2667;-11279.38,5210.617;Float;False;Triplanar NormSAO Array Material;0;;22144;2ae230feac7e920499683efd4613d3c2;0;7;835;SAMPLER2D;0;False;938;FLOAT;0;False;837;SAMPLER2D;0;False;939;FLOAT;0;False;927;FLOAT2;0,0;False;926;FLOAT2;1,1;False;925;FLOAT;1;False;5;COLOR;899;FLOAT3;898;FLOAT;900;FLOAT;897;FLOAT;896
Node;AmplifyShaderEditor.RangedFloatNode;2948;-11258.05,5032.966;Float;False;Property;_TopCoverValueMultiplier;Top Cover Value Multiplier;87;0;Create;True;0;0;False;0;1;0.75;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2946;-11258.05,5112.966;Float;False;Property;_TopCoverContrast;Top Cover Contrast;88;0;Create;True;0;0;False;0;1;1;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2945;-11279.32,4934.548;Float;False;Property;_TopCoverSaturationMultiplier;Top Cover Saturation Multiplier;86;0;Create;True;0;0;False;0;1;1;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1480;-16602.09,3746.637;Float;False;terrainHeight;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2736;-11224.3,4163.305;Float;False;Property;_CoverAlphaMaskContrast;Cover Alpha Mask Contrast;82;0;Create;True;0;0;False;0;1;2.99;0.1;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2951;-11889.39,676.9273;Float;False;Property;_BottomCoverValueMultiplier;Bottom Cover Value Multiplier;55;0;Create;True;0;0;False;0;1;1;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2750;-14918.87,3815.779;Float;False;Property;_CoverFadeNoiseStrength;Cover Fade Noise Strength;151;0;Create;True;0;0;False;0;1;0.575;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2949;-11889.39,596.9273;Float;False;Property;_BottomCoverSaturationMultiplier;Bottom Cover Saturation Multiplier;54;0;Create;True;0;0;False;0;1;1;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2739;-10710.02,3950.179;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;2986;-10615.56,6160.842;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;2773;-14842.47,3632.879;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2276;-6319.03,2121.9;Float;False;786;mainNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;2312;-10537.43,6584.506;Float;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2950;-11889.39,756.9273;Float;False;Property;_BottomCoverContrast;Bottom Cover Contrast;56;0;Create;True;0;0;False;0;1;1;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2668;-11921.73,890.1763;Float;False;Triplanar NormSAO Array Material;0;;22177;2ae230feac7e920499683efd4613d3c2;0;7;835;SAMPLER2D;0;False;938;FLOAT;0;False;837;SAMPLER2D;0;False;939;FLOAT;0;False;927;FLOAT2;0,0;False;926;FLOAT2;1,1;False;925;FLOAT;1;False;5;COLOR;899;FLOAT3;898;FLOAT;900;FLOAT;897;FLOAT;896
Node;AmplifyShaderEditor.RangedFloatNode;2922;-6335.17,2248.652;Float;False;Property;_TerrainOverlay1AreaNormalStrength;Terrain Overlay 1 Area Normal Strength;115;0;Create;True;0;0;False;0;1;0.115;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2282;-6326.092,3296.212;Float;False;Property;_TerrainOverlay1MaximumVerticalRange;Terrain Overlay 1 Maximum Vertical Range;118;0;Create;True;0;0;False;0;1;100;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2286;-6314.585,3663.358;Float;False;Property;_TerrainOverlay1FinalContrast;Terrain Overlay 1 Final Contrast;122;0;Create;True;0;0;False;0;1;1;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2952;-11345.67,625.3431;Float;False;Material Modification;-1;;22209;a3c4b501064391643b3102d29050d33f;0;5;410;COLOR;0,0,0,0;False;430;FLOAT;0;False;431;FLOAT;1;False;432;FLOAT;1;False;443;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;2735;-10567.01,4013.643;Float;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2280;-6236.654,3107.872;Float;False;1480;terrainHeight;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2284;-6329.805,3471.792;Float;False;Property;_TerrainOverlay1TargetPercentage;Terrain Overlay 1 Target Percentage;117;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2723;-18916.56,450.4365;Float;False;Property;_TerrainOverlayCoverMaskTolerance;Terrain Overlay Cover Mask Tolerance;104;0;Create;True;0;0;False;0;0.02;0.08;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2279;-6307.211,3002.782;Float;False;Property;_TerrainOverlay1FadeSmoothness;Terrain Overlay 1 Fade Smoothness;119;0;Create;True;0;0;False;0;0.05;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;2278;-6329.839,2586.683;Float;False;Property;_TerrainOverlay1BaseCoverageRange;Terrain Overlay 1 Base Coverage Range;114;0;Create;True;0;0;False;0;1,0.5,1;1,0.2,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;2313;-10270.58,6584.836;Float;False;terrainOverlay1AlphaMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2281;-6328.359,3206.116;Float;False;Property;_TerrainOverlay1FinalStrength;Terrain Overlay 1 Final Strength;121;0;Create;True;0;0;False;0;1;1;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2772;-14610.79,3763.504;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2994;-11177.68,952.1561;Float;False;Property;_BottomCoverAlbedoMatch;Bottom Cover Albedo Match;57;0;Create;True;0;0;False;0;1;0.02;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;2980;-6328.642,2764.594;Float;False;Property;_TerrainOverlay1PeakCoverageRange;Terrain Overlay 1 Peak Coverage Range;113;0;Create;True;0;0;False;0;1,0.5,1;1,0.1,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;819;-6452.194,-2023.753;Float;False;3096.181;1747.673;;24;2972;851;2483;2361;2499;2482;2385;2778;2457;2316;1514;1272;1336;1159;1128;1131;1271;1132;2925;1339;1263;1135;2920;2976;Bottom Cover Area;0,0,1,1;0;0
Node;AmplifyShaderEditor.Vector3Node;2277;-6299.007,2411.092;Float;False;Property;_TerrainOverlay1CoverageBasis;Terrain Overlay 1 Coverage Basis;112;0;Create;True;0;0;False;0;0,-0.5,0;0,0.93,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;773;-10335.24,6141.742;Float;False;terrainOverlay1BaseColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;2927;-5972.002,2212.934;Float;False;3;0;FLOAT3;0,0,1;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;2261;-6443.263,35.30141;Float;False;3080.76;1669.219;;24;2274;2488;2367;2501;2489;2776;2381;2490;2321;2971;2926;2269;2979;2264;2272;2268;2267;2266;2265;2270;2271;2263;2262;2921;Top Cover Top Area;0,1,0,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;2993;-11129.68,872.1563;Float;False;789;mainBaseColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2988;-10682.33,5211.747;Float;False;Property;_TopCoverAlbedoMatch;Top Cover Albedo Match;89;0;Create;True;0;0;False;0;1;0.02;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2947;-10879.25,4978.283;Float;False;Material Modification;-1;;22210;a3c4b501064391643b3102d29050d33f;0;5;410;COLOR;0,0,0,0;False;430;FLOAT;0;False;431;FLOAT;1;False;432;FLOAT;1;False;443;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2987;-10634.33,5131.747;Float;False;789;mainBaseColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2285;-6324.957,3563.705;Float;False;Property;_TerrainOverlay1FadePercentage;Terrain Overlay 1 Fade Percentage;120;0;Create;True;0;0;False;0;0.2;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2283;-6333.842,3381.636;Float;False;Property;_TerrainOverlay1MinimumVerticalRange;Terrain Overlay 1 Minimum Vertical Range;116;0;Create;True;0;0;False;0;1;0.5;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2771;-14434.37,3762.879;Float;False;coverFadeNoise;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2724;-18529.37,480.8354;Float;False;TerrainOverlayCoverMaskTolerance;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2725;-18916.58,575.1135;Float;False;Property;_TerarinCoverColorLowThreshold;Terarin Cover Color Low Threshold;105;0;Create;True;0;0;False;0;0.02;0.112;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2970;-5603.173,2753.375;Float;False;Smart Cover (Unmasked);-1;;22213;1da15c5282eb6c04fbee1b4ace7abcc7;0;12;30;FLOAT3;0,0,1;False;26;FLOAT3;0,0.5,0;False;309;FLOAT3;1,0.5,1;False;123;FLOAT3;1,0.5,1;False;167;FLOAT;0.1;False;303;FLOAT;-1000;False;221;FLOAT;1;False;237;FLOAT;10;False;250;FLOAT;0.1;False;251;FLOAT;10;False;239;FLOAT;0.1;False;227;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2921;-6385.142,182.2453;Float;False;Property;_TopCoverAreaNormalStrength;Top Cover Area Normal Strength;93;0;Create;True;0;0;False;0;1;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2262;-6331.802,101.8712;Float;False;786;mainNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;2305;-10773.03,1054.492;Float;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;2308;-10359.86,4012.8;Float;False;True;False;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2627;-10010.69,6148.99;Float;False;Sum Components 3;-1;;22262;7e94ed8ab59b2174ba15f73cd495eb18;0;1;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2324;-5349.208,2614.191;Float;False;2313;terrainOverlay1AlphaMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2995;-10810.39,680.8152;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1135;-6360.365,-1902.488;Float;False;786;mainNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;2989;-10350.48,4977.971;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2920;-6396.79,-1820.471;Float;False;Property;_BottomCoverAreaNormalStrength;Bottom Cover Area Normal Strength;61;0;Create;True;0;0;False;0;1;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2307;-10529.55,1047.737;Float;False;bottomCoverAlphaMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2271;-6378.209,1383.999;Float;False;Property;_TopCoverFadePercentage;Top Cover Fade Percentage;98;0;Create;True;0;0;False;0;0.2;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2311;-10105.54,4080.755;Float;False;topCoverAlphaMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;2263;-6385.69,264.8205;Float;False;Property;_TopCoverCoverageBasis;Top Cover Coverage Basis;90;0;Create;True;0;0;False;0;0,-0.5,0;0,0.65,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;2726;-18548.58,575.1135;Float;False;TerarinCoverColorLowThreshold;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;2976;-6382.457,-1374.437;Float;False;Property;_BottomCoverPeakCoverageRange;Bottom Cover Peak Coverage Range;59;0;Create;True;0;0;False;0;1,0.5,1;1,1,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;1272;-6406.519,-824.7122;Float;False;Property;_BottomCoverMaximumVerticalRange;Bottom Cover Maximum Vertical Range;64;0;Create;True;0;0;False;0;1;250;0;250;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1339;-6390.519,-552.7122;Float;False;Property;_BottomCoverFadePercentage;Bottom Cover Fade Percentage;66;0;Create;True;0;0;False;0;0.2;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;1131;-6390.519,-1717.276;Float;False;Property;_BottomCoverCoverageBasis;Bottom Cover Coverage Basis;58;0;Create;True;0;0;False;0;0,-0.5,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;2270;-6383.057,1292.085;Float;False;Property;_TopCoverTargetPercentage;Top Cover Target Percentage;95;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;1132;-6384.119,-1531.912;Float;False;Property;_BottomCoverBaseCoverageRange;Bottom Cover Base Coverage Range;60;0;Create;True;0;0;False;0;1,0.5,1;1,1,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;1336;-6406.519,-648.7123;Float;False;Property;_BottomCoverTargetPercentage;Bottom Cover Target Percentage;63;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1159;-6406.519,-920.7122;Float;False;Property;_BottomCoverFinalStrength;Bottom Cover Final Strength;70;0;Create;True;0;0;False;0;1;1;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1263;-6390.519,-456.7122;Float;False;Property;_BottomCoverFinalContrast;Bottom Cover Final Contrast;69;0;Create;True;0;0;False;0;1;1;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1271;-6406.519,-744.7122;Float;False;Property;_BottomCoverMinimumVerticalRange;Bottom Cover Minimum Vertical Range;62;0;Create;True;0;0;False;0;1;0.5;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1128;-6374.519,-1112.712;Float;False;Property;_BottomCoverFadeSmoothness;Bottom Cover Fade Smoothness;65;0;Create;True;0;0;False;0;0.05;0.373;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2465;-9764.987,6141.915;Float;False;terrainOverlay1ColorSum;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2265;-6360.463,823.0763;Float;False;Property;_TopCoverFadeSmoothness;Top Cover Fade Smoothness;97;0;Create;True;0;0;False;0;0.05;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2267;-6381.612,1026.41;Float;False;Property;_TopCoverFinalStrength;Top Cover Final Strength;101;0;Create;True;0;0;False;0;1;1;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2268;-6379.344,1116.505;Float;False;Property;_TopCoverMaximumVerticalRange;Top Cover Maximum Vertical Range;96;0;Create;True;0;0;False;0;1;250;0;250;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2272;-6367.837,1483.653;Float;False;Property;_TopCoverFinalContrast;Top Cover Final Contrast;102;0;Create;True;0;0;False;0;1;2;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2455;-18923.05,-591.5202;Float;False;Property;_TopCoverMaskTolerance;Top Cover Mask Tolerance;99;0;Create;True;0;0;False;0;0.02;0;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;2264;-6374.791,431.9785;Float;False;Property;_TopCoverBaseCoverageRange;Top Cover Base Coverage Range;92;0;Create;True;0;0;False;0;1,0.5,1;1,0.2,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;2979;-6370.662,583.6894;Float;False;Property;_TopCoverPeakCoverageRange;Top Cover Peak Coverage Range;91;0;Create;True;0;0;False;0;1,0.5,1;1,0.5,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;1514;-6310.519,-1016.712;Float;False;1480;terrainHeight;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;702;-10142.34,4949.646;Float;False;topCoverBaseColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2717;-18909.3,154.1744;Float;False;Property;_BottomCoverMaskTolerance;Bottom Cover Mask Tolerance;67;0;Create;True;0;0;False;0;0.02;0.02;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2925;-5981.499,-1893.846;Float;False;3;0;FLOAT3;0,0,1;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2775;-4933.048,2896.232;Float;False;2771;coverFadeNoise;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareLower;2382;-5017.193,2686.071;Float;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2926;-6018.345,134.9164;Float;False;3;0;FLOAT3;0,0,1;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2733;-5383.344,2516.318;Float;False;2724;TerrainOverlayCoverMaskTolerance;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2266;-6289.906,928.1654;Float;False;1480;terrainHeight;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2160;-10406.69,767.6053;Float;False;bottomCoverBaseColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2269;-6387.094,1201.931;Float;False;Property;_TopCoverMinimumVerticalRange;Top Cover Minimum Vertical Range;94;0;Create;True;0;0;False;0;1;1;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2718;-18522.1,184.5733;Float;False;BottomCoverMaskTolerance;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2719;-18909.32,278.8514;Float;False;Property;_BottomCoverColorLowThreshold;Bottom Cover Color Low Threshold;68;0;Create;True;0;0;False;0;0.02;0.02;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2456;-18535.85,-561.1203;Float;False;TopCoverMaskTolerance;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2633;-9855.458,4968.869;Float;False;Sum Components 3;-1;;22342;7e94ed8ab59b2174ba15f73cd495eb18;0;1;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2316;-5189.445,-1669.205;Float;False;2307;bottomCoverAlphaMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2497;-18923.07,-466.8432;Float;False;Property;_TopCoverColorLowThreshold;Top Cover Color Low Threshold;100;0;Create;True;0;0;False;0;0.02;0.078;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2734;-5325.784,2419.329;Float;False;2726;TerarinCoverColorLowThreshold;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2492;-4931.048,2377.735;Float;False;2465;terrainOverlay1ColorSum;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareGreater;2370;-4776.207,2622.191;Float;False;4;0;FLOAT;0;False;1;FLOAT;0.01;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2321;-5095.612,458.2375;Float;False;2311;topCoverAlphaMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2172;-17115.36,1281.441;Float;False;Property;_MiddleCoverTextureScale;Middle Cover Texture Scale;71;0;Create;True;0;0;False;0;1;1;0;30;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2972;-5458.907,-1474.81;Float;False;Smart Cover (Unmasked);-1;;22264;1da15c5282eb6c04fbee1b4ace7abcc7;0;12;30;FLOAT3;0,0,1;False;26;FLOAT3;0,0.5,0;False;309;FLOAT3;1,0.5,1;False;123;FLOAT3;1,0.5,1;False;167;FLOAT;0.1;False;303;FLOAT;-1000;False;221;FLOAT;1;False;237;FLOAT;10;False;250;FLOAT;0.1;False;251;FLOAT;10;False;239;FLOAT;0.1;False;227;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareLower;2567;-14953.01,5100.66;Float;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2971;-5644.917,558.5893;Float;False;Smart Cover (Unmasked);-1;;22288;1da15c5282eb6c04fbee1b4ace7abcc7;0;12;30;FLOAT3;0,0,1;False;26;FLOAT3;0,0.5,0;False;309;FLOAT3;1,0.5,1;False;123;FLOAT3;1,0.5,1;False;167;FLOAT;0.1;False;303;FLOAT;-1000;False;221;FLOAT;1;False;237;FLOAT;10;False;250;FLOAT;0.1;False;251;FLOAT;10;False;239;FLOAT;0.1;False;227;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2632;-10077.5,769.2342;Float;False;Sum Components 3;-1;;22316;7e94ed8ab59b2174ba15f73cd495eb18;0;1;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareGreater;2491;-4520.891,2564.891;Float;False;4;0;FLOAT;0;False;1;FLOAT;0.01;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareLower;2381;-4779.558,592.7534;Float;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2776;-4609.103,787.7695;Float;False;2771;coverFadeNoise;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2457;-5028.582,-1763.043;Float;False;2718;BottomCoverMaskTolerance;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2463;-9619.315,4959.389;Float;False;topCoverColorSum;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2720;-18541.32,278.8514;Float;False;BottomCoverColorLowThreshold;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2459;-9831.842,776.5052;Float;False;bottomCoverColorSum;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2387;-4574.15,2403.95;Float;False;2211;textureOverlay1Index;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2498;-18555.07,-466.8432;Float;False;TopCoverColorLowThreshold;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1292;-16650.06,1280.841;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareLower;2385;-4613.09,-1511.819;Float;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2778;-4467.526,-1217.925;Float;False;2771;coverFadeNoise;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2490;-4913.035,354.1293;Float;False;2456;TopCoverMaskTolerance;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2562;-14701.33,5112.031;Float;False;noTerrainOverlay1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2501;-4828.95,243.4575;Float;False;2498;TopCoverColorLowThreshold;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;2142;-12038.41,2365.982;Float;False;2944.852;1098.819;;24;2149;2150;2148;2675;2146;2957;2461;2636;2145;2992;2940;2990;2991;2939;2938;2941;2666;2151;2943;2143;2152;2942;2155;2154;Middle Cover;1,0.3710344,0,1;0;0
Node;AmplifyShaderEditor.TFHCCompareGreater;2605;-15751.82,-1259.961;Float;False;4;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2709;-18896.82,-316.2224;Float;False;Property;_MiddleCoverTriplanarContrast;Middle Cover Triplanar Contrast;73;0;Create;True;0;0;False;0;4;50;1;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareGreater;2361;-4362.247,-1617.505;Float;False;4;0;FLOAT;0;False;1;FLOAT;0.01;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2489;-4636.951,141.0104;Float;False;2463;topCoverColorSum;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2499;-4885.316,-1856.583;Float;False;2720;BottomCoverColorLowThreshold;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;2140;-354.8102,-1308.576;Float;False;4047.892;8462.991;Comment;4;2026;2021;662;911;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;2482;-4601.45,-1939.725;Float;False;2459;bottomCoverColorSum;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareLower;2392;-4266.833,2530.049;Float;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2571;-4245.348,2415.733;Float;False;2562;noTerrainOverlay1;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2193;-16394.06,1280.841;Float;False;middleCoverScale;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareGreater;2367;-4540.204,532.0683;Float;False;4;0;FLOAT;0;False;1;FLOAT;0.01;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2154;-11978.42,3115.333;Float;False;2193;middleCoverScale;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2710;-18575.82,-298.2224;Float;False;MiddleCoverTriplanarContrast;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2245;-15463.82,-1259.961;Float;False;middleCoverNormalIndex;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareGreater;2483;-4132.771,-1693.281;Float;False;4;0;FLOAT;0;False;1;FLOAT;0.01;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2244;-15751.82,-603.9609;Float;False;middleCoverBaseColorIndex;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;911;-88.60639,-505.8249;Float;False;3480.313;3180.421;;147;2584;2585;2582;2343;2344;2350;951;2649;2336;1531;1532;1530;2650;1529;2348;2349;1590;2356;1589;2355;1591;2354;1592;1582;2353;856;684;1583;1588;864;2352;2351;1581;2024;2025;2077;2553;2551;2677;2550;2646;914;916;915;2689;2342;2644;965;1577;930;2346;2347;1939;929;2345;928;1615;2811;2812;2814;2815;2816;2817;2818;2819;2820;2821;2822;2823;2824;2825;2826;2827;2828;2829;2830;2831;2832;2833;2834;2835;2836;2837;2838;2839;2840;2841;2842;2844;2845;2846;2847;2843;2848;2849;2850;2851;2852;2853;2854;2855;2856;2857;2858;2859;2860;2861;2862;2863;2864;2865;2866;2867;2868;2869;2870;2871;2872;2873;2874;2875;2876;2877;2878;2879;2880;2881;2882;2883;2884;2886;2887;2889;2890;2891;2892;2893;2899;2900;2901;2902;2903;2904;2905;2906;2907;2908;Pre-Detail Blend;0,0,1,1;0;0
Node;AmplifyShaderEditor.TFHCCompareGreater;2488;-4244.623,445.6913;Float;False;4;0;FLOAT;0;False;1;FLOAT;0.01;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2572;-3976.01,2490.094;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2143;-11948.49,3009.098;Float;False;2710;MiddleCoverTriplanarContrast;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2274;-3972.007,463.2814;Float;False;topCoverAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1615;341.5024,1887.852;Float;False;363.4253;686.1315;;6;2335;2333;2331;1566;2332;2330;Blend Weights;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;851;-3896.746,-1695.905;Float;False;bottomCoverAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2152;-11933.53,2928.568;Float;False;2245;middleCoverNormalIndex;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2151;-11933.53,2848.568;Float;False;2244;middleCoverBaseColorIndex;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2943;-11962.47,2793.403;Float;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SwizzleNode;2155;-11702.71,3100.698;Float;False;FLOAT2;0;1;2;3;1;0;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2288;-3813.027,2551.207;Float;False;terrainOverlay1Alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2942;-11993.51,2755.705;Float;False;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FunctionNode;2666;-11406.74,2825.58;Float;False;Triplanar NormSAO Array Material;0;;22112;2ae230feac7e920499683efd4613d3c2;0;7;835;SAMPLER2D;0;False;938;FLOAT;0;False;837;SAMPLER2D;0;False;939;FLOAT;0;False;927;FLOAT2;0,0;False;926;FLOAT2;1,1;False;925;FLOAT;1;False;5;COLOR;899;FLOAT3;898;FLOAT;900;FLOAT;897;FLOAT;896
Node;AmplifyShaderEditor.RangedFloatNode;2941;-11413.92,2545.238;Float;False;Property;_MiddleCoverValueMultiplier;Middle Cover Value Multiplier;75;0;Create;True;0;0;False;0;1;1;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2938;-11413.92,2465.238;Float;False;Property;_MiddleCoverSaturationMultiplier;Middle Cover Saturation Multiplier;74;0;Create;True;0;0;False;0;1;1;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2939;-11413.92,2625.238;Float;False;Property;_MiddleCoverContrast;Middle Cover Contrast;76;0;Create;True;0;0;False;0;1;1;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;282;-10503.73,5407.505;Float;False;Property;_TopCoverNormalScale;Top Cover Normal Scale;84;0;Create;True;0;0;False;0;1;1;0.1;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;772;-10883.7,6729.573;Float;False;Property;_TerrainOverlayNormalScale;Terrain Overlay Normal Scale;107;0;Create;True;0;0;False;0;1;1;0.1;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2161;-11092.07,1210.839;Float;False;Property;_BottomCoverNormalScale;Bottom Cover Normal Scale;52;0;Create;True;0;0;False;0;1;0.1;0.1;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2146;-10690.92,3160.514;Float;False;Property;_MiddleCoverNormalScale;Middle Cover Normal Scale;72;0;Create;True;0;0;False;0;1;1;0.1;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2685;-11107.03,1296.544;Float;False;2681;normalZReconstructionStyle;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2330;416,2048;Float;False;-1;;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2331;416,2144;Float;False;2274;topCoverAlpha;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2333;416,2352;Float;False;2288;terrainOverlay1Alpha;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1566;416,1952;Float;False;851;bottomCoverAlpha;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2332;416,2240;Float;False;-1;;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2335;416,2448;Float;False;-1;;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2686;-10499.35,5522.108;Float;False;2681;normalZReconstructionStyle;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2957;-10717.78,3058.578;Float;False;2681;normalZReconstructionStyle;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2687;-10868.8,6815.16;Float;False;2681;normalZReconstructionStyle;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2676;-10763.92,1158.297;Float;False;Normal Scale (Unpacked);-1;;22378;6838fae5b50a0ea4b95a3b9f9a4c53ea;0;3;2;FLOAT3;0,0,0;False;37;FLOAT;1;False;43;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;2887;944,1792;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2882;944,1824;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2671;-10186.43,5359.16;Float;False;Normal Scale (Unpacked);-1;;22375;6838fae5b50a0ea4b95a3b9f9a4c53ea;0;3;2;FLOAT3;0,0,0;False;37;FLOAT;1;False;43;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;2893;944,1776;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2883;944,1808;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2881;944,1840;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2673;-10574.69,6696.65;Float;False;Normal Scale (Unpacked);-1;;22390;6838fae5b50a0ea4b95a3b9f9a4c53ea;0;3;2;FLOAT3;0,0,0;False;37;FLOAT;1;False;43;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;2940;-10891.9,2587.081;Float;False;Material Modification;-1;;22212;a3c4b501064391643b3102d29050d33f;0;5;410;COLOR;0,0,0,0;False;430;FLOAT;0;False;431;FLOAT;1;False;432;FLOAT;1;False;443;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2990;-10625.86,2753.336;Float;False;789;mainBaseColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2991;-10673.86,2833.336;Float;False;Property;_MiddleCoverAlbedoMatch;Middle Cover Albedo Match;77;0;Create;True;0;0;False;0;1;0.02;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2675;-10327.18,2979.777;Float;False;Normal Scale (Unpacked);-1;;22381;6838fae5b50a0ea4b95a3b9f9a4c53ea;0;3;2;FLOAT3;0,0,0;False;37;FLOAT;1;False;43;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;2880;944,1856;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2992;-10289.86,2609.336;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;2824;1136,1264;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2891;816,1648;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2828;1200,1328;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;770;-10149.07,6680.493;Float;False;terrainOverlay1Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;2826;1168,1296;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2827;1184,1312;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2884;896,1728;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2892;864,1696;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2829;1216,1344;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;700;-9725.737,5362.155;Float;False;topCoverNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;2890;832,1664;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2825;1152,1280;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2163;-10298.73,1153.305;Float;False;bottomCoverNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;2889;848,1680;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2148;-9845.385,2999.736;Float;False;middleCoverNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;2886;880,1712;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2145;-10046.54,2638.745;Float;False;middleCoverBaseColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2346;-16,224;Float;False;700;topCoverNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;2833;1072,1072;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2345;-16,160;Float;False;2148;middleCoverNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;2818;1488,432;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2831;1024,1024;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2821;1536,480;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2347;-16,416;Float;False;-1;;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;2832;1088,1088;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2835;1040,1040;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2834;1056,1056;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;928;-16,352;Float;False;770;terrainOverlay1Normal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;2830;1008,1008;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;930;-16,32;Float;False;786;mainNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;929;-16,96;Float;False;2163;bottomCoverNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;2819;1504,448;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1939;-16,288;Float;False;-1;;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;2820;1520,464;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2822;1552,496;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2823;1568,512;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1378;-15671.43,608.6871;Float;False;mainObjectScaleF;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2689;2112,288;Float;False;2681;normalZReconstructionStyle;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2817;1344,64;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;662;66.6314,3158.212;Float;False;1812.316;1154.169;;21;2068;2069;2067;588;1379;589;1384;408;877;1655;998;1374;1375;1377;886;885;2691;2690;2910;2911;2912;Detailing;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;2816;1328,48;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2811;1264,-16;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2344;-13.3088,-58.95063;Float;False;-1;;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2644;1675.27,86.26677;Float;False;Layered Blend 6 Vector3;-1;;22393;6ce596bf98b14bb43903d81e00605ad9;0;13;20;FLOAT3;0,0,0;False;14;FLOAT3;0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT3;0,0,0;False;17;FLOAT3;0,0,0;False;19;FLOAT3;0,0,0;False;18;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2342;-16,-384;Float;False;2160;bottomCoverBaseColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;915;-16,-448;Float;False;789;mainBaseColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;916;-16,-320;Float;False;2145;middleCoverBaseColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;2814;1296,16;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2815;1312,32;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2812;1280,0;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;965;2112,192;Float;False;Property;_FinalNormalScale;Final Normal Scale;32;0;Create;True;0;0;False;0;1;3.34;0.1;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2343;-13.3088,-122.9505;Float;False;773;terrainOverlay1BaseColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1577;-16,-256;Float;False;702;topCoverBaseColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;914;-16,-192;Float;False;-1;;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1377;131,3267;Float;False;1378;mainObjectScaleF;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1375;128,3344;Float;False;1313;scaleMultiplier;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;2021;47.02052,4637.055;Float;False;1608.994;457.5406;;7;938;1601;1600;1599;494;490;2647;Camera Detail Fade;1,1,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;2646;1520.666,-373.5315;Float;False;Layered Blend 6 Vector4;-1;;22394;06fa407921a0ca346af979203c094c7b;0;13;20;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT4;0,0,0,0;False;16;FLOAT4;0,0,0,0;False;17;FLOAT4;0,0,0,0;False;19;FLOAT4;0,0,0,0;False;18;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;2677;2512,112;Float;False;Normal Scale (Unpacked);-1;;22395;6838fae5b50a0ea4b95a3b9f9a4c53ea;0;3;2;FLOAT3;0,0,0;False;37;FLOAT;1;False;43;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2551;1920,-256;Float;False;789;mainBaseColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2550;1920,-160;Float;False;Property;_FinalAlbedoMatch;Final Albedo Match;31;0;Create;True;0;0;False;0;1;0.039;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;490;138.2206,4793.013;Float;False;Property;_DetailViewFadeStart;Detail View Fade Start;130;0;Create;True;0;0;False;0;3;10;1;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;494;138.2206,4889.014;Float;False;Property;_DetailViewFadeDistance;Detail View Fade Distance;131;0;Create;True;0;0;False;0;5;20;0;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;2077;2944,112;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;589;96,3936;Float;False;Property;_DetailTiling;Detail Tiling;126;0;Create;True;0;0;False;0;1;0.1;0.1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1374;400,3298;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2553;2268.892,-362.5152;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1415;-11158.95,6776.358;Float;False;terrainOverlay1AO;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2025;2464,-368;Float;False;preDetailBaseColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1379;689.9943,3815.252;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1599;741.0647,4922.019;Float;False;Property;_FinalDetailMultiplier;Final Detail Multiplier;35;0;Create;True;0;0;False;0;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2024;3168,112;Float;False;preDetailNormals;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2691;90.55627,4014.466;Float;False;2681;normalZReconstructionStyle;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1384;96,3856;Float;False;Property;_DetailNormalScale;Detail Normal Scale;129;0;Create;True;0;0;False;0;1.15;1;0.1;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2647;624.5721,4804.015;Float;False;Camera Distance Fade;-1;;22398;2b5f56921ab3ab94bbfa00609d7425b4;0;2;14;FLOAT;10;False;11;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;408;96,3776;Float;False;Property;_DetailBaseColorStrength;Detail Base Color Strength;127;0;Create;True;0;0;False;0;0.25;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;856;-13.3088,1141.049;Float;False;Property;_CoverAOTextureStrength;Cover AO Texture Strength;50;0;Create;True;0;0;False;0;1;0.89;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;588;823.7435,3805.503;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2165;-11397.99,1170.332;Float;False;bottomCoverAO;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1588;-13.3088,1061.049;Float;False;Property;_TerrainAOTextureStrength;Terrain AO Texture Strength;46;0;Create;True;0;0;False;0;1;0.7;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1416;-11135.07,-220.7401;Float;False;mainAO;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2912;641.8571,3709.943;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1600;1055.802,4791.942;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1581;-13.3088,1301.049;Float;False;-1;;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2150;-10952.27,3032.241;Float;False;middleCoverAO;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2353;-13.3088,1621.049;Float;False;-1;;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1582;-12.00881,1557.049;Float;False;1415;terrainOverlay1AO;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2911;606.5521,3757.487;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2069;141,4177;Float;False;2025;preDetailBaseColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;2910;584.5521,3811.487;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1655;96,3504;Float;False;Property;_DetailContrast;Detail Contrast;128;0;Create;True;0;0;False;0;1;0.1;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2067;93,4097;Float;False;1057;TopCoverTriplanarContrast;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;877;96,3584;Float;True;Property;_DetailNormalArray;Detail Normal Array;124;1;[NoScaleOffset];Create;True;0;0;False;0;0aa941ff34c44ab4ca8ff4d116159e89;988043ff4d26f0b40abd1ca5cd3acd6f;True;bump;LockedToTexture2D;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1400;-10801.1,5412.419;Float;False;topCoverAO;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2068;460,4209;Float;False;2024;preDetailNormals;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;998;96,3424;Float;False;Property;_InvertDetails;Invert Details;125;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2356;368,1648;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1601;1195.153,4799.168;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1583;-13.3088,1365.049;Float;False;2165;bottomCoverAO;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2354;370.6912,1237.049;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;684;-13.3088,981.0493;Float;False;Property;_MainAOTextureStrength;Main AO Texture Strength;45;0;Create;True;0;0;False;0;1;0.8;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1592;368,1568;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;864;-13.3088,1237.049;Float;False;1416;mainAO;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2352;-13.3088,1493.049;Float;False;1400;topCoverAO;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2351;-13.3088,1429.049;Float;False;2150;middleCoverAO;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2690;1187.674,3583.805;Float;False;Detail Map;12;;22399;d15fcb35c6ccd7743b7978ab6163c8ac;0;10;80;FLOAT;0;False;153;FLOAT;1;False;98;SAMPLER2D;0;False;71;FLOAT;0.5;False;140;FLOAT;1;False;215;FLOAT;1;False;59;FLOAT2;1,1;False;58;FLOAT;1;False;30;COLOR;0,0,0,0;False;66;FLOAT3;0,0,0;False;2;FLOAT3;0;FLOAT3;22
Node;AmplifyShaderEditor.RegisterLocalVarNode;938;1347.904,4799.054;Float;False;detailFadeAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2905;720,1360;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2904;720,1344;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2355;370.6912,1317.049;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;885;1619.852,3555.675;Float;False;postDetailBaseColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;2903;720,1328;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1589;370.6912,1157.049;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;2026;207.7491,6053.662;Float;False;1118.48;876.4678;Comment;10;2006;941;2028;935;943;939;925;942;2029;962;Post-Detail Fade;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1591;368,1488;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1590;370.6912,1397.049;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2907;768,1344;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2902;720,1312;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2029;358.8391,6168.053;Float;False;2025;preDetailBaseColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;2906;784,1360;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2899;720,1264;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;925;384.2737,6272.696;Float;False;885;postDetailBaseColor;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;2900;720,1280;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;942;436.1107,6365.496;Float;False;938;detailFadeAlpha;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;672;4657.375,-712.8262;Float;False;9135.181;6179.27;;2;799;956;Post Processing;0.5941916,0,1,1;0;0
Node;AmplifyShaderEditor.WireNode;2908;752,1328;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2901;720,1296;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2865;768,1280;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2873;1072,2032;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2867;752,1264;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2870;1072,2080;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2869;1072,2096;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2868;1072,2112;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2839;1008,2352;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2862;832,1344;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2864;784,1296;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2872;1072,2048;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2836;1008,2400;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2838;1008,2368;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2871;1072,2064;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;956;4902.165,183.306;Float;False;2607.505;2478.919;;3;958;675;872;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;2861;848,1360;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;939;796.933,6136.655;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;2866;816,1328;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2841;1008,2320;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2840;1008,2336;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2837;1008,2384;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2863;800,1312;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2876;1008,1952;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2856;1872,1376;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2847;1472,1856;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;675;5044.841,540.2442;Float;False;1656.459;639.7336;;11;870;2337;1594;995;687;688;685;1593;865;871;2652;Ambient Occlusion;1,0,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;799;8386.605,1753.434;Float;False;3053.429;2739.5;;36;2653;987;988;2591;2590;2700;2702;2701;2509;2579;2506;1898;2505;1882;2608;2411;2511;1902;2587;1854;1807;1537;2507;1534;2508;2415;2586;2588;626;632;2611;2613;2609;2614;2704;2705;Wetness;0,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;2853;1824,1328;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2854;1840,1344;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;872;4995.916,1378.986;Float;False;2413.7;528.272;;6;959;271;960;2694;2693;2695;Base Color;1,0,0,1;0;0
Node;AmplifyShaderEditor.WireNode;2874;1008,1984;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2878;1008,1920;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;943;1015.952,6149.453;Float;False;postFadeBaseColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;2843;1408,1792;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2769;-18409.76,4359.349;Float;False;Property;_WetnessTerrainNoiseStrength;Wetness Terrain Noise Strength;149;0;Create;True;0;0;False;0;0;0.51;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2582;1408,2272;Float;False;6;6;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2842;1392,1776;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2850;1776,1280;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1417;-11234.84,-110.494;Float;False;mainSmoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1401;-10853.05,5505.333;Float;False;topCoverSmoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2875;1008,1968;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2164;-11470.71,1286.395;Float;False;bottomCoverSmoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2149;-11015.38,3148.047;Float;False;middleCoverSmoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2877;1008,1936;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2845;1440,1824;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2855;1856,1360;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1414;-11213.61,6872.434;Float;False;terrainOverlay1Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2852;1808,1312;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2879;1008,1904;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2851;1792,1296;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2844;1424,1808;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2846;1456,1840;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2349;-16,704;Float;False;1401;topCoverSmoothness;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;687;5121.039,729.5071;Float;False;Property;_MeshAOContrast;Mesh AO Contrast;144;0;Create;True;0;0;False;0;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1530;-13.3088,837.0493;Float;False;1414;terrainOverlay1Smoothness;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2694;5392,1648;Float;False;Property;_FinalSaturationMultiplier;Final Saturation Multiplier;28;0;Create;True;0;0;False;0;1.1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2614;8496.281,3975.196;Float;False;Property;_EnableUV1WWetness;Enable UV1 W Wetness;169;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;960;5265.816,1455.426;Float;False;943;postFadeBaseColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;685;5098.938,994.9083;Float;False;Property;_MeshAOStrength;Mesh AO Strength;147;0;Create;True;0;0;False;0;1;0.31;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2859;1312,1568;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2848;1264,1520;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2770;-17697.64,4152.529;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2585;1584,2256;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2858;1328,1584;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;1925;-18450.64,4111.15;Float;True;Property;_TerrainWetnessData;Terrain Wetness Data;155;1;[NoScaleOffset];Create;True;0;0;False;0;None;81bd0787394d1d84c9ccf1fcf3b16f6b;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;995;5091.977,895.4664;Float;False;Property;_OnlyBoostDarkMeshAO;Only Boost Dark Mesh AO;146;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2860;1296,1552;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2849;1280,1536;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2650;2495.953,976.1379;Float;False;Layered Blend 6 Float;-1;;22446;170c7cd50f31a2c4eafaa0836cfbc891;0;13;20;FLOAT;0;False;14;FLOAT;0;False;15;FLOAT;0;False;16;FLOAT;0;False;17;FLOAT;0;False;19;FLOAT;0;False;18;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2350;-13.3088,901.0493;Float;False;-1;;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;271;5393.872,1808.372;Float;False;Property;_FinalColorContrast;Final Color Contrast;30;0;Create;True;0;0;False;0;1.1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2857;1344,1600;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2348;-16,640;Float;False;2149;middleCoverSmoothness;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;2609;8494.146,4061.61;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1531;-16,576;Float;False;2164;bottomCoverSmoothness;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2695;5392,1728;Float;False;Property;_FinalValueMultiplier;Final Value Multiplier;29;0;Create;True;0;0;False;0;1.1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;688;5147.039,812.5081;Float;False;Property;_MeshAODarknessBoost;MeshAO Darkness Boost;145;0;Create;True;0;0;False;0;0;0;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1529;-13.3088,517.0493;Float;False;1417;mainSmoothness;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1532;-16,768;Float;False;-1;;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2591;8558.213,3502.205;Float;False;Property;_CoverWaterDarknessModifier;Cover Water Darkness Modifier;141;0;Create;True;0;0;False;0;0.01;0.99;0.2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2336;2816,976;Float;False;postFadeAO;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2760;-17465.47,3865.252;Float;False;Terrain Awareness Map;-1;;22451;c3df2b1a31343934bb908013141a0a1c;0;8;15;SAMPLER2D;0;False;23;FLOAT2;4096,4096;False;39;FLOAT;1;False;14;FLOAT2;2048,2048;False;18;FLOAT;255;False;19;FLOAT;255;False;20;FLOAT;255;False;21;FLOAT;255;False;5;COLOR;30;FLOAT;24;FLOAT;25;FLOAT;26;FLOAT;27
Node;AmplifyShaderEditor.RangedFloatNode;2579;8558.213,3678.205;Float;False;Property;_WaterSmoothnessPower;Water Smoothness Power;142;0;Create;True;0;0;False;0;1;0.322;0.25;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2415;8558.213,3422.205;Float;False;Property;_WaterDarkeningPower;Water Darkening Power;140;0;Create;True;0;0;False;0;1;1;0.25;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2652;5493.938,779.908;Float;False;Vertex Color Ambient Occlusion;-1;;22448;9a96686797e0dc14f80bb3f27fa4f274;0;4;4;FLOAT;0.5;False;7;FLOAT;0.01;False;9;FLOAT;1;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2590;8558.213,3774.205;Float;False;Property;_CoverWaterSmoothnessMultiplier;Cover Water Smoothness Multiplier;143;0;Create;True;0;0;False;0;0.01;0.547;0.2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2649;2496,464;Float;False;Layered Blend 6 Float;-1;;22450;170c7cd50f31a2c4eafaa0836cfbc891;0;13;20;FLOAT;0;False;14;FLOAT;0;False;15;FLOAT;0;False;16;FLOAT;0;False;17;FLOAT;0;False;19;FLOAT;0;False;18;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareGreater;2613;8859.776,4124.572;Float;False;4;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2693;6158.111,1486.86;Float;False;Material Modification;-1;;22447;a3c4b501064391643b3102d29050d33f;0;5;410;COLOR;0,0,0,0;False;430;FLOAT;0;False;431;FLOAT;1;False;432;FLOAT;1;False;443;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2584;1744,2256;Float;False;totalCoverAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1926;-16739.2,3998.127;Float;False;terrainPuddles;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1927;-16772.2,4213.227;Float;False;terrainNeighoringWaterData;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1918;-16754.2,3933.227;Float;False;terrainWetness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1481;-16756.2,4108.229;Float;False;terrainWater;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;959;7012.337,1473.544;Float;False;preWetnessAlbedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;626;8665.061,2041.418;Float;False;Property;_SurfacePorosity;Surface Porosity;138;0;Create;True;0;0;False;0;0.01;0.01;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2337;5840.352,617.7039;Float;False;2336;postFadeAO;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2611;9141.916,4114.819;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;886;1627.277,3641.545;Float;False;postDetailNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCCompareLower;1594;5893.78,762.4603;Float;False;4;0;FLOAT;0;False;1;FLOAT;0.01;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2701;8619.171,3586.306;Float;False;2584;totalCoverAlpha;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2704;8899.271,3754.508;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;951;2816,464;Float;False;postFadeSmoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;632;8907.142,4017.692;Float;False;Property;_DebugWetness;Debug Wetness;168;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2586;8663.035,2142.348;Float;False;Property;_CoverSurfacePorosity;Cover Surface Porosity;139;0;Create;True;0;0;False;0;0.01;0.05;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2705;8859.271,3492.508;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2588;8690.334,2237.248;Float;False;2584;totalCoverAlpha;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2506;9085.374,1881.917;Float;False;959;preWetnessAlbedo;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;2508;8777.576,3070.076;Float;False;Property;_RainYRangeLowHigh;Rain Y Range (Low High);136;0;Create;True;0;0;False;0;0,0;-0.5,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;935;333.1619,6696.697;Float;False;886;postDetailNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2411;8934.39,2411.404;Float;False;1481;terrainWater;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;2608;9318.394,4023.748;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1882;8801.062,3332.718;Float;False;Property;_WaterNeighborImpact;Water Neighbor Impact;137;0;Create;True;0;0;False;0;1;0.1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1898;8786.647,2849.207;Float;False;1313;scaleMultiplier;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2587;9129.734,2150.147;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2509;9025.68,3068.994;Float;False;1926;terrainPuddles;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1537;8766.547,2740.006;Float;False;Property;_WaterFadeRange;Water Fade Range;134;0;Create;True;0;0;False;0;1;5;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2702;9198.213,3422.205;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2507;9038.733,1997.758;Float;False;951;postFadeSmoothness;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2028;334.5623,6588.002;Float;False;2024;preDetailNormals;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2511;9303.235,2617.505;Float;False;1918;terrainWetness;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1807;8786.626,3220.542;Float;False;1927;terrainNeighoringWaterData;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1902;8688.147,2955.707;Float;False;Property;_WaterRangeScaleIncrease;Water Range Scale Increase;135;0;Create;True;0;0;False;0;1;0.1;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1593;6123.661,743.0296;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2700;9198.213,3678.205;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2505;9049.131,2326.492;Float;False;1480;terrainHeight;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;941;344.2078,6796.588;Float;False;938;detailFadeAlpha;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;870;5918.955,962.8987;Float;False;Property;_FinalAOMultiplier;Final AO Multiplier;34;0;Create;True;0;0;False;0;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1534;8865.861,2510.118;Float;False;Property;_WaterHeightOffset;Water Height Offset;132;0;Create;True;0;0;False;0;0.1;0.2;-5;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1854;8784.047,2637.007;Float;False;Property;_WaterDirectContactArea;Water Direct Contact Area;133;0;Create;True;0;0;False;0;1;0.5;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;978;6385.233,5954.129;Float;False;3858.716;2043.979;;1;665;;0,0,0,1;0;0
Node;AmplifyShaderEditor.LerpOp;2006;763.4514,6573.494;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;871;6268.271,853.0447;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2653;10199.94,2341.278;Float;False;Wetness (Comprehensive);-1;;22452;7a7a57f555ad7184cacf97219a2557d7;0;19;8;COLOR;0.6415094,0.638396,0.3419366,0;False;10;FLOAT;0.2;False;11;FLOAT;0;False;12;FLOAT;0.1;False;99;FLOAT;100;False;89;FLOAT;99;False;91;FLOAT;0.1;False;95;FLOAT;1;False;187;FLOAT;1;False;84;FLOAT;1;False;78;FLOAT;1;False;79;FLOAT;1;False;86;FLOAT;0.1;False;132;FLOAT2;0,1;False;90;FLOAT;0.1;False;93;FLOAT;1;False;80;FLOAT;0.8;False;215;FLOAT;0.95;False;92;FLOAT;0;False;2;COLOR;0;FLOAT;21
Node;AmplifyShaderEditor.RegisterLocalVarNode;987;10953.81,2308.753;Float;False;finalAlbedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;665;6483.242,6149.963;Float;False;3447.136;1585.344;;20;2444;0;1605;1604;1603;1542;1606;1609;2451;1235;1607;1236;2446;2445;1992;2443;977;976;975;968;Output;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;988;11023.96,2499.618;Float;False;finalSmoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;962;996.1668,6571.393;Float;False;finalNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;865;6440.056,851.6238;Float;False;finalAO;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2443;8102.387,6198.103;Float;False;Property;_DebugMode;Debug Mode;170;0;Create;True;0;0;False;0;0;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;976;7383.802,6952.615;Float;False;865;finalAO;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;968;7844.28,6634.464;Float;False;962;finalNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;975;7429.394,6834.615;Float;False;988;finalSmoothness;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;977;7835.015,6449.555;Float;False;987;finalAlbedo;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2442;-16583.14,3444.82;Float;False;terrainSupplementalData;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2441;-16599.68,3847.56;Float;False;terrainWetnessData;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1607;7999.015,7025.057;Float;False;Constant;_Color1;Color 1;182;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;958;5088.034,2033.504;Float;False;1538.045;285.5723;;8;974;973;972;479;480;971;970;969;Smoothness;0.002349854,0,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;1609;8183.256,6446.183;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RoundOpNode;2451;8943.449,6627.016;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2654;8151.485,6579.68;Float;False;Normal Pack;-1;;22458;505170751a054f248b165a75f7b6efb7;0;1;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;1235;7783.49,6836.482;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1236;7767.296,6943.615;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1606;8211.741,7116.711;Float;False;Constant;_Color0;Color 0;182;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;2445;8097.079,6290.883;Float;False;2442;terrainSupplementalData;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2446;8117.786,6367.303;Float;False;2441;terrainWetnessData;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector3Node;1992;8133.537,6724.26;Float;False;Constant;_Vector0;Vector 0;199;0;Create;True;0;0;False;0;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;479;5792.034,2113.504;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchNode;1604;8615.642,6845.965;Float;False;0;2;8;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchNode;1605;8615.642,6973.965;Float;False;0;2;8;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2714;-18549.32,-77.14909;Float;False;MiddleCoverColorLowThreshold;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2461;-9527.443,2651.138;Float;False;middleCoverColorSum;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2636;-9754.192,2648.847;Float;False;Sum Components 3;-1;;22341;7e94ed8ab59b2174ba15f73cd495eb18;0;1;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2309;-10120.16,3985.845;Float;False;middleCoverAlphaMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2713;-18917.32,-77.14909;Float;False;Property;_MiddleCoverColorLowThreshold;Middle Cover Color Low Threshold;79;0;Create;True;0;0;False;0;0.02;0.084;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;970;5382.034,2213.504;Float;False;False;False;False;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;972;5952.036,2113.504;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;2242;-14510.07,5577.301;Float;False;True;False;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2711;-18917.3,-201.8263;Float;False;Property;_MiddleCoverMaskTolerance;Middle Cover Mask Tolerance;78;0;Create;True;0;0;False;0;0.02;0;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2712;-18530.1,-171.4262;Float;False;MiddleCoverMaskTolerance;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2243;-16114.48,-374.1086;Float;False;Constant;_DetailIndex;Detail Index;199;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2780;-16533.97,3631.611;Float;False;terrainBaseSplat;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;973;6112.036,2113.504;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2229;-14302.07,5577.301;Float;False;textureOverlay2Index;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2113;-10666.56,-485.4556;Float;False;mainNormalUnnormalized;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;971;5600.034,2209.504;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1542;8801.567,6789.261;Float;False;const;-1;;22461;5b64729fb717c5f49a1bc2dab81d5e1c;1,3,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;969;5108.034,2217.504;Float;False;951;postFadeSmoothness;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;974;6304.036,2112.504;Float;False;preWetnessSmoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchNode;1603;8615.642,6645.964;Float;False;0;4;8;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RoundOpNode;2779;-16703.62,3643.957;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2444;8708.078,6469.883;Float;False;Enum Switch;-1;;22460;d0ffb2eb7ab9dbe45bba7a4f97d686ac;1,34,2;12;25;FLOAT;0;False;7;FLOAT;0;False;29;FLOAT;0;False;8;COLOR;0,0,0,0;False;18;FLOAT;0;False;28;FLOAT;0;False;17;FLOAT;0;False;10;FLOAT3;0,0,0;False;30;FLOAT;0;False;11;COLOR;0,0,0,0;False;20;FLOAT;0;False;15;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;480;5120.034,2113.504;Float;False;Property;_FinalRoughnessMultiplier;Final Roughness Multiplier;33;0;Create;True;0;0;False;0;1;1.2;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2196;-16390.23,1656.505;Float;False;terrainOverlay2Scale;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2192;-16646.23,1656.505;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2174;-17110.23,1640.505;Float;False;Property;_TerrainOverlay2TextureScale;Terrain Overlay 2 Texture Scale;123;0;Create;True;0;0;False;0;1;5;0;30;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2123;-15907.25,-365.6264;Float;False;detailIndex;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;8991.833,6715.943;Float;False;True;3;Float;ASEMaterialInspector;0;0;Standard;internal/debris;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;Back;0;False;-1;3;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;4;10;25;False;0.5;True;0;4;False;-1;1;False;-1;0;0;False;-1;0;False;-1;1;False;-1;1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;3;Pragma;instancing_options procedural:setup;False;;Custom;Pragma;multi_compile GPU_FRUSTUM_ON __;False;;Custom;Include;VS_indirect.cginc;True;b9eaad53950bfdf4abeba7e786c39119;Custom;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2752;0;2757;0
WireConnection;2752;1;2756;0
WireConnection;2753;0;2752;0
WireConnection;2557;0;1310;0
WireConnection;2767;0;2753;0
WireConnection;1311;0;1283;0
WireConnection;1311;1;2557;0
WireConnection;2762;15;1922;0
WireConnection;2762;23;1921;0
WireConnection;2762;39;2768;0
WireConnection;2762;14;1475;0
WireConnection;2762;18;2440;0
WireConnection;2762;19;2440;0
WireConnection;2762;20;2439;0
WireConnection;2762;21;2439;0
WireConnection;1312;0;1311;0
WireConnection;2452;0;2762;24
WireConnection;1361;0;1312;0
WireConnection;1361;1;1312;1
WireConnection;1928;0;2452;0
WireConnection;1362;0;1361;0
WireConnection;1362;1;1312;2
WireConnection;1662;1;1362;0
WireConnection;1313;0;1662;0
WireConnection;712;0;1013;0
WireConnection;2132;0;1011;0
WireConnection;713;0;1014;0
WireConnection;715;0;660;0
WireConnection;714;0;640;0
WireConnection;2201;0;2199;0
WireConnection;2202;0;2201;0
WireConnection;2203;7;2202;0
WireConnection;2203;8;2215;1
WireConnection;2203;10;2215;2
WireConnection;2203;11;2215;3
WireConnection;2203;15;2215;4
WireConnection;1012;0;2133;0
WireConnection;1012;2;746;1
WireConnection;1012;3;746;2
WireConnection;2135;0;2133;0
WireConnection;2135;2;2136;1
WireConnection;2135;3;2136;2
WireConnection;1322;0;1279;0
WireConnection;1322;1;1318;0
WireConnection;2617;214;729;0
WireConnection;2617;216;734;0
WireConnection;2617;142;735;0
WireConnection;2617;102;736;0
WireConnection;2617;220;737;0
WireConnection;1281;0;1278;0
WireConnection;1281;1;1314;0
WireConnection;1320;0;1322;0
WireConnection;1320;1;1322;0
WireConnection;731;0;2617;0
WireConnection;731;2;2617;95
WireConnection;2205;7;2202;0
WireConnection;2205;8;2214;1
WireConnection;2205;10;2214;2
WireConnection;2205;11;2214;3
WireConnection;2205;15;2214;4
WireConnection;2204;0;2201;0
WireConnection;2204;3;2203;0
WireConnection;738;0;2136;1
WireConnection;738;1;2135;0
WireConnection;738;2;746;1
WireConnection;738;3;1012;0
WireConnection;1324;0;1320;0
WireConnection;1324;1;2434;0
WireConnection;1288;0;756;0
WireConnection;1288;1;1281;0
WireConnection;2206;7;2202;0
WireConnection;2206;8;2213;1
WireConnection;2206;10;2213;2
WireConnection;2206;11;2213;3
WireConnection;2206;15;2213;4
WireConnection;2207;0;2201;0
WireConnection;2207;3;2205;0
WireConnection;2207;4;2204;0
WireConnection;1008;0;2436;0
WireConnection;1008;2;731;0
WireConnection;1008;3;738;0
WireConnection;2208;0;2201;0
WireConnection;2208;3;2206;0
WireConnection;2208;4;2207;0
WireConnection;1274;0;1324;0
WireConnection;2209;7;2202;0
WireConnection;2209;8;2212;1
WireConnection;2209;10;2212;2
WireConnection;2209;11;2212;3
WireConnection;2209;15;2212;4
WireConnection;745;0;1008;0
WireConnection;1323;0;756;0
WireConnection;1323;1;1288;0
WireConnection;2603;0;2607;0
WireConnection;2603;2;745;0
WireConnection;2603;3;745;1
WireConnection;1003;0;2133;0
WireConnection;1003;2;2432;1
WireConnection;1003;3;2432;2
WireConnection;2210;0;2201;0
WireConnection;2210;3;2209;0
WireConnection;2210;4;2208;0
WireConnection;1273;0;1323;0
WireConnection;2433;0;2133;0
WireConnection;2433;2;727;1
WireConnection;2433;3;727;2
WireConnection;2515;0;2189;0
WireConnection;2515;1;2514;0
WireConnection;2240;0;2210;0
WireConnection;2138;0;2432;1
WireConnection;2138;1;1003;0
WireConnection;2138;2;727;1
WireConnection;2138;3;2433;0
WireConnection;732;0;2617;97
WireConnection;732;2;2617;96
WireConnection;750;0;745;0
WireConnection;751;0;2603;0
WireConnection;2537;0;2536;0
WireConnection;2618;245;2240;0
WireConnection;2618;142;2396;0
WireConnection;2618;102;2395;0
WireConnection;2618;220;2397;0
WireConnection;1663;0;1327;0
WireConnection;1009;0;2436;0
WireConnection;1009;2;732;0
WireConnection;1009;3;2138;0
WireConnection;2191;0;2189;0
WireConnection;2191;1;2173;0
WireConnection;2516;0;2515;0
WireConnection;2195;0;2191;0
WireConnection;744;0;1009;0
WireConnection;2241;0;2618;0
WireConnection;2670;835;188;0
WireConnection;2670;938;795;0
WireConnection;2670;837;189;0
WireConnection;2670;939;792;0
WireConnection;2670;926;1663;0
WireConnection;2670;925;1056;0
WireConnection;2681;0;2680;0
WireConnection;2190;0;2189;0
WireConnection;2190;1;1042;0
WireConnection;2175;0;2189;0
WireConnection;2175;1;1043;0
WireConnection;2517;0;2518;0
WireConnection;2696;410;2670;899
WireConnection;2696;431;2697;0
WireConnection;2696;432;2698;0
WireConnection;2696;443;2699;0
WireConnection;1057;0;1055;0
WireConnection;2211;0;2241;0
WireConnection;2722;0;2721;0
WireConnection;2121;0;744;2
WireConnection;2679;2;2670;898
WireConnection;2679;37;788;0
WireConnection;2679;43;2682;0
WireConnection;1665;0;1293;0
WireConnection;1330;0;1328;0
WireConnection;1330;1;2696;0
WireConnection;2741;0;2517;0
WireConnection;2741;1;2740;0
WireConnection;2194;0;2190;0
WireConnection;1275;0;2175;0
WireConnection;2604;0;2607;0
WireConnection;2604;2;745;2
WireConnection;2604;3;745;3
WireConnection;2958;0;290;0
WireConnection;2606;0;2607;0
WireConnection;2606;2;744;2
WireConnection;2606;3;744;3
WireConnection;2122;0;2606;0
WireConnection;2112;0;2679;0
WireConnection;2664;835;290;0
WireConnection;2664;938;779;0
WireConnection;2664;837;287;0
WireConnection;2664;939;779;0
WireConnection;2664;926;1665;0
WireConnection;2664;925;1059;0
WireConnection;741;0;2604;0
WireConnection;2716;0;2715;0
WireConnection;740;0;745;2
WireConnection;2662;835;2958;0
WireConnection;2662;899;2996;0
WireConnection;2662;890;2741;0
WireConnection;2662;889;1058;0
WireConnection;789;0;1330;0
WireConnection;2737;0;2662;846
WireConnection;2936;410;2664;899
WireConnection;2936;431;2934;0
WireConnection;2936;432;2937;0
WireConnection;2936;443;2935;0
WireConnection;786;0;2112;0
WireConnection;2761;15;1922;0
WireConnection;2761;23;1921;0
WireConnection;2761;14;1475;0
WireConnection;2761;18;2440;0
WireConnection;2761;19;2440;0
WireConnection;2761;20;2439;0
WireConnection;2761;21;2439;0
WireConnection;2764;0;2757;0
WireConnection;2764;1;2763;0
WireConnection;2170;0;2169;0
WireConnection;2944;0;290;0
WireConnection;1666;0;1291;0
WireConnection;2955;0;287;0
WireConnection;2667;835;2944;0
WireConnection;2667;938;760;0
WireConnection;2667;837;2955;0
WireConnection;2667;939;761;0
WireConnection;2667;926;1666;0
WireConnection;2667;925;2953;0
WireConnection;1480;0;2761;25
WireConnection;2739;0;2737;0
WireConnection;2739;1;2738;0
WireConnection;2986;0;2936;0
WireConnection;2986;1;2984;0
WireConnection;2986;2;2985;0
WireConnection;2773;0;2764;0
WireConnection;2312;0;2664;899
WireConnection;2668;835;290;0
WireConnection;2668;938;2166;0
WireConnection;2668;837;287;0
WireConnection;2668;939;2167;0
WireConnection;2668;926;2170;0
WireConnection;2668;925;2158;0
WireConnection;2952;410;2668;899
WireConnection;2952;431;2949;0
WireConnection;2952;432;2951;0
WireConnection;2952;443;2950;0
WireConnection;2735;1;2739;0
WireConnection;2735;0;2736;0
WireConnection;2313;0;2312;0
WireConnection;2772;0;2773;0
WireConnection;2772;1;2750;0
WireConnection;773;0;2986;0
WireConnection;2927;1;2276;0
WireConnection;2927;2;2922;0
WireConnection;2947;410;2667;899
WireConnection;2947;431;2945;0
WireConnection;2947;432;2948;0
WireConnection;2947;443;2946;0
WireConnection;2771;0;2772;0
WireConnection;2724;0;2723;0
WireConnection;2970;30;2927;0
WireConnection;2970;26;2277;0
WireConnection;2970;309;2278;0
WireConnection;2970;123;2980;0
WireConnection;2970;167;2279;0
WireConnection;2970;303;2280;0
WireConnection;2970;221;2281;0
WireConnection;2970;237;2282;0
WireConnection;2970;250;2283;0
WireConnection;2970;251;2284;0
WireConnection;2970;239;2285;0
WireConnection;2970;227;2286;0
WireConnection;2305;0;2668;899
WireConnection;2308;0;2735;0
WireConnection;2627;1;773;0
WireConnection;2995;0;2952;0
WireConnection;2995;1;2993;0
WireConnection;2995;2;2994;0
WireConnection;2989;0;2947;0
WireConnection;2989;1;2987;0
WireConnection;2989;2;2988;0
WireConnection;2307;0;2305;0
WireConnection;2311;0;2308;0
WireConnection;2726;0;2725;0
WireConnection;2465;0;2627;0
WireConnection;702;0;2989;0
WireConnection;2925;1;1135;0
WireConnection;2925;2;2920;0
WireConnection;2382;0;2324;0
WireConnection;2382;1;2970;0
WireConnection;2926;1;2262;0
WireConnection;2926;2;2921;0
WireConnection;2160;0;2995;0
WireConnection;2718;0;2717;0
WireConnection;2456;0;2455;0
WireConnection;2633;1;702;0
WireConnection;2370;0;2324;0
WireConnection;2370;1;2733;0
WireConnection;2370;2;2382;0
WireConnection;2370;3;2775;0
WireConnection;2972;30;2925;0
WireConnection;2972;26;1131;0
WireConnection;2972;309;1132;0
WireConnection;2972;123;2976;0
WireConnection;2972;167;1128;0
WireConnection;2972;303;1514;0
WireConnection;2972;221;1159;0
WireConnection;2972;237;1272;0
WireConnection;2972;250;1271;0
WireConnection;2972;251;1336;0
WireConnection;2972;239;1339;0
WireConnection;2972;227;1263;0
WireConnection;2567;0;2210;0
WireConnection;2971;30;2926;0
WireConnection;2971;26;2263;0
WireConnection;2971;309;2264;0
WireConnection;2971;123;2979;0
WireConnection;2971;167;2265;0
WireConnection;2971;303;2266;0
WireConnection;2971;221;2267;0
WireConnection;2971;237;2268;0
WireConnection;2971;250;2269;0
WireConnection;2971;251;2270;0
WireConnection;2971;239;2271;0
WireConnection;2971;227;2272;0
WireConnection;2632;1;2160;0
WireConnection;2491;0;2492;0
WireConnection;2491;1;2734;0
WireConnection;2491;2;2370;0
WireConnection;2381;0;2321;0
WireConnection;2381;1;2971;0
WireConnection;2463;0;2633;0
WireConnection;2720;0;2719;0
WireConnection;2459;0;2632;0
WireConnection;2498;0;2497;0
WireConnection;1292;0;2189;0
WireConnection;1292;1;2172;0
WireConnection;2385;0;2316;0
WireConnection;2385;1;2972;0
WireConnection;2562;0;2567;0
WireConnection;2605;0;2607;0
WireConnection;2605;2;744;0
WireConnection;2605;3;744;1
WireConnection;2361;0;2316;0
WireConnection;2361;1;2457;0
WireConnection;2361;2;2385;0
WireConnection;2361;3;2778;0
WireConnection;2392;0;2387;0
WireConnection;2392;3;2491;0
WireConnection;2193;0;1292;0
WireConnection;2367;0;2321;0
WireConnection;2367;1;2490;0
WireConnection;2367;2;2381;0
WireConnection;2367;3;2776;0
WireConnection;2710;0;2709;0
WireConnection;2245;0;2605;0
WireConnection;2483;0;2482;0
WireConnection;2483;1;2499;0
WireConnection;2483;2;2361;0
WireConnection;2244;0;744;0
WireConnection;2488;0;2489;0
WireConnection;2488;1;2501;0
WireConnection;2488;2;2367;0
WireConnection;2572;0;2571;0
WireConnection;2572;1;2392;0
WireConnection;2274;0;2488;0
WireConnection;851;0;2483;0
WireConnection;2943;0;287;0
WireConnection;2155;0;2154;0
WireConnection;2288;0;2572;0
WireConnection;2942;0;290;0
WireConnection;2666;835;2942;0
WireConnection;2666;938;2151;0
WireConnection;2666;837;2943;0
WireConnection;2666;939;2152;0
WireConnection;2666;926;2155;0
WireConnection;2666;925;2143;0
WireConnection;2676;2;2668;898
WireConnection;2676;37;2161;0
WireConnection;2676;43;2685;0
WireConnection;2887;0;2330;0
WireConnection;2882;0;2332;0
WireConnection;2671;2;2667;898
WireConnection;2671;37;282;0
WireConnection;2671;43;2686;0
WireConnection;2893;0;1566;0
WireConnection;2883;0;2331;0
WireConnection;2881;0;2333;0
WireConnection;2673;2;2664;898
WireConnection;2673;37;772;0
WireConnection;2673;43;2687;0
WireConnection;2940;410;2666;899
WireConnection;2940;431;2938;0
WireConnection;2940;432;2941;0
WireConnection;2940;443;2939;0
WireConnection;2675;2;2666;898
WireConnection;2675;37;2146;0
WireConnection;2675;43;2957;0
WireConnection;2880;0;2335;0
WireConnection;2992;0;2940;0
WireConnection;2992;1;2990;0
WireConnection;2992;2;2991;0
WireConnection;2824;0;2893;0
WireConnection;2891;0;1566;0
WireConnection;2828;0;2881;0
WireConnection;770;0;2673;0
WireConnection;2826;0;2883;0
WireConnection;2827;0;2882;0
WireConnection;2884;0;2335;0
WireConnection;2892;0;2332;0
WireConnection;2829;0;2880;0
WireConnection;700;0;2671;0
WireConnection;2890;0;2330;0
WireConnection;2825;0;2887;0
WireConnection;2163;0;2676;0
WireConnection;2889;0;2331;0
WireConnection;2148;0;2675;0
WireConnection;2886;0;2333;0
WireConnection;2145;0;2992;0
WireConnection;2833;0;2886;0
WireConnection;2818;0;2824;0
WireConnection;2831;0;2890;0
WireConnection;2821;0;2827;0
WireConnection;2832;0;2884;0
WireConnection;2835;0;2889;0
WireConnection;2834;0;2892;0
WireConnection;2830;0;2891;0
WireConnection;2819;0;2825;0
WireConnection;2820;0;2826;0
WireConnection;2822;0;2828;0
WireConnection;2823;0;2829;0
WireConnection;1378;0;1278;0
WireConnection;2817;0;2832;0
WireConnection;2816;0;2833;0
WireConnection;2811;0;2830;0
WireConnection;2644;20;930;0
WireConnection;2644;14;929;0
WireConnection;2644;15;2345;0
WireConnection;2644;16;2346;0
WireConnection;2644;17;1939;0
WireConnection;2644;19;928;0
WireConnection;2644;18;2347;0
WireConnection;2644;1;2818;0
WireConnection;2644;2;2819;0
WireConnection;2644;3;2820;0
WireConnection;2644;4;2821;0
WireConnection;2644;5;2822;0
WireConnection;2644;6;2823;0
WireConnection;2814;0;2835;0
WireConnection;2815;0;2834;0
WireConnection;2812;0;2831;0
WireConnection;2646;20;915;0
WireConnection;2646;14;2342;0
WireConnection;2646;15;916;0
WireConnection;2646;16;1577;0
WireConnection;2646;17;914;0
WireConnection;2646;19;2343;0
WireConnection;2646;18;2344;0
WireConnection;2646;1;2811;0
WireConnection;2646;2;2812;0
WireConnection;2646;3;2814;0
WireConnection;2646;4;2815;0
WireConnection;2646;5;2816;0
WireConnection;2646;6;2817;0
WireConnection;2677;2;2644;0
WireConnection;2677;37;965;0
WireConnection;2677;43;2689;0
WireConnection;2077;0;2677;0
WireConnection;1374;0;1377;0
WireConnection;1374;1;1375;0
WireConnection;2553;0;2646;0
WireConnection;2553;1;2551;0
WireConnection;2553;2;2550;0
WireConnection;1415;0;2664;900
WireConnection;2025;0;2553;0
WireConnection;1379;0;1374;0
WireConnection;1379;1;589;0
WireConnection;2024;0;2077;0
WireConnection;2647;14;490;0
WireConnection;2647;11;494;0
WireConnection;588;0;1379;0
WireConnection;588;1;1379;0
WireConnection;2165;0;2668;900
WireConnection;1416;0;2670;900
WireConnection;2912;0;408;0
WireConnection;1600;0;1599;0
WireConnection;1600;1;2647;0
WireConnection;2150;0;2666;900
WireConnection;2911;0;1384;0
WireConnection;2910;0;2691;0
WireConnection;1400;0;2667;900
WireConnection;2356;0;2353;0
WireConnection;2356;1;856;0
WireConnection;1601;0;1600;0
WireConnection;2354;0;1581;0
WireConnection;2354;1;1588;0
WireConnection;1592;0;1582;0
WireConnection;1592;1;856;0
WireConnection;2690;80;998;0
WireConnection;2690;153;1655;0
WireConnection;2690;98;877;0
WireConnection;2690;71;2912;0
WireConnection;2690;140;2911;0
WireConnection;2690;215;2910;0
WireConnection;2690;59;588;0
WireConnection;2690;58;2067;0
WireConnection;2690;30;2069;0
WireConnection;2690;66;2068;0
WireConnection;938;0;1601;0
WireConnection;2905;0;2356;0
WireConnection;2904;0;1592;0
WireConnection;2355;0;1583;0
WireConnection;2355;1;856;0
WireConnection;885;0;2690;0
WireConnection;2903;0;2354;0
WireConnection;1589;0;864;0
WireConnection;1589;1;684;0
WireConnection;1591;0;2352;0
WireConnection;1591;1;856;0
WireConnection;1590;0;2351;0
WireConnection;1590;1;856;0
WireConnection;2907;0;2904;0
WireConnection;2902;0;1591;0
WireConnection;2906;0;2905;0
WireConnection;2899;0;1589;0
WireConnection;2900;0;2355;0
WireConnection;2908;0;2903;0
WireConnection;2901;0;1590;0
WireConnection;2865;0;2900;0
WireConnection;2873;0;1566;0
WireConnection;2867;0;2899;0
WireConnection;2870;0;2332;0
WireConnection;2869;0;2333;0
WireConnection;2868;0;2335;0
WireConnection;2839;0;2331;0
WireConnection;2862;0;2907;0
WireConnection;2864;0;2901;0
WireConnection;2872;0;2330;0
WireConnection;2836;0;2335;0
WireConnection;2838;0;2332;0
WireConnection;2871;0;2331;0
WireConnection;2861;0;2906;0
WireConnection;939;0;2029;0
WireConnection;939;1;925;0
WireConnection;939;2;942;0
WireConnection;2866;0;2908;0
WireConnection;2841;0;1566;0
WireConnection;2840;0;2330;0
WireConnection;2837;0;2333;0
WireConnection;2863;0;2902;0
WireConnection;2876;0;2332;0
WireConnection;2856;0;2861;0
WireConnection;2847;0;2868;0
WireConnection;2853;0;2863;0
WireConnection;2854;0;2866;0
WireConnection;2874;0;2335;0
WireConnection;2878;0;2330;0
WireConnection;943;0;939;0
WireConnection;2843;0;2872;0
WireConnection;2582;0;2841;0
WireConnection;2582;1;2840;0
WireConnection;2582;2;2839;0
WireConnection;2582;3;2838;0
WireConnection;2582;4;2837;0
WireConnection;2582;5;2836;0
WireConnection;2842;0;2873;0
WireConnection;2850;0;2867;0
WireConnection;1417;0;2670;897
WireConnection;1401;0;2667;897
WireConnection;2875;0;2333;0
WireConnection;2164;0;2668;897
WireConnection;2149;0;2666;897
WireConnection;2877;0;2331;0
WireConnection;2845;0;2870;0
WireConnection;2855;0;2862;0
WireConnection;1414;0;2664;897
WireConnection;2852;0;2864;0
WireConnection;2879;0;1566;0
WireConnection;2851;0;2865;0
WireConnection;2844;0;2871;0
WireConnection;2846;0;2869;0
WireConnection;2859;0;2876;0
WireConnection;2848;0;2879;0
WireConnection;2770;0;2769;0
WireConnection;2770;1;2768;0
WireConnection;2585;0;2582;0
WireConnection;2858;0;2875;0
WireConnection;2860;0;2877;0
WireConnection;2849;0;2878;0
WireConnection;2650;20;2850;0
WireConnection;2650;14;2851;0
WireConnection;2650;15;2852;0
WireConnection;2650;16;2853;0
WireConnection;2650;17;2854;0
WireConnection;2650;19;2855;0
WireConnection;2650;18;2856;0
WireConnection;2650;1;2842;0
WireConnection;2650;2;2843;0
WireConnection;2650;3;2844;0
WireConnection;2650;4;2845;0
WireConnection;2650;5;2846;0
WireConnection;2650;6;2847;0
WireConnection;2857;0;2874;0
WireConnection;2336;0;2650;0
WireConnection;2760;15;1925;0
WireConnection;2760;23;1921;0
WireConnection;2760;39;2770;0
WireConnection;2760;14;1475;0
WireConnection;2760;18;2439;0
WireConnection;2760;19;2439;0
WireConnection;2760;20;2440;0
WireConnection;2760;21;2439;0
WireConnection;2652;4;687;0
WireConnection;2652;7;688;0
WireConnection;2652;9;995;0
WireConnection;2652;2;685;0
WireConnection;2649;20;1529;0
WireConnection;2649;14;1531;0
WireConnection;2649;15;2348;0
WireConnection;2649;16;2349;0
WireConnection;2649;17;1532;0
WireConnection;2649;19;1530;0
WireConnection;2649;18;2350;0
WireConnection;2649;1;2848;0
WireConnection;2649;2;2849;0
WireConnection;2649;3;2860;0
WireConnection;2649;4;2859;0
WireConnection;2649;5;2858;0
WireConnection;2649;6;2857;0
WireConnection;2613;0;2614;0
WireConnection;2613;2;2609;4
WireConnection;2693;410;960;0
WireConnection;2693;431;2694;0
WireConnection;2693;432;2695;0
WireConnection;2693;443;271;0
WireConnection;2584;0;2585;0
WireConnection;1926;0;2760;25
WireConnection;1927;0;2760;27
WireConnection;1918;0;2760;24
WireConnection;1481;0;2760;26
WireConnection;959;0;2693;0
WireConnection;2611;0;2613;0
WireConnection;886;0;2690;22
WireConnection;1594;0;2652;0
WireConnection;1594;3;2652;0
WireConnection;2704;0;2579;0
WireConnection;2704;1;2590;0
WireConnection;951;0;2649;0
WireConnection;2705;0;2415;0
WireConnection;2705;1;2591;0
WireConnection;2608;0;632;0
WireConnection;2608;1;2611;0
WireConnection;2587;0;626;0
WireConnection;2587;1;2586;0
WireConnection;2587;2;2588;0
WireConnection;2702;0;2415;0
WireConnection;2702;1;2705;0
WireConnection;2702;2;2701;0
WireConnection;1593;0;2337;0
WireConnection;1593;1;1594;0
WireConnection;2700;0;2579;0
WireConnection;2700;1;2704;0
WireConnection;2700;2;2701;0
WireConnection;2006;0;2028;0
WireConnection;2006;1;935;0
WireConnection;2006;2;941;0
WireConnection;871;0;1593;0
WireConnection;871;1;870;0
WireConnection;2653;8;2506;0
WireConnection;2653;10;2507;0
WireConnection;2653;12;2587;0
WireConnection;2653;99;2505;0
WireConnection;2653;89;2411;0
WireConnection;2653;91;1534;0
WireConnection;2653;95;1854;0
WireConnection;2653;187;2511;0
WireConnection;2653;84;1537;0
WireConnection;2653;78;1898;0
WireConnection;2653;79;1902;0
WireConnection;2653;86;2509;0
WireConnection;2653;132;2508;0
WireConnection;2653;90;1807;0
WireConnection;2653;93;1882;0
WireConnection;2653;80;2702;0
WireConnection;2653;215;2700;0
WireConnection;2653;92;2608;0
WireConnection;987;0;2653;0
WireConnection;988;0;2653;21
WireConnection;962;0;2006;0
WireConnection;865;0;871;0
WireConnection;2442;0;2761;30
WireConnection;2441;0;2760;30
WireConnection;1609;0;977;0
WireConnection;2451;0;2443;0
WireConnection;2654;2;968;0
WireConnection;1235;0;975;0
WireConnection;1236;0;976;0
WireConnection;479;0;480;0
WireConnection;479;1;971;0
WireConnection;1604;0;1235;0
WireConnection;1604;1;1606;0
WireConnection;1605;0;1236;0
WireConnection;1605;1;1607;0
WireConnection;2714;0;2713;0
WireConnection;2461;0;2636;0
WireConnection;2636;1;2145;0
WireConnection;2309;0;2308;0
WireConnection;970;0;969;0
WireConnection;972;0;479;0
WireConnection;2242;0;2618;95
WireConnection;2712;0;2711;0
WireConnection;2780;0;2779;0
WireConnection;973;0;972;0
WireConnection;2229;0;2242;0
WireConnection;2113;0;2679;0
WireConnection;971;0;970;0
WireConnection;974;0;973;0
WireConnection;1603;0;968;0
WireConnection;1603;2;1992;0
WireConnection;2779;0;2761;24
WireConnection;2444;7;2451;0
WireConnection;2444;8;1609;0
WireConnection;2444;10;2654;0
WireConnection;2444;11;2445;0
WireConnection;2444;15;2446;0
WireConnection;2196;0;2192;0
WireConnection;2192;0;2189;0
WireConnection;2192;1;2174;0
WireConnection;2123;0;2243;0
WireConnection;0;0;2444;0
WireConnection;0;1;1603;0
WireConnection;0;3;1542;0
WireConnection;0;4;1604;0
WireConnection;0;5;1605;0
ASEEND*/
//CHKSM=1B68E1D57A66F02709365DA120C020B7012CC281