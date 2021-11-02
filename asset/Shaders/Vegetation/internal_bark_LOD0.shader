// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "appalachia/bark_LOD0"
{
	Properties
	{
		[AppalachiaBanner(Internal, Bark)]_BANNER("BANNER", Float) = 1
		[AppalachiaCategory(Trunk)]_TRUNKK("[ TRUNKK ]", Float) = 0
		_MainTex("Bark Albedo", 2D) = "white" {}
		_Color("Trunk Color", Color) = (1,1,1,1)
		_Saturation("Saturation", Range( -1 , 1)) = 0
		_Brightness("Brightness", Range( -1 , 1)) = 0
		[NoScaleOffset][Normal]_BumpMap("Bark Normal", 2D) = "bump" {}
		_BumpScale("Normal Scale", Range( 0 , 5)) = 1
		[NoScaleOffset]_MetallicGlossMap("Bark Surface", 2D) = "white" {}
		_Color9("Trunk Fade Color", Color) = (1,1,1,1)
		_TrunkFadeStrength("Trunk Fade Strength", Range( 0 , 0.2)) = 0
		_TrunkVariation("Trunk Variation", Range( 0 , 1)) = 1
		_Glossiness("Base Smoothness", Range( 0 , 1)) = 0.1
		_Occlusion("Base Occlusion", Range( 0 , 1)) = 1
		[AppalachiaCategory(Cover Blending)]_COVERR("[ COVERR  ]", Float) = 0
		[Toggle(_ENABLEBASE_ON)] _EnableBase("Enable Base", Float) = 0
		_BlendAmount("Blend Amount", Range( 0.0001 , 1)) = 1
		_BlendVariation("Blend Variation", Range( 0 , 1)) = 1
		_BlendHeight("Blend Height", Range( 0 , 20)) = 1
		_BlendFade("Blend Fade", Range( 0 , 60)) = 20
		_BlendFadeRatio("Blend Fade Ratio", Range( 0 , 20)) = 3
		_BaseHeightOffset("Base Height Offset", Range( -1 , 1)) = -0.25
		_BaseHeightRange("Base Height Range", Range( 0.0001 , 1)) = 1
		_CoverHeightOffset("Cover Height Offset", Range( -1 , 1)) = 0
		_CoverHeightRange("Cover Height Range", Range( 0.0001 , 1)) = 0.9
		_HeightBlendContrast("Height Blend Contrast", Range( 0 , 0.999)) = 0.95
		_BlendNormals("Blend Normals", Range( 0 , 1)) = 0.3
		_Occlusion3("Cover Occlusion", Range( 0 , 1)) = 1
		_Glossiness3("Cover Smoothness", Range( 0 , 1)) = 0.1
		[Toggle]_SwapLayers("Swap Layers", Range( 0 , 1)) = 0
		_MainTex3("Cover Albedo", 2D) = "white" {}
		_Color3("Cover Color", Color) = (1,1,1,1)
		_CoverSaturation("Cover Saturation", Range( -1 , 1)) = 0
		_CoverBrightness("Cover Brightness", Range( -1 , 1)) = 0
		[NoScaleOffset][Normal]_BumpMap3("Cover Normal", 2D) = "bump" {}
		_BumpScale3("Cover Normal Scale", Range( 0 , 5)) = 1
		[NoScaleOffset]_MetallicGlossMap3("Cover Surface", 2D) = "white" {}
		[AppalachiaCategory(Break)]_BREAKK("[ BREAKK ]", Float) = 0
		_MainTex2("Break Albedo", 2D) = "white" {}
		[NoScaleOffset]_Map2("Break Color Map", 2D) = "white" {}
		_BreakColorHeartwood("Break Color Heartwood", Color) = (0.3215686,0.2352941,0.1333333,1)
		_BreakColorSapwood("Break Color Sapwood", Color) = (0.6431373,0.5372549,0.3137255,1)
		_BreakColorContrast("Break Color Contrast", Color) = (0.07843138,0.05490196,0.03137255,1)
		[NoScaleOffset][Normal]_BumpMap2("Break Normal", 2D) = "bump" {}
		_BumpScale2("Break Normal Scale", Range( 0 , 5)) = 1
		[NoScaleOffset]_MetallicGlossMap2("Break Surface", 2D) = "white" {}
		_Occlusion2("Break Occlusion", Range( 0 , 1)) = 1
		_Glossiness2("Break Smoothness", Range( 0 , 1)) = 0.2
		[AppalachiaCategory(Occlusion)]_OCCLUSIONN("[ OCCLUSIONN ]", Float) = 0
		_Occlusion("Texture Occlusion", Range( 0 , 1)) = 0.5
		_VertexOcclusion("Vertex Occlusion", Range( 0 , 1)) = 0.5
		_VertexOcclusionContrast("Vertex Occlusion Contrast", Range( 0 , 5)) = 0.5
		_AOProbeStrength("AO Probe Strength", Range( 0 , 1)) = 0.8
		_AOIndirect("AO Indirect", Range( 0 , 1)) = 1
		_AODirect("AO Direct", Range( 0 , 1)) = 0
		[AppalachiaCategory(Global Illumination)]_GLOBALILLUMINATIONN("[ GLOBAL ILLUMINATIONN ]", Float) = 0
		_GlobalIlluminationAlbedoEffect("Global Illumination Albedo Effect", Range( 0 , 5)) = 1
		_GlobalIlluminationEmissiveEffect("Global Illumination Emissive Effect", Range( 0 , 5)) = 1
		[HideInInspector][Toggle]_IsLeaf("Is Leaf", Float) = 0
		[HideInInspector] _tex4coord3( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector][Toggle]_IsBark("Is Bark", Float) = 1
		[HideInInspector][Toggle]_IsShadow("Is Shadow", Float) = 0
		[HideInInspector] _tex3coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "InternalBark"  "Queue" = "Geometry+0" "DisableBatching" = "True" "IsEmissive" = "true"  }
		LOD 300
		Cull Off
		ZWrite On
		ZTest LEqual
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "Lighting.cginc"
		#pragma target 4.0
		#pragma shader_feature_local _ENABLEBASE_ON
		 





		// INTERNAL_SHADER_FEATURE_START

		// FEATURE_GPU_INSTANCER
		#include "UnityCG.cginc"
		#include "Assets/Resources/CGIncludes/Appalachia/GPUInstancerInclude.cginc"
		#pragma instancing_options procedural:setupGPUI


		// FEATURE_LODFADE_DITHER
		#define INTERNAL_LODFADE_DITHER
		#pragma multi_compile _ LOD_FADE_CROSSFADE

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
		};
		struct Input
		{
			float4 uv3_tex4coord3;
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
			float3 worldPos;
			float4 uv_tex4coord;
			float3 uv_tex3coord;
			float4 screenPosition;
			float3 worldNormal;
			INTERNAL_DATA
			half ASEVFace : VFACE;
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

		uniform half _COVERR;
		uniform half _GLOBALILLUMINATIONN;
		uniform half _BREAKK;
		uniform half _BANNER;
		uniform half _IsShadow;
		uniform half _TRUNKK;
		uniform half _IsLeaf;
		uniform half _IsBark;
		uniform half _OCCLUSIONN;
		uniform half _WIND_TRUNK_STRENGTH;
		uniform half _WIND_BASE_TRUNK_FIELD_SIZE;
		uniform half _WIND_BASE_TRUNK_CYCLE_TIME;
		uniform half _WIND_BASE_AMPLITUDE;
		uniform half _WIND_BASE_TRUNK_STRENGTH;
		uniform half _WIND_GUST_AMPLITUDE;
		uniform half _WIND_GUST_AUDIO_STRENGTH;
		uniform half _WIND_AUDIO_INFLUENCE;
		uniform half _WIND_GUST_AUDIO_STRENGTH_LOW;
		uniform half _WIND_GUST_TRUNK_STRENGTH;
		uniform half _WIND_GUST_TRUNK_CYCLE_TIME;
		uniform half _WIND_GUST_TRUNK_FIELD_SIZE;
		uniform half3 _WIND_DIRECTION;
		uniform half _WIND_BRANCH_STRENGTH;
		uniform half _WIND_BASE_BRANCH_FIELD_SIZE;
		uniform half _WIND_BASE_BRANCH_VARIATION_STRENGTH;
		uniform half _WIND_BASE_BRANCH_CYCLE_TIME;
		uniform half _WIND_BASE_BRANCH_STRENGTH;
		uniform sampler2D _WIND_GUST_TEXTURE;
		uniform half _WIND_GUST_BRANCH_CYCLE_TIME;
		uniform half _WIND_GUST_BRANCH_VARIATION_STRENGTH;
		uniform half _WIND_GUST_BRANCH_FIELD_SIZE;
		uniform half _WIND_GUST_AUDIO_STRENGTH_MID;
		uniform half _WIND_GUST_BRANCH_STRENGTH;
		uniform half _WIND_GUST_BRANCH_STRENGTH_OPPOSITE;
		uniform half _WIND_GUST_BRANCH_STRENGTH_PERPENDICULAR;
		uniform half _WIND_GUST_BRANCH_STRENGTH_PARALLEL;
		uniform half _WIND_LEAF_STRENGTH;
		uniform half _WIND_BASE_LEAF_FIELD_SIZE;
		uniform half _WIND_BASE_LEAF_CYCLE_TIME;
		uniform half _WIND_BASE_LEAF_STRENGTH;
		uniform half _WIND_GUST_LEAF_STRENGTH;
		uniform half _WIND_GUST_AUDIO_STRENGTH_VERYHIGH;
		uniform half _WIND_GUST_LEAF_FIELD_SIZE;
		uniform half _WIND_GUST_LEAF_CYCLE_TIME;
		uniform half _WIND_GUST_LEAF_MID_STRENGTH;
		uniform half _WIND_GUST_AUDIO_STRENGTH_HIGH;
		uniform half _WIND_GUST_LEAF_MID_CYCLE_TIME;
		uniform half _WIND_GUST_LEAF_MID_FIELD_SIZE;
		uniform half _WIND_GUST_LEAF_MICRO_STRENGTH;
		uniform half _WIND_GUST_LEAF_MICRO_CYCLE_TIME;
		uniform half _WIND_GUST_LEAF_MICRO_FIELD_SIZE;
		uniform float _GlobalIlluminationAlbedoEffect;
		uniform sampler2D _MetallicGlossMap2;
		uniform sampler2D _MainTex2;
		uniform float4 _MainTex2_ST;
		uniform float _Occlusion2;
		uniform float _SwapLayers;
		uniform sampler2D _MetallicGlossMap3;
		uniform sampler2D _MainTex3;
		uniform float4 _MainTex3_ST;
		uniform half _Occlusion3;
		uniform sampler2D _MetallicGlossMap;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform half _TrunkVariation;
		uniform half _Occlusion;
		uniform half _BlendAmount;
		uniform half _BlendVariation;
		uniform half _BlendHeight;
		uniform half _BlendFade;
		uniform half _BlendFadeRatio;
		uniform float _BaseHeightRange;
		uniform float _CoverHeightRange;
		uniform float _BaseHeightOffset;
		uniform float _CoverHeightOffset;
		uniform float _HeightBlendContrast;
		uniform half _VertexOcclusionContrast;
		uniform half _VertexOcclusion;
		uniform float4x4 _OcclusionProbesWorldToLocal;
		uniform sampler3D _OcclusionProbes;
		uniform float4 _OcclusionProbes_ST;
		uniform float _AOProbeStrength;
		uniform float _OCCLUSION_PROBE_GLOBAL;
		uniform float _AOIndirect;
		uniform float _AODirect;
		uniform half4 _BreakColorContrast;
		uniform float _CoverSaturation;
		uniform float _CoverBrightness;
		uniform float _Saturation;
		uniform float _Brightness;
		uniform half4 _Color3;
		uniform half4 _Color;
		uniform half4 _Color9;
		uniform float _TrunkFadeStrength;
		uniform sampler2D _Map2;
		uniform float4 _BreakColorSapwood;
		uniform float4 _BreakColorHeartwood;
		uniform float _GlobalIlluminationEmissiveEffect;
		uniform half _BumpScale2;
		uniform sampler2D _BumpMap2;
		uniform half _BumpScale3;
		uniform sampler2D _BumpMap3;
		uniform half _BumpScale;
		uniform sampler2D _BumpMap;
		uniform half _BlendNormals;
		uniform float _Glossiness2;
		uniform half _Glossiness3;
		uniform half _Glossiness;


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


		void vertexDataFunc( inout appdata_full_custom v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float WIND_TRUNK_STRENGTH1235_g23919 = _WIND_TRUNK_STRENGTH;
			half localunity_ObjectToWorld0w1_g23998 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g23998 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g23998 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g23998 = (float3(localunity_ObjectToWorld0w1_g23998 , localunity_ObjectToWorld1w2_g23998 , localunity_ObjectToWorld2w3_g23998));
			float3 WIND_POSITION_OBJECT1195_g23919 = appendResult6_g23998;
			float2 temp_output_1_0_g23959 = (WIND_POSITION_OBJECT1195_g23919).xz;
			float WIND_BASE_TRUNK_FIELD_SIZE1238_g23919 = _WIND_BASE_TRUNK_FIELD_SIZE;
			float2 temp_cast_0 = (( 1.0 / (( WIND_BASE_TRUNK_FIELD_SIZE1238_g23919 == 0.0 ) ? 1.0 :  WIND_BASE_TRUNK_FIELD_SIZE1238_g23919 ) )).xx;
			float2 temp_output_2_0_g23959 = temp_cast_0;
			float2 temp_output_3_0_g23959 = float2( 0,0 );
			float2 temp_output_704_0_g23947 = ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g23959 / temp_output_2_0_g23959 ) :  ( temp_output_1_0_g23959 * temp_output_2_0_g23959 ) ) + temp_output_3_0_g23959 );
			float WIND_BASE_TRUNK_FREQUENCY1237_g23919 = ( 1.0 / (( _WIND_BASE_TRUNK_CYCLE_TIME == 0.0 ) ? 1.0 :  _WIND_BASE_TRUNK_CYCLE_TIME ) );
			float2 temp_output_721_0_g23947 = (WIND_BASE_TRUNK_FREQUENCY1237_g23919).xx;
			float2 break298_g23949 = ( temp_output_704_0_g23947 + ( temp_output_721_0_g23947 * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g23949 = (float2(sin( break298_g23949.x ) , cos( break298_g23949.y )));
			float4 temp_output_273_0_g23949 = (-1.0).xxxx;
			float4 temp_output_271_0_g23949 = (1.0).xxxx;
			float2 clampResult26_g23949 = clamp( appendResult299_g23949 , temp_output_273_0_g23949.xy , temp_output_271_0_g23949.xy );
			float WIND_BASE_AMPLITUDE1197_g23919 = _WIND_BASE_AMPLITUDE;
			float WIND_BASE_TRUNK_STRENGTH1236_g23919 = _WIND_BASE_TRUNK_STRENGTH;
			float2 temp_output_720_0_g23947 = (( WIND_BASE_AMPLITUDE1197_g23919 * WIND_BASE_TRUNK_STRENGTH1236_g23919 )).xx;
			float2 TRUNK_PIVOT_ROCKING701_g23947 = ( clampResult26_g23949 * temp_output_720_0_g23947 );
			float WIND_PRIMARY_ROLL1202_g23919 = v.color.r;
			float _WIND_PRIMARY_ROLL669_g23947 = WIND_PRIMARY_ROLL1202_g23919;
			float temp_output_54_0_g23948 = ( TRUNK_PIVOT_ROCKING701_g23947 * 0.05 * _WIND_PRIMARY_ROLL669_g23947 ).x;
			float temp_output_72_0_g23948 = cos( temp_output_54_0_g23948 );
			float one_minus_c52_g23948 = ( 1.0 - temp_output_72_0_g23948 );
			float3 break70_g23948 = float3(0,1,0);
			float axis_x25_g23948 = break70_g23948.x;
			float c66_g23948 = temp_output_72_0_g23948;
			float axis_y37_g23948 = break70_g23948.y;
			float axis_z29_g23948 = break70_g23948.z;
			float s67_g23948 = sin( temp_output_54_0_g23948 );
			float3 appendResult83_g23948 = (float3(( ( one_minus_c52_g23948 * axis_x25_g23948 * axis_x25_g23948 ) + c66_g23948 ) , ( ( one_minus_c52_g23948 * axis_x25_g23948 * axis_y37_g23948 ) - ( axis_z29_g23948 * s67_g23948 ) ) , ( ( one_minus_c52_g23948 * axis_z29_g23948 * axis_x25_g23948 ) + ( axis_y37_g23948 * s67_g23948 ) )));
			float3 appendResult81_g23948 = (float3(( ( one_minus_c52_g23948 * axis_x25_g23948 * axis_y37_g23948 ) + ( axis_z29_g23948 * s67_g23948 ) ) , ( ( one_minus_c52_g23948 * axis_y37_g23948 * axis_y37_g23948 ) + c66_g23948 ) , ( ( one_minus_c52_g23948 * axis_y37_g23948 * axis_z29_g23948 ) - ( axis_x25_g23948 * s67_g23948 ) )));
			float3 appendResult82_g23948 = (float3(( ( one_minus_c52_g23948 * axis_z29_g23948 * axis_x25_g23948 ) - ( axis_y37_g23948 * s67_g23948 ) ) , ( ( one_minus_c52_g23948 * axis_y37_g23948 * axis_z29_g23948 ) + ( axis_x25_g23948 * s67_g23948 ) ) , ( ( one_minus_c52_g23948 * axis_z29_g23948 * axis_z29_g23948 ) + c66_g23948 )));
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 WIND_PRIMARY_PIVOT1203_g23919 = (v.texcoord1).xyz;
			float3 _WIND_PRIMARY_PIVOT655_g23947 = WIND_PRIMARY_PIVOT1203_g23919;
			float3 temp_output_38_0_g23948 = ( ase_vertex3Pos - (_WIND_PRIMARY_PIVOT655_g23947).xyz );
			float2 break298_g23955 = ( temp_output_704_0_g23947 + ( temp_output_721_0_g23947 * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g23955 = (float2(sin( break298_g23955.x ) , cos( break298_g23955.y )));
			float4 temp_output_273_0_g23955 = (-1.0).xxxx;
			float4 temp_output_271_0_g23955 = (1.0).xxxx;
			float2 clampResult26_g23955 = clamp( appendResult299_g23955 , temp_output_273_0_g23955.xy , temp_output_271_0_g23955.xy );
			float2 TRUNK_SWIRL700_g23947 = ( clampResult26_g23955 * temp_output_720_0_g23947 );
			float2 break699_g23947 = TRUNK_SWIRL700_g23947;
			float3 appendResult698_g23947 = (float3(break699_g23947.x , 0.0 , break699_g23947.y));
			float3 temp_output_694_0_g23947 = ( ( mul( float3x3(appendResult83_g23948, appendResult81_g23948, appendResult82_g23948), temp_output_38_0_g23948 ) - temp_output_38_0_g23948 ) + ( _WIND_PRIMARY_ROLL669_g23947 * appendResult698_g23947 * 0.5 ) );
			float lerpResult632_g23960 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH , _WIND_AUDIO_INFLUENCE);
			float WIND_GUST_AUDIO_STRENGTH1242_g23919 = lerpResult632_g23960;
			float temp_output_15_0_g24004 = WIND_GUST_AUDIO_STRENGTH1242_g23919;
			float lerpResult635_g23960 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_LOW , _WIND_AUDIO_INFLUENCE);
			float WIND_GUST_AUDIO_LOW1246_g23919 = lerpResult635_g23960;
			float temp_output_16_0_g24004 = WIND_GUST_AUDIO_LOW1246_g23919;
			float WIND_GUST_TRUNK_STRENGTH1240_g23919 = _WIND_GUST_TRUNK_STRENGTH;
			float4 color658_g23935 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float WIND_GUST_TRUNK_CYCLE_TIME1241_g23919 = _WIND_GUST_TRUNK_CYCLE_TIME;
			float2 temp_cast_6 = (( 1.0 / (( WIND_GUST_TRUNK_CYCLE_TIME1241_g23919 == 0.0 ) ? 1.0 :  WIND_GUST_TRUNK_CYCLE_TIME1241_g23919 ) )).xx;
			float2 temp_output_61_0_g23939 = float2( 0,0 );
			float2 temp_output_1_0_g23940 = (WIND_POSITION_OBJECT1195_g23919).xz;
			float WIND_GUST_TRUNK_FIELD_SIZE1239_g23919 = _WIND_GUST_TRUNK_FIELD_SIZE;
			float temp_output_40_0_g23939 = ( 1.0 / (( WIND_GUST_TRUNK_FIELD_SIZE1239_g23919 == 0.0 ) ? 1.0 :  WIND_GUST_TRUNK_FIELD_SIZE1239_g23919 ) );
			float2 temp_cast_7 = (temp_output_40_0_g23939).xx;
			float2 temp_output_2_0_g23940 = temp_cast_7;
			float2 temp_output_3_0_g23940 = temp_output_61_0_g23939;
			float2 panner90_g23939 = ( _Time.y * temp_cast_6 + ( (( temp_output_61_0_g23939 > float2( 0,0 ) ) ? ( temp_output_1_0_g23940 / temp_output_2_0_g23940 ) :  ( temp_output_1_0_g23940 * temp_output_2_0_g23940 ) ) + temp_output_3_0_g23940 ));
			float temp_output_679_0_g23935 = 1.0;
			float4 temp_cast_8 = (temp_output_679_0_g23935).xxxx;
			float4 temp_output_52_0_g23939 = saturate( pow( tex2Dlod( _WIND_GUST_TEXTURE, float4( panner90_g23939, 0, 0.0) ) , temp_cast_8 ) );
			float4 lerpResult656_g23935 = lerp( color658_g23935 , temp_output_52_0_g23939 , temp_output_679_0_g23935);
			float4 break655_g23935 = lerpResult656_g23935;
			float4 _Vector0 = float4(0,0,0,0);
			float4 _Vector1 = float4(1,1,1,1);
			float _TRUNK1350_g23919 = ( ( ( temp_output_15_0_g24004 + temp_output_16_0_g24004 ) / 2.0 ) * WIND_GUST_TRUNK_STRENGTH1240_g23919 * (-0.45 + (( 1.0 - break655_g23935.b ) - _Vector0.x) * (1.0 - -0.45) / (_Vector1.x - _Vector0.x)) );
			float _WIND_GUST_STRENGTH703_g23947 = _TRUNK1350_g23919;
			float WIND_PRIMARY_BEND1204_g23919 = v.texcoord1.w;
			float _WIND_PRIMARY_BEND662_g23947 = WIND_PRIMARY_BEND1204_g23919;
			float temp_output_54_0_g23954 = ( -_WIND_GUST_STRENGTH703_g23947 * _WIND_PRIMARY_BEND662_g23947 );
			float temp_output_72_0_g23954 = cos( temp_output_54_0_g23954 );
			float one_minus_c52_g23954 = ( 1.0 - temp_output_72_0_g23954 );
			float3 WIND_DIRECTION1192_g23919 = _WIND_DIRECTION;
			float3 _WIND_DIRECTION671_g23947 = WIND_DIRECTION1192_g23919;
			float3 worldToObjDir719_g23947 = mul( unity_WorldToObject, float4( cross( _WIND_DIRECTION671_g23947 , float3(0,1,0) ), 0 ) ).xyz;
			float3 break70_g23954 = worldToObjDir719_g23947;
			float axis_x25_g23954 = break70_g23954.x;
			float c66_g23954 = temp_output_72_0_g23954;
			float axis_y37_g23954 = break70_g23954.y;
			float axis_z29_g23954 = break70_g23954.z;
			float s67_g23954 = sin( temp_output_54_0_g23954 );
			float3 appendResult83_g23954 = (float3(( ( one_minus_c52_g23954 * axis_x25_g23954 * axis_x25_g23954 ) + c66_g23954 ) , ( ( one_minus_c52_g23954 * axis_x25_g23954 * axis_y37_g23954 ) - ( axis_z29_g23954 * s67_g23954 ) ) , ( ( one_minus_c52_g23954 * axis_z29_g23954 * axis_x25_g23954 ) + ( axis_y37_g23954 * s67_g23954 ) )));
			float3 appendResult81_g23954 = (float3(( ( one_minus_c52_g23954 * axis_x25_g23954 * axis_y37_g23954 ) + ( axis_z29_g23954 * s67_g23954 ) ) , ( ( one_minus_c52_g23954 * axis_y37_g23954 * axis_y37_g23954 ) + c66_g23954 ) , ( ( one_minus_c52_g23954 * axis_y37_g23954 * axis_z29_g23954 ) - ( axis_x25_g23954 * s67_g23954 ) )));
			float3 appendResult82_g23954 = (float3(( ( one_minus_c52_g23954 * axis_z29_g23954 * axis_x25_g23954 ) - ( axis_y37_g23954 * s67_g23954 ) ) , ( ( one_minus_c52_g23954 * axis_y37_g23954 * axis_z29_g23954 ) + ( axis_x25_g23954 * s67_g23954 ) ) , ( ( one_minus_c52_g23954 * axis_z29_g23954 * axis_z29_g23954 ) + c66_g23954 )));
			float3 temp_output_38_0_g23954 = ( ase_vertex3Pos - (_WIND_PRIMARY_PIVOT655_g23947).xyz );
			float3 lerpResult538_g23947 = lerp( temp_output_694_0_g23947 , ( temp_output_694_0_g23947 + ( mul( float3x3(appendResult83_g23954, appendResult81_g23954, appendResult82_g23954), temp_output_38_0_g23954 ) - temp_output_38_0_g23954 ) ) , WIND_GUST_AUDIO_STRENGTH1242_g23919);
			float3 MOTION_TRUNK1337_g23919 = lerpResult538_g23947;
			float WIND_BRANCH_STRENGTH1224_g23919 = _WIND_BRANCH_STRENGTH;
			float3 _WIND_POSITION_ROOT1002_g24030 = WIND_POSITION_OBJECT1195_g23919;
			float2 temp_output_1_0_g24046 = (_WIND_POSITION_ROOT1002_g24030).xz;
			float WIND_BASE_BRANCH_FIELD_SIZE1218_g23919 = _WIND_BASE_BRANCH_FIELD_SIZE;
			float _WIND_BASE_BRANCH_FIELD_SIZE1004_g24030 = WIND_BASE_BRANCH_FIELD_SIZE1218_g23919;
			float2 temp_cast_11 = (( 1.0 / (( _WIND_BASE_BRANCH_FIELD_SIZE1004_g24030 == 0.0 ) ? 1.0 :  _WIND_BASE_BRANCH_FIELD_SIZE1004_g24030 ) )).xx;
			float2 temp_output_2_0_g24046 = temp_cast_11;
			float temp_output_587_552_g23982 = v.color.a;
			float WIND_PHASE1212_g23919 = temp_output_587_552_g23982;
			float _WIND_PHASE852_g24030 = WIND_PHASE1212_g23919;
			float WIND_BASE_BRANCH_VARIATION_STRENGTH1219_g23919 = _WIND_BASE_BRANCH_VARIATION_STRENGTH;
			float _WIND_BASE_BRANCH_VARIATION_STRENGTH1006_g24030 = WIND_BASE_BRANCH_VARIATION_STRENGTH1219_g23919;
			float2 temp_cast_12 = (( ( _WIND_PHASE852_g24030 * _WIND_BASE_BRANCH_VARIATION_STRENGTH1006_g24030 ) * UNITY_PI )).xx;
			float2 temp_output_3_0_g24046 = temp_cast_12;
			float WIND_BASE_BRANCH_FREQUENCY1217_g23919 = ( 1.0 / (( _WIND_BASE_BRANCH_CYCLE_TIME == 0.0 ) ? 1.0 :  _WIND_BASE_BRANCH_CYCLE_TIME ) );
			float2 break298_g24047 = ( ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g24046 / temp_output_2_0_g24046 ) :  ( temp_output_1_0_g24046 * temp_output_2_0_g24046 ) ) + temp_output_3_0_g24046 ) + ( (( WIND_BASE_BRANCH_FREQUENCY1217_g23919 * _WIND_PHASE852_g24030 )).xx * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g24047 = (float2(sin( break298_g24047.x ) , cos( break298_g24047.y )));
			float4 temp_output_273_0_g24047 = (-1.0).xxxx;
			float4 temp_output_271_0_g24047 = (1.0).xxxx;
			float2 clampResult26_g24047 = clamp( appendResult299_g24047 , temp_output_273_0_g24047.xy , temp_output_271_0_g24047.xy );
			float WIND_BASE_BRANCH_STRENGTH1227_g23919 = _WIND_BASE_BRANCH_STRENGTH;
			float2 BRANCH_SWIRL931_g24030 = ( clampResult26_g24047 * (( WIND_BASE_AMPLITUDE1197_g23919 * WIND_BASE_BRANCH_STRENGTH1227_g23919 )).xx );
			float2 break932_g24030 = BRANCH_SWIRL931_g24030;
			float3 appendResult933_g24030 = (float3(break932_g24030.x , 0.0 , break932_g24030.y));
			float WIND_SECONDARY_ROLL1205_g23919 = v.color.g;
			float _WIND_SECONDARY_ROLL650_g24030 = WIND_SECONDARY_ROLL1205_g23919;
			float3 VALUE_ROLL1034_g24030 = ( appendResult933_g24030 * _WIND_SECONDARY_ROLL650_g24030 * 0.5 );
			float3 _WIND_DIRECTION856_g24030 = WIND_DIRECTION1192_g23919;
			float3 WIND_SECONDARY_GROWTH_DIRECTION1208_g23919 = (v.texcoord2).xyz;
			float3 temp_output_839_0_g24030 = WIND_SECONDARY_GROWTH_DIRECTION1208_g23919;
			float3 _WIND_SECONDARY_GROWTH_DIRECTION = float3(0,1,0);
			float3 objToWorldDir1174_g24030 = mul( unity_ObjectToWorld, float4( (( length( temp_output_839_0_g24030 ) == 0.0 ) ? _WIND_SECONDARY_GROWTH_DIRECTION :  temp_output_839_0_g24030 ), 0 ) ).xyz;
			float3 _WIND_SECONDARY_GROWTH_DIRECTION840_g24030 = (objToWorldDir1174_g24030).xyz;
			float dotResult565_g24030 = dot( _WIND_DIRECTION856_g24030 , _WIND_SECONDARY_GROWTH_DIRECTION840_g24030 );
			float clampResult13_g24039 = clamp( dotResult565_g24030 , -1.0 , 1.0 );
			float4 color658_g23929 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float WIND_GUST_BRANCH_CYCLE_TIME1220_g23919 = _WIND_GUST_BRANCH_CYCLE_TIME;
			float clampResult3_g23991 = clamp( temp_output_587_552_g23982 , 0.0 , 1.0 );
			float WIND_PHASE_UNPACKED1530_g23919 = ( ( clampResult3_g23991 * 2.0 ) - 1.0 );
			float2 temp_cast_15 = (( 1.0 / (( ( WIND_GUST_BRANCH_CYCLE_TIME1220_g23919 + ( WIND_GUST_BRANCH_CYCLE_TIME1220_g23919 * WIND_PHASE_UNPACKED1530_g23919 * 0.1 ) ) == 0.0 ) ? 1.0 :  ( WIND_GUST_BRANCH_CYCLE_TIME1220_g23919 + ( WIND_GUST_BRANCH_CYCLE_TIME1220_g23919 * WIND_PHASE_UNPACKED1530_g23919 * 0.1 ) ) ) )).xx;
			float2 temp_output_61_0_g23933 = float2( 0,0 );
			float3 WIND_SECONDARY_PIVOT1206_g23919 = (v.texcoord3).xyz;
			float WIND_GUST_BRANCH_VARIATION_STRENGTH1223_g23919 = _WIND_GUST_BRANCH_VARIATION_STRENGTH;
			float2 temp_output_1_0_g23934 = ( (WIND_POSITION_OBJECT1195_g23919).xz + (WIND_SECONDARY_PIVOT1206_g23919).xy + ( WIND_PHASE1212_g23919 * WIND_GUST_BRANCH_VARIATION_STRENGTH1223_g23919 ) );
			float WIND_GUST_BRANCH_FIELD_SIZE1222_g23919 = _WIND_GUST_BRANCH_FIELD_SIZE;
			float temp_output_40_0_g23933 = ( 1.0 / (( WIND_GUST_BRANCH_FIELD_SIZE1222_g23919 == 0.0 ) ? 1.0 :  WIND_GUST_BRANCH_FIELD_SIZE1222_g23919 ) );
			float2 temp_cast_16 = (temp_output_40_0_g23933).xx;
			float2 temp_output_2_0_g23934 = temp_cast_16;
			float2 temp_output_3_0_g23934 = temp_output_61_0_g23933;
			float2 panner90_g23933 = ( _Time.y * temp_cast_15 + ( (( temp_output_61_0_g23933 > float2( 0,0 ) ) ? ( temp_output_1_0_g23934 / temp_output_2_0_g23934 ) :  ( temp_output_1_0_g23934 * temp_output_2_0_g23934 ) ) + temp_output_3_0_g23934 ));
			float temp_output_679_0_g23929 = 1.0;
			float4 temp_cast_17 = (temp_output_679_0_g23929).xxxx;
			float4 temp_output_52_0_g23933 = saturate( pow( tex2Dlod( _WIND_GUST_TEXTURE, float4( panner90_g23933, 0, 0.0) ) , temp_cast_17 ) );
			float4 lerpResult656_g23929 = lerp( color658_g23929 , temp_output_52_0_g23933 , temp_output_679_0_g23929);
			float4 break655_g23929 = lerpResult656_g23929;
			float temp_output_15_0_g23996 = break655_g23929.r;
			float temp_output_16_0_g23996 = ( 1.0 - break655_g23929.b );
			float temp_output_15_0_g24009 = WIND_GUST_AUDIO_STRENGTH1242_g23919;
			float lerpResult634_g23960 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_MID , _WIND_AUDIO_INFLUENCE);
			float WIND_GUST_AUDIO_MID1245_g23919 = lerpResult634_g23960;
			float temp_output_16_0_g24009 = WIND_GUST_AUDIO_MID1245_g23919;
			float temp_output_1516_14_g23919 = ( ( temp_output_15_0_g24009 + temp_output_16_0_g24009 ) / 2.0 );
			float WIND_GUST_BRANCH_STRENGTH1229_g23919 = _WIND_GUST_BRANCH_STRENGTH;
			float WIND_GUST_BRANCH_STRENGTH_OPPOSITE1573_g23919 = _WIND_GUST_BRANCH_STRENGTH_OPPOSITE;
			float _BRANCH_OPPOSITE_DOWN1466_g23919 = ( (-0.1 + (( ( temp_output_15_0_g23996 + temp_output_16_0_g23996 ) / 2.0 ) - _Vector0.x) * (0.75 - -0.1) / (_Vector1.x - _Vector0.x)) * temp_output_1516_14_g23919 * WIND_GUST_BRANCH_STRENGTH1229_g23919 * WIND_GUST_BRANCH_STRENGTH_OPPOSITE1573_g23919 );
			float _GUST_STRENGTH_OPPOSITE_DOWN1188_g24030 = _BRANCH_OPPOSITE_DOWN1466_g23919;
			float temp_output_15_0_g23979 = ( 1.0 - break655_g23929.g );
			float temp_output_16_0_g23979 = break655_g23929.a;
			float _BRANCH_OPPOSITE_UP1348_g23919 = ( (-0.3 + (( ( temp_output_15_0_g23979 + temp_output_16_0_g23979 ) / 2.0 ) - _Vector0.x) * (1.0 - -0.3) / (_Vector1.x - _Vector0.x)) * temp_output_1516_14_g23919 * WIND_GUST_BRANCH_STRENGTH1229_g23919 * WIND_GUST_BRANCH_STRENGTH_OPPOSITE1573_g23919 );
			float _GUST_STRENGTH_OPPOSITE_UP871_g24030 = _BRANCH_OPPOSITE_UP1348_g23919;
			float dotResult1180_g24030 = dot( _WIND_SECONDARY_GROWTH_DIRECTION840_g24030 , float3(0,1,0) );
			float clampResult8_g24052 = clamp( dotResult1180_g24030 , -1.0 , 1.0 );
			float _WIND_SECONDARY_VERTICALITY843_g24030 = ( ( clampResult8_g24052 * 0.5 ) + 0.5 );
			float temp_output_2_0_g24054 = _WIND_SECONDARY_VERTICALITY843_g24030;
			float temp_output_3_0_g24054 = 0.5;
			float temp_output_21_0_g24054 = 1.0;
			float temp_output_26_0_g24054 = 0.0;
			float lerpResult1_g24058 = lerp( _GUST_STRENGTH_OPPOSITE_DOWN1188_g24030 , -_GUST_STRENGTH_OPPOSITE_UP871_g24030 , saturate( saturate( (( temp_output_2_0_g24054 >= temp_output_3_0_g24054 ) ? temp_output_21_0_g24054 :  temp_output_26_0_g24054 ) ) ));
			float WIND_SECONDARY_BEND1207_g23919 = v.texcoord3.w;
			float _WIND_SECONDARY_BEND849_g24030 = WIND_SECONDARY_BEND1207_g23919;
			float clampResult1170_g24030 = clamp( _WIND_SECONDARY_BEND849_g24030 , 0.0 , 0.75 );
			float clampResult1175_g24030 = clamp( ( lerpResult1_g24058 * clampResult1170_g24030 ) , -1.5 , 1.5 );
			float temp_output_54_0_g24036 = clampResult1175_g24030;
			float temp_output_72_0_g24036 = cos( temp_output_54_0_g24036 );
			float one_minus_c52_g24036 = ( 1.0 - temp_output_72_0_g24036 );
			float3 worldToObjDir1173_g24030 = mul( unity_WorldToObject, float4( cross( _WIND_DIRECTION856_g24030 , float3(0,1,0) ), 0 ) ).xyz;
			float3 break70_g24036 = worldToObjDir1173_g24030;
			float axis_x25_g24036 = break70_g24036.x;
			float c66_g24036 = temp_output_72_0_g24036;
			float axis_y37_g24036 = break70_g24036.y;
			float axis_z29_g24036 = break70_g24036.z;
			float s67_g24036 = sin( temp_output_54_0_g24036 );
			float3 appendResult83_g24036 = (float3(( ( one_minus_c52_g24036 * axis_x25_g24036 * axis_x25_g24036 ) + c66_g24036 ) , ( ( one_minus_c52_g24036 * axis_x25_g24036 * axis_y37_g24036 ) - ( axis_z29_g24036 * s67_g24036 ) ) , ( ( one_minus_c52_g24036 * axis_z29_g24036 * axis_x25_g24036 ) + ( axis_y37_g24036 * s67_g24036 ) )));
			float3 appendResult81_g24036 = (float3(( ( one_minus_c52_g24036 * axis_x25_g24036 * axis_y37_g24036 ) + ( axis_z29_g24036 * s67_g24036 ) ) , ( ( one_minus_c52_g24036 * axis_y37_g24036 * axis_y37_g24036 ) + c66_g24036 ) , ( ( one_minus_c52_g24036 * axis_y37_g24036 * axis_z29_g24036 ) - ( axis_x25_g24036 * s67_g24036 ) )));
			float3 appendResult82_g24036 = (float3(( ( one_minus_c52_g24036 * axis_z29_g24036 * axis_x25_g24036 ) - ( axis_y37_g24036 * s67_g24036 ) ) , ( ( one_minus_c52_g24036 * axis_y37_g24036 * axis_z29_g24036 ) + ( axis_x25_g24036 * s67_g24036 ) ) , ( ( one_minus_c52_g24036 * axis_z29_g24036 * axis_z29_g24036 ) + c66_g24036 )));
			float3 _WIND_SECONDARY_PIVOT846_g24030 = WIND_SECONDARY_PIVOT1206_g23919;
			float3 temp_output_38_0_g24036 = ( ase_vertex3Pos - (_WIND_SECONDARY_PIVOT846_g24030).xyz );
			float3 VALUE_FACING_WIND1042_g24030 = ( mul( float3x3(appendResult83_g24036, appendResult81_g24036, appendResult82_g24036), temp_output_38_0_g24036 ) - temp_output_38_0_g24036 );
			float2 temp_output_1_0_g24031 = (_WIND_SECONDARY_PIVOT846_g24030).xz;
			float _WIND_GUST_BRANCH_FIELD_SIZE1011_g24030 = WIND_GUST_BRANCH_FIELD_SIZE1222_g23919;
			float2 temp_cast_22 = (( 1.0 / (( _WIND_GUST_BRANCH_FIELD_SIZE1011_g24030 == 0.0 ) ? 1.0 :  _WIND_GUST_BRANCH_FIELD_SIZE1011_g24030 ) )).xx;
			float2 temp_output_2_0_g24031 = temp_cast_22;
			float _WIND_GUST_BRANCH_VARIATION_STRENGTH1008_g24030 = WIND_GUST_BRANCH_VARIATION_STRENGTH1223_g23919;
			float2 temp_cast_23 = (( ( _WIND_PHASE852_g24030 * _WIND_GUST_BRANCH_VARIATION_STRENGTH1008_g24030 ) * UNITY_PI )).xx;
			float2 temp_output_3_0_g24031 = temp_cast_23;
			float WIND_GUST_BRANCH_FREQUENCY1221_g23919 = ( 1.0 / (( _WIND_GUST_BRANCH_CYCLE_TIME == 0.0 ) ? 1.0 :  _WIND_GUST_BRANCH_CYCLE_TIME ) );
			float _WIND_GUST_BRANCH_FREQUENCY1012_g24030 = WIND_GUST_BRANCH_FREQUENCY1221_g23919;
			float2 break298_g24032 = ( ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g24031 / temp_output_2_0_g24031 ) :  ( temp_output_1_0_g24031 * temp_output_2_0_g24031 ) ) + temp_output_3_0_g24031 ) + ( (_WIND_GUST_BRANCH_FREQUENCY1012_g24030).xx * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g24032 = (float2(sin( break298_g24032.x ) , cos( break298_g24032.y )));
			float4 temp_output_273_0_g24032 = (-1.0).xxxx;
			float4 temp_output_271_0_g24032 = (1.0).xxxx;
			float2 clampResult26_g24032 = clamp( appendResult299_g24032 , temp_output_273_0_g24032.xy , temp_output_271_0_g24032.xy );
			float2 break305_g24032 = float2( -0.25,1 );
			float temp_output_15_0_g23995 = ( 1.0 - break655_g23929.r );
			float temp_output_16_0_g23995 = break655_g23929.g;
			float WIND_GUST_BRANCH_STRENGTH_PERPENDICULAR1574_g23919 = _WIND_GUST_BRANCH_STRENGTH_PERPENDICULAR;
			float _BRANCH_PERPENDICULAR1431_g23919 = ( (-0.1 + (( ( temp_output_15_0_g23995 + temp_output_16_0_g23995 ) / 2.0 ) - _Vector0.x) * (0.9 - -0.1) / (_Vector1.x - _Vector0.x)) * temp_output_1516_14_g23919 * WIND_GUST_BRANCH_STRENGTH1229_g23919 * WIND_GUST_BRANCH_STRENGTH_PERPENDICULAR1574_g23919 );
			float _GUST_STRENGTH_PERPENDICULAR999_g24030 = _BRANCH_PERPENDICULAR1431_g23919;
			float2 break1067_g24030 = ( ( ((break305_g24032.x).xxxx.xy + (clampResult26_g24032 - temp_output_273_0_g24032.xy) * ((break305_g24032.y).xxxx.xy - (break305_g24032.x).xxxx.xy) / (temp_output_271_0_g24032.xy - temp_output_273_0_g24032.xy)) * (_GUST_STRENGTH_PERPENDICULAR999_g24030).xx ) * _WIND_SECONDARY_ROLL650_g24030 );
			float3 appendResult1066_g24030 = (float3(break1067_g24030.x , 0.0 , break1067_g24030.y));
			float3 worldToObjDir1089_g24030 = normalize( mul( unity_WorldToObject, float4( _WIND_DIRECTION856_g24030, 0 ) ).xyz );
			float3 BRANCH_SWIRL972_g24030 = ( appendResult1066_g24030 * worldToObjDir1089_g24030 );
			float3 VALUE_PERPENDICULAR1041_g24030 = BRANCH_SWIRL972_g24030;
			float3 temp_output_3_0_g24039 = VALUE_PERPENDICULAR1041_g24030;
			float3 lerpResult1_g24045 = lerp( VALUE_FACING_WIND1042_g24030 , temp_output_3_0_g24039 , saturate( ( 1.0 + clampResult13_g24039 ) ));
			float temp_output_15_0_g23922 = break655_g23929.b;
			float temp_output_16_0_g23922 = ( 1.0 - break655_g23929.a );
			float clampResult3_g23980 = clamp( ( ( temp_output_15_0_g23922 + temp_output_16_0_g23922 ) / 2.0 ) , 0.0 , 1.0 );
			float WIND_GUST_BRANCH_STRENGTH_PARALLEL1575_g23919 = _WIND_GUST_BRANCH_STRENGTH_PARALLEL;
			float _BRANCH_PARALLEL1432_g23919 = ( ( ( clampResult3_g23980 * 2.0 ) - 1.0 ) * temp_output_1516_14_g23919 * WIND_GUST_BRANCH_STRENGTH1229_g23919 * WIND_GUST_BRANCH_STRENGTH_PARALLEL1575_g23919 );
			float _GUST_STRENGTH_PARALLEL1110_g24030 = _BRANCH_PARALLEL1432_g23919;
			float clampResult1167_g24030 = clamp( ( _GUST_STRENGTH_PARALLEL1110_g24030 * _WIND_SECONDARY_BEND849_g24030 ) , -1.5 , 1.5 );
			float temp_output_54_0_g24037 = clampResult1167_g24030;
			float temp_output_72_0_g24037 = cos( temp_output_54_0_g24037 );
			float one_minus_c52_g24037 = ( 1.0 - temp_output_72_0_g24037 );
			float3 break70_g24037 = float3(0,1,0);
			float axis_x25_g24037 = break70_g24037.x;
			float c66_g24037 = temp_output_72_0_g24037;
			float axis_y37_g24037 = break70_g24037.y;
			float axis_z29_g24037 = break70_g24037.z;
			float s67_g24037 = sin( temp_output_54_0_g24037 );
			float3 appendResult83_g24037 = (float3(( ( one_minus_c52_g24037 * axis_x25_g24037 * axis_x25_g24037 ) + c66_g24037 ) , ( ( one_minus_c52_g24037 * axis_x25_g24037 * axis_y37_g24037 ) - ( axis_z29_g24037 * s67_g24037 ) ) , ( ( one_minus_c52_g24037 * axis_z29_g24037 * axis_x25_g24037 ) + ( axis_y37_g24037 * s67_g24037 ) )));
			float3 appendResult81_g24037 = (float3(( ( one_minus_c52_g24037 * axis_x25_g24037 * axis_y37_g24037 ) + ( axis_z29_g24037 * s67_g24037 ) ) , ( ( one_minus_c52_g24037 * axis_y37_g24037 * axis_y37_g24037 ) + c66_g24037 ) , ( ( one_minus_c52_g24037 * axis_y37_g24037 * axis_z29_g24037 ) - ( axis_x25_g24037 * s67_g24037 ) )));
			float3 appendResult82_g24037 = (float3(( ( one_minus_c52_g24037 * axis_z29_g24037 * axis_x25_g24037 ) - ( axis_y37_g24037 * s67_g24037 ) ) , ( ( one_minus_c52_g24037 * axis_y37_g24037 * axis_z29_g24037 ) + ( axis_x25_g24037 * s67_g24037 ) ) , ( ( one_minus_c52_g24037 * axis_z29_g24037 * axis_z29_g24037 ) + c66_g24037 )));
			float3 temp_output_38_0_g24037 = ( ase_vertex3Pos - (_WIND_SECONDARY_PIVOT846_g24030).xyz );
			float3 VALUE_AWAY_FROM_WIND1040_g24030 = ( mul( float3x3(appendResult83_g24037, appendResult81_g24037, appendResult82_g24037), temp_output_38_0_g24037 ) - temp_output_38_0_g24037 );
			float3 lerpResult1_g24040 = lerp( temp_output_3_0_g24039 , VALUE_AWAY_FROM_WIND1040_g24030 , saturate( clampResult13_g24039 ));
			float3 lerpResult631_g24030 = lerp( VALUE_ROLL1034_g24030 , (( clampResult13_g24039 < 0.0 ) ? lerpResult1_g24045 :  lerpResult1_g24040 ) , WIND_GUST_AUDIO_STRENGTH1242_g23919);
			float3 MOTION_BRANCH1339_g23919 = lerpResult631_g24030;
			float WIND_LEAF_STRENGTH1179_g23919 = _WIND_LEAF_STRENGTH;
			float temp_output_17_0_g23975 = 3.0;
			float TYPE_DESIGNATOR1209_g23919 = round( v.texcoord2.w );
			float temp_output_18_0_g23975 = TYPE_DESIGNATOR1209_g23919;
			float WIND_TERTIARY_ROLL1210_g23919 = v.color.b;
			float _WIND_TERTIARY_ROLL669_g24010 = WIND_TERTIARY_ROLL1210_g23919;
			float3 temp_output_615_0_g23997 = ( float3( 0,0,0 ) + ase_vertex3Pos );
			float3 WIND_POSITION_VERTEX_OBJECT1193_g23919 = temp_output_615_0_g23997;
			float2 temp_output_1_0_g24011 = (WIND_POSITION_VERTEX_OBJECT1193_g23919).xz;
			float WIND_BASE_LEAF_FIELD_SIZE1182_g23919 = _WIND_BASE_LEAF_FIELD_SIZE;
			float2 temp_output_2_0_g24011 = (WIND_BASE_LEAF_FIELD_SIZE1182_g23919).xx;
			float _WIND_VARIATION662_g24010 = WIND_PHASE1212_g23919;
			float2 temp_output_3_0_g24011 = (_WIND_VARIATION662_g24010).xx;
			float2 temp_output_704_0_g24010 = ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g24011 / temp_output_2_0_g24011 ) :  ( temp_output_1_0_g24011 * temp_output_2_0_g24011 ) ) + temp_output_3_0_g24011 );
			float WIND_BASE_LEAF_FREQUENCY1264_g23919 = ( 1.0 / (( _WIND_BASE_LEAF_CYCLE_TIME == 0.0 ) ? 1.0 :  _WIND_BASE_LEAF_CYCLE_TIME ) );
			float temp_output_618_0_g24010 = WIND_BASE_LEAF_FREQUENCY1264_g23919;
			float2 break298_g24012 = ( temp_output_704_0_g24010 + ( (temp_output_618_0_g24010).xx * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g24012 = (float2(sin( break298_g24012.x ) , cos( break298_g24012.y )));
			float4 temp_output_273_0_g24012 = (-1.0).xxxx;
			float4 temp_output_271_0_g24012 = (1.0).xxxx;
			float2 clampResult26_g24012 = clamp( appendResult299_g24012 , temp_output_273_0_g24012.xy , temp_output_271_0_g24012.xy );
			float WIND_BASE_LEAF_STRENGTH1180_g23919 = _WIND_BASE_LEAF_STRENGTH;
			float2 temp_output_1031_0_g24010 = (( WIND_BASE_LEAF_STRENGTH1180_g23919 * WIND_BASE_AMPLITUDE1197_g23919 )).xx;
			float2 break699_g24010 = ( clampResult26_g24012 * temp_output_1031_0_g24010 );
			float2 break298_g24016 = ( temp_output_704_0_g24010 + ( (( 0.71 * temp_output_618_0_g24010 )).xx * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g24016 = (float2(sin( break298_g24016.x ) , cos( break298_g24016.y )));
			float4 temp_output_273_0_g24016 = (-1.0).xxxx;
			float4 temp_output_271_0_g24016 = (1.0).xxxx;
			float2 clampResult26_g24016 = clamp( appendResult299_g24016 , temp_output_273_0_g24016.xy , temp_output_271_0_g24016.xy );
			float3 appendResult698_g24010 = (float3(break699_g24010.x , ( clampResult26_g24016 * temp_output_1031_0_g24010 ).x , break699_g24010.y));
			float3 temp_output_684_0_g24010 = ( _WIND_TERTIARY_ROLL669_g24010 * appendResult698_g24010 );
			float3 _WIND_DIRECTION671_g24010 = WIND_DIRECTION1192_g23919;
			float3 worldToObjDir1006_g24010 = mul( unity_WorldToObject, float4( _WIND_DIRECTION671_g24010, 0 ) ).xyz;
			float WIND_GUST_LEAF_STRENGTH1183_g23919 = _WIND_GUST_LEAF_STRENGTH;
			float lerpResult638_g23960 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_VERYHIGH , _WIND_AUDIO_INFLUENCE);
			float WIND_GUST_AUDIO_VERYHIGH1243_g23919 = lerpResult638_g23960;
			float4 color658_g23964 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float2 temp_output_61_0_g23966 = float2( 0,0 );
			float WIND_VARIATION1211_g23919 = v.texcoord.w;
			half localunity_ObjectToWorld0w1_g23920 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld2w3_g23920 = ( unity_ObjectToWorld[2].w );
			float2 appendResult1374_g23919 = (float2(localunity_ObjectToWorld0w1_g23920 , localunity_ObjectToWorld2w3_g23920));
			float2 temp_output_1_0_g23967 = ( ( 10.0 * WIND_VARIATION1211_g23919 ) + appendResult1374_g23919 );
			float WIND_GUST_LEAF_FIELD_SIZE1185_g23919 = _WIND_GUST_LEAF_FIELD_SIZE;
			float temp_output_40_0_g23966 = ( 1.0 / (( WIND_GUST_LEAF_FIELD_SIZE1185_g23919 == 0.0 ) ? 1.0 :  WIND_GUST_LEAF_FIELD_SIZE1185_g23919 ) );
			float2 temp_cast_37 = (temp_output_40_0_g23966).xx;
			float2 temp_output_2_0_g23967 = temp_cast_37;
			float2 temp_output_3_0_g23967 = temp_output_61_0_g23966;
			float clampResult3_g23976 = clamp( WIND_VARIATION1211_g23919 , 0.0 , 1.0 );
			float WIND_GUST_LEAF_CYCLE_TIME1184_g23919 = _WIND_GUST_LEAF_CYCLE_TIME;
			float mulTime37_g23966 = _Time.y * ( 1.0 / (( ( ( ( ( clampResult3_g23976 * 2.0 ) - 1.0 ) * 0.3 * WIND_GUST_LEAF_CYCLE_TIME1184_g23919 ) + WIND_GUST_LEAF_CYCLE_TIME1184_g23919 ) == 0.0 ) ? 1.0 :  ( ( ( ( clampResult3_g23976 * 2.0 ) - 1.0 ) * 0.3 * WIND_GUST_LEAF_CYCLE_TIME1184_g23919 ) + WIND_GUST_LEAF_CYCLE_TIME1184_g23919 ) ) );
			float temp_output_220_0_g23969 = -1.0;
			float4 temp_cast_38 = (temp_output_220_0_g23969).xxxx;
			float temp_output_219_0_g23969 = 1.0;
			float4 temp_cast_39 = (temp_output_219_0_g23969).xxxx;
			float4 clampResult26_g23969 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g23966 > float2( 0,0 ) ) ? ( temp_output_1_0_g23967 / temp_output_2_0_g23967 ) :  ( temp_output_1_0_g23967 * temp_output_2_0_g23967 ) ) + temp_output_3_0_g23967 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g23966 ) ) , temp_cast_38 , temp_cast_39 );
			float4 temp_cast_40 = (temp_output_220_0_g23969).xxxx;
			float4 temp_cast_41 = (temp_output_219_0_g23969).xxxx;
			float4 temp_cast_42 = (0.0).xxxx;
			float4 temp_cast_43 = (temp_output_219_0_g23969).xxxx;
			float temp_output_679_0_g23964 = 1.0;
			float4 temp_cast_44 = (temp_output_679_0_g23964).xxxx;
			float4 temp_output_52_0_g23966 = saturate( pow( abs( (temp_cast_42 + (clampResult26_g23969 - temp_cast_40) * (temp_cast_43 - temp_cast_42) / (temp_cast_41 - temp_cast_40)) ) , temp_cast_44 ) );
			float4 lerpResult656_g23964 = lerp( color658_g23964 , temp_output_52_0_g23966 , temp_output_679_0_g23964);
			float4 break655_g23964 = lerpResult656_g23964;
			float LEAF_GUST1375_g23919 = ( WIND_GUST_LEAF_STRENGTH1183_g23919 * WIND_GUST_AUDIO_VERYHIGH1243_g23919 * break655_g23964.g );
			float _WIND_GUST_STRENGTH703_g24010 = LEAF_GUST1375_g23919;
			float3 _GUST1018_g24010 = ( worldToObjDir1006_g24010 * _WIND_GUST_STRENGTH703_g24010 );
			float WIND_GUST_LEAF_MID_STRENGTH1186_g23919 = _WIND_GUST_LEAF_MID_STRENGTH;
			float lerpResult633_g23960 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_HIGH , _WIND_AUDIO_INFLUENCE);
			float WIND_GUST_AUDIO_HIGH1244_g23919 = lerpResult633_g23960;
			float4 color658_g23923 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float WIND_GUST_LEAF_MID_CYCLE_TIME1187_g23919 = _WIND_GUST_LEAF_MID_CYCLE_TIME;
			float2 temp_cast_45 = (( 1.0 / (( ( WIND_GUST_LEAF_MID_CYCLE_TIME1187_g23919 + ( WIND_VARIATION1211_g23919 * -0.05 ) ) == 0.0 ) ? 1.0 :  ( WIND_GUST_LEAF_MID_CYCLE_TIME1187_g23919 + ( WIND_VARIATION1211_g23919 * -0.05 ) ) ) )).xx;
			float2 temp_output_61_0_g23927 = float2( 0,0 );
			float2 appendResult1400_g23919 = (float2(ase_vertex3Pos.x , ase_vertex3Pos.z));
			float2 temp_output_1_0_g23928 = ( (WIND_VARIATION1211_g23919).xx + appendResult1400_g23919 );
			float WIND_GUST_LEAF_MID_FIELD_SIZE1188_g23919 = _WIND_GUST_LEAF_MID_FIELD_SIZE;
			float temp_output_40_0_g23927 = ( 1.0 / (( WIND_GUST_LEAF_MID_FIELD_SIZE1188_g23919 == 0.0 ) ? 1.0 :  WIND_GUST_LEAF_MID_FIELD_SIZE1188_g23919 ) );
			float2 temp_cast_46 = (temp_output_40_0_g23927).xx;
			float2 temp_output_2_0_g23928 = temp_cast_46;
			float2 temp_output_3_0_g23928 = temp_output_61_0_g23927;
			float2 panner90_g23927 = ( _Time.y * temp_cast_45 + ( (( temp_output_61_0_g23927 > float2( 0,0 ) ) ? ( temp_output_1_0_g23928 / temp_output_2_0_g23928 ) :  ( temp_output_1_0_g23928 * temp_output_2_0_g23928 ) ) + temp_output_3_0_g23928 ));
			float temp_output_679_0_g23923 = 1.0;
			float4 temp_cast_47 = (temp_output_679_0_g23923).xxxx;
			float4 temp_output_52_0_g23927 = saturate( pow( tex2Dlod( _WIND_GUST_TEXTURE, float4( panner90_g23927, 0, 0.0) ) , temp_cast_47 ) );
			float4 lerpResult656_g23923 = lerp( color658_g23923 , temp_output_52_0_g23927 , temp_output_679_0_g23923);
			float4 break655_g23923 = lerpResult656_g23923;
			float temp_output_1557_630_g23919 = break655_g23923.r;
			float LEAF_GUST_MID1397_g23919 = ( WIND_GUST_LEAF_MID_STRENGTH1186_g23919 * WIND_GUST_AUDIO_HIGH1244_g23919 * temp_output_1557_630_g23919 * temp_output_1557_630_g23919 );
			float _WIND_GUST_STRENGTH_MID829_g24010 = LEAF_GUST_MID1397_g23919;
			float3 _GUST_MID1019_g24010 = ( worldToObjDir1006_g24010 * _WIND_GUST_STRENGTH_MID829_g24010 );
			float3 ase_vertexNormal = v.normal.xyz;
			float3 _LEAF_NORMAL992_g24010 = ase_vertexNormal;
			float dotResult1_g24022 = dot( worldToObjDir1006_g24010 , _LEAF_NORMAL992_g24010 );
			float clampResult13_g24023 = clamp( dotResult1_g24022 , -1.0 , 1.0 );
			float WIND_GUST_LEAF_MICRO_STRENGTH1189_g23919 = _WIND_GUST_LEAF_MICRO_STRENGTH;
			float4 color658_g23941 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float WIND_GUST_LEAF_MICRO_CYCLE_TIME1190_g23919 = _WIND_GUST_LEAF_MICRO_CYCLE_TIME;
			float2 temp_cast_48 = (( 1.0 / (( ( WIND_GUST_LEAF_MICRO_CYCLE_TIME1190_g23919 + ( WIND_VARIATION1211_g23919 * 0.1 ) ) == 0.0 ) ? 1.0 :  ( WIND_GUST_LEAF_MICRO_CYCLE_TIME1190_g23919 + ( WIND_VARIATION1211_g23919 * 0.1 ) ) ) )).xx;
			float2 temp_output_61_0_g23945 = float2( 0,0 );
			float2 appendResult1409_g23919 = (float2(ase_vertex3Pos.y , ase_vertex3Pos.z));
			float2 temp_output_1_0_g23946 = ( (WIND_VARIATION1211_g23919).xx + appendResult1409_g23919 );
			float WIND_GUST_LEAF_MICRO_FIELD_SIZE1191_g23919 = _WIND_GUST_LEAF_MICRO_FIELD_SIZE;
			float temp_output_40_0_g23945 = ( 1.0 / (( WIND_GUST_LEAF_MICRO_FIELD_SIZE1191_g23919 == 0.0 ) ? 1.0 :  WIND_GUST_LEAF_MICRO_FIELD_SIZE1191_g23919 ) );
			float2 temp_cast_49 = (temp_output_40_0_g23945).xx;
			float2 temp_output_2_0_g23946 = temp_cast_49;
			float2 temp_output_3_0_g23946 = temp_output_61_0_g23945;
			float2 panner90_g23945 = ( _Time.y * temp_cast_48 + ( (( temp_output_61_0_g23945 > float2( 0,0 ) ) ? ( temp_output_1_0_g23946 / temp_output_2_0_g23946 ) :  ( temp_output_1_0_g23946 * temp_output_2_0_g23946 ) ) + temp_output_3_0_g23946 ));
			float temp_output_679_0_g23941 = 1.0;
			float4 temp_cast_50 = (temp_output_679_0_g23941).xxxx;
			float4 temp_output_52_0_g23945 = saturate( pow( tex2Dlod( _WIND_GUST_TEXTURE, float4( panner90_g23945, 0, 0.0) ) , temp_cast_50 ) );
			float4 lerpResult656_g23941 = lerp( color658_g23941 , temp_output_52_0_g23945 , temp_output_679_0_g23941);
			float4 break655_g23941 = lerpResult656_g23941;
			float LEAF_GUST_MICRO1408_g23919 = ( WIND_GUST_LEAF_MICRO_STRENGTH1189_g23919 * WIND_GUST_AUDIO_VERYHIGH1243_g23919 * break655_g23941.a );
			float _WIND_GUST_STRENGTH_MICRO851_g24010 = LEAF_GUST_MICRO1408_g23919;
			float clampResult3_g24020 = clamp( _WIND_GUST_STRENGTH_MICRO851_g24010 , 0.0 , 1.0 );
			float temp_output_3_0_g24023 = ( ( clampResult3_g24020 * 2.0 ) - 1.0 );
			float lerpResult1_g24029 = lerp( ( _WIND_GUST_STRENGTH_MICRO851_g24010 - 1.0 ) , temp_output_3_0_g24023 , saturate( ( 1.0 + clampResult13_g24023 ) ));
			float lerpResult1_g24024 = lerp( temp_output_3_0_g24023 , _WIND_GUST_STRENGTH_MICRO851_g24010 , saturate( clampResult13_g24023 ));
			float3 _GUST_MICRO1020_g24010 = ( worldToObjDir1006_g24010 * (( clampResult13_g24023 < 0.0 ) ? lerpResult1_g24029 :  lerpResult1_g24024 ) );
			float3 lerpResult538_g24010 = lerp( temp_output_684_0_g24010 , ( temp_output_684_0_g24010 + ( ( _GUST1018_g24010 + _GUST_MID1019_g24010 + _GUST_MICRO1020_g24010 ) * _WIND_TERTIARY_ROLL669_g24010 ) ) , WIND_GUST_AUDIO_STRENGTH1242_g23919);
			float3 MOTION_LEAF1343_g23919 = lerpResult538_g24010;
			float3 temp_output_19_0_g23975 = MOTION_LEAF1343_g23919;
			float3 temp_output_20_0_g23975 = float3(0,0,0);
			float3 temp_output_41_0_g24120 = ( ( WIND_TRUNK_STRENGTH1235_g23919 * MOTION_TRUNK1337_g23919 ) + ( WIND_BRANCH_STRENGTH1224_g23919 * MOTION_BRANCH1339_g23919 ) + ( WIND_LEAF_STRENGTH1179_g23919 * (( temp_output_17_0_g23975 == temp_output_18_0_g23975 ) ? temp_output_19_0_g23975 :  temp_output_20_0_g23975 ) ) );
			float temp_output_63_0_g24121 = (( unity_LODFade.x >= 1E-06 && unity_LODFade.x <= 0.999999 ) ? unity_LODFade.x :  1.0 );
			float3 lerpResult57_g24121 = lerp( temp_output_41_0_g24120 , -ase_vertex3Pos , ( 1.0 - temp_output_63_0_g24121 ));
			#ifdef INTERNAL_LODFADE_SCALE
				float3 staticSwitch58_g24120 = lerpResult57_g24121;
			#else
				float3 staticSwitch58_g24120 = temp_output_41_0_g24120;
			#endif
			#ifdef LOD_FADE_CROSSFADE
				float3 staticSwitch62_g24120 = staticSwitch58_g24120;
			#else
				float3 staticSwitch62_g24120 = temp_output_41_0_g24120;
			#endif
			v.vertex.xyz += staticSwitch62_g24120;
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			o.screenPosition = ase_screenPos;
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
			float temp_output_41_0_g24114 = 1.0;
			float4 ase_screenPos = i.screenPosition;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 clipScreen45_g24115 = ase_screenPosNorm.xy * _ScreenParams.xy;
			float dither45_g24115 = Dither8x8Bayer( fmod(clipScreen45_g24115.x, 8), fmod(clipScreen45_g24115.y, 8) );
			float temp_output_56_0_g24115 = (( unity_LODFade.x >= 1E-06 && unity_LODFade.x <= 0.999999 ) ? unity_LODFade.x :  1.0 );
			dither45_g24115 = step( dither45_g24115, temp_output_56_0_g24115 );
			#ifdef INTERNAL_LODFADE_DITHER
				float staticSwitch50_g24114 = ( temp_output_41_0_g24114 * dither45_g24115 );
			#else
				float staticSwitch50_g24114 = temp_output_41_0_g24114;
			#endif
			#ifdef LOD_FADE_CROSSFADE
				float staticSwitch56_g24114 = staticSwitch50_g24114;
			#else
				float staticSwitch56_g24114 = temp_output_41_0_g24114;
			#endif
			SurfaceOutputStandard s1_g24111 = (SurfaceOutputStandard ) 0;
			float temp_output_36_0_g1 = 1.0;
			float temp_output_2852_549 = round( i.uv3_tex4coord3.w );
			float temp_output_2851_0 = 10.0;
			float2 uv0_MainTex2 = i.uv_texcoord * _MainTex2_ST.xy + _MainTex2_ST.zw;
			float4 tex2DNode2861 = tex2D( _MetallicGlossMap2, uv0_MainTex2 );
			float lerpResult2886 = lerp( 1.0 , tex2DNode2861.g , _Occlusion2);
			float break_ao2872 = lerpResult2886;
			float switch131_g24068 = _SwapLayers;
			float temp_output_1_0_g24071 = switch131_g24068;
			float temp_output_10_0_g24071 = 0.0;
			float temp_output_187_0_g24068 = 1.0;
			float2 uv0_MainTex3 = i.uv_texcoord * _MainTex3_ST.xy + _MainTex3_ST.zw;
			float4 tex2DNode2049 = tex2D( _MetallicGlossMap3, uv0_MainTex3 );
			float lerpResult46_g24068 = lerp( temp_output_187_0_g24068 , tex2DNode2049.g , _Occlusion3);
			float2 uv0_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 break1299 = uv0_MainTex;
			half localunity_ObjectToWorld0w1_g1420 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld2w3_g1420 = ( unity_ObjectToWorld[2].w );
			float2 appendResult1104 = (float2(break1299.x , ( break1299.y + ( localunity_ObjectToWorld0w1_g1420 + localunity_ObjectToWorld2w3_g1420 ) )));
			float2 lerpResult1_g24059 = lerp( uv0_MainTex , appendResult1104 , saturate( _TrunkVariation ));
			half2 Main_UVs587 = lerpResult1_g24059;
			float4 tex2DNode645 = tex2D( _MetallicGlossMap, Main_UVs587 );
			float lerpResult47_g24068 = lerp( temp_output_187_0_g24068 , tex2DNode645.g , _Occlusion);
			float temp_output_68_0_g24073 = (( temp_output_1_0_g24071 > temp_output_10_0_g24071 ) ? lerpResult46_g24068 :  lerpResult47_g24068 );
			float WIND_SECONDARY_ROLL1205_g23919 = i.vertexColor.g;
			float secondary2693 = WIND_SECONDARY_ROLL1205_g23919;
			float WIND_PRIMARY_ROLL1202_g23919 = i.vertexColor.r;
			float primary2617 = WIND_PRIMARY_ROLL1202_g23919;
			float temp_output_1_0_g24069 = switch131_g24068;
			float temp_output_10_0_g24069 = 0.0;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float temp_output_24_0_g24075 = ase_vertex3Pos.y;
			float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
			float lerpResult67_g24068 = lerp( 1.0 , ase_objectScale.y , _BlendVariation);
			float temp_output_21_0_g24075 = ( lerpResult67_g24068 * _BlendHeight * ase_vertex3Pos.z );
			float temp_output_31_0_g24075 = ( temp_output_21_0_g24075 + min( _BlendFade , ( abs( temp_output_21_0_g24075 ) * _BlendFadeRatio ) ) );
			float temp_output_7_0_g24077 = temp_output_31_0_g24075;
			float smoothstepResult29_g24074 = smoothstep( 0.0 , 1.0 , (( temp_output_24_0_g24075 < temp_output_21_0_g24075 ) ? 1.0 :  (( temp_output_24_0_g24075 < temp_output_31_0_g24075 ) ? ( ( temp_output_24_0_g24075 - temp_output_7_0_g24077 ) / ( temp_output_21_0_g24075 - temp_output_7_0_g24077 ) ) :  0.0 ) ));
			float temp_output_1_0_g24094 = switch131_g24068;
			float temp_output_10_0_g24094 = 0.0;
			float temp_output_1_0_g24089 = switch131_g24068;
			float temp_output_10_0_g24089 = 0.0;
			float height_230_g24085 = saturate( ( (0.0 + ((( temp_output_1_0_g24069 > temp_output_10_0_g24069 ) ? tex2DNode645.b :  ( tex2DNode2049.b - ( 1.0 - smoothstepResult29_g24074 ) ) ) - 0.0) * ((( temp_output_1_0_g24094 > temp_output_10_0_g24094 ) ? _BaseHeightRange :  _CoverHeightRange ) - 0.0) / (1.0 - 0.0)) + (( temp_output_1_0_g24089 > temp_output_10_0_g24089 ) ? _BaseHeightOffset :  _CoverHeightOffset ) ) );
			float height_129_g24085 = saturate( ( (0.0 + ((( temp_output_1_0_g24069 > temp_output_10_0_g24069 ) ? ( tex2DNode2049.b - ( 1.0 - smoothstepResult29_g24074 ) ) :  tex2DNode645.b ) - 0.0) * ((( temp_output_1_0_g24094 > temp_output_10_0_g24094 ) ? _CoverHeightRange :  _BaseHeightRange ) - 0.0) / (1.0 - 0.0)) + (( temp_output_1_0_g24089 > temp_output_10_0_g24089 ) ? _CoverHeightOffset :  _BaseHeightOffset ) ) );
			float clampResult6_g24085 = clamp( ( 1.0 - saturate( _HeightBlendContrast ) ) , 1E-07 , 0.999999 );
			float height_start26_g24085 = saturate( ( max( height_129_g24085 , height_230_g24085 ) - clampResult6_g24085 ) );
			float level_239_g24085 = max( ( height_230_g24085 - height_start26_g24085 ) , 0.0 );
			float level_138_g24085 = max( ( height_129_g24085 - height_start26_g24085 ) , 0.0 );
			float temp_output_60_0_g24085 = ( level_138_g24085 + level_239_g24085 + 1E-06 );
			float temp_output_81_0_g24068 = ( ( ( 1.0 - saturate( secondary2693 ) ) * ( 1.0 - saturate( primary2617 ) ) ) * _BlendAmount * ( level_239_g24085 / temp_output_60_0_g24085 ) );
			float lerpResult7_g24073 = lerp( temp_output_68_0_g24073 , (( temp_output_1_0_g24071 > temp_output_10_0_g24071 ) ? lerpResult47_g24068 :  lerpResult46_g24068 ) , temp_output_81_0_g24068);
			#ifdef _ENABLEBASE_ON
				float staticSwitch16_g24073 = lerpResult7_g24073;
			#else
				float staticSwitch16_g24073 = temp_output_68_0_g24073;
			#endif
			half OUT_AO2077 = saturate( staticSwitch16_g24073 );
			float lerpResult38_g1 = lerp( temp_output_36_0_g1 , (( temp_output_2852_549 == temp_output_2851_0 ) ? break_ao2872 :  OUT_AO2077 ) , _Occlusion);
			float temp_output_48_0_g1 = i.uv_tex4coord.z;
			float lerpResult37_g1 = lerp( temp_output_36_0_g1 , saturate( (CalculateContrast(_VertexOcclusionContrast,(saturate( temp_output_48_0_g1 )).xxxx)).r ) , _VertexOcclusion);
			float3 ase_worldPos = i.worldPos;
			float3 positionWS3_g19685 = ase_worldPos;
			float4x4 OcclusionProbesWorldToLocal3_g19685 = _OcclusionProbesWorldToLocal;
			float3 uv_OcclusionProbes3 = i.uv_tex3coord;
			uv_OcclusionProbes3.xy = i.uv_tex3coord.xy * _OcclusionProbes_ST.xy + _OcclusionProbes_ST.zw;
			float OcclusionProbes3_g19685 = tex3D( _OcclusionProbes, uv_OcclusionProbes3 ).r;
			float localSampleOcclusionProbes3_g19685 = SampleOcclusionProbes( positionWS3_g19685 , OcclusionProbesWorldToLocal3_g19685 , OcclusionProbes3_g19685 );
			float lerpResult1_g19685 = lerp( 1.0 , localSampleOcclusionProbes3_g19685 , ( _AOProbeStrength * _OCCLUSION_PROBE_GLOBAL ));
			float temp_output_7_0_g1 = ( saturate( ( lerpResult38_g1 * lerpResult37_g1 ) ) * lerpResult1_g19685 );
			float lerpResult18_g1 = lerp( 1.0 , temp_output_7_0_g1 , _AOIndirect);
			float lerpResult14_g1 = lerp( 1.0 , temp_output_7_0_g1 , _AODirect);
			float lerpResult1_g1 = lerp( lerpResult18_g1 , lerpResult14_g1 , ase_lightAtten);
			float temp_output_16_0_g1 = saturate( lerpResult1_g1 );
			float4 temp_output_9_0_g24104 = _BreakColorContrast;
			float temp_output_1_0_g24096 = switch131_g24068;
			float temp_output_10_0_g24096 = 0.0;
			float4 temp_output_89_0_g24064 = tex2D( _MainTex3, uv0_MainTex3 );
			float3 hsvTorgb92_g24064 = RGBToHSV( temp_output_89_0_g24064.rgb );
			float temp_output_118_0_g24064 = 1.0;
			float3 hsvTorgb83_g24064 = HSVToRGB( float3(hsvTorgb92_g24064.x,( hsvTorgb92_g24064.y * ( temp_output_118_0_g24064 + _CoverSaturation ) ),( hsvTorgb92_g24064.z * ( temp_output_118_0_g24064 + _CoverBrightness ) )) );
			float4 temp_output_89_0_g24060 = tex2D( _MainTex, Main_UVs587 );
			float3 hsvTorgb92_g24060 = RGBToHSV( temp_output_89_0_g24060.rgb );
			float temp_output_118_0_g24060 = 1.0;
			float3 hsvTorgb83_g24060 = HSVToRGB( float3(hsvTorgb92_g24060.x,( hsvTorgb92_g24060.y * ( temp_output_118_0_g24060 + _Saturation ) ),( hsvTorgb92_g24060.z * ( temp_output_118_0_g24060 + _Brightness ) )) );
			float4 temp_output_68_0_g24100 = (( temp_output_1_0_g24096 > temp_output_10_0_g24096 ) ? float4( hsvTorgb83_g24064 , 0.0 ) :  float4( hsvTorgb83_g24060 , 0.0 ) );
			float4 lerpResult7_g24100 = lerp( temp_output_68_0_g24100 , (( temp_output_1_0_g24096 > temp_output_10_0_g24096 ) ? float4( hsvTorgb83_g24060 , 0.0 ) :  float4( hsvTorgb83_g24064 , 0.0 ) ) , temp_output_81_0_g24068);
			#ifdef _ENABLEBASE_ON
				float4 staticSwitch16_g24100 = lerpResult7_g24100;
			#else
				float4 staticSwitch16_g24100 = temp_output_68_0_g24100;
			#endif
			half4 OUT_ALBEDO1501 = staticSwitch16_g24100;
			float temp_output_1_0_g24098 = switch131_g24068;
			float temp_output_10_0_g24098 = 0.0;
			float4 temp_output_68_0_g24101 = (( temp_output_1_0_g24098 > temp_output_10_0_g24098 ) ? _Color3 :  _Color );
			float4 lerpResult7_g24101 = lerp( temp_output_68_0_g24101 , (( temp_output_1_0_g24098 > temp_output_10_0_g24098 ) ? _Color :  _Color3 ) , temp_output_81_0_g24068);
			#ifdef _ENABLEBASE_ON
				float4 staticSwitch16_g24101 = lerpResult7_g24101;
			#else
				float4 staticSwitch16_g24101 = temp_output_68_0_g24101;
			#endif
			half4 OUT_COLOR1539 = staticSwitch16_g24101;
			float4 lerpResult1_g24103 = lerp( ( OUT_ALBEDO1501 * OUT_COLOR1539 ) , _Color9 , saturate( ( _TrunkFadeStrength * primary2617 ) ));
			float4 temp_output_2683_0 = lerpResult1_g24103;
			float3 break12_g24104 = tex2D( _Map2, uv0_MainTex2 ).rgb;
			float4 lerpResult8_g24104 = lerp( temp_output_9_0_g24104 , temp_output_2683_0 , break12_g24104.z);
			float4 lerpResult10_g24104 = lerp( temp_output_9_0_g24104 , _BreakColorSapwood , break12_g24104.y);
			float4 lerpResult21_g24104 = lerp( lerpResult8_g24104 , lerpResult10_g24104 , break12_g24104.y);
			float4 lerpResult11_g24104 = lerp( temp_output_9_0_g24104 , _BreakColorHeartwood , break12_g24104.x);
			float4 lerpResult20_g24104 = lerp( lerpResult21_g24104 , lerpResult11_g24104 , break12_g24104.x);
			float4 break_albedo2870 = ( tex2D( _MainTex2, uv0_MainTex2 ) * lerpResult20_g24104 );
			float3 albedo51_g24111 = ( temp_output_16_0_g1 * saturate( ((( temp_output_2852_549 == temp_output_2851_0 ) ? break_albedo2870 :  temp_output_2683_0 )).rgb ) );
			s1_g24111.Albedo = albedo51_g24111;
			float3 break_normal2871 = UnpackScaleNormal( tex2D( _BumpMap2, uv0_MainTex2 ), _BumpScale2 );
			float temp_output_1_0_g24087 = switch131_g24068;
			float temp_output_10_0_g24087 = 0.0;
			float3 temp_output_190_0_g24068 = (( temp_output_1_0_g24087 > temp_output_10_0_g24087 ) ? UnpackScaleNormal( tex2D( _BumpMap3, uv0_MainTex3 ), _BumpScale3 ) :  UnpackScaleNormal( tex2D( _BumpMap, Main_UVs587 ), _BumpScale ) );
			float3 temp_output_68_0_g24102 = temp_output_190_0_g24068;
			float3 temp_output_190_2_g24068 = (( temp_output_1_0_g24087 > temp_output_10_0_g24087 ) ? UnpackScaleNormal( tex2D( _BumpMap, Main_UVs587 ), _BumpScale ) :  UnpackScaleNormal( tex2D( _BumpMap3, uv0_MainTex3 ), _BumpScale3 ) );
			float3 base14_g24081 = ( float3(0,0,1) + temp_output_190_2_g24068 );
			float3 detail15_g24081 = ( temp_output_190_0_g24068 * float3(-1,-1,1) );
			float dotResult9_g24081 = dot( base14_g24081 , detail15_g24081 );
			float3 lerpResult19_g24068 = lerp( temp_output_190_2_g24068 , ( ( ( base14_g24081 * dotResult9_g24081 ) / (base14_g24081).z ) - detail15_g24081 ) , _BlendNormals);
			float3 lerpResult7_g24102 = lerp( temp_output_68_0_g24102 , lerpResult19_g24068 , temp_output_81_0_g24068);
			#ifdef _ENABLEBASE_ON
				float3 staticSwitch16_g24102 = lerpResult7_g24102;
			#else
				float3 staticSwitch16_g24102 = temp_output_68_0_g24102;
			#endif
			float3 normalizeResult29_g24068 = normalize( staticSwitch16_g24102 );
			float3 OUT_NORMAL1512 = normalizeResult29_g24068;
			float3 temp_output_55_0_g24111 = (( temp_output_2852_549 == temp_output_2851_0 ) ? break_normal2871 :  OUT_NORMAL1512 );
			float3 normal_TS54_g24111 = temp_output_55_0_g24111;
			s1_g24111.Normal = WorldNormalVector( i , normal_TS54_g24111 );
			float3 emissive71_g24111 = float3(0,0,0);
			s1_g24111.Emission = emissive71_g24111;
			float metallic34_g24111 = 0.0;
			s1_g24111.Metallic = metallic34_g24111;
			float break_smoothness2877 = ( tex2DNode2861.a * _Glossiness2 );
			float temp_output_1_0_g24092 = switch131_g24068;
			float temp_output_10_0_g24092 = 0.0;
			float temp_output_68_0_g24078 = (( temp_output_1_0_g24092 > temp_output_10_0_g24092 ) ? ( tex2DNode2049.a * _Glossiness3 ) :  ( tex2DNode645.a * _Glossiness ) );
			float lerpResult7_g24078 = lerp( temp_output_68_0_g24078 , (( temp_output_1_0_g24092 > temp_output_10_0_g24092 ) ? ( tex2DNode645.a * _Glossiness ) :  ( tex2DNode2049.a * _Glossiness3 ) ) , temp_output_81_0_g24068);
			#ifdef _ENABLEBASE_ON
				float staticSwitch16_g24078 = lerpResult7_g24078;
			#else
				float staticSwitch16_g24078 = temp_output_68_0_g24078;
			#endif
			half OUT_SMOOTHNESS2071 = saturate( staticSwitch16_g24078 );
			float smoothness39_g24111 = (( temp_output_2852_549 == temp_output_2851_0 ) ? break_smoothness2877 :  OUT_SMOOTHNESS2071 );
			s1_g24111.Smoothness = smoothness39_g24111;
			float occlusion188_g24111 = temp_output_16_0_g1;
			s1_g24111.Occlusion = occlusion188_g24111;

			data.light = gi.light;

			UnityGI gi1_g24111 = gi;
			#ifdef UNITY_PASS_FORWARDBASE
			Unity_GlossyEnvironmentData g1_g24111 = UnityGlossyEnvironmentSetup( s1_g24111.Smoothness, data.worldViewDir, s1_g24111.Normal, float3(0,0,0));
			gi1_g24111 = UnityGlobalIllumination( data, s1_g24111.Occlusion, s1_g24111.Normal, g1_g24111 );
			#endif

			float3 surfResult1_g24111 = LightingStandard ( s1_g24111, viewDir, gi1_g24111 ).rgb;
			surfResult1_g24111 += s1_g24111.Emission;

			#ifdef UNITY_PASS_FORWARDADD//1_g24111
			surfResult1_g24111 -= s1_g24111.Emission;
			#endif//1_g24111
			float3 clampResult196_g24111 = clamp( surfResult1_g24111 , float3(0,0,0) , float3(50,50,50) );
			float4 color2788 = IsGammaSpace() ? float4(0,0,0.3490566,0) : float4(0,0,0.09992068,0);
			float3 switchResult2787 = (((i.ASEVFace>0)?(clampResult196_g24111):((color2788).rgb)));
			c.rgb = switchResult2787;
			c.a = staticSwitch56_g24114;
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
			float temp_output_36_0_g1 = 1.0;
			float temp_output_2852_549 = round( i.uv3_tex4coord3.w );
			float temp_output_2851_0 = 10.0;
			float2 uv0_MainTex2 = i.uv_texcoord * _MainTex2_ST.xy + _MainTex2_ST.zw;
			float4 tex2DNode2861 = tex2D( _MetallicGlossMap2, uv0_MainTex2 );
			float lerpResult2886 = lerp( 1.0 , tex2DNode2861.g , _Occlusion2);
			float break_ao2872 = lerpResult2886;
			float switch131_g24068 = _SwapLayers;
			float temp_output_1_0_g24071 = switch131_g24068;
			float temp_output_10_0_g24071 = 0.0;
			float temp_output_187_0_g24068 = 1.0;
			float2 uv0_MainTex3 = i.uv_texcoord * _MainTex3_ST.xy + _MainTex3_ST.zw;
			float4 tex2DNode2049 = tex2D( _MetallicGlossMap3, uv0_MainTex3 );
			float lerpResult46_g24068 = lerp( temp_output_187_0_g24068 , tex2DNode2049.g , _Occlusion3);
			float2 uv0_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 break1299 = uv0_MainTex;
			half localunity_ObjectToWorld0w1_g1420 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld2w3_g1420 = ( unity_ObjectToWorld[2].w );
			float2 appendResult1104 = (float2(break1299.x , ( break1299.y + ( localunity_ObjectToWorld0w1_g1420 + localunity_ObjectToWorld2w3_g1420 ) )));
			float2 lerpResult1_g24059 = lerp( uv0_MainTex , appendResult1104 , saturate( _TrunkVariation ));
			half2 Main_UVs587 = lerpResult1_g24059;
			float4 tex2DNode645 = tex2D( _MetallicGlossMap, Main_UVs587 );
			float lerpResult47_g24068 = lerp( temp_output_187_0_g24068 , tex2DNode645.g , _Occlusion);
			float temp_output_68_0_g24073 = (( temp_output_1_0_g24071 > temp_output_10_0_g24071 ) ? lerpResult46_g24068 :  lerpResult47_g24068 );
			float WIND_SECONDARY_ROLL1205_g23919 = i.vertexColor.g;
			float secondary2693 = WIND_SECONDARY_ROLL1205_g23919;
			float WIND_PRIMARY_ROLL1202_g23919 = i.vertexColor.r;
			float primary2617 = WIND_PRIMARY_ROLL1202_g23919;
			float temp_output_1_0_g24069 = switch131_g24068;
			float temp_output_10_0_g24069 = 0.0;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float temp_output_24_0_g24075 = ase_vertex3Pos.y;
			float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
			float lerpResult67_g24068 = lerp( 1.0 , ase_objectScale.y , _BlendVariation);
			float temp_output_21_0_g24075 = ( lerpResult67_g24068 * _BlendHeight * ase_vertex3Pos.z );
			float temp_output_31_0_g24075 = ( temp_output_21_0_g24075 + min( _BlendFade , ( abs( temp_output_21_0_g24075 ) * _BlendFadeRatio ) ) );
			float temp_output_7_0_g24077 = temp_output_31_0_g24075;
			float smoothstepResult29_g24074 = smoothstep( 0.0 , 1.0 , (( temp_output_24_0_g24075 < temp_output_21_0_g24075 ) ? 1.0 :  (( temp_output_24_0_g24075 < temp_output_31_0_g24075 ) ? ( ( temp_output_24_0_g24075 - temp_output_7_0_g24077 ) / ( temp_output_21_0_g24075 - temp_output_7_0_g24077 ) ) :  0.0 ) ));
			float temp_output_1_0_g24094 = switch131_g24068;
			float temp_output_10_0_g24094 = 0.0;
			float temp_output_1_0_g24089 = switch131_g24068;
			float temp_output_10_0_g24089 = 0.0;
			float height_230_g24085 = saturate( ( (0.0 + ((( temp_output_1_0_g24069 > temp_output_10_0_g24069 ) ? tex2DNode645.b :  ( tex2DNode2049.b - ( 1.0 - smoothstepResult29_g24074 ) ) ) - 0.0) * ((( temp_output_1_0_g24094 > temp_output_10_0_g24094 ) ? _BaseHeightRange :  _CoverHeightRange ) - 0.0) / (1.0 - 0.0)) + (( temp_output_1_0_g24089 > temp_output_10_0_g24089 ) ? _BaseHeightOffset :  _CoverHeightOffset ) ) );
			float height_129_g24085 = saturate( ( (0.0 + ((( temp_output_1_0_g24069 > temp_output_10_0_g24069 ) ? ( tex2DNode2049.b - ( 1.0 - smoothstepResult29_g24074 ) ) :  tex2DNode645.b ) - 0.0) * ((( temp_output_1_0_g24094 > temp_output_10_0_g24094 ) ? _CoverHeightRange :  _BaseHeightRange ) - 0.0) / (1.0 - 0.0)) + (( temp_output_1_0_g24089 > temp_output_10_0_g24089 ) ? _CoverHeightOffset :  _BaseHeightOffset ) ) );
			float clampResult6_g24085 = clamp( ( 1.0 - saturate( _HeightBlendContrast ) ) , 1E-07 , 0.999999 );
			float height_start26_g24085 = saturate( ( max( height_129_g24085 , height_230_g24085 ) - clampResult6_g24085 ) );
			float level_239_g24085 = max( ( height_230_g24085 - height_start26_g24085 ) , 0.0 );
			float level_138_g24085 = max( ( height_129_g24085 - height_start26_g24085 ) , 0.0 );
			float temp_output_60_0_g24085 = ( level_138_g24085 + level_239_g24085 + 1E-06 );
			float temp_output_81_0_g24068 = ( ( ( 1.0 - saturate( secondary2693 ) ) * ( 1.0 - saturate( primary2617 ) ) ) * _BlendAmount * ( level_239_g24085 / temp_output_60_0_g24085 ) );
			float lerpResult7_g24073 = lerp( temp_output_68_0_g24073 , (( temp_output_1_0_g24071 > temp_output_10_0_g24071 ) ? lerpResult47_g24068 :  lerpResult46_g24068 ) , temp_output_81_0_g24068);
			#ifdef _ENABLEBASE_ON
				float staticSwitch16_g24073 = lerpResult7_g24073;
			#else
				float staticSwitch16_g24073 = temp_output_68_0_g24073;
			#endif
			half OUT_AO2077 = saturate( staticSwitch16_g24073 );
			float lerpResult38_g1 = lerp( temp_output_36_0_g1 , (( temp_output_2852_549 == temp_output_2851_0 ) ? break_ao2872 :  OUT_AO2077 ) , _Occlusion);
			float temp_output_48_0_g1 = i.uv_tex4coord.z;
			float lerpResult37_g1 = lerp( temp_output_36_0_g1 , saturate( (CalculateContrast(_VertexOcclusionContrast,(saturate( temp_output_48_0_g1 )).xxxx)).r ) , _VertexOcclusion);
			float3 ase_worldPos = i.worldPos;
			float3 positionWS3_g19685 = ase_worldPos;
			float4x4 OcclusionProbesWorldToLocal3_g19685 = _OcclusionProbesWorldToLocal;
			float3 uv_OcclusionProbes3 = i.uv_tex3coord;
			uv_OcclusionProbes3.xy = i.uv_tex3coord.xy * _OcclusionProbes_ST.xy + _OcclusionProbes_ST.zw;
			float OcclusionProbes3_g19685 = tex3D( _OcclusionProbes, uv_OcclusionProbes3 ).r;
			float localSampleOcclusionProbes3_g19685 = SampleOcclusionProbes( positionWS3_g19685 , OcclusionProbesWorldToLocal3_g19685 , OcclusionProbes3_g19685 );
			float lerpResult1_g19685 = lerp( 1.0 , localSampleOcclusionProbes3_g19685 , ( _AOProbeStrength * _OCCLUSION_PROBE_GLOBAL ));
			float temp_output_7_0_g1 = ( saturate( ( lerpResult38_g1 * lerpResult37_g1 ) ) * lerpResult1_g19685 );
			float lerpResult18_g1 = lerp( 1.0 , temp_output_7_0_g1 , _AOIndirect);
			float lerpResult14_g1 = lerp( 1.0 , temp_output_7_0_g1 , _AODirect);
			float lerpResult1_g1 = lerp( lerpResult18_g1 , lerpResult14_g1 , 1);
			float temp_output_16_0_g1 = saturate( lerpResult1_g1 );
			float4 temp_output_9_0_g24104 = _BreakColorContrast;
			float temp_output_1_0_g24096 = switch131_g24068;
			float temp_output_10_0_g24096 = 0.0;
			float4 temp_output_89_0_g24064 = tex2D( _MainTex3, uv0_MainTex3 );
			float3 hsvTorgb92_g24064 = RGBToHSV( temp_output_89_0_g24064.rgb );
			float temp_output_118_0_g24064 = 1.0;
			float3 hsvTorgb83_g24064 = HSVToRGB( float3(hsvTorgb92_g24064.x,( hsvTorgb92_g24064.y * ( temp_output_118_0_g24064 + _CoverSaturation ) ),( hsvTorgb92_g24064.z * ( temp_output_118_0_g24064 + _CoverBrightness ) )) );
			float4 temp_output_89_0_g24060 = tex2D( _MainTex, Main_UVs587 );
			float3 hsvTorgb92_g24060 = RGBToHSV( temp_output_89_0_g24060.rgb );
			float temp_output_118_0_g24060 = 1.0;
			float3 hsvTorgb83_g24060 = HSVToRGB( float3(hsvTorgb92_g24060.x,( hsvTorgb92_g24060.y * ( temp_output_118_0_g24060 + _Saturation ) ),( hsvTorgb92_g24060.z * ( temp_output_118_0_g24060 + _Brightness ) )) );
			float4 temp_output_68_0_g24100 = (( temp_output_1_0_g24096 > temp_output_10_0_g24096 ) ? float4( hsvTorgb83_g24064 , 0.0 ) :  float4( hsvTorgb83_g24060 , 0.0 ) );
			float4 lerpResult7_g24100 = lerp( temp_output_68_0_g24100 , (( temp_output_1_0_g24096 > temp_output_10_0_g24096 ) ? float4( hsvTorgb83_g24060 , 0.0 ) :  float4( hsvTorgb83_g24064 , 0.0 ) ) , temp_output_81_0_g24068);
			#ifdef _ENABLEBASE_ON
				float4 staticSwitch16_g24100 = lerpResult7_g24100;
			#else
				float4 staticSwitch16_g24100 = temp_output_68_0_g24100;
			#endif
			half4 OUT_ALBEDO1501 = staticSwitch16_g24100;
			float temp_output_1_0_g24098 = switch131_g24068;
			float temp_output_10_0_g24098 = 0.0;
			float4 temp_output_68_0_g24101 = (( temp_output_1_0_g24098 > temp_output_10_0_g24098 ) ? _Color3 :  _Color );
			float4 lerpResult7_g24101 = lerp( temp_output_68_0_g24101 , (( temp_output_1_0_g24098 > temp_output_10_0_g24098 ) ? _Color :  _Color3 ) , temp_output_81_0_g24068);
			#ifdef _ENABLEBASE_ON
				float4 staticSwitch16_g24101 = lerpResult7_g24101;
			#else
				float4 staticSwitch16_g24101 = temp_output_68_0_g24101;
			#endif
			half4 OUT_COLOR1539 = staticSwitch16_g24101;
			float4 lerpResult1_g24103 = lerp( ( OUT_ALBEDO1501 * OUT_COLOR1539 ) , _Color9 , saturate( ( _TrunkFadeStrength * primary2617 ) ));
			float4 temp_output_2683_0 = lerpResult1_g24103;
			float3 break12_g24104 = tex2D( _Map2, uv0_MainTex2 ).rgb;
			float4 lerpResult8_g24104 = lerp( temp_output_9_0_g24104 , temp_output_2683_0 , break12_g24104.z);
			float4 lerpResult10_g24104 = lerp( temp_output_9_0_g24104 , _BreakColorSapwood , break12_g24104.y);
			float4 lerpResult21_g24104 = lerp( lerpResult8_g24104 , lerpResult10_g24104 , break12_g24104.y);
			float4 lerpResult11_g24104 = lerp( temp_output_9_0_g24104 , _BreakColorHeartwood , break12_g24104.x);
			float4 lerpResult20_g24104 = lerp( lerpResult21_g24104 , lerpResult11_g24104 , break12_g24104.x);
			float4 break_albedo2870 = ( tex2D( _MainTex2, uv0_MainTex2 ) * lerpResult20_g24104 );
			float3 albedo51_g24111 = ( temp_output_16_0_g1 * saturate( ((( temp_output_2852_549 == temp_output_2851_0 ) ? break_albedo2870 :  temp_output_2683_0 )).rgb ) );
			o.Albedo = ( _GlobalIlluminationAlbedoEffect * albedo51_g24111 );
			float3 emissive71_g24111 = float3(0,0,0);
			o.Emission = ( _GlobalIlluminationEmissiveEffect * emissive71_g24111 );
		}

		ENDCG
		CGPROGRAM
#include "UnityCG.cginc"
#include "Assets/Resources/CGIncludes/Appalachia/GPUInstancerInclude.cginc"
#pragma instancing_options procedural:setupGPUI
#pragma multi_compile_instancing
#include "UnityCG.cginc"

		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows dithercrossfade vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
#include "UnityCG.cginc"
#include "Assets/Resources/CGIncludes/Appalachia/GPUInstancerInclude.cginc"
#pragma instancing_options procedural:setupGPUI
#pragma multi_compile_instancing
#include "UnityCG.cginc"

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
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float4 customPack1 : TEXCOORD1;
				float2 customPack2 : TEXCOORD2;
				float4 customPack3 : TEXCOORD3;
				float3 customPack4 : TEXCOORD4;
				float4 customPack5 : TEXCOORD5;
				float4 tSpace0 : TEXCOORD6;
				float4 tSpace1 : TEXCOORD7;
				float4 tSpace2 : TEXCOORD8;
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
				o.customPack1.xyzw = customInputData.uv3_tex4coord3;
				o.customPack1.xyzw = v.texcoord2;
				o.customPack2.xy = customInputData.uv_texcoord;
				o.customPack2.xy = v.texcoord;
				o.customPack3.xyzw = customInputData.uv_tex4coord;
				o.customPack3.xyzw = v.texcoord;
				o.customPack4.xyz = customInputData.uv_tex3coord;
				o.customPack4.xyz = v.texcoord;
				o.customPack5.xyzw = customInputData.screenPosition;
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
				surfIN.uv3_tex4coord3 = IN.customPack1.xyzw;
				surfIN.uv_texcoord = IN.customPack2.xy;
				surfIN.uv_tex4coord = IN.customPack3.xyzw;
				surfIN.uv_tex3coord = IN.customPack4.xyz;
				surfIN.screenPosition = IN.customPack5.xyzw;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				surfIN.vertexColor = IN.color;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT( UnityGI, gi );
				o.Alpha = LightingStandardCustomLighting( o, worldViewDir, gi ).a;
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "AppalachiaShaderGUI"
}
/*ASEBEGIN
Version=17500
0;-864;1536;843;-6403.474;1893.1;1.3;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;2700;1339.87,-2148.727;Inherit;False;0;18;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1102;1547.97,-1965.927;Inherit;False;Object Position;-1;;1420;b9555b68a3d67c54f91597a05086026a;0;0;4;FLOAT3;7;FLOAT;0;FLOAT;4;FLOAT;5
Node;AmplifyShaderEditor.BreakToComponentsNode;1299;1645.17,-2067.427;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;1109;1755.87,-1956.726;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1101;1915.87,-1988.726;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1826;1949.571,-1882.026;Half;False;Property;_TrunkVariation;Trunk Variation;12;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2911;6935.065,-1165.16;Inherit;False;Wind (Tree Complex);70;;23919;76dbe6e88a5c02e42a177b05b9981ead;2,981,1,983,1;0;8;FLOAT3;0;FLOAT;1021;FLOAT;1022;FLOAT;1023;FLOAT;1024;FLOAT;1027;FLOAT;1025;FLOAT;1454
Node;AmplifyShaderEditor.DynamicAppendNode;1104;2091.87,-2068.726;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;2812;2328.69,-2170.795;Inherit;False;Lerp (Clamped);-1;;24059;cad3f473268ed2641979326c3e8290ec;0;3;2;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2693;7296.663,-995.9969;Inherit;False;secondary;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2617;7295.24,-1080.332;Inherit;False;primary;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;587;2539.871,-2148.727;Half;False;Main_UVs;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;2694;2739.633,-3006.556;Inherit;False;2693;secondary;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2690;2739.633,-2926.556;Inherit;False;2617;primary;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2695;2995.633,-3006.556;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2691;2995.633,-2926.556;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;588;2160.197,-2637.894;Inherit;False;587;Main_UVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2699;2686.532,-1599.488;Inherit;False;0;1415;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2809;3024.852,-1678.921;Inherit;False;Property;_CoverBrightness;Cover Brightness;44;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;2696;3155.633,-3006.556;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;18;2396.392,-2652.298;Inherit;True;Property;_MainTex;Bark Albedo;3;0;Create;False;0;0;False;0;-1;None;e0d809474c2ae59458365a42f3290c24;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2808;3024.852,-1774.921;Inherit;False;Property;_CoverSaturation;Cover Saturation;43;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2216;2560,-2336;Inherit;False;Property;_Brightness;Brightness;6;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1488;2641.084,-1358.295;Half;False;Property;_BumpScale3;Cover Normal Scale;46;0;Create;False;0;0;False;0;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2215;2560,-2432;Inherit;False;Property;_Saturation;Saturation;5;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;604;2879.808,-2287.539;Inherit;False;587;Main_UVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;655;2840.808,-2159.539;Half;False;Property;_BumpScale;Normal Scale;8;0;Create;False;0;0;False;0;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;2242;3155.633,-2926.556;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;644;2881.677,-2060.138;Inherit;False;587;Main_UVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1415;3014.328,-1589.451;Inherit;True;Property;_MainTex3;Cover Albedo;41;0;Create;False;0;0;False;0;-1;None;c84ebe83ab5a4254cb2de5e0e304c0e2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;1532;3526.409,-1348.967;Half;False;Property;_Color3;Cover Color;42;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2781;3347.633,-2990.556;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2836;2957.972,-2575.872;Inherit;False;Color Adjustment;-1;;24060;f9571dc7cf91d954d87b44c4dd2d35aa;6,90,0,81,1,91,1,85,0,116,0,111,0;6;89;COLOR;0,0,0,0;False;82;FLOAT;0;False;86;FLOAT;0;False;87;FLOAT;0;False;88;FLOAT;0;False;115;FLOAT;0;False;1;FLOAT3;37
Node;AmplifyShaderEditor.FunctionNode;2837;3432.2,-1818.414;Inherit;False;Color Adjustment;-1;;24064;f9571dc7cf91d954d87b44c4dd2d35aa;6,90,0,81,1,91,1,85,0,116,0,111,0;6;89;COLOR;0,0,0,0;False;82;FLOAT;0;False;86;FLOAT;0;False;87;FLOAT;0;False;88;FLOAT;0;False;115;FLOAT;0;False;1;FLOAT3;37
Node;AmplifyShaderEditor.SamplerNode;607;3151.809,-2287.539;Inherit;True;Property;_BumpMap;Bark Normal;7;2;[NoScaleOffset];[Normal];Create;False;0;0;False;0;-1;None;a0d0f46d221ac9a4d8ded765512d82d6;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;409;3202.369,-2823.961;Half;False;Property;_Color;Trunk Color;4;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;645;3137.677,-2060.138;Inherit;True;Property;_MetallicGlossMap;Bark Surface;9;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;95075df431682dd4eb43288b4842c024;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2049;3014.328,-1205.451;Inherit;True;Property;_MetallicGlossMap3;Cover Surface;47;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;87069b6423d163d4088bce8a9d168c27;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1486;3014.328,-1397.451;Inherit;True;Property;_BumpMap3;Cover Normal;45;2;[NoScaleOffset];[Normal];Create;False;0;0;False;0;-1;None;301af0db7375c4f47b07ba633dca1dce;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;2906;4043.444,-2364.338;Inherit;False;Base Cover Blend;13;;24068;19c60fd13ac32254683b2f42e399098f;0;13;83;FLOAT;0;False;79;FLOAT;0;False;85;COLOR;0,0,0,0;False;86;COLOR;0,0,0,0;False;87;FLOAT3;0,0,1;False;89;FLOAT;0;False;88;FLOAT;0;False;80;FLOAT;0;False;91;COLOR;0,0,0,0;False;92;COLOR;0,0,0,0;False;93;FLOAT3;0,0,1;False;90;FLOAT;0;False;94;FLOAT;0;False;5;COLOR;69;COLOR;70;FLOAT3;71;FLOAT;73;FLOAT;72
Node;AmplifyShaderEditor.RegisterLocalVarNode;1501;4505.735,-2391.636;Half;False;OUT_ALBEDO;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1539;4504.735,-2472.636;Half;False;OUT_COLOR;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2619;3975.256,-758.863;Inherit;False;2617;primary;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2570;3901.956,-1217.606;Inherit;False;1501;OUT_ALBEDO;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2448;3908.954,-1119.302;Inherit;False;1539;OUT_COLOR;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2613;3879.256,-834.8631;Inherit;False;Property;_TrunkFadeStrength;Trunk Fade Strength;11;0;Create;True;0;0;False;0;0;0;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2857;2688,-256;Inherit;False;0;2893;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;2608;3871.954,-1028.302;Half;False;Property;_Color9;Trunk Fade Color;10;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2612;4182.954,-836.3021;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2451;4153.493,-1130.969;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2859;3024,-258.6287;Inherit;True;Property;_Map2;Break Color Map;50;1;[NoScaleOffset];Create;False;0;0;False;0;-1;30b74f8943398f34ea38fa130da14be2;51f7c98ac0c72f64d8d4acae5ad066c5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;2864;3844.189,-143.1209;Inherit;False;Property;_BreakColorHeartwood;Break Color Heartwood;51;0;Create;True;0;0;False;0;0.3215686,0.2352941,0.1333333,1;0.917,0.6801059,0.4878438,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;2683;4374.355,-995.1041;Inherit;False;Lerp (Clamped);-1;;24103;cad3f473268ed2641979326c3e8290ec;0;3;2;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;2867;3844.189,384.8791;Half;False;Property;_BreakColorContrast;Break Color Contrast;54;0;Create;True;0;0;False;0;0.07843138,0.05490196,0.03137255,1;0.09899988,0.0699929,0.04098591,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;2863;3844.189,32.87908;Inherit;False;Property;_BreakColorSapwood;Break Color Sapwood;52;0;Create;True;0;0;False;0;0.6431373,0.5372549,0.3137255,1;0.78,0.6280519,0.482857,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;2869;4077.483,-193.292;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2892;5015.251,-177.8083;Inherit;False;RGB Color Map;-1;;24104;453fd39d4e873fe40a4796e5f58ebec5;0;5;1;FLOAT3;0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;9;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2893;3024,-448;Inherit;True;Property;_MainTex2;Break Albedo;49;0;Create;False;0;0;False;0;-1;76887b41324732748bfa938d4ff881b6;76887b41324732748bfa938d4ff881b6;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2894;5189.007,-222.3697;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2870;5345.826,-234.5493;Inherit;False;break_albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2885;2928,400;Inherit;False;Property;_Occlusion2;Break Occlusion;58;0;Create;False;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2887;3156.21,329.5974;Inherit;False;Constant;_Float0;Float 0;53;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2861;3024,128;Inherit;True;Property;_MetallicGlossMap2;Break Surface;57;1;[NoScaleOffset];Create;False;0;0;False;0;-1;ca9a4a92cb27b614e888b673ecc30005;44d089f28e1b3a742954c6b9f948b232;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;2851;5163.099,-935.7005;Inherit;False;Tree Component ID;-1;;24106;5271313988492174092a46e3f289ae62;1,4,7;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2886;3405.711,255.1497;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2879;5106,-1538;Inherit;False;2870;break_albedo;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2883;2944,496;Inherit;False;Property;_Glossiness2;Break Smoothness;59;0;Create;False;0;0;False;0;0.2;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2858;2641,-16;Half;False;Property;_BumpScale2;Break Normal Scale;56;0;Create;False;0;0;False;0;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2852;4976,-1898.2;Inherit;False;Mesh Values (Tree) (Complex) (UV3);-1;;24105;8e1e1d817f2a77d4ea50f9fe634408b6;0;0;2;FLOAT3;500;FLOAT;549
Node;AmplifyShaderEditor.WireNode;2895;4926.632,-1325.367;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2077;4506.735,-2228.637;Half;False;OUT_AO;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2872;3572.563,306.4321;Inherit;False;break_ao;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2860;3024,-64;Inherit;True;Property;_BumpMap2;Break Normal;55;2;[NoScaleOffset];[Normal];Create;False;0;0;False;0;-1;a2f22b01e0b3c0945933c219961fcd91;18c34d2028f79b1429b4742041ece4fa;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCCompareEqual;2873;5632,-1520;Inherit;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2884;3419.795,447.3052;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2871;3343.144,-57.1875;Inherit;False;break_normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2071;4479.735,-2143.637;Half;False;OUT_SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2880;5120,-1696;Inherit;False;2872;break_ao;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2496;5120,-1616;Inherit;False;2077;OUT_AO;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1512;4505.735,-2311.637;Float;False;OUT_NORMAL;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;2692;5833,-1524;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2877;3564.094,423.3071;Inherit;False;break_smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;2758;5939.495,-1858.722;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;2876;5124,-1330;Inherit;False;2871;break_normal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;624;5121,-1256;Inherit;False;1512;OUT_NORMAL;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;2739;6064.886,-1510.864;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCCompareEqual;2853;5632,-1664;Inherit;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2878;5120,-1168;Inherit;False;2877;break_smoothness;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;654;5115,-1094;Inherit;False;2071;OUT_SMOOTHNESS;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareEqual;2875;5632,-1232;Inherit;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareEqual;2874;5632,-1376;Inherit;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;2788;6940.001,-1870.082;Inherit;False;Constant;_Color10;Color 10;41;0;Create;True;0;0;False;0;0,0,0.3490566,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;2912;6282.029,-1596.802;Inherit;False;Occlusion Probes;60;;1;fc5cec86a89be184e93fc845da77a0cc;4,22,1,65,1,66,1,64,0;3;12;FLOAT;0;False;48;FLOAT;0;False;26;FLOAT3;1,1,1;False;2;FLOAT;0;FLOAT3;31
Node;AmplifyShaderEditor.CommentaryNode;1465;7966.115,-1768.58;Inherit;False;499.6666;540.5626;Drawers;7;2642;2638;2643;2630;1468;1472;2881;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.FunctionNode;2840;7005.679,-1253.843;Inherit;False;const;-1;;24112;5b64729fb717c5f49a1bc2dab81d5e1c;4,21,0,3,1,22,0,28,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2845;6834.502,-1562.523;Inherit;False;Custom Lighting;96;;24111;b225dcbb02c65fb46af1dbc43764905b;1,67,0;7;56;FLOAT3;0,0,0;False;55;FLOAT3;0,0,0;False;70;FLOAT3;0,0,0;False;45;FLOAT;0;False;148;FLOAT3;0,0,0;False;41;FLOAT;0;False;189;FLOAT;0;False;3;FLOAT3;4;FLOAT3;5;FLOAT3;3
Node;AmplifyShaderEditor.ComponentMaskNode;2789;7208.001,-1859.082;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1472;7998.114,-1704.58;Half;False;Property;_BANNER;BANNER;1;0;Create;True;0;0;True;1;InternalBanner(Internal, Bark);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2862;3844.189,208.8791;Half;False;Property;_BreakColorBark;Break Color Bark;53;0;Create;True;0;0;False;0;0.22,0.1481633,0.08979592,1;0.4439999,0.2913719,0.1984679,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2881;8192,-1520;Half;False;Property;_BREAKK;[ BREAKK ];48;0;Create;True;0;0;True;1;InternalCategory(Break);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2643;8320.601,-1330.614;Half;False;Property;_IsShadow;Is Shadow;102;2;[HideInInspector];[Toggle];Create;True;2;Off;0;On;1;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;2815;3471.446,-2207.12;Inherit;False;Constant;_Vector0;Vector 0;43;0;Create;True;0;0;False;0;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FunctionNode;2630;8002.114,-1421.581;Inherit;False;Internal Features Support;-1;;24126;3c493d142aeebd840af72d626f6915c6;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2642;8160.601,-1330.614;Half;False;Property;_IsLeaf;Is Leaf;100;2;[HideInInspector];[Toggle];Create;True;2;Off;0;On;1;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;2787;7393.001,-1475.082;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2638;8000.601,-1330.614;Half;False;Property;_IsBark;Is Bark;101;2;[HideInInspector];[Toggle];Create;True;2;Off;0;On;1;0;True;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1468;7998.114,-1512.581;Half;False;Property;_TRUNKK;[ TRUNKK ];2;0;Create;True;0;0;True;1;InternalCategory(Trunk);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2841;7305.033,-1237.781;Inherit;False;Execute LOD Fade;-1;;24113;18ea34bd83a0d6c4db425672111543e6;0;2;41;FLOAT;0;False;58;FLOAT3;0,0,0;False;3;FLOAT;0;FLOAT3;91;FLOAT;96
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;7721.279,-1647.184;Float;False;True;-1;4;AppalachiaShaderGUI;300;0;CustomLighting;appalachia/bark_LOD0;False;False;False;False;False;False;False;False;False;False;False;False;True;True;False;False;True;False;False;False;False;Off;1;False;925;3;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Custom;InternalBark;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;550;10;False;553;0;0;False;550;0;False;553;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;False;False;_BILLBOARD_ON;Relative;300;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;14;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT3;0,0,0;False;0
WireConnection;1299;0;2700;0
WireConnection;1109;0;1102;0
WireConnection;1109;1;1102;5
WireConnection;1101;0;1299;1
WireConnection;1101;1;1109;0
WireConnection;1104;0;1299;0
WireConnection;1104;1;1101;0
WireConnection;2812;2;2700;0
WireConnection;2812;4;1104;0
WireConnection;2812;5;1826;0
WireConnection;2693;0;2911;1022
WireConnection;2617;0;2911;1021
WireConnection;587;0;2812;0
WireConnection;2695;0;2694;0
WireConnection;2691;0;2690;0
WireConnection;2696;0;2695;0
WireConnection;18;1;588;0
WireConnection;2242;0;2691;0
WireConnection;1415;1;2699;0
WireConnection;2781;0;2696;0
WireConnection;2781;1;2242;0
WireConnection;2836;89;18;0
WireConnection;2836;86;2215;0
WireConnection;2836;87;2216;0
WireConnection;2837;89;1415;0
WireConnection;2837;86;2808;0
WireConnection;2837;87;2809;0
WireConnection;607;1;604;0
WireConnection;607;5;655;0
WireConnection;645;1;644;0
WireConnection;2049;1;2699;0
WireConnection;1486;1;2699;0
WireConnection;1486;5;1488;0
WireConnection;2906;83;2781;0
WireConnection;2906;79;645;3
WireConnection;2906;85;409;0
WireConnection;2906;86;2836;37
WireConnection;2906;87;607;0
WireConnection;2906;89;645;2
WireConnection;2906;88;645;4
WireConnection;2906;80;2049;3
WireConnection;2906;91;2837;37
WireConnection;2906;92;1532;0
WireConnection;2906;93;1486;0
WireConnection;2906;90;2049;2
WireConnection;2906;94;2049;4
WireConnection;1501;0;2906;70
WireConnection;1539;0;2906;69
WireConnection;2612;0;2613;0
WireConnection;2612;1;2619;0
WireConnection;2451;0;2570;0
WireConnection;2451;1;2448;0
WireConnection;2859;1;2857;0
WireConnection;2683;2;2451;0
WireConnection;2683;4;2608;0
WireConnection;2683;5;2612;0
WireConnection;2869;0;2859;0
WireConnection;2892;1;2869;0
WireConnection;2892;4;2864;0
WireConnection;2892;5;2863;0
WireConnection;2892;6;2683;0
WireConnection;2892;9;2867;0
WireConnection;2893;1;2857;0
WireConnection;2894;0;2893;0
WireConnection;2894;1;2892;0
WireConnection;2870;0;2894;0
WireConnection;2861;1;2857;0
WireConnection;2886;0;2887;0
WireConnection;2886;1;2861;2
WireConnection;2886;2;2885;0
WireConnection;2895;0;2683;0
WireConnection;2077;0;2906;73
WireConnection;2872;0;2886;0
WireConnection;2860;1;2857;0
WireConnection;2860;5;2858;0
WireConnection;2873;0;2852;549
WireConnection;2873;1;2851;0
WireConnection;2873;2;2879;0
WireConnection;2873;3;2895;0
WireConnection;2884;0;2861;4
WireConnection;2884;1;2883;0
WireConnection;2871;0;2860;0
WireConnection;2071;0;2906;72
WireConnection;1512;0;2906;71
WireConnection;2692;0;2873;0
WireConnection;2877;0;2884;0
WireConnection;2739;0;2692;0
WireConnection;2853;0;2852;549
WireConnection;2853;1;2851;0
WireConnection;2853;2;2880;0
WireConnection;2853;3;2496;0
WireConnection;2875;0;2852;549
WireConnection;2875;1;2851;0
WireConnection;2875;2;2878;0
WireConnection;2875;3;654;0
WireConnection;2874;0;2852;549
WireConnection;2874;1;2851;0
WireConnection;2874;2;2876;0
WireConnection;2874;3;624;0
WireConnection;2912;12;2853;0
WireConnection;2912;48;2758;3
WireConnection;2912;26;2739;0
WireConnection;2845;56;2912;31
WireConnection;2845;55;2874;0
WireConnection;2845;41;2875;0
WireConnection;2845;189;2912;0
WireConnection;2789;0;2788;0
WireConnection;2787;0;2845;3
WireConnection;2787;1;2789;0
WireConnection;2841;41;2840;0
WireConnection;2841;58;2911;0
WireConnection;0;0;2845;4
WireConnection;0;2;2845;5
WireConnection;0;9;2841;0
WireConnection;0;14;2787;0
WireConnection;0;11;2841;91
ASEEND*/
//CHKSM=78AD52970EA49225F34A0306B2250387160777E2
