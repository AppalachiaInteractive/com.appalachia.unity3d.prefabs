// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "appalachia/leaf_LOD0"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.75
		[InternalBanner(Internal, Leaf)]_BANNER("BANNER", Float) = 1
		[InternalCategory(Cutoff)]_CUTOFFF("[ CUTOFFF ]", Float) = 0
		_CutoffLowNear("Cutoff Low (Near)", Range( 0 , 1)) = 0.7
		_CutoffHighNear("Cutoff High (Near)", Range( 0 , 1)) = 0.9
		_CutoffFar("Cutoff Far", Range( 6 , 64)) = 16
		_CutoffLowFar("Cutoff Low (Far)", Range( 0 , 1)) = 0.5
		_CutoffHighFar("Cutoff High (Far)", Range( 0 , 1)) = 0.7
		[InternalCategory(Leaf)]_LEAFF("[ LEAFF ]", Float) = 0
		[NoScaleOffset]_MainTex("Leaf Albedo", 2D) = "white" {}
		[NoScaleOffset]_BumpMap("Leaf Normal", 2D) = "bump" {}
		_BumpScale("Leaf Normal Scale", Range( 0 , 5)) = 1
		[NoScaleOffset]_MetallicGlossMap("Leaf Surface", 2D) = "white" {}
		_Glossiness("Leaf Smoothness", Range( 0 , 1)) = 0.1
		[InternalCategory(Color Map)]_COLORMAPP("[ COLOR MAPP ]", Float) = 0
		_SecondaryColor("Secondary Color", Color) = (0,0,0,0)
		_MaskedColor("Masked Color", Color) = (0,0,0,0)
		[NoScaleOffset]_ColorMap("Color Map", 2D) = "white" {}
		[IntRange]_ColorMapChannel("Color Map Channel", Range( 0 , 3)) = 0
		_ColorMapScale("Color Map Scale", Range( 0.1 , 2048)) = 10
		_ColorMapContrast("Color Map Contrast", Range( 0.1 , 2)) = 1
		_ColorMapBias("Color Map Bias", Range( -1 , 1)) = 0
		_Saturation("Leaf Saturation", Range( -1 , 1)) = 0
		_Brightness("Leaf Brightness", Range( -1 , 1)) = 0
		_Color("Primary Color", Color) = (1,1,1,1)
		_NonLeafColor("Non-Leaf Color", Color) = (0,0,0,0)
		[HideInInspector][InternalCategory(Backshading)]_BACKSHADINGG("[ BACKSHADINGG ]", Float) = 0
		_Backshade("Backshade", Color) = (0,0,0,0.3294118)
		_BackshadingBias("Backshading Bias", Range( -1 , 1)) = 0
		_BackshadingPower("Backshading Power", Range( 1 , 10)) = 2
		_BackshadingContrast("Backshading Contrast", Range( 0.1 , 5)) = 3
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
		[InternalCategory(Global Illumination)]_GLOBALILLUMINATIONN("[ GLOBAL ILLUMINATIONN ]", Float) = 0
		_GlobalIlluminationAlbedoEffect("Global Illumination Albedo Effect", Range( 0 , 5)) = 1
		_GlobalIlluminationEmissiveEffect("Global Illumination Emissive Effect", Range( 0 , 5)) = 1
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord3( "", 2D ) = "white" {}
		[Toggle]_IsLeaf("Is Leaf", Float) = 1
		[Toggle]_IsBark("Is Bark", Float) = 0
		[Toggle]_IsShadow("Is Shadow", Float) = 0
		[HideInInspector] _tex3coord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "InternalLeaf"  "Queue" = "AlphaTest+0" "DisableBatching" = "True" "IsEmissive" = "true"  }
		LOD 400
		Cull Off
		ZWrite On
		ZTest LEqual
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 4.0
		 





		// INTERNAL_SHADER_FEATURE_START

		// FEATURE_GPU_INSTANCER
		#include "UnityCG.cginc"
		#include "Assets/Resources/CGIncludes/GPUInstancerInclude.cginc"
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
			float3 worldPos;
			float2 uv_texcoord;
			float4 uv_tex4coord;
			float3 uv_tex3coord;
			float4 uv3_tex4coord3;
			float4 screenPosition;
			float4 vertexColor : COLOR;
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

		uniform half _COLORMAPP;
		uniform half _BACKSHADINGG;
		uniform half _TRANSMISSIONN;
		uniform half _TRANSLUCENCYY;
		uniform half _TRANSMITTANCEE;
		uniform half _GLOBALILLUMINATIONN;
		uniform half _IsShadow;
		uniform half _IsLeaf;
		uniform half _CUTOFFF;
		uniform half _IsBark;
		uniform half _BANNER;
		uniform half _LEAFF;
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
		uniform sampler2D _MetallicGlossMap;
		uniform half _Occlusion;
		uniform half _VertexOcclusion;
		uniform float4x4 _OcclusionProbesWorldToLocal;
		uniform sampler3D _OcclusionProbes;
		uniform float4 _OcclusionProbes_ST;
		uniform float _AOProbeStrength;
		uniform float _OCCLUSION_PROBE_GLOBAL;
		uniform float _AOIndirect;
		uniform float _AODirect;
		uniform sampler2D _MainTex;
		uniform half4 _SecondaryColor;
		uniform half4 _Color;
		uniform half4 _MaskedColor;
		uniform float _ColorMapBias;
		uniform float _ColorMapContrast;
		uniform sampler2D _ColorMap;
		uniform float _ColorMapScale;
		uniform float _ColorMapChannel;
		uniform float _Saturation;
		uniform float _Brightness;
		uniform half4 _NonLeafColor;
		uniform float4 _Backshade;
		uniform float _BackshadingContrast;
		uniform float _BackshadingBias;
		uniform float _BackshadingPower;
		uniform float _GlobalIlluminationEmissiveEffect;
		uniform half _CutoffLowFar;
		uniform half _CutoffLowNear;
		uniform half _CutoffFar;
		uniform half _CutoffHighFar;
		uniform half _CutoffHighNear;
		uniform half _BumpScale;
		uniform sampler2D _BumpMap;
		uniform half _Glossiness;
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
		uniform float _Cutoff = 0.75;


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


		void vertexDataFunc( inout appdata_full_custom v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float WIND_TRUNK_STRENGTH1235_g26354 = _WIND_TRUNK_STRENGTH;
			half localunity_ObjectToWorld0w1_g26433 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g26433 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g26433 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g26433 = (float3(localunity_ObjectToWorld0w1_g26433 , localunity_ObjectToWorld1w2_g26433 , localunity_ObjectToWorld2w3_g26433));
			float3 WIND_POSITION_OBJECT1195_g26354 = appendResult6_g26433;
			float2 temp_output_1_0_g26394 = (WIND_POSITION_OBJECT1195_g26354).xz;
			float WIND_BASE_TRUNK_FIELD_SIZE1238_g26354 = _WIND_BASE_TRUNK_FIELD_SIZE;
			float2 temp_cast_0 = (( 1.0 / (( WIND_BASE_TRUNK_FIELD_SIZE1238_g26354 == 0.0 ) ? 1.0 :  WIND_BASE_TRUNK_FIELD_SIZE1238_g26354 ) )).xx;
			float2 temp_output_2_0_g26394 = temp_cast_0;
			float2 temp_output_3_0_g26394 = float2( 0,0 );
			float2 temp_output_704_0_g26382 = ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g26394 / temp_output_2_0_g26394 ) :  ( temp_output_1_0_g26394 * temp_output_2_0_g26394 ) ) + temp_output_3_0_g26394 );
			float WIND_BASE_TRUNK_FREQUENCY1237_g26354 = ( 1.0 / (( _WIND_BASE_TRUNK_CYCLE_TIME == 0.0 ) ? 1.0 :  _WIND_BASE_TRUNK_CYCLE_TIME ) );
			float2 temp_output_721_0_g26382 = (WIND_BASE_TRUNK_FREQUENCY1237_g26354).xx;
			float2 break298_g26384 = ( temp_output_704_0_g26382 + ( temp_output_721_0_g26382 * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g26384 = (float2(sin( break298_g26384.x ) , cos( break298_g26384.y )));
			float4 temp_output_273_0_g26384 = (-1.0).xxxx;
			float4 temp_output_271_0_g26384 = (1.0).xxxx;
			float2 clampResult26_g26384 = clamp( appendResult299_g26384 , temp_output_273_0_g26384.xy , temp_output_271_0_g26384.xy );
			float WIND_BASE_AMPLITUDE1197_g26354 = _WIND_BASE_AMPLITUDE;
			float WIND_BASE_TRUNK_STRENGTH1236_g26354 = _WIND_BASE_TRUNK_STRENGTH;
			float2 temp_output_720_0_g26382 = (( WIND_BASE_AMPLITUDE1197_g26354 * WIND_BASE_TRUNK_STRENGTH1236_g26354 )).xx;
			float2 TRUNK_PIVOT_ROCKING701_g26382 = ( clampResult26_g26384 * temp_output_720_0_g26382 );
			float WIND_PRIMARY_ROLL1202_g26354 = v.color.r;
			float _WIND_PRIMARY_ROLL669_g26382 = WIND_PRIMARY_ROLL1202_g26354;
			float temp_output_54_0_g26383 = ( TRUNK_PIVOT_ROCKING701_g26382 * 0.05 * _WIND_PRIMARY_ROLL669_g26382 ).x;
			float temp_output_72_0_g26383 = cos( temp_output_54_0_g26383 );
			float one_minus_c52_g26383 = ( 1.0 - temp_output_72_0_g26383 );
			float3 break70_g26383 = float3(0,1,0);
			float axis_x25_g26383 = break70_g26383.x;
			float c66_g26383 = temp_output_72_0_g26383;
			float axis_y37_g26383 = break70_g26383.y;
			float axis_z29_g26383 = break70_g26383.z;
			float s67_g26383 = sin( temp_output_54_0_g26383 );
			float3 appendResult83_g26383 = (float3(( ( one_minus_c52_g26383 * axis_x25_g26383 * axis_x25_g26383 ) + c66_g26383 ) , ( ( one_minus_c52_g26383 * axis_x25_g26383 * axis_y37_g26383 ) - ( axis_z29_g26383 * s67_g26383 ) ) , ( ( one_minus_c52_g26383 * axis_z29_g26383 * axis_x25_g26383 ) + ( axis_y37_g26383 * s67_g26383 ) )));
			float3 appendResult81_g26383 = (float3(( ( one_minus_c52_g26383 * axis_x25_g26383 * axis_y37_g26383 ) + ( axis_z29_g26383 * s67_g26383 ) ) , ( ( one_minus_c52_g26383 * axis_y37_g26383 * axis_y37_g26383 ) + c66_g26383 ) , ( ( one_minus_c52_g26383 * axis_y37_g26383 * axis_z29_g26383 ) - ( axis_x25_g26383 * s67_g26383 ) )));
			float3 appendResult82_g26383 = (float3(( ( one_minus_c52_g26383 * axis_z29_g26383 * axis_x25_g26383 ) - ( axis_y37_g26383 * s67_g26383 ) ) , ( ( one_minus_c52_g26383 * axis_y37_g26383 * axis_z29_g26383 ) + ( axis_x25_g26383 * s67_g26383 ) ) , ( ( one_minus_c52_g26383 * axis_z29_g26383 * axis_z29_g26383 ) + c66_g26383 )));
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 WIND_PRIMARY_PIVOT1203_g26354 = (v.texcoord1).xyz;
			float3 _WIND_PRIMARY_PIVOT655_g26382 = WIND_PRIMARY_PIVOT1203_g26354;
			float3 temp_output_38_0_g26383 = ( ase_vertex3Pos - (_WIND_PRIMARY_PIVOT655_g26382).xyz );
			float2 break298_g26390 = ( temp_output_704_0_g26382 + ( temp_output_721_0_g26382 * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g26390 = (float2(sin( break298_g26390.x ) , cos( break298_g26390.y )));
			float4 temp_output_273_0_g26390 = (-1.0).xxxx;
			float4 temp_output_271_0_g26390 = (1.0).xxxx;
			float2 clampResult26_g26390 = clamp( appendResult299_g26390 , temp_output_273_0_g26390.xy , temp_output_271_0_g26390.xy );
			float2 TRUNK_SWIRL700_g26382 = ( clampResult26_g26390 * temp_output_720_0_g26382 );
			float2 break699_g26382 = TRUNK_SWIRL700_g26382;
			float3 appendResult698_g26382 = (float3(break699_g26382.x , 0.0 , break699_g26382.y));
			float3 temp_output_694_0_g26382 = ( ( mul( float3x3(appendResult83_g26383, appendResult81_g26383, appendResult82_g26383), temp_output_38_0_g26383 ) - temp_output_38_0_g26383 ) + ( _WIND_PRIMARY_ROLL669_g26382 * appendResult698_g26382 * 0.5 ) );
			float lerpResult632_g26395 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH , _WIND_AUDIO_INFLUENCE);
			float WIND_GUST_AUDIO_STRENGTH1242_g26354 = lerpResult632_g26395;
			float temp_output_15_0_g26439 = WIND_GUST_AUDIO_STRENGTH1242_g26354;
			float lerpResult635_g26395 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_LOW , _WIND_AUDIO_INFLUENCE);
			float WIND_GUST_AUDIO_LOW1246_g26354 = lerpResult635_g26395;
			float temp_output_16_0_g26439 = WIND_GUST_AUDIO_LOW1246_g26354;
			float WIND_GUST_TRUNK_STRENGTH1240_g26354 = _WIND_GUST_TRUNK_STRENGTH;
			float4 color658_g26370 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float WIND_GUST_TRUNK_CYCLE_TIME1241_g26354 = _WIND_GUST_TRUNK_CYCLE_TIME;
			float2 temp_cast_6 = (( 1.0 / (( WIND_GUST_TRUNK_CYCLE_TIME1241_g26354 == 0.0 ) ? 1.0 :  WIND_GUST_TRUNK_CYCLE_TIME1241_g26354 ) )).xx;
			float2 temp_output_61_0_g26374 = float2( 0,0 );
			float2 temp_output_1_0_g26375 = (WIND_POSITION_OBJECT1195_g26354).xz;
			float WIND_GUST_TRUNK_FIELD_SIZE1239_g26354 = _WIND_GUST_TRUNK_FIELD_SIZE;
			float temp_output_40_0_g26374 = ( 1.0 / (( WIND_GUST_TRUNK_FIELD_SIZE1239_g26354 == 0.0 ) ? 1.0 :  WIND_GUST_TRUNK_FIELD_SIZE1239_g26354 ) );
			float2 temp_cast_7 = (temp_output_40_0_g26374).xx;
			float2 temp_output_2_0_g26375 = temp_cast_7;
			float2 temp_output_3_0_g26375 = temp_output_61_0_g26374;
			float2 panner90_g26374 = ( _Time.y * temp_cast_6 + ( (( temp_output_61_0_g26374 > float2( 0,0 ) ) ? ( temp_output_1_0_g26375 / temp_output_2_0_g26375 ) :  ( temp_output_1_0_g26375 * temp_output_2_0_g26375 ) ) + temp_output_3_0_g26375 ));
			float temp_output_679_0_g26370 = 1.0;
			float4 temp_cast_8 = (temp_output_679_0_g26370).xxxx;
			float4 temp_output_52_0_g26374 = saturate( pow( tex2Dlod( _WIND_GUST_TEXTURE, float4( panner90_g26374, 0, 0.0) ) , temp_cast_8 ) );
			float4 lerpResult656_g26370 = lerp( color658_g26370 , temp_output_52_0_g26374 , temp_output_679_0_g26370);
			float4 break655_g26370 = lerpResult656_g26370;
			float4 _Vector0 = float4(0,0,0,0);
			float4 _Vector1 = float4(1,1,1,1);
			float _TRUNK1350_g26354 = ( ( ( temp_output_15_0_g26439 + temp_output_16_0_g26439 ) / 2.0 ) * WIND_GUST_TRUNK_STRENGTH1240_g26354 * (-0.45 + (( 1.0 - break655_g26370.b ) - _Vector0.x) * (1.0 - -0.45) / (_Vector1.x - _Vector0.x)) );
			float _WIND_GUST_STRENGTH703_g26382 = _TRUNK1350_g26354;
			float WIND_PRIMARY_BEND1204_g26354 = v.texcoord1.w;
			float _WIND_PRIMARY_BEND662_g26382 = WIND_PRIMARY_BEND1204_g26354;
			float temp_output_54_0_g26389 = ( -_WIND_GUST_STRENGTH703_g26382 * _WIND_PRIMARY_BEND662_g26382 );
			float temp_output_72_0_g26389 = cos( temp_output_54_0_g26389 );
			float one_minus_c52_g26389 = ( 1.0 - temp_output_72_0_g26389 );
			float3 WIND_DIRECTION1192_g26354 = _WIND_DIRECTION;
			float3 _WIND_DIRECTION671_g26382 = WIND_DIRECTION1192_g26354;
			float3 worldToObjDir719_g26382 = mul( unity_WorldToObject, float4( cross( _WIND_DIRECTION671_g26382 , float3(0,1,0) ), 0 ) ).xyz;
			float3 break70_g26389 = worldToObjDir719_g26382;
			float axis_x25_g26389 = break70_g26389.x;
			float c66_g26389 = temp_output_72_0_g26389;
			float axis_y37_g26389 = break70_g26389.y;
			float axis_z29_g26389 = break70_g26389.z;
			float s67_g26389 = sin( temp_output_54_0_g26389 );
			float3 appendResult83_g26389 = (float3(( ( one_minus_c52_g26389 * axis_x25_g26389 * axis_x25_g26389 ) + c66_g26389 ) , ( ( one_minus_c52_g26389 * axis_x25_g26389 * axis_y37_g26389 ) - ( axis_z29_g26389 * s67_g26389 ) ) , ( ( one_minus_c52_g26389 * axis_z29_g26389 * axis_x25_g26389 ) + ( axis_y37_g26389 * s67_g26389 ) )));
			float3 appendResult81_g26389 = (float3(( ( one_minus_c52_g26389 * axis_x25_g26389 * axis_y37_g26389 ) + ( axis_z29_g26389 * s67_g26389 ) ) , ( ( one_minus_c52_g26389 * axis_y37_g26389 * axis_y37_g26389 ) + c66_g26389 ) , ( ( one_minus_c52_g26389 * axis_y37_g26389 * axis_z29_g26389 ) - ( axis_x25_g26389 * s67_g26389 ) )));
			float3 appendResult82_g26389 = (float3(( ( one_minus_c52_g26389 * axis_z29_g26389 * axis_x25_g26389 ) - ( axis_y37_g26389 * s67_g26389 ) ) , ( ( one_minus_c52_g26389 * axis_y37_g26389 * axis_z29_g26389 ) + ( axis_x25_g26389 * s67_g26389 ) ) , ( ( one_minus_c52_g26389 * axis_z29_g26389 * axis_z29_g26389 ) + c66_g26389 )));
			float3 temp_output_38_0_g26389 = ( ase_vertex3Pos - (_WIND_PRIMARY_PIVOT655_g26382).xyz );
			float3 lerpResult538_g26382 = lerp( temp_output_694_0_g26382 , ( temp_output_694_0_g26382 + ( mul( float3x3(appendResult83_g26389, appendResult81_g26389, appendResult82_g26389), temp_output_38_0_g26389 ) - temp_output_38_0_g26389 ) ) , WIND_GUST_AUDIO_STRENGTH1242_g26354);
			float3 MOTION_TRUNK1337_g26354 = lerpResult538_g26382;
			float WIND_BRANCH_STRENGTH1224_g26354 = _WIND_BRANCH_STRENGTH;
			float3 _WIND_POSITION_ROOT1002_g26465 = WIND_POSITION_OBJECT1195_g26354;
			float2 temp_output_1_0_g26481 = (_WIND_POSITION_ROOT1002_g26465).xz;
			float WIND_BASE_BRANCH_FIELD_SIZE1218_g26354 = _WIND_BASE_BRANCH_FIELD_SIZE;
			float _WIND_BASE_BRANCH_FIELD_SIZE1004_g26465 = WIND_BASE_BRANCH_FIELD_SIZE1218_g26354;
			float2 temp_cast_11 = (( 1.0 / (( _WIND_BASE_BRANCH_FIELD_SIZE1004_g26465 == 0.0 ) ? 1.0 :  _WIND_BASE_BRANCH_FIELD_SIZE1004_g26465 ) )).xx;
			float2 temp_output_2_0_g26481 = temp_cast_11;
			float temp_output_587_552_g26417 = v.color.a;
			float WIND_PHASE1212_g26354 = temp_output_587_552_g26417;
			float _WIND_PHASE852_g26465 = WIND_PHASE1212_g26354;
			float WIND_BASE_BRANCH_VARIATION_STRENGTH1219_g26354 = _WIND_BASE_BRANCH_VARIATION_STRENGTH;
			float _WIND_BASE_BRANCH_VARIATION_STRENGTH1006_g26465 = WIND_BASE_BRANCH_VARIATION_STRENGTH1219_g26354;
			float2 temp_cast_12 = (( ( _WIND_PHASE852_g26465 * _WIND_BASE_BRANCH_VARIATION_STRENGTH1006_g26465 ) * UNITY_PI )).xx;
			float2 temp_output_3_0_g26481 = temp_cast_12;
			float WIND_BASE_BRANCH_FREQUENCY1217_g26354 = ( 1.0 / (( _WIND_BASE_BRANCH_CYCLE_TIME == 0.0 ) ? 1.0 :  _WIND_BASE_BRANCH_CYCLE_TIME ) );
			float2 break298_g26482 = ( ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g26481 / temp_output_2_0_g26481 ) :  ( temp_output_1_0_g26481 * temp_output_2_0_g26481 ) ) + temp_output_3_0_g26481 ) + ( (( WIND_BASE_BRANCH_FREQUENCY1217_g26354 * _WIND_PHASE852_g26465 )).xx * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g26482 = (float2(sin( break298_g26482.x ) , cos( break298_g26482.y )));
			float4 temp_output_273_0_g26482 = (-1.0).xxxx;
			float4 temp_output_271_0_g26482 = (1.0).xxxx;
			float2 clampResult26_g26482 = clamp( appendResult299_g26482 , temp_output_273_0_g26482.xy , temp_output_271_0_g26482.xy );
			float WIND_BASE_BRANCH_STRENGTH1227_g26354 = _WIND_BASE_BRANCH_STRENGTH;
			float2 BRANCH_SWIRL931_g26465 = ( clampResult26_g26482 * (( WIND_BASE_AMPLITUDE1197_g26354 * WIND_BASE_BRANCH_STRENGTH1227_g26354 )).xx );
			float2 break932_g26465 = BRANCH_SWIRL931_g26465;
			float3 appendResult933_g26465 = (float3(break932_g26465.x , 0.0 , break932_g26465.y));
			float WIND_SECONDARY_ROLL1205_g26354 = v.color.g;
			float _WIND_SECONDARY_ROLL650_g26465 = WIND_SECONDARY_ROLL1205_g26354;
			float3 VALUE_ROLL1034_g26465 = ( appendResult933_g26465 * _WIND_SECONDARY_ROLL650_g26465 * 0.5 );
			float3 _WIND_DIRECTION856_g26465 = WIND_DIRECTION1192_g26354;
			float3 WIND_SECONDARY_GROWTH_DIRECTION1208_g26354 = (v.texcoord2).xyz;
			float3 temp_output_839_0_g26465 = WIND_SECONDARY_GROWTH_DIRECTION1208_g26354;
			float3 _WIND_SECONDARY_GROWTH_DIRECTION = float3(0,1,0);
			float3 objToWorldDir1174_g26465 = mul( unity_ObjectToWorld, float4( (( length( temp_output_839_0_g26465 ) == 0.0 ) ? _WIND_SECONDARY_GROWTH_DIRECTION :  temp_output_839_0_g26465 ), 0 ) ).xyz;
			float3 _WIND_SECONDARY_GROWTH_DIRECTION840_g26465 = (objToWorldDir1174_g26465).xyz;
			float dotResult565_g26465 = dot( _WIND_DIRECTION856_g26465 , _WIND_SECONDARY_GROWTH_DIRECTION840_g26465 );
			float clampResult13_g26474 = clamp( dotResult565_g26465 , -1.0 , 1.0 );
			float4 color658_g26364 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float WIND_GUST_BRANCH_CYCLE_TIME1220_g26354 = _WIND_GUST_BRANCH_CYCLE_TIME;
			float clampResult3_g26426 = clamp( temp_output_587_552_g26417 , 0.0 , 1.0 );
			float WIND_PHASE_UNPACKED1530_g26354 = ( ( clampResult3_g26426 * 2.0 ) - 1.0 );
			float2 temp_cast_15 = (( 1.0 / (( ( WIND_GUST_BRANCH_CYCLE_TIME1220_g26354 + ( WIND_GUST_BRANCH_CYCLE_TIME1220_g26354 * WIND_PHASE_UNPACKED1530_g26354 * 0.1 ) ) == 0.0 ) ? 1.0 :  ( WIND_GUST_BRANCH_CYCLE_TIME1220_g26354 + ( WIND_GUST_BRANCH_CYCLE_TIME1220_g26354 * WIND_PHASE_UNPACKED1530_g26354 * 0.1 ) ) ) )).xx;
			float2 temp_output_61_0_g26368 = float2( 0,0 );
			float3 WIND_SECONDARY_PIVOT1206_g26354 = (v.texcoord3).xyz;
			float WIND_GUST_BRANCH_VARIATION_STRENGTH1223_g26354 = _WIND_GUST_BRANCH_VARIATION_STRENGTH;
			float2 temp_output_1_0_g26369 = ( (WIND_POSITION_OBJECT1195_g26354).xz + (WIND_SECONDARY_PIVOT1206_g26354).xy + ( WIND_PHASE1212_g26354 * WIND_GUST_BRANCH_VARIATION_STRENGTH1223_g26354 ) );
			float WIND_GUST_BRANCH_FIELD_SIZE1222_g26354 = _WIND_GUST_BRANCH_FIELD_SIZE;
			float temp_output_40_0_g26368 = ( 1.0 / (( WIND_GUST_BRANCH_FIELD_SIZE1222_g26354 == 0.0 ) ? 1.0 :  WIND_GUST_BRANCH_FIELD_SIZE1222_g26354 ) );
			float2 temp_cast_16 = (temp_output_40_0_g26368).xx;
			float2 temp_output_2_0_g26369 = temp_cast_16;
			float2 temp_output_3_0_g26369 = temp_output_61_0_g26368;
			float2 panner90_g26368 = ( _Time.y * temp_cast_15 + ( (( temp_output_61_0_g26368 > float2( 0,0 ) ) ? ( temp_output_1_0_g26369 / temp_output_2_0_g26369 ) :  ( temp_output_1_0_g26369 * temp_output_2_0_g26369 ) ) + temp_output_3_0_g26369 ));
			float temp_output_679_0_g26364 = 1.0;
			float4 temp_cast_17 = (temp_output_679_0_g26364).xxxx;
			float4 temp_output_52_0_g26368 = saturate( pow( tex2Dlod( _WIND_GUST_TEXTURE, float4( panner90_g26368, 0, 0.0) ) , temp_cast_17 ) );
			float4 lerpResult656_g26364 = lerp( color658_g26364 , temp_output_52_0_g26368 , temp_output_679_0_g26364);
			float4 break655_g26364 = lerpResult656_g26364;
			float temp_output_15_0_g26431 = break655_g26364.r;
			float temp_output_16_0_g26431 = ( 1.0 - break655_g26364.b );
			float temp_output_15_0_g26444 = WIND_GUST_AUDIO_STRENGTH1242_g26354;
			float lerpResult634_g26395 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_MID , _WIND_AUDIO_INFLUENCE);
			float WIND_GUST_AUDIO_MID1245_g26354 = lerpResult634_g26395;
			float temp_output_16_0_g26444 = WIND_GUST_AUDIO_MID1245_g26354;
			float temp_output_1516_14_g26354 = ( ( temp_output_15_0_g26444 + temp_output_16_0_g26444 ) / 2.0 );
			float WIND_GUST_BRANCH_STRENGTH1229_g26354 = _WIND_GUST_BRANCH_STRENGTH;
			float WIND_GUST_BRANCH_STRENGTH_OPPOSITE1573_g26354 = _WIND_GUST_BRANCH_STRENGTH_OPPOSITE;
			float _BRANCH_OPPOSITE_DOWN1466_g26354 = ( (-0.1 + (( ( temp_output_15_0_g26431 + temp_output_16_0_g26431 ) / 2.0 ) - _Vector0.x) * (0.75 - -0.1) / (_Vector1.x - _Vector0.x)) * temp_output_1516_14_g26354 * WIND_GUST_BRANCH_STRENGTH1229_g26354 * WIND_GUST_BRANCH_STRENGTH_OPPOSITE1573_g26354 );
			float _GUST_STRENGTH_OPPOSITE_DOWN1188_g26465 = _BRANCH_OPPOSITE_DOWN1466_g26354;
			float temp_output_15_0_g26414 = ( 1.0 - break655_g26364.g );
			float temp_output_16_0_g26414 = break655_g26364.a;
			float _BRANCH_OPPOSITE_UP1348_g26354 = ( (-0.3 + (( ( temp_output_15_0_g26414 + temp_output_16_0_g26414 ) / 2.0 ) - _Vector0.x) * (1.0 - -0.3) / (_Vector1.x - _Vector0.x)) * temp_output_1516_14_g26354 * WIND_GUST_BRANCH_STRENGTH1229_g26354 * WIND_GUST_BRANCH_STRENGTH_OPPOSITE1573_g26354 );
			float _GUST_STRENGTH_OPPOSITE_UP871_g26465 = _BRANCH_OPPOSITE_UP1348_g26354;
			float dotResult1180_g26465 = dot( _WIND_SECONDARY_GROWTH_DIRECTION840_g26465 , float3(0,1,0) );
			float clampResult8_g26487 = clamp( dotResult1180_g26465 , -1.0 , 1.0 );
			float _WIND_SECONDARY_VERTICALITY843_g26465 = ( ( clampResult8_g26487 * 0.5 ) + 0.5 );
			float temp_output_2_0_g26489 = _WIND_SECONDARY_VERTICALITY843_g26465;
			float temp_output_3_0_g26489 = 0.5;
			float temp_output_21_0_g26489 = 1.0;
			float temp_output_26_0_g26489 = 0.0;
			float lerpResult1_g26493 = lerp( _GUST_STRENGTH_OPPOSITE_DOWN1188_g26465 , -_GUST_STRENGTH_OPPOSITE_UP871_g26465 , saturate( saturate( (( temp_output_2_0_g26489 >= temp_output_3_0_g26489 ) ? temp_output_21_0_g26489 :  temp_output_26_0_g26489 ) ) ));
			float WIND_SECONDARY_BEND1207_g26354 = v.texcoord3.w;
			float _WIND_SECONDARY_BEND849_g26465 = WIND_SECONDARY_BEND1207_g26354;
			float clampResult1170_g26465 = clamp( _WIND_SECONDARY_BEND849_g26465 , 0.0 , 0.75 );
			float clampResult1175_g26465 = clamp( ( lerpResult1_g26493 * clampResult1170_g26465 ) , -1.5 , 1.5 );
			float temp_output_54_0_g26471 = clampResult1175_g26465;
			float temp_output_72_0_g26471 = cos( temp_output_54_0_g26471 );
			float one_minus_c52_g26471 = ( 1.0 - temp_output_72_0_g26471 );
			float3 worldToObjDir1173_g26465 = mul( unity_WorldToObject, float4( cross( _WIND_DIRECTION856_g26465 , float3(0,1,0) ), 0 ) ).xyz;
			float3 break70_g26471 = worldToObjDir1173_g26465;
			float axis_x25_g26471 = break70_g26471.x;
			float c66_g26471 = temp_output_72_0_g26471;
			float axis_y37_g26471 = break70_g26471.y;
			float axis_z29_g26471 = break70_g26471.z;
			float s67_g26471 = sin( temp_output_54_0_g26471 );
			float3 appendResult83_g26471 = (float3(( ( one_minus_c52_g26471 * axis_x25_g26471 * axis_x25_g26471 ) + c66_g26471 ) , ( ( one_minus_c52_g26471 * axis_x25_g26471 * axis_y37_g26471 ) - ( axis_z29_g26471 * s67_g26471 ) ) , ( ( one_minus_c52_g26471 * axis_z29_g26471 * axis_x25_g26471 ) + ( axis_y37_g26471 * s67_g26471 ) )));
			float3 appendResult81_g26471 = (float3(( ( one_minus_c52_g26471 * axis_x25_g26471 * axis_y37_g26471 ) + ( axis_z29_g26471 * s67_g26471 ) ) , ( ( one_minus_c52_g26471 * axis_y37_g26471 * axis_y37_g26471 ) + c66_g26471 ) , ( ( one_minus_c52_g26471 * axis_y37_g26471 * axis_z29_g26471 ) - ( axis_x25_g26471 * s67_g26471 ) )));
			float3 appendResult82_g26471 = (float3(( ( one_minus_c52_g26471 * axis_z29_g26471 * axis_x25_g26471 ) - ( axis_y37_g26471 * s67_g26471 ) ) , ( ( one_minus_c52_g26471 * axis_y37_g26471 * axis_z29_g26471 ) + ( axis_x25_g26471 * s67_g26471 ) ) , ( ( one_minus_c52_g26471 * axis_z29_g26471 * axis_z29_g26471 ) + c66_g26471 )));
			float3 _WIND_SECONDARY_PIVOT846_g26465 = WIND_SECONDARY_PIVOT1206_g26354;
			float3 temp_output_38_0_g26471 = ( ase_vertex3Pos - (_WIND_SECONDARY_PIVOT846_g26465).xyz );
			float3 VALUE_FACING_WIND1042_g26465 = ( mul( float3x3(appendResult83_g26471, appendResult81_g26471, appendResult82_g26471), temp_output_38_0_g26471 ) - temp_output_38_0_g26471 );
			float2 temp_output_1_0_g26466 = (_WIND_SECONDARY_PIVOT846_g26465).xz;
			float _WIND_GUST_BRANCH_FIELD_SIZE1011_g26465 = WIND_GUST_BRANCH_FIELD_SIZE1222_g26354;
			float2 temp_cast_22 = (( 1.0 / (( _WIND_GUST_BRANCH_FIELD_SIZE1011_g26465 == 0.0 ) ? 1.0 :  _WIND_GUST_BRANCH_FIELD_SIZE1011_g26465 ) )).xx;
			float2 temp_output_2_0_g26466 = temp_cast_22;
			float _WIND_GUST_BRANCH_VARIATION_STRENGTH1008_g26465 = WIND_GUST_BRANCH_VARIATION_STRENGTH1223_g26354;
			float2 temp_cast_23 = (( ( _WIND_PHASE852_g26465 * _WIND_GUST_BRANCH_VARIATION_STRENGTH1008_g26465 ) * UNITY_PI )).xx;
			float2 temp_output_3_0_g26466 = temp_cast_23;
			float WIND_GUST_BRANCH_FREQUENCY1221_g26354 = ( 1.0 / (( _WIND_GUST_BRANCH_CYCLE_TIME == 0.0 ) ? 1.0 :  _WIND_GUST_BRANCH_CYCLE_TIME ) );
			float _WIND_GUST_BRANCH_FREQUENCY1012_g26465 = WIND_GUST_BRANCH_FREQUENCY1221_g26354;
			float2 break298_g26467 = ( ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g26466 / temp_output_2_0_g26466 ) :  ( temp_output_1_0_g26466 * temp_output_2_0_g26466 ) ) + temp_output_3_0_g26466 ) + ( (_WIND_GUST_BRANCH_FREQUENCY1012_g26465).xx * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g26467 = (float2(sin( break298_g26467.x ) , cos( break298_g26467.y )));
			float4 temp_output_273_0_g26467 = (-1.0).xxxx;
			float4 temp_output_271_0_g26467 = (1.0).xxxx;
			float2 clampResult26_g26467 = clamp( appendResult299_g26467 , temp_output_273_0_g26467.xy , temp_output_271_0_g26467.xy );
			float2 break305_g26467 = float2( -0.25,1 );
			float temp_output_15_0_g26430 = ( 1.0 - break655_g26364.r );
			float temp_output_16_0_g26430 = break655_g26364.g;
			float WIND_GUST_BRANCH_STRENGTH_PERPENDICULAR1574_g26354 = _WIND_GUST_BRANCH_STRENGTH_PERPENDICULAR;
			float _BRANCH_PERPENDICULAR1431_g26354 = ( (-0.1 + (( ( temp_output_15_0_g26430 + temp_output_16_0_g26430 ) / 2.0 ) - _Vector0.x) * (0.9 - -0.1) / (_Vector1.x - _Vector0.x)) * temp_output_1516_14_g26354 * WIND_GUST_BRANCH_STRENGTH1229_g26354 * WIND_GUST_BRANCH_STRENGTH_PERPENDICULAR1574_g26354 );
			float _GUST_STRENGTH_PERPENDICULAR999_g26465 = _BRANCH_PERPENDICULAR1431_g26354;
			float2 break1067_g26465 = ( ( ((break305_g26467.x).xxxx.xy + (clampResult26_g26467 - temp_output_273_0_g26467.xy) * ((break305_g26467.y).xxxx.xy - (break305_g26467.x).xxxx.xy) / (temp_output_271_0_g26467.xy - temp_output_273_0_g26467.xy)) * (_GUST_STRENGTH_PERPENDICULAR999_g26465).xx ) * _WIND_SECONDARY_ROLL650_g26465 );
			float3 appendResult1066_g26465 = (float3(break1067_g26465.x , 0.0 , break1067_g26465.y));
			float3 worldToObjDir1089_g26465 = normalize( mul( unity_WorldToObject, float4( _WIND_DIRECTION856_g26465, 0 ) ).xyz );
			float3 BRANCH_SWIRL972_g26465 = ( appendResult1066_g26465 * worldToObjDir1089_g26465 );
			float3 VALUE_PERPENDICULAR1041_g26465 = BRANCH_SWIRL972_g26465;
			float3 temp_output_3_0_g26474 = VALUE_PERPENDICULAR1041_g26465;
			float3 lerpResult1_g26480 = lerp( VALUE_FACING_WIND1042_g26465 , temp_output_3_0_g26474 , saturate( ( 1.0 + clampResult13_g26474 ) ));
			float temp_output_15_0_g26357 = break655_g26364.b;
			float temp_output_16_0_g26357 = ( 1.0 - break655_g26364.a );
			float clampResult3_g26415 = clamp( ( ( temp_output_15_0_g26357 + temp_output_16_0_g26357 ) / 2.0 ) , 0.0 , 1.0 );
			float WIND_GUST_BRANCH_STRENGTH_PARALLEL1575_g26354 = _WIND_GUST_BRANCH_STRENGTH_PARALLEL;
			float _BRANCH_PARALLEL1432_g26354 = ( ( ( clampResult3_g26415 * 2.0 ) - 1.0 ) * temp_output_1516_14_g26354 * WIND_GUST_BRANCH_STRENGTH1229_g26354 * WIND_GUST_BRANCH_STRENGTH_PARALLEL1575_g26354 );
			float _GUST_STRENGTH_PARALLEL1110_g26465 = _BRANCH_PARALLEL1432_g26354;
			float clampResult1167_g26465 = clamp( ( _GUST_STRENGTH_PARALLEL1110_g26465 * _WIND_SECONDARY_BEND849_g26465 ) , -1.5 , 1.5 );
			float temp_output_54_0_g26472 = clampResult1167_g26465;
			float temp_output_72_0_g26472 = cos( temp_output_54_0_g26472 );
			float one_minus_c52_g26472 = ( 1.0 - temp_output_72_0_g26472 );
			float3 break70_g26472 = float3(0,1,0);
			float axis_x25_g26472 = break70_g26472.x;
			float c66_g26472 = temp_output_72_0_g26472;
			float axis_y37_g26472 = break70_g26472.y;
			float axis_z29_g26472 = break70_g26472.z;
			float s67_g26472 = sin( temp_output_54_0_g26472 );
			float3 appendResult83_g26472 = (float3(( ( one_minus_c52_g26472 * axis_x25_g26472 * axis_x25_g26472 ) + c66_g26472 ) , ( ( one_minus_c52_g26472 * axis_x25_g26472 * axis_y37_g26472 ) - ( axis_z29_g26472 * s67_g26472 ) ) , ( ( one_minus_c52_g26472 * axis_z29_g26472 * axis_x25_g26472 ) + ( axis_y37_g26472 * s67_g26472 ) )));
			float3 appendResult81_g26472 = (float3(( ( one_minus_c52_g26472 * axis_x25_g26472 * axis_y37_g26472 ) + ( axis_z29_g26472 * s67_g26472 ) ) , ( ( one_minus_c52_g26472 * axis_y37_g26472 * axis_y37_g26472 ) + c66_g26472 ) , ( ( one_minus_c52_g26472 * axis_y37_g26472 * axis_z29_g26472 ) - ( axis_x25_g26472 * s67_g26472 ) )));
			float3 appendResult82_g26472 = (float3(( ( one_minus_c52_g26472 * axis_z29_g26472 * axis_x25_g26472 ) - ( axis_y37_g26472 * s67_g26472 ) ) , ( ( one_minus_c52_g26472 * axis_y37_g26472 * axis_z29_g26472 ) + ( axis_x25_g26472 * s67_g26472 ) ) , ( ( one_minus_c52_g26472 * axis_z29_g26472 * axis_z29_g26472 ) + c66_g26472 )));
			float3 temp_output_38_0_g26472 = ( ase_vertex3Pos - (_WIND_SECONDARY_PIVOT846_g26465).xyz );
			float3 VALUE_AWAY_FROM_WIND1040_g26465 = ( mul( float3x3(appendResult83_g26472, appendResult81_g26472, appendResult82_g26472), temp_output_38_0_g26472 ) - temp_output_38_0_g26472 );
			float3 lerpResult1_g26475 = lerp( temp_output_3_0_g26474 , VALUE_AWAY_FROM_WIND1040_g26465 , saturate( clampResult13_g26474 ));
			float3 lerpResult631_g26465 = lerp( VALUE_ROLL1034_g26465 , (( clampResult13_g26474 < 0.0 ) ? lerpResult1_g26480 :  lerpResult1_g26475 ) , WIND_GUST_AUDIO_STRENGTH1242_g26354);
			float3 MOTION_BRANCH1339_g26354 = lerpResult631_g26465;
			float WIND_LEAF_STRENGTH1179_g26354 = _WIND_LEAF_STRENGTH;
			float temp_output_17_0_g26410 = 3.0;
			float TYPE_DESIGNATOR1209_g26354 = round( v.texcoord2.w );
			float temp_output_18_0_g26410 = TYPE_DESIGNATOR1209_g26354;
			float WIND_TERTIARY_ROLL1210_g26354 = v.color.b;
			float _WIND_TERTIARY_ROLL669_g26445 = WIND_TERTIARY_ROLL1210_g26354;
			float3 temp_output_615_0_g26432 = ( float3( 0,0,0 ) + ase_vertex3Pos );
			float3 WIND_POSITION_VERTEX_OBJECT1193_g26354 = temp_output_615_0_g26432;
			float2 temp_output_1_0_g26446 = (WIND_POSITION_VERTEX_OBJECT1193_g26354).xz;
			float WIND_BASE_LEAF_FIELD_SIZE1182_g26354 = _WIND_BASE_LEAF_FIELD_SIZE;
			float2 temp_output_2_0_g26446 = (WIND_BASE_LEAF_FIELD_SIZE1182_g26354).xx;
			float _WIND_VARIATION662_g26445 = WIND_PHASE1212_g26354;
			float2 temp_output_3_0_g26446 = (_WIND_VARIATION662_g26445).xx;
			float2 temp_output_704_0_g26445 = ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g26446 / temp_output_2_0_g26446 ) :  ( temp_output_1_0_g26446 * temp_output_2_0_g26446 ) ) + temp_output_3_0_g26446 );
			float WIND_BASE_LEAF_FREQUENCY1264_g26354 = ( 1.0 / (( _WIND_BASE_LEAF_CYCLE_TIME == 0.0 ) ? 1.0 :  _WIND_BASE_LEAF_CYCLE_TIME ) );
			float temp_output_618_0_g26445 = WIND_BASE_LEAF_FREQUENCY1264_g26354;
			float2 break298_g26447 = ( temp_output_704_0_g26445 + ( (temp_output_618_0_g26445).xx * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g26447 = (float2(sin( break298_g26447.x ) , cos( break298_g26447.y )));
			float4 temp_output_273_0_g26447 = (-1.0).xxxx;
			float4 temp_output_271_0_g26447 = (1.0).xxxx;
			float2 clampResult26_g26447 = clamp( appendResult299_g26447 , temp_output_273_0_g26447.xy , temp_output_271_0_g26447.xy );
			float WIND_BASE_LEAF_STRENGTH1180_g26354 = _WIND_BASE_LEAF_STRENGTH;
			float2 temp_output_1031_0_g26445 = (( WIND_BASE_LEAF_STRENGTH1180_g26354 * WIND_BASE_AMPLITUDE1197_g26354 )).xx;
			float2 break699_g26445 = ( clampResult26_g26447 * temp_output_1031_0_g26445 );
			float2 break298_g26451 = ( temp_output_704_0_g26445 + ( (( 0.71 * temp_output_618_0_g26445 )).xx * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g26451 = (float2(sin( break298_g26451.x ) , cos( break298_g26451.y )));
			float4 temp_output_273_0_g26451 = (-1.0).xxxx;
			float4 temp_output_271_0_g26451 = (1.0).xxxx;
			float2 clampResult26_g26451 = clamp( appendResult299_g26451 , temp_output_273_0_g26451.xy , temp_output_271_0_g26451.xy );
			float3 appendResult698_g26445 = (float3(break699_g26445.x , ( clampResult26_g26451 * temp_output_1031_0_g26445 ).x , break699_g26445.y));
			float3 temp_output_684_0_g26445 = ( _WIND_TERTIARY_ROLL669_g26445 * appendResult698_g26445 );
			float3 _WIND_DIRECTION671_g26445 = WIND_DIRECTION1192_g26354;
			float3 worldToObjDir1006_g26445 = mul( unity_WorldToObject, float4( _WIND_DIRECTION671_g26445, 0 ) ).xyz;
			float WIND_GUST_LEAF_STRENGTH1183_g26354 = _WIND_GUST_LEAF_STRENGTH;
			float lerpResult638_g26395 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_VERYHIGH , _WIND_AUDIO_INFLUENCE);
			float WIND_GUST_AUDIO_VERYHIGH1243_g26354 = lerpResult638_g26395;
			float4 color658_g26399 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float2 temp_output_61_0_g26401 = float2( 0,0 );
			float WIND_VARIATION1211_g26354 = v.texcoord.w;
			half localunity_ObjectToWorld0w1_g26355 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld2w3_g26355 = ( unity_ObjectToWorld[2].w );
			float2 appendResult1374_g26354 = (float2(localunity_ObjectToWorld0w1_g26355 , localunity_ObjectToWorld2w3_g26355));
			float2 temp_output_1_0_g26402 = ( ( 10.0 * WIND_VARIATION1211_g26354 ) + appendResult1374_g26354 );
			float WIND_GUST_LEAF_FIELD_SIZE1185_g26354 = _WIND_GUST_LEAF_FIELD_SIZE;
			float temp_output_40_0_g26401 = ( 1.0 / (( WIND_GUST_LEAF_FIELD_SIZE1185_g26354 == 0.0 ) ? 1.0 :  WIND_GUST_LEAF_FIELD_SIZE1185_g26354 ) );
			float2 temp_cast_37 = (temp_output_40_0_g26401).xx;
			float2 temp_output_2_0_g26402 = temp_cast_37;
			float2 temp_output_3_0_g26402 = temp_output_61_0_g26401;
			float clampResult3_g26411 = clamp( WIND_VARIATION1211_g26354 , 0.0 , 1.0 );
			float WIND_GUST_LEAF_CYCLE_TIME1184_g26354 = _WIND_GUST_LEAF_CYCLE_TIME;
			float mulTime37_g26401 = _Time.y * ( 1.0 / (( ( ( ( ( clampResult3_g26411 * 2.0 ) - 1.0 ) * 0.3 * WIND_GUST_LEAF_CYCLE_TIME1184_g26354 ) + WIND_GUST_LEAF_CYCLE_TIME1184_g26354 ) == 0.0 ) ? 1.0 :  ( ( ( ( clampResult3_g26411 * 2.0 ) - 1.0 ) * 0.3 * WIND_GUST_LEAF_CYCLE_TIME1184_g26354 ) + WIND_GUST_LEAF_CYCLE_TIME1184_g26354 ) ) );
			float temp_output_220_0_g26404 = -1.0;
			float4 temp_cast_38 = (temp_output_220_0_g26404).xxxx;
			float temp_output_219_0_g26404 = 1.0;
			float4 temp_cast_39 = (temp_output_219_0_g26404).xxxx;
			float4 clampResult26_g26404 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g26401 > float2( 0,0 ) ) ? ( temp_output_1_0_g26402 / temp_output_2_0_g26402 ) :  ( temp_output_1_0_g26402 * temp_output_2_0_g26402 ) ) + temp_output_3_0_g26402 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g26401 ) ) , temp_cast_38 , temp_cast_39 );
			float4 temp_cast_40 = (temp_output_220_0_g26404).xxxx;
			float4 temp_cast_41 = (temp_output_219_0_g26404).xxxx;
			float4 temp_cast_42 = (0.0).xxxx;
			float4 temp_cast_43 = (temp_output_219_0_g26404).xxxx;
			float temp_output_679_0_g26399 = 1.0;
			float4 temp_cast_44 = (temp_output_679_0_g26399).xxxx;
			float4 temp_output_52_0_g26401 = saturate( pow( abs( (temp_cast_42 + (clampResult26_g26404 - temp_cast_40) * (temp_cast_43 - temp_cast_42) / (temp_cast_41 - temp_cast_40)) ) , temp_cast_44 ) );
			float4 lerpResult656_g26399 = lerp( color658_g26399 , temp_output_52_0_g26401 , temp_output_679_0_g26399);
			float4 break655_g26399 = lerpResult656_g26399;
			float LEAF_GUST1375_g26354 = ( WIND_GUST_LEAF_STRENGTH1183_g26354 * WIND_GUST_AUDIO_VERYHIGH1243_g26354 * break655_g26399.g );
			float _WIND_GUST_STRENGTH703_g26445 = LEAF_GUST1375_g26354;
			float3 _GUST1018_g26445 = ( worldToObjDir1006_g26445 * _WIND_GUST_STRENGTH703_g26445 );
			float WIND_GUST_LEAF_MID_STRENGTH1186_g26354 = _WIND_GUST_LEAF_MID_STRENGTH;
			float lerpResult633_g26395 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_HIGH , _WIND_AUDIO_INFLUENCE);
			float WIND_GUST_AUDIO_HIGH1244_g26354 = lerpResult633_g26395;
			float4 color658_g26358 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float WIND_GUST_LEAF_MID_CYCLE_TIME1187_g26354 = _WIND_GUST_LEAF_MID_CYCLE_TIME;
			float2 temp_cast_45 = (( 1.0 / (( ( WIND_GUST_LEAF_MID_CYCLE_TIME1187_g26354 + ( WIND_VARIATION1211_g26354 * -0.05 ) ) == 0.0 ) ? 1.0 :  ( WIND_GUST_LEAF_MID_CYCLE_TIME1187_g26354 + ( WIND_VARIATION1211_g26354 * -0.05 ) ) ) )).xx;
			float2 temp_output_61_0_g26362 = float2( 0,0 );
			float2 appendResult1400_g26354 = (float2(ase_vertex3Pos.x , ase_vertex3Pos.z));
			float2 temp_output_1_0_g26363 = ( (WIND_VARIATION1211_g26354).xx + appendResult1400_g26354 );
			float WIND_GUST_LEAF_MID_FIELD_SIZE1188_g26354 = _WIND_GUST_LEAF_MID_FIELD_SIZE;
			float temp_output_40_0_g26362 = ( 1.0 / (( WIND_GUST_LEAF_MID_FIELD_SIZE1188_g26354 == 0.0 ) ? 1.0 :  WIND_GUST_LEAF_MID_FIELD_SIZE1188_g26354 ) );
			float2 temp_cast_46 = (temp_output_40_0_g26362).xx;
			float2 temp_output_2_0_g26363 = temp_cast_46;
			float2 temp_output_3_0_g26363 = temp_output_61_0_g26362;
			float2 panner90_g26362 = ( _Time.y * temp_cast_45 + ( (( temp_output_61_0_g26362 > float2( 0,0 ) ) ? ( temp_output_1_0_g26363 / temp_output_2_0_g26363 ) :  ( temp_output_1_0_g26363 * temp_output_2_0_g26363 ) ) + temp_output_3_0_g26363 ));
			float temp_output_679_0_g26358 = 1.0;
			float4 temp_cast_47 = (temp_output_679_0_g26358).xxxx;
			float4 temp_output_52_0_g26362 = saturate( pow( tex2Dlod( _WIND_GUST_TEXTURE, float4( panner90_g26362, 0, 0.0) ) , temp_cast_47 ) );
			float4 lerpResult656_g26358 = lerp( color658_g26358 , temp_output_52_0_g26362 , temp_output_679_0_g26358);
			float4 break655_g26358 = lerpResult656_g26358;
			float temp_output_1557_630_g26354 = break655_g26358.r;
			float LEAF_GUST_MID1397_g26354 = ( WIND_GUST_LEAF_MID_STRENGTH1186_g26354 * WIND_GUST_AUDIO_HIGH1244_g26354 * temp_output_1557_630_g26354 * temp_output_1557_630_g26354 );
			float _WIND_GUST_STRENGTH_MID829_g26445 = LEAF_GUST_MID1397_g26354;
			float3 _GUST_MID1019_g26445 = ( worldToObjDir1006_g26445 * _WIND_GUST_STRENGTH_MID829_g26445 );
			float3 ase_vertexNormal = v.normal.xyz;
			float3 _LEAF_NORMAL992_g26445 = ase_vertexNormal;
			float dotResult1_g26457 = dot( worldToObjDir1006_g26445 , _LEAF_NORMAL992_g26445 );
			float clampResult13_g26458 = clamp( dotResult1_g26457 , -1.0 , 1.0 );
			float WIND_GUST_LEAF_MICRO_STRENGTH1189_g26354 = _WIND_GUST_LEAF_MICRO_STRENGTH;
			float4 color658_g26376 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float WIND_GUST_LEAF_MICRO_CYCLE_TIME1190_g26354 = _WIND_GUST_LEAF_MICRO_CYCLE_TIME;
			float2 temp_cast_48 = (( 1.0 / (( ( WIND_GUST_LEAF_MICRO_CYCLE_TIME1190_g26354 + ( WIND_VARIATION1211_g26354 * 0.1 ) ) == 0.0 ) ? 1.0 :  ( WIND_GUST_LEAF_MICRO_CYCLE_TIME1190_g26354 + ( WIND_VARIATION1211_g26354 * 0.1 ) ) ) )).xx;
			float2 temp_output_61_0_g26380 = float2( 0,0 );
			float2 appendResult1409_g26354 = (float2(ase_vertex3Pos.y , ase_vertex3Pos.z));
			float2 temp_output_1_0_g26381 = ( (WIND_VARIATION1211_g26354).xx + appendResult1409_g26354 );
			float WIND_GUST_LEAF_MICRO_FIELD_SIZE1191_g26354 = _WIND_GUST_LEAF_MICRO_FIELD_SIZE;
			float temp_output_40_0_g26380 = ( 1.0 / (( WIND_GUST_LEAF_MICRO_FIELD_SIZE1191_g26354 == 0.0 ) ? 1.0 :  WIND_GUST_LEAF_MICRO_FIELD_SIZE1191_g26354 ) );
			float2 temp_cast_49 = (temp_output_40_0_g26380).xx;
			float2 temp_output_2_0_g26381 = temp_cast_49;
			float2 temp_output_3_0_g26381 = temp_output_61_0_g26380;
			float2 panner90_g26380 = ( _Time.y * temp_cast_48 + ( (( temp_output_61_0_g26380 > float2( 0,0 ) ) ? ( temp_output_1_0_g26381 / temp_output_2_0_g26381 ) :  ( temp_output_1_0_g26381 * temp_output_2_0_g26381 ) ) + temp_output_3_0_g26381 ));
			float temp_output_679_0_g26376 = 1.0;
			float4 temp_cast_50 = (temp_output_679_0_g26376).xxxx;
			float4 temp_output_52_0_g26380 = saturate( pow( tex2Dlod( _WIND_GUST_TEXTURE, float4( panner90_g26380, 0, 0.0) ) , temp_cast_50 ) );
			float4 lerpResult656_g26376 = lerp( color658_g26376 , temp_output_52_0_g26380 , temp_output_679_0_g26376);
			float4 break655_g26376 = lerpResult656_g26376;
			float LEAF_GUST_MICRO1408_g26354 = ( WIND_GUST_LEAF_MICRO_STRENGTH1189_g26354 * WIND_GUST_AUDIO_VERYHIGH1243_g26354 * break655_g26376.a );
			float _WIND_GUST_STRENGTH_MICRO851_g26445 = LEAF_GUST_MICRO1408_g26354;
			float clampResult3_g26455 = clamp( _WIND_GUST_STRENGTH_MICRO851_g26445 , 0.0 , 1.0 );
			float temp_output_3_0_g26458 = ( ( clampResult3_g26455 * 2.0 ) - 1.0 );
			float lerpResult1_g26464 = lerp( ( _WIND_GUST_STRENGTH_MICRO851_g26445 - 1.0 ) , temp_output_3_0_g26458 , saturate( ( 1.0 + clampResult13_g26458 ) ));
			float lerpResult1_g26459 = lerp( temp_output_3_0_g26458 , _WIND_GUST_STRENGTH_MICRO851_g26445 , saturate( clampResult13_g26458 ));
			float3 _GUST_MICRO1020_g26445 = ( worldToObjDir1006_g26445 * (( clampResult13_g26458 < 0.0 ) ? lerpResult1_g26464 :  lerpResult1_g26459 ) );
			float3 lerpResult538_g26445 = lerp( temp_output_684_0_g26445 , ( temp_output_684_0_g26445 + ( ( _GUST1018_g26445 + _GUST_MID1019_g26445 + _GUST_MICRO1020_g26445 ) * _WIND_TERTIARY_ROLL669_g26445 ) ) , WIND_GUST_AUDIO_STRENGTH1242_g26354);
			float3 MOTION_LEAF1343_g26354 = lerpResult538_g26445;
			float3 temp_output_19_0_g26410 = MOTION_LEAF1343_g26354;
			float3 temp_output_20_0_g26410 = float3(0,0,0);
			float4 break360_g25922 = v.ase_texcoord4;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 temp_output_356_0_g25922 = ( ase_worldPos - (_WorldSpaceCameraPos).xyz );
			float3 normalizeResult358_g25922 = normalize( temp_output_356_0_g25922 );
			float3 cam_pos_axis_z384_g25922 = normalizeResult358_g25922;
			float3 normalizeResult366_g25922 = normalize( cross( float3(0,1,0) , cam_pos_axis_z384_g25922 ) );
			float3 cam_pos_axis_x385_g25922 = normalizeResult366_g25922;
			float4x4 break375_g25922 = UNITY_MATRIX_V;
			float3 appendResult377_g25922 = (float3(break375_g25922[ 0 ][ 0 ] , break375_g25922[ 0 ][ 1 ] , break375_g25922[ 0 ][ 2 ]));
			float3 cam_rot_axis_x378_g25922 = appendResult377_g25922;
			float dotResult436_g25922 = dot( float3(0,1,0) , temp_output_356_0_g25922 );
			float temp_output_438_0_g25922 = saturate( abs( dotResult436_g25922 ) );
			float3 lerpResult424_g25922 = lerp( cam_pos_axis_x385_g25922 , cam_rot_axis_x378_g25922 , temp_output_438_0_g25922);
			float3 xAxis346_g25922 = lerpResult424_g25922;
			float3 cam_pos_axis_y383_g25922 = cross( cam_pos_axis_z384_g25922 , normalizeResult366_g25922 );
			float3 appendResult381_g25922 = (float3(break375_g25922[ 1 ][ 0 ] , break375_g25922[ 1 ][ 1 ] , break375_g25922[ 1 ][ 2 ]));
			float3 cam_rot_axis_y379_g25922 = appendResult381_g25922;
			float3 lerpResult423_g25922 = lerp( cam_pos_axis_y383_g25922 , cam_rot_axis_y379_g25922 , temp_output_438_0_g25922);
			float3 yAxis362_g25922 = lerpResult423_g25922;
			float isBillboard343_g25922 = (( break360_g25922.w < -0.99999 ) ? 1.0 :  0.0 );
			float3 temp_output_41_0_g26501 = ( ( ( WIND_TRUNK_STRENGTH1235_g26354 * MOTION_TRUNK1337_g26354 ) + ( WIND_BRANCH_STRENGTH1224_g26354 * MOTION_BRANCH1339_g26354 ) + ( WIND_LEAF_STRENGTH1179_g26354 * (( temp_output_17_0_g26410 == temp_output_18_0_g26410 ) ? temp_output_19_0_g26410 :  temp_output_20_0_g26410 ) ) ) + ( -( ( break360_g25922.x * xAxis346_g25922 ) + ( break360_g25922.y * yAxis362_g25922 ) ) * isBillboard343_g25922 * -1.0 ) );
			float temp_output_63_0_g26502 = (( unity_LODFade.x >= 1E-06 && unity_LODFade.x <= 0.999999 ) ? unity_LODFade.x :  1.0 );
			float3 lerpResult57_g26502 = lerp( temp_output_41_0_g26501 , -ase_vertex3Pos , ( 1.0 - temp_output_63_0_g26502 ));
			#ifdef INTERNAL_LODFADE_SCALE
				float3 staticSwitch58_g26501 = lerpResult57_g26502;
			#else
				float3 staticSwitch58_g26501 = temp_output_41_0_g26501;
			#endif
			#ifdef LOD_FADE_CROSSFADE
				float3 staticSwitch62_g26501 = staticSwitch58_g26501;
			#else
				float3 staticSwitch62_g26501 = temp_output_41_0_g26501;
			#endif
			v.vertex.xyz += staticSwitch62_g26501;
			float3 appendResult382_g25922 = (float3(break375_g25922[ 2 ][ 0 ] , break375_g25922[ 2 ][ 1 ] , break375_g25922[ 2 ][ 2 ]));
			float3 cam_rot_axis_z380_g25922 = appendResult382_g25922;
			float3 lerpResult422_g25922 = lerp( cam_pos_axis_z384_g25922 , cam_rot_axis_z380_g25922 , temp_output_438_0_g25922);
			float3 zAxis421_g25922 = lerpResult422_g25922;
			float3 lerpResult331_g25922 = lerp( ase_vertexNormal , ( -1.0 * zAxis421_g25922 ) , isBillboard343_g25922);
			float3 normalizeResult326_g25922 = normalize( lerpResult331_g25922 );
			v.normal = normalizeResult326_g25922;
			float4 ase_vertexTangent = v.tangent;
			float4 appendResult345_g25922 = (float4(xAxis346_g25922 , -1.0));
			float4 lerpResult341_g25922 = lerp( float4( ase_vertexTangent.xyz , 0.0 ) , appendResult345_g25922 , isBillboard343_g25922);
			v.tangent = lerpResult341_g25922;
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
			half Opacity1306 = tex2DNode18.a;
			float temp_output_41_0_g26495 = Opacity1306;
			float4 ase_screenPos = i.screenPosition;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 clipScreen45_g26496 = ase_screenPosNorm.xy * _ScreenParams.xy;
			float dither45_g26496 = Dither8x8Bayer( fmod(clipScreen45_g26496.x, 8), fmod(clipScreen45_g26496.y, 8) );
			float temp_output_56_0_g26496 = (( unity_LODFade.x >= 1E-06 && unity_LODFade.x <= 0.999999 ) ? unity_LODFade.x :  1.0 );
			dither45_g26496 = step( dither45_g26496, temp_output_56_0_g26496 );
			#ifdef INTERNAL_LODFADE_DITHER
				float staticSwitch50_g26495 = ( temp_output_41_0_g26495 * dither45_g26496 );
			#else
				float staticSwitch50_g26495 = temp_output_41_0_g26495;
			#endif
			#ifdef LOD_FADE_CROSSFADE
				float staticSwitch56_g26495 = staticSwitch50_g26495;
			#else
				float staticSwitch56_g26495 = temp_output_41_0_g26495;
			#endif
			float opacity34_g26508 = staticSwitch56_g26495;
			float3 ase_worldPos = i.worldPos;
			float distance22_g26509 = distance( ase_worldPos , _WorldSpaceCameraPos );
			float temp_output_14_0_g26509 = _CutoffFar;
			float temp_output_11_0_g26509 = _CutoffFar;
			float fadeEnd20_g26509 = ( temp_output_14_0_g26509 + temp_output_11_0_g26509 );
			float fadeStart19_g26509 = temp_output_14_0_g26509;
			float fadeLength23_g26509 = temp_output_11_0_g26509;
			float temp_output_9_0_g26508 = saturate( saturate( (( distance22_g26509 > fadeEnd20_g26509 ) ? 0.0 :  (( distance22_g26509 < fadeStart19_g26509 ) ? 1.0 :  ( 1.0 - ( ( distance22_g26509 - fadeStart19_g26509 ) / max( fadeLength23_g26509 , 1E-05 ) ) ) ) ) ) );
			float lerpResult12_g26508 = lerp( _CutoffLowFar , _CutoffLowNear , temp_output_9_0_g26508);
			float lerpResult11_g26508 = lerp( _CutoffHighFar , _CutoffHighNear , temp_output_9_0_g26508);
			float lerpResult1_g26510 = lerp( lerpResult12_g26508 , lerpResult11_g26508 , saturate( i.vertexColor.b ));
			float cutoff34_g26508 = lerpResult1_g26510;
			float localExecuteClip34_g26508 = ExecuteClip( opacity34_g26508 , cutoff34_g26508 );
			SurfaceOutputStandard s1_g25488 = (SurfaceOutputStandard ) 0;
			float temp_output_36_0_g1 = 1.0;
			float2 uv_MetallicGlossMap645 = i.uv_texcoord;
			float4 tex2DNode645 = tex2D( _MetallicGlossMap, uv_MetallicGlossMap645 );
			half Main_MetallicGlossMap_G1788 = tex2DNode645.g;
			float lerpResult38_g1 = lerp( temp_output_36_0_g1 , Main_MetallicGlossMap_G1788 , _Occlusion);
			float temp_output_48_0_g1 = i.uv_tex4coord.z;
			float lerpResult37_g1 = lerp( temp_output_36_0_g1 , saturate( temp_output_48_0_g1 ) , _VertexOcclusion);
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
			float temp_output_17_0_g24765 = round( i.uv3_tex4coord3.w );
			float temp_output_18_0_g24765 = 3.0;
			half4 Main_MainTex487 = tex2DNode18;
			float3 temp_output_2_0_g24757 = Main_MainTex487.rgb;
			float4 color107_g24712 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
			float2 appendResult102_g24712 = (float2(0.0 , _SecondaryColor.a));
			float4 temp_output_108_0_g24712 = _Color;
			float2 weightedBlendVar103_g24712 = appendResult102_g24712;
			float4 weightedAvg103_g24712 = ( ( weightedBlendVar103_g24712.x*temp_output_108_0_g24712 + weightedBlendVar103_g24712.y*_SecondaryColor )/( weightedBlendVar103_g24712.x + weightedBlendVar103_g24712.y ) );
			half Main_MetallicGlossMap_B1836 = tex2DNode645.b;
			float temp_output_86_0_g24712 = ( 1.0 - Main_MetallicGlossMap_B1836 );
			float4 lerpResult1_g24723 = lerp( (( max( 0.0 , _SecondaryColor.a ) == 0.0 ) ? color107_g24712 :  weightedAvg103_g24712 ) , _MaskedColor , saturate( temp_output_86_0_g24712 ));
			float4 temp_output_8_0_g24757 = lerpResult1_g24723;
			float3 temp_output_10_0_g24757 = (temp_output_8_0_g24757).rgb;
			float3 lerpResult1_g24758 = lerp( temp_output_2_0_g24757 , ( temp_output_2_0_g24757 * temp_output_10_0_g24757 ) , saturate( saturate( (temp_output_8_0_g24757).a ) ));
			half3 Main_MainTex_RGB2572 = (tex2DNode18).rgb;
			float3 temp_output_2_0_g24724 = Main_MainTex_RGB2572;
			float2 appendResult54_g24712 = (float2(( ase_worldPos.x + ase_worldPos.z ) , ase_worldPos.y));
			float2 temp_output_1_0_g24714 = appendResult54_g24712;
			float2 temp_output_2_0_g24714 = (_ColorMapScale).xx;
			float2 temp_output_3_0_g24714 = float2( 0,0 );
			float4 temp_output_1_0_g24716 = tex2D( _ColorMap, ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g24714 / temp_output_2_0_g24714 ) :  ( temp_output_1_0_g24714 * temp_output_2_0_g24714 ) ) + temp_output_3_0_g24714 ) );
			float temp_output_2_0_g24716 = _ColorMapChannel;
			float temp_output_7_0_g24719 = temp_output_2_0_g24716;
			float4 lerpResult4_g24719 = lerp( float4(1,0,0,0) , float4(0,1,0,0) , saturate( temp_output_7_0_g24719 ));
			float4 lerpResult6_g24719 = lerp( lerpResult4_g24719 , float4(0,0,1,0) , step( 2.0 , temp_output_7_0_g24719 ));
			float4 lerpResult12_g24719 = lerp( lerpResult6_g24719 , float4(0,0,0,1) , step( 3.0 , temp_output_7_0_g24719 ));
			half4 FOUR16_g24719 = lerpResult12_g24719;
			float4 temp_output_17_0_g24716 = ( (temp_output_1_0_g24716).xyzw * FOUR16_g24719 );
			float4 break37_g24716 = temp_output_17_0_g24716;
			float4 lerpResult1_g24713 = lerp( temp_output_108_0_g24712 , _SecondaryColor , saturate( ( _ColorMapBias + (CalculateContrast(_ColorMapContrast,(saturate( max( max( max( break37_g24716.x , break37_g24716.y ) , break37_g24716.z ) , break37_g24716.w ) )).xxxx)).r ) ));
			float4 temp_output_8_0_g24724 = lerpResult1_g24713;
			float3 temp_output_10_0_g24724 = (temp_output_8_0_g24724).rgb;
			float3 lerpResult1_g24725 = lerp( temp_output_2_0_g24724 , ( temp_output_2_0_g24724 * temp_output_10_0_g24724 ) , saturate( saturate( (temp_output_8_0_g24724).a ) ));
			float4 temp_output_89_0_g24753 = float4( (lerpResult1_g24725).xyz , 0.0 );
			float3 hsvTorgb92_g24753 = RGBToHSV( temp_output_89_0_g24753.rgb );
			float temp_output_118_0_g24753 = 1.0;
			float3 hsvTorgb83_g24753 = HSVToRGB( float3(hsvTorgb92_g24753.x,( hsvTorgb92_g24753.y * ( temp_output_118_0_g24753 + _Saturation ) ),( hsvTorgb92_g24753.z * ( temp_output_118_0_g24753 + _Brightness ) )) );
			float3 lerpResult1_g24761 = lerp( (lerpResult1_g24758).xyz , hsvTorgb83_g24753 , saturate( ( 2.0 * Main_MetallicGlossMap_B1836 ) ));
			float3 temp_output_19_0_g24765 = lerpResult1_g24761;
			float3 temp_output_2_0_g24762 = Main_MainTex487.rgb;
			float4 temp_output_8_0_g24762 = _NonLeafColor;
			float3 temp_output_10_0_g24762 = (temp_output_8_0_g24762).rgb;
			float3 lerpResult1_g24763 = lerp( temp_output_2_0_g24762 , ( temp_output_2_0_g24762 * temp_output_10_0_g24762 ) , saturate( saturate( (temp_output_8_0_g24762).a ) ));
			float3 temp_output_20_0_g24765 = (lerpResult1_g24763).xyz;
			float3 ALBEDO2580 = saturate( (( temp_output_17_0_g24765 == temp_output_18_0_g24765 ) ? temp_output_19_0_g24765 :  temp_output_20_0_g24765 ) );
			float3 temp_output_2_0_g25238 = ( temp_output_16_0_g1 * ALBEDO2580 );
			float4 temp_output_8_0_g25238 = _Backshade;
			float3 temp_output_10_0_g25238 = (temp_output_8_0_g25238).rgb;
			half localunity_ObjectToWorld0w1_g25236 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g25236 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g25236 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g25236 = (float3(localunity_ObjectToWorld0w1_g25236 , localunity_ObjectToWorld1w2_g25236 , localunity_ObjectToWorld2w3_g25236));
			float3 normalizeResult7_g25230 = normalize( ( _WorldSpaceCameraPos - appendResult6_g25236 ) );
			half localunity_ObjectToWorld0w1_g25237 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g25237 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g25237 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g25237 = (float3(localunity_ObjectToWorld0w1_g25237 , localunity_ObjectToWorld1w2_g25237 , localunity_ObjectToWorld2w3_g25237));
			float3 normalizeResult8_g25230 = normalize( ( ase_worldPos - appendResult6_g25237 ) );
			float dotResult9_g25230 = dot( normalizeResult7_g25230 , normalizeResult8_g25230 );
			float clampResult46_g25230 = clamp( ( _BackshadingBias + saturate( dotResult9_g25230 ) ) , 1E-06 , 2.0 );
			float3 lerpResult1_g25239 = lerp( temp_output_2_0_g25238 , temp_output_10_0_g25238 , saturate( saturate( ( (_Backshade).a * ( 1.0 - saturate( (CalculateContrast(_BackshadingContrast,(saturate( pow( clampResult46_g25230 , _BackshadingPower ) )).xxxx)).r ) ) ) ) ));
			float3 albedo51_g25488 = ((lerpResult1_g25239).xyz).xyz;
			s1_g25488.Albedo = albedo51_g25488;
			float2 uv_BumpMap607 = i.uv_texcoord;
			float3 temp_output_13_0_g24766 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap607 ), _BumpScale );
			float3 switchResult20_g24766 = (((i.ASEVFace>0)?(temp_output_13_0_g24766):(-temp_output_13_0_g24766)));
			half3 MainBumpMap620 = switchResult20_g24766;
			float3 temp_output_55_0_g25488 = MainBumpMap620;
			float3 normal_TS54_g25488 = temp_output_55_0_g25488;
			s1_g25488.Normal = WorldNormalVector( i , normal_TS54_g25488 );
			float3 emissive71_g25488 = float3(0,0,0);
			s1_g25488.Emission = emissive71_g25488;
			float metallic34_g25488 = 0.0;
			s1_g25488.Metallic = metallic34_g25488;
			half SMOOTHNESS660 = saturate( ( tex2DNode645.a * _Glossiness ) );
			float smoothness39_g25488 = SMOOTHNESS660;
			s1_g25488.Smoothness = smoothness39_g25488;
			float occlusion188_g25488 = temp_output_16_0_g1;
			s1_g25488.Occlusion = occlusion188_g25488;

			data.light = gi.light;

			UnityGI gi1_g25488 = gi;
			#ifdef UNITY_PASS_FORWARDBASE
			Unity_GlossyEnvironmentData g1_g25488 = UnityGlossyEnvironmentSetup( s1_g25488.Smoothness, data.worldViewDir, s1_g25488.Normal, float3(0,0,0));
			gi1_g25488 = UnityGlobalIllumination( data, s1_g25488.Occlusion, s1_g25488.Normal, g1_g25488 );
			#endif

			float3 surfResult1_g25488 = LightingStandard ( s1_g25488, viewDir, gi1_g25488 ).rgb;
			surfResult1_g25488 += s1_g25488.Emission;

			#ifdef UNITY_PASS_FORWARDADD//1_g25488
			surfResult1_g25488 -= s1_g25488.Emission;
			#endif//1_g25488
			float3 clampResult196_g25488 = clamp( surfResult1_g25488 , float3(0,0,0) , float3(50,50,50) );
			float lerpResult36_g25476 = lerp( 1.0 , ( ase_lightAtten * _OcclusionTransmissionLightingScale ) , _OcclusionTransmissionDampening);
			float OCCLUSION77_g25476 = saturate( lerpResult36_g25476 );
			float temp_output_7_0_g25478 = 0.4;
			float lerpResult82_g25476 = lerp( 1.0 , saturate( ( ( ( _GLOBAL_SOLAR_TIME - temp_output_7_0_g25478 ) / ( 1.0 - temp_output_7_0_g25478 ) ) * 3.0 ) ) , _NighttimeTransmissionDamping);
			UnityGI gi30_g25476 =(UnityGI)gi;
			float3 localIndirectLightDir30_g25476 = IndirectLightDir( gi30_g25476 );
			float dotResult5_g25476 = dot( (WorldNormalVector( i , MainBumpMap620 )) , localIndirectLightDir30_g25476 );
			float baseTransmissionStrength91_g25476 = saturate( -dotResult5_g25476 );
			float adjustedTransmissionStrength93_g25476 = ( ( baseTransmissionStrength91_g25476 * _TransmDirect ) + ( ( 1.0 - baseTransmissionStrength91_g25476 ) * _TransmAmbient ) );
			float cameraDepthFade64_g25476 = (( i.eyeDepth -_ProjectionParams.y - _TransmissionFadeOffset ) / _TransmissionFadeDistance);
			float transmission_strength67_g25476 = ( adjustedTransmissionStrength93_g25476 * _Transmission * ( 1.0 - cameraDepthFade64_g25476 ) );
			float temp_output_34_0_g25479 = _TransmissionCutoff;
			float4 appendResult2736 = (float4(ALBEDO2580 , Opacity1306));
			float4 in_albedo59_g25476 = appendResult2736;
			float4 lerpResult1_g25480 = lerp( _TransmissionColor , in_albedo59_g25476 , saturate( _TransmissionAlbedoBlend ));
			float4 temp_output_15_0_g25479 = lerpResult1_g25480;
			half3 COLOR_TRANSMISSION54_g25476 = ( ( (0.0 + (saturate( ( Main_MetallicGlossMap_B1836 - temp_output_34_0_g25479 ) ) - 0.0) * (1.0 - 0.0) / (( 1.0 - temp_output_34_0_g25479 ) - 0.0)) * (temp_output_15_0_g25479).a ) * (temp_output_15_0_g25479).rgb );
			UnityGI gi29_g25476 =(UnityGI)gi;
			float3 localIndirectLightColor29_g25476 = IndirectLightColor( gi29_g25476 );
			float distance22_g25482 = distance( ase_worldPos , _WorldSpaceCameraPos );
			float temp_output_14_0_g25482 = _TranslucencyFadeOffset;
			float temp_output_11_0_g25482 = _TranslucencyFadeDistance;
			float fadeEnd20_g25482 = ( temp_output_14_0_g25482 + temp_output_11_0_g25482 );
			float fadeStart19_g25482 = temp_output_14_0_g25482;
			float fadeLength23_g25482 = temp_output_11_0_g25482;
			float translucency_strength100_g25481 = ( _Translucency * saturate( (( distance22_g25482 > fadeEnd20_g25482 ) ? 0.0 :  (( distance22_g25482 < fadeStart19_g25482 ) ? 1.0 :  ( 1.0 - ( ( distance22_g25482 - fadeStart19_g25482 ) / max( fadeLength23_g25482 , 1E-05 ) ) ) ) ) ) );
			float lerpResult81_g25481 = lerp( 1.0 , ( ase_lightAtten * _OcclusionTransmissionLightingScale1 ) , _OcclusionTranslucencyDamping);
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float3 temp_output_47_0_g25481 = ( (WorldNormalVector( i , MainBumpMap620 )) * _TransNormalDistortion );
			float3 lightDir40_g25481 = ( ase_worldlightDir + temp_output_47_0_g25481 );
			float dotResult59_g25481 = dot( ase_worldViewDir , -lightDir40_g25481 );
			float transVdotL56_g25481 = pow( saturate( dotResult59_g25481 ) , _TransScattering );
			UnityGI gi129_g25481 =(UnityGI)gi;
			float3 localGetGILightColor129_g25481 = GetGILightColor( gi129_g25481 );
			float3 localGetPrimaryLightColor33_g25481 = GetPrimaryLightColor();
			float3 lerpResult30_g25481 = lerp( localGetPrimaryLightColor33_g25481 , localGetGILightColor129_g25481 , saturate( _TransShadow ));
			#ifdef DIRECTIONAL
				float3 staticSwitch18_g25481 = lerpResult30_g25481;
			#else
				float3 staticSwitch18_g25481 = localGetGILightColor129_g25481;
			#endif
			float3 lightAtten35_g25481 = staticSwitch18_g25481;
			float temp_output_34_0_g25483 = _TranslucencyCutoff;
			float4 lerpResult1_g25484 = lerp( _TranslucencyColor , appendResult2736 , saturate( _TranslucencyAlbedoBlend ));
			float4 temp_output_15_0_g25483 = lerpResult1_g25484;
			half3 COLOR_TRANSLUCENCY105_g25481 = ( ( (0.0 + (saturate( ( Main_MetallicGlossMap_B1836 - temp_output_34_0_g25483 ) ) - 0.0) * (1.0 - 0.0) / (( 1.0 - temp_output_34_0_g25483 ) - 0.0)) * (temp_output_15_0_g25483).a ) * (temp_output_15_0_g25483).rgb );
			float3 translucency63_g25481 = ( ( ( transVdotL56_g25481 * _TransDirect ) + ( ( 1.0 - transVdotL56_g25481 ) * _TransAmbient ) ) * lightAtten35_g25481 * COLOR_TRANSLUCENCY105_g25481 );
			float temp_output_7_0_g25486 = 0.4;
			float lerpResult125_g25481 = lerp( 1.0 , saturate( ( ( ( _GLOBAL_SOLAR_TIME - temp_output_7_0_g25486 ) / ( 1.0 - temp_output_7_0_g25486 ) ) * 3.0 ) ) , _NighttimeTranslucencyDamping);
			float3 clampResult6_g25487 = clamp( ( ( ( OCCLUSION77_g25476 * lerpResult82_g25476 * transmission_strength67_g25476 * COLOR_TRANSMISSION54_g25476 * localIndirectLightColor29_g25476 * (in_albedo59_g25476).rgb ) + (( translucency_strength100_g25481 * saturate( lerpResult81_g25481 ) * translucency63_g25481 * lerpResult125_g25481 )).xyz ) * (_TransmittanceScaling).xxx ) , float3( 0,0,0 ) , (_TransmittanceLimit).xxx );
			c.rgb = ( clampResult196_g25488 + clampResult6_g25487 );
			c.a = 1;
			clip( localExecuteClip34_g26508 - _Cutoff );
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
			float2 uv_MetallicGlossMap645 = i.uv_texcoord;
			float4 tex2DNode645 = tex2D( _MetallicGlossMap, uv_MetallicGlossMap645 );
			half Main_MetallicGlossMap_G1788 = tex2DNode645.g;
			float lerpResult38_g1 = lerp( temp_output_36_0_g1 , Main_MetallicGlossMap_G1788 , _Occlusion);
			float temp_output_48_0_g1 = i.uv_tex4coord.z;
			float lerpResult37_g1 = lerp( temp_output_36_0_g1 , saturate( temp_output_48_0_g1 ) , _VertexOcclusion);
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
			float temp_output_17_0_g24765 = round( i.uv3_tex4coord3.w );
			float temp_output_18_0_g24765 = 3.0;
			float2 uv_MainTex18 = i.uv_texcoord;
			float4 tex2DNode18 = tex2D( _MainTex, uv_MainTex18 );
			half4 Main_MainTex487 = tex2DNode18;
			float3 temp_output_2_0_g24757 = Main_MainTex487.rgb;
			float4 color107_g24712 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
			float2 appendResult102_g24712 = (float2(0.0 , _SecondaryColor.a));
			float4 temp_output_108_0_g24712 = _Color;
			float2 weightedBlendVar103_g24712 = appendResult102_g24712;
			float4 weightedAvg103_g24712 = ( ( weightedBlendVar103_g24712.x*temp_output_108_0_g24712 + weightedBlendVar103_g24712.y*_SecondaryColor )/( weightedBlendVar103_g24712.x + weightedBlendVar103_g24712.y ) );
			half Main_MetallicGlossMap_B1836 = tex2DNode645.b;
			float temp_output_86_0_g24712 = ( 1.0 - Main_MetallicGlossMap_B1836 );
			float4 lerpResult1_g24723 = lerp( (( max( 0.0 , _SecondaryColor.a ) == 0.0 ) ? color107_g24712 :  weightedAvg103_g24712 ) , _MaskedColor , saturate( temp_output_86_0_g24712 ));
			float4 temp_output_8_0_g24757 = lerpResult1_g24723;
			float3 temp_output_10_0_g24757 = (temp_output_8_0_g24757).rgb;
			float3 lerpResult1_g24758 = lerp( temp_output_2_0_g24757 , ( temp_output_2_0_g24757 * temp_output_10_0_g24757 ) , saturate( saturate( (temp_output_8_0_g24757).a ) ));
			half3 Main_MainTex_RGB2572 = (tex2DNode18).rgb;
			float3 temp_output_2_0_g24724 = Main_MainTex_RGB2572;
			float2 appendResult54_g24712 = (float2(( ase_worldPos.x + ase_worldPos.z ) , ase_worldPos.y));
			float2 temp_output_1_0_g24714 = appendResult54_g24712;
			float2 temp_output_2_0_g24714 = (_ColorMapScale).xx;
			float2 temp_output_3_0_g24714 = float2( 0,0 );
			float4 temp_output_1_0_g24716 = tex2D( _ColorMap, ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g24714 / temp_output_2_0_g24714 ) :  ( temp_output_1_0_g24714 * temp_output_2_0_g24714 ) ) + temp_output_3_0_g24714 ) );
			float temp_output_2_0_g24716 = _ColorMapChannel;
			float temp_output_7_0_g24719 = temp_output_2_0_g24716;
			float4 lerpResult4_g24719 = lerp( float4(1,0,0,0) , float4(0,1,0,0) , saturate( temp_output_7_0_g24719 ));
			float4 lerpResult6_g24719 = lerp( lerpResult4_g24719 , float4(0,0,1,0) , step( 2.0 , temp_output_7_0_g24719 ));
			float4 lerpResult12_g24719 = lerp( lerpResult6_g24719 , float4(0,0,0,1) , step( 3.0 , temp_output_7_0_g24719 ));
			half4 FOUR16_g24719 = lerpResult12_g24719;
			float4 temp_output_17_0_g24716 = ( (temp_output_1_0_g24716).xyzw * FOUR16_g24719 );
			float4 break37_g24716 = temp_output_17_0_g24716;
			float4 lerpResult1_g24713 = lerp( temp_output_108_0_g24712 , _SecondaryColor , saturate( ( _ColorMapBias + (CalculateContrast(_ColorMapContrast,(saturate( max( max( max( break37_g24716.x , break37_g24716.y ) , break37_g24716.z ) , break37_g24716.w ) )).xxxx)).r ) ));
			float4 temp_output_8_0_g24724 = lerpResult1_g24713;
			float3 temp_output_10_0_g24724 = (temp_output_8_0_g24724).rgb;
			float3 lerpResult1_g24725 = lerp( temp_output_2_0_g24724 , ( temp_output_2_0_g24724 * temp_output_10_0_g24724 ) , saturate( saturate( (temp_output_8_0_g24724).a ) ));
			float4 temp_output_89_0_g24753 = float4( (lerpResult1_g24725).xyz , 0.0 );
			float3 hsvTorgb92_g24753 = RGBToHSV( temp_output_89_0_g24753.rgb );
			float temp_output_118_0_g24753 = 1.0;
			float3 hsvTorgb83_g24753 = HSVToRGB( float3(hsvTorgb92_g24753.x,( hsvTorgb92_g24753.y * ( temp_output_118_0_g24753 + _Saturation ) ),( hsvTorgb92_g24753.z * ( temp_output_118_0_g24753 + _Brightness ) )) );
			float3 lerpResult1_g24761 = lerp( (lerpResult1_g24758).xyz , hsvTorgb83_g24753 , saturate( ( 2.0 * Main_MetallicGlossMap_B1836 ) ));
			float3 temp_output_19_0_g24765 = lerpResult1_g24761;
			float3 temp_output_2_0_g24762 = Main_MainTex487.rgb;
			float4 temp_output_8_0_g24762 = _NonLeafColor;
			float3 temp_output_10_0_g24762 = (temp_output_8_0_g24762).rgb;
			float3 lerpResult1_g24763 = lerp( temp_output_2_0_g24762 , ( temp_output_2_0_g24762 * temp_output_10_0_g24762 ) , saturate( saturate( (temp_output_8_0_g24762).a ) ));
			float3 temp_output_20_0_g24765 = (lerpResult1_g24763).xyz;
			float3 ALBEDO2580 = saturate( (( temp_output_17_0_g24765 == temp_output_18_0_g24765 ) ? temp_output_19_0_g24765 :  temp_output_20_0_g24765 ) );
			float3 temp_output_2_0_g25238 = ( temp_output_16_0_g1 * ALBEDO2580 );
			float4 temp_output_8_0_g25238 = _Backshade;
			float3 temp_output_10_0_g25238 = (temp_output_8_0_g25238).rgb;
			half localunity_ObjectToWorld0w1_g25236 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g25236 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g25236 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g25236 = (float3(localunity_ObjectToWorld0w1_g25236 , localunity_ObjectToWorld1w2_g25236 , localunity_ObjectToWorld2w3_g25236));
			float3 normalizeResult7_g25230 = normalize( ( _WorldSpaceCameraPos - appendResult6_g25236 ) );
			half localunity_ObjectToWorld0w1_g25237 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g25237 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g25237 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g25237 = (float3(localunity_ObjectToWorld0w1_g25237 , localunity_ObjectToWorld1w2_g25237 , localunity_ObjectToWorld2w3_g25237));
			float3 normalizeResult8_g25230 = normalize( ( ase_worldPos - appendResult6_g25237 ) );
			float dotResult9_g25230 = dot( normalizeResult7_g25230 , normalizeResult8_g25230 );
			float clampResult46_g25230 = clamp( ( _BackshadingBias + saturate( dotResult9_g25230 ) ) , 1E-06 , 2.0 );
			float3 lerpResult1_g25239 = lerp( temp_output_2_0_g25238 , temp_output_10_0_g25238 , saturate( saturate( ( (_Backshade).a * ( 1.0 - saturate( (CalculateContrast(_BackshadingContrast,(saturate( pow( clampResult46_g25230 , _BackshadingPower ) )).xxxx)).r ) ) ) ) ));
			float3 albedo51_g25488 = ((lerpResult1_g25239).xyz).xyz;
			o.Albedo = ( _GlobalIlluminationAlbedoEffect * albedo51_g25488 );
			float3 emissive71_g25488 = float3(0,0,0);
			o.Emission = ( _GlobalIlluminationEmissiveEffect * emissive71_g25488 );
		}

		ENDCG
		CGPROGRAM
#include "UnityCG.cginc"
#include "Assets/Resources/CGIncludes/GPUInstancerInclude.cginc"
#pragma instancing_options procedural:setupGPUI
#pragma multi_compile_instancing
#include "UnityCG.cginc"

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
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float3 customPack1 : TEXCOORD1;
				float4 customPack2 : TEXCOORD2;
				float3 customPack3 : TEXCOORD3;
				float4 customPack4 : TEXCOORD4;
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
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.customPack2.xyzw = customInputData.uv_tex4coord;
				o.customPack2.xyzw = v.texcoord;
				o.customPack3.xyz = customInputData.uv_tex3coord;
				o.customPack3.xyz = v.texcoord;
				o.customPack4.xyzw = customInputData.uv3_tex4coord3;
				o.customPack4.xyzw = v.texcoord2;
				o.customPack5.xyzw = customInputData.screenPosition;
				o.customPack1.z = customInputData.eyeDepth;
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
				surfIN.uv_texcoord = IN.customPack1.xy;
				surfIN.uv_tex4coord = IN.customPack2.xyzw;
				surfIN.uv_tex3coord = IN.customPack3.xyz;
				surfIN.uv3_tex4coord3 = IN.customPack4.xyzw;
				surfIN.screenPosition = IN.customPack5.xyzw;
				surfIN.eyeDepth = IN.customPack1.z;
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
0;-864;1536;843;-2586.773;2569.104;1.3;True;False
Node;AmplifyShaderEditor.SamplerNode;18;940.1176,-444.745;Inherit;True;Property;_MainTex;Leaf Albedo;10;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;7ef4107201e4351428e5e8dc4f6be6d8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;645;2844.414,-470.8856;Inherit;True;Property;_MetallicGlossMap;Leaf Surface;13;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;86972d4515fc169479817955aab87619;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;2571;1309.687,-346.631;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1836;3192.414,-403.7736;Half;False;Main_MetallicGlossMap_B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2437;729.6556,-1135.158;Inherit;False;1836;Main_MetallicGlossMap_B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2818;720,-1328;Half;False;Property;_Color;Primary Color;26;0;Create;False;0;0;True;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;2572;1523.687,-347.631;Half;False;Main_MainTex_RGB;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;36;1081.957,-1093.439;Inherit;False;2572;Main_MainTex_RGB;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;1324.118,-444.745;Half;False;Main_MainTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2817;1053.669,-1205.307;Inherit;False;Color Map;15;;24712;75394c603df4334428b014264f3883db;2,111,0,110,0;2;108;COLOR;1,1,1,1;False;83;FLOAT;0;False;3;COLOR;84;COLOR;0;FLOAT;116
Node;AmplifyShaderEditor.FunctionNode;2470;1862.186,-948.3488;Inherit;False;const;-1;;24726;5b64729fb717c5f49a1bc2dab81d5e1c;4,21,0,3,6,22,0,28,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2785;1436.428,-1083.75;Inherit;False;Color Blend;-1;;24724;e23fbae801d69e440a1b323378db49a5;2,11,0,14,1;3;2;FLOAT3;0,0,0;False;8;COLOR;0,0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1965;1370.765,-874.5014;Inherit;False;Property;_Brightness;Leaf Brightness;25;0;Create;False;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1967;1362.147,-975.538;Inherit;False;Property;_Saturation;Leaf Saturation;24;0;Create;False;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2001;1726.986,-854.249;Inherit;False;1836;Main_MetallicGlossMap_B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2261;1109.526,-1293.263;Inherit;False;487;Main_MainTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2469;1995.995,-916.4102;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2784;1436.777,-1200.669;Inherit;False;Color Blend;-1;;24757;e23fbae801d69e440a1b323378db49a5;2,11,0,14,1;3;2;FLOAT3;0,0,0;False;8;COLOR;0,0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2258;2398.698,-1087.892;Inherit;False;487;Main_MainTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;2357;2345.778,-987.6512;Half;False;Property;_NonLeafColor;Non-Leaf Color;27;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;2772;1682.939,-1044.263;Inherit;False;Color Adjustment;-1;;24753;f9571dc7cf91d954d87b44c4dd2d35aa;6,90,0,81,1,91,1,85,0,116,0,111,0;6;89;COLOR;0,0,0,0;False;82;FLOAT;0;False;86;FLOAT;0;False;87;FLOAT;0;False;88;FLOAT;0;False;115;FLOAT;0;False;1;FLOAT3;37
Node;AmplifyShaderEditor.FunctionNode;2256;2725.924,-1285.786;Inherit;False;Tree Component ID;-1;;24764;5271313988492174092a46e3f289ae62;1,4,3;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2782;2623.26,-1085.257;Inherit;False;Color Blend;-1;;24762;e23fbae801d69e440a1b323378db49a5;2,11,0,14,1;3;2;FLOAT3;0,0,0;False;8;COLOR;0,0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;2568;2148.25,-1204.672;Inherit;False;Lerp (Clamped);-1;;24761;cad3f473268ed2641979326c3e8290ec;0;3;2;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;2464;2536.527,-1389.862;Inherit;False;Mesh Values (Tree) (Complex) (UV3);-1;;24760;8e1e1d817f2a77d4ea50f9fe634408b6;0;0;2;FLOAT3;500;FLOAT;549
Node;AmplifyShaderEditor.FunctionNode;2255;2988.799,-1264.355;Inherit;False;Multi Comparison;-1;;24765;8cbe358a30145e843bfece526f25c2c8;1,4,1;4;17;FLOAT;0;False;18;FLOAT;0;False;19;FLOAT3;0,0,0;False;20;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;655;1801.118,-428.745;Half;False;Property;_BumpScale;Leaf Normal Scale;12;0;Create;False;0;0;False;0;1;2;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;607;2090.366,-473.2588;Inherit;True;Property;_BumpMap;Leaf Normal;11;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;903130fdcaaec944994e2b29000f03e3;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;294;2877.774,-263.0922;Half;False;Property;_Glossiness;Leaf Smoothness;14;0;Create;False;0;0;False;0;0.1;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1343;3190.395,-1260.105;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1306;1313.118,-249.7451;Half;False;Opacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1788;3198.414,-488.7736;Half;False;Main_MetallicGlossMap_G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2794;2398.886,-455.2908;Inherit;False;Normal BackFace;-1;;24766;121446c878db06f4c847f9c5afed7cfe;0;1;13;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;745;3199.775,-298.0922;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2580;3350.521,-1268.64;Inherit;False;ALBEDO;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1814;1886.495,-2833.946;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;2738;1590.376,-2649.256;Inherit;False;2580;ALBEDO;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1795;1851.388,-2920.967;Inherit;False;1788;Main_MetallicGlossMap_G;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2613;3356.456,-306.2242;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2737;1709.866,-2300.631;Inherit;False;1306;Opacity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;620;2598.118,-463.745;Half;False;MainBumpMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2741;1869.981,-2220.505;Inherit;False;620;MainBumpMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;2736;1928.866,-2317.631;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;2742;1831.519,-2139.576;Inherit;False;1836;Main_MetallicGlossMap_B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2828;2539.913,-2152.01;Inherit;False;Wind (Tree Complex);81;;26354;76dbe6e88a5c02e42a177b05b9981ead;2,981,1,983,1;0;8;FLOAT3;0;FLOAT;1021;FLOAT;1022;FLOAT;1023;FLOAT;1024;FLOAT;1027;FLOAT;1025;FLOAT;1454
Node;AmplifyShaderEditor.FunctionNode;2829;2178.681,-2776.137;Inherit;False;Occlusion Probes;34;;1;fc5cec86a89be184e93fc845da77a0cc;4,22,1,65,0,66,1,64,0;3;12;FLOAT;0;False;48;FLOAT;0;False;26;FLOAT3;1,1,1;False;2;FLOAT;0;FLOAT3;31
Node;AmplifyShaderEditor.FunctionNode;2428;2859.941,-1823.095;Inherit;False;Pivot Billboard;-1;;25922;50ed44a1d0e6ecb498e997b8969f8558;3,431,2,432,2,433,2;0;3;FLOAT3;370;FLOAT3;369;FLOAT4;371
Node;AmplifyShaderEditor.RegisterLocalVarNode;660;3520.774,-324.6923;Half;False;SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;624;2201.109,-2646.095;Inherit;False;620;MainBumpMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;2823;2220.259,-2200.775;Inherit;False;Translucency;57;;25481;2d05813238a8e3247978494a31c6caa3;1,45,0;4;55;COLOR;0,0,0,0;False;44;FLOAT3;0,0,0;False;42;FLOAT3;0,0,0;False;113;FLOAT;1;False;1;FLOAT3;54
Node;AmplifyShaderEditor.FunctionNode;2822;2214.828,-2331.805;Inherit;False;Transmission;44;;25476;e758152fceada0549997f6183a738107;1,14,0;4;6;COLOR;0,0,0,0;False;7;FLOAT3;0,0,0;False;15;FLOAT3;0,0,0;False;57;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2006;3070.654,-2152.864;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;2812;2593.903,-2732.481;Inherit;False;Backshade;28;;25230;ef1e6c9fe3ccd0a469022ea4da76c89a;0;1;25;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1783;3026.831,-2234.047;Inherit;False;1306;Opacity;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;654;2216.076,-2577.043;Inherit;False;660;SMOOTHNESS;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1465;3810.939,-1458.148;Inherit;False;797.8645;735.9034;DRAWERS;7;2391;1468;2366;1472;2492;2491;2433;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.FunctionNode;2487;3244.739,-2228.877;Inherit;False;Execute LOD Fade;-1;;26494;18ea34bd83a0d6c4db425672111543e6;0;2;41;FLOAT;0;False;58;FLOAT3;0,0,0;False;3;FLOAT;0;FLOAT3;91;FLOAT;96
Node;AmplifyShaderEditor.FunctionNode;2767;2596.951,-2337.308;Inherit;False;Transmittance Scaling;73;;25487;78929217b6ba7534daefd6d688626ff6;0;2;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;2793;2858.64,-2660.823;Inherit;False;Custom Lighting;77;;25488;b225dcbb02c65fb46af1dbc43764905b;1,67,0;7;56;FLOAT3;0,0,0;False;55;FLOAT3;0,0,0;False;70;FLOAT3;0,0,0;False;45;FLOAT;0;False;148;FLOAT3;0,0,0;False;41;FLOAT;0;False;189;FLOAT;0;False;3;FLOAT3;4;FLOAT3;5;FLOAT3;3
Node;AmplifyShaderEditor.FunctionNode;2465;3152.195,-2075.843;Inherit;False;Mesh Values (Tree) (Complex) (Vertex Colors);-1;;26507;9cacaefc2ecfddf4c8e070f9be99b854;0;0;4;FLOAT;495;FLOAT;501;FLOAT;550;FLOAT;552
Node;AmplifyShaderEditor.SimpleAddOpNode;2728;3270.15,-2359.37;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;2366;3838.939,-1097.147;Inherit;False;Internal Features Support;-1;;26511;3c493d142aeebd840af72d626f6915c6;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2492;4148.937,-843.1475;Half;False;Property;_IsShadow;Is Shadow;109;1;[Toggle];Create;True;2;Off;0;On;1;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1468;3842.939,-1202.147;Half;False;Property;_LEAFF;[ LEAFF ];9;0;Create;True;0;0;True;1;InternalCategory(Leaf);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1472;3842.939,-1394.148;Half;False;Property;_BANNER;BANNER;0;0;Create;True;0;0;True;1;InternalBanner(Internal, Leaf);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;2792;2271.119,-2499.458;Inherit;False;Constant;_Vector0;Vector 0;35;0;Create;True;0;0;False;0;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;2433;3828.939,-843.1475;Half;False;Property;_IsBark;Is Bark;108;1;[Toggle];Create;True;2;Off;0;On;1;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2391;3815.937,-996.1475;Inherit;False;Property;_Cutoff;Depth Cutoff;1;1;[HideInInspector];Create;False;0;0;False;0;0.7;0.75;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2806;3604.155,-2252.545;Inherit;False;Cutoff Distance;2;;26508;5fa78795cf865fc4fba7d47ebe2d2d92;0;2;33;FLOAT;0;False;16;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2491;3988.938,-843.1475;Half;False;Property;_IsLeaf;Is Leaf;107;1;[Toggle];Create;True;2;Off;0;On;1;0;True;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2362;2786.62,-2060.989;Inherit;False;primary;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;4078.67,-2456.328;Float;False;True;-1;4;AppalachiaShaderGUI;400;0;CustomLighting;appalachia/leaf_LOD0;False;False;False;False;False;False;False;False;False;False;False;False;True;True;False;False;True;False;False;False;False;Off;1;False;925;3;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.75;True;True;0;True;Custom;InternalLeaf;AlphaTest;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;550;10;False;553;0;1;False;550;1;False;553;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;False;False;_BILLBOARD_ON;Relative;400;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;14;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;708;1801.118,-604.745;Inherit;False;1027.031;100;Normal Texture;0;;0.5019608,0.5019608,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;760;940.1176,-604.745;Inherit;False;578.3026;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;715;2860.118,-604.745;Inherit;False;826;100;Surface Texture (Metallic, AO, SubSurface, Smoothness);0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;2440;808.0198,-1512.642;Inherit;False;2871.096;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
WireConnection;2571;0;18;0
WireConnection;1836;0;645;3
WireConnection;2572;0;2571;0
WireConnection;487;0;18;0
WireConnection;2817;108;2818;0
WireConnection;2817;83;2437;0
WireConnection;2785;2;36;0
WireConnection;2785;8;2817;84
WireConnection;2469;0;2470;0
WireConnection;2469;1;2001;0
WireConnection;2784;2;2261;0
WireConnection;2784;8;2817;0
WireConnection;2772;89;2785;0
WireConnection;2772;86;1967;0
WireConnection;2772;87;1965;0
WireConnection;2782;2;2258;0
WireConnection;2782;8;2357;0
WireConnection;2568;2;2784;0
WireConnection;2568;4;2772;37
WireConnection;2568;5;2469;0
WireConnection;2255;17;2464;549
WireConnection;2255;18;2256;0
WireConnection;2255;19;2568;0
WireConnection;2255;20;2782;0
WireConnection;607;5;655;0
WireConnection;1343;0;2255;0
WireConnection;1306;0;18;4
WireConnection;1788;0;645;2
WireConnection;2794;13;607;0
WireConnection;745;0;645;4
WireConnection;745;1;294;0
WireConnection;2580;0;1343;0
WireConnection;2613;0;745;0
WireConnection;620;0;2794;0
WireConnection;2736;0;2738;0
WireConnection;2736;3;2737;0
WireConnection;2829;12;1795;0
WireConnection;2829;48;1814;3
WireConnection;2829;26;2738;0
WireConnection;660;0;2613;0
WireConnection;2823;55;2736;0
WireConnection;2823;44;2741;0
WireConnection;2823;113;2742;0
WireConnection;2822;6;2736;0
WireConnection;2822;7;2741;0
WireConnection;2822;57;2742;0
WireConnection;2006;0;2828;0
WireConnection;2006;1;2428;370
WireConnection;2812;25;2829;31
WireConnection;2487;41;1783;0
WireConnection;2487;58;2006;0
WireConnection;2767;2;2822;0
WireConnection;2767;3;2823;54
WireConnection;2793;56;2812;0
WireConnection;2793;55;624;0
WireConnection;2793;41;654;0
WireConnection;2793;189;2829;0
WireConnection;2728;0;2793;3
WireConnection;2728;1;2767;0
WireConnection;2806;33;2487;0
WireConnection;2806;16;2465;550
WireConnection;2362;0;2828;1021
WireConnection;0;0;2793;4
WireConnection;0;2;2793;5
WireConnection;0;10;2806;0
WireConnection;0;14;2728;0
WireConnection;0;11;2487;91
WireConnection;0;12;2428;369
WireConnection;0;13;2428;371
ASEEND*/
//CHKSM=368327C913D83C55CDCB41B22FDD0BCDA09B9981
