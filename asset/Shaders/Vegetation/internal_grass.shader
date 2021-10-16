// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "internal/grass"
{
	Properties
	{
		[InternalBanner(Internal,Grass)]_BANNER("BANNER", Float) = 1
		[InternalCategory(Rendering)]_RENDERINGG("[ RENDERINGG ]", Float) = 0
		[Toggle(_BILLBOARD_ON)] _Billboard("Billboard", Float) = 0
		[Toggle]_ZWrite("Z Write", Range( 0 , 1)) = 0
		_Cutoff("Depth Cutoff", Range( 0 , 1)) = 0.5
		[InternalCategory(Cutoff)]_CUTOFFF("[ CUTOFFF ]", Float) = 0
		_CutoffLowNear("Cutoff Low (Near)", Range( 0 , 1)) = 0.7
		_CutoffHighNear("Cutoff High (Near)", Range( 0 , 1)) = 0.9
		_CutoffFar("Cutoff Far", Range( 6 , 64)) = 16
		_CutoffLowFar("Cutoff Low (Far)", Range( 0 , 1)) = 0.5
		_CutoffHighFar("Cutoff High (Far)", Range( 0 , 1)) = 0.7
		[InternalCategory(Color)]_COLORR("[ COLORR ]", Float) = 0
		[NoScaleOffset]_MainTex("Grass Albedo", 2D) = "white" {}
		_Color("Grass Color", Color) = (1,1,1,1)
		_Saturation("Saturation", Range( -1 , 1)) = 1
		_Brightness("Brightness", Range( -1 , 1)) = 1
		[Toggle]_ColorMap("Color Map", Float) = 0
		_Color_2("Grass Color 2", Color) = (1,1,1,1)
		[InternalCategory(Normal)]_NORMALL("[ NORMALL ]", Float) = 0
		[NoScaleOffset]_BumpMap("Grass Normal", 2D) = "bump" {}
		_NormalScale("Grass Normal Scale", Float) = 1
		[InternalCategory(Surface)]_SURFACEE("[ SURFACEE ]", Float) = 0
		[NoScaleOffset]_MetallicGlossMap("Grass Surface", 2D) = "white" {}
		_Smoothness("Grass Smoothness", Range( 0 , 1)) = 1
		_Occlusion("Grass Occlusion", Range( 0 , 1)) = 1
		[HideInInspector][InternalCategory(Base Darkening)]_BASEDARKENINGG("[ BASE DARKENINGG ]", Float) = 0
		_BaseDarkening("Base Darkening", Range( 0 , 1)) = 0
		_BaseDarkeningHeight("Base Darkening Height", Range( 0.0001 , 3)) = 1.5
		_BaseDarkeningFadeInStart("Base Darkening Fade In Start", Range( 0 , 64)) = 2
		_BaseDarkeningFadeInRange("Base Darkening Fade In Range", Range( 0 , 64)) = 16
		[InternalCategory(Occlusion)]_OCCLUSIONN("[ OCCLUSIONN ]", Float) = 0
		_Occlusion("Texture Occlusion", Range( 0 , 1)) = 0.5
		_VertexOcclusion("Vertex Occlusion", Range( 0 , 1)) = 0.5
		_AOProbeStrength("AO Probe Strength", Range( 0 , 1)) = 0.8
		_AOIndirect("AO Indirect", Range( 0 , 1)) = 1
		_AODirect("AO Direct", Range( 0 , 1)) = 0
		[InternalCategory(Transmission)]_TRANSMISSIONN("[ TRANSMISSIONN ]", Float) = 0
		_Transmission("Transmission Strength", Range( 0 , 10)) = 1
		_TransmissionAlbedoBlend("Transmission Albedo Blend", Range( 0 , 1)) = 0.5
		[HDR]_TransmissionColor("Transmission Color", Color) = (0.8069925,0.93,0.4677897,1)
		_TransmissionCutoff("Transmission Cutoff", Range( 0 , 0.25)) = 0.1
		_TransmissionFadeOffset("Transmission Fade Offset", Range( 12 , 512)) = 256
		_TransmissionFadeDistance("Transmission Fade Distance", Range( 12 , 512)) = 256
		_NighttimeTransmissionDamping("Nighttime Transmission Damping", Range( 0 , 1)) = 1
		_OcclusionTransmissionDampening("Occlusion Transmission Dampening", Range( 0 , 1)) = 1
		_OcclusionTransmissionLightingScale("Occlusion Transmission Lighting Scale", Range( 1 , 4)) = 2
		_TransmDirect("Direct Transmission", Range( 0 , 3)) = 1
		_TransmAmbient("Ambient Transmission", Range( 0 , 3)) = 0
		[InternalCategory(Translucency)]_TRANSLUCENCYY("[ TRANSLUCENCYY ]", Float) = 0
		_Translucency("Translucency Strength", Range( 0 , 50)) = 4
		_TranslucencyAlbedoBlend("Translucency Albedo Blend", Range( 0 , 1)) = 0.5
		[HDR]_TranslucencyColor("Translucency Color", Color) = (0.8566224,0.887,0.2581168,1)
		_TranslucencyCutoff("Translucency Cutoff", Range( 0 , 0.25)) = 0.1
		_TranslucencyFadeOffset("Translucency Fade Offset", Range( 12 , 512)) = 256
		_TranslucencyFadeDistance("Translucency Fade Distance", Range( 5 , 512)) = 256
		_NighttimeTranslucencyDamping("Nighttime Translucency Damping", Range( 0 , 1)) = 1
		_OcclusionTransmissionLightingScale1("Occlusion Transmission Lighting Scale", Range( 1 , 4)) = 2
		_OcclusionTranslucencyDamping("Occlusion Translucency Damping", Range( 0 , 1)) = 1
		_TransNormalDistortion("Translucency Normal Distortion", Range( 0 , 1)) = 0.05
		_TransScattering("Translucency Scattering Falloff", Range( 1 , 50)) = 1
		_TransDirect("Direct Translucency", Range( 0 , 3)) = 1
		_TransAmbient("Ambient Translucency", Range( 0 , 3)) = 0
		_TransShadow("Translucency Shadow", Range( 0 , 1)) = 0.8
		[InternalCategory(Transmittance)]_TRANSMITTANCEE("[ TRANSMITTANCEE ]", Float) = 0
		_TransmittanceScaling("Transmittance Scaling", Range( 0 , 2)) = 1
		_TransmittanceLimit("Transmittance Limit", Range( 0 , 10)) = 5
		[InternalCategory(Wind)]_WINDD("[ WINDD ]", Float) = 0
		[Toggle(_WINDENABLED_ON)] _WindEnabled("Wind Enabled", Float) = 1
		[Toggle(_HEIGHTBASEDWIND_ON)] _HeightBasedWind("Height Based Wind", Float) = 0
		_HeightWindStrength("Height Wind Strength", Range( 0 , 3)) = 0.5
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
		Tags{ "RenderType" = "InternalGrass"  "Queue" = "AlphaTest+0" "DisableBatching" = "True" "IsEmissive" = "true"  }
		LOD 300
		Cull Off
		ZWrite [_ZWrite]
		ZTest LEqual
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 4.0
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#pragma shader_feature_local _BILLBOARD_ON
		#pragma shader_feature_local _HEIGHTBASEDWIND_ON
		#pragma shader_feature_local _WINDENABLED_ON
		 
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
			float3 worldPos;
			float2 uv_texcoord;
			float3 uv_tex3coord;
			float4 screenPosition;
			float3 worldNormal;
			INTERNAL_DATA
			half ASEVFace : VFACE;
			float eyeDepth;
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

		uniform half _BASEDARKENINGG;
		uniform half _TRANSMISSIONN;
		uniform half _OCCLUSIONN;
		uniform half _TRANSLUCENCYY;
		uniform half _TRANSMITTANCEE;
		uniform half _GLOBALILLUMINATIONN;
		uniform half _BANNER;
		uniform half _Cutoff;
		uniform half _NORMALL;
		uniform half _CUTOFFF;
		uniform half _SURFACEE;
		uniform half _WINDD;
		uniform half _COLORR;
		uniform float _ZWrite;
		uniform half _RENDERINGG;
		uniform sampler2D _TOUCHBEND_CURRENT_STATE_MAP_MASK;
		uniform float4 _TOUCHBEND_CURRENT_STATE_MAP_MIN_XZ;
		uniform sampler2D _TOUCHBEND_CURRENT_STATE_MAP_SPATIAL;
		uniform float _HeightWindStrength;
		uniform half _WIND_GRASS_STRENGTH;
		uniform half _WIND_BASE_GRASS_FIELD_SIZE;
		uniform half _WIND_BASE_GRASS_CYCLE_TIME;
		uniform half _WIND_BASE_GRASS_STRENGTH;
		uniform half _WIND_BASE_AMPLITUDE;
		uniform half _WIND_GUST_AMPLITUDE;
		uniform half _WIND_GUST_AUDIO_STRENGTH;
		uniform half _WIND_AUDIO_INFLUENCE;
		uniform half _WIND_GUST_AUDIO_STRENGTH_VERYHIGH;
		uniform half _WIND_GUST_GRASS_MICRO_STRENGTH;
		uniform half _WIND_GUST_GRASS_MICRO_CYCLE_TIME;
		uniform half _WIND_GUST_GRASS_MICRO_FIELD_SIZE;
		uniform half _WIND_GUST_GRASS_STRENGTH;
		uniform half _WIND_GUST_AUDIO_STRENGTH_HIGH;
		uniform sampler2D _WIND_GUST_TEXTURE;
		uniform half _WIND_GUST_GRASS_CYCLE_TIME;
		uniform half _WIND_GUST_GRASS_FIELD_SIZE;
		uniform half3 _WIND_DIRECTION;
		uniform half _WIND_GUST_GRASS_MID_STRENGTH;
		uniform half _WIND_GUST_GRASS_MID_CYCLE_TIME;
		uniform half _WIND_GUST_GRASS_MID_FIELD_SIZE;
		uniform sampler2D _TOUCHBEND_CURRENT_STATE_MAP_MOTION;
		uniform float _GlobalIlluminationAlbedoEffect;
		uniform sampler2D _MetallicGlossMap;
		uniform float _BaseDarkeningHeight;
		uniform half _BaseDarkening;
		uniform half _BaseDarkeningFadeInStart;
		uniform half _BaseDarkeningFadeInRange;
		uniform half _Occlusion;
		uniform half _VertexOcclusion;
		uniform float4x4 _OcclusionProbesWorldToLocal;
		uniform sampler3D _OcclusionProbes;
		uniform float4 _OcclusionProbes_ST;
		uniform float _AOProbeStrength;
		uniform float _OCCLUSION_PROBE_GLOBAL;
		uniform float _AOIndirect;
		uniform float _AODirect;
		uniform float _ColorMap;
		uniform sampler2D _MainTex;
		uniform half4 _Color;
		uniform half4 _Color_2;
		uniform float _Saturation;
		uniform float _Brightness;
		uniform float _GlobalIlluminationEmissiveEffect;
		uniform half _CutoffLowFar;
		uniform half _CutoffLowNear;
		uniform half _CutoffFar;
		uniform half _CutoffHighFar;
		uniform half _CutoffHighNear;
		uniform half _NormalScale;
		uniform sampler2D _BumpMap;
		uniform half _Smoothness;
		uniform half _OcclusionTransmissionLightingScale;
		uniform half _OcclusionTransmissionDampening;
		uniform float _GLOBAL_SOLAR_TIME;
		uniform half _NighttimeTransmissionDamping;
		uniform float _TransmDirect;
		uniform float _TransmAmbient;
		uniform float _Transmission;
		uniform float _TransmissionFadeDistance;
		uniform float _TransmissionFadeOffset;
		uniform half _TransmissionCutoff;
		uniform half4 _TransmissionColor;
		uniform half _TransmissionAlbedoBlend;
		uniform float _Translucency;
		uniform half _TranslucencyFadeOffset;
		uniform half _TranslucencyFadeDistance;
		uniform half _OcclusionTransmissionLightingScale1;
		uniform half _OcclusionTranslucencyDamping;
		uniform float _TransNormalDistortion;
		uniform float _TransScattering;
		uniform float _TransDirect;
		uniform float _TransAmbient;
		uniform float _TransShadow;
		uniform half _TranslucencyCutoff;
		uniform half4 _TranslucencyColor;
		uniform half _TranslucencyAlbedoBlend;
		uniform half _NighttimeTranslucencyDamping;
		uniform float _TransmittanceScaling;
		uniform float _TransmittanceLimit;


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

		inline float Dither8x8Bayer( int x, int y )
		{
			const float dither[ 64 ] = {
				 1, 49, 13, 61,  4, 52, 16, 64,
				33, 17, 45, 29, 36, 20, 48, 32,
				 9, 57,  5, 53, 12, 60,  8, 56,
				41, 25, 37, 21, 44, 28, 40, 24,
				 3, 51, 15, 63,  2, 50, 14, 62,
				35, 19, 47, 31, 34, 18, 46, 30,
				11, 59,  7, 55, 10, 58,  6, 54,
				43, 27, 39, 23, 42, 26, 38, 22};
			int r = y * 8 + x;
			return dither[r] / 64; // same # of instructions as pre-dividing due to compiler magic
		}


		float ExecuteClip( float opacity , float cutoff )
		{
			clip( opacity - cutoff );
			return 1.0;
		}


		float3 IndirectLightDir( UnityGI gi )
		{
			return gi.light.dir;
		}


		float3 IndirectLightColor( UnityGI gi )
		{
			return gi.light.color;
		}


		float3 GetGILightColor( UnityGI gi )
		{
			return gi.light.color;
		}


		float3 GetPrimaryLightColor(  )
		{
			return  _LightColor0.rgb;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
#ifdef _BILLBOARD_ON
			//Calculate new billboard vertex position and normal;
			float3 upCamVec = float3( 0, 1, 0 );
			float3 forwardCamVec = -normalize ( UNITY_MATRIX_V._m20_m21_m22 );
			float3 rightCamVec = normalize( UNITY_MATRIX_V._m00_m01_m02 );
			float4x4 rotationCamMatrix = float4x4( rightCamVec, 0, upCamVec, 0, forwardCamVec, 0, 0, 0, 0, 1 );
			v.normal = normalize( mul( float4( v.normal , 0 ), rotationCamMatrix )).xyz;
			v.vertex.x *= length( unity_ObjectToWorld._m00_m10_m20 );
			v.vertex.y *= length( unity_ObjectToWorld._m01_m11_m21 );
			v.vertex.z *= length( unity_ObjectToWorld._m02_m12_m22 );
			v.vertex = mul( v.vertex, rotationCamMatrix );
			v.vertex.xyz += unity_ObjectToWorld._m03_m13_m23;
			//Need to nullify rotation inserted by generated surface shader;
			v.vertex = mul( unity_WorldToObject, v.vertex );
#endif
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 break602_g27268 = ase_worldPos;
			float worldPos_X_vertex604_g27268 = break602_g27268.x;
			float temp_output_16_0_g27268 = ( ( worldPos_X_vertex604_g27268 - _TOUCHBEND_CURRENT_STATE_MAP_MIN_XZ.x ) / _TOUCHBEND_CURRENT_STATE_MAP_MIN_XZ.w );
			float worldPos_Z_vertex606_g27268 = break602_g27268.z;
			float temp_output_187_0_g27268 = ( ( -worldPos_Z_vertex606_g27268 - _TOUCHBEND_CURRENT_STATE_MAP_MIN_XZ.z ) / _TOUCHBEND_CURRENT_STATE_MAP_MIN_XZ.w );
			float2 appendResult188_g27268 = (float2(( 1.0 - saturate( temp_output_16_0_g27268 ) ) , ( 1.0 - saturate( temp_output_187_0_g27268 ) )));
			float2 tbPos_vertex98_g27268 = appendResult188_g27268;
			float4 tex2DNode518_g27268 = tex2Dlod( _TOUCHBEND_CURRENT_STATE_MAP_MASK, float4( tbPos_vertex98_g27268, 0, 0.0) );
			float mask_r650_g27268 = tex2DNode518_g27268.r;
			float temp_output_270_0_g27268 = 1E-06;
			float temp_output_269_0_g27268 = 0.999999;
			float temp_output_272_0_g27268 = 1.0;
			float temp_output_273_0_g27268 = 0.0;
			float IN_BEND_RADIUS96_g27268 = saturate( ( (( temp_output_16_0_g27268 >= temp_output_270_0_g27268 && temp_output_16_0_g27268 <= temp_output_269_0_g27268 ) ? temp_output_272_0_g27268 :  temp_output_273_0_g27268 ) * (( temp_output_187_0_g27268 >= temp_output_270_0_g27268 && temp_output_187_0_g27268 <= temp_output_269_0_g27268 ) ? temp_output_272_0_g27268 :  temp_output_273_0_g27268 ) ) );
			float worldPos_Y_vertex605_g27268 = break602_g27268.y;
			float4 tex2DNode18_g27268 = tex2Dlod( _TOUCHBEND_CURRENT_STATE_MAP_SPATIAL, float4( tbPos_vertex98_g27268, 0, 0.0) );
			float4 _Vector0 = float4(0,0,0,0);
			float4 _Vector1 = float4(1,1,1,1);
			float4 _UP_LOW = float4(0,0,0,0);
			float height_eligible586_g27268 = saturate( ( worldPos_Y_vertex605_g27268 - ( ((_UP_LOW).x + (tex2DNode18_g27268.g - _Vector0.x) * (1024.0 - (_UP_LOW).x) / (_Vector1.x - _Vector0.x)) - 0.5 ) ) );
			float temp_output_426_0_g27268 = ( ( 1.0 - step( mask_r650_g27268 , 0.0 ) ) * IN_BEND_RADIUS96_g27268 * height_eligible586_g27268 );
			float displacement_amount599_g27268 = saturate( ( mask_r650_g27268 * temp_output_426_0_g27268 ) );
			float3 temp_output_815_481_g27265 = displacement_amount599_g27268;
			#ifdef _HEIGHTBASEDWIND_ON
				float staticSwitch2605 = ( ase_worldPos.y * _HeightWindStrength );
			#else
				float staticSwitch2605 = v.color.r;
			#endif
			float _GRASS_BEND_AVAILABILITY385_g27265 = saturate( staticSwitch2605 );
			float3 touchbend_amount614_g27265 = ( temp_output_815_481_g27265 * _GRASS_BEND_AVAILABILITY385_g27265 );
			float temp_output_54_0_g27266 = ( touchbend_amount614_g27265 * -2.0 ).x;
			float temp_output_72_0_g27266 = cos( temp_output_54_0_g27266 );
			float one_minus_c52_g27266 = ( 1.0 - temp_output_72_0_g27266 );
			float3 worldToObjDir680_g27265 = mul( unity_WorldToObject, float4( float3(0,1,0), 0 ) ).xyz;
			float3 appendResult366_g27268 = (float3(( 1.0 - tex2DNode18_g27268.r ) , 0.5 , ( 1.0 - tex2DNode18_g27268.b )));
			float3 temp_output_362_0_g27268 = (appendResult366_g27268*2.0 + -1.0);
			float3 worldToObjDir455_g27268 = normalize( mul( unity_WorldToObject, float4( temp_output_362_0_g27268, 0 ) ).xyz );
			float3 break445_g27265 = worldToObjDir455_g27268;
			float3 appendResult469_g27265 = (float3(break445_g27265.x , break445_g27265.y , break445_g27265.z));
			float3 break70_g27266 = cross( worldToObjDir680_g27265 , appendResult469_g27265 );
			float axis_x25_g27266 = break70_g27266.x;
			float c66_g27266 = temp_output_72_0_g27266;
			float axis_y37_g27266 = break70_g27266.y;
			float axis_z29_g27266 = break70_g27266.z;
			float s67_g27266 = sin( temp_output_54_0_g27266 );
			float3 appendResult83_g27266 = (float3(( ( one_minus_c52_g27266 * axis_x25_g27266 * axis_x25_g27266 ) + c66_g27266 ) , ( ( one_minus_c52_g27266 * axis_x25_g27266 * axis_y37_g27266 ) - ( axis_z29_g27266 * s67_g27266 ) ) , ( ( one_minus_c52_g27266 * axis_z29_g27266 * axis_x25_g27266 ) + ( axis_y37_g27266 * s67_g27266 ) )));
			float3 appendResult81_g27266 = (float3(( ( one_minus_c52_g27266 * axis_x25_g27266 * axis_y37_g27266 ) + ( axis_z29_g27266 * s67_g27266 ) ) , ( ( one_minus_c52_g27266 * axis_y37_g27266 * axis_y37_g27266 ) + c66_g27266 ) , ( ( one_minus_c52_g27266 * axis_y37_g27266 * axis_z29_g27266 ) - ( axis_x25_g27266 * s67_g27266 ) )));
			float3 appendResult82_g27266 = (float3(( ( one_minus_c52_g27266 * axis_z29_g27266 * axis_x25_g27266 ) - ( axis_y37_g27266 * s67_g27266 ) ) , ( ( one_minus_c52_g27266 * axis_y37_g27266 * axis_z29_g27266 ) + ( axis_x25_g27266 * s67_g27266 ) ) , ( ( one_minus_c52_g27266 * axis_z29_g27266 * axis_z29_g27266 ) + c66_g27266 )));
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 appendResult2162 = (float3(-v.texcoord1.xy.x , 0.0 , v.texcoord1.xy.y));
			float3 pivot_object_space717_g27265 = appendResult2162;
			float3 temp_output_38_0_g27266 = ( ase_vertex3Pos - (pivot_object_space717_g27265).xyz );
			float3 temp_output_677_84_g27265 = ( mul( float3x3(appendResult83_g27266, appendResult81_g27266, appendResult82_g27266), temp_output_38_0_g27266 ) - temp_output_38_0_g27266 );
			float3 pos130_g27265 = ase_vertex3Pos;
			float3 appendResult534_g27265 = (float3(0.0 , -pos130_g27265.y , 0.0));
			float3 lerpResult692_g27265 = lerp( temp_output_677_84_g27265 , ( temp_output_677_84_g27265 + ( appendResult534_g27265 * touchbend_amount614_g27265 ) ) , touchbend_amount614_g27265);
			float GRASS_STRENGTH1499_g27193 = _WIND_GRASS_STRENGTH;
			float _WIND_PRIMARY_ROLL669_g27220 = staticSwitch2605;
			half localunity_ObjectToWorld0w1_g27196 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g27196 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g27196 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g27196 = (float3(localunity_ObjectToWorld0w1_g27196 , localunity_ObjectToWorld1w2_g27196 , localunity_ObjectToWorld2w3_g27196));
			float2 UV_POSITION_OBJECT1504_g27193 = (appendResult6_g27196).xz;
			float BASE_FIELD_SIZE1503_g27193 = _WIND_BASE_GRASS_FIELD_SIZE;
			float BASE_FREQUENCY1498_g27193 = ( 1.0 / (( _WIND_BASE_GRASS_CYCLE_TIME == 0.0 ) ? 1.0 :  _WIND_BASE_GRASS_CYCLE_TIME ) );
			float2 break298_g27221 = ( ( UV_POSITION_OBJECT1504_g27193 * BASE_FIELD_SIZE1503_g27193 ) + ( BASE_FREQUENCY1498_g27193 * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g27221 = (float2(sin( break298_g27221.x ) , cos( break298_g27221.y )));
			float4 temp_output_273_0_g27221 = (-1.0).xxxx;
			float4 temp_output_271_0_g27221 = (1.0).xxxx;
			float2 clampResult26_g27221 = clamp( appendResult299_g27221 , temp_output_273_0_g27221.xy , temp_output_271_0_g27221.xy );
			float BASE_GRASS_STRENGTH1628_g27193 = _WIND_BASE_GRASS_STRENGTH;
			float BASE_AMPLITUDE1549_g27193 = _WIND_BASE_AMPLITUDE;
			float2 break699_g27220 = ( clampResult26_g27221 * ( BASE_GRASS_STRENGTH1628_g27193 * BASE_AMPLITUDE1549_g27193 ) );
			float3 appendResult698_g27220 = (float3(break699_g27220.x , 0.0 , break699_g27220.y));
			float3 temp_output_684_0_g27220 = ( _WIND_PRIMARY_ROLL669_g27220 * (appendResult698_g27220).xyz );
			float3 ase_vertexNormal = v.normal.xyz;
			float3 _VERTEX_NORMAL918_g27220 = ase_vertexNormal;
			float lerpResult632_g27218 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH , _WIND_AUDIO_INFLUENCE);
			float AUDIO_BLEND1671_g27193 = lerpResult632_g27218;
			float temp_output_15_0_g27219 = AUDIO_BLEND1671_g27193;
			float lerpResult638_g27218 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_VERYHIGH , _WIND_AUDIO_INFLUENCE);
			float AUDIO_VERYHIGH1639_g27193 = lerpResult638_g27218;
			float temp_output_16_0_g27219 = AUDIO_VERYHIGH1639_g27193;
			float GUST_MICRO_STRENGTH1513_g27193 = _WIND_GUST_GRASS_MICRO_STRENGTH;
			float4 color658_g27198 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float GUST_MICRO_CYCLE_TIME1514_g27193 = _WIND_GUST_GRASS_MICRO_CYCLE_TIME;
			float2 temp_cast_5 = (( 1.0 / (( GUST_MICRO_CYCLE_TIME1514_g27193 == 0.0 ) ? 1.0 :  GUST_MICRO_CYCLE_TIME1514_g27193 ) )).xx;
			float2 temp_output_61_0_g27202 = float2( 0,0 );
			half localunity_ObjectToWorld0w1_g27212 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g27212 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g27212 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g27212 = (float3(localunity_ObjectToWorld0w1_g27212 , localunity_ObjectToWorld1w2_g27212 , localunity_ObjectToWorld2w3_g27212));
			float3 appendResult1493_g27193 = (float3(-v.texcoord1.xy.x , 0.0 , v.texcoord1.xy.y));
			float3 PLANE_PIVOT1494_g27193 = appendResult1493_g27193;
			float2 appendResult1587_g27193 = (float2(ase_vertex3Pos.x , ase_vertex3Pos.x));
			float2 temp_output_1_0_g27203 = ( (appendResult6_g27212).xz + (PLANE_PIVOT1494_g27193).xz + appendResult1587_g27193 );
			float GUST_MICRO_FIELD_SIZE1515_g27193 = _WIND_GUST_GRASS_MICRO_FIELD_SIZE;
			float temp_output_40_0_g27202 = ( 1.0 / (( GUST_MICRO_FIELD_SIZE1515_g27193 == 0.0 ) ? 1.0 :  GUST_MICRO_FIELD_SIZE1515_g27193 ) );
			float2 temp_cast_6 = (temp_output_40_0_g27202).xx;
			float2 temp_output_2_0_g27203 = temp_cast_6;
			float2 temp_output_3_0_g27203 = temp_output_61_0_g27202;
			float2 panner90_g27202 = ( _Time.y * temp_cast_5 + ( (( temp_output_61_0_g27202 > float2( 0,0 ) ) ? ( temp_output_1_0_g27203 / temp_output_2_0_g27203 ) :  ( temp_output_1_0_g27203 * temp_output_2_0_g27203 ) ) + temp_output_3_0_g27203 ));
			float temp_output_679_0_g27198 = 1.0;
			float4 temp_cast_7 = (temp_output_679_0_g27198).xxxx;
			float4 temp_output_52_0_g27202 = saturate( pow( tex2Dlod( _WIND_GUST_TEXTURE, float4( panner90_g27202, 0, 0.0) ) , temp_cast_7 ) );
			float4 lerpResult656_g27198 = lerp( color658_g27198 , temp_output_52_0_g27202 , temp_output_679_0_g27198);
			float4 break655_g27198 = lerpResult656_g27198;
			float clampResult3_g27232 = clamp( ( 1.0 - break655_g27198.r ) , 0.0 , 1.0 );
			float GUST_MICRO1651_g27193 = ( ( ( temp_output_15_0_g27219 + temp_output_16_0_g27219 ) / 2.0 ) * GUST_MICRO_STRENGTH1513_g27193 * ( ( clampResult3_g27232 * 2.0 ) - 1.0 ) );
			float _GUST_STRENGTH_MICRO769_g27220 = GUST_MICRO1651_g27193;
			float3 GUST_MICRO816_g27220 = ( _VERTEX_NORMAL918_g27220 * _WIND_PRIMARY_ROLL669_g27220 * _GUST_STRENGTH_MICRO769_g27220 );
			float GUST_STRENGTH1624_g27193 = _WIND_GUST_GRASS_STRENGTH;
			float lerpResult633_g27218 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_HIGH , _WIND_AUDIO_INFLUENCE);
			float AUDIO_HIGH1640_g27193 = lerpResult633_g27218;
			float4 color658_g27206 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float2 appendResult1567_g27193 = (float2(-v.texcoord1.xy.x , v.texcoord1.xy.x));
			float2 UV_PLANE1566_g27193 = appendResult1567_g27193;
			float clampResult3_g27204 = clamp( (UV_PLANE1566_g27193).x , 0.0 , 1.0 );
			float GUST_CYCLE_TIME1511_g27193 = _WIND_GUST_GRASS_CYCLE_TIME;
			float2 temp_cast_8 = (( 1.0 / (( ( ( ( ( clampResult3_g27204 * 2.0 ) - 1.0 ) * 0.15 * GUST_CYCLE_TIME1511_g27193 ) + GUST_CYCLE_TIME1511_g27193 ) == 0.0 ) ? 1.0 :  ( ( ( ( clampResult3_g27204 * 2.0 ) - 1.0 ) * 0.15 * GUST_CYCLE_TIME1511_g27193 ) + GUST_CYCLE_TIME1511_g27193 ) ) )).xx;
			float2 temp_output_61_0_g27210 = float2( 0,0 );
			half localunity_ObjectToWorld0w1_g27194 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld2w3_g27194 = ( unity_ObjectToWorld[2].w );
			float2 appendResult1608_g27193 = (float2(localunity_ObjectToWorld0w1_g27194 , localunity_ObjectToWorld2w3_g27194));
			float2 temp_output_1_0_g27211 = ( ( 10.0 * UV_PLANE1566_g27193 ) + appendResult1608_g27193 );
			float GUST_FIELD_SIZE1512_g27193 = _WIND_GUST_GRASS_FIELD_SIZE;
			float temp_output_40_0_g27210 = ( 1.0 / (( GUST_FIELD_SIZE1512_g27193 == 0.0 ) ? 1.0 :  GUST_FIELD_SIZE1512_g27193 ) );
			float2 temp_cast_9 = (temp_output_40_0_g27210).xx;
			float2 temp_output_2_0_g27211 = temp_cast_9;
			float2 temp_output_3_0_g27211 = temp_output_61_0_g27210;
			float2 panner90_g27210 = ( _Time.y * temp_cast_8 + ( (( temp_output_61_0_g27210 > float2( 0,0 ) ) ? ( temp_output_1_0_g27211 / temp_output_2_0_g27211 ) :  ( temp_output_1_0_g27211 * temp_output_2_0_g27211 ) ) + temp_output_3_0_g27211 ));
			float temp_output_679_0_g27206 = 1.0;
			float4 temp_cast_10 = (temp_output_679_0_g27206).xxxx;
			float4 temp_output_52_0_g27210 = saturate( pow( tex2Dlod( _WIND_GUST_TEXTURE, float4( panner90_g27210, 0, 0.0) ) , temp_cast_10 ) );
			float4 lerpResult656_g27206 = lerp( color658_g27206 , temp_output_52_0_g27210 , temp_output_679_0_g27206);
			float4 break655_g27206 = lerpResult656_g27206;
			float GUST1666_g27193 = ( GUST_STRENGTH1624_g27193 * AUDIO_HIGH1640_g27193 * break655_g27206.b );
			float _GUST_STRENGTH845_g27220 = GUST1666_g27193;
			float temp_output_54_0_g27225 = _GUST_STRENGTH845_g27220;
			float temp_output_72_0_g27225 = cos( temp_output_54_0_g27225 );
			float one_minus_c52_g27225 = ( 1.0 - temp_output_72_0_g27225 );
			float3 WIND_DIRECTION1507_g27193 = _WIND_DIRECTION;
			float3 _WIND_DIRECTION671_g27220 = WIND_DIRECTION1507_g27193;
			float3 worldToObjDir963_g27220 = normalize( mul( unity_WorldToObject, float4( cross( -_WIND_DIRECTION671_g27220 , float3(0,1,0) ), 0 ) ).xyz );
			float3 break70_g27225 = worldToObjDir963_g27220;
			float axis_x25_g27225 = break70_g27225.x;
			float c66_g27225 = temp_output_72_0_g27225;
			float axis_y37_g27225 = break70_g27225.y;
			float axis_z29_g27225 = break70_g27225.z;
			float s67_g27225 = sin( temp_output_54_0_g27225 );
			float3 appendResult83_g27225 = (float3(( ( one_minus_c52_g27225 * axis_x25_g27225 * axis_x25_g27225 ) + c66_g27225 ) , ( ( one_minus_c52_g27225 * axis_x25_g27225 * axis_y37_g27225 ) - ( axis_z29_g27225 * s67_g27225 ) ) , ( ( one_minus_c52_g27225 * axis_z29_g27225 * axis_x25_g27225 ) + ( axis_y37_g27225 * s67_g27225 ) )));
			float3 appendResult81_g27225 = (float3(( ( one_minus_c52_g27225 * axis_x25_g27225 * axis_y37_g27225 ) + ( axis_z29_g27225 * s67_g27225 ) ) , ( ( one_minus_c52_g27225 * axis_y37_g27225 * axis_y37_g27225 ) + c66_g27225 ) , ( ( one_minus_c52_g27225 * axis_y37_g27225 * axis_z29_g27225 ) - ( axis_x25_g27225 * s67_g27225 ) )));
			float3 appendResult82_g27225 = (float3(( ( one_minus_c52_g27225 * axis_z29_g27225 * axis_x25_g27225 ) - ( axis_y37_g27225 * s67_g27225 ) ) , ( ( one_minus_c52_g27225 * axis_y37_g27225 * axis_z29_g27225 ) + ( axis_x25_g27225 * s67_g27225 ) ) , ( ( one_minus_c52_g27225 * axis_z29_g27225 * axis_z29_g27225 ) + c66_g27225 )));
			float3 appendResult962_g27220 = (float3(ase_vertex3Pos.x , 0.0 , ase_vertex3Pos.z));
			float3 temp_output_38_0_g27225 = ( ase_vertex3Pos - (appendResult962_g27220).xyz );
			float3 GUST798_g27220 = ( _WIND_PRIMARY_ROLL669_g27220 * ( mul( float3x3(appendResult83_g27225, appendResult81_g27225, appendResult82_g27225), temp_output_38_0_g27225 ) - temp_output_38_0_g27225 ) );
			float3 worldToObjDir921_g27220 = mul( unity_WorldToObject, float4( _WIND_DIRECTION671_g27220, 0 ) ).xyz;
			float GUST_MID_STRENGTH1625_g27193 = _WIND_GUST_GRASS_MID_STRENGTH;
			float temp_output_15_0_g27234 = AUDIO_VERYHIGH1639_g27193;
			float temp_output_16_0_g27234 = AUDIO_HIGH1640_g27193;
			float4 color658_g27226 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float GUST_MID_CYCLE_TIME1626_g27193 = _WIND_GUST_GRASS_MID_CYCLE_TIME;
			float2 temp_cast_11 = (( 1.0 / (( GUST_MID_CYCLE_TIME1626_g27193 == 0.0 ) ? 1.0 :  GUST_MID_CYCLE_TIME1626_g27193 ) )).xx;
			float2 temp_output_61_0_g27230 = float2( 0,0 );
			half localunity_ObjectToWorld0w1_g27197 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g27197 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g27197 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g27197 = (float3(localunity_ObjectToWorld0w1_g27197 , localunity_ObjectToWorld1w2_g27197 , localunity_ObjectToWorld2w3_g27197));
			float2 appendResult1723_g27193 = (float2(ase_vertex3Pos.y , ase_vertex3Pos.y));
			float2 temp_output_1_0_g27231 = ( (appendResult6_g27197).xz + (PLANE_PIVOT1494_g27193).xz + appendResult1723_g27193 );
			float GUST_MID_FIELD_SIZE1627_g27193 = _WIND_GUST_GRASS_MID_FIELD_SIZE;
			float temp_output_40_0_g27230 = ( 1.0 / (( GUST_MID_FIELD_SIZE1627_g27193 == 0.0 ) ? 1.0 :  GUST_MID_FIELD_SIZE1627_g27193 ) );
			float2 temp_cast_12 = (temp_output_40_0_g27230).xx;
			float2 temp_output_2_0_g27231 = temp_cast_12;
			float2 temp_output_3_0_g27231 = temp_output_61_0_g27230;
			float2 panner90_g27230 = ( _Time.y * temp_cast_11 + ( (( temp_output_61_0_g27230 > float2( 0,0 ) ) ? ( temp_output_1_0_g27231 / temp_output_2_0_g27231 ) :  ( temp_output_1_0_g27231 * temp_output_2_0_g27231 ) ) + temp_output_3_0_g27231 ));
			float temp_output_679_0_g27226 = 1.0;
			float4 temp_cast_13 = (temp_output_679_0_g27226).xxxx;
			float4 temp_output_52_0_g27230 = saturate( pow( tex2Dlod( _WIND_GUST_TEXTURE, float4( panner90_g27230, 0, 0.0) ) , temp_cast_13 ) );
			float4 lerpResult656_g27226 = lerp( color658_g27226 , temp_output_52_0_g27230 , temp_output_679_0_g27226);
			float4 break655_g27226 = lerpResult656_g27226;
			float GUST_MID1664_g27193 = ( GUST_MID_STRENGTH1625_g27193 * ( ( temp_output_15_0_g27234 + temp_output_16_0_g27234 ) / 2.0 ) * ( 1.0 - break655_g27226.r ) );
			float _GUST_STRENGTH_MID842_g27220 = GUST_MID1664_g27193;
			float3 GUST_MID926_g27220 = ( _WIND_PRIMARY_ROLL669_g27220 * ( worldToObjDir921_g27220 * _GUST_STRENGTH_MID842_g27220 ) );
			float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
			float3 _vec_min_old = float3(1,1,1);
			float3 _vec_max_old = float3(7,7,7);
			float3 clampResult934_g27220 = clamp( ase_objectScale , _vec_min_old , _vec_max_old );
			float3 lerpResult538_g27220 = lerp( temp_output_684_0_g27220 , ( temp_output_684_0_g27220 + ( GUST_MICRO816_g27220 + ( ( GUST798_g27220 + GUST_MID926_g27220 ) * (float3(1,1,1) + (clampResult934_g27220 - _vec_min_old) * (float3(3,3,3) - float3(1,1,1)) / (_vec_max_old - _vec_min_old)) ) ) ) , AUDIO_BLEND1671_g27193);
			#ifdef _WINDENABLED_ON
				float3 staticSwitch2625 = ( GRASS_STRENGTH1499_g27193 * lerpResult538_g27220 );
			#else
				float3 staticSwitch2625 = float3(0,0,0);
			#endif
			float3 UPDATED_OFFSET611_g27265 = ( ( 1.0 - touchbend_amount614_g27265 ) * staticSwitch2625 );
			half localunity_ObjectToWorld0w1_g27267 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g27267 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g27267 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g27267 = (float3(localunity_ObjectToWorld0w1_g27267 , localunity_ObjectToWorld1w2_g27267 , localunity_ObjectToWorld2w3_g27267));
			float3 obj_pos_world743_g27265 = appendResult6_g27267;
			float3 break298_g27292 = ( ( ( (obj_pos_world743_g27265).xyz * float3(97.125,91.88,82.1018) ) + (pivot_object_space717_g27265).xyz ) + ( float3(1.8,3.17,2.775) * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g27292 = (float2(sin( break298_g27292.x ) , cos( break298_g27292.y )));
			float4 temp_output_273_0_g27292 = (-1.0).xxxx;
			float4 temp_output_271_0_g27292 = (1.0).xxxx;
			float2 clampResult26_g27292 = clamp( appendResult299_g27292 , temp_output_273_0_g27292.xy , temp_output_271_0_g27292.xy );
			float4 tex2DNode625_g27268 = tex2Dlod( _TOUCHBEND_CURRENT_STATE_MAP_MOTION, float4( tbPos_vertex98_g27268, 0, 0.0) );
			float motion_g655_g27268 = tex2DNode625_g27268.g;
			float temp_output_684_29_g27268 = ((_UP_LOW).x + (motion_g655_g27268 - _Vector0.x) * (8.0 - (_UP_LOW).x) / (_Vector1.x - _Vector0.x));
			float motion_r654_g27268 = tex2DNode625_g27268.r;
			float2 break11_g27270 = tbPos_vertex98_g27268;
			float clampResult3_g27271 = clamp( break11_g27270.x , 0.0 , 1.0 );
			float clampResult3_g27273 = clamp( break11_g27270.y , 0.0 , 1.0 );
			float lerpResult8_g27270 = lerp( 1.0 , 4.0 , max( abs( ( ( clampResult3_g27271 * 2.0 ) - 1.0 ) ) , abs( ( ( clampResult3_g27273 * 2.0 ) - 1.0 ) ) ));
			float updated_motion_r702_g27268 = ( motion_r654_g27268 * lerpResult8_g27270 );
			float temp_output_7_0_g27282 = 0.0;
			float movement_amount628_g27268 = ( ( ( temp_output_684_29_g27268 * saturate( ( updated_motion_r702_g27268 - ( mask_r650_g27268 * 2.5 ) ) ) * IN_BEND_RADIUS96_g27268 ) - temp_output_7_0_g27282 ) / ( 8.0 - temp_output_7_0_g27282 ) );
			float movement721_g27265 = ( _GRASS_BEND_AVAILABILITY385_g27265 * movement_amount628_g27268 );
			float3 break702_g27265 = ( float3( clampResult26_g27292 ,  0.0 ) * ( pow( movement721_g27265 , 2.0 ) * float3(1,0.4,0.93) ) );
			float3 appendResult704_g27265 = (float3(break702_g27265.x , break702_g27265.y , break702_g27265.z));
			float3 temp_cast_19 = (0.0).xxx;
			float3 temp_cast_20 = (1.0).xxx;
			float3 temp_output_1_0_g27290 = ( appendResult704_g27265 * ( 1.0 / (( ase_objectScale == temp_cast_19 ) ? temp_cast_20 :  ase_objectScale ) ) );
			float3 temp_output_728_0_g27265 = temp_output_1_0_g27290;
			float3 temp_output_41_0_g27368 = ( lerpResult692_g27265 + UPDATED_OFFSET611_g27265 + temp_output_728_0_g27265 );
			float temp_output_63_0_g27369 = (( unity_LODFade.x >= 1E-06 && unity_LODFade.x <= 0.999999 ) ? unity_LODFade.x :  1.0 );
			float3 lerpResult57_g27369 = lerp( temp_output_41_0_g27368 , -ase_vertex3Pos , ( 1.0 - temp_output_63_0_g27369 ));
			#ifdef INTERNAL_LODFADE_SCALE
				float3 staticSwitch58_g27368 = lerpResult57_g27369;
			#else
				float3 staticSwitch58_g27368 = temp_output_41_0_g27368;
			#endif
			#ifdef LOD_FADE_CROSSFADE
				float3 staticSwitch62_g27368 = staticSwitch58_g27368;
			#else
				float3 staticSwitch62_g27368 = temp_output_41_0_g27368;
			#endif
			v.vertex.xyz += staticSwitch62_g27368;
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			o.screenPosition = ase_screenPos;
			o.eyeDepth = -UnityObjectToViewPos( v.vertex.xyz ).z;
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
			float2 uv_MainTex18 = i.uv_texcoord;
			float4 tex2DNode18 = tex2D( _MainTex, uv_MainTex18 );
			half Main_MainTex_A616 = tex2DNode18.a;
			float temp_output_41_0_g27362 = Main_MainTex_A616;
			float4 ase_screenPos = i.screenPosition;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 clipScreen45_g27363 = ase_screenPosNorm.xy * _ScreenParams.xy;
			float dither45_g27363 = Dither8x8Bayer( fmod(clipScreen45_g27363.x, 8), fmod(clipScreen45_g27363.y, 8) );
			float temp_output_56_0_g27363 = (( unity_LODFade.x >= 1E-06 && unity_LODFade.x <= 0.999999 ) ? unity_LODFade.x :  1.0 );
			dither45_g27363 = step( dither45_g27363, temp_output_56_0_g27363 );
			#ifdef INTERNAL_LODFADE_DITHER
				float staticSwitch50_g27362 = ( temp_output_41_0_g27362 * dither45_g27363 );
			#else
				float staticSwitch50_g27362 = temp_output_41_0_g27362;
			#endif
			#ifdef LOD_FADE_CROSSFADE
				float staticSwitch56_g27362 = staticSwitch50_g27362;
			#else
				float staticSwitch56_g27362 = temp_output_41_0_g27362;
			#endif
			float opacity34_g27376 = staticSwitch56_g27362;
			float3 ase_worldPos = i.worldPos;
			float distance22_g27377 = distance( ase_worldPos , _WorldSpaceCameraPos );
			float temp_output_14_0_g27377 = _CutoffFar;
			float temp_output_11_0_g27377 = _CutoffFar;
			float fadeEnd20_g27377 = ( temp_output_14_0_g27377 + temp_output_11_0_g27377 );
			float fadeStart19_g27377 = temp_output_14_0_g27377;
			float fadeLength23_g27377 = temp_output_11_0_g27377;
			float temp_output_9_0_g27376 = saturate( saturate( (( distance22_g27377 > fadeEnd20_g27377 ) ? 0.0 :  (( distance22_g27377 < fadeStart19_g27377 ) ? 1.0 :  ( 1.0 - ( ( distance22_g27377 - fadeStart19_g27377 ) / max( fadeLength23_g27377 , 1E-05 ) ) ) ) ) ) );
			float lerpResult12_g27376 = lerp( _CutoffLowFar , _CutoffLowNear , temp_output_9_0_g27376);
			float lerpResult11_g27376 = lerp( _CutoffHighFar , _CutoffHighNear , temp_output_9_0_g27376);
			float lerpResult1_g27378 = lerp( lerpResult12_g27376 , lerpResult11_g27376 , saturate( 1.0 ));
			float cutoff34_g27376 = lerpResult1_g27378;
			float localExecuteClip34_g27376 = ExecuteClip( opacity34_g27376 , cutoff34_g27376 );
			SurfaceOutputStandard s1_g27375 = (SurfaceOutputStandard ) 0;
			float temp_output_36_0_g27351 = 1.0;
			float2 uv_MetallicGlossMap645 = i.uv_texcoord;
			float4 tex2DNode645 = tex2D( _MetallicGlossMap, uv_MetallicGlossMap645 );
			half Main_MetallicGlossMap_G1287 = tex2DNode645.g;
			float temp_output_108_0_g27307 = Main_MetallicGlossMap_G1287;
			half localunity_ObjectToWorld0w1_g27309 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g27309 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g27309 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g27309 = (float3(localunity_ObjectToWorld0w1_g27309 , localunity_ObjectToWorld1w2_g27309 , localunity_ObjectToWorld2w3_g27309));
			float3 temp_output_22_0_g27308 = ( ase_worldPos - appendResult6_g27309 );
			float3 break23_g27308 = temp_output_22_0_g27308;
			float distance22_g27310 = distance( ase_worldPos , _WorldSpaceCameraPos );
			float temp_output_14_0_g27310 = _BaseDarkeningFadeInStart;
			float temp_output_11_0_g27310 = _BaseDarkeningFadeInRange;
			float fadeEnd20_g27310 = ( temp_output_14_0_g27310 + temp_output_11_0_g27310 );
			float fadeStart19_g27310 = temp_output_14_0_g27310;
			float fadeLength23_g27310 = temp_output_11_0_g27310;
			float lerpResult94_g27307 = lerp( _BaseDarkening , 0.0 , saturate( (( distance22_g27310 > fadeEnd20_g27310 ) ? 0.0 :  (( distance22_g27310 < fadeStart19_g27310 ) ? 1.0 :  ( 1.0 - ( ( distance22_g27310 - fadeStart19_g27310 ) / max( fadeLength23_g27310 , 1E-05 ) ) ) ) ) ));
			float lerpResult96_g27307 = lerp( temp_output_108_0_g27307 , ( temp_output_108_0_g27307 * saturate( ( break23_g27308.y / _BaseDarkeningHeight ) ) ) , lerpResult94_g27307);
			float lerpResult97_g27307 = lerp( 1.0 , lerpResult96_g27307 , _Occlusion);
			float lerpResult38_g27351 = lerp( temp_output_36_0_g27351 , lerpResult97_g27307 , _Occlusion);
			float temp_output_48_0_g27351 = 1.0;
			float lerpResult37_g27351 = lerp( temp_output_36_0_g27351 , saturate( temp_output_48_0_g27351 ) , _VertexOcclusion);
			float3 positionWS3_g27354 = ase_worldPos;
			float4x4 OcclusionProbesWorldToLocal3_g27354 = _OcclusionProbesWorldToLocal;
			float3 uv_OcclusionProbes3 = i.uv_tex3coord;
			uv_OcclusionProbes3.xy = i.uv_tex3coord.xy * _OcclusionProbes_ST.xy + _OcclusionProbes_ST.zw;
			float OcclusionProbes3_g27354 = tex3D( _OcclusionProbes, uv_OcclusionProbes3 ).r;
			float localSampleOcclusionProbes3_g27354 = SampleOcclusionProbes( positionWS3_g27354 , OcclusionProbesWorldToLocal3_g27354 , OcclusionProbes3_g27354 );
			float lerpResult1_g27354 = lerp( 1.0 , localSampleOcclusionProbes3_g27354 , ( _AOProbeStrength * _OCCLUSION_PROBE_GLOBAL ));
			float temp_output_7_0_g27351 = ( saturate( ( lerpResult38_g27351 * lerpResult37_g27351 ) ) * lerpResult1_g27354 );
			float lerpResult18_g27351 = lerp( 1.0 , temp_output_7_0_g27351 , _AOIndirect);
			float lerpResult14_g27351 = lerp( 1.0 , temp_output_7_0_g27351 , _AODirect);
			float lerpResult1_g27351 = lerp( lerpResult18_g27351 , lerpResult14_g27351 , ase_lightAtten);
			float temp_output_16_0_g27351 = saturate( lerpResult1_g27351 );
			float3 temp_output_1323_0 = (tex2DNode18).rgb;
			float3 lerpResult1322 = lerp( temp_output_1323_0 , ( temp_output_1323_0 * (_Color).rgb ) , _Color.a);
			float4 lerpResult2256 = lerp( _Color , _Color_2 , tex2DNode18.r);
			float4 temp_output_89_0_g27299 = float4( (( _ColorMap )?( ( tex2DNode18.g * (lerpResult2256).rgb ) ):( lerpResult1322 )) , 0.0 );
			float3 hsvTorgb92_g27299 = RGBToHSV( temp_output_89_0_g27299.rgb );
			float temp_output_118_0_g27299 = 1.0;
			float3 hsvTorgb83_g27299 = HSVToRGB( float3(hsvTorgb92_g27299.x,( hsvTorgb92_g27299.y * ( temp_output_118_0_g27299 + _Saturation ) ),( hsvTorgb92_g27299.z * ( temp_output_118_0_g27299 + _Brightness ) )) );
			half3 _ALBEDO2254 = hsvTorgb83_g27299;
			float3 break602_g27268 = ase_worldPos;
			float worldPos_X_vertex604_g27268 = break602_g27268.x;
			float temp_output_16_0_g27268 = ( ( worldPos_X_vertex604_g27268 - _TOUCHBEND_CURRENT_STATE_MAP_MIN_XZ.x ) / _TOUCHBEND_CURRENT_STATE_MAP_MIN_XZ.w );
			float worldPos_Z_vertex606_g27268 = break602_g27268.z;
			float temp_output_187_0_g27268 = ( ( -worldPos_Z_vertex606_g27268 - _TOUCHBEND_CURRENT_STATE_MAP_MIN_XZ.z ) / _TOUCHBEND_CURRENT_STATE_MAP_MIN_XZ.w );
			float2 appendResult188_g27268 = (float2(( 1.0 - saturate( temp_output_16_0_g27268 ) ) , ( 1.0 - saturate( temp_output_187_0_g27268 ) )));
			float2 tbPos_vertex98_g27268 = appendResult188_g27268;
			float4 tex2DNode625_g27268 = tex2D( _TOUCHBEND_CURRENT_STATE_MAP_MOTION, tbPos_vertex98_g27268 );
			float motion_g655_g27268 = tex2DNode625_g27268.g;
			float4 _Vector0 = float4(0,0,0,0);
			float4 _Vector1 = float4(1,1,1,1);
			float4 _UP_LOW = float4(0,0,0,0);
			float temp_output_684_29_g27268 = ((_UP_LOW).x + (motion_g655_g27268 - _Vector0.x) * (8.0 - (_UP_LOW).x) / (_Vector1.x - _Vector0.x));
			float temp_output_2620_810 = temp_output_684_29_g27268;
			float2 break11_g27275 = tbPos_vertex98_g27268;
			float clampResult3_g27276 = clamp( break11_g27275.x , 0.0 , 1.0 );
			float clampResult3_g27278 = clamp( break11_g27275.y , 0.0 , 1.0 );
			float lerpResult8_g27275 = lerp( 0.0 , 1.0 , max( abs( ( ( clampResult3_g27276 * 2.0 ) - 1.0 ) ) , abs( ( ( clampResult3_g27278 * 2.0 ) - 1.0 ) ) ));
			float lerpResult2370 = lerp( 1.0 , ( 1.0 - ( 0.2 * temp_output_2620_810 ) ) , ( temp_output_2620_810 * lerpResult8_g27275 ));
			float3 temp_output_2362_0 = saturate( ( saturate( _ALBEDO2254 ) * lerpResult2370 ) );
			float3 albedo51_g27375 = ( temp_output_16_0_g27351 * temp_output_2362_0 );
			s1_g27375.Albedo = albedo51_g27375;
			float2 uv_BumpMap607 = i.uv_texcoord;
			float3 temp_output_13_0_g27306 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap607 ), _NormalScale );
			float3 switchResult20_g27306 = (((i.ASEVFace>0)?(temp_output_13_0_g27306):(-temp_output_13_0_g27306)));
			half3 MainBumpMap620 = switchResult20_g27306;
			float3 temp_output_55_0_g27375 = MainBumpMap620;
			float3 normal_TS54_g27375 = temp_output_55_0_g27375;
			s1_g27375.Normal = WorldNormalVector( i , normal_TS54_g27375 );
			float3 emissive71_g27375 = float3(0,0,0);
			s1_g27375.Emission = emissive71_g27375;
			float metallic34_g27375 = 0.0;
			s1_g27375.Metallic = metallic34_g27375;
			half OUT_SMOOTHNESS660 = ( tex2DNode645.a * _Smoothness );
			float smoothness39_g27375 = OUT_SMOOTHNESS660;
			s1_g27375.Smoothness = smoothness39_g27375;
			float occlusion188_g27375 = temp_output_16_0_g27351;
			s1_g27375.Occlusion = occlusion188_g27375;

			data.light = gi.light;

			UnityGI gi1_g27375 = gi;
			#ifdef UNITY_PASS_FORWARDBASE
			Unity_GlossyEnvironmentData g1_g27375 = UnityGlossyEnvironmentSetup( s1_g27375.Smoothness, data.worldViewDir, s1_g27375.Normal, float3(0,0,0));
			gi1_g27375 = UnityGlobalIllumination( data, s1_g27375.Occlusion, s1_g27375.Normal, g1_g27375 );
			#endif

			float3 surfResult1_g27375 = LightingStandard ( s1_g27375, viewDir, gi1_g27375 ).rgb;
			surfResult1_g27375 += s1_g27375.Emission;

			#ifdef UNITY_PASS_FORWARDADD//1_g27375
			surfResult1_g27375 -= s1_g27375.Emission;
			#endif//1_g27375
			float3 clampResult196_g27375 = clamp( surfResult1_g27375 , float3(0,0,0) , float3(50,50,50) );
			float lerpResult36_g27340 = lerp( 1.0 , ( ase_lightAtten * _OcclusionTransmissionLightingScale ) , _OcclusionTransmissionDampening);
			float OCCLUSION77_g27340 = saturate( lerpResult36_g27340 );
			float temp_output_7_0_g27342 = 0.4;
			float lerpResult82_g27340 = lerp( 1.0 , saturate( ( ( ( _GLOBAL_SOLAR_TIME - temp_output_7_0_g27342 ) / ( 1.0 - temp_output_7_0_g27342 ) ) * 3.0 ) ) , _NighttimeTransmissionDamping);
			UnityGI gi30_g27340 =(UnityGI)gi;
			float3 localIndirectLightDir30_g27340 = IndirectLightDir( gi30_g27340 );
			float dotResult5_g27340 = dot( (WorldNormalVector( i , MainBumpMap620 )) , localIndirectLightDir30_g27340 );
			float baseTransmissionStrength91_g27340 = saturate( -dotResult5_g27340 );
			float adjustedTransmissionStrength93_g27340 = ( ( baseTransmissionStrength91_g27340 * _TransmDirect ) + ( ( 1.0 - baseTransmissionStrength91_g27340 ) * _TransmAmbient ) );
			float cameraDepthFade64_g27340 = (( i.eyeDepth -_ProjectionParams.y - _TransmissionFadeOffset ) / _TransmissionFadeDistance);
			float transmission_strength67_g27340 = ( adjustedTransmissionStrength93_g27340 * _Transmission * ( 1.0 - cameraDepthFade64_g27340 ) );
			half Main_MetallicGlossMap_B1271 = tex2DNode645.b;
			float temp_output_34_0_g27343 = _TransmissionCutoff;
			float4 appendResult2551 = (float4(temp_output_2362_0 , Main_MainTex_A616));
			float4 in_albedo59_g27340 = appendResult2551;
			float4 lerpResult1_g27344 = lerp( _TransmissionColor , in_albedo59_g27340 , saturate( _TransmissionAlbedoBlend ));
			float4 temp_output_15_0_g27343 = lerpResult1_g27344;
			half3 COLOR_TRANSMISSION54_g27340 = ( ( (0.0 + (saturate( ( Main_MetallicGlossMap_B1271 - temp_output_34_0_g27343 ) ) - 0.0) * (1.0 - 0.0) / (( 1.0 - temp_output_34_0_g27343 ) - 0.0)) * (temp_output_15_0_g27343).a ) * (temp_output_15_0_g27343).rgb );
			UnityGI gi29_g27340 =(UnityGI)gi;
			float3 localIndirectLightColor29_g27340 = IndirectLightColor( gi29_g27340 );
			float distance22_g27356 = distance( ase_worldPos , _WorldSpaceCameraPos );
			float temp_output_14_0_g27356 = _TranslucencyFadeOffset;
			float temp_output_11_0_g27356 = _TranslucencyFadeDistance;
			float fadeEnd20_g27356 = ( temp_output_14_0_g27356 + temp_output_11_0_g27356 );
			float fadeStart19_g27356 = temp_output_14_0_g27356;
			float fadeLength23_g27356 = temp_output_11_0_g27356;
			float translucency_strength100_g27355 = ( _Translucency * saturate( (( distance22_g27356 > fadeEnd20_g27356 ) ? 0.0 :  (( distance22_g27356 < fadeStart19_g27356 ) ? 1.0 :  ( 1.0 - ( ( distance22_g27356 - fadeStart19_g27356 ) / max( fadeLength23_g27356 , 1E-05 ) ) ) ) ) ) );
			float lerpResult81_g27355 = lerp( 1.0 , ( ase_lightAtten * _OcclusionTransmissionLightingScale1 ) , _OcclusionTranslucencyDamping);
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float3 temp_output_47_0_g27355 = ( (WorldNormalVector( i , MainBumpMap620 )) * _TransNormalDistortion );
			float3 lightDir40_g27355 = ( ase_worldlightDir + temp_output_47_0_g27355 );
			float dotResult59_g27355 = dot( ase_worldViewDir , -lightDir40_g27355 );
			float transVdotL56_g27355 = pow( saturate( dotResult59_g27355 ) , _TransScattering );
			UnityGI gi129_g27355 =(UnityGI)gi;
			float3 localGetGILightColor129_g27355 = GetGILightColor( gi129_g27355 );
			float3 localGetPrimaryLightColor33_g27355 = GetPrimaryLightColor();
			float3 lerpResult30_g27355 = lerp( localGetPrimaryLightColor33_g27355 , localGetGILightColor129_g27355 , saturate( _TransShadow ));
			#ifdef DIRECTIONAL
				float3 staticSwitch18_g27355 = lerpResult30_g27355;
			#else
				float3 staticSwitch18_g27355 = localGetGILightColor129_g27355;
			#endif
			float3 lightAtten35_g27355 = staticSwitch18_g27355;
			float temp_output_34_0_g27357 = _TranslucencyCutoff;
			float4 lerpResult1_g27358 = lerp( _TranslucencyColor , appendResult2551 , saturate( _TranslucencyAlbedoBlend ));
			float4 temp_output_15_0_g27357 = lerpResult1_g27358;
			half3 COLOR_TRANSLUCENCY105_g27355 = ( ( (0.0 + (saturate( ( Main_MetallicGlossMap_B1271 - temp_output_34_0_g27357 ) ) - 0.0) * (1.0 - 0.0) / (( 1.0 - temp_output_34_0_g27357 ) - 0.0)) * (temp_output_15_0_g27357).a ) * (temp_output_15_0_g27357).rgb );
			float3 translucency63_g27355 = ( ( ( transVdotL56_g27355 * _TransDirect ) + ( ( 1.0 - transVdotL56_g27355 ) * _TransAmbient ) ) * lightAtten35_g27355 * COLOR_TRANSLUCENCY105_g27355 );
			float temp_output_7_0_g27360 = 0.4;
			float lerpResult125_g27355 = lerp( 1.0 , saturate( ( ( ( _GLOBAL_SOLAR_TIME - temp_output_7_0_g27360 ) / ( 1.0 - temp_output_7_0_g27360 ) ) * 3.0 ) ) , _NighttimeTranslucencyDamping);
			float3 clampResult6_g27374 = clamp( ( ( ( OCCLUSION77_g27340 * lerpResult82_g27340 * transmission_strength67_g27340 * COLOR_TRANSMISSION54_g27340 * localIndirectLightColor29_g27340 * (in_albedo59_g27340).rgb ) + (( translucency_strength100_g27355 * saturate( lerpResult81_g27355 ) * translucency63_g27355 * lerpResult125_g27355 )).xyz ) * (_TransmittanceScaling).xxx ) , float3( 0,0,0 ) , (_TransmittanceLimit).xxx );
			c.rgb = ( clampResult196_g27375 + clampResult6_g27374 );
			c.a = 1;
			clip( localExecuteClip34_g27376 - _Cutoff );
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
			float temp_output_36_0_g27351 = 1.0;
			float2 uv_MetallicGlossMap645 = i.uv_texcoord;
			float4 tex2DNode645 = tex2D( _MetallicGlossMap, uv_MetallicGlossMap645 );
			half Main_MetallicGlossMap_G1287 = tex2DNode645.g;
			float temp_output_108_0_g27307 = Main_MetallicGlossMap_G1287;
			float3 ase_worldPos = i.worldPos;
			half localunity_ObjectToWorld0w1_g27309 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g27309 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g27309 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g27309 = (float3(localunity_ObjectToWorld0w1_g27309 , localunity_ObjectToWorld1w2_g27309 , localunity_ObjectToWorld2w3_g27309));
			float3 temp_output_22_0_g27308 = ( ase_worldPos - appendResult6_g27309 );
			float3 break23_g27308 = temp_output_22_0_g27308;
			float distance22_g27310 = distance( ase_worldPos , _WorldSpaceCameraPos );
			float temp_output_14_0_g27310 = _BaseDarkeningFadeInStart;
			float temp_output_11_0_g27310 = _BaseDarkeningFadeInRange;
			float fadeEnd20_g27310 = ( temp_output_14_0_g27310 + temp_output_11_0_g27310 );
			float fadeStart19_g27310 = temp_output_14_0_g27310;
			float fadeLength23_g27310 = temp_output_11_0_g27310;
			float lerpResult94_g27307 = lerp( _BaseDarkening , 0.0 , saturate( (( distance22_g27310 > fadeEnd20_g27310 ) ? 0.0 :  (( distance22_g27310 < fadeStart19_g27310 ) ? 1.0 :  ( 1.0 - ( ( distance22_g27310 - fadeStart19_g27310 ) / max( fadeLength23_g27310 , 1E-05 ) ) ) ) ) ));
			float lerpResult96_g27307 = lerp( temp_output_108_0_g27307 , ( temp_output_108_0_g27307 * saturate( ( break23_g27308.y / _BaseDarkeningHeight ) ) ) , lerpResult94_g27307);
			float lerpResult97_g27307 = lerp( 1.0 , lerpResult96_g27307 , _Occlusion);
			float lerpResult38_g27351 = lerp( temp_output_36_0_g27351 , lerpResult97_g27307 , _Occlusion);
			float temp_output_48_0_g27351 = 1.0;
			float lerpResult37_g27351 = lerp( temp_output_36_0_g27351 , saturate( temp_output_48_0_g27351 ) , _VertexOcclusion);
			float3 positionWS3_g27354 = ase_worldPos;
			float4x4 OcclusionProbesWorldToLocal3_g27354 = _OcclusionProbesWorldToLocal;
			float3 uv_OcclusionProbes3 = i.uv_tex3coord;
			uv_OcclusionProbes3.xy = i.uv_tex3coord.xy * _OcclusionProbes_ST.xy + _OcclusionProbes_ST.zw;
			float OcclusionProbes3_g27354 = tex3D( _OcclusionProbes, uv_OcclusionProbes3 ).r;
			float localSampleOcclusionProbes3_g27354 = SampleOcclusionProbes( positionWS3_g27354 , OcclusionProbesWorldToLocal3_g27354 , OcclusionProbes3_g27354 );
			float lerpResult1_g27354 = lerp( 1.0 , localSampleOcclusionProbes3_g27354 , ( _AOProbeStrength * _OCCLUSION_PROBE_GLOBAL ));
			float temp_output_7_0_g27351 = ( saturate( ( lerpResult38_g27351 * lerpResult37_g27351 ) ) * lerpResult1_g27354 );
			float lerpResult18_g27351 = lerp( 1.0 , temp_output_7_0_g27351 , _AOIndirect);
			float lerpResult14_g27351 = lerp( 1.0 , temp_output_7_0_g27351 , _AODirect);
			float lerpResult1_g27351 = lerp( lerpResult18_g27351 , lerpResult14_g27351 , 1);
			float temp_output_16_0_g27351 = saturate( lerpResult1_g27351 );
			float2 uv_MainTex18 = i.uv_texcoord;
			float4 tex2DNode18 = tex2D( _MainTex, uv_MainTex18 );
			float3 temp_output_1323_0 = (tex2DNode18).rgb;
			float3 lerpResult1322 = lerp( temp_output_1323_0 , ( temp_output_1323_0 * (_Color).rgb ) , _Color.a);
			float4 lerpResult2256 = lerp( _Color , _Color_2 , tex2DNode18.r);
			float4 temp_output_89_0_g27299 = float4( (( _ColorMap )?( ( tex2DNode18.g * (lerpResult2256).rgb ) ):( lerpResult1322 )) , 0.0 );
			float3 hsvTorgb92_g27299 = RGBToHSV( temp_output_89_0_g27299.rgb );
			float temp_output_118_0_g27299 = 1.0;
			float3 hsvTorgb83_g27299 = HSVToRGB( float3(hsvTorgb92_g27299.x,( hsvTorgb92_g27299.y * ( temp_output_118_0_g27299 + _Saturation ) ),( hsvTorgb92_g27299.z * ( temp_output_118_0_g27299 + _Brightness ) )) );
			half3 _ALBEDO2254 = hsvTorgb83_g27299;
			float3 break602_g27268 = ase_worldPos;
			float worldPos_X_vertex604_g27268 = break602_g27268.x;
			float temp_output_16_0_g27268 = ( ( worldPos_X_vertex604_g27268 - _TOUCHBEND_CURRENT_STATE_MAP_MIN_XZ.x ) / _TOUCHBEND_CURRENT_STATE_MAP_MIN_XZ.w );
			float worldPos_Z_vertex606_g27268 = break602_g27268.z;
			float temp_output_187_0_g27268 = ( ( -worldPos_Z_vertex606_g27268 - _TOUCHBEND_CURRENT_STATE_MAP_MIN_XZ.z ) / _TOUCHBEND_CURRENT_STATE_MAP_MIN_XZ.w );
			float2 appendResult188_g27268 = (float2(( 1.0 - saturate( temp_output_16_0_g27268 ) ) , ( 1.0 - saturate( temp_output_187_0_g27268 ) )));
			float2 tbPos_vertex98_g27268 = appendResult188_g27268;
			float4 tex2DNode625_g27268 = tex2D( _TOUCHBEND_CURRENT_STATE_MAP_MOTION, tbPos_vertex98_g27268 );
			float motion_g655_g27268 = tex2DNode625_g27268.g;
			float4 _Vector0 = float4(0,0,0,0);
			float4 _Vector1 = float4(1,1,1,1);
			float4 _UP_LOW = float4(0,0,0,0);
			float temp_output_684_29_g27268 = ((_UP_LOW).x + (motion_g655_g27268 - _Vector0.x) * (8.0 - (_UP_LOW).x) / (_Vector1.x - _Vector0.x));
			float temp_output_2620_810 = temp_output_684_29_g27268;
			float2 break11_g27275 = tbPos_vertex98_g27268;
			float clampResult3_g27276 = clamp( break11_g27275.x , 0.0 , 1.0 );
			float clampResult3_g27278 = clamp( break11_g27275.y , 0.0 , 1.0 );
			float lerpResult8_g27275 = lerp( 0.0 , 1.0 , max( abs( ( ( clampResult3_g27276 * 2.0 ) - 1.0 ) ) , abs( ( ( clampResult3_g27278 * 2.0 ) - 1.0 ) ) ));
			float lerpResult2370 = lerp( 1.0 , ( 1.0 - ( 0.2 * temp_output_2620_810 ) ) , ( temp_output_2620_810 * lerpResult8_g27275 ));
			float3 temp_output_2362_0 = saturate( ( saturate( _ALBEDO2254 ) * lerpResult2370 ) );
			float3 albedo51_g27375 = ( temp_output_16_0_g27351 * temp_output_2362_0 );
			o.Albedo = ( _GlobalIlluminationAlbedoEffect * albedo51_g27375 );
			float3 emissive71_g27375 = float3(0,0,0);
			o.Emission = ( _GlobalIlluminationEmissiveEffect * emissive71_g27375 );
		}

		ENDCG
		CGPROGRAM
#include "UnityCG.cginc"
#include "Assets/Resources/CGIncludes/GPUInstancerInclude.cginc"
#pragma instancing_options procedural:setupGPUI
#pragma multi_compile_instancing
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows exclude_path:deferred dithercrossfade vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
#include "UnityCG.cginc"
#include "Assets/Resources/CGIncludes/GPUInstancerInclude.cginc"
#pragma instancing_options procedural:setupGPUI
#pragma multi_compile_instancing
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.0
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
				float3 customPack2 : TEXCOORD2;
				float4 customPack3 : TEXCOORD3;
				float4 tSpace0 : TEXCOORD4;
				float4 tSpace1 : TEXCOORD5;
				float4 tSpace2 : TEXCOORD6;
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
				o.customPack3.xyzw = customInputData.screenPosition;
				o.customPack1.z = customInputData.eyeDepth;
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
				surfIN.screenPosition = IN.customPack3.xyzw;
				surfIN.eyeDepth = IN.customPack1.z;
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
				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT( UnityGI, gi );
				o.Alpha = LightingStandardCustomLighting( o, worldViewDir, gi ).a;
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "internal/fallback"
	CustomEditor "InternalShaderGUI"
}
/*ASEBEGIN
Version=17500
261.6;0;1006;745;-493.5364;808.9208;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;2607;-3576.31,167.8434;Inherit;False;Property;_HeightWindStrength;Height Wind Strength;78;0;Create;True;0;0;False;0;0.5;0.5;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2606;-3583.31,17.84338;Inherit;False;Vertex Position (World);-1;;25944;0a7d99b9d0eadce408a017c263e65d01;0;0;4;FLOAT3;0;FLOAT;3;FLOAT;5;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2608;-3262.31,24.84338;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1300;-3572.207,-146.6559;Inherit;False;Mesh Values (Tree) (Complex) (Vertex Colors);-1;;26742;9cacaefc2ecfddf4c8e070f9be99b854;0;0;4;FLOAT;495;FLOAT;501;FLOAT;550;FLOAT;552
Node;AmplifyShaderEditor.ColorNode;2249;-2574.165,834.2368;Half;False;Property;_Color_2;Grass Color 2;18;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;2161;-2946.139,-313.9377;Inherit;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;18;-2574.165,386.2368;Inherit;True;Property;_MainTex;Grass Albedo;13;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;e968f28595d9c894d9af70a95c1f7a0e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;409;-2574.165,642.2368;Half;False;Property;_Color;Grass Color;14;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;2605;-3118.61,-96.25661;Inherit;False;Property;_HeightBasedWind;Height Based Wind;77;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;2221;-2690.139,-313.9377;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;1323;-2176,384;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;2256;-2176,864;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2619;-2843.532,-157.8779;Inherit;False;Wind (Grass);79;;27193;d7f6e9209bef88c48a309bf8b38bad07;0;2;1469;FLOAT3;0,0,0;False;1152;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;2626;-2667.171,3.094421;Inherit;False;Constant;_Vector0;Vector 0;40;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ComponentMaskNode;1320;-2107.265,556.2369;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;2264;-2016,864;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;2162;-2498.139,-313.9377;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;2625;-2461.279,-15.60306;Inherit;False;Property;_WindEnabled;Wind Enabled;76;0;Create;True;0;0;False;0;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1074;-1862.164,503.2368;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;2595;-1721.006,599.3914;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2620;-2212.699,-152.6988;Inherit;False;TouchBend (Grass);95;;27265;0036c878fe7874347ba0398f61078a69;0;3;682;FLOAT3;0,0,0;False;618;FLOAT3;0,0,0;False;281;FLOAT;0;False;8;FLOAT3;695;FLOAT3;604;FLOAT3;0;FLOAT3;708;FLOAT3;612;FLOAT3;422;FLOAT;810;FLOAT;814
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2379;-1792,832;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;1322;-1634.165,439.2368;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;2588;-1412.903,530.1616;Inherit;False;Property;_ColorMap;Color Map;17;0;Create;True;0;0;False;0;0;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2585;-1449.71,768.8115;Inherit;False;Property;_Brightness;Brightness;16;0;Create;False;0;0;False;0;1;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2569;-1721.936,-341.4791;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2584;-1459.328,679.7748;Inherit;False;Property;_Saturation;Saturation;15;0;Create;False;0;0;False;0;1;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2589;-1119.536,528.0499;Inherit;False;Color Adjustment;-1;;27299;f9571dc7cf91d954d87b44c4dd2d35aa;6,90,0,81,1,91,1,85,0,116,0,111,0;6;89;COLOR;0,0,0,0;False;82;FLOAT;0;False;86;FLOAT;0;False;87;FLOAT;0;False;88;FLOAT;0;False;115;FLOAT;0;False;1;FLOAT3;37
Node;AmplifyShaderEditor.WireNode;2570;-2448,-848;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2567;-1650.102,-323.815;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2568;-1609.703,-321.4597;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2360;-2549.59,-1046.475;Inherit;False;Constant;_Float3;Float 3;35;0;Create;True;0;0;False;0;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2572;-2208,-752;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2254;-907.0645,521.1369;Half;False;_ALBEDO;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2359;-2344.99,-1041.375;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2571;-2192,-768;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;655;-55.36663,384.3344;Half;False;Property;_NormalScale;Grass Normal Scale;21;0;Create;False;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;2366;-2184.99,-1041.375;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2376;-2152.99,-945.375;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;36;-2300.556,-1219.511;Inherit;False;2254;_ALBEDO;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2371;-2176.99,-1112.375;Inherit;False;Constant;_Float4;Float 4;35;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2370;-1999.623,-1058.33;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;645;-15.18266,777.5811;Inherit;True;Property;_MetallicGlossMap;Grass Surface;23;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;14428ab7ffaaca34a87b0084f2c3c790;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;607;200.6334,384.3344;Inherit;True;Property;_BumpMap;Grass Normal;20;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;4ac8f3664f15d2649841f464812edcb2;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;1109;-2031.555,-1198.844;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;294;15.81734,984.5811;Half;False;Property;_Smoothness;Grass Smoothness;24;0;Create;False;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2365;-1827.573,-1077.428;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1287;350.0633,800.387;Half;False;Main_MetallicGlossMap_G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;616;-2176,480;Half;False;Main_MainTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1273;551.6334,410.3344;Inherit;False;Normal BackFace;-1;;27306;121446c878db06f4c847f9c5afed7cfe;0;1;13;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1271;370.8682,887.6317;Half;False;Main_MetallicGlossMap_B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;745;374.8173,976.5811;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2550;-1580.058,-801.9531;Inherit;False;616;Main_MainTex_A;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2362;-1667.573,-1077.428;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1313;-1664.717,-1282.482;Half;False;Property;_Occlusion;Grass Occlusion;25;0;Create;False;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;620;776.6334,384.3344;Half;False;MainBumpMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1292;-1650.946,-1198.882;Inherit;False;1287;Main_MetallicGlossMap_G;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2545;-1336.579,-1217.318;Inherit;False;Occlusion Base Darkening;26;;27307;dc12f5d0428b96f4b9e8c694be09d275;0;2;107;FLOAT;0;False;108;FLOAT;0;False;1;FLOAT;106
Node;AmplifyShaderEditor.DynamicAppendNode;2551;-1277.858,-817.653;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;2565;-1375.013,-632.2277;Inherit;False;1271;Main_MetallicGlossMap_B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;660;536.8173,976.5811;Half;False;OUT_SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2564;-1336.013,-712.8277;Inherit;False;620;MainBumpMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2558;-978.8487,-939.7658;Inherit;False;660;OUT_SMOOTHNESS;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2582;-987.8568,-700.7971;Inherit;False;Translucency;55;;27355;2d05813238a8e3247978494a31c6caa3;1,45,0;4;55;COLOR;0,0,0,0;False;44;FLOAT3;0,0,0;False;42;FLOAT3;0,0,0;False;113;FLOAT;1;False;1;FLOAT3;54
Node;AmplifyShaderEditor.WireNode;2372;-661.2026,-43.9049;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;791;-732.1061,-238.2956;Inherit;False;616;Main_MainTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2596;-982.5969,-824.8269;Inherit;False;Transmission;42;;27340;e758152fceada0549997f6183a738107;1,14,0;4;6;COLOR;0,0,0,0;False;7;FLOAT3;0,0,0;False;15;FLOAT3;0,0,0;False;57;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2557;-982.8156,-1018.818;Inherit;False;620;MainBumpMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;2622;-1005.243,-1148.859;Inherit;False;Occlusion Probes;32;;27351;fc5cec86a89be184e93fc845da77a0cc;4,64,0,22,1,65,0,66,1;3;12;FLOAT;0;False;48;FLOAT;0;False;26;FLOAT3;1,1,1;False;2;FLOAT;0;FLOAT3;31
Node;AmplifyShaderEditor.FunctionNode;1364;-381.0503,-189.3804;Inherit;False;Execute LOD Fade;-1;;27361;18ea34bd83a0d6c4db425672111543e6;0;2;41;FLOAT;0;False;58;FLOAT3;0,0,0;False;3;FLOAT;0;FLOAT3;91;FLOAT;96
Node;AmplifyShaderEditor.FunctionNode;2579;-537.674,-668.8303;Inherit;False;Transmittance Scaling;71;;27374;78929217b6ba7534daefd6d688626ff6;0;2;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2604;-235.1231,79.29376;Inherit;False;Constant;_Float2;Float 2;34;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1112;984.8914,-877.3608;Inherit;False;373.6605;714.1545;Drawers;9;1119;1282;1115;2609;1116;862;2576;1113;2623;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.FunctionNode;2581;-404.1844,-968.8458;Inherit;False;Custom Lighting;100;;27375;b225dcbb02c65fb46af1dbc43764905b;1,67,0;7;56;FLOAT3;0,0,0;False;55;FLOAT3;0,0,0;False;70;FLOAT3;0,0,0;False;45;FLOAT;0;False;148;FLOAT3;0,0,0;False;41;FLOAT;0;False;189;FLOAT;0;False;3;FLOAT3;4;FLOAT3;5;FLOAT3;3
Node;AmplifyShaderEditor.RangedFloatNode;1116;1016.891,-525.3618;Half;False;Property;_SURFACEE;[ SURFACEE ];22;0;Create;True;0;0;True;1;InternalCategory(Surface);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2576;1185.884,-520.9364;Half;False;Property;_NORMALL;[ NORMALL ];19;0;Create;True;0;0;True;1;InternalCategory(Normal);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2609;1219.526,-595.3618;Half;False;Property;_WINDD;[ WINDD ];75;0;Create;True;0;0;True;1;InternalCategory(Wind);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1115;1017.891,-621.3616;Half;False;Property;_COLORR;[ COLORR ];12;0;Create;True;0;0;True;1;InternalCategory(Color);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1113;1016.891,-717.3616;Half;False;Property;_RENDERINGG;[ RENDERINGG ];1;0;Create;True;0;0;True;1;InternalCategory(Rendering);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1119;1016.891,-813.3608;Half;False;Property;_BANNER;BANNER;0;0;Create;True;0;0;True;1;InternalBanner(Internal,Grass);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1282;1024,-256;Inherit;False;Internal Features Support;-1;;27379;3c493d142aeebd840af72d626f6915c6;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2560;238.3259,-594.2922;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;2602;180.55,-270.8306;Inherit;False;Cutoff Distance;5;;27376;5fa78795cf865fc4fba7d47ebe2d2d92;0;2;33;FLOAT;0;False;16;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;2621;-3268.023,-270.1943;Inherit;False;Property;_Billboard;Billboard;2;0;Create;True;0;0;True;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;862;1026.891,-439.3616;Half;False;Property;_Cutoff;Depth Cutoff;4;0;Create;False;3;Off;0;Front;1;Back;2;0;True;0;0.5;0.8;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2623;1024,-351;Inherit;False;Property;_ZWrite;Z Write;3;1;[Toggle];Create;True;0;0;True;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;569.8781,-833.283;Float;False;True;-1;4;InternalShaderGUI;300;0;CustomLighting;internal/grass;False;False;False;False;False;False;False;False;False;False;False;False;True;True;False;False;True;False;True;True;False;Off;1;True;2623;3;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.8;True;True;0;True;Custom;InternalGrass;AlphaTest;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;550;10;False;553;0;1;False;550;10;False;553;0;True;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;True;Cylindrical;True;True;True;_BILLBOARD_ON;Relative;300;internal/fallback;-1;-1;-1;-1;0;False;0;0;False;743;-1;0;True;862;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;14;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;708;-55.36663,256.3343;Inherit;False;1024.6;100;Normal Texture;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;760;-2780.052,230.1812;Inherit;False;2581.91;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;715;-15.18266,649.5809;Inherit;False;833.8796;100;Surface Input;0;;1,0.7686275,0,1;0;0
WireConnection;2608;0;2606;5
WireConnection;2608;1;2607;0
WireConnection;2605;1;1300;495
WireConnection;2605;0;2608;0
WireConnection;2221;0;2161;1
WireConnection;1323;0;18;0
WireConnection;2256;0;409;0
WireConnection;2256;1;2249;0
WireConnection;2256;2;18;1
WireConnection;2619;1152;2605;0
WireConnection;1320;0;409;0
WireConnection;2264;0;2256;0
WireConnection;2162;0;2221;0
WireConnection;2162;2;2161;2
WireConnection;2625;1;2626;0
WireConnection;2625;0;2619;0
WireConnection;1074;0;1323;0
WireConnection;1074;1;1320;0
WireConnection;2595;0;409;4
WireConnection;2620;682;2162;0
WireConnection;2620;618;2625;0
WireConnection;2620;281;2605;0
WireConnection;2379;0;18;2
WireConnection;2379;1;2264;0
WireConnection;1322;0;1323;0
WireConnection;1322;1;1074;0
WireConnection;1322;2;2595;0
WireConnection;2588;0;1322;0
WireConnection;2588;1;2379;0
WireConnection;2569;0;2620;810
WireConnection;2589;89;2588;0
WireConnection;2589;86;2584;0
WireConnection;2589;87;2585;0
WireConnection;2570;0;2569;0
WireConnection;2567;0;2620;810
WireConnection;2568;0;2620;814
WireConnection;2572;0;2567;0
WireConnection;2254;0;2589;37
WireConnection;2359;0;2360;0
WireConnection;2359;1;2570;0
WireConnection;2571;0;2568;0
WireConnection;2366;0;2359;0
WireConnection;2376;0;2572;0
WireConnection;2376;1;2571;0
WireConnection;2370;0;2371;0
WireConnection;2370;1;2366;0
WireConnection;2370;2;2376;0
WireConnection;607;5;655;0
WireConnection;1109;0;36;0
WireConnection;2365;0;1109;0
WireConnection;2365;1;2370;0
WireConnection;1287;0;645;2
WireConnection;616;0;18;4
WireConnection;1273;13;607;0
WireConnection;1271;0;645;3
WireConnection;745;0;645;4
WireConnection;745;1;294;0
WireConnection;2362;0;2365;0
WireConnection;620;0;1273;0
WireConnection;2545;107;1313;0
WireConnection;2545;108;1292;0
WireConnection;2551;0;2362;0
WireConnection;2551;3;2550;0
WireConnection;660;0;745;0
WireConnection;2582;55;2551;0
WireConnection;2582;44;2564;0
WireConnection;2582;113;2565;0
WireConnection;2372;0;2620;695
WireConnection;2596;6;2551;0
WireConnection;2596;7;2564;0
WireConnection;2596;57;2565;0
WireConnection;2622;12;2545;106
WireConnection;2622;26;2362;0
WireConnection;1364;41;791;0
WireConnection;1364;58;2372;0
WireConnection;2579;2;2596;0
WireConnection;2579;3;2582;54
WireConnection;2581;56;2622;31
WireConnection;2581;55;2557;0
WireConnection;2581;41;2558;0
WireConnection;2581;189;2622;0
WireConnection;2560;0;2581;3
WireConnection;2560;1;2579;0
WireConnection;2602;33;1364;0
WireConnection;2602;16;2604;0
WireConnection;0;0;2581;4
WireConnection;0;2;2581;5
WireConnection;0;10;2602;0
WireConnection;0;14;2560;0
WireConnection;0;11;1364;91
ASEEND*/
//CHKSM=8055AF9D9E078AE66CAA3A4CC6A17733BBC26CA5
