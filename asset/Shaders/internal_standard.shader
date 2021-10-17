// Upgrade NOTE: upgraded instancing buffer 'internalstandard' to new syntax.

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "appalachia/standard"
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
		[InternalCategory(Albedo)]_ALBEDOO("[ ALBEDOO ]", Float) = 0
		_MainTex("Albedo", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,0)
		_Saturation("Saturation", Range( -1 , 4)) = 0
		_Brightness("Brightness", Range( -1 , 4)) = 0
		_Contrast("Contrast", Range( 0 , 10)) = 1
		_ContrastCorrection("Contrast Correction", Range( 0 , 10)) = 1
		[InternalCategory(Normal)]_NORMALL("[ NORMALL ]", Float) = 0
		[NoScaleOffset][Normal]_BumpMap("Normal", 2D) = "bump" {}
		_BumpScale("Normal Scale", Range( 0 , 5)) = 1
		[InternalCategory(Emission)]_EMISSIONN("[ EMISSIONN ]", Float) = 0
		[NoScaleOffset]_EmissionMap("Emission Map", 2D) = "white" {}
		_EmissionColor("Emission Color", Color) = (0,0,0,0)
		_EmissionStrength("Emission Strength", Range( 0 , 5)) = 1
		[InternalCategory(Specularity)]_SPECULARITYY("[ SPECULARITYY  ]", Float) = 0
		[InternalCategory(Surface)]_SURFACEE("[ SURFACEE ]", Float) = 0
		[NoScaleOffset]_MetallicGlossMap("Surface Map", 2D) = "white" {}
		[Toggle]_IgnoreMetallicMap("Ignore Metallic Map", Range( 0 , 1)) = 0
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_Glossiness("Smoothness", Range( 0 , 1)) = 0.1
		[Toggle]_InvertSmoothness("Invert Smoothness", Float) = 0
		_DisplacementStrength("Displacement", Range( 0 , 1)) = 1
		_OcclusionStrength("Occlusion", Range( 0 , 1)) = 1
		[InternalCategory(Occlusion)]_OCCLUSIONN("[ OCCLUSIONN ]", Float) = 0
		_Occlusion("Texture Occlusion", Range( 0 , 1)) = 0.5
		_AOProbeStrength("AO Probe Strength", Range( 0 , 1)) = 0.8
		_AOIndirect("AO Indirect", Range( 0 , 1)) = 1
		_AODirect("AO Direct", Range( 0 , 1)) = 0
		[InternalCategory(Terrain Blending)]_TERRAINNBLEND("[ TERRAINN BLEND ]", Float) = 0
		[Toggle(_TERRAINBLEND_ON)] _TerrainBlend("Terrain Blend", Float) = 0
		[NoScaleOffset]_TerrainTex("Terrain Albedo", 2D) = "white" {}
		_TerrainScale("Terrain Scale", Vector) = (2,2,0,0)
		_TerrainOffset("Terrain Offset", Vector) = (0,0,0,0)
		[NoScaleOffset]_TerrainBumpMap("Terrain Normal", 2D) = "white" {}
		_TerrainBumpMapScale("Terrain Normal Scale", Range( 0 , 3)) = 1
		[NoScaleOffset]_TerrainMetallicGlossMap("Terrain Surface", 2D) = "white" {}
		_TerrainMetallic("Terrain Metallic", Range( 0 , 1)) = 0
		_TerrainOcclusionStrength("Terrain Occlusion", Range( 0 , 1)) = 1
		[Toggle]_InvertTerrainSmoothness("Invert Terrain Smoothness", Float) = 0
		_TerrainGlossiness("Terrain Smoothness", Range( 0 , 1)) = 0.1
		_TriplanarContrast("Triplanar Contrast", Range( 0.1 , 20)) = 1
		[Toggle]_LimitBlendHeight("Limit Blend Height", Float) = 0
		_BlendHeightLimit("Blend Height Limit", Range( 0 , 2)) = 0.2
		_BlendThreshold("Blend Threshold", Range( 0 , 0.1)) = 0.01
		_BlendFade("Blend Fade", Range( 0 , 0.1)) = 0.01
		[InternalCategory(Burn)]_BURNN("[ BURNN ]", Float) = 0
		[Toggle(_BURNABLE_ON)] _Burnable("Burnable", Float) = 0
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
		[InternalCategory(Wetness)]_WETNESS("[ WETNESS ]", Float) = 0
		[NoScaleOffset]_WetnessMask("Wetness Mask", 2D) = "white" {}
		_WetnessDarkening("Wetness Darkening", Range( 0 , 0.93)) = 0.65
		_WetnessSmoothness("Wetness Smoothness", Range( 0 , 1)) = 0.3
		_WetnessPorosity("Wetness Porosity", Range( 0 , 1)) = 0.1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[PerRendererData]_Wetness("Wetness", Range( 0 , 1)) = 0
		[PerRendererData]_SubmersionWetness("Submersion Wetness", Range( 0 , 1)) = 0
		[PerRendererData]_RainWetness("Rain Wetness", Range( 0 , 1)) = 0
		[InternalCategory(Grounding)]_GROUNDINGG("[ GROUNDINGG ]", Float) = 0
		[Toggle(_GROUNDED_ON)] _Grounded("Grounded", Float) = 0
		_GroundFadeStartX("Ground Fade Start X", Range( 0.01 , 20)) = 1
		_GroundFadeDistanceX("Ground Fade Distance X", Range( 0.01 , 20)) = 1
		_GroundFadePowerX("Ground Fade Power X", Range( 1 , 5)) = 1.25
		_GroundDisplacementX("Ground Displacement X", Range( 0 , 10)) = 0
		_GroundFadeStartZ("Ground Fade Start Z", Range( 0.01 , 20)) = 1
		_GroundFadeDistanceZ("Ground Fade Distance Z", Range( 0.01 , 20)) = 1
		_GroundFadePowerZ("Ground Fade Power Z", Range( 1 , 5)) = 1.25
		_GroundDisplacementZ("Ground Displacement Z", Range( 0 , 10)) = 0
		_GroundDisplacementHeightCutoff("Ground Displacement Height Cutoff", Range( 0 , 5)) = 0.5
		_GroundDisplacementHeightFadeRange("Ground Displacement Height Fade Range", Range( 0.05 , 4)) = 0.5
		_GroundDisplacementDirection("Ground Displacement Direction", Vector) = (0,-1,0,0)
		[InternalCategory(Global Illumination)]_GLOBALILLUMINATIONN("[ GLOBAL ILLUMINATIONN ]", Float) = 0
		_GlobalIlluminationAlbedoEffect("Global Illumination Albedo Effect", Range( 0 , 5)) = 1
		_GlobalIlluminationEmissiveEffect("Global Illumination Emissive Effect", Range( 0 , 5)) = 1
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
		#pragma shader_feature_local _GROUNDED_ON
		#pragma shader_feature_local _WETTABLE_ON
		#pragma shader_feature_local _TERRAINBLEND_ON
		#define ASE_TEXTURE_PARAMS(textureName) textureName

		 
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
			float3 worldNormal;
			INTERNAL_DATA
			float3 uv_tex3coord;
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

		uniform half _OCCLUSIONN;
		uniform half _WETNESS;
		uniform half _BANNER;
		uniform half _GROUNDINGG;
		uniform float _CullMode;
		uniform float _MaskClipValue;
		uniform float _ZWriteMode;
		uniform float _AlphaToCoverage;
		uniform half _RENDERINGG;
		uniform half _NORMALL;
		uniform half _SURFACEE;
		uniform half _ALBEDOO;
		uniform half _TERRAINNBLEND;
		uniform half _SPECULARITYY;
		uniform half _EMISSIONN;
		uniform half _GLOBALILLUMINATIONN;
		uniform half _BURNN;
		uniform half _WETT;
		uniform float _ZTestMode;
		uniform float _GroundDisplacementHeightCutoff;
		uniform float _GroundDisplacementHeightFadeRange;
		uniform float _GroundFadeStartX;
		uniform float _GroundFadeDistanceX;
		uniform float _GroundFadePowerX;
		uniform float _GroundDisplacementX;
		uniform float3 _GroundDisplacementDirection;
		uniform float _GroundFadeStartZ;
		uniform float _GroundFadeDistanceZ;
		uniform float _GroundFadePowerZ;
		uniform float _GroundDisplacementZ;
		uniform float _GlobalIlluminationAlbedoEffect;
		uniform sampler2D _MetallicGlossMap;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float _OcclusionStrength;
		uniform float _IgnoreMetallicMap;
		uniform float _Metallic;
		uniform float _DisplacementStrength;
		uniform float _InvertSmoothness;
		uniform float _Glossiness;
		uniform sampler2D _TerrainMetallicGlossMap;
		uniform float2 _TerrainScale;
		uniform float _TriplanarContrast;
		uniform float2 _TerrainOffset;
		uniform float _TerrainOcclusionStrength;
		uniform float _LimitBlendHeight;
		uniform float _BlendHeightLimit;
		uniform float _Contrast;
		uniform float4 _Color;
		uniform float _Saturation;
		uniform float _Brightness;
		uniform float _ContrastCorrection;
		uniform float _BlendThreshold;
		uniform float _BlendFade;
		uniform half _Occlusion;
		uniform float4x4 _OcclusionProbesWorldToLocal;
		uniform sampler3D _OcclusionProbes;
		uniform float _AOProbeStrength;
		uniform float _OCCLUSION_PROBE_GLOBAL;
		uniform float _AOIndirect;
		uniform float _AODirect;
		uniform sampler2D _TerrainTex;
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
		uniform float _TerrainMetallic;
		uniform float _InvertTerrainSmoothness;
		uniform float _TerrainGlossiness;
		uniform float _WetnessPorosity;
		uniform float _BumpScale;
		uniform sampler2D _BumpMap;
		uniform sampler2D _TerrainBumpMap;
		uniform float _TerrainBumpMapScale;
		uniform half _CharredNormalScale;
		uniform sampler2D _CharNormal;
		uniform sampler2D _WetnessMask;
		uniform float _GlobalIlluminationEmissiveEffect;
		uniform sampler2D _EmissionMap;
		uniform float4 _EmissionColor;
		uniform float _EmissionStrength;
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
		uniform float _OCCLUSION_PROBE_TERRAIN_BLEND;

		UNITY_INSTANCING_BUFFER_START(internalstandard)
			UNITY_DEFINE_INSTANCED_PROP(float4, _OcclusionProbes_ST)
#define _OcclusionProbes_ST_arr internalstandard
			UNITY_DEFINE_INSTANCED_PROP(half, _Heat)
#define _Heat_arr internalstandard
			UNITY_DEFINE_INSTANCED_PROP(half, _Burned)
#define _Burned_arr internalstandard
			UNITY_DEFINE_INSTANCED_PROP(float, _Wetness)
#define _Wetness_arr internalstandard
			UNITY_DEFINE_INSTANCED_PROP(float, _RainWetness)
#define _RainWetness_arr internalstandard
			UNITY_DEFINE_INSTANCED_PROP(float, _SubmersionWetness)
#define _SubmersionWetness_arr internalstandard
			UNITY_DEFINE_INSTANCED_PROP(half, _WindProtection)
#define _WindProtection_arr internalstandard
		UNITY_INSTANCING_BUFFER_END(internalstandard)


		inline float4 TriplanarSamplingSF( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
		{
			float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
			projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
			float3 nsign = sign( worldNormal );
			half4 xNorm; half4 yNorm; half4 zNorm;
			xNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.zy * float2( nsign.x, 1.0 ) ) );
			yNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.xz * float2( nsign.y, 1.0 ) ) );
			zNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.xy * float2( -nsign.z, 1.0 ) ) );
			return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
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

		float SampleOcclusionProbes( float3 positionWS , float4x4 OcclusionProbesWorldToLocal , float OcclusionProbes )
		{
			float occlusionProbes = 1;
			float3 pos = mul(_OcclusionProbesWorldToLocal, float4(positionWS, 1)).xyz;
			occlusionProbes = tex3D(_OcclusionProbes, pos).a;
			return occlusionProbes;
		}


		inline float3 TriplanarSamplingSNF( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
		{
			float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
			projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
			float3 nsign = sign( worldNormal );
			half4 xNorm; half4 yNorm; half4 zNorm;
			xNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.zy * float2( nsign.x, 1.0 ) ) );
			yNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.xz * float2( nsign.y, 1.0 ) ) );
			zNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.xy * float2( -nsign.z, 1.0 ) ) );
			xNorm.xyz = half3( UnpackScaleNormal( xNorm, normalScale.y ).xy * float2( nsign.x, 1.0 ) + worldNormal.zy, worldNormal.x ).zyx;
			yNorm.xyz = half3( UnpackScaleNormal( yNorm, normalScale.x ).xy * float2( nsign.y, 1.0 ) + worldNormal.xz, worldNormal.y ).xzy;
			zNorm.xyz = half3( UnpackScaleNormal( zNorm, normalScale.y ).xy * float2( -nsign.z, 1.0 ) + worldNormal.xy, worldNormal.z ).xyz;
			return normalize( xNorm.xyz * projNormal.x + yNorm.xyz * projNormal.y + zNorm.xyz * projNormal.z );
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float height70_g20543 = ase_vertex3Pos.y;
			float height_cutoff67_g20543 = _GroundDisplacementHeightCutoff;
			float3 vec3_zero73_g20543 = float3(0,0,0);
			float height_fade_range68_g20543 = _GroundDisplacementHeightFadeRange;
			float height_fade_start69_g20543 = ( height_cutoff67_g20543 - height_fade_range68_g20543 );
			float3 temp_output_46_0_g20543 = min( ( pow( saturate( ( ( abs( ase_vertex3Pos.x ) - _GroundFadeStartX ) / _GroundFadeDistanceX ) ) , _GroundFadePowerX ) * _GroundDisplacementX * _GroundDisplacementDirection ) , ( pow( saturate( ( ( abs( ase_vertex3Pos.z ) - _GroundFadeStartZ ) / _GroundFadeDistanceZ ) ) , _GroundFadePowerZ ) * _GroundDisplacementZ * _GroundDisplacementDirection ) );
			float height_fade_strength84_g20543 = ( 1.0 - ( ( height70_g20543 - height_fade_start69_g20543 ) / height_fade_range68_g20543 ) );
			float3 lerpResult1_g20544 = lerp( vec3_zero73_g20543 , temp_output_46_0_g20543 , saturate( height_fade_strength84_g20543 ));
			#ifdef _GROUNDED_ON
				float3 staticSwitch225 = (( height70_g20543 > height_cutoff67_g20543 ) ? vec3_zero73_g20543 :  (( height70_g20543 > height_fade_start69_g20543 ) ? lerpResult1_g20544 :  temp_output_46_0_g20543 ) );
			#else
				float3 staticSwitch225 = float3( 0,0,0 );
			#endif
			v.vertex.xyz += staticSwitch225;
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
			SurfaceOutputStandard s1_g20547 = (SurfaceOutputStandard ) 0;
			float temp_output_36_0_g20384 = 1.0;
			float2 uv0_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 UV77 = uv0_MainTex;
			float4 tex2DNode34 = tex2D( _MetallicGlossMap, UV77 );
			float lerpResult74 = lerp( 1.0 , tex2DNode34.g , _OcclusionStrength);
			float _OCCLUSION48 = lerpResult74;
			float lerpResult340 = lerp( tex2DNode34.r , 1.0 , _IgnoreMetallicMap);
			float _METALLIC33 = ( lerpResult340 * _Metallic );
			float lerpResult311 = lerp( 0.5 , tex2DNode34.b , _DisplacementStrength);
			float _DISPLACEMENT312 = lerpResult311;
			float _SMOOTHNESS58 = ( (( _InvertSmoothness )?( ( 1.0 - tex2DNode34.a ) ):( tex2DNode34.a )) * _Glossiness );
			float4 appendResult240 = (float4(_METALLIC33 , _OCCLUSION48 , _DISPLACEMENT312 , _SMOOTHNESS58));
			float4 temp_output_16_0_g20377 = appendResult240;
			float4 break37_g20377 = temp_output_16_0_g20377;
			float2 temp_output_926_0_g20383 = ( (1.0).xx / (( _TerrainScale == (0.0).xx ) ? (1.0).xx :  _TerrainScale ) );
			float temp_output_925_0_g20383 = _TriplanarContrast;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float2 break955_g20383 = _TerrainOffset;
			float3 appendResult954_g20383 = (float3(break955_g20383.x , 0.0 , break955_g20383.y));
			float3 temp_output_953_0_g20383 = ( appendResult954_g20383 + ase_worldPos );
			float4 triplanar951_g20383 = TriplanarSamplingSF( _TerrainMetallicGlossMap, temp_output_953_0_g20383, ase_worldNormal, temp_output_925_0_g20383, temp_output_926_0_g20383, 1.0, 0 );
			float temp_output_98_900_g20377 = triplanar951_g20383.y;
			float lerpResult89_g20377 = lerp( 1.0 , temp_output_98_900_g20377 , _TerrainOcclusionStrength);
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float temp_output_88_0_g20298 = _Contrast;
			float4 tex2DNode2 = tex2D( _MainTex, UV77 );
			float4 temp_output_89_0_g20298 = ( tex2DNode2 * _Color );
			float3 hsvTorgb92_g20298 = RGBToHSV( temp_output_89_0_g20298.rgb );
			float temp_output_118_0_g20298 = 1.0;
			float3 hsvTorgb83_g20298 = HSVToRGB( float3(hsvTorgb92_g20298.x,( hsvTorgb92_g20298.y * ( temp_output_118_0_g20298 + _Saturation ) ),( hsvTorgb92_g20298.z * ( temp_output_118_0_g20298 + _Brightness ) )) );
			float4 _ALBEDO23 = CalculateContrast(temp_output_88_0_g20298,( float4( hsvTorgb83_g20298 , 0.0 ) * ( 1.0 / (( _ContrastCorrection == 0.0 ) ? 1.0 :  _ContrastCorrection ) ) ));
			float4 temp_output_14_0_g20377 = _ALBEDO23;
			float4 break28_g20377 = temp_output_14_0_g20377;
			float temp_output_15_0_g20382 = break28_g20377.r;
			float temp_output_16_0_g20382 = break28_g20377.g;
			float temp_output_17_0_g20382 = break28_g20377.b;
			float temp_output_24_0_g20379 = ( ( temp_output_15_0_g20382 + temp_output_16_0_g20382 + temp_output_17_0_g20382 ) / 3.0 );
			float temp_output_21_0_g20379 = _BlendThreshold;
			float temp_output_31_0_g20379 = ( temp_output_21_0_g20379 + min( _BlendFade , ( abs( temp_output_21_0_g20379 ) * 5.0 ) ) );
			float temp_output_7_0_g20381 = temp_output_31_0_g20379;
			float4 blend32_g20377 = (( (( ase_vertex3Pos.y > (( _LimitBlendHeight )?( _BlendHeightLimit ):( 10240.0 )) ) ? 0.0 :  1.0 ) * (( temp_output_24_0_g20379 < temp_output_21_0_g20379 ) ? 1.0 :  (( temp_output_24_0_g20379 < temp_output_31_0_g20379 ) ? ( ( temp_output_24_0_g20379 - temp_output_7_0_g20381 ) / ( temp_output_21_0_g20379 - temp_output_7_0_g20381 ) ) :  0.0 ) ) )).xxxx;
			float lerpResult53_g20377 = lerp( break37_g20377.y , lerpResult89_g20377 , blend32_g20377.x);
			#ifdef _TERRAINBLEND_ON
				float staticSwitch239 = lerpResult53_g20377;
			#else
				float staticSwitch239 = _OCCLUSION48;
			#endif
			float lerpResult38_g20384 = lerp( temp_output_36_0_g20384 , staticSwitch239 , _Occlusion);
			float3 positionWS3_g20387 = ase_worldPos;
			float4x4 OcclusionProbesWorldToLocal3_g20387 = _OcclusionProbesWorldToLocal;
			float4 _OcclusionProbes_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_OcclusionProbes_ST_arr, _OcclusionProbes_ST);
			float3 uv_OcclusionProbes3 = i.uv_tex3coord;
			uv_OcclusionProbes3.xy = i.uv_tex3coord.xy * _OcclusionProbes_ST_Instance.xy + _OcclusionProbes_ST_Instance.zw;
			float OcclusionProbes3_g20387 = tex3D( _OcclusionProbes, uv_OcclusionProbes3 ).r;
			float localSampleOcclusionProbes3_g20387 = SampleOcclusionProbes( positionWS3_g20387 , OcclusionProbesWorldToLocal3_g20387 , OcclusionProbes3_g20387 );
			float lerpResult1_g20387 = lerp( 1.0 , localSampleOcclusionProbes3_g20387 , ( _AOProbeStrength * _OCCLUSION_PROBE_GLOBAL ));
			float temp_output_7_0_g20384 = ( saturate( ( lerpResult38_g20384 * temp_output_36_0_g20384 ) ) * lerpResult1_g20387 );
			float lerpResult18_g20384 = lerp( 1.0 , temp_output_7_0_g20384 , _AOIndirect);
			float lerpResult14_g20384 = lerp( 1.0 , temp_output_7_0_g20384 , _AODirect);
			float lerpResult1_g20384 = lerp( lerpResult18_g20384 , lerpResult14_g20384 , ase_lightAtten);
			float temp_output_16_0_g20384 = saturate( lerpResult1_g20384 );
			float4 triplanar949_g20383 = TriplanarSamplingSF( _TerrainTex, temp_output_953_0_g20383, ase_worldNormal, temp_output_925_0_g20383, temp_output_926_0_g20383, 1.0, 0 );
			float4 lerpResult13_g20377 = lerp( temp_output_14_0_g20377 , triplanar949_g20383 , blend32_g20377);
			#ifdef _TERRAINBLEND_ON
				float4 staticSwitch236 = lerpResult13_g20377;
			#else
				float4 staticSwitch236 = _ALBEDO23;
			#endif
			float3 temp_output_262_31 = ( temp_output_16_0_g20384 * staticSwitch236.rgb );
			float4 color73_g20504 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
			float2 appendResult22_g20496 = (float2(_BurnMapScaleX , _BurnMapScaleY));
			float2 uv_TexCoord24_g20496 = i.uv_texcoord * appendResult22_g20496;
			float4 tex2DNode34_g20496 = tex2D( _BurnMap, uv_TexCoord24_g20496 );
			half AlbedoTex5_Blue36_g20496 = tex2DNode34_g20496.b;
			float mulTime7_g20496 = _Time.y * _BurnSpeed;
			float2 appendResult3_g20496 = (float2(_BurnNoiseScaleX , _BurnNoiseScaleY));
			float2 uv_TexCoord5_g20496 = i.uv_texcoord * appendResult3_g20496;
			float4 tex2DNode11_g20496 = tex2D( _BurnNoise, uv_TexCoord5_g20496 );
			float clampResult8_g20509 = clamp( sin( ( mulTime7_g20496 + ( tex2DNode11_g20496.g * ( 2.0 * UNITY_PI ) ) + ( 0.5 * UNITY_PI ) ) ) , -1.0 , 1.0 );
			float temp_output_26_0_g20496 = ( ( clampResult8_g20509 * 0.5 ) + 0.5 );
			float4 temp_output_41_0_g20496 = ( _BurnColor2 * AlbedoTex5_Blue36_g20496 * temp_output_26_0_g20496 );
			half AlbedoTex5_Green44_g20496 = tex2DNode34_g20496.g;
			float clampResult8_g20511 = clamp( sin( ( mulTime7_g20496 + ( tex2DNode11_g20496.b * ( 2.0 * UNITY_PI ) ) + ( 1.0 * UNITY_PI ) ) ) , -1.0 , 1.0 );
			half AlbedoTex5_Red38_g20496 = tex2DNode34_g20496.r;
			float4 blendOpSrc58_g20496 = ( _BurnColor2 * AlbedoTex5_Green44_g20496 * ( ( ( ( clampResult8_g20511 * 0.5 ) + 0.5 ) * 0.5 ) + 0.5 ) );
			float4 blendOpDest58_g20496 = ( _BurnColor1 * AlbedoTex5_Red38_g20496 * ( ( temp_output_26_0_g20496 * 0.5 ) + 0.5 ) );
			float4 blendOpSrc63_g20496 = temp_output_41_0_g20496;
			float4 blendOpDest63_g20496 = ( saturate( ( 1.0 - ( 1.0 - blendOpSrc58_g20496 ) * ( 1.0 - blendOpDest58_g20496 ) ) ));
			half _Heat_Instance = UNITY_ACCESS_INSTANCED_PROP(_Heat_arr, _Heat);
			half Heat_Strength56_g20496 = _Heat_Instance;
			float4 lerpResult69_g20496 = lerp( float4( 0,0,0,0 ) , ( saturate( 2.0f*blendOpDest63_g20496*blendOpSrc63_g20496 + blendOpDest63_g20496*blendOpDest63_g20496*(1.0f - 2.0f*blendOpSrc63_g20496) )) , Heat_Strength56_g20496);
			float4 blendOpSrc62_g20496 = ( _CharColor2 * AlbedoTex5_Green44_g20496 );
			float4 blendOpDest62_g20496 = ( _CharColor1 * AlbedoTex5_Red38_g20496 );
			half _Burned_Instance = UNITY_ACCESS_INSTANCED_PROP(_Burned_arr, _Burned);
			half Burn_Strength64_g20496 = _Burned_Instance;
			float4 lerpResult74_g20496 = lerp( lerpResult69_g20496 , ( ( saturate( ( blendOpSrc62_g20496 + blendOpDest62_g20496 ) )) * ( ( AlbedoTex5_Blue36_g20496 * 0.5 ) + 0.5 ) ) , Burn_Strength64_g20496);
			float4 appendResult83_g20496 = (float4(lerpResult74_g20496.rgb , 1.0));
			float4 Burn_Tex88_g20496 = appendResult83_g20496;
			float _Wetness_Instance = UNITY_ACCESS_INSTANCED_PROP(_Wetness_arr, _Wetness);
			float temp_output_118_0_g20496 = _Wetness_Instance;
			float blend_strength79_g20504 = saturate( ( max( Burn_Strength64_g20496 , Heat_Strength56_g20496 ) * ( 1.0 - temp_output_118_0_g20496 ) ) );
			float4 lerpResult43_g20504 = lerp( ( float4( temp_output_262_31 , 0.0 ) * color73_g20504 ) , ( float4( Burn_Tex88_g20496.xyz , 0.0 ) * color73_g20504 ) , blend_strength79_g20504);
			float4 temp_output_166_0_g20496 = lerpResult43_g20504;
			#ifdef _BURNABLE_ON
				float3 staticSwitch276 = (temp_output_166_0_g20496).rgb;
			#else
				float3 staticSwitch276 = temp_output_262_31;
			#endif
			float temp_output_98_942_g20377 = triplanar951_g20383.x;
			float lerpResult52_g20377 = lerp( break37_g20377.x , ( temp_output_98_942_g20377 * _TerrainMetallic ) , blend32_g20377.x);
			#ifdef _TERRAINBLEND_ON
				float staticSwitch238 = lerpResult52_g20377;
			#else
				float staticSwitch238 = _METALLIC33;
			#endif
			float lerpResult106_g20504 = lerp( staticSwitch238 , 1.0 , blend_strength79_g20504);
			#ifdef _BURNABLE_ON
				float staticSwitch278 = lerpResult106_g20504;
			#else
				float staticSwitch278 = staticSwitch238;
			#endif
			float temp_output_98_897_g20377 = triplanar951_g20383.w;
			float lerpResult57_g20377 = lerp( break37_g20377.w , ( (( _InvertTerrainSmoothness )?( ( 1.0 - temp_output_98_897_g20377 ) ):( temp_output_98_897_g20377 )) * _TerrainGlossiness ) , blend32_g20377.x);
			#ifdef _TERRAINBLEND_ON
				float staticSwitch241 = lerpResult57_g20377;
			#else
				float staticSwitch241 = _SMOOTHNESS58;
			#endif
			float lerpResult31_g20504 = lerp( staticSwitch241 , 0.35 , blend_strength79_g20504);
			#ifdef _BURNABLE_ON
				float staticSwitch281 = lerpResult31_g20504;
			#else
				float staticSwitch281 = staticSwitch241;
			#endif
			float temp_output_10_0_g20542 = staticSwitch281;
			float lerpResult18_g20542 = lerp( 1.0 , ( 1.0 - _WetnessDarkening ) , ( ( 1.0 - staticSwitch278 ) * saturate( ( ( ( 1.0 - temp_output_10_0_g20542 ) - 0.5 ) / max( _WetnessPorosity , 0.001 ) ) ) ));
			float3 _NORMAL_TS25 = UnpackScaleNormal( tex2D( _BumpMap, UV77 ), _BumpScale );
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3x3 ase_worldToTangent = float3x3( ase_worldTangent, ase_worldBitangent, ase_worldNormal );
			float3 triplanar950_g20383 = TriplanarSamplingSNF( _TerrainBumpMap, temp_output_953_0_g20383, ase_worldNormal, temp_output_925_0_g20383, temp_output_926_0_g20383, _TerrainBumpMapScale, 0 );
			float3 tanTriplanarNormal950_g20383 = mul( ase_worldToTangent, triplanar950_g20383 );
			float3 lerpResult33_g20377 = lerp( _NORMAL_TS25 , tanTriplanarNormal950_g20383 , blend32_g20377.xyz);
			#ifdef _TERRAINBLEND_ON
				float3 staticSwitch243 = lerpResult33_g20377;
			#else
				float3 staticSwitch243 = _NORMAL_TS25;
			#endif
			float3 temp_output_4_0_g20505 = staticSwitch243;
			float3 a13_g20505 = temp_output_4_0_g20505;
			float2 uv_CharNormal81_g20496 = i.uv_texcoord;
			half3 CharNormal85_g20496 = UnpackScaleNormal( tex2D( _CharNormal, uv_CharNormal81_g20496 ), _CharredNormalScale );
			float3 temp_output_5_0_g20505 = CharNormal85_g20496;
			float3 ab14_g20505 = BlendNormals( temp_output_4_0_g20505 , temp_output_5_0_g20505 );
			float temp_output_21_0_g20505 = saturate( blend_strength79_g20504 );
			float3 lerpResult8_g20505 = lerp( a13_g20505 , ab14_g20505 , temp_output_21_0_g20505);
			float3 b19_g20505 = temp_output_5_0_g20505;
			float3 lerpResult22_g20505 = lerp( lerpResult8_g20505 , b19_g20505 , saturate( ( ( temp_output_21_0_g20505 * 2.0 ) - 1.0 ) ));
			float3 normalizeResult11_g20505 = normalize( lerpResult22_g20505 );
			#ifdef _BURNABLE_ON
				float3 staticSwitch277 = normalizeResult11_g20505;
			#else
				float3 staticSwitch277 = staticSwitch243;
			#endif
			float _RainWetness_Instance = UNITY_ACCESS_INSTANCED_PROP(_RainWetness_arr, _RainWetness);
			float _SubmersionWetness_Instance = UNITY_ACCESS_INSTANCED_PROP(_SubmersionWetness_arr, _SubmersionWetness);
			float Wetness_Strength298 = _Wetness_Instance;
			float temp_output_24_0_g20540 = max( max( ( normalize( (WorldNormalVector( i , staticSwitch277 )) ).y * _RainWetness_Instance ) , _SubmersionWetness_Instance ) , ( Wetness_Strength298 * tex2D( _WetnessMask, UV77 ).r ) );
			float lerpResult22_g20542 = lerp( 1.0 , lerpResult18_g20542 , temp_output_24_0_g20540);
			#ifdef _WETTABLE_ON
				float4 staticSwitch307 = ( float4( staticSwitch276 , 0.0 ) * lerpResult22_g20542 );
			#else
				float4 staticSwitch307 = float4( staticSwitch276 , 0.0 );
			#endif
			float3 albedo51_g20547 = staticSwitch307.rgb;
			s1_g20547.Albedo = albedo51_g20547;
			float3 temp_output_55_0_g20547 = staticSwitch277;
			float3 normal_TS54_g20547 = temp_output_55_0_g20547;
			s1_g20547.Normal = WorldNormalVector( i , normal_TS54_g20547 );
			float4 _EMISSION20 = ( tex2D( _EmissionMap, UV77 ) * _EmissionColor * _EmissionStrength );
			#ifdef _TERRAINBLEND_ON
				float4 staticSwitch242 = _EMISSION20;
			#else
				float4 staticSwitch242 = _EMISSION20;
			#endif
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float fresnelNdotV122_g20496 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode122_g20496 = ( _GlowBias + _GlowScale * pow( 1.0 - fresnelNdotV122_g20496, _GlowPower ) );
			float4 blendOpSrc84_g20496 = temp_output_41_0_g20496;
			float4 blendOpDest84_g20496 = float4( 0,0,0,0 );
			float4 appendResult87_g20496 = (float4(( saturate( (( blendOpSrc84_g20496 > 0.5 ) ? max( blendOpDest84_g20496, 2.0 * ( blendOpSrc84_g20496 - 0.5 ) ) : min( blendOpDest84_g20496, 2.0 * blendOpSrc84_g20496 ) ) )).rgb , 1.0));
			float4 Emission_Tex89_g20496 = appendResult87_g20496;
			float4 temp_cast_42 = (min( _Heat_Instance , ( 1.0 - _GLOBAL_SOLAR_TIME ) )).xxxx;
			float lerpResult632_g20499 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH , _WIND_AUDIO_INFLUENCE);
			float temp_output_15_0_g20500 = lerpResult632_g20499;
			float lerpResult638_g20499 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_VERYHIGH , _WIND_AUDIO_INFLUENCE);
			float temp_output_16_0_g20500 = lerpResult638_g20499;
			float lerpResult633_g20499 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_HIGH , _WIND_AUDIO_INFLUENCE);
			float temp_output_17_0_g20500 = lerpResult633_g20499;
			float4 temp_cast_43 = (( 1.0 - saturate( ( ( temp_output_15_0_g20500 + temp_output_16_0_g20500 + temp_output_17_0_g20500 ) / 3.0 ) ) )).xxxx;
			float4 temp_cast_44 = (1.0).xxxx;
			half _WindProtection_Instance = UNITY_ACCESS_INSTANCED_PROP(_WindProtection_arr, _WindProtection);
			float4 lerpResult80_g20496 = lerp( CalculateContrast(_EmissionContrast,temp_cast_43) , temp_cast_44 , _WindProtection_Instance);
			half4 Glow_Strength90_g20496 = min( temp_cast_42 , lerpResult80_g20496 );
			float4 lerpResult99_g20504 = lerp( staticSwitch242 , saturate( ( fresnelNode122_g20496 * temp_output_118_0_g20496 * Emission_Tex89_g20496 * Glow_Strength90_g20496 ) ) , blend_strength79_g20504);
			#ifdef _BURNABLE_ON
				float4 staticSwitch282 = lerpResult99_g20504;
			#else
				float4 staticSwitch282 = staticSwitch242;
			#endif
			float3 emissive71_g20547 = staticSwitch282.rgb;
			s1_g20547.Emission = emissive71_g20547;
			float metallic34_g20547 = staticSwitch278;
			s1_g20547.Metallic = metallic34_g20547;
			float lerpResult24_g20542 = lerp( temp_output_10_0_g20542 , saturate( _WetnessSmoothness ) , temp_output_24_0_g20540);
			#ifdef _WETTABLE_ON
				float staticSwitch308 = saturate( lerpResult24_g20542 );
			#else
				float staticSwitch308 = staticSwitch281;
			#endif
			float smoothness39_g20547 = staticSwitch308;
			s1_g20547.Smoothness = smoothness39_g20547;
			float temp_output_262_0 = temp_output_16_0_g20384;
			#ifdef _TERRAINBLEND_ON
				float staticSwitch269 = saturate( ( temp_output_262_0 + _OCCLUSION_PROBE_TERRAIN_BLEND ) );
			#else
				float staticSwitch269 = temp_output_262_0;
			#endif
			float lerpResult34_g20504 = lerp( staticSwitch269 , 1.0 , blend_strength79_g20504);
			#ifdef _BURNABLE_ON
				float staticSwitch279 = lerpResult34_g20504;
			#else
				float staticSwitch279 = staticSwitch269;
			#endif
			float occlusion188_g20547 = staticSwitch279;
			s1_g20547.Occlusion = occlusion188_g20547;

			data.light = gi.light;

			UnityGI gi1_g20547 = gi;
			#ifdef UNITY_PASS_FORWARDBASE
			Unity_GlossyEnvironmentData g1_g20547 = UnityGlossyEnvironmentSetup( s1_g20547.Smoothness, data.worldViewDir, s1_g20547.Normal, float3(0,0,0));
			gi1_g20547 = UnityGlobalIllumination( data, s1_g20547.Occlusion, s1_g20547.Normal, g1_g20547 );
			#endif

			float3 surfResult1_g20547 = LightingStandard ( s1_g20547, viewDir, gi1_g20547 ).rgb;
			surfResult1_g20547 += s1_g20547.Emission;

			#ifdef UNITY_PASS_FORWARDADD//1_g20547
			surfResult1_g20547 -= s1_g20547.Emission;
			#endif//1_g20547
			float3 clampResult196_g20547 = clamp( surfResult1_g20547 , float3(0,0,0) , float3(50,50,50) );
			c.rgb = clampResult196_g20547;
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
			float temp_output_36_0_g20384 = 1.0;
			float2 uv0_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 UV77 = uv0_MainTex;
			float4 tex2DNode34 = tex2D( _MetallicGlossMap, UV77 );
			float lerpResult74 = lerp( 1.0 , tex2DNode34.g , _OcclusionStrength);
			float _OCCLUSION48 = lerpResult74;
			float lerpResult340 = lerp( tex2DNode34.r , 1.0 , _IgnoreMetallicMap);
			float _METALLIC33 = ( lerpResult340 * _Metallic );
			float lerpResult311 = lerp( 0.5 , tex2DNode34.b , _DisplacementStrength);
			float _DISPLACEMENT312 = lerpResult311;
			float _SMOOTHNESS58 = ( (( _InvertSmoothness )?( ( 1.0 - tex2DNode34.a ) ):( tex2DNode34.a )) * _Glossiness );
			float4 appendResult240 = (float4(_METALLIC33 , _OCCLUSION48 , _DISPLACEMENT312 , _SMOOTHNESS58));
			float4 temp_output_16_0_g20377 = appendResult240;
			float4 break37_g20377 = temp_output_16_0_g20377;
			float2 temp_output_926_0_g20383 = ( (1.0).xx / (( _TerrainScale == (0.0).xx ) ? (1.0).xx :  _TerrainScale ) );
			float temp_output_925_0_g20383 = _TriplanarContrast;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float2 break955_g20383 = _TerrainOffset;
			float3 appendResult954_g20383 = (float3(break955_g20383.x , 0.0 , break955_g20383.y));
			float3 temp_output_953_0_g20383 = ( appendResult954_g20383 + ase_worldPos );
			float4 triplanar951_g20383 = TriplanarSamplingSF( _TerrainMetallicGlossMap, temp_output_953_0_g20383, ase_worldNormal, temp_output_925_0_g20383, temp_output_926_0_g20383, 1.0, 0 );
			float temp_output_98_900_g20377 = triplanar951_g20383.y;
			float lerpResult89_g20377 = lerp( 1.0 , temp_output_98_900_g20377 , _TerrainOcclusionStrength);
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float temp_output_88_0_g20298 = _Contrast;
			float4 tex2DNode2 = tex2D( _MainTex, UV77 );
			float4 temp_output_89_0_g20298 = ( tex2DNode2 * _Color );
			float3 hsvTorgb92_g20298 = RGBToHSV( temp_output_89_0_g20298.rgb );
			float temp_output_118_0_g20298 = 1.0;
			float3 hsvTorgb83_g20298 = HSVToRGB( float3(hsvTorgb92_g20298.x,( hsvTorgb92_g20298.y * ( temp_output_118_0_g20298 + _Saturation ) ),( hsvTorgb92_g20298.z * ( temp_output_118_0_g20298 + _Brightness ) )) );
			float4 _ALBEDO23 = CalculateContrast(temp_output_88_0_g20298,( float4( hsvTorgb83_g20298 , 0.0 ) * ( 1.0 / (( _ContrastCorrection == 0.0 ) ? 1.0 :  _ContrastCorrection ) ) ));
			float4 temp_output_14_0_g20377 = _ALBEDO23;
			float4 break28_g20377 = temp_output_14_0_g20377;
			float temp_output_15_0_g20382 = break28_g20377.r;
			float temp_output_16_0_g20382 = break28_g20377.g;
			float temp_output_17_0_g20382 = break28_g20377.b;
			float temp_output_24_0_g20379 = ( ( temp_output_15_0_g20382 + temp_output_16_0_g20382 + temp_output_17_0_g20382 ) / 3.0 );
			float temp_output_21_0_g20379 = _BlendThreshold;
			float temp_output_31_0_g20379 = ( temp_output_21_0_g20379 + min( _BlendFade , ( abs( temp_output_21_0_g20379 ) * 5.0 ) ) );
			float temp_output_7_0_g20381 = temp_output_31_0_g20379;
			float4 blend32_g20377 = (( (( ase_vertex3Pos.y > (( _LimitBlendHeight )?( _BlendHeightLimit ):( 10240.0 )) ) ? 0.0 :  1.0 ) * (( temp_output_24_0_g20379 < temp_output_21_0_g20379 ) ? 1.0 :  (( temp_output_24_0_g20379 < temp_output_31_0_g20379 ) ? ( ( temp_output_24_0_g20379 - temp_output_7_0_g20381 ) / ( temp_output_21_0_g20379 - temp_output_7_0_g20381 ) ) :  0.0 ) ) )).xxxx;
			float lerpResult53_g20377 = lerp( break37_g20377.y , lerpResult89_g20377 , blend32_g20377.x);
			#ifdef _TERRAINBLEND_ON
				float staticSwitch239 = lerpResult53_g20377;
			#else
				float staticSwitch239 = _OCCLUSION48;
			#endif
			float lerpResult38_g20384 = lerp( temp_output_36_0_g20384 , staticSwitch239 , _Occlusion);
			float3 positionWS3_g20387 = ase_worldPos;
			float4x4 OcclusionProbesWorldToLocal3_g20387 = _OcclusionProbesWorldToLocal;
			float4 _OcclusionProbes_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_OcclusionProbes_ST_arr, _OcclusionProbes_ST);
			float3 uv_OcclusionProbes3 = i.uv_tex3coord;
			uv_OcclusionProbes3.xy = i.uv_tex3coord.xy * _OcclusionProbes_ST_Instance.xy + _OcclusionProbes_ST_Instance.zw;
			float OcclusionProbes3_g20387 = tex3D( _OcclusionProbes, uv_OcclusionProbes3 ).r;
			float localSampleOcclusionProbes3_g20387 = SampleOcclusionProbes( positionWS3_g20387 , OcclusionProbesWorldToLocal3_g20387 , OcclusionProbes3_g20387 );
			float lerpResult1_g20387 = lerp( 1.0 , localSampleOcclusionProbes3_g20387 , ( _AOProbeStrength * _OCCLUSION_PROBE_GLOBAL ));
			float temp_output_7_0_g20384 = ( saturate( ( lerpResult38_g20384 * temp_output_36_0_g20384 ) ) * lerpResult1_g20387 );
			float lerpResult18_g20384 = lerp( 1.0 , temp_output_7_0_g20384 , _AOIndirect);
			float lerpResult14_g20384 = lerp( 1.0 , temp_output_7_0_g20384 , _AODirect);
			float lerpResult1_g20384 = lerp( lerpResult18_g20384 , lerpResult14_g20384 , 1);
			float temp_output_16_0_g20384 = saturate( lerpResult1_g20384 );
			float4 triplanar949_g20383 = TriplanarSamplingSF( _TerrainTex, temp_output_953_0_g20383, ase_worldNormal, temp_output_925_0_g20383, temp_output_926_0_g20383, 1.0, 0 );
			float4 lerpResult13_g20377 = lerp( temp_output_14_0_g20377 , triplanar949_g20383 , blend32_g20377);
			#ifdef _TERRAINBLEND_ON
				float4 staticSwitch236 = lerpResult13_g20377;
			#else
				float4 staticSwitch236 = _ALBEDO23;
			#endif
			float3 temp_output_262_31 = ( temp_output_16_0_g20384 * staticSwitch236.rgb );
			float4 color73_g20504 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
			float2 appendResult22_g20496 = (float2(_BurnMapScaleX , _BurnMapScaleY));
			float2 uv_TexCoord24_g20496 = i.uv_texcoord * appendResult22_g20496;
			float4 tex2DNode34_g20496 = tex2D( _BurnMap, uv_TexCoord24_g20496 );
			half AlbedoTex5_Blue36_g20496 = tex2DNode34_g20496.b;
			float mulTime7_g20496 = _Time.y * _BurnSpeed;
			float2 appendResult3_g20496 = (float2(_BurnNoiseScaleX , _BurnNoiseScaleY));
			float2 uv_TexCoord5_g20496 = i.uv_texcoord * appendResult3_g20496;
			float4 tex2DNode11_g20496 = tex2D( _BurnNoise, uv_TexCoord5_g20496 );
			float clampResult8_g20509 = clamp( sin( ( mulTime7_g20496 + ( tex2DNode11_g20496.g * ( 2.0 * UNITY_PI ) ) + ( 0.5 * UNITY_PI ) ) ) , -1.0 , 1.0 );
			float temp_output_26_0_g20496 = ( ( clampResult8_g20509 * 0.5 ) + 0.5 );
			float4 temp_output_41_0_g20496 = ( _BurnColor2 * AlbedoTex5_Blue36_g20496 * temp_output_26_0_g20496 );
			half AlbedoTex5_Green44_g20496 = tex2DNode34_g20496.g;
			float clampResult8_g20511 = clamp( sin( ( mulTime7_g20496 + ( tex2DNode11_g20496.b * ( 2.0 * UNITY_PI ) ) + ( 1.0 * UNITY_PI ) ) ) , -1.0 , 1.0 );
			half AlbedoTex5_Red38_g20496 = tex2DNode34_g20496.r;
			float4 blendOpSrc58_g20496 = ( _BurnColor2 * AlbedoTex5_Green44_g20496 * ( ( ( ( clampResult8_g20511 * 0.5 ) + 0.5 ) * 0.5 ) + 0.5 ) );
			float4 blendOpDest58_g20496 = ( _BurnColor1 * AlbedoTex5_Red38_g20496 * ( ( temp_output_26_0_g20496 * 0.5 ) + 0.5 ) );
			float4 blendOpSrc63_g20496 = temp_output_41_0_g20496;
			float4 blendOpDest63_g20496 = ( saturate( ( 1.0 - ( 1.0 - blendOpSrc58_g20496 ) * ( 1.0 - blendOpDest58_g20496 ) ) ));
			half _Heat_Instance = UNITY_ACCESS_INSTANCED_PROP(_Heat_arr, _Heat);
			half Heat_Strength56_g20496 = _Heat_Instance;
			float4 lerpResult69_g20496 = lerp( float4( 0,0,0,0 ) , ( saturate( 2.0f*blendOpDest63_g20496*blendOpSrc63_g20496 + blendOpDest63_g20496*blendOpDest63_g20496*(1.0f - 2.0f*blendOpSrc63_g20496) )) , Heat_Strength56_g20496);
			float4 blendOpSrc62_g20496 = ( _CharColor2 * AlbedoTex5_Green44_g20496 );
			float4 blendOpDest62_g20496 = ( _CharColor1 * AlbedoTex5_Red38_g20496 );
			half _Burned_Instance = UNITY_ACCESS_INSTANCED_PROP(_Burned_arr, _Burned);
			half Burn_Strength64_g20496 = _Burned_Instance;
			float4 lerpResult74_g20496 = lerp( lerpResult69_g20496 , ( ( saturate( ( blendOpSrc62_g20496 + blendOpDest62_g20496 ) )) * ( ( AlbedoTex5_Blue36_g20496 * 0.5 ) + 0.5 ) ) , Burn_Strength64_g20496);
			float4 appendResult83_g20496 = (float4(lerpResult74_g20496.rgb , 1.0));
			float4 Burn_Tex88_g20496 = appendResult83_g20496;
			float _Wetness_Instance = UNITY_ACCESS_INSTANCED_PROP(_Wetness_arr, _Wetness);
			float temp_output_118_0_g20496 = _Wetness_Instance;
			float blend_strength79_g20504 = saturate( ( max( Burn_Strength64_g20496 , Heat_Strength56_g20496 ) * ( 1.0 - temp_output_118_0_g20496 ) ) );
			float4 lerpResult43_g20504 = lerp( ( float4( temp_output_262_31 , 0.0 ) * color73_g20504 ) , ( float4( Burn_Tex88_g20496.xyz , 0.0 ) * color73_g20504 ) , blend_strength79_g20504);
			float4 temp_output_166_0_g20496 = lerpResult43_g20504;
			#ifdef _BURNABLE_ON
				float3 staticSwitch276 = (temp_output_166_0_g20496).rgb;
			#else
				float3 staticSwitch276 = temp_output_262_31;
			#endif
			float temp_output_98_942_g20377 = triplanar951_g20383.x;
			float lerpResult52_g20377 = lerp( break37_g20377.x , ( temp_output_98_942_g20377 * _TerrainMetallic ) , blend32_g20377.x);
			#ifdef _TERRAINBLEND_ON
				float staticSwitch238 = lerpResult52_g20377;
			#else
				float staticSwitch238 = _METALLIC33;
			#endif
			float lerpResult106_g20504 = lerp( staticSwitch238 , 1.0 , blend_strength79_g20504);
			#ifdef _BURNABLE_ON
				float staticSwitch278 = lerpResult106_g20504;
			#else
				float staticSwitch278 = staticSwitch238;
			#endif
			float temp_output_98_897_g20377 = triplanar951_g20383.w;
			float lerpResult57_g20377 = lerp( break37_g20377.w , ( (( _InvertTerrainSmoothness )?( ( 1.0 - temp_output_98_897_g20377 ) ):( temp_output_98_897_g20377 )) * _TerrainGlossiness ) , blend32_g20377.x);
			#ifdef _TERRAINBLEND_ON
				float staticSwitch241 = lerpResult57_g20377;
			#else
				float staticSwitch241 = _SMOOTHNESS58;
			#endif
			float lerpResult31_g20504 = lerp( staticSwitch241 , 0.35 , blend_strength79_g20504);
			#ifdef _BURNABLE_ON
				float staticSwitch281 = lerpResult31_g20504;
			#else
				float staticSwitch281 = staticSwitch241;
			#endif
			float temp_output_10_0_g20542 = staticSwitch281;
			float lerpResult18_g20542 = lerp( 1.0 , ( 1.0 - _WetnessDarkening ) , ( ( 1.0 - staticSwitch278 ) * saturate( ( ( ( 1.0 - temp_output_10_0_g20542 ) - 0.5 ) / max( _WetnessPorosity , 0.001 ) ) ) ));
			float3 _NORMAL_TS25 = UnpackScaleNormal( tex2D( _BumpMap, UV77 ), _BumpScale );
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3x3 ase_worldToTangent = float3x3( ase_worldTangent, ase_worldBitangent, ase_worldNormal );
			float3 triplanar950_g20383 = TriplanarSamplingSNF( _TerrainBumpMap, temp_output_953_0_g20383, ase_worldNormal, temp_output_925_0_g20383, temp_output_926_0_g20383, _TerrainBumpMapScale, 0 );
			float3 tanTriplanarNormal950_g20383 = mul( ase_worldToTangent, triplanar950_g20383 );
			float3 lerpResult33_g20377 = lerp( _NORMAL_TS25 , tanTriplanarNormal950_g20383 , blend32_g20377.xyz);
			#ifdef _TERRAINBLEND_ON
				float3 staticSwitch243 = lerpResult33_g20377;
			#else
				float3 staticSwitch243 = _NORMAL_TS25;
			#endif
			float3 temp_output_4_0_g20505 = staticSwitch243;
			float3 a13_g20505 = temp_output_4_0_g20505;
			float2 uv_CharNormal81_g20496 = i.uv_texcoord;
			half3 CharNormal85_g20496 = UnpackScaleNormal( tex2D( _CharNormal, uv_CharNormal81_g20496 ), _CharredNormalScale );
			float3 temp_output_5_0_g20505 = CharNormal85_g20496;
			float3 ab14_g20505 = BlendNormals( temp_output_4_0_g20505 , temp_output_5_0_g20505 );
			float temp_output_21_0_g20505 = saturate( blend_strength79_g20504 );
			float3 lerpResult8_g20505 = lerp( a13_g20505 , ab14_g20505 , temp_output_21_0_g20505);
			float3 b19_g20505 = temp_output_5_0_g20505;
			float3 lerpResult22_g20505 = lerp( lerpResult8_g20505 , b19_g20505 , saturate( ( ( temp_output_21_0_g20505 * 2.0 ) - 1.0 ) ));
			float3 normalizeResult11_g20505 = normalize( lerpResult22_g20505 );
			#ifdef _BURNABLE_ON
				float3 staticSwitch277 = normalizeResult11_g20505;
			#else
				float3 staticSwitch277 = staticSwitch243;
			#endif
			float _RainWetness_Instance = UNITY_ACCESS_INSTANCED_PROP(_RainWetness_arr, _RainWetness);
			float _SubmersionWetness_Instance = UNITY_ACCESS_INSTANCED_PROP(_SubmersionWetness_arr, _SubmersionWetness);
			float Wetness_Strength298 = _Wetness_Instance;
			float temp_output_24_0_g20540 = max( max( ( normalize( (WorldNormalVector( i , staticSwitch277 )) ).y * _RainWetness_Instance ) , _SubmersionWetness_Instance ) , ( Wetness_Strength298 * tex2D( _WetnessMask, UV77 ).r ) );
			float lerpResult22_g20542 = lerp( 1.0 , lerpResult18_g20542 , temp_output_24_0_g20540);
			#ifdef _WETTABLE_ON
				float4 staticSwitch307 = ( float4( staticSwitch276 , 0.0 ) * lerpResult22_g20542 );
			#else
				float4 staticSwitch307 = float4( staticSwitch276 , 0.0 );
			#endif
			float3 albedo51_g20547 = staticSwitch307.rgb;
			o.Albedo = ( _GlobalIlluminationAlbedoEffect * albedo51_g20547 );
			float4 _EMISSION20 = ( tex2D( _EmissionMap, UV77 ) * _EmissionColor * _EmissionStrength );
			#ifdef _TERRAINBLEND_ON
				float4 staticSwitch242 = _EMISSION20;
			#else
				float4 staticSwitch242 = _EMISSION20;
			#endif
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float fresnelNdotV122_g20496 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode122_g20496 = ( _GlowBias + _GlowScale * pow( 1.0 - fresnelNdotV122_g20496, _GlowPower ) );
			float4 blendOpSrc84_g20496 = temp_output_41_0_g20496;
			float4 blendOpDest84_g20496 = float4( 0,0,0,0 );
			float4 appendResult87_g20496 = (float4(( saturate( (( blendOpSrc84_g20496 > 0.5 ) ? max( blendOpDest84_g20496, 2.0 * ( blendOpSrc84_g20496 - 0.5 ) ) : min( blendOpDest84_g20496, 2.0 * blendOpSrc84_g20496 ) ) )).rgb , 1.0));
			float4 Emission_Tex89_g20496 = appendResult87_g20496;
			float4 temp_cast_18 = (min( _Heat_Instance , ( 1.0 - _GLOBAL_SOLAR_TIME ) )).xxxx;
			float lerpResult632_g20499 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH , _WIND_AUDIO_INFLUENCE);
			float temp_output_15_0_g20500 = lerpResult632_g20499;
			float lerpResult638_g20499 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_VERYHIGH , _WIND_AUDIO_INFLUENCE);
			float temp_output_16_0_g20500 = lerpResult638_g20499;
			float lerpResult633_g20499 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_HIGH , _WIND_AUDIO_INFLUENCE);
			float temp_output_17_0_g20500 = lerpResult633_g20499;
			float4 temp_cast_19 = (( 1.0 - saturate( ( ( temp_output_15_0_g20500 + temp_output_16_0_g20500 + temp_output_17_0_g20500 ) / 3.0 ) ) )).xxxx;
			float4 temp_cast_20 = (1.0).xxxx;
			half _WindProtection_Instance = UNITY_ACCESS_INSTANCED_PROP(_WindProtection_arr, _WindProtection);
			float4 lerpResult80_g20496 = lerp( CalculateContrast(_EmissionContrast,temp_cast_19) , temp_cast_20 , _WindProtection_Instance);
			half4 Glow_Strength90_g20496 = min( temp_cast_18 , lerpResult80_g20496 );
			float4 lerpResult99_g20504 = lerp( staticSwitch242 , saturate( ( fresnelNode122_g20496 * temp_output_118_0_g20496 * Emission_Tex89_g20496 * Glow_Strength90_g20496 ) ) , blend_strength79_g20504);
			#ifdef _BURNABLE_ON
				float4 staticSwitch282 = lerpResult99_g20504;
			#else
				float4 staticSwitch282 = staticSwitch242;
			#endif
			float3 emissive71_g20547 = staticSwitch282.rgb;
			o.Emission = ( _GlobalIlluminationEmissiveEffect * emissive71_g20547 );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows dithercrossfade vertex:vertexDataFunc 

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
				vertexDataFunc( v, customInputData );
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
	CustomEditor "AppalachiaShaderEditorGUI"
}
/*ASEBEGIN
Version=17500
533.6;-864;1536;843;3140.171;94.84265;1;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;76;-3328,-1024;Inherit;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;77;-3104,-1024;Inherit;False;UV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;81;-3706,321;Inherit;False;77;UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;34;-3456,304;Inherit;True;Property;_MetallicGlossMap;Surface Map;25;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;48cc708243ed3d040892659b8e8cae8c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;341;-2609.171,153.1573;Inherit;False;Constant;_Float20;Float 20;64;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;42;-2833.917,336;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;339;-2860.171,221.1573;Inherit;False;Property;_IgnoreMetallicMap;Ignore Metallic Map;26;1;[Toggle];Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;192;-2639.263,1298.474;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;162;-2309.282,1480.282;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-2542.917,384;Inherit;False;Property;_Metallic;Metallic;27;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;340;-2397.171,222.1573;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-2560,1024;Inherit;False;Property;_OcclusionStrength;Occlusion;31;0;Create;False;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;59;-2820,849;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;313;-2514.275,1172.531;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;75;-2369,852;Inherit;False;Constant;_Float0;Float 0;24;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;314;-2063.151,1098.441;Inherit;False;Constant;_Float50;Float 50;24;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-2202.775,1606.111;Inherit;False;Property;_Glossiness;Smoothness;28;0;Create;False;0;0;False;0;0.1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;21;-2744,-832;Inherit;False;Property;_Color;Color;9;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;161;-2105.775,1391.111;Inherit;False;Property;_InvertSmoothness;Invert Smoothness;29;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-2814,-1024;Inherit;True;Property;_MainTex;Albedo;8;0;Create;False;0;0;False;0;-1;None;c37675aa7c2afbb4fbf491de96addd18;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;310;-2159.57,1243.46;Inherit;False;Property;_DisplacementStrength;Displacement;30;0;Create;False;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;74;-2176,896;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-3184,-592;Inherit;False;Property;_BumpScale;Normal Scale;16;0;Create;False;0;0;False;0;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-1813.775,1337.111;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-2177.917,256;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;197;-2560,-1287.6;Inherit;False;Property;_ContrastCorrection;Contrast Correction;13;0;Create;True;0;0;False;0;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;196;-2560,-1367.6;Inherit;False;Property;_Contrast;Contrast;12;0;Create;True;0;0;False;0;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;194;-2555,-1450.6;Inherit;False;Property;_Brightness;Brightness;11;0;Create;True;0;0;False;0;0;0;-1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;311;-1798.57,1108.46;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;195;-2556,-1536.6;Inherit;False;Property;_Saturation;Saturation;10;0;Create;True;0;0;False;0;0;0;-1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;78;-3090,-671;Inherit;False;77;UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-2496,-960;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;58;-1685.775,1337.111;Inherit;False;_SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;257;-2195.25,-1041.027;Inherit;False;Color Adjustment;-1;;20298;f9571dc7cf91d954d87b44c4dd2d35aa;6,90,0,81,1,91,1,85,1,116,0,111,1;6;89;COLOR;0,0,0,0;False;82;FLOAT;0;False;86;FLOAT;0;False;87;FLOAT;0;False;88;FLOAT;0;False;115;FLOAT;0;False;1;COLOR;37
Node;AmplifyShaderEditor.SamplerNode;3;-2816,-640;Inherit;True;Property;_BumpMap;Normal;15;2;[NoScaleOffset];[Normal];Create;False;0;0;False;0;-1;None;860eb468a6bfcc74b8288d6457a5bfa6;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;312;-1638.57,1111.46;Inherit;False;_DISPLACEMENT;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;48;-2017,897;Inherit;False;_OCCLUSION;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;33;-2049.917,256;Inherit;False;_METALLIC;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;86;-1920,-480;Inherit;False;33;_METALLIC;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;23;-1911.4,-976.9;Inherit;False;_ALBEDO;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;88;-1920,-400;Inherit;False;48;_OCCLUSION;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;25;-2432,-640;Inherit;False;_NORMAL_TS;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;87;-1920,-240;Inherit;False;58;_SMOOTHNESS;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;315;-1920,-320;Inherit;False;312;_DISPLACEMENT;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;240;-1493.096,167.2409;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;27;-1920,-640;Inherit;False;25;_NORMAL_TS;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;26;-1920,-144;Inherit;False;23;_ALBEDO;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;271;-1267.151,130.0963;Inherit;False;Simple Terrain Blend;45;;20377;4ec8628d052b96241b6cd175c39d3369;0;3;14;COLOR;0,0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;7;FLOAT4;0;FLOAT3;6;FLOAT4;11;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10
Node;AmplifyShaderEditor.StaticSwitch;239;-576,-336;Inherit;False;Property;_TerrainBlend;Terrain Blend;61;0;Create;True;0;0;True;0;0;0;0;True;;Toggle;2;Key0;Key1;Reference;236;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;79;-3072,-352;Inherit;False;77;UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;236;-576,0;Inherit;False;Property;_TerrainBlend;Terrain Blend;43;0;Create;True;0;0;True;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;270;-329.3,310.4;Inherit;False;Global;_OCCLUSION_PROBE_TERRAIN_BLEND;_OCCLUSION_PROBE_TERRAIN_BLEND;40;0;Create;True;0;0;False;0;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-2817,-16;Inherit;False;Property;_EmissionStrength;Emission Strength;20;0;Create;True;0;0;False;0;1;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;262;-161.6,78.4;Inherit;False;Occlusion Probes;32;;20384;fc5cec86a89be184e93fc845da77a0cc;4,64,1,22,1,65,1,66,0;3;12;FLOAT;0;False;48;FLOAT;0;False;26;FLOAT3;1,1,1;False;2;FLOAT;0;FLOAT3;31
Node;AmplifyShaderEditor.SamplerNode;4;-2828,-404;Inherit;True;Property;_EmissionMap;Emission Map;18;1;[NoScaleOffset];Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;5;-2752,-192;Inherit;False;Property;_EmissionColor;Emission Color;19;0;Create;False;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;267;24,297.6;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-2432,-384;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;268;156.8,297.6;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;20;-2264.4,-391.8;Inherit;False;_EMISSION;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;316;-576,-224;Inherit;False;Property;_TerrainBlend2;Terrain Blend;43;0;Create;True;0;0;True;0;0;0;0;True;;Toggle;2;Key0;Key1;Reference;236;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;241;-576,-112;Inherit;False;Property;_TerrainBlend;Terrain Blend;47;0;Create;True;0;0;True;0;0;0;0;True;;Toggle;2;Key0;Key1;Reference;236;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;269;304.6,201.6;Inherit;False;Property;_TerrainBlend1;Terrain Blend;44;0;Create;True;0;0;True;0;0;0;1;True;;Toggle;2;Key0;Key1;Reference;236;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;243;-576,-672;Inherit;False;Property;_TerrainBlend;Terrain Blend;43;0;Create;True;0;0;True;0;0;0;0;True;;Toggle;2;Key0;Key1;Reference;236;True;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;28;-1920,-560;Inherit;False;20;_EMISSION;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;238;-576,-448;Inherit;False;Property;_TerrainBlend;Terrain Blend;45;0;Create;True;0;0;True;0;0;0;0;True;;Toggle;2;Key0;Key1;Reference;236;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;294;624,160;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;293;624,112;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;291;624,34;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;295;624,-352;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;242;-576,-560;Inherit;False;Property;_TerrainBlend;Terrain Blend;48;0;Create;True;0;0;True;0;0;0;0;True;;Toggle;2;Key0;Key1;Reference;236;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;290;624,64;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;292;624,80;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;297;640,384;Inherit;False;InstancedProperty;_Wetness;Wetness;100;1;[PerRendererData];Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;317;624,144;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;285;1136,-128;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;289;1136,-400;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;288;1136,-464;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;305;915.754,20.1334;Inherit;False;Burnable;71;;20496;a0caf447e4aba704388d4974489e2842;0;8;138;FLOAT3;0,0,0;False;131;FLOAT3;0,0,0;False;168;FLOAT;0;False;132;FLOAT;0;False;145;FLOAT;0;False;134;FLOAT;0;False;162;COLOR;0,0,0,0;False;118;FLOAT;0;False;8;COLOR;151;FLOAT3;169;FLOAT3;150;FLOAT;167;FLOAT;149;FLOAT;148;FLOAT;147;COLOR;0
Node;AmplifyShaderEditor.WireNode;287;1136,-288;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;277;1463.977,-460.6088;Inherit;False;Property;_Burnable1;Burnable;65;0;Create;True;0;0;True;0;0;0;1;True;;Toggle;2;Key0;Key1;Reference;276;True;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;276;1457.808,-564.4088;Inherit;False;Property;_Burnable;Burnable;63;0;Create;True;0;0;True;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;298;1024,384;Inherit;False;Wetness_Strength;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;323;1613,357;Inherit;False;InstancedProperty;_SubmersionWetness;Submersion Wetness;101;1;[PerRendererData];Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;324;1602,264;Inherit;False;InstancedProperty;_RainWetness;Rain Wetness;102;1;[PerRendererData];Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;281;1472,-48;Inherit;False;Property;_Burnable5;Burnable;69;0;Create;True;0;0;True;0;0;0;1;True;;Toggle;2;Key0;Key1;Reference;276;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;296;624,-80;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;319;1795.285,512.4242;Inherit;False;77;UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;278;1463.977,-364.6089;Inherit;False;Property;_Burnable2;Burnable;66;0;Create;True;0;0;True;0;0;0;1;True;;Toggle;2;Key0;Key1;Reference;276;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;284;1136,-32;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;286;1136,-192;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;330;2068.5,7.499992;Inherit;False;Wettable;94;;20540;ab843f2248a33694ab8e680c830bea7f;0;8;14;FLOAT;1;False;18;FLOAT;1;False;19;FLOAT;1;False;21;FLOAT3;1,0,0;False;11;COLOR;1,1,1,1;False;13;FLOAT;0;False;12;FLOAT;0;False;17;FLOAT2;1,1;False;2;COLOR;9;FLOAT;10
Node;AmplifyShaderEditor.CommentaryNode;331;1435.495,754.1688;Inherit;False;494.9983;670.553;Rendering;5;272;333;334;335;336;;0,0.0238266,1,1;0;0
Node;AmplifyShaderEditor.StaticSwitch;308;2469,-77;Inherit;False;Property;_Burnable4;Burnable;64;0;Create;True;0;0;True;0;0;0;1;True;;Toggle;2;Key0;Key1;Reference;307;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;200;885.158,724.5157;Inherit;False;420.0045;734.6437;Drawers;5;301;202;226;212;337;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.FunctionNode;329;3125.944,116.5086;Inherit;False;Grounding;105;;20543;79042621b6bed2a41810809c7a256ec9;0;0;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;279;1463.977,-268.6089;Inherit;False;Property;_Burnable3;Burnable;67;0;Create;True;0;0;True;0;0;0;1;True;;Toggle;2;Key0;Key1;Reference;276;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;282;1472,48;Inherit;False;Property;_Burnable6;Burnable;70;0;Create;True;0;0;True;0;0;0;1;True;;Toggle;2;Key0;Key1;Reference;276;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;307;2474.6,-525.7;Inherit;False;Property;_Wettable;Wettable;93;0;Create;True;0;0;True;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;225;3339.245,89.11301;Inherit;False;Property;_Grounded;Grounded;104;0;Create;True;0;0;True;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;336;1734.482,1190.294;Inherit;False;Property;_ZTestMode;ZTest Mode;6;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CompareFunction;True;0;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;337;1124.221,1087.567;Half;False;Property;_WETT;[ WETT ];92;0;Create;True;0;0;True;1;InternalCategory(Wettable);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;301;922.5704,1167.98;Half;False;Property;_BURNN;[ BURNN ];62;0;Create;True;0;0;True;1;InternalCategory(Burn);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;199;914.957,1363.731;Inherit;False;Internal Features Support;-1;;20548;3c493d142aeebd840af72d626f6915c6;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;188;3195.182,-440.8716;Inherit;False;Custom Lighting;117;;20547;b225dcbb02c65fb46af1dbc43764905b;1,67,0;7;56;FLOAT3;0,0,0;False;55;FLOAT3;0,0,0;False;70;FLOAT3;0,0,0;False;45;FLOAT;0;False;148;FLOAT3;0,0,0;False;41;FLOAT;0;False;189;FLOAT;0;False;3;FLOAT3;4;FLOAT3;5;FLOAT3;3
Node;AmplifyShaderEditor.RangedFloatNode;212;1139.219,988.9824;Half;False;Property;_EMISSIONN;[ EMISSIONN ];17;0;Create;True;0;0;True;1;InternalCategory(Emission);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;125;-2016,559;Inherit;False;_SPECULAR;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;152;-2423.621,519.1543;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;124;-2556,645;Inherit;False;Property;_Specularity;Specularity;23;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;126;-3008,464;Inherit;False;77;UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;334;1699.482,1004.294;Inherit;False;Property;_AlphaToCoverage;Alpha To Coverage;4;1;[Toggle];Create;True;0;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;213;907.2191,881.9824;Half;False;Property;_SPECULARITYY;[ SPECULARITYY  ];21;0;Create;True;0;0;True;1;InternalCategory(Specularity);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;122;-2176,560;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;237;1113.229,1264.653;Half;False;Property;_TERRAINNBLEND;[ TERRAINN BLEND ];42;0;Create;True;0;0;True;1;InternalCategory(Terrain Blending);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;207;918.158,980.5149;Half;False;Property;_ALBEDOO;[ ALBEDOO ];7;0;Create;True;0;0;True;1;InternalCategory(Albedo);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;206;916.158,1076.515;Half;False;Property;_SURFACEE;[ SURFACEE ];24;0;Create;True;0;0;True;1;InternalCategory(Surface);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;128;-2816,432;Inherit;True;Property;_SpecGlossMap;Specularity Map;22;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;211;1095.977,1179.209;Half;False;Property;_NORMALL;[ NORMALL ];14;0;Create;True;0;0;True;1;InternalCategory(Normal);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;300;1127.791,894.5376;Half;False;Property;_RENDERINGG;[ RENDERINGG  ];1;0;Create;True;0;0;True;1;InternalCategory(Rendering);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;143;-2412,-856;Inherit;False;albedo_alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;333;1738.482,1103.294;Inherit;False;Property;_ZWriteMode;ZWrite Mode;5;1;[Toggle];Create;True;0;0;True;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;335;1447.482,1126.294;Inherit;False;Property;_MaskClipValue;Mask Clip Value;3;0;Create;True;0;0;True;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;226;928.7869,1259.44;Half;False;Property;_GROUNDINGG;[ GROUNDINGG ];103;0;Create;True;0;0;True;1;InternalCategory(Grounding);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;202;917.158,788.5157;Half;False;Property;_BANNER;BANNER;0;0;Create;True;0;0;True;1;InternalBanner(Internal,Standard);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;318;1472,-160;Inherit;False;Property;_Burnable7;Burnable;68;0;Create;True;0;0;True;0;0;0;1;True;;Toggle;2;Key0;Key1;Reference;276;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;272;1464.097,848.185;Inherit;False;Property;_CullMode;Cull Mode;2;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;0;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3635.977,-460.5901;Float;False;True;-1;5;AppalachiaShaderEditorGUI;0;0;CustomLighting;appalachia/standard;False;False;False;False;False;False;False;False;False;False;False;False;True;True;False;False;True;False;True;True;False;Back;1;True;333;3;True;336;False;0;False;-1;0;False;-1;False;3;Custom;0.5;True;True;0;True;Custom;InternalOpaque;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;False;False;_BILLBOARD_ON;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;272;-1;0;True;335;0;0;0;False;0.1;False;-1;0;True;334;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;14;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT3;0,0,0;False;0
WireConnection;77;0;76;0
WireConnection;34;1;81;0
WireConnection;42;0;34;1
WireConnection;192;0;34;4
WireConnection;162;0;34;4
WireConnection;340;0;42;0
WireConnection;340;1;341;0
WireConnection;340;2;339;0
WireConnection;59;0;34;2
WireConnection;313;0;34;3
WireConnection;161;0;192;0
WireConnection;161;1;162;0
WireConnection;2;1;77;0
WireConnection;74;0;75;0
WireConnection;74;1;59;0
WireConnection;74;2;47;0
WireConnection;56;0;161;0
WireConnection;56;1;57;0
WireConnection;12;0;340;0
WireConnection;12;1;31;0
WireConnection;311;0;314;0
WireConnection;311;1;313;0
WireConnection;311;2;310;0
WireConnection;22;0;2;0
WireConnection;22;1;21;0
WireConnection;58;0;56;0
WireConnection;257;89;22;0
WireConnection;257;86;195;0
WireConnection;257;87;194;0
WireConnection;257;88;196;0
WireConnection;257;115;197;0
WireConnection;3;1;78;0
WireConnection;3;5;24;0
WireConnection;312;0;311;0
WireConnection;48;0;74;0
WireConnection;33;0;12;0
WireConnection;23;0;257;37
WireConnection;25;0;3;0
WireConnection;240;0;86;0
WireConnection;240;1;88;0
WireConnection;240;2;315;0
WireConnection;240;3;87;0
WireConnection;271;14;26;0
WireConnection;271;15;27;0
WireConnection;271;16;240;0
WireConnection;239;1;88;0
WireConnection;239;0;271;8
WireConnection;236;1;26;0
WireConnection;236;0;271;0
WireConnection;262;12;239;0
WireConnection;262;26;236;0
WireConnection;4;1;79;0
WireConnection;267;0;262;0
WireConnection;267;1;270;0
WireConnection;6;0;4;0
WireConnection;6;1;5;0
WireConnection;6;2;32;0
WireConnection;268;0;267;0
WireConnection;20;0;6;0
WireConnection;316;1;315;0
WireConnection;316;0;271;9
WireConnection;241;1;87;0
WireConnection;241;0;271;10
WireConnection;269;1;262;0
WireConnection;269;0;268;0
WireConnection;243;1;27;0
WireConnection;243;0;271;6
WireConnection;238;1;86;0
WireConnection;238;0;271;7
WireConnection;294;0;269;0
WireConnection;293;0;241;0
WireConnection;291;0;262;31
WireConnection;295;0;262;31
WireConnection;242;1;28;0
WireConnection;242;0;28;0
WireConnection;290;0;243;0
WireConnection;292;0;238;0
WireConnection;317;0;316;0
WireConnection;285;0;241;0
WireConnection;289;0;243;0
WireConnection;288;0;295;0
WireConnection;305;138;291;0
WireConnection;305;131;290;0
WireConnection;305;168;292;0
WireConnection;305;132;294;0
WireConnection;305;145;317;0
WireConnection;305;134;293;0
WireConnection;305;162;242;0
WireConnection;305;118;297;0
WireConnection;287;0;238;0
WireConnection;277;1;289;0
WireConnection;277;0;305;150
WireConnection;276;1;288;0
WireConnection;276;0;305;169
WireConnection;298;0;297;0
WireConnection;281;1;285;0
WireConnection;281;0;305;147
WireConnection;296;0;269;0
WireConnection;278;1;287;0
WireConnection;278;0;305;167
WireConnection;284;0;242;0
WireConnection;286;0;296;0
WireConnection;330;14;298;0
WireConnection;330;18;324;0
WireConnection;330;19;323;0
WireConnection;330;21;277;0
WireConnection;330;11;276;0
WireConnection;330;13;278;0
WireConnection;330;12;281;0
WireConnection;330;17;319;0
WireConnection;308;1;281;0
WireConnection;308;0;330;10
WireConnection;279;1;286;0
WireConnection;279;0;305;149
WireConnection;282;1;284;0
WireConnection;282;0;305;0
WireConnection;307;1;276;0
WireConnection;307;0;330;9
WireConnection;225;0;329;0
WireConnection;188;56;307;0
WireConnection;188;55;277;0
WireConnection;188;70;282;0
WireConnection;188;45;278;0
WireConnection;188;41;308;0
WireConnection;188;189;279;0
WireConnection;125;0;122;0
WireConnection;152;0;128;0
WireConnection;122;0;152;0
WireConnection;122;1;124;0
WireConnection;128;1;126;0
WireConnection;143;0;2;4
WireConnection;318;1;316;0
WireConnection;318;0;305;148
WireConnection;0;0;188;4
WireConnection;0;2;188;5
WireConnection;0;14;188;3
WireConnection;0;11;225;0
ASEEND*/
//CHKSM=0DE90BC3BDA93E87E25CB620B5440105F9BB8E3D