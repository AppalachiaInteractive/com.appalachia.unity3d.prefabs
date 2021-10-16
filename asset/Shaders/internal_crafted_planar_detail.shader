// Upgrade NOTE: upgraded instancing buffer 'internalcrafted_planar_detail' to new syntax.

Shader "internal/crafted_planar_detail"
{
	Properties
	{
		[InternalBanner(Internal,Standard)]_BANNER("BANNER", Float) = 1
		[InternalCategory(Rendering)]_RENDERINGG("[ RENDERINGG  ]", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("Cull Mode", Float) = 2
		_MaskClipValue("Mask Clip Value", Range( 0 , 1)) = 0.5
		[Toggle]_AlphaToCoverage("Alpha To Coverage", Float) = 0
		[Toggle]_ZWriteMode("ZWrite Mode", Float) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTest Mode", Float) = 4
		[InternalCategory(Planar)]_PLANARR("[ PLANARR ]", Float) = 0
		[Enum(ZY,0,XZ,1,XY,2)]_PlanarAxis("Planar Axis", Int) = 0
		_TextureOffset("Texture Offset", Vector) = (0,0,0,0)
		_TextureScale("Texture Scale", Vector) = (1,1,0,0)
		[Toggle]_FlipXY("Flip XY", Float) = 0
		[InternalCategory(Main Texture)]_MAINTEXX("[ MAINTEXX ]", Float) = 0
		_MainTex("Albedo", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,0)
		_Saturation("Saturation", Range( -1 , 4)) = 0
		_Brightness("Brightness", Range( -1 , 4)) = 0
		_Contrast("Contrast", Range( 0 , 10)) = 1
		_ContrastCorrection("Contrast Correction", Range( 0 , 10)) = 1
		_EmissionColor("Emission Color", Color) = (0,0,0,0)
		_EmissionStrength("Emission Strength", Range( 0 , 5)) = 1
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_OcclusionStrength("Occlusion", Range( 0 , 1)) = 1
		_Glossiness("Smoothness", Range( 0 , 1)) = 0.1
		[InternalCategory(Detail Texture)]_MAINTEXXDetail("[ MAINTEXX ]", Float) = 0
		_MainTexDetail("Albedo", 2D) = "white" {}
		_ColorDetail("Color", Color) = (1,1,1,0)
		_SaturationDetail("Saturation", Range( -1 , 4)) = 0
		_BrightnessDetail("Brightness", Range( -1 , 4)) = 0
		_ContrastDetail("Contrast", Range( 0 , 10)) = 1
		_ContrastCorrectionDetail("Contrast Correction", Range( 0 , 10)) = 1
		[NoScaleOffset][Normal]_BumpMapDetail("Normal", 2D) = "bump" {}
		_BumpScaleDetail("Normal Scale", Range( 0 , 5)) = 1
		_EmissionColorDetail("Emission Color", Color) = (0,0,0,0)
		_EmissionStrengthDetail("Emission Strength", Range( 0 , 5)) = 1
		_MetallicDetail("Metallic", Range( 0 , 1)) = 0
		_OcclusionStrengthDetail("Occlusion", Range( 0 , 1)) = 1
		_GlossinessDetail("Smoothness", Range( 0 , 1)) = 0.1
		[InternalCategory(Occlusion Probes)]_OCCLUSIONPROBESS("[ OCCLUSION PROBESS  ]", Float) = 0
		[InternalCategory(Occlusion)]_OCCLUSIONN("[ OCCLUSIONN ]", Float) = 0
		_Occlusion("Texture Occlusion", Range( 0 , 1)) = 0.5
		_AOProbeStrength("AO Probe Strength", Range( 0 , 1)) = 0.8
		_AOIndirect("AO Indirect", Range( 0 , 1)) = 1
		_AODirect("AO Direct", Range( 0 , 1)) = 0
		[InternalCategory(Burn)]_BURNN("[ BURNN ]", Float) = 0
		_CharColor1("Char Color 1", Color) = (0.3098039,0.3098039,0.3098039,1)
		_CharColor2("Char Color 2", Color) = (0.1333333,0.1333333,0.1333333,1)
		_BurnColor1("Burn Color 1", Color) = (1,0.5137255,0,1)
		_BurnColor2("Burn Color 2", Color) = (1,0.1137255,0,1)
		[NoScaleOffset]_BurnMap("Burn Map", 2D) = "white" {}
		_BurnMapScaleX("Burn Map Scale X", Range( 0.1 , 5)) = 1
		_BurnMapScaleY("Burn Map Scale Y", Range( 0.1 , 5)) = 1
		[NoScaleOffset][Normal]_CharNormal("Char Normal", 2D) = "bump" {}
		_CharredNormalScale("Charred Normal Scale", Range( 0 , 5)) = 1
		[NoScaleOffset]_BurnNoise("Burn Noise", 2D) = "white" {}
		_BurnNoiseScaleX("Burn Noise Scale X", Range( 0.1 , 5)) = 1
		_BurnNoiseScaleY("Burn Noise Scale Y", Range( 0.1 , 5)) = 1
		_BurnSpeed("Burn Speed", Range( 0.01 , 2)) = 0.01
		_EmissionContrast("Emission Contrast", Range( 0 , 3)) = 2.5
		_GlowPower("Glow Power", Range( 0 , 10)) = 1
		_GlowBias("Glow Bias", Range( -0.5 , 0.5)) = 0
		_GlowScale("Glow Scale", Range( 0 , 2)) = 1
		[PerRendererData]_Burned("Burned", Range( 0 , 1)) = 0
		[PerRendererData]_Heat("Heat", Range( 0 , 1)) = 0
		[PerRendererData]_WindProtection("Wind Protection", Range( 0 , 1)) = 0
		[InternalCategory(Wettable)]_WETT("[ WETT ]", Float) = 0
		[Toggle(_WETTABLE_ON)] _Wettable("Wettable", Float) = 0
		[PerRendererData]_Wetness("Wetness", Range( 0 , 1)) = 0
		[PerRendererData]_RainWetness("Rain Wetness", Range( 0 , 1)) = 0
		[PerRendererData]_SubmersionWetness("Submersion Wetness", Range( 0 , 1)) = 0
		[InternalCategory(Wetness)]_WETNESS("[ WETNESS ]", Float) = 0
		_WetnessDarkening("Wetness Darkening", Range( 0 , 0.93)) = 0.65
		_WetnessSmoothness("Wetness Smoothness", Range( 0 , 1)) = 0.3
		_WetnessPorosity("Wetness Porosity", Range( 0 , 1)) = 0.1
		[Toggle(_BURNABLE_ON)] _Burnable("Burnable", Float) = 0
		[InternalCategory(Global Illumination)]_GLOBALILLUMINATIONN("[ GLOBAL ILLUMINATIONN ]", Float) = 0
		_GlobalIlluminationAlbedoEffect("Global Illumination Albedo Effect", Range( 0 , 5)) = 1
		_GlobalIlluminationEmissiveEffect("Global Illumination Emissive Effect", Range( 0 , 5)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex3coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "InternalOpaque"  "Queue" = "Geometry+0" "DisableBatching" = "True" "IsEmissive" = "true"  }
		Cull [_CullMode]
		ZWrite [_ZWriteMode]
		ZTest [_ZTestMode]
		AlphaToMask [_AlphaToCoverage]
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "Lighting.cginc"
		#pragma target 4.5
		#pragma multi_compile_instancing
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#pragma shader_feature_local _BURNABLE_ON
		#pragma shader_feature_local _WETTABLE_ON
		 
		// INTERNAL_SHADER_FEATURE_START
		// INTERNAL_SHADER_FEATURE_END
		  
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
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 uv_tex3coord;
			float3 worldNormal;
			INTERNAL_DATA
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform half _MAINTEXX;
		uniform half _PLANARR;
		uniform half _OCCLUSIONN;
		uniform half _WETNESS;
		uniform half _BURNN;
		uniform half _BANNER;
		uniform float _AlphaToCoverage;
		uniform half _RENDERINGG;
		uniform half _WETT;
		uniform float _CullMode;
		uniform half _GLOBALILLUMINATIONN;
		uniform float _MaskClipValue;
		uniform float _ZWriteMode;
		uniform float _ZTestMode;
		uniform half _OCCLUSIONPROBESS;
		uniform half _MAINTEXXDetail;
		uniform float _GlobalIlluminationAlbedoEffect;
		uniform float _OcclusionStrength;
		uniform float _OcclusionStrengthDetail;
		uniform sampler2D _MainTexDetail;
		uniform float4 _MainTexDetail_ST;
		uniform half _Occlusion;
		uniform float4x4 _OcclusionProbesWorldToLocal;
		uniform sampler3D _OcclusionProbes;
		uniform float _AOProbeStrength;
		uniform float _OCCLUSION_PROBE_GLOBAL;
		uniform float _AOIndirect;
		uniform float _AODirect;
		uniform float _Contrast;
		uniform sampler2D _MainTex;
		uniform float2 _TextureOffset;
		uniform float2 _TextureScale;
		uniform int _PlanarAxis;
		uniform float _FlipXY;
		uniform float4 _Color;
		uniform float _Saturation;
		uniform float _Brightness;
		uniform float _ContrastCorrection;
		uniform float _ContrastDetail;
		uniform float4 _ColorDetail;
		uniform float _SaturationDetail;
		uniform float _BrightnessDetail;
		uniform float _ContrastCorrectionDetail;
		uniform half4 _BurnColor2;
		uniform sampler2D _BurnMap;
		uniform float _BurnMapScaleX;
		uniform float _BurnMapScaleY;
		uniform float _BurnSpeed;
		uniform sampler2D _BurnNoise;
		uniform float _BurnNoiseScaleX;
		uniform float _BurnNoiseScaleY;
		uniform half4 _BurnColor1;
		uniform half4 _CharColor2;
		uniform half4 _CharColor1;
		uniform float _WetnessDarkening;
		uniform float _Metallic;
		uniform float _MetallicDetail;
		uniform float _Glossiness;
		uniform float _GlossinessDetail;
		uniform float _WetnessPorosity;
		uniform sampler2D _BumpMapDetail;
		uniform float _BumpScaleDetail;
		uniform half _CharredNormalScale;
		uniform sampler2D _CharNormal;
		uniform float _GlobalIlluminationEmissiveEffect;
		uniform float4 _EmissionColor;
		uniform float _EmissionStrength;
		uniform float4 _EmissionColorDetail;
		uniform float _EmissionStrengthDetail;
		uniform float _GlowBias;
		uniform float _GlowScale;
		uniform float _GlowPower;
		uniform float _GLOBAL_SOLAR_TIME;
		uniform float _EmissionContrast;
		uniform half _WIND_GUST_AMPLITUDE;
		uniform half _WIND_GUST_AUDIO_STRENGTH;
		uniform half _WIND_AUDIO_INFLUENCE;
		uniform half _WIND_GUST_AUDIO_STRENGTH_VERYHIGH;
		uniform half _WIND_GUST_AUDIO_STRENGTH_HIGH;
		uniform float _WetnessSmoothness;

		UNITY_INSTANCING_BUFFER_START(internalcrafted_planar_detail)
			UNITY_DEFINE_INSTANCED_PROP(float4, _OcclusionProbes_ST)
#define _OcclusionProbes_ST_arr internalcrafted_planar_detail
			UNITY_DEFINE_INSTANCED_PROP(half, _Heat)
#define _Heat_arr internalcrafted_planar_detail
			UNITY_DEFINE_INSTANCED_PROP(half, _Burned)
#define _Burned_arr internalcrafted_planar_detail
			UNITY_DEFINE_INSTANCED_PROP(float, _Wetness)
#define _Wetness_arr internalcrafted_planar_detail
			UNITY_DEFINE_INSTANCED_PROP(float, _SubmersionWetness)
#define _SubmersionWetness_arr internalcrafted_planar_detail
			UNITY_DEFINE_INSTANCED_PROP(float, _RainWetness)
#define _RainWetness_arr internalcrafted_planar_detail
			UNITY_DEFINE_INSTANCED_PROP(half, _WindProtection)
#define _WindProtection_arr internalcrafted_planar_detail
		UNITY_INSTANCING_BUFFER_END(internalcrafted_planar_detail)


		float SampleOcclusionProbes( float3 positionWS , float4x4 OcclusionProbesWorldToLocal , float OcclusionProbes )
		{
			float occlusionProbes = 1;
			float3 pos = mul(_OcclusionProbesWorldToLocal, float4(positionWS, 1)).xyz;
			occlusionProbes = tex3D(_OcclusionProbes, pos).a;
			return occlusionProbes;
		}


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

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef UNITY_PASS_FORWARDBASE
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			#if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
			half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
			float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
			float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
			ase_lightAtten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
			#endif
			SurfaceOutputStandard s1_g21557 = (SurfaceOutputStandard ) 0;
			float temp_output_36_0_g21529 = 1.0;
			float2 uv0_MainTexDetail = i.uv_texcoord * _MainTexDetail_ST.xy + _MainTexDetail_ST.zw;
			float2 UV2_g20324 = uv0_MainTexDetail;
			float4 tex2DNode20_g20324 = tex2D( _MainTexDetail, UV2_g20324 );
			float temp_output_390_56 = tex2DNode20_g20324.a;
			float lerpResult375 = lerp( _OcclusionStrength , _OcclusionStrengthDetail , temp_output_390_56);
			float lerpResult38_g21529 = lerp( temp_output_36_0_g21529 , lerpResult375 , _Occlusion);
			float3 ase_worldPos = i.worldPos;
			float3 positionWS3_g21532 = ase_worldPos;
			float4x4 OcclusionProbesWorldToLocal3_g21532 = _OcclusionProbesWorldToLocal;
			float4 _OcclusionProbes_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_OcclusionProbes_ST_arr, _OcclusionProbes_ST);
			float3 uv_OcclusionProbes3 = i.uv_tex3coord;
			uv_OcclusionProbes3.xy = i.uv_tex3coord.xy * _OcclusionProbes_ST_Instance.xy + _OcclusionProbes_ST_Instance.zw;
			float OcclusionProbes3_g21532 = tex3D( _OcclusionProbes, uv_OcclusionProbes3 ).r;
			float localSampleOcclusionProbes3_g21532 = SampleOcclusionProbes( positionWS3_g21532 , OcclusionProbesWorldToLocal3_g21532 , OcclusionProbes3_g21532 );
			float lerpResult1_g21532 = lerp( 1.0 , localSampleOcclusionProbes3_g21532 , ( _AOProbeStrength * _OCCLUSION_PROBE_GLOBAL ));
			float temp_output_7_0_g21529 = ( saturate( ( lerpResult38_g21529 * temp_output_36_0_g21529 ) ) * lerpResult1_g21532 );
			float lerpResult18_g21529 = lerp( 1.0 , temp_output_7_0_g21529 , _AOIndirect);
			float lerpResult14_g21529 = lerp( 1.0 , temp_output_7_0_g21529 , _AODirect);
			float lerpResult1_g21529 = lerp( lerpResult18_g21529 , lerpResult14_g21529 , ase_lightAtten);
			float temp_output_16_0_g21529 = saturate( lerpResult1_g21529 );
			float temp_output_88_0_g21522 = _Contrast;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float3 break29_g21526 = ase_vertex3Pos;
			float2 appendResult11_g21526 = (float2(break29_g21526.z , break29_g21526.y));
			float2 temp_output_30_0_g21526 = _TextureOffset;
			float2 temp_output_31_0_g21526 = _TextureScale;
			float2 appendResult13_g21526 = (float2(break29_g21526.x , break29_g21526.z));
			float temp_output_25_0_g21528 = (float)_PlanarAxis;
			float2 lerpResult24_g21528 = lerp( ( ( appendResult11_g21526 + temp_output_30_0_g21526 ) / temp_output_31_0_g21526 ) , ( ( appendResult13_g21526 + temp_output_30_0_g21526 ) / temp_output_31_0_g21526 ) , saturate( temp_output_25_0_g21528 ));
			float2 appendResult10_g21526 = (float2(break29_g21526.x , break29_g21526.y));
			float2 lerpResult21_g21528 = lerp( lerpResult24_g21528 , ( ( appendResult10_g21526 + temp_output_30_0_g21526 ) / temp_output_31_0_g21526 ) , step( 2.0 , temp_output_25_0_g21528 ));
			half2 THREE27_g21528 = lerpResult21_g21528;
			float2 temp_output_49_0_g21526 = THREE27_g21528;
			float2 lerpResult31_g21527 = lerp( temp_output_49_0_g21526 , (temp_output_49_0_g21526).yx , _FlipXY);
			half2 TWO33_g21527 = lerpResult31_g21527;
			float2 UV2_g21521 = TWO33_g21527;
			float4 tex2DNode20_g21521 = tex2D( _MainTex, UV2_g21521 );
			float4 temp_output_89_0_g21522 = ( tex2DNode20_g21521 * _Color );
			float3 hsvTorgb92_g21522 = RGBToHSV( temp_output_89_0_g21522.rgb );
			float temp_output_118_0_g21522 = 1.0;
			float3 hsvTorgb83_g21522 = HSVToRGB( float3(hsvTorgb92_g21522.x,( hsvTorgb92_g21522.y * ( temp_output_118_0_g21522 + _Saturation ) ),( hsvTorgb92_g21522.z * ( temp_output_118_0_g21522 + _Brightness ) )) );
			float temp_output_2_0_g21524 = _ContrastCorrection;
			float temp_output_88_0_g20325 = _ContrastDetail;
			float4 temp_output_89_0_g20325 = ( tex2DNode20_g20324 * _ColorDetail );
			float3 hsvTorgb92_g20325 = RGBToHSV( temp_output_89_0_g20325.rgb );
			float temp_output_118_0_g20325 = 1.0;
			float3 hsvTorgb83_g20325 = HSVToRGB( float3(hsvTorgb92_g20325.x,( hsvTorgb92_g20325.y * ( temp_output_118_0_g20325 + _SaturationDetail ) ),( hsvTorgb92_g20325.z * ( temp_output_118_0_g20325 + _BrightnessDetail ) )) );
			float temp_output_2_0_g20327 = _ContrastCorrectionDetail;
			float4 lerpResult372 = lerp( (CalculateContrast(temp_output_88_0_g21522,( float4( hsvTorgb83_g21522 , 0.0 ) * ( 1.0 / (( temp_output_2_0_g21524 == 0.0 ) ? 1.0 :  temp_output_2_0_g21524 ) ) ))).rgba , (CalculateContrast(temp_output_88_0_g20325,( float4( hsvTorgb83_g20325 , 0.0 ) * ( 1.0 / (( temp_output_2_0_g20327 == 0.0 ) ? 1.0 :  temp_output_2_0_g20327 ) ) ))).rgba , temp_output_390_56);
			float3 temp_output_262_31 = ( temp_output_16_0_g21529 * lerpResult372.rgb );
			float4 color73_g21543 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
			float2 appendResult22_g21533 = (float2(_BurnMapScaleX , _BurnMapScaleY));
			float2 uv_TexCoord24_g21533 = i.uv_texcoord * appendResult22_g21533;
			float4 tex2DNode34_g21533 = tex2D( _BurnMap, uv_TexCoord24_g21533 );
			half AlbedoTex5_Blue36_g21533 = tex2DNode34_g21533.b;
			float mulTime7_g21533 = _Time.y * _BurnSpeed;
			float2 appendResult3_g21533 = (float2(_BurnNoiseScaleX , _BurnNoiseScaleY));
			float2 uv_TexCoord5_g21533 = i.uv_texcoord * appendResult3_g21533;
			float4 tex2DNode11_g21533 = tex2D( _BurnNoise, uv_TexCoord5_g21533 );
			float clampResult8_g21534 = clamp( sin( ( mulTime7_g21533 + ( tex2DNode11_g21533.g * ( 2.0 * UNITY_PI ) ) + ( 0.5 * UNITY_PI ) ) ) , -1.0 , 1.0 );
			float temp_output_26_0_g21533 = ( ( clampResult8_g21534 * 0.5 ) + 0.5 );
			float4 temp_output_41_0_g21533 = ( _BurnColor2 * AlbedoTex5_Blue36_g21533 * temp_output_26_0_g21533 );
			half AlbedoTex5_Green44_g21533 = tex2DNode34_g21533.g;
			float clampResult8_g21541 = clamp( sin( ( mulTime7_g21533 + ( tex2DNode11_g21533.b * ( 2.0 * UNITY_PI ) ) + ( 1.0 * UNITY_PI ) ) ) , -1.0 , 1.0 );
			half AlbedoTex5_Red38_g21533 = tex2DNode34_g21533.r;
			float4 blendOpSrc58_g21533 = ( _BurnColor2 * AlbedoTex5_Green44_g21533 * ( ( ( ( clampResult8_g21541 * 0.5 ) + 0.5 ) * 0.5 ) + 0.5 ) );
			float4 blendOpDest58_g21533 = ( _BurnColor1 * AlbedoTex5_Red38_g21533 * ( ( temp_output_26_0_g21533 * 0.5 ) + 0.5 ) );
			float4 blendOpSrc63_g21533 = temp_output_41_0_g21533;
			float4 blendOpDest63_g21533 = ( saturate( ( 1.0 - ( 1.0 - blendOpSrc58_g21533 ) * ( 1.0 - blendOpDest58_g21533 ) ) ));
			half _Heat_Instance = UNITY_ACCESS_INSTANCED_PROP(_Heat_arr, _Heat);
			half Heat_Strength56_g21533 = _Heat_Instance;
			float4 lerpResult69_g21533 = lerp( float4( 0,0,0,0 ) , ( saturate( 2.0f*blendOpDest63_g21533*blendOpSrc63_g21533 + blendOpDest63_g21533*blendOpDest63_g21533*(1.0f - 2.0f*blendOpSrc63_g21533) )) , Heat_Strength56_g21533);
			float4 blendOpSrc62_g21533 = ( _CharColor2 * AlbedoTex5_Green44_g21533 );
			float4 blendOpDest62_g21533 = ( _CharColor1 * AlbedoTex5_Red38_g21533 );
			half _Burned_Instance = UNITY_ACCESS_INSTANCED_PROP(_Burned_arr, _Burned);
			half Burn_Strength64_g21533 = _Burned_Instance;
			float4 lerpResult74_g21533 = lerp( lerpResult69_g21533 , ( ( saturate( ( blendOpSrc62_g21533 + blendOpDest62_g21533 ) )) * ( ( AlbedoTex5_Blue36_g21533 * 0.5 ) + 0.5 ) ) , Burn_Strength64_g21533);
			float4 appendResult83_g21533 = (float4(lerpResult74_g21533.rgb , 1.0));
			float4 Burn_Tex88_g21533 = appendResult83_g21533;
			float _Wetness_Instance = UNITY_ACCESS_INSTANCED_PROP(_Wetness_arr, _Wetness);
			float temp_output_118_0_g21533 = _Wetness_Instance;
			float blend_strength79_g21543 = saturate( ( max( Burn_Strength64_g21533 , Heat_Strength56_g21533 ) * ( 1.0 - temp_output_118_0_g21533 ) ) );
			float4 lerpResult43_g21543 = lerp( ( float4( temp_output_262_31 , 0.0 ) * color73_g21543 ) , ( float4( Burn_Tex88_g21533.xyz , 0.0 ) * color73_g21543 ) , blend_strength79_g21543);
			float4 temp_output_166_0_g21533 = lerpResult43_g21543;
			#ifdef _BURNABLE_ON
				float3 staticSwitch276 = (temp_output_166_0_g21533).rgb;
			#else
				float3 staticSwitch276 = temp_output_262_31;
			#endif
			float lerpResult374 = lerp( _Metallic , _MetallicDetail , temp_output_390_56);
			float lerpResult106_g21543 = lerp( lerpResult374 , 1.0 , blend_strength79_g21543);
			#ifdef _BURNABLE_ON
				float staticSwitch278 = lerpResult106_g21543;
			#else
				float staticSwitch278 = lerpResult374;
			#endif
			float lerpResult377 = lerp( _Glossiness , _GlossinessDetail , temp_output_390_56);
			float lerpResult31_g21543 = lerp( lerpResult377 , 0.35 , blend_strength79_g21543);
			#ifdef _BURNABLE_ON
				float staticSwitch281 = lerpResult31_g21543;
			#else
				float staticSwitch281 = lerpResult377;
			#endif
			float temp_output_10_0_g21555 = staticSwitch281;
			float lerpResult18_g21555 = lerp( 1.0 , ( 1.0 - _WetnessDarkening ) , ( ( 1.0 - staticSwitch278 ) * saturate( ( ( ( 1.0 - temp_output_10_0_g21555 ) - 0.5 ) / max( _WetnessPorosity , 0.001 ) ) ) ));
			float3 temp_output_390_58 = UnpackScaleNormal( tex2D( _BumpMapDetail, UV2_g20324 ), _BumpScaleDetail );
			float3 temp_output_4_0_g21544 = temp_output_390_58;
			float3 a13_g21544 = temp_output_4_0_g21544;
			float2 uv_CharNormal81_g21533 = i.uv_texcoord;
			half3 CharNormal85_g21533 = UnpackScaleNormal( tex2D( _CharNormal, uv_CharNormal81_g21533 ), _CharredNormalScale );
			float3 temp_output_5_0_g21544 = CharNormal85_g21533;
			float3 ab14_g21544 = BlendNormals( temp_output_4_0_g21544 , temp_output_5_0_g21544 );
			float temp_output_21_0_g21544 = saturate( blend_strength79_g21543 );
			float3 lerpResult8_g21544 = lerp( a13_g21544 , ab14_g21544 , temp_output_21_0_g21544);
			float3 b19_g21544 = temp_output_5_0_g21544;
			float3 lerpResult22_g21544 = lerp( lerpResult8_g21544 , b19_g21544 , saturate( ( ( temp_output_21_0_g21544 * 2.0 ) - 1.0 ) ));
			float3 normalizeResult11_g21544 = normalize( lerpResult22_g21544 );
			#ifdef _BURNABLE_ON
				float3 staticSwitch277 = normalizeResult11_g21544;
			#else
				float3 staticSwitch277 = temp_output_390_58;
			#endif
			float _SubmersionWetness_Instance = UNITY_ACCESS_INSTANCED_PROP(_SubmersionWetness_arr, _SubmersionWetness);
			float _RainWetness_Instance = UNITY_ACCESS_INSTANCED_PROP(_RainWetness_arr, _RainWetness);
			float Wetness_Strength298 = _Wetness_Instance;
			float temp_output_24_0_g21553 = max( max( ( normalize( (WorldNormalVector( i , staticSwitch277 )) ).y * _SubmersionWetness_Instance ) , _RainWetness_Instance ) , ( Wetness_Strength298 * 0.0 ) );
			float lerpResult22_g21555 = lerp( 1.0 , lerpResult18_g21555 , temp_output_24_0_g21553);
			#ifdef _WETTABLE_ON
				float4 staticSwitch307 = ( float4( staticSwitch276 , 0.0 ) * lerpResult22_g21555 );
			#else
				float4 staticSwitch307 = float4( staticSwitch276 , 0.0 );
			#endif
			float3 albedo51_g21557 = staticSwitch307.rgb;
			s1_g21557.Albedo = albedo51_g21557;
			float3 normalizeResult195_g21557 = normalize( staticSwitch277 );
			float3 normal_TS54_g21557 = normalizeResult195_g21557;
			s1_g21557.Normal = WorldNormalVector( i , normal_TS54_g21557 );
			float4 lerpResult373 = lerp( ( _EmissionColor * _EmissionStrength ) , ( _EmissionColorDetail * _EmissionStrengthDetail ) , temp_output_390_56);
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV122_g21533 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode122_g21533 = ( _GlowBias + _GlowScale * pow( 1.0 - fresnelNdotV122_g21533, _GlowPower ) );
			float4 blendOpSrc84_g21533 = temp_output_41_0_g21533;
			float4 blendOpDest84_g21533 = float4( 0,0,0,0 );
			float4 appendResult87_g21533 = (float4(( saturate( (( blendOpSrc84_g21533 > 0.5 ) ? max( blendOpDest84_g21533, 2.0 * ( blendOpSrc84_g21533 - 0.5 ) ) : min( blendOpDest84_g21533, 2.0 * blendOpSrc84_g21533 ) ) )).rgb , 1.0));
			float4 Emission_Tex89_g21533 = appendResult87_g21533;
			float4 temp_cast_36 = (min( _Heat_Instance , ( 1.0 - _GLOBAL_SOLAR_TIME ) )).xxxx;
			float lerpResult632_g21546 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH , _WIND_AUDIO_INFLUENCE);
			float temp_output_15_0_g21552 = lerpResult632_g21546;
			float lerpResult638_g21546 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_VERYHIGH , _WIND_AUDIO_INFLUENCE);
			float temp_output_16_0_g21552 = lerpResult638_g21546;
			float lerpResult633_g21546 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_HIGH , _WIND_AUDIO_INFLUENCE);
			float temp_output_17_0_g21552 = lerpResult633_g21546;
			float4 temp_cast_37 = (( 1.0 - saturate( ( ( temp_output_15_0_g21552 + temp_output_16_0_g21552 + temp_output_17_0_g21552 ) / 3.0 ) ) )).xxxx;
			float4 temp_cast_38 = (1.0).xxxx;
			half _WindProtection_Instance = UNITY_ACCESS_INSTANCED_PROP(_WindProtection_arr, _WindProtection);
			float4 lerpResult80_g21533 = lerp( CalculateContrast(_EmissionContrast,temp_cast_37) , temp_cast_38 , _WindProtection_Instance);
			half4 Glow_Strength90_g21533 = min( temp_cast_36 , lerpResult80_g21533 );
			float4 lerpResult99_g21543 = lerp( lerpResult373 , saturate( ( fresnelNode122_g21533 * temp_output_118_0_g21533 * Emission_Tex89_g21533 * Glow_Strength90_g21533 ) ) , blend_strength79_g21543);
			#ifdef _BURNABLE_ON
				float4 staticSwitch282 = lerpResult99_g21543;
			#else
				float4 staticSwitch282 = lerpResult373;
			#endif
			float3 emissive71_g21557 = staticSwitch282.rgb;
			s1_g21557.Emission = emissive71_g21557;
			float metallic34_g21557 = staticSwitch278;
			s1_g21557.Metallic = metallic34_g21557;
			float lerpResult24_g21555 = lerp( temp_output_10_0_g21555 , saturate( _WetnessSmoothness ) , temp_output_24_0_g21553);
			#ifdef _WETTABLE_ON
				float staticSwitch308 = saturate( lerpResult24_g21555 );
			#else
				float staticSwitch308 = staticSwitch281;
			#endif
			float smoothness39_g21557 = staticSwitch308;
			s1_g21557.Smoothness = smoothness39_g21557;
			float lerpResult34_g21543 = lerp( lerpResult375 , 1.0 , blend_strength79_g21543);
			#ifdef _BURNABLE_ON
				float staticSwitch279 = lerpResult34_g21543;
			#else
				float staticSwitch279 = temp_output_16_0_g21529;
			#endif
			float occlusion188_g21557 = staticSwitch279;
			s1_g21557.Occlusion = occlusion188_g21557;

			data.light = gi.light;

			UnityGI gi1_g21557 = gi;
			#ifdef UNITY_PASS_FORWARDBASE
			Unity_GlossyEnvironmentData g1_g21557 = UnityGlossyEnvironmentSetup( s1_g21557.Smoothness, data.worldViewDir, s1_g21557.Normal, float3(0,0,0));
			gi1_g21557 = UnityGlobalIllumination( data, s1_g21557.Occlusion, s1_g21557.Normal, g1_g21557 );
			#endif

			float3 surfResult1_g21557 = LightingStandard ( s1_g21557, viewDir, gi1_g21557 ).rgb;
			surfResult1_g21557 += s1_g21557.Emission;

			#ifdef UNITY_PASS_FORWARDADD//1_g21557
			surfResult1_g21557 -= s1_g21557.Emission;
			#endif//1_g21557
			float3 clampResult196_g21557 = clamp( surfResult1_g21557 , float3(0,0,0) , float3(50,50,50) );
			float3 temp_output_18_0_g21558 = clampResult196_g21557;
			float3 break28_g21558 = temp_output_18_0_g21558;
			float ifLocalVar21_g21558 = 0;
			ifLocalVar21_g21558 = 1.0;
			float ifLocalVar22_g21558 = 0;
			ifLocalVar22_g21558 = 1.0;
			float ifLocalVar23_g21558 = 0;
			ifLocalVar23_g21558 = 1.0;
			c.rgb = (( ( ifLocalVar21_g21558 + ifLocalVar22_g21558 + ifLocalVar23_g21558 ) > 2.9 ) ? temp_output_18_0_g21558 :  float3(0,10,10) );
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
			float temp_output_36_0_g21529 = 1.0;
			float2 uv0_MainTexDetail = i.uv_texcoord * _MainTexDetail_ST.xy + _MainTexDetail_ST.zw;
			float2 UV2_g20324 = uv0_MainTexDetail;
			float4 tex2DNode20_g20324 = tex2D( _MainTexDetail, UV2_g20324 );
			float temp_output_390_56 = tex2DNode20_g20324.a;
			float lerpResult375 = lerp( _OcclusionStrength , _OcclusionStrengthDetail , temp_output_390_56);
			float lerpResult38_g21529 = lerp( temp_output_36_0_g21529 , lerpResult375 , _Occlusion);
			float3 ase_worldPos = i.worldPos;
			float3 positionWS3_g21532 = ase_worldPos;
			float4x4 OcclusionProbesWorldToLocal3_g21532 = _OcclusionProbesWorldToLocal;
			float4 _OcclusionProbes_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_OcclusionProbes_ST_arr, _OcclusionProbes_ST);
			float3 uv_OcclusionProbes3 = i.uv_tex3coord;
			uv_OcclusionProbes3.xy = i.uv_tex3coord.xy * _OcclusionProbes_ST_Instance.xy + _OcclusionProbes_ST_Instance.zw;
			float OcclusionProbes3_g21532 = tex3D( _OcclusionProbes, uv_OcclusionProbes3 ).r;
			float localSampleOcclusionProbes3_g21532 = SampleOcclusionProbes( positionWS3_g21532 , OcclusionProbesWorldToLocal3_g21532 , OcclusionProbes3_g21532 );
			float lerpResult1_g21532 = lerp( 1.0 , localSampleOcclusionProbes3_g21532 , ( _AOProbeStrength * _OCCLUSION_PROBE_GLOBAL ));
			float temp_output_7_0_g21529 = ( saturate( ( lerpResult38_g21529 * temp_output_36_0_g21529 ) ) * lerpResult1_g21532 );
			float lerpResult18_g21529 = lerp( 1.0 , temp_output_7_0_g21529 , _AOIndirect);
			float lerpResult14_g21529 = lerp( 1.0 , temp_output_7_0_g21529 , _AODirect);
			float lerpResult1_g21529 = lerp( lerpResult18_g21529 , lerpResult14_g21529 , 1);
			float temp_output_16_0_g21529 = saturate( lerpResult1_g21529 );
			float temp_output_88_0_g21522 = _Contrast;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float3 break29_g21526 = ase_vertex3Pos;
			float2 appendResult11_g21526 = (float2(break29_g21526.z , break29_g21526.y));
			float2 temp_output_30_0_g21526 = _TextureOffset;
			float2 temp_output_31_0_g21526 = _TextureScale;
			float2 appendResult13_g21526 = (float2(break29_g21526.x , break29_g21526.z));
			float temp_output_25_0_g21528 = (float)_PlanarAxis;
			float2 lerpResult24_g21528 = lerp( ( ( appendResult11_g21526 + temp_output_30_0_g21526 ) / temp_output_31_0_g21526 ) , ( ( appendResult13_g21526 + temp_output_30_0_g21526 ) / temp_output_31_0_g21526 ) , saturate( temp_output_25_0_g21528 ));
			float2 appendResult10_g21526 = (float2(break29_g21526.x , break29_g21526.y));
			float2 lerpResult21_g21528 = lerp( lerpResult24_g21528 , ( ( appendResult10_g21526 + temp_output_30_0_g21526 ) / temp_output_31_0_g21526 ) , step( 2.0 , temp_output_25_0_g21528 ));
			half2 THREE27_g21528 = lerpResult21_g21528;
			float2 temp_output_49_0_g21526 = THREE27_g21528;
			float2 lerpResult31_g21527 = lerp( temp_output_49_0_g21526 , (temp_output_49_0_g21526).yx , _FlipXY);
			half2 TWO33_g21527 = lerpResult31_g21527;
			float2 UV2_g21521 = TWO33_g21527;
			float4 tex2DNode20_g21521 = tex2D( _MainTex, UV2_g21521 );
			float4 temp_output_89_0_g21522 = ( tex2DNode20_g21521 * _Color );
			float3 hsvTorgb92_g21522 = RGBToHSV( temp_output_89_0_g21522.rgb );
			float temp_output_118_0_g21522 = 1.0;
			float3 hsvTorgb83_g21522 = HSVToRGB( float3(hsvTorgb92_g21522.x,( hsvTorgb92_g21522.y * ( temp_output_118_0_g21522 + _Saturation ) ),( hsvTorgb92_g21522.z * ( temp_output_118_0_g21522 + _Brightness ) )) );
			float temp_output_2_0_g21524 = _ContrastCorrection;
			float temp_output_88_0_g20325 = _ContrastDetail;
			float4 temp_output_89_0_g20325 = ( tex2DNode20_g20324 * _ColorDetail );
			float3 hsvTorgb92_g20325 = RGBToHSV( temp_output_89_0_g20325.rgb );
			float temp_output_118_0_g20325 = 1.0;
			float3 hsvTorgb83_g20325 = HSVToRGB( float3(hsvTorgb92_g20325.x,( hsvTorgb92_g20325.y * ( temp_output_118_0_g20325 + _SaturationDetail ) ),( hsvTorgb92_g20325.z * ( temp_output_118_0_g20325 + _BrightnessDetail ) )) );
			float temp_output_2_0_g20327 = _ContrastCorrectionDetail;
			float4 lerpResult372 = lerp( (CalculateContrast(temp_output_88_0_g21522,( float4( hsvTorgb83_g21522 , 0.0 ) * ( 1.0 / (( temp_output_2_0_g21524 == 0.0 ) ? 1.0 :  temp_output_2_0_g21524 ) ) ))).rgba , (CalculateContrast(temp_output_88_0_g20325,( float4( hsvTorgb83_g20325 , 0.0 ) * ( 1.0 / (( temp_output_2_0_g20327 == 0.0 ) ? 1.0 :  temp_output_2_0_g20327 ) ) ))).rgba , temp_output_390_56);
			float3 temp_output_262_31 = ( temp_output_16_0_g21529 * lerpResult372.rgb );
			float4 color73_g21543 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
			float2 appendResult22_g21533 = (float2(_BurnMapScaleX , _BurnMapScaleY));
			float2 uv_TexCoord24_g21533 = i.uv_texcoord * appendResult22_g21533;
			float4 tex2DNode34_g21533 = tex2D( _BurnMap, uv_TexCoord24_g21533 );
			half AlbedoTex5_Blue36_g21533 = tex2DNode34_g21533.b;
			float mulTime7_g21533 = _Time.y * _BurnSpeed;
			float2 appendResult3_g21533 = (float2(_BurnNoiseScaleX , _BurnNoiseScaleY));
			float2 uv_TexCoord5_g21533 = i.uv_texcoord * appendResult3_g21533;
			float4 tex2DNode11_g21533 = tex2D( _BurnNoise, uv_TexCoord5_g21533 );
			float clampResult8_g21534 = clamp( sin( ( mulTime7_g21533 + ( tex2DNode11_g21533.g * ( 2.0 * UNITY_PI ) ) + ( 0.5 * UNITY_PI ) ) ) , -1.0 , 1.0 );
			float temp_output_26_0_g21533 = ( ( clampResult8_g21534 * 0.5 ) + 0.5 );
			float4 temp_output_41_0_g21533 = ( _BurnColor2 * AlbedoTex5_Blue36_g21533 * temp_output_26_0_g21533 );
			half AlbedoTex5_Green44_g21533 = tex2DNode34_g21533.g;
			float clampResult8_g21541 = clamp( sin( ( mulTime7_g21533 + ( tex2DNode11_g21533.b * ( 2.0 * UNITY_PI ) ) + ( 1.0 * UNITY_PI ) ) ) , -1.0 , 1.0 );
			half AlbedoTex5_Red38_g21533 = tex2DNode34_g21533.r;
			float4 blendOpSrc58_g21533 = ( _BurnColor2 * AlbedoTex5_Green44_g21533 * ( ( ( ( clampResult8_g21541 * 0.5 ) + 0.5 ) * 0.5 ) + 0.5 ) );
			float4 blendOpDest58_g21533 = ( _BurnColor1 * AlbedoTex5_Red38_g21533 * ( ( temp_output_26_0_g21533 * 0.5 ) + 0.5 ) );
			float4 blendOpSrc63_g21533 = temp_output_41_0_g21533;
			float4 blendOpDest63_g21533 = ( saturate( ( 1.0 - ( 1.0 - blendOpSrc58_g21533 ) * ( 1.0 - blendOpDest58_g21533 ) ) ));
			half _Heat_Instance = UNITY_ACCESS_INSTANCED_PROP(_Heat_arr, _Heat);
			half Heat_Strength56_g21533 = _Heat_Instance;
			float4 lerpResult69_g21533 = lerp( float4( 0,0,0,0 ) , ( saturate( 2.0f*blendOpDest63_g21533*blendOpSrc63_g21533 + blendOpDest63_g21533*blendOpDest63_g21533*(1.0f - 2.0f*blendOpSrc63_g21533) )) , Heat_Strength56_g21533);
			float4 blendOpSrc62_g21533 = ( _CharColor2 * AlbedoTex5_Green44_g21533 );
			float4 blendOpDest62_g21533 = ( _CharColor1 * AlbedoTex5_Red38_g21533 );
			half _Burned_Instance = UNITY_ACCESS_INSTANCED_PROP(_Burned_arr, _Burned);
			half Burn_Strength64_g21533 = _Burned_Instance;
			float4 lerpResult74_g21533 = lerp( lerpResult69_g21533 , ( ( saturate( ( blendOpSrc62_g21533 + blendOpDest62_g21533 ) )) * ( ( AlbedoTex5_Blue36_g21533 * 0.5 ) + 0.5 ) ) , Burn_Strength64_g21533);
			float4 appendResult83_g21533 = (float4(lerpResult74_g21533.rgb , 1.0));
			float4 Burn_Tex88_g21533 = appendResult83_g21533;
			float _Wetness_Instance = UNITY_ACCESS_INSTANCED_PROP(_Wetness_arr, _Wetness);
			float temp_output_118_0_g21533 = _Wetness_Instance;
			float blend_strength79_g21543 = saturate( ( max( Burn_Strength64_g21533 , Heat_Strength56_g21533 ) * ( 1.0 - temp_output_118_0_g21533 ) ) );
			float4 lerpResult43_g21543 = lerp( ( float4( temp_output_262_31 , 0.0 ) * color73_g21543 ) , ( float4( Burn_Tex88_g21533.xyz , 0.0 ) * color73_g21543 ) , blend_strength79_g21543);
			float4 temp_output_166_0_g21533 = lerpResult43_g21543;
			#ifdef _BURNABLE_ON
				float3 staticSwitch276 = (temp_output_166_0_g21533).rgb;
			#else
				float3 staticSwitch276 = temp_output_262_31;
			#endif
			float lerpResult374 = lerp( _Metallic , _MetallicDetail , temp_output_390_56);
			float lerpResult106_g21543 = lerp( lerpResult374 , 1.0 , blend_strength79_g21543);
			#ifdef _BURNABLE_ON
				float staticSwitch278 = lerpResult106_g21543;
			#else
				float staticSwitch278 = lerpResult374;
			#endif
			float lerpResult377 = lerp( _Glossiness , _GlossinessDetail , temp_output_390_56);
			float lerpResult31_g21543 = lerp( lerpResult377 , 0.35 , blend_strength79_g21543);
			#ifdef _BURNABLE_ON
				float staticSwitch281 = lerpResult31_g21543;
			#else
				float staticSwitch281 = lerpResult377;
			#endif
			float temp_output_10_0_g21555 = staticSwitch281;
			float lerpResult18_g21555 = lerp( 1.0 , ( 1.0 - _WetnessDarkening ) , ( ( 1.0 - staticSwitch278 ) * saturate( ( ( ( 1.0 - temp_output_10_0_g21555 ) - 0.5 ) / max( _WetnessPorosity , 0.001 ) ) ) ));
			float3 temp_output_390_58 = UnpackScaleNormal( tex2D( _BumpMapDetail, UV2_g20324 ), _BumpScaleDetail );
			float3 temp_output_4_0_g21544 = temp_output_390_58;
			float3 a13_g21544 = temp_output_4_0_g21544;
			float2 uv_CharNormal81_g21533 = i.uv_texcoord;
			half3 CharNormal85_g21533 = UnpackScaleNormal( tex2D( _CharNormal, uv_CharNormal81_g21533 ), _CharredNormalScale );
			float3 temp_output_5_0_g21544 = CharNormal85_g21533;
			float3 ab14_g21544 = BlendNormals( temp_output_4_0_g21544 , temp_output_5_0_g21544 );
			float temp_output_21_0_g21544 = saturate( blend_strength79_g21543 );
			float3 lerpResult8_g21544 = lerp( a13_g21544 , ab14_g21544 , temp_output_21_0_g21544);
			float3 b19_g21544 = temp_output_5_0_g21544;
			float3 lerpResult22_g21544 = lerp( lerpResult8_g21544 , b19_g21544 , saturate( ( ( temp_output_21_0_g21544 * 2.0 ) - 1.0 ) ));
			float3 normalizeResult11_g21544 = normalize( lerpResult22_g21544 );
			#ifdef _BURNABLE_ON
				float3 staticSwitch277 = normalizeResult11_g21544;
			#else
				float3 staticSwitch277 = temp_output_390_58;
			#endif
			float _SubmersionWetness_Instance = UNITY_ACCESS_INSTANCED_PROP(_SubmersionWetness_arr, _SubmersionWetness);
			float _RainWetness_Instance = UNITY_ACCESS_INSTANCED_PROP(_RainWetness_arr, _RainWetness);
			float Wetness_Strength298 = _Wetness_Instance;
			float temp_output_24_0_g21553 = max( max( ( normalize( (WorldNormalVector( i , staticSwitch277 )) ).y * _SubmersionWetness_Instance ) , _RainWetness_Instance ) , ( Wetness_Strength298 * 0.0 ) );
			float lerpResult22_g21555 = lerp( 1.0 , lerpResult18_g21555 , temp_output_24_0_g21553);
			#ifdef _WETTABLE_ON
				float4 staticSwitch307 = ( float4( staticSwitch276 , 0.0 ) * lerpResult22_g21555 );
			#else
				float4 staticSwitch307 = float4( staticSwitch276 , 0.0 );
			#endif
			float3 albedo51_g21557 = staticSwitch307.rgb;
			o.Albedo = ( _GlobalIlluminationAlbedoEffect * albedo51_g21557 );
			float4 lerpResult373 = lerp( ( _EmissionColor * _EmissionStrength ) , ( _EmissionColorDetail * _EmissionStrengthDetail ) , temp_output_390_56);
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV122_g21533 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode122_g21533 = ( _GlowBias + _GlowScale * pow( 1.0 - fresnelNdotV122_g21533, _GlowPower ) );
			float4 blendOpSrc84_g21533 = temp_output_41_0_g21533;
			float4 blendOpDest84_g21533 = float4( 0,0,0,0 );
			float4 appendResult87_g21533 = (float4(( saturate( (( blendOpSrc84_g21533 > 0.5 ) ? max( blendOpDest84_g21533, 2.0 * ( blendOpSrc84_g21533 - 0.5 ) ) : min( blendOpDest84_g21533, 2.0 * blendOpSrc84_g21533 ) ) )).rgb , 1.0));
			float4 Emission_Tex89_g21533 = appendResult87_g21533;
			float4 temp_cast_15 = (min( _Heat_Instance , ( 1.0 - _GLOBAL_SOLAR_TIME ) )).xxxx;
			float lerpResult632_g21546 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH , _WIND_AUDIO_INFLUENCE);
			float temp_output_15_0_g21552 = lerpResult632_g21546;
			float lerpResult638_g21546 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_VERYHIGH , _WIND_AUDIO_INFLUENCE);
			float temp_output_16_0_g21552 = lerpResult638_g21546;
			float lerpResult633_g21546 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_HIGH , _WIND_AUDIO_INFLUENCE);
			float temp_output_17_0_g21552 = lerpResult633_g21546;
			float4 temp_cast_16 = (( 1.0 - saturate( ( ( temp_output_15_0_g21552 + temp_output_16_0_g21552 + temp_output_17_0_g21552 ) / 3.0 ) ) )).xxxx;
			float4 temp_cast_17 = (1.0).xxxx;
			half _WindProtection_Instance = UNITY_ACCESS_INSTANCED_PROP(_WindProtection_arr, _WindProtection);
			float4 lerpResult80_g21533 = lerp( CalculateContrast(_EmissionContrast,temp_cast_16) , temp_cast_17 , _WindProtection_Instance);
			half4 Glow_Strength90_g21533 = min( temp_cast_15 , lerpResult80_g21533 );
			float4 lerpResult99_g21543 = lerp( lerpResult373 , saturate( ( fresnelNode122_g21533 * temp_output_118_0_g21533 * Emission_Tex89_g21533 * Glow_Strength90_g21533 ) ) , blend_strength79_g21543);
			#ifdef _BURNABLE_ON
				float4 staticSwitch282 = lerpResult99_g21543;
			#else
				float4 staticSwitch282 = lerpResult373;
			#endif
			float3 emissive71_g21557 = staticSwitch282.rgb;
			o.Emission = ( _GlobalIlluminationEmissiveEffect * emissive71_g21557 );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows dithercrossfade 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			AlphaToMask Off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.5
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
				float2 customPack1 : TEXCOORD1;
				float3 customPack2 : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.customPack2.xyz = customInputData.uv_tex3coord;
				o.customPack2.xyz = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
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
				surfIN.uv_texcoord = IN.customPack1.xy;
				surfIN.uv_tex3coord = IN.customPack2.xyz;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
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
	CustomEditor "InternalShaderGUI"
}
/*ASEBEGIN
Version=17500
533.6;-864;1536;843;-23.45978;889.8073;1.737926;True;False
Node;AmplifyShaderEditor.FunctionNode;389;156.7788,-582.8987;Inherit;False;Texture Set Planar (1 Sampler - 1 Sample);7;;21519;a244d60cef63698458324225564a6bf2;0;0;8;COLOR;423;FLOAT;425;COLOR;427;FLOAT3;422;FLOAT;430;FLOAT;429;FLOAT;424;FLOAT;426
Node;AmplifyShaderEditor.FunctionNode;390;201.1838,-269.5291;Inherit;False;Texture Set Detail (2 Samplers);28;;1;80dd8bdc81f72bf45918ec0cba4f4c5a;0;1;66;FLOAT2;0,0;False;9;COLOR;55;FLOAT;56;FLOAT3;58;COLOR;59;FLOAT3;61;FLOAT;60;FLOAT;62;FLOAT;63;FLOAT;64
Node;AmplifyShaderEditor.LerpOp;375;711.9614,-348.5842;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;372;711.9614,-684.5839;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;297;825.416,241.3008;Inherit;False;InstancedProperty;_Wetness;Wetness;80;1;[PerRendererData];Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;373;711.9614,-572.5839;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;377;711.9614,-124.5841;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;379;775.812,73.45115;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;262;996.9708,-678.2689;Inherit;False;Occlusion Probes;46;;21529;fc5cec86a89be184e93fc845da77a0cc;4,22,1,65,1,66,0,64,1;3;12;FLOAT;0;False;48;FLOAT;0;False;26;FLOAT3;1,1,1;False;2;FLOAT;0;FLOAT3;31
Node;AmplifyShaderEditor.LerpOp;376;711.9614,-236.5842;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;374;711.9614,-460.5841;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;305;1253.539,-75.77296;Inherit;False;Burnable;57;;21533;a0caf447e4aba704388d4974489e2842;0;8;138;FLOAT3;0,0,0;False;131;FLOAT3;0,0,0;False;162;COLOR;0,0,0,0;False;168;FLOAT;0;False;132;FLOAT;0;False;145;FLOAT;0;False;134;FLOAT;0;False;118;FLOAT;0;False;8;COLOR;151;FLOAT3;169;FLOAT3;150;COLOR;0;FLOAT;167;FLOAT;149;FLOAT;148;FLOAT;147
Node;AmplifyShaderEditor.WireNode;387;801.0202,13.77732;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;277;1907.906,-576.777;Inherit;False;Property;_Burnable;Burnable;110;0;Create;True;0;0;True;0;0;0;0;True;;Toggle;2;Key0;Key1;Reference;276;True;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;323;1920,160;Inherit;False;InstancedProperty;_SubmersionWetness;Submersion Wetness;82;1;[PerRendererData];Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;278;1907.906,-480.7772;Inherit;False;Property;_Burnable;Burnable;73;0;Create;True;0;0;True;0;0;0;0;True;;Toggle;2;Key0;Key1;Reference;276;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;276;1901.737,-680.577;Inherit;False;Property;_Burnable;Burnable;88;0;Create;True;0;0;True;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;324;1920,256;Inherit;False;InstancedProperty;_RainWetness;Rain Wetness;81;1;[PerRendererData];Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;298;1920,64;Inherit;False;Wetness_Strength;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;281;1915.929,-164.1683;Inherit;False;Property;_Burnable;Burnable;56;0;Create;True;0;0;True;0;0;0;0;True;;Toggle;2;Key0;Key1;Reference;276;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;348;2444.857,-42.71685;Inherit;False;Wettable (Masked);83;;21553;5036304cb644c124e95df478d54c3678;0;8;21;FLOAT3;1,0,0;False;11;COLOR;1,1,1,1;False;13;FLOAT;0;False;12;FLOAT;0;False;14;FLOAT;1;False;18;FLOAT;1;False;19;FLOAT;1;False;26;FLOAT;0;False;2;COLOR;9;FLOAT;10
Node;AmplifyShaderEditor.StaticSwitch;307;2881.189,-571.3375;Inherit;False;Property;_Wettable;Wettable;79;0;Create;True;0;0;True;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;279;1907.906,-384.7772;Inherit;False;Property;_Burnable;Burnable;85;0;Create;True;0;0;True;0;0;0;0;True;;Toggle;2;Key0;Key1;Reference;276;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;331;3674.509,106.1358;Inherit;False;316.9983;545.553;Rendering;5;336;333;335;334;272;;0,0.0238266,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;200;3228.225,83.8914;Inherit;False;290.0045;637.6437;Drawers;6;199;301;337;343;300;202;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.StaticSwitch;282;1915.929,-68.16832;Inherit;False;Property;_Burnable;Burnable;88;0;Create;True;0;0;True;0;0;0;0;True;;Toggle;2;Key0;Key1;Reference;276;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;308;2875.589,-122.6376;Inherit;False;Property;_Burnable;Burnable;82;0;Create;True;0;0;True;0;0;0;0;True;;Toggle;2;Key0;Key1;Reference;307;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;318;1915.929,-276.1683;Inherit;False;Property;_Burnable;Burnable;86;0;Create;True;0;0;True;0;0;0;0;True;;Toggle;2;Key0;Key1;Reference;276;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;202;3260.224,147.8914;Half;False;Property;_BANNER;BANNER;0;0;Create;True;0;0;True;1;InternalBanner(Internal,Standard);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;334;3706.509,266.1357;Inherit;False;Property;_AlphaToCoverage;Alpha To Coverage;4;1;[Toggle];Create;True;0;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;300;3260.224,243.8914;Half;False;Property;_RENDERINGG;[ RENDERINGG  ];1;0;Create;True;0;0;True;1;InternalCategory(Rendering);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;199;3260.224,627.8912;Inherit;False;Internal Features Support;-1;;21556;3c493d142aeebd840af72d626f6915c6;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;272;3706.509,170.1358;Inherit;False;Property;_CullMode;Cull Mode;2;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;0;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;386;3195.182,-440.8716;Inherit;False;Custom Lighting;89;;21557;b225dcbb02c65fb46af1dbc43764905b;3,67,0,209,0,210,0;7;56;FLOAT3;0,0,0;False;55;FLOAT3;0,0,0;False;70;FLOAT3;0,0,0;False;148;FLOAT3;0,0,0;False;45;FLOAT;0;False;189;FLOAT;0;False;41;FLOAT;0;False;3;FLOAT3;4;FLOAT3;5;FLOAT3;3
Node;AmplifyShaderEditor.RangedFloatNode;335;3706.509,362.1357;Inherit;False;Property;_MaskClipValue;Mask Clip Value;3;0;Create;True;0;0;True;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;333;3706.509,458.1357;Inherit;False;Property;_ZWriteMode;ZWrite Mode;5;1;[Toggle];Create;True;0;0;True;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;336;3706.509,554.1357;Inherit;False;Property;_ZTestMode;ZTest Mode;6;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CompareFunction;True;0;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;343;3260.224,339.8914;Half;False;Property;_OCCLUSIONPROBESS;[ OCCLUSION PROBESS  ];45;0;Create;True;0;0;True;1;InternalCategory(Occlusion Probes);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;301;3260.224,531.8913;Half;False;Property;_BURNN;[ BURNN ];56;0;Create;True;0;0;True;1;InternalCategory(Burn);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;337;3260.224,435.8914;Half;False;Property;_WETT;[ WETT ];78;0;Create;True;0;0;True;1;InternalCategory(Wettable);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3635.977,-460.5901;Float;False;True;-1;5;InternalShaderGUI;0;0;CustomLighting;internal/crafted_planar_detail;False;False;False;False;False;False;False;False;False;False;False;False;True;True;False;False;True;False;True;True;False;Back;1;True;333;3;True;336;False;0;False;-1;0;False;-1;False;3;Custom;0.5;True;True;0;True;Custom;InternalOpaque;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;False;False;_BILLBOARD_ON;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;272;-1;0;True;335;0;0;0;False;0.1;False;-1;0;True;334;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;14;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT3;0,0,0;False;0
WireConnection;375;0;389;429
WireConnection;375;1;390;62
WireConnection;375;2;390;56
WireConnection;372;0;389;423
WireConnection;372;1;390;55
WireConnection;372;2;390;56
WireConnection;373;0;389;427
WireConnection;373;1;390;59
WireConnection;373;2;390;56
WireConnection;377;0;389;426
WireConnection;377;1;390;64
WireConnection;377;2;390;56
WireConnection;379;0;390;58
WireConnection;262;12;375;0
WireConnection;262;26;372;0
WireConnection;376;0;389;424
WireConnection;376;1;390;63
WireConnection;376;2;390;56
WireConnection;374;0;389;430
WireConnection;374;1;390;60
WireConnection;374;2;390;56
WireConnection;305;138;262;31
WireConnection;305;131;379;0
WireConnection;305;162;373;0
WireConnection;305;168;374;0
WireConnection;305;132;375;0
WireConnection;305;145;376;0
WireConnection;305;134;377;0
WireConnection;305;118;297;0
WireConnection;387;0;390;58
WireConnection;277;1;387;0
WireConnection;277;0;305;150
WireConnection;278;1;374;0
WireConnection;278;0;305;167
WireConnection;276;1;262;31
WireConnection;276;0;305;169
WireConnection;298;0;297;0
WireConnection;281;1;377;0
WireConnection;281;0;305;147
WireConnection;348;21;277;0
WireConnection;348;11;276;0
WireConnection;348;13;278;0
WireConnection;348;12;281;0
WireConnection;348;14;298;0
WireConnection;348;18;323;0
WireConnection;348;19;324;0
WireConnection;307;1;276;0
WireConnection;307;0;348;9
WireConnection;279;1;262;0
WireConnection;279;0;305;149
WireConnection;282;1;373;0
WireConnection;282;0;305;0
WireConnection;308;1;281;0
WireConnection;308;0;348;10
WireConnection;318;1;376;0
WireConnection;318;0;305;148
WireConnection;386;56;307;0
WireConnection;386;55;277;0
WireConnection;386;70;282;0
WireConnection;386;45;278;0
WireConnection;386;189;279;0
WireConnection;386;41;308;0
WireConnection;0;0;386;4
WireConnection;0;2;386;5
WireConnection;0;14;386;3
ASEEND*/
//CHKSM=40FDD5934C0A4DF8B6A29EA35E56FB2DBE30C68A