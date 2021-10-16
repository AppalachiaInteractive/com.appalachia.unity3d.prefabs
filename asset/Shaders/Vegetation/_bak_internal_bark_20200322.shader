// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "internal/backup/bark-20200322"
{
	Properties
	{
		[HideInInspector]_Mode1("_Mode", Float) = 0
		[InternalBanner(Internal, Bark)]_ADSStandardLitTreeBark("< ADS Standard Lit Tree Bark>", Float) = 1
		[Toggle(_ENABLEBASE_ON)] _ENABLEBASE("Enable Base", Float) = 0
		[InternalInteractive(_Mode, 1)]_RenderCutt("# RenderCutt", Float) = 0
		[InternalCategory(Trunk)]_TRUNKK("[ TRUNKK ]", Float) = 0
		_Color("Trunk Color", Color) = (1,1,1,1)
		[NoScaleOffset]_MainTex("MainTex", 2D) = "white" {}
		_Saturation("Saturation", Range( 0.1 , 2)) = 1
		_Brightness("Brightness", Range( 0.1 , 2)) = 1
		_BumpScale("BumpScale", Range( 0 , 5)) = 1
		[NoScaleOffset]_BumpMap("BumpMap", 2D) = "bump" {}
		[NoScaleOffset]_MetallicGlossMap("MetallicGlossMap", 2D) = "white" {}
		_Glossiness("Glossiness", Range( 0 , 1)) = 0.1
		_Occlusion("Trunk Occlusion (G)", Range( 0 , 1)) = 1
		_TrunkVariation("Trunk Variation", Range( 0 , 1)) = 1
		[Space(10)]_UVZero("Trunk UVs", Vector) = (1,1,0,0)
		[InternalCategory(Base)]_BASEE("[ BASEE ]", Float) = 0
		[InternalInteractive(_ENABLEBASE_ON)]_BlendingBasee("# BlendingBasee", Float) = 0
		_Color3("Base Color", Color) = (1,1,1,1)
		[NoScaleOffset]_MainTex3("MainTex3", 2D) = "white" {}
		_BumpScale3("BumpScale3", Float) = 1
		[NoScaleOffset][Normal]_BumpMap3("BumpMap3", 2D) = "bump" {}
		[NoScaleOffset]_MetallicGlossMap3("MetallicGlossMap3", 2D) = "white" {}
		_Glossiness3("Glossiness3", Range( 0 , 1)) = 0.1
		_Occlusion3("Base Occlusion (G)", Range( 0 , 1)) = 1
		[Space(10)]_UVZero3("Base UVs", Vector) = (1,1,0,0)
		_BaseBlendHeight("Base Blend Height", Range( 0 , 20)) = 0.1
		_BaseBlendAmount("Base Blend Amount", Range( 0.0001 , 1)) = 0.1
		_BaseBlendVariation("Base Blend Variation", Range( 0.0001 , 1)) = 0.1
		_TrunkHeightOffset("Trunk Height Offset", Range( -1 , 1)) = 0
		_TrunkHeightRange("Trunk Height Range", Range( 0 , 1)) = 1
		_BaseBlendHeightContrast("Base Blend Height Contrast", Range( 0 , 1)) = 0.5
		_BaseHeightOffset("Base Height Offset", Range( -1 , 1)) = 0
		_BaseHeightRange("Base Height Range", Range( 0 , 1)) = 0.9
		_BaseBlendNormals("Base Blend Normals", Range( 0 , 1)) = 0
		[InternalCategory(Settings)]_SETTINGSS("[ SETTINGSS ]", Float) = 0
		_TextureOcclusionDarkening("Texture Occlusion Darkening", Range( 0 , 1)) = 0.8
		_VertexOcclusion("Vertex Occlusion", Range( 0 , 1)) = 0.5
		_VertexOcclusionDarkening("Vertex Occlusion Darkening", Range( 0 , 1)) = 0.8
		[HideInInspector] _texcoord4( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" "DisableBatching" = "True" }
		LOD 300
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma shader_feature_local _ENABLEBASE_ON
		#include "UnityCG.cginc"
		#include "Assets/Resources/CGIncludes/GPUInstancerInclude.cginc"
		#pragma instancing_options procedural:setupGPUI
		#pragma exclude_renderers gles vulkan 
		#pragma surface surf Standard keepalpha vertex:vertexDataFunc 
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
			float2 uv_texcoord;
			float2 uv4_texcoord4;
			float3 worldPos;
			half ASEVFace : VFACE;
			float4 uv_tex4coord;
		};

		uniform half _BASEE;
		uniform float _Mode1;
		uniform half _ADSStandardLitTreeBark;
		uniform half _RenderCutt;
		uniform half _SETTINGSS;
		uniform half _TRUNKK;
		uniform half _BlendingBasee;
		uniform half _WIND_TRUNK_STRENGTH;
		uniform half _WIND_BASE_TRUNK_FIELD_SIZE;
		uniform half _WIND_BASE_TRUNK_CYCLE_TIME;
		uniform half _WIND_BASE_AMPLITUDE;
		uniform half _WIND_BASE_TO_GUST_RATIO;
		uniform half _WIND_GUST_AUDIO_STRENGTH;
		uniform sampler2D _WIND_GUST_TEXTURE;
		uniform half _WIND_GUST_TRUNK_FIELD_SIZE;
		uniform half _WIND_GUST_TRUNK_CYCLE_TIME;
		uniform half _WIND_GUST_CONTRAST;
		uniform half _WIND_GUST_TEXTURE_ON;
		uniform half3 _WIND_DIRECTION;
		uniform half _WIND_GUST_AMPLITUDE;
		uniform half _WIND_BRANCH_STRENGTH;
		uniform half _WIND_BASE_BRANCH_FIELD_SIZE;
		uniform half _WIND_BASE_BRANCH_VARIATION_STRENGTH;
		uniform half _WIND_BASE_BRANCH_CYCLE_TIME;
		uniform half _WIND_GUST_BRANCH_FIELD_SIZE;
		uniform half _WIND_GUST_BRANCH_CYCLE_TIME;
		uniform half _WIND_GUST_BRANCH_VARIATION_STRENGTH;
		uniform half _WIND_LEAF_STRENGTH;
		uniform half _WIND_BASE_LEAF_FIELD_SIZE;
		uniform half _WIND_BASE_LEAF_CYCLE_TIME;
		uniform half _BumpScale;
		uniform sampler2D _BumpMap;
		uniform half4 _UVZero;
		uniform half _TrunkVariation;
		uniform half _BumpScale3;
		uniform sampler2D _BumpMap3;
		uniform half4 _UVZero3;
		uniform half _BaseBlendHeight;
		uniform half _BaseBlendAmount;
		uniform half _BaseBlendVariation;
		uniform sampler2D _MetallicGlossMap3;
		uniform float _BaseHeightRange;
		uniform float _BaseHeightOffset;
		uniform sampler2D _MetallicGlossMap;
		uniform float _TrunkHeightRange;
		uniform float _TrunkHeightOffset;
		uniform float _BaseBlendHeightContrast;
		uniform half _BaseBlendNormals;
		uniform half _Occlusion;
		uniform half _TextureOcclusionDarkening;
		uniform half _VertexOcclusion;
		uniform half _VertexOcclusionDarkening;
		uniform sampler2D _MainTex;
		uniform float _Saturation;
		uniform float _Brightness;
		uniform sampler2D _MainTex3;
		uniform half4 _Color;
		uniform half4 _Color3;
		uniform half _Glossiness;
		uniform half _Glossiness3;
		uniform half _Occlusion3;


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

		void vertexDataFunc( inout appdata_full_custom v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			half localunity_ObjectToWorld0w1_g3182 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g3182 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g3182 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g3182 = (float3(localunity_ObjectToWorld0w1_g3182 , localunity_ObjectToWorld1w2_g3182 , localunity_ObjectToWorld2w3_g3182));
			float3 temp_output_831_510_g3060 = appendResult6_g3182;
			float2 temp_output_1_0_g3072 = (temp_output_831_510_g3060).xz;
			float temp_output_2_0_g3068 = _WIND_BASE_TRUNK_FIELD_SIZE;
			float2 temp_cast_0 = (( 1.0 / (( temp_output_2_0_g3068 == 0.0 ) ? 1.0 :  temp_output_2_0_g3068 ) )).xx;
			float2 temp_output_2_0_g3072 = temp_cast_0;
			float2 temp_output_704_0_g3061 = ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g3072 / temp_output_2_0_g3072 ) :  ( temp_output_1_0_g3072 * temp_output_2_0_g3072 ) ) + float2( 0,0 ) );
			float temp_output_2_0_g3178 = _WIND_BASE_TRUNK_CYCLE_TIME;
			float temp_output_618_0_g3061 = ( 1.0 / (( temp_output_2_0_g3178 == 0.0 ) ? 1.0 :  temp_output_2_0_g3178 ) );
			float2 break298_g3073 = ( temp_output_704_0_g3061 + ( temp_output_618_0_g3061 * _Time.y ) );
			float2 appendResult299_g3073 = (float2(sin( break298_g3073.x ) , cos( break298_g3073.y )));
			float4 temp_output_273_0_g3073 = (-1.0).xxxx;
			float4 temp_output_271_0_g3073 = (1.0).xxxx;
			float2 clampResult26_g3073 = clamp( appendResult299_g3073 , temp_output_273_0_g3073.xy , temp_output_271_0_g3073.xy );
			float temp_output_831_495_g3060 = _WIND_BASE_AMPLITUDE;
			float temp_output_831_501_g3060 = _WIND_BASE_TO_GUST_RATIO;
			float temp_output_524_0_g3061 = ( temp_output_831_495_g3060 * temp_output_831_501_g3060 );
			float2 TRUNK_PIVOT_ROCKING701_g3061 = ( clampResult26_g3073 * temp_output_524_0_g3061 );
			float _WIND_PRIMARY_ROLL669_g3061 = v.color.r;
			float temp_output_54_0_g3063 = ( TRUNK_PIVOT_ROCKING701_g3061 * 0.15 * _WIND_PRIMARY_ROLL669_g3061 ).x;
			float temp_output_72_0_g3063 = cos( temp_output_54_0_g3063 );
			float one_minus_c52_g3063 = ( 1.0 - temp_output_72_0_g3063 );
			float3 break70_g3063 = float3(0,1,0);
			float axis_x25_g3063 = break70_g3063.x;
			float c66_g3063 = temp_output_72_0_g3063;
			float axis_y37_g3063 = break70_g3063.y;
			float axis_z29_g3063 = break70_g3063.z;
			float s67_g3063 = sin( temp_output_54_0_g3063 );
			float3 appendResult83_g3063 = (float3(( ( one_minus_c52_g3063 * axis_x25_g3063 * axis_x25_g3063 ) + c66_g3063 ) , ( ( one_minus_c52_g3063 * axis_x25_g3063 * axis_y37_g3063 ) - ( axis_z29_g3063 * s67_g3063 ) ) , ( ( one_minus_c52_g3063 * axis_z29_g3063 * axis_x25_g3063 ) + ( axis_y37_g3063 * s67_g3063 ) )));
			float3 appendResult81_g3063 = (float3(( ( one_minus_c52_g3063 * axis_x25_g3063 * axis_y37_g3063 ) + ( axis_z29_g3063 * s67_g3063 ) ) , ( ( one_minus_c52_g3063 * axis_y37_g3063 * axis_y37_g3063 ) + c66_g3063 ) , ( ( one_minus_c52_g3063 * axis_y37_g3063 * axis_z29_g3063 ) - ( axis_x25_g3063 * s67_g3063 ) )));
			float3 appendResult82_g3063 = (float3(( ( one_minus_c52_g3063 * axis_z29_g3063 * axis_x25_g3063 ) - ( axis_y37_g3063 * s67_g3063 ) ) , ( ( one_minus_c52_g3063 * axis_y37_g3063 * axis_z29_g3063 ) + ( axis_x25_g3063 * s67_g3063 ) ) , ( ( one_minus_c52_g3063 * axis_z29_g3063 * axis_z29_g3063 ) + c66_g3063 )));
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 _WIND_PRIMARY_PIVOT655_g3061 = (v.texcoord1).xyz;
			float3 temp_output_38_0_g3063 = ( ase_vertex3Pos - (_WIND_PRIMARY_PIVOT655_g3061).xyz );
			float2 break298_g3065 = ( temp_output_704_0_g3061 + ( temp_output_618_0_g3061 * _Time.y ) );
			float2 appendResult299_g3065 = (float2(sin( break298_g3065.x ) , cos( break298_g3065.y )));
			float4 temp_output_273_0_g3065 = (-1.0).xxxx;
			float4 temp_output_271_0_g3065 = (1.0).xxxx;
			float2 clampResult26_g3065 = clamp( appendResult299_g3065 , temp_output_273_0_g3065.xy , temp_output_271_0_g3065.xy );
			float2 TRUNK_SWIRL700_g3061 = ( clampResult26_g3065 * temp_output_524_0_g3061 );
			float2 break699_g3061 = TRUNK_SWIRL700_g3061;
			float4 appendResult698_g3061 = (float4(break699_g3061.x , 0.0 , break699_g3061.y , 0.0));
			float4 temp_output_694_0_g3061 = ( float4( ( mul( float3x3(appendResult83_g3063, appendResult81_g3063, appendResult82_g3063), temp_output_38_0_g3063 ) - temp_output_38_0_g3063 ) , 0.0 ) + ( _WIND_PRIMARY_ROLL669_g3061 * appendResult698_g3061 ) );
			float temp_output_831_579_g3060 = _WIND_GUST_AUDIO_STRENGTH;
			float4 color658_g3141 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float2 temp_output_61_0_g3147 = float2( 0,0 );
			float2 temp_output_1_0_g3152 = temp_output_831_510_g3060.xy;
			float temp_output_2_0_g3143 = _WIND_GUST_TRUNK_FIELD_SIZE;
			float temp_output_40_0_g3147 = ( 1.0 / (( temp_output_2_0_g3143 == 0.0 ) ? 1.0 :  temp_output_2_0_g3143 ) );
			float2 temp_cast_9 = (temp_output_40_0_g3147).xx;
			float2 temp_output_2_0_g3152 = temp_cast_9;
			float temp_output_2_0_g3153 = _WIND_GUST_TRUNK_CYCLE_TIME;
			float mulTime37_g3147 = _Time.y * ( 1.0 / (( temp_output_2_0_g3153 == 0.0 ) ? 1.0 :  temp_output_2_0_g3153 ) );
			float temp_output_220_0_g3148 = -1.0;
			float4 temp_cast_10 = (temp_output_220_0_g3148).xxxx;
			float temp_output_219_0_g3148 = 1.0;
			float4 temp_cast_11 = (temp_output_219_0_g3148).xxxx;
			float4 clampResult26_g3148 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g3147 > float2( 0,0 ) ) ? ( temp_output_1_0_g3152 / temp_output_2_0_g3152 ) :  ( temp_output_1_0_g3152 * temp_output_2_0_g3152 ) ) + temp_output_61_0_g3147 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g3147 ) ) , temp_cast_10 , temp_cast_11 );
			float4 temp_cast_12 = (temp_output_220_0_g3148).xxxx;
			float4 temp_cast_13 = (temp_output_219_0_g3148).xxxx;
			float4 temp_cast_14 = (0.0).xxxx;
			float4 temp_cast_15 = (temp_output_219_0_g3148).xxxx;
			float temp_output_831_526_g3060 = _WIND_GUST_CONTRAST;
			float4 temp_cast_16 = (temp_output_831_526_g3060).xxxx;
			float4 temp_output_52_0_g3147 = saturate( pow( abs( (temp_cast_14 + (clampResult26_g3148 - temp_cast_12) * (temp_cast_15 - temp_cast_14) / (temp_cast_13 - temp_cast_12)) ) , temp_cast_16 ) );
			float temp_output_831_527_g3060 = _WIND_GUST_TEXTURE_ON;
			float4 lerpResult656_g3141 = lerp( color658_g3141 , temp_output_52_0_g3147 , temp_output_831_527_g3060);
			float2 weightedBlendVar660_g3141 = (0.5).xx;
			float4 weightedBlend660_g3141 = ( weightedBlendVar660_g3141.x*(temp_output_831_579_g3060).xxxx + weightedBlendVar660_g3141.y*lerpResult656_g3141 );
			float4 break655_g3141 = weightedBlend660_g3141;
			float temp_output_965_630_g3060 = break655_g3141.x;
			float _WIND_GUST_STRENGTH703_g3061 = temp_output_965_630_g3060;
			float _WIND_PRIMARY_BEND662_g3061 = v.texcoord1.w;
			float temp_output_54_0_g3064 = ( ( _WIND_GUST_STRENGTH703_g3061 * -1.0 ) * _WIND_PRIMARY_BEND662_g3061 );
			float temp_output_72_0_g3064 = cos( temp_output_54_0_g3064 );
			float one_minus_c52_g3064 = ( 1.0 - temp_output_72_0_g3064 );
			float3 temp_output_831_494_g3060 = _WIND_DIRECTION;
			float3 _WIND_DIRECTION671_g3061 = temp_output_831_494_g3060;
			float4 transform641_g3061 = mul(unity_WorldToObject,float4( cross( _WIND_DIRECTION671_g3061 , float3(0,1,0) ) , 0.0 ));
			float3 break70_g3064 = transform641_g3061.xyz;
			float axis_x25_g3064 = break70_g3064.x;
			float c66_g3064 = temp_output_72_0_g3064;
			float axis_y37_g3064 = break70_g3064.y;
			float axis_z29_g3064 = break70_g3064.z;
			float s67_g3064 = sin( temp_output_54_0_g3064 );
			float3 appendResult83_g3064 = (float3(( ( one_minus_c52_g3064 * axis_x25_g3064 * axis_x25_g3064 ) + c66_g3064 ) , ( ( one_minus_c52_g3064 * axis_x25_g3064 * axis_y37_g3064 ) - ( axis_z29_g3064 * s67_g3064 ) ) , ( ( one_minus_c52_g3064 * axis_z29_g3064 * axis_x25_g3064 ) + ( axis_y37_g3064 * s67_g3064 ) )));
			float3 appendResult81_g3064 = (float3(( ( one_minus_c52_g3064 * axis_x25_g3064 * axis_y37_g3064 ) + ( axis_z29_g3064 * s67_g3064 ) ) , ( ( one_minus_c52_g3064 * axis_y37_g3064 * axis_y37_g3064 ) + c66_g3064 ) , ( ( one_minus_c52_g3064 * axis_y37_g3064 * axis_z29_g3064 ) - ( axis_x25_g3064 * s67_g3064 ) )));
			float3 appendResult82_g3064 = (float3(( ( one_minus_c52_g3064 * axis_z29_g3064 * axis_x25_g3064 ) - ( axis_y37_g3064 * s67_g3064 ) ) , ( ( one_minus_c52_g3064 * axis_y37_g3064 * axis_z29_g3064 ) + ( axis_x25_g3064 * s67_g3064 ) ) , ( ( one_minus_c52_g3064 * axis_z29_g3064 * axis_z29_g3064 ) + c66_g3064 )));
			float3 temp_output_38_0_g3064 = ( ase_vertex3Pos - (_WIND_PRIMARY_PIVOT655_g3061).xyz );
			float temp_output_831_498_g3060 = _WIND_GUST_AMPLITUDE;
			float smoothstepResult551_g3061 = smoothstep( 0.0 , 1.0 , temp_output_831_498_g3060);
			float4 lerpResult538_g3061 = lerp( temp_output_694_0_g3061 , ( temp_output_694_0_g3061 + float4( ( mul( float3x3(appendResult83_g3064, appendResult81_g3064, appendResult82_g3064), temp_output_38_0_g3064 ) - temp_output_38_0_g3064 ) , 0.0 ) ) , smoothstepResult551_g3061);
			float3 _WIND_POSITION_ROOT1002_g3076 = temp_output_831_510_g3060;
			float2 temp_output_1_0_g3077 = (_WIND_POSITION_ROOT1002_g3076).xz;
			float _WIND_BASE_BRANCH_FIELD_SIZE1004_g3076 = _WIND_BASE_BRANCH_FIELD_SIZE;
			float temp_output_2_0_g3094 = _WIND_BASE_BRANCH_FIELD_SIZE1004_g3076;
			float2 temp_cast_21 = (( 1.0 / (( temp_output_2_0_g3094 == 0.0 ) ? 1.0 :  temp_output_2_0_g3094 ) )).xx;
			float2 temp_output_2_0_g3077 = temp_cast_21;
			float temp_output_970_552_g3060 = v.color.a;
			float _WIND_PHASE852_g3076 = temp_output_970_552_g3060;
			float _WIND_BASE_BRANCH_VARIATION_STRENGTH1006_g3076 = _WIND_BASE_BRANCH_VARIATION_STRENGTH;
			float2 temp_cast_22 = (( ( _WIND_PHASE852_g3076 * _WIND_BASE_BRANCH_VARIATION_STRENGTH1006_g3076 ) * UNITY_PI )).xx;
			float temp_output_2_0_g3170 = _WIND_BASE_BRANCH_CYCLE_TIME;
			float2 break298_g3088 = ( ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g3077 / temp_output_2_0_g3077 ) :  ( temp_output_1_0_g3077 * temp_output_2_0_g3077 ) ) + temp_cast_22 ) + ( ( ( 1.0 / (( temp_output_2_0_g3170 == 0.0 ) ? 1.0 :  temp_output_2_0_g3170 ) ) * _WIND_PHASE852_g3076 ) * _Time.y ) );
			float2 appendResult299_g3088 = (float2(sin( break298_g3088.x ) , cos( break298_g3088.y )));
			float4 temp_output_273_0_g3088 = (-1.0).xxxx;
			float4 temp_output_271_0_g3088 = (1.0).xxxx;
			float2 clampResult26_g3088 = clamp( appendResult299_g3088 , temp_output_273_0_g3088.xy , temp_output_271_0_g3088.xy );
			float2 BRANCH_SWIRL931_g3076 = ( clampResult26_g3088 * ( temp_output_831_495_g3060 * temp_output_831_501_g3060 ) );
			float2 break932_g3076 = BRANCH_SWIRL931_g3076;
			float4 appendResult933_g3076 = (float4(break932_g3076.x , 0.0 , break932_g3076.y , 0.0));
			float _WIND_SECONDARY_ROLL650_g3076 = v.color.g;
			float4 VALUE_ROLL1034_g3076 = ( appendResult933_g3076 * _WIND_SECONDARY_ROLL650_g3076 );
			float3 _WIND_DIRECTION856_g3076 = temp_output_831_494_g3060;
			float3 temp_output_839_0_g3076 = (v.texcoord2).xyz;
			float3 _WIND_SECONDARY_GROWTH_DIRECTION = float3(0,1,0);
			float3 _WIND_SECONDARY_GROWTH_DIRECTION840_g3076 = (( length( temp_output_839_0_g3076 ) == 0.0 ) ? _WIND_SECONDARY_GROWTH_DIRECTION :  temp_output_839_0_g3076 );
			float4 transform566_g3076 = mul(unity_ObjectToWorld,float4( _WIND_SECONDARY_GROWTH_DIRECTION840_g3076 , 0.0 ));
			float dotResult565_g3076 = dot( float4( _WIND_DIRECTION856_g3076 , 0.0 ) , transform566_g3076 );
			float clampResult13_g3079 = clamp( dotResult565_g3076 , -1.0 , 1.0 );
			float4 color658_g3125 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float2 temp_output_61_0_g3131 = float2( 0,0 );
			float3 temp_output_970_498_g3060 = (v.texcoord3).xyz;
			float2 temp_output_1_0_g3136 = ( temp_output_831_510_g3060 + temp_output_970_498_g3060 + temp_output_970_552_g3060 ).xy;
			float temp_output_831_571_g3060 = _WIND_GUST_BRANCH_FIELD_SIZE;
			float temp_output_2_0_g3127 = temp_output_831_571_g3060;
			float temp_output_40_0_g3131 = ( 1.0 / (( temp_output_2_0_g3127 == 0.0 ) ? 1.0 :  temp_output_2_0_g3127 ) );
			float2 temp_cast_28 = (temp_output_40_0_g3131).xx;
			float2 temp_output_2_0_g3136 = temp_cast_28;
			float temp_output_2_0_g3137 = _WIND_GUST_BRANCH_CYCLE_TIME;
			float mulTime37_g3131 = _Time.y * ( 1.0 / (( temp_output_2_0_g3137 == 0.0 ) ? 1.0 :  temp_output_2_0_g3137 ) );
			float temp_output_220_0_g3132 = -1.0;
			float4 temp_cast_29 = (temp_output_220_0_g3132).xxxx;
			float temp_output_219_0_g3132 = 1.0;
			float4 temp_cast_30 = (temp_output_219_0_g3132).xxxx;
			float4 clampResult26_g3132 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g3131 > float2( 0,0 ) ) ? ( temp_output_1_0_g3136 / temp_output_2_0_g3136 ) :  ( temp_output_1_0_g3136 * temp_output_2_0_g3136 ) ) + temp_output_61_0_g3131 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g3131 ) ) , temp_cast_29 , temp_cast_30 );
			float4 temp_cast_31 = (temp_output_220_0_g3132).xxxx;
			float4 temp_cast_32 = (temp_output_219_0_g3132).xxxx;
			float4 temp_cast_33 = (0.0).xxxx;
			float4 temp_cast_34 = (temp_output_219_0_g3132).xxxx;
			float4 temp_cast_35 = (temp_output_831_526_g3060).xxxx;
			float4 temp_output_52_0_g3131 = saturate( pow( abs( (temp_cast_33 + (clampResult26_g3132 - temp_cast_31) * (temp_cast_34 - temp_cast_33) / (temp_cast_32 - temp_cast_31)) ) , temp_cast_35 ) );
			float4 lerpResult656_g3125 = lerp( color658_g3125 , temp_output_52_0_g3131 , temp_output_831_527_g3060);
			float2 weightedBlendVar660_g3125 = (0.5).xx;
			float4 weightedBlend660_g3125 = ( weightedBlendVar660_g3125.x*(temp_output_831_579_g3060).xxxx + weightedBlendVar660_g3125.y*lerpResult656_g3125 );
			float4 break655_g3125 = weightedBlend660_g3125;
			float _WIND_GUST_STRENGTH_A871_g3076 = break655_g3125.y;
			float _WIND_SECONDARY_BEND849_g3076 = v.texcoord3.w;
			float temp_output_54_0_g3101 = ( ( _WIND_GUST_STRENGTH_A871_g3076 * -1.0 ) * _WIND_SECONDARY_BEND849_g3076 );
			float temp_output_72_0_g3101 = cos( temp_output_54_0_g3101 );
			float one_minus_c52_g3101 = ( 1.0 - temp_output_72_0_g3101 );
			float4 transform832_g3076 = mul(unity_WorldToObject,float4( cross( _WIND_DIRECTION856_g3076 , float3(0,1,0) ) , 0.0 ));
			float3 break70_g3101 = transform832_g3076.xyz;
			float axis_x25_g3101 = break70_g3101.x;
			float c66_g3101 = temp_output_72_0_g3101;
			float axis_y37_g3101 = break70_g3101.y;
			float axis_z29_g3101 = break70_g3101.z;
			float s67_g3101 = sin( temp_output_54_0_g3101 );
			float3 appendResult83_g3101 = (float3(( ( one_minus_c52_g3101 * axis_x25_g3101 * axis_x25_g3101 ) + c66_g3101 ) , ( ( one_minus_c52_g3101 * axis_x25_g3101 * axis_y37_g3101 ) - ( axis_z29_g3101 * s67_g3101 ) ) , ( ( one_minus_c52_g3101 * axis_z29_g3101 * axis_x25_g3101 ) + ( axis_y37_g3101 * s67_g3101 ) )));
			float3 appendResult81_g3101 = (float3(( ( one_minus_c52_g3101 * axis_x25_g3101 * axis_y37_g3101 ) + ( axis_z29_g3101 * s67_g3101 ) ) , ( ( one_minus_c52_g3101 * axis_y37_g3101 * axis_y37_g3101 ) + c66_g3101 ) , ( ( one_minus_c52_g3101 * axis_y37_g3101 * axis_z29_g3101 ) - ( axis_x25_g3101 * s67_g3101 ) )));
			float3 appendResult82_g3101 = (float3(( ( one_minus_c52_g3101 * axis_z29_g3101 * axis_x25_g3101 ) - ( axis_y37_g3101 * s67_g3101 ) ) , ( ( one_minus_c52_g3101 * axis_y37_g3101 * axis_z29_g3101 ) + ( axis_x25_g3101 * s67_g3101 ) ) , ( ( one_minus_c52_g3101 * axis_z29_g3101 * axis_z29_g3101 ) + c66_g3101 )));
			float3 _WIND_SECONDARY_PIVOT846_g3076 = temp_output_970_498_g3060;
			float3 temp_output_38_0_g3101 = ( ase_vertex3Pos - (_WIND_SECONDARY_PIVOT846_g3076).xyz );
			float3 VALUE_FACING_WIND1042_g3076 = ( mul( float3x3(appendResult83_g3101, appendResult81_g3101, appendResult82_g3101), temp_output_38_0_g3101 ) - temp_output_38_0_g3101 );
			float4 transform1084_g3076 = mul(unity_ObjectToWorld,float4( _WIND_SECONDARY_PIVOT846_g3076 , 0.0 ));
			float2 temp_output_1_0_g3098 = (transform1084_g3076).xz;
			float _WIND_GUST_BRANCH_FIELD_SIZE1011_g3076 = temp_output_831_571_g3060;
			float temp_output_2_0_g3084 = _WIND_GUST_BRANCH_FIELD_SIZE1011_g3076;
			float2 temp_cast_41 = (( 1.0 / (( temp_output_2_0_g3084 == 0.0 ) ? 1.0 :  temp_output_2_0_g3084 ) )).xx;
			float2 temp_output_2_0_g3098 = temp_cast_41;
			float _WIND_GUST_BRANCH_VARIATION_STRENGTH1008_g3076 = _WIND_GUST_BRANCH_VARIATION_STRENGTH;
			float2 temp_cast_42 = (( ( _WIND_PHASE852_g3076 * _WIND_GUST_BRANCH_VARIATION_STRENGTH1008_g3076 ) * UNITY_PI )).xx;
			float temp_output_2_0_g3158 = _WIND_GUST_BRANCH_CYCLE_TIME;
			float _WIND_GUST_BRANCH_FREQUENCY1012_g3076 = ( 1.0 / (( temp_output_2_0_g3158 == 0.0 ) ? 1.0 :  temp_output_2_0_g3158 ) );
			float2 break298_g3091 = ( ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g3098 / temp_output_2_0_g3098 ) :  ( temp_output_1_0_g3098 * temp_output_2_0_g3098 ) ) + temp_cast_42 ) + ( _WIND_GUST_BRANCH_FREQUENCY1012_g3076 * _Time.y ) );
			float2 appendResult299_g3091 = (float2(sin( break298_g3091.x ) , cos( break298_g3091.y )));
			float4 temp_output_273_0_g3091 = (-1.0).xxxx;
			float4 temp_output_271_0_g3091 = (1.0).xxxx;
			float2 clampResult26_g3091 = clamp( appendResult299_g3091 , temp_output_273_0_g3091.xy , temp_output_271_0_g3091.xy );
			float2 break305_g3091 = float2( 0,1 );
			float _WIND_GUST_STRENGTH_B999_g3076 = break655_g3125.z;
			float2 break1067_g3076 = ( ( ((break305_g3091.x).xxxx.xy + (clampResult26_g3091 - temp_output_273_0_g3091.xy) * ((break305_g3091.y).xxxx.xy - (break305_g3091.x).xxxx.xy) / (temp_output_271_0_g3091.xy - temp_output_273_0_g3091.xy)) * _WIND_SECONDARY_ROLL650_g3076 ) * _WIND_GUST_STRENGTH_B999_g3076 );
			float4 appendResult1066_g3076 = (float4(break1067_g3076.x , 0.0 , break1067_g3076.y , 0.0));
			float3 worldToObjDir1089_g3076 = normalize( mul( unity_WorldToObject, float4( _WIND_DIRECTION856_g3076, 0 ) ).xyz );
			float4 BRANCH_SWIRL972_g3076 = ( appendResult1066_g3076 * float4( worldToObjDir1089_g3076 , 0.0 ) );
			float4 VALUE_PERPENDICULAR1041_g3076 = BRANCH_SWIRL972_g3076;
			float4 temp_output_3_0_g3079 = VALUE_PERPENDICULAR1041_g3076;
			float4 lerpResult2_g3079 = lerp( float4( VALUE_FACING_WIND1042_g3076 , 0.0 ) , temp_output_3_0_g3079 , ( 1.0 + clampResult13_g3079 ));
			float _WIND_GUST_STRENGTH_C1110_g3076 = break655_g3125.w;
			float temp_output_54_0_g3103 = ( _WIND_GUST_STRENGTH_C1110_g3076 * _WIND_SECONDARY_BEND849_g3076 * ( _WIND_PHASE852_g3076 + ( _WIND_GUST_BRANCH_VARIATION_STRENGTH1008_g3076 % 1.0 ) + 3.25 ) );
			float temp_output_72_0_g3103 = cos( temp_output_54_0_g3103 );
			float one_minus_c52_g3103 = ( 1.0 - temp_output_72_0_g3103 );
			float3 break70_g3103 = float3(0,1,0);
			float axis_x25_g3103 = break70_g3103.x;
			float c66_g3103 = temp_output_72_0_g3103;
			float axis_y37_g3103 = break70_g3103.y;
			float axis_z29_g3103 = break70_g3103.z;
			float s67_g3103 = sin( temp_output_54_0_g3103 );
			float3 appendResult83_g3103 = (float3(( ( one_minus_c52_g3103 * axis_x25_g3103 * axis_x25_g3103 ) + c66_g3103 ) , ( ( one_minus_c52_g3103 * axis_x25_g3103 * axis_y37_g3103 ) - ( axis_z29_g3103 * s67_g3103 ) ) , ( ( one_minus_c52_g3103 * axis_z29_g3103 * axis_x25_g3103 ) + ( axis_y37_g3103 * s67_g3103 ) )));
			float3 appendResult81_g3103 = (float3(( ( one_minus_c52_g3103 * axis_x25_g3103 * axis_y37_g3103 ) + ( axis_z29_g3103 * s67_g3103 ) ) , ( ( one_minus_c52_g3103 * axis_y37_g3103 * axis_y37_g3103 ) + c66_g3103 ) , ( ( one_minus_c52_g3103 * axis_y37_g3103 * axis_z29_g3103 ) - ( axis_x25_g3103 * s67_g3103 ) )));
			float3 appendResult82_g3103 = (float3(( ( one_minus_c52_g3103 * axis_z29_g3103 * axis_x25_g3103 ) - ( axis_y37_g3103 * s67_g3103 ) ) , ( ( one_minus_c52_g3103 * axis_y37_g3103 * axis_z29_g3103 ) + ( axis_x25_g3103 * s67_g3103 ) ) , ( ( one_minus_c52_g3103 * axis_z29_g3103 * axis_z29_g3103 ) + c66_g3103 )));
			float3 temp_output_38_0_g3103 = ( ase_vertex3Pos - (_WIND_SECONDARY_PIVOT846_g3076).xyz );
			float3 VALUE_AWAY_FROM_WIND1040_g3076 = ( mul( float3x3(appendResult83_g3103, appendResult81_g3103, appendResult82_g3103), temp_output_38_0_g3103 ) - temp_output_38_0_g3103 );
			float4 lerpResult5_g3079 = lerp( temp_output_3_0_g3079 , float4( VALUE_AWAY_FROM_WIND1040_g3076 , 0.0 ) , clampResult13_g3079);
			float smoothstepResult636_g3076 = smoothstep( 0.0 , 1.0 , temp_output_831_498_g3060);
			float4 lerpResult631_g3076 = lerp( VALUE_ROLL1034_g3076 , (( clampResult13_g3079 < 0.0 ) ? lerpResult2_g3079 :  lerpResult5_g3079 ) , smoothstepResult636_g3076);
			float temp_output_17_0_g3121 = 3.0;
			float temp_output_18_0_g3121 = v.texcoord2.w;
			float _WIND_TERTIARY_ROLL669_g3183 = v.color.b;
			float2 temp_output_1_0_g3184 = v.texcoord.xy;
			float temp_output_2_0_g3188 = _WIND_BASE_LEAF_FIELD_SIZE;
			float2 temp_output_2_0_g3184 = (( 1.0 / (( temp_output_2_0_g3188 == 0.0 ) ? 1.0 :  temp_output_2_0_g3188 ) )).xxxx.xy;
			float temp_output_2_0_g3166 = _WIND_BASE_LEAF_CYCLE_TIME;
			float2 break298_g3185 = ( ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g3184 / temp_output_2_0_g3184 ) :  ( temp_output_1_0_g3184 * temp_output_2_0_g3184 ) ) + float2( 0,0 ) ) + ( ( 1.0 / (( temp_output_2_0_g3166 == 0.0 ) ? 1.0 :  temp_output_2_0_g3166 ) ) * _Time.y ) );
			float2 appendResult299_g3185 = (float2(sin( break298_g3185.x ) , cos( break298_g3185.y )));
			float4 temp_output_273_0_g3185 = (-1.0).xxxx;
			float4 temp_output_271_0_g3185 = (1.0).xxxx;
			float2 clampResult26_g3185 = clamp( appendResult299_g3185 , temp_output_273_0_g3185.xy , temp_output_271_0_g3185.xy );
			float2 break699_g3183 = ( clampResult26_g3185 * ( temp_output_831_495_g3060 * temp_output_831_501_g3060 ) );
			float4 appendResult698_g3183 = (float4(break699_g3183.x , 0.0 , break699_g3183.y , 0.0));
			float4 temp_output_684_0_g3183 = ( _WIND_TERTIARY_ROLL669_g3183 * appendResult698_g3183 );
			float smoothstepResult551_g3183 = smoothstep( 0.0 , 1.0 , temp_output_831_498_g3060);
			float4 lerpResult538_g3183 = lerp( temp_output_684_0_g3183 , ( temp_output_684_0_g3183 + float4( 0,0,0,0 ) ) , smoothstepResult551_g3183);
			float4 temp_output_19_0_g3121 = lerpResult538_g3183;
			float3 _Vector3 = float3(0,0,0);
			float3 temp_output_20_0_g3121 = _Vector3;
			v.vertex.xyz += ( ( _WIND_TRUNK_STRENGTH * lerpResult538_g3061 ) + ( _WIND_BRANCH_STRENGTH * lerpResult631_g3076 ) + ( _WIND_LEAF_STRENGTH * (( temp_output_17_0_g3121 == temp_output_18_0_g3121 ) ? temp_output_19_0_g3121 :  float4( temp_output_20_0_g3121 , 0.0 ) ) ) ).xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 appendResult564 = (float2(_UVZero.x , _UVZero.y));
			float2 appendResult565 = (float2(_UVZero.z , _UVZero.w));
			float2 temp_output_575_0 = ( ( i.uv_texcoord * appendResult564 ) + appendResult565 );
			float2 break1299 = temp_output_575_0;
			half localunity_ObjectToWorld0w1_g1420 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld2w3_g1420 = ( unity_ObjectToWorld[2].w );
			float2 appendResult1104 = (float2(break1299.x , ( break1299.y + ( localunity_ObjectToWorld0w1_g1420 + localunity_ObjectToWorld2w3_g1420 ) )));
			float2 lerpResult1825 = lerp( temp_output_575_0 , appendResult1104 , _TrunkVariation);
			half2 Main_UVs587 = lerpResult1825;
			half3 MainBumpMap620 = UnpackScaleNormal( tex2D( _BumpMap, Main_UVs587 ), _BumpScale );
			float2 appendResult1482 = (float2(_UVZero3.x , _UVZero3.y));
			float2 appendResult1483 = (float2(_UVZero3.z , _UVZero3.w));
			float2 temp_output_1485_0 = ( ( i.uv4_texcoord4 * appendResult1482 ) + appendResult1483 );
			half3 Base_NormaTex1490 = UnpackScaleNormal( tex2D( _BumpMap3, temp_output_1485_0 ), _BumpScale3 );
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			half localunity_ObjectToWorld0w1_g1421 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld2w3_g1421 = ( unity_ObjectToWorld[2].w );
			float lerpResult2138 = lerp( 1.0 , frac( ( localunity_ObjectToWorld0w1_g1421 + localunity_ObjectToWorld2w3_g1421 ) ) , _BaseBlendVariation);
			float4 tex2DNode2049 = tex2D( _MetallicGlossMap3, temp_output_1485_0 );
			half Base_MetallicGlossMap_B2229 = tex2DNode2049.b;
			float height_230_g2055 = saturate( ( (0.0 + (Base_MetallicGlossMap_B2229 - 0.0) * (_BaseHeightRange - 0.0) / (1.0 - 0.0)) + _BaseHeightOffset ) );
			float4 tex2DNode645 = tex2D( _MetallicGlossMap, Main_UVs587 );
			half Main_MetallicGlossMap_B1929 = tex2DNode645.b;
			float height_129_g2055 = saturate( ( (0.0 + (Main_MetallicGlossMap_B1929 - 0.0) * (_TrunkHeightRange - 0.0) / (1.0 - 0.0)) + _TrunkHeightOffset ) );
			float clampResult6_g2055 = clamp( ( 1.0 - saturate( _BaseBlendHeightContrast ) ) , 1E-07 , 0.999999 );
			float height_start26_g2055 = ( max( height_129_g2055 , height_230_g2055 ) - clampResult6_g2055 );
			float level_239_g2055 = max( ( height_230_g2055 - height_start26_g2055 ) , 0.0 );
			float level_138_g2055 = max( ( height_129_g2055 - height_start26_g2055 ) , 0.0 );
			float temp_output_60_0_g2055 = ( level_138_g2055 + level_239_g2055 );
			half Mask_BaseBlend1491 = ( ( 1.0 - saturate( (0.0 + (ase_vertex3Pos.y - 0.0) * (1.0 - 0.0) / (_BaseBlendHeight - 0.0)) ) ) * _BaseBlendAmount * lerpResult2138 * ( level_239_g2055 / temp_output_60_0_g2055 ) );
			float3 lerpResult1502 = lerp( MainBumpMap620 , Base_NormaTex1490 , Mask_BaseBlend1491);
			float3 lerpResult2192 = lerp( lerpResult1502 , BlendNormals( MainBumpMap620 , Base_NormaTex1490 ) , _BaseBlendNormals);
			half3 Blending_BaseNormal1897 = lerpResult2192;
			#ifdef _ENABLEBASE_ON
				float3 staticSwitch2464 = Blending_BaseNormal1897;
			#else
				float3 staticSwitch2464 = MainBumpMap620;
			#endif
			half3 OUT_NORMAL1512 = staticSwitch2464;
			o.Normal = OUT_NORMAL1512;
			float textureOcclusionDarkening2461 = ( 1.0 - ( _Occlusion * ( 1.0 - _TextureOcclusionDarkening ) ) );
			float vertexOcclusionDarkening2455 = ( 1.0 - ( _VertexOcclusion * ( 1.0 - _VertexOcclusionDarkening ) ) );
			float4 tex2DNode18 = tex2D( _MainTex, Main_UVs587 );
			float3 hsvTorgb2213 = RGBToHSV( tex2DNode18.rgb );
			float3 hsvTorgb2218 = HSVToRGB( float3(hsvTorgb2213.x,( hsvTorgb2213.y * _Saturation ),( hsvTorgb2213.z * _Brightness )) );
			half3 Main_MainTex487 = hsvTorgb2218;
			float4 tex2DNode1415 = tex2D( _MainTex3, temp_output_1485_0 );
			half4 Base_MainTex1489 = tex2DNode1415;
			float4 lerpResult1495 = lerp( float4( Main_MainTex487 , 0.0 ) , Base_MainTex1489 , Mask_BaseBlend1491);
			half4 Blending_BaseAlbedo1896 = lerpResult1495;
			#ifdef _ENABLEBASE_ON
				float4 staticSwitch2463 = Blending_BaseAlbedo1896;
			#else
				float4 staticSwitch2463 = float4( Main_MainTex487 , 0.0 );
			#endif
			half4 OUT_ALBEDO1501 = staticSwitch2463;
			half4 Main_Color486 = _Color;
			half4 Base_Color1533 = _Color3;
			float4 lerpResult1536 = lerp( Main_Color486 , Base_Color1533 , Mask_BaseBlend1491);
			half4 Blending_BaseColor1898 = lerpResult1536;
			#ifdef _ENABLEBASE_ON
				float4 staticSwitch2462 = Blending_BaseColor1898;
			#else
				float4 staticSwitch2462 = Main_Color486;
			#endif
			half4 OUT_COLOR1539 = staticSwitch2462;
			float4 color2244 = IsGammaSpace() ? float4(0,0.08482099,1,0) : float4(0,0.007826502,1,0);
			float4 switchResult2243 = (((i.ASEVFace>0)?(( textureOcclusionDarkening2461 * vertexOcclusionDarkening2455 * OUT_ALBEDO1501 * OUT_COLOR1539 )):(color2244)));
			o.Albedo = switchResult2243.rgb;
			half Main_MetallicGlossMap_A744 = tex2DNode645.a;
			half Main_Smoothness660 = ( Main_MetallicGlossMap_A744 * _Glossiness );
			half Base_MetallicGlossMap_A2051 = tex2DNode2049.a;
			half Base_Smoothness748 = ( Base_MetallicGlossMap_A2051 * _Glossiness3 );
			float lerpResult2059 = lerp( Main_Smoothness660 , Base_Smoothness748 , Mask_BaseBlend1491);
			half Blending_BaseSmoothness2060 = lerpResult2059;
			#ifdef _ENABLEBASE_ON
				float staticSwitch2465 = Blending_BaseSmoothness2060;
			#else
				float staticSwitch2465 = Main_Smoothness660;
			#endif
			half OUT_SMOOTHNESS2071 = staticSwitch2465;
			o.Smoothness = OUT_SMOOTHNESS2071;
			float lerpResult1308 = lerp( 1.0 , i.uv_tex4coord.z , _VertexOcclusion);
			half Vertex_Occlusion1312 = lerpResult1308;
			half Main_MetallicGlossMap_G1788 = tex2DNode645.g;
			float lerpResult1793 = lerp( 1.0 , Main_MetallicGlossMap_G1788 , _Occlusion);
			half Main_Occlusion1794 = lerpResult1793;
			half Base_MetallicGlossMap_G2050 = tex2DNode2049.g;
			float lerpResult2055 = lerp( 1.0 , Base_MetallicGlossMap_G2050 , _Occlusion3);
			half Base_Occlusion2056 = lerpResult2055;
			float lerpResult2065 = lerp( Main_Occlusion1794 , Base_Occlusion2056 , Mask_BaseBlend1491);
			half Blending_BaseOcclusion2064 = lerpResult2065;
			#ifdef _ENABLEBASE_ON
				float staticSwitch2466 = Blending_BaseOcclusion2064;
			#else
				float staticSwitch2466 = Main_Occlusion1794;
			#endif
			half OUT_AO2077 = staticSwitch2466;
			o.Occlusion = ( Vertex_Occlusion1312 * OUT_AO2077 );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "internal/bark-simple"
	CustomEditor "InternalShaderGUI"
}
/*ASEBEGIN
Version=17500
390.4;-790.4;676;752;-2564.924;1685.458;1.550203;True;False
Node;AmplifyShaderEditor.Vector4Node;563;-2048,-1888;Half;False;Property;_UVZero;Trunk UVs;37;0;Create;False;0;0;False;1;Space(10);1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;564;-1792,-1888;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;561;-2048,-2048;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;565;-1792,-1808;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;562;-1600,-2048;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;1102;-1426.3,-1806.7;Inherit;False;Object Position;-1;;1420;b9555b68a3d67c54f91597a05086026a;0;0;4;FLOAT3;7;FLOAT;0;FLOAT;4;FLOAT;5
Node;AmplifyShaderEditor.SimpleAddOpNode;575;-1392,-2048;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1299;-1216,-1968;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;1109;-1104,-1856;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1101;-944,-1888;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;1480;-1280,-32;Half;False;Property;_UVZero3;Base UVs;47;0;Create;False;0;0;False;1;Space(10);1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;1104;-768,-1968;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1826;-896,-1728;Half;False;Property;_TrunkVariation;Trunk Variation;36;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1482;-1024,-32;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1481;-1280,-256;Inherit;False;3;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;1825;-544,-2048;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1484;-832,-256;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;587;-320,-2048;Half;False;Main_UVs;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1483;-1024,48;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1485;-624,-256;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;644;3328,-1024;Inherit;False;587;Main_UVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;645;3584,-1024;Inherit;True;Property;_MetallicGlossMap;MetallicGlossMap;33;1;[NoScaleOffset];Create;True;0;0;False;0;-1;None;f21aa9ff13365794d8fe8e5ab752ed99;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2238;432,-96;Half;False;Property;_BaseBlendHeight;Base Blend Height;48;0;Create;True;0;0;False;1;;0.1;2;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2049;-384,128;Inherit;True;Property;_MetallicGlossMap3;MetallicGlossMap3;44;1;[NoScaleOffset];Create;True;0;0;False;0;-1;None;3d71e135301ead648aa518fbd4034569;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;588;-2048,-1280;Inherit;False;587;Main_UVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PosVertexDataNode;2237;512,-256;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1815;621.0788,45.47393;Inherit;False;Object Position;-1;;1421;b9555b68a3d67c54f91597a05086026a;0;0;4;FLOAT3;7;FLOAT;0;FLOAT;4;FLOAT;5
Node;AmplifyShaderEditor.RegisterLocalVarNode;1929;3968,-848;Half;False;Main_MetallicGlossMap_B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2229;-32,176;Half;False;Base_MetallicGlossMap_B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1817;829.0789,45.47393;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;2240;784,-256;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;18;-1792,-1280;Inherit;True;Property;_MainTex;MainTex;28;1;[NoScaleOffset];Create;True;0;0;False;0;-1;None;5f79b2d209181ac4caf48353216276d5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2215;-976,-1136;Inherit;False;Property;_Saturation;Saturation;29;0;Create;True;0;0;False;0;1;1;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2226;640,720;Float;False;Property;_BaseHeightRange;Base Height Range;55;0;Create;True;0;0;False;0;0.9;0.9;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2216;-976,-1040;Inherit;False;Property;_Brightness;Brightness;30;0;Create;True;0;0;False;0;1;1;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2227;640,800;Float;False;Property;_BaseHeightOffset;Base Height Offset;54;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;1816;973.0789,45.47393;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;2213;-928,-1280;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;2231;640,304;Inherit;False;1929;Main_MetallicGlossMap_B;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2135;973.0789,-34.52606;Inherit;False;const;-1;;1842;5b64729fb717c5f49a1bc2dab81d5e1c;3,21,0,3,1,22,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2241;992,-256;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2224;640,560;Float;False;Property;_TrunkHeightRange;Trunk Height Range;52;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1822;829.0789,157.4739;Half;False;Property;_BaseBlendVariation;Base Blend Variation;50;0;Create;True;0;0;False;1;;0.1;0.1;0.0001;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2230;640,384;Inherit;False;2229;Base_MetallicGlossMap_B;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2223;640,464;Float;False;Property;_BaseBlendHeightContrast;Base Blend Height Contrast;53;0;Create;True;0;0;False;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2225;640,640;Float;False;Property;_TrunkHeightOffset;Trunk Height Offset;51;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1426;1120.485,-78.44485;Half;False;Property;_BaseBlendAmount;Base Blend Amount;49;0;Create;True;0;0;False;1;;0.1;0.1;0.0001;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2222;1139.454,283.4037;Inherit;False;Height Blend;-1;;2055;f050d451a30c809489d59339735fb04d;0;7;3;FLOAT;0.5;False;1;FLOAT;0;False;19;FLOAT;1;False;13;FLOAT;0;False;21;FLOAT;0;False;24;FLOAT;1;False;22;FLOAT;0;False;2;FLOAT;61;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2217;-656,-1056;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2214;-656,-1168;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;2242;1152,-256;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2138;1133.079,45.47393;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1788;3968,-928;Half;False;Main_MetallicGlossMap_G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2050;-23,107;Half;False;Base_MetallicGlossMap_G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2052;512,1472;Half;False;Property;_Occlusion3;Base Occlusion (G);46;0;Create;False;0;0;False;0;1;0.6;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1532;-1280,384;Half;False;Property;_Color3;Base Color;40;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;2115;-384,1152;Inherit;False;const;-1;;2797;5b64729fb717c5f49a1bc2dab81d5e1c;3,21,0,3,1,22,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2051;-57,266;Half;False;Base_MetallicGlossMap_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1488;-768,0;Half;False;Property;_BumpScale3;BumpScale3;42;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1795;-384,1280;Inherit;False;1788;Main_MetallicGlossMap_G;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;655;2304,-896;Half;False;Property;_BumpScale;BumpScale;31;0;Create;True;0;0;False;0;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2116;512,1152;Inherit;False;const;-1;;2796;5b64729fb717c5f49a1bc2dab81d5e1c;3,21,0,3,1,22,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;409;-1792,-1072;Half;False;Property;_Color;Trunk Color;27;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1792;-384,1472;Half;False;Property;_Occlusion;Trunk Occlusion (G);35;0;Create;False;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;744;3968,-768;Half;False;Main_MetallicGlossMap_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2053;512,1280;Inherit;False;2050;Base_MetallicGlossMap_G;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1415;-384,-256;Inherit;True;Property;_MainTex3;MainTex3;41;1;[NoScaleOffset];Create;True;0;0;False;0;-1;None;395f3dc081ab76248854e859729ee5bb;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;604;2304,-1024;Inherit;False;587;Main_UVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2232;1632,0;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.HSVToRGBNode;2218;-480,-1280;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;750;-640,464;Half;False;Property;_Glossiness3;Glossiness3;45;0;Create;True;0;0;False;0;0.1;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1486;-384,-64;Inherit;True;Property;_BumpMap3;BumpMap3;43;2;[NoScaleOffset];[Normal];Create;True;0;0;False;0;-1;None;f99f6fdd4b6609e4889aada8f34a067e;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1489;-64,-256;Half;False;Base_MainTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;607;2576,-1024;Inherit;True;Property;_BumpMap;BumpMap;32;1;[NoScaleOffset];Create;True;0;0;False;0;-1;None;3130d1036d33deb49b9376334bbd026a;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;1793;0,1152;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;-1408,-1072;Half;False;Main_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;749;4352,-1024;Inherit;False;744;Main_MetallicGlossMap_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1533;-960,384;Half;False;Base_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;-224,-1280;Half;False;Main_MainTex;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;294;4352,-944;Half;False;Property;_Glossiness;Glossiness;34;0;Create;True;0;0;False;0;0.1;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2055;896,1152;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1491;1792,0;Half;False;Mask_BaseBlend;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;656;-640,384;Inherit;False;2051;Base_MetallicGlossMap_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1499;4032.557,868.0125;Inherit;False;1491;Mask_BaseBlend;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1794;192,1152;Half;False;Main_Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1497;4032.557,-11.98758;Inherit;False;1489;Base_MainTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1534;4032.557,-251.9876;Inherit;False;486;Main_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;657;-320,384;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1496;4032.557,-75.98758;Inherit;False;487;Main_MainTex;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1490;-64,-64;Half;False;Base_NormaTex;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;745;4672,-1040;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1535;4032.557,-187.9876;Inherit;False;1533;Base_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;620;2944,-1024;Half;False;MainBumpMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2056;1088,1152;Half;False;Base_Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;660;4864,-1040;Half;False;Main_Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1536;4480.556,-251.9876;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2452;-1418.734,1656.598;Half;False;Property;_VertexOcclusionDarkening;Vertex Occlusion Darkening;60;0;Create;True;0;0;False;0;0.8;0.8;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2062;4032.557,692.0125;Inherit;False;1794;Main_Occlusion;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1503;4032.557,116.0124;Inherit;False;620;MainBumpMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2457;-554.7343,1784.598;Half;False;Property;_TextureOcclusionDarkening;Texture Occlusion Darkening;58;0;Create;True;0;0;False;0;0.8;0.8;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1508;4032.557,180.0124;Inherit;False;1490;Base_NormaTex;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2061;4032.557,756.0125;Inherit;False;2056;Base_Occlusion;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1495;4480.556,-75.98758;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;748;-128,384;Half;False;Base_Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2057;4032.557,580.0125;Inherit;False;748;Base_Smoothness;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1896;4816.557,-75.98758;Half;False;Blending_BaseAlbedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;2460;-234.7342,1784.598;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;2190;4464.556,260.0124;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2058;4032.557,516.0125;Inherit;False;660;Main_Smoothness;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2193;4432.556,372.0124;Half;False;Property;_BaseBlendNormals;Base Blend Normals;56;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;2456;-1130.734,1656.598;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2065;4480.556,692.0125;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1309;-1280,1472;Half;False;Property;_VertexOcclusion;Vertex Occlusion;59;0;Create;True;0;0;False;0;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1898;4816.557,-251.9876;Half;False;Blending_BaseColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;1502;4480.556,132.0124;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2064;4784.557,692.0125;Half;False;Blending_BaseOcclusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2192;4672.556,132.0124;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2453;-938.7341,1656.598;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2168;5312.556,-251.9876;Inherit;False;486;Main_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;2059;4480.556,516.0125;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2163;5312.556,-59.98758;Inherit;False;487;Main_MainTex;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2159;5312.556,20.01242;Inherit;False;1896;Blending_BaseAlbedo;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2154;5312.556,-171.9876;Inherit;False;1898;Blending_BaseColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2458;-42.73418,1784.598;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1897;4816.557,132.0124;Half;False;Blending_BaseNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;2459;85.26583,1784.598;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2060;4784.557,516.0125;Half;False;Blending_BaseSmoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2114;-1280,1152;Inherit;False;const;-1;;2798;5b64729fb717c5f49a1bc2dab81d5e1c;3,21,0,3,1,22,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;2463;5648,-32;Float;False;Property;_ENABLEBASE5;Enable Base;20;0;Create;False;0;0;False;0;0;0;0;True;;Toggle;2;Off;Base;Reference;2462;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1638;-1280,1280;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;2170;5312.556,516.0125;Inherit;False;1794;Main_Occlusion;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;2454;-810.7341,1656.598;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2153;5312.556,596.0125;Inherit;False;2064;Blending_BaseOcclusion;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;2462;5656.953,-249.256;Float;False;Property;_ENABLEBASE;Enable Base;21;0;Create;False;0;0;False;0;0;0;0;True;;Toggle;2;Off;Base;Create;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;1308;-896,1152;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1539;5952.556,-251.9876;Half;False;OUT_COLOR;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2178;5312.556,132.0124;Inherit;False;620;MainBumpMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2179;5312.556,324.0124;Inherit;False;660;Main_Smoothness;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2455;-618.7343,1656.598;Inherit;False;vertexOcclusionDarkening;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2162;5255.556,418.0124;Inherit;False;2060;Blending_BaseSmoothness;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2461;277.2658,1784.598;Inherit;False;textureOcclusionDarkening;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;2466;5709.336,542.9918;Float;False;Property;_ENABLEBASE8;Enable Base;18;0;Create;False;0;0;False;0;0;0;0;True;;Toggle;2;Off;Base;Reference;2462;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1501;5952.556,-59.98758;Half;False;OUT_ALBEDO;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2171;5312.556,212.0124;Inherit;False;1897;Blending_BaseNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2447;995.7188,-2194.369;Inherit;False;1501;OUT_ALBEDO;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2077;5952.556,516.0125;Half;False;OUT_AO;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;2464;5648,128;Float;False;Property;_ENABLEBASE6;Enable Base;19;0;Create;False;0;0;False;0;0;0;0;True;;Toggle;2;Off;Base;Reference;2462;True;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2448;995.7188,-2130.369;Inherit;False;1539;OUT_COLOR;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2450;908.3357,-2276.528;Inherit;False;2455;vertexOcclusionDarkening;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2449;908.3357,-2356.528;Inherit;False;2461;textureOcclusionDarkening;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;2465;5632,336;Float;False;Property;_ENABLEBASE7;Enable Base;22;0;Create;False;0;0;False;0;0;0;0;True;;Toggle;2;Off;Base;Reference;2462;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1312;-704,1152;Half;False;Vertex_Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2071;5952.556,324.0124;Half;False;OUT_SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1512;5952.556,132.0124;Half;False;OUT_NORMAL;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2451;1379.719,-2190.369;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;2244;1583.123,-2356.275;Inherit;False;Constant;_Color0;Color 0;71;0;Create;True;0;0;False;0;0,0.08482099,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1313;1048.383,-1835.841;Inherit;False;1312;Vertex_Occlusion;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2107;1048.383,-1771.841;Inherit;False;2077;OUT_AO;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;743;-624,-2688;Half;False;Property;_CullType;Cull Type;23;1;[Enum];Create;True;3;Off;0;Front;1;Back;2;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;862;-448,-2688;Half;False;Property;_Cutoff;Cutout;25;1;[HideInInspector];Create;False;3;Off;0;Front;1;Back;2;0;False;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2108;1304.383,-1835.841;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;550;-1280,-2688;Half;False;Property;_SrcBlend;_SrcBlend;61;1;[HideInInspector];Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1799;-1088,-3264;Half;False;Property;_BlendingBasee;# BlendingBasee;39;0;Create;True;0;0;True;1;InternalInteractive(_ENABLEBASE_ON);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1468;-1088,-3360;Half;False;Property;_TRUNKK;[ TRUNKK ];26;0;Create;True;0;0;True;1;InternalCategory(Trunk);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;616;-1408,-1184;Half;False;Main_MainTex_Alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2445;1806.452,-1653.79;Inherit;False;Wind;0;;3060;76dbe6e88a5c02e42a177b05b9981ead;10,981,1,983,1,991,0,992,0,993,0,987,0,985,0,989,0,988,0,990,0;0;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;1466;-1280,-3360;Half;False;Property;_RENDERINGG;[ RENDERINGG ];16;0;Create;True;0;0;False;1;InternalCategory(Rendering);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;654;1048.383,-1931.841;Inherit;False;2071;OUT_SMOOTHNESS;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1469;-768,-3360;Half;False;Property;_SETTINGSS;[ SETTINGSS ];57;0;Create;True;0;0;True;1;InternalCategory(Settings);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;624;1048.383,-2027.841;Inherit;False;1512;OUT_NORMAL;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1476;-1280,-3264;Half;False;Property;_RenderCutt;# RenderCutt;24;0;Create;True;0;0;True;1;InternalInteractive(_Mode, 1);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;925;-960,-2688;Half;False;Property;_ZWrite;_ZWrite;63;1;[HideInInspector];Create;True;2;Off;0;On;1;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1492;-64,-176;Half;False;Base_MainTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1472;-1280,-3456;Half;False;Property;_ADSStandardLitTreeBark;< ADS Standard Lit Tree Bark>;15;0;Create;True;0;0;True;1;InternalBanner(Internal, Bark);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;549;-800,-2688;Half;False;Property;_RenderType;Render Type;17;1;[Enum];Create;True;2;Opaque;0;Cutout;1;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;553;-1120,-2688;Half;False;Property;_DstBlend;_DstBlend;62;1;[HideInInspector];Create;True;0;0;False;0;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2470;-837.7521,-2577.258;Float;False;Property;_Mode1;_Mode;14;1;[HideInInspector];Create;True;0;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1513;-928,-3360;Half;False;Property;_BASEE;[ BASEE ];38;0;Create;True;0;0;True;1;InternalCategory(Base);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;2243;1887.559,-2210.087;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;646;3968,-1024;Half;False;Main_MetallicGlossMap_R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2200.383,-2155.841;Float;False;True;-1;2;InternalShaderGUI;300;0;Standard;internal/backup/bark-20200322;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;False;True;False;False;False;True;Off;0;False;925;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Opaque;;Geometry;All;12;d3d9;d3d11_9x;d3d11;glcore;gles3;metal;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;True;550;10;True;553;0;1;False;550;10;False;553;0;True;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;300;internal/bark-simple;-1;-1;-1;-1;0;False;0;0;False;743;-1;0;True;862;3;Include;UnityCG.cginc;False;;Custom;Include;./../../../GPUInstancer/Shaders/Include/GPUInstancerInclude.cginc;False;;Custom;Pragma;instancing_options procedural:setupGPUI;False;;Custom;0;0;False;0.1;False;-1;0;False;-1;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;14;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;2189;4032.557,-379.9876;Inherit;False;1027.098;100;Trunk Base Blending ;0;;1,0,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;712;-2048,-2240;Inherit;False;1919.763;125.4341;Main UVs;0;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;760;-2048,-1472;Inherit;False;2046.548;120.5201;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;683;-1280,-2816;Inherit;False;1085;100;Rendering (Unused);0;;1,0,0.503,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;2188;5312.556,-379.9876;Inherit;False;1048.21;100;Trunk Base Blending Final;0;;1,0,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1545;-1280,-384;Inherit;False;1541.176;100;Base Blend Inputs;0;;1,0.234,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1465;-1280,-3584;Inherit;False;1793.477;100;Drawers;0;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;708;2304,-1152;Inherit;False;833.139;100;Normal Texture;0;;0.5019608,0.5019608,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;715;3328,-1152;Inherit;False;872;100;Smoothness Texture(Metallic, AO, Height, Smoothness);0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1546;384,-384;Inherit;False;1880.808;100;Blend Height Mask;0;;1,0.234,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;751;4352,-1152;Inherit;False;761.9668;100;Metallic / Smoothness;0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1544;-1280,1024;Inherit;False;2559.027;100;Ambient Occlusion;0;;1,1,1,1;0;0
WireConnection;564;0;563;1
WireConnection;564;1;563;2
WireConnection;565;0;563;3
WireConnection;565;1;563;4
WireConnection;562;0;561;0
WireConnection;562;1;564;0
WireConnection;575;0;562;0
WireConnection;575;1;565;0
WireConnection;1299;0;575;0
WireConnection;1109;0;1102;0
WireConnection;1109;1;1102;5
WireConnection;1101;0;1299;1
WireConnection;1101;1;1109;0
WireConnection;1104;0;1299;0
WireConnection;1104;1;1101;0
WireConnection;1482;0;1480;1
WireConnection;1482;1;1480;2
WireConnection;1825;0;575;0
WireConnection;1825;1;1104;0
WireConnection;1825;2;1826;0
WireConnection;1484;0;1481;0
WireConnection;1484;1;1482;0
WireConnection;587;0;1825;0
WireConnection;1483;0;1480;3
WireConnection;1483;1;1480;4
WireConnection;1485;0;1484;0
WireConnection;1485;1;1483;0
WireConnection;645;1;644;0
WireConnection;2049;1;1485;0
WireConnection;1929;0;645;3
WireConnection;2229;0;2049;3
WireConnection;1817;0;1815;0
WireConnection;1817;1;1815;5
WireConnection;2240;0;2237;2
WireConnection;2240;2;2238;0
WireConnection;18;1;588;0
WireConnection;1816;0;1817;0
WireConnection;2213;0;18;0
WireConnection;2241;0;2240;0
WireConnection;2222;3;2223;0
WireConnection;2222;1;2231;0
WireConnection;2222;19;2224;0
WireConnection;2222;13;2225;0
WireConnection;2222;21;2230;0
WireConnection;2222;24;2226;0
WireConnection;2222;22;2227;0
WireConnection;2217;0;2213;3
WireConnection;2217;1;2216;0
WireConnection;2214;0;2213;2
WireConnection;2214;1;2215;0
WireConnection;2242;0;2241;0
WireConnection;2138;0;2135;0
WireConnection;2138;1;1816;0
WireConnection;2138;2;1822;0
WireConnection;1788;0;645;2
WireConnection;2050;0;2049;2
WireConnection;2051;0;2049;4
WireConnection;744;0;645;4
WireConnection;1415;1;1485;0
WireConnection;2232;0;2242;0
WireConnection;2232;1;1426;0
WireConnection;2232;2;2138;0
WireConnection;2232;3;2222;0
WireConnection;2218;0;2213;1
WireConnection;2218;1;2214;0
WireConnection;2218;2;2217;0
WireConnection;1486;1;1485;0
WireConnection;1486;5;1488;0
WireConnection;1489;0;1415;0
WireConnection;607;1;604;0
WireConnection;607;5;655;0
WireConnection;1793;0;2115;0
WireConnection;1793;1;1795;0
WireConnection;1793;2;1792;0
WireConnection;486;0;409;0
WireConnection;1533;0;1532;0
WireConnection;487;0;2218;0
WireConnection;2055;0;2116;0
WireConnection;2055;1;2053;0
WireConnection;2055;2;2052;0
WireConnection;1491;0;2232;0
WireConnection;1794;0;1793;0
WireConnection;657;0;656;0
WireConnection;657;1;750;0
WireConnection;1490;0;1486;0
WireConnection;745;0;749;0
WireConnection;745;1;294;0
WireConnection;620;0;607;0
WireConnection;2056;0;2055;0
WireConnection;660;0;745;0
WireConnection;1536;0;1534;0
WireConnection;1536;1;1535;0
WireConnection;1536;2;1499;0
WireConnection;1495;0;1496;0
WireConnection;1495;1;1497;0
WireConnection;1495;2;1499;0
WireConnection;748;0;657;0
WireConnection;1896;0;1495;0
WireConnection;2460;0;2457;0
WireConnection;2190;0;1503;0
WireConnection;2190;1;1508;0
WireConnection;2456;0;2452;0
WireConnection;2065;0;2062;0
WireConnection;2065;1;2061;0
WireConnection;2065;2;1499;0
WireConnection;1898;0;1536;0
WireConnection;1502;0;1503;0
WireConnection;1502;1;1508;0
WireConnection;1502;2;1499;0
WireConnection;2064;0;2065;0
WireConnection;2192;0;1502;0
WireConnection;2192;1;2190;0
WireConnection;2192;2;2193;0
WireConnection;2453;0;1309;0
WireConnection;2453;1;2456;0
WireConnection;2059;0;2058;0
WireConnection;2059;1;2057;0
WireConnection;2059;2;1499;0
WireConnection;2458;0;1792;0
WireConnection;2458;1;2460;0
WireConnection;1897;0;2192;0
WireConnection;2459;0;2458;0
WireConnection;2060;0;2059;0
WireConnection;2463;1;2163;0
WireConnection;2463;0;2159;0
WireConnection;2454;0;2453;0
WireConnection;2462;1;2168;0
WireConnection;2462;0;2154;0
WireConnection;1308;0;2114;0
WireConnection;1308;1;1638;3
WireConnection;1308;2;1309;0
WireConnection;1539;0;2462;0
WireConnection;2455;0;2454;0
WireConnection;2461;0;2459;0
WireConnection;2466;1;2170;0
WireConnection;2466;0;2153;0
WireConnection;1501;0;2463;0
WireConnection;2077;0;2466;0
WireConnection;2464;1;2178;0
WireConnection;2464;0;2171;0
WireConnection;2465;1;2179;0
WireConnection;2465;0;2162;0
WireConnection;1312;0;1308;0
WireConnection;2071;0;2465;0
WireConnection;1512;0;2464;0
WireConnection;2451;0;2449;0
WireConnection;2451;1;2450;0
WireConnection;2451;2;2447;0
WireConnection;2451;3;2448;0
WireConnection;2108;0;1313;0
WireConnection;2108;1;2107;0
WireConnection;616;0;18;4
WireConnection;1492;0;1415;4
WireConnection;2243;0;2451;0
WireConnection;2243;1;2244;0
WireConnection;646;0;645;1
WireConnection;0;0;2243;0
WireConnection;0;1;624;0
WireConnection;0;4;654;0
WireConnection;0;5;2108;0
WireConnection;0;11;2445;0
ASEEND*/
//CHKSM=B196BDF2FAC199628555E3B6AC319F4D73F2D12D