// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "internal/fallback-cutout"
{
	Properties
	{
		[InternalBanner(Internal, Leaf)]_BANNER("BANNER", Float) = 1
		[InternalCategory(Rendering)]_RENDERINGG("[ RENDERINGG ]", Float) = 0
		[InternalCategory(Cutoff)]_CUTOFFF("[ CUTOFFF ]", Float) = 0
		[InternalCategory(Leaf)]_LEAFF("[ LEAFF ]", Float) = 0
		[NoScaleOffset]_MainTex("Leaf Albedo", 2D) = "white" {}
		[NoScaleOffset]_BumpMap("Leaf Normal", 2D) = "bump" {}
		_BumpScale("Leaf Normal Scale", Range( 0 , 5)) = 1
		[NoScaleOffset]_MetallicGlossMap("Leaf Surface", 2D) = "white" {}
		_Glossiness("Leaf Smoothness", Range( 0 , 1)) = 0.1
		_Color("Primary Color", Color) = (1,1,1,1)
		[InternalCategory(Color Map)]_COLORMAPP("[ COLOR MAPP ]", Float) = 0
		_SecondaryColor("Secondary Color", Color) = (0,0,0,0)
		_MaskedColor("Masked Color", Color) = (0,0,0,0)
		[NoScaleOffset]_ColorMap("Color Map", 2D) = "white" {}
		[IntRange]_ColorMapChannel("Color Map Channel", Range( 0 , 3)) = 0
		_ColorMapScale("Color Map Scale", Range( 0.1 , 2048)) = 10
		_ColorMapContrast("Color Map Contrast", Range( 0.1 , 2)) = 1
		_ColorMapBias("Color Map Bias", Range( -1 , 1)) = 0
		[Toggle]_IsLeaf("Is Leaf", Float) = 1
		[Toggle]_IsBark("Is Bark", Float) = 0
		[Toggle]_IsShadow("Is Shadow", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		LOD 200
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		 
		// INTERNAL_SHADER_FEATURE_START
		// INTERNAL_SHADER_FEATURE_END
		  
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows novertexlights nolightmap  nodynlightmap nodirlightmap nometa noforwardadd vertex:vertexDataFunc 

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
			half ASEVFace : VFACE;
		};

		uniform half _CUTOFFF;
		uniform half _RENDERINGG;
		uniform half _IsBark;
		uniform half _BANNER;
		uniform half _IsShadow;
		uniform half _LEAFF;
		uniform half _IsLeaf;
		uniform half _COLORMAPP;
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
		uniform half _BumpScale;
		uniform sampler2D _BumpMap;
		uniform sampler2D _MainTex;
		uniform half4 _SecondaryColor;
		uniform half4 _Color;
		uniform half4 _MaskedColor;
		uniform sampler2D _MetallicGlossMap;
		uniform float _ColorMapBias;
		uniform float _ColorMapContrast;
		uniform sampler2D _ColorMap;
		uniform float _ColorMapScale;
		uniform float _ColorMapChannel;
		uniform half _Glossiness;


		float4 CalculateContrast( float contrastValue, float4 colorTarget )
		{
			float t = 0.5 * ( 1.0 - contrastValue );
			return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
		}

		void vertexDataFunc( inout appdata_full_custom v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float WIND_TRUNK_STRENGTH1235_g24488 = _WIND_TRUNK_STRENGTH;
			half localunity_ObjectToWorld0w1_g24544 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g24544 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g24544 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g24544 = (float3(localunity_ObjectToWorld0w1_g24544 , localunity_ObjectToWorld1w2_g24544 , localunity_ObjectToWorld2w3_g24544));
			float3 WIND_POSITION_OBJECT1195_g24488 = appendResult6_g24544;
			float2 temp_output_1_0_g24693 = (WIND_POSITION_OBJECT1195_g24488).xz;
			float WIND_BASE_TRUNK_FIELD_SIZE1238_g24488 = _WIND_BASE_TRUNK_FIELD_SIZE;
			float temp_output_2_0_g24683 = WIND_BASE_TRUNK_FIELD_SIZE1238_g24488;
			float2 temp_cast_0 = (( 1.0 / (( temp_output_2_0_g24683 == 0.0 ) ? 1.0 :  temp_output_2_0_g24683 ) )).xx;
			float2 temp_output_2_0_g24693 = temp_cast_0;
			float2 temp_output_704_0_g24677 = ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g24693 / temp_output_2_0_g24693 ) :  ( temp_output_1_0_g24693 * temp_output_2_0_g24693 ) ) + float2( 0,0 ) );
			float temp_output_2_0_g24605 = _WIND_BASE_TRUNK_CYCLE_TIME;
			float WIND_BASE_TRUNK_FREQUENCY1237_g24488 = ( 1.0 / (( temp_output_2_0_g24605 == 0.0 ) ? 1.0 :  temp_output_2_0_g24605 ) );
			float2 temp_output_721_0_g24677 = (WIND_BASE_TRUNK_FREQUENCY1237_g24488).xx;
			float2 break298_g24678 = ( temp_output_704_0_g24677 + ( temp_output_721_0_g24677 * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g24678 = (float2(sin( break298_g24678.x ) , cos( break298_g24678.y )));
			float4 temp_output_273_0_g24678 = (-1.0).xxxx;
			float4 temp_output_271_0_g24678 = (1.0).xxxx;
			float2 clampResult26_g24678 = clamp( appendResult299_g24678 , temp_output_273_0_g24678.xy , temp_output_271_0_g24678.xy );
			float WIND_BASE_AMPLITUDE1197_g24488 = _WIND_BASE_AMPLITUDE;
			float WIND_BASE_TRUNK_STRENGTH1236_g24488 = _WIND_BASE_TRUNK_STRENGTH;
			float2 temp_output_720_0_g24677 = (( WIND_BASE_AMPLITUDE1197_g24488 * WIND_BASE_TRUNK_STRENGTH1236_g24488 )).xx;
			float2 TRUNK_PIVOT_ROCKING701_g24677 = ( clampResult26_g24678 * temp_output_720_0_g24677 );
			float WIND_PRIMARY_ROLL1202_g24488 = v.color.r;
			float _WIND_PRIMARY_ROLL669_g24677 = WIND_PRIMARY_ROLL1202_g24488;
			float temp_output_54_0_g24682 = ( TRUNK_PIVOT_ROCKING701_g24677 * 0.05 * _WIND_PRIMARY_ROLL669_g24677 ).x;
			float temp_output_72_0_g24682 = cos( temp_output_54_0_g24682 );
			float one_minus_c52_g24682 = ( 1.0 - temp_output_72_0_g24682 );
			float3 break70_g24682 = float3(0,1,0);
			float axis_x25_g24682 = break70_g24682.x;
			float c66_g24682 = temp_output_72_0_g24682;
			float axis_y37_g24682 = break70_g24682.y;
			float axis_z29_g24682 = break70_g24682.z;
			float s67_g24682 = sin( temp_output_54_0_g24682 );
			float3 appendResult83_g24682 = (float3(( ( one_minus_c52_g24682 * axis_x25_g24682 * axis_x25_g24682 ) + c66_g24682 ) , ( ( one_minus_c52_g24682 * axis_x25_g24682 * axis_y37_g24682 ) - ( axis_z29_g24682 * s67_g24682 ) ) , ( ( one_minus_c52_g24682 * axis_z29_g24682 * axis_x25_g24682 ) + ( axis_y37_g24682 * s67_g24682 ) )));
			float3 appendResult81_g24682 = (float3(( ( one_minus_c52_g24682 * axis_x25_g24682 * axis_y37_g24682 ) + ( axis_z29_g24682 * s67_g24682 ) ) , ( ( one_minus_c52_g24682 * axis_y37_g24682 * axis_y37_g24682 ) + c66_g24682 ) , ( ( one_minus_c52_g24682 * axis_y37_g24682 * axis_z29_g24682 ) - ( axis_x25_g24682 * s67_g24682 ) )));
			float3 appendResult82_g24682 = (float3(( ( one_minus_c52_g24682 * axis_z29_g24682 * axis_x25_g24682 ) - ( axis_y37_g24682 * s67_g24682 ) ) , ( ( one_minus_c52_g24682 * axis_y37_g24682 * axis_z29_g24682 ) + ( axis_x25_g24682 * s67_g24682 ) ) , ( ( one_minus_c52_g24682 * axis_z29_g24682 * axis_z29_g24682 ) + c66_g24682 )));
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 WIND_PRIMARY_PIVOT1203_g24488 = (v.texcoord1).xyz;
			float3 _WIND_PRIMARY_PIVOT655_g24677 = WIND_PRIMARY_PIVOT1203_g24488;
			float3 temp_output_38_0_g24682 = ( ase_vertex3Pos - (_WIND_PRIMARY_PIVOT655_g24677).xyz );
			float2 break298_g24688 = ( temp_output_704_0_g24677 + ( temp_output_721_0_g24677 * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g24688 = (float2(sin( break298_g24688.x ) , cos( break298_g24688.y )));
			float4 temp_output_273_0_g24688 = (-1.0).xxxx;
			float4 temp_output_271_0_g24688 = (1.0).xxxx;
			float2 clampResult26_g24688 = clamp( appendResult299_g24688 , temp_output_273_0_g24688.xy , temp_output_271_0_g24688.xy );
			float2 TRUNK_SWIRL700_g24677 = ( clampResult26_g24688 * temp_output_720_0_g24677 );
			float2 break699_g24677 = TRUNK_SWIRL700_g24677;
			float3 appendResult698_g24677 = (float3(break699_g24677.x , 0.0 , break699_g24677.y));
			float3 temp_output_694_0_g24677 = ( ( mul( float3x3(appendResult83_g24682, appendResult81_g24682, appendResult82_g24682), temp_output_38_0_g24682 ) - temp_output_38_0_g24682 ) + ( _WIND_PRIMARY_ROLL669_g24677 * appendResult698_g24677 * 0.5 ) );
			float lerpResult632_g24639 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH , _WIND_AUDIO_INFLUENCE);
			float WIND_GUST_AUDIO_STRENGTH1242_g24488 = lerpResult632_g24639;
			float temp_output_15_0_g24582 = WIND_GUST_AUDIO_STRENGTH1242_g24488;
			float lerpResult635_g24639 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_LOW , _WIND_AUDIO_INFLUENCE);
			float WIND_GUST_AUDIO_LOW1246_g24488 = lerpResult635_g24639;
			float temp_output_16_0_g24582 = WIND_GUST_AUDIO_LOW1246_g24488;
			float WIND_GUST_TRUNK_STRENGTH1240_g24488 = _WIND_GUST_TRUNK_STRENGTH;
			float4 color658_g24640 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float WIND_GUST_TRUNK_CYCLE_TIME1241_g24488 = _WIND_GUST_TRUNK_CYCLE_TIME;
			float temp_output_2_0_g24641 = WIND_GUST_TRUNK_CYCLE_TIME1241_g24488;
			float2 temp_cast_6 = (( 1.0 / (( temp_output_2_0_g24641 == 0.0 ) ? 1.0 :  temp_output_2_0_g24641 ) )).xx;
			float2 temp_output_61_0_g24650 = float2( 0,0 );
			float2 temp_output_1_0_g24651 = (WIND_POSITION_OBJECT1195_g24488).xz;
			float WIND_GUST_TRUNK_FIELD_SIZE1239_g24488 = _WIND_GUST_TRUNK_FIELD_SIZE;
			float temp_output_2_0_g24646 = WIND_GUST_TRUNK_FIELD_SIZE1239_g24488;
			float temp_output_40_0_g24650 = ( 1.0 / (( temp_output_2_0_g24646 == 0.0 ) ? 1.0 :  temp_output_2_0_g24646 ) );
			float2 temp_cast_7 = (temp_output_40_0_g24650).xx;
			float2 temp_output_2_0_g24651 = temp_cast_7;
			float2 panner90_g24650 = ( _Time.y * temp_cast_6 + ( (( temp_output_61_0_g24650 > float2( 0,0 ) ) ? ( temp_output_1_0_g24651 / temp_output_2_0_g24651 ) :  ( temp_output_1_0_g24651 * temp_output_2_0_g24651 ) ) + temp_output_61_0_g24650 ));
			float temp_output_679_0_g24640 = 1.0;
			float4 temp_cast_8 = (temp_output_679_0_g24640).xxxx;
			float4 temp_output_52_0_g24650 = saturate( pow( tex2Dlod( _WIND_GUST_TEXTURE, float4( panner90_g24650, 0, 0.0) ) , temp_cast_8 ) );
			float4 lerpResult656_g24640 = lerp( color658_g24640 , temp_output_52_0_g24650 , temp_output_679_0_g24640);
			float4 break655_g24640 = lerpResult656_g24640;
			float4 _Vector0 = float4(0,0,0,0);
			float4 _Vector1 = float4(1,1,1,1);
			float _TRUNK1350_g24488 = ( ( ( temp_output_15_0_g24582 + temp_output_16_0_g24582 ) / 2.0 ) * WIND_GUST_TRUNK_STRENGTH1240_g24488 * (-0.45 + (( 1.0 - break655_g24640.b ) - _Vector0.x) * (1.0 - -0.45) / (_Vector1.x - _Vector0.x)) );
			float _WIND_GUST_STRENGTH703_g24677 = _TRUNK1350_g24488;
			float WIND_PRIMARY_BEND1204_g24488 = v.texcoord1.w;
			float _WIND_PRIMARY_BEND662_g24677 = WIND_PRIMARY_BEND1204_g24488;
			float temp_output_54_0_g24687 = ( ( _WIND_GUST_STRENGTH703_g24677 * -1.0 ) * _WIND_PRIMARY_BEND662_g24677 );
			float temp_output_72_0_g24687 = cos( temp_output_54_0_g24687 );
			float one_minus_c52_g24687 = ( 1.0 - temp_output_72_0_g24687 );
			float3 WIND_DIRECTION1192_g24488 = _WIND_DIRECTION;
			float3 _WIND_DIRECTION671_g24677 = WIND_DIRECTION1192_g24488;
			float3 worldToObjDir719_g24677 = mul( unity_WorldToObject, float4( cross( _WIND_DIRECTION671_g24677 , float3(0,1,0) ), 0 ) ).xyz;
			float3 break70_g24687 = worldToObjDir719_g24677;
			float axis_x25_g24687 = break70_g24687.x;
			float c66_g24687 = temp_output_72_0_g24687;
			float axis_y37_g24687 = break70_g24687.y;
			float axis_z29_g24687 = break70_g24687.z;
			float s67_g24687 = sin( temp_output_54_0_g24687 );
			float3 appendResult83_g24687 = (float3(( ( one_minus_c52_g24687 * axis_x25_g24687 * axis_x25_g24687 ) + c66_g24687 ) , ( ( one_minus_c52_g24687 * axis_x25_g24687 * axis_y37_g24687 ) - ( axis_z29_g24687 * s67_g24687 ) ) , ( ( one_minus_c52_g24687 * axis_z29_g24687 * axis_x25_g24687 ) + ( axis_y37_g24687 * s67_g24687 ) )));
			float3 appendResult81_g24687 = (float3(( ( one_minus_c52_g24687 * axis_x25_g24687 * axis_y37_g24687 ) + ( axis_z29_g24687 * s67_g24687 ) ) , ( ( one_minus_c52_g24687 * axis_y37_g24687 * axis_y37_g24687 ) + c66_g24687 ) , ( ( one_minus_c52_g24687 * axis_y37_g24687 * axis_z29_g24687 ) - ( axis_x25_g24687 * s67_g24687 ) )));
			float3 appendResult82_g24687 = (float3(( ( one_minus_c52_g24687 * axis_z29_g24687 * axis_x25_g24687 ) - ( axis_y37_g24687 * s67_g24687 ) ) , ( ( one_minus_c52_g24687 * axis_y37_g24687 * axis_z29_g24687 ) + ( axis_x25_g24687 * s67_g24687 ) ) , ( ( one_minus_c52_g24687 * axis_z29_g24687 * axis_z29_g24687 ) + c66_g24687 )));
			float3 temp_output_38_0_g24687 = ( ase_vertex3Pos - (_WIND_PRIMARY_PIVOT655_g24677).xyz );
			float3 lerpResult538_g24677 = lerp( temp_output_694_0_g24677 , ( temp_output_694_0_g24677 + ( mul( float3x3(appendResult83_g24687, appendResult81_g24687, appendResult82_g24687), temp_output_38_0_g24687 ) - temp_output_38_0_g24687 ) ) , WIND_GUST_AUDIO_STRENGTH1242_g24488);
			float3 MOTION_TRUNK1337_g24488 = lerpResult538_g24677;
			float WIND_BRANCH_STRENGTH1224_g24488 = _WIND_BRANCH_STRENGTH;
			float3 _WIND_POSITION_ROOT1002_g24504 = WIND_POSITION_OBJECT1195_g24488;
			float2 temp_output_1_0_g24527 = (_WIND_POSITION_ROOT1002_g24504).xz;
			float WIND_BASE_BRANCH_FIELD_SIZE1218_g24488 = _WIND_BASE_BRANCH_FIELD_SIZE;
			float _WIND_BASE_BRANCH_FIELD_SIZE1004_g24504 = WIND_BASE_BRANCH_FIELD_SIZE1218_g24488;
			float temp_output_2_0_g24505 = _WIND_BASE_BRANCH_FIELD_SIZE1004_g24504;
			float2 temp_cast_11 = (( 1.0 / (( temp_output_2_0_g24505 == 0.0 ) ? 1.0 :  temp_output_2_0_g24505 ) )).xx;
			float2 temp_output_2_0_g24527 = temp_cast_11;
			float temp_output_587_552_g24491 = v.color.a;
			float WIND_PHASE1212_g24488 = temp_output_587_552_g24491;
			float _WIND_PHASE852_g24504 = WIND_PHASE1212_g24488;
			float WIND_BASE_BRANCH_VARIATION_STRENGTH1219_g24488 = _WIND_BASE_BRANCH_VARIATION_STRENGTH;
			float _WIND_BASE_BRANCH_VARIATION_STRENGTH1006_g24504 = WIND_BASE_BRANCH_VARIATION_STRENGTH1219_g24488;
			float2 temp_cast_12 = (( ( _WIND_PHASE852_g24504 * _WIND_BASE_BRANCH_VARIATION_STRENGTH1006_g24504 ) * UNITY_PI )).xx;
			float temp_output_2_0_g24589 = _WIND_BASE_BRANCH_CYCLE_TIME;
			float WIND_BASE_BRANCH_FREQUENCY1217_g24488 = ( 1.0 / (( temp_output_2_0_g24589 == 0.0 ) ? 1.0 :  temp_output_2_0_g24589 ) );
			float2 break298_g24517 = ( ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g24527 / temp_output_2_0_g24527 ) :  ( temp_output_1_0_g24527 * temp_output_2_0_g24527 ) ) + temp_cast_12 ) + ( (( WIND_BASE_BRANCH_FREQUENCY1217_g24488 * _WIND_PHASE852_g24504 )).xx * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g24517 = (float2(sin( break298_g24517.x ) , cos( break298_g24517.y )));
			float4 temp_output_273_0_g24517 = (-1.0).xxxx;
			float4 temp_output_271_0_g24517 = (1.0).xxxx;
			float2 clampResult26_g24517 = clamp( appendResult299_g24517 , temp_output_273_0_g24517.xy , temp_output_271_0_g24517.xy );
			float WIND_BASE_BRANCH_STRENGTH1227_g24488 = _WIND_BASE_BRANCH_STRENGTH;
			float2 BRANCH_SWIRL931_g24504 = ( clampResult26_g24517 * (( WIND_BASE_AMPLITUDE1197_g24488 * WIND_BASE_BRANCH_STRENGTH1227_g24488 )).xx );
			float2 break932_g24504 = BRANCH_SWIRL931_g24504;
			float3 appendResult933_g24504 = (float3(break932_g24504.x , 0.0 , break932_g24504.y));
			float WIND_SECONDARY_ROLL1205_g24488 = v.color.g;
			float _WIND_SECONDARY_ROLL650_g24504 = WIND_SECONDARY_ROLL1205_g24488;
			float3 VALUE_ROLL1034_g24504 = ( appendResult933_g24504 * _WIND_SECONDARY_ROLL650_g24504 * 0.5 );
			float3 _WIND_DIRECTION856_g24504 = WIND_DIRECTION1192_g24488;
			float3 WIND_SECONDARY_GROWTH_DIRECTION1208_g24488 = (v.texcoord2).xyz;
			float3 temp_output_839_0_g24504 = WIND_SECONDARY_GROWTH_DIRECTION1208_g24488;
			float3 _WIND_SECONDARY_GROWTH_DIRECTION = float3(0,1,0);
			float3 objToWorldDir1174_g24504 = mul( unity_ObjectToWorld, float4( (( length( temp_output_839_0_g24504 ) == 0.0 ) ? _WIND_SECONDARY_GROWTH_DIRECTION :  temp_output_839_0_g24504 ), 0 ) ).xyz;
			float3 _WIND_SECONDARY_GROWTH_DIRECTION840_g24504 = (objToWorldDir1174_g24504).xyz;
			float dotResult565_g24504 = dot( _WIND_DIRECTION856_g24504 , _WIND_SECONDARY_GROWTH_DIRECTION840_g24504 );
			float clampResult13_g24532 = clamp( dotResult565_g24504 , -1.0 , 1.0 );
			float4 color658_g24665 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float WIND_GUST_BRANCH_CYCLE_TIME1220_g24488 = _WIND_GUST_BRANCH_CYCLE_TIME;
			float clampResult3_g24500 = clamp( temp_output_587_552_g24491 , 0.0 , 1.0 );
			float WIND_PHASE_UNPACKED1530_g24488 = ( ( clampResult3_g24500 * 2.0 ) - 1.0 );
			float temp_output_2_0_g24666 = ( WIND_GUST_BRANCH_CYCLE_TIME1220_g24488 + ( WIND_GUST_BRANCH_CYCLE_TIME1220_g24488 * WIND_PHASE_UNPACKED1530_g24488 * 0.1 ) );
			float2 temp_cast_15 = (( 1.0 / (( temp_output_2_0_g24666 == 0.0 ) ? 1.0 :  temp_output_2_0_g24666 ) )).xx;
			float2 temp_output_61_0_g24675 = float2( 0,0 );
			float3 WIND_SECONDARY_PIVOT1206_g24488 = (v.texcoord3).xyz;
			float WIND_GUST_BRANCH_VARIATION_STRENGTH1223_g24488 = _WIND_GUST_BRANCH_VARIATION_STRENGTH;
			float2 temp_output_1_0_g24676 = ( (WIND_POSITION_OBJECT1195_g24488).xz + (WIND_SECONDARY_PIVOT1206_g24488).xy + ( WIND_PHASE1212_g24488 * WIND_GUST_BRANCH_VARIATION_STRENGTH1223_g24488 ) );
			float WIND_GUST_BRANCH_FIELD_SIZE1222_g24488 = _WIND_GUST_BRANCH_FIELD_SIZE;
			float temp_output_2_0_g24671 = WIND_GUST_BRANCH_FIELD_SIZE1222_g24488;
			float temp_output_40_0_g24675 = ( 1.0 / (( temp_output_2_0_g24671 == 0.0 ) ? 1.0 :  temp_output_2_0_g24671 ) );
			float2 temp_cast_16 = (temp_output_40_0_g24675).xx;
			float2 temp_output_2_0_g24676 = temp_cast_16;
			float2 panner90_g24675 = ( _Time.y * temp_cast_15 + ( (( temp_output_61_0_g24675 > float2( 0,0 ) ) ? ( temp_output_1_0_g24676 / temp_output_2_0_g24676 ) :  ( temp_output_1_0_g24676 * temp_output_2_0_g24676 ) ) + temp_output_61_0_g24675 ));
			float temp_output_679_0_g24665 = 1.0;
			float4 temp_cast_17 = (temp_output_679_0_g24665).xxxx;
			float4 temp_output_52_0_g24675 = saturate( pow( tex2Dlod( _WIND_GUST_TEXTURE, float4( panner90_g24675, 0, 0.0) ) , temp_cast_17 ) );
			float4 lerpResult656_g24665 = lerp( color658_g24665 , temp_output_52_0_g24675 , temp_output_679_0_g24665);
			float4 break655_g24665 = lerpResult656_g24665;
			float temp_output_15_0_g24583 = break655_g24665.r;
			float temp_output_16_0_g24583 = ( 1.0 - break655_g24665.b );
			float temp_output_15_0_g24638 = WIND_GUST_AUDIO_STRENGTH1242_g24488;
			float lerpResult634_g24639 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_MID , _WIND_AUDIO_INFLUENCE);
			float WIND_GUST_AUDIO_MID1245_g24488 = lerpResult634_g24639;
			float temp_output_16_0_g24638 = WIND_GUST_AUDIO_MID1245_g24488;
			float temp_output_1516_14_g24488 = ( ( temp_output_15_0_g24638 + temp_output_16_0_g24638 ) / 2.0 );
			float WIND_GUST_BRANCH_STRENGTH1229_g24488 = _WIND_GUST_BRANCH_STRENGTH;
			float _BRANCH_OPPOSITE_DOWN1466_g24488 = ( (-0.1 + (( ( temp_output_15_0_g24583 + temp_output_16_0_g24583 ) / 2.0 ) - _Vector0.x) * (0.75 - -0.1) / (_Vector1.x - _Vector0.x)) * temp_output_1516_14_g24488 * WIND_GUST_BRANCH_STRENGTH1229_g24488 );
			float _GUST_STRENGTH_OPPOSITE_DOWN1188_g24504 = _BRANCH_OPPOSITE_DOWN1466_g24488;
			float temp_output_15_0_g24542 = ( 1.0 - break655_g24665.g );
			float temp_output_16_0_g24542 = break655_g24665.a;
			float temp_output_15_0_g24598 = WIND_GUST_AUDIO_STRENGTH1242_g24488;
			float temp_output_16_0_g24598 = WIND_GUST_AUDIO_LOW1246_g24488;
			float temp_output_1517_14_g24488 = ( ( temp_output_15_0_g24598 + temp_output_16_0_g24598 ) / 2.0 );
			float _BRANCH_OPPOSITE_UP1348_g24488 = ( (-0.3 + (( ( temp_output_15_0_g24542 + temp_output_16_0_g24542 ) / 2.0 ) - _Vector0.x) * (1.0 - -0.3) / (_Vector1.x - _Vector0.x)) * temp_output_1517_14_g24488 * WIND_GUST_BRANCH_STRENGTH1229_g24488 );
			float _GUST_STRENGTH_OPPOSITE_UP871_g24504 = _BRANCH_OPPOSITE_UP1348_g24488;
			float dotResult1180_g24504 = dot( _WIND_SECONDARY_GROWTH_DIRECTION840_g24504 , float3(0,1,0) );
			float clampResult8_g24514 = clamp( dotResult1180_g24504 , -1.0 , 1.0 );
			float _WIND_SECONDARY_VERTICALITY843_g24504 = ( ( clampResult8_g24514 * 0.5 ) + 0.5 );
			float temp_output_2_0_g24509 = _WIND_SECONDARY_VERTICALITY843_g24504;
			float temp_output_3_0_g24509 = 0.5;
			float temp_output_21_0_g24509 = 1.0;
			float temp_output_26_0_g24509 = 0.0;
			float lerpResult1_g24516 = lerp( _GUST_STRENGTH_OPPOSITE_DOWN1188_g24504 , ( _GUST_STRENGTH_OPPOSITE_UP871_g24504 * -1.0 ) , saturate( saturate( (( temp_output_2_0_g24509 >= temp_output_3_0_g24509 ) ? temp_output_21_0_g24509 :  temp_output_26_0_g24509 ) ) ));
			float WIND_SECONDARY_BEND1207_g24488 = v.texcoord3.w;
			float _WIND_SECONDARY_BEND849_g24504 = WIND_SECONDARY_BEND1207_g24488;
			float clampResult1170_g24504 = clamp( _WIND_SECONDARY_BEND849_g24504 , 0.0 , 0.75 );
			float clampResult1175_g24504 = clamp( ( lerpResult1_g24516 * clampResult1170_g24504 ) , -1.5 , 1.5 );
			float temp_output_54_0_g24521 = clampResult1175_g24504;
			float temp_output_72_0_g24521 = cos( temp_output_54_0_g24521 );
			float one_minus_c52_g24521 = ( 1.0 - temp_output_72_0_g24521 );
			float3 worldToObjDir1173_g24504 = mul( unity_WorldToObject, float4( cross( _WIND_DIRECTION856_g24504 , float3(0,1,0) ), 0 ) ).xyz;
			float3 break70_g24521 = worldToObjDir1173_g24504;
			float axis_x25_g24521 = break70_g24521.x;
			float c66_g24521 = temp_output_72_0_g24521;
			float axis_y37_g24521 = break70_g24521.y;
			float axis_z29_g24521 = break70_g24521.z;
			float s67_g24521 = sin( temp_output_54_0_g24521 );
			float3 appendResult83_g24521 = (float3(( ( one_minus_c52_g24521 * axis_x25_g24521 * axis_x25_g24521 ) + c66_g24521 ) , ( ( one_minus_c52_g24521 * axis_x25_g24521 * axis_y37_g24521 ) - ( axis_z29_g24521 * s67_g24521 ) ) , ( ( one_minus_c52_g24521 * axis_z29_g24521 * axis_x25_g24521 ) + ( axis_y37_g24521 * s67_g24521 ) )));
			float3 appendResult81_g24521 = (float3(( ( one_minus_c52_g24521 * axis_x25_g24521 * axis_y37_g24521 ) + ( axis_z29_g24521 * s67_g24521 ) ) , ( ( one_minus_c52_g24521 * axis_y37_g24521 * axis_y37_g24521 ) + c66_g24521 ) , ( ( one_minus_c52_g24521 * axis_y37_g24521 * axis_z29_g24521 ) - ( axis_x25_g24521 * s67_g24521 ) )));
			float3 appendResult82_g24521 = (float3(( ( one_minus_c52_g24521 * axis_z29_g24521 * axis_x25_g24521 ) - ( axis_y37_g24521 * s67_g24521 ) ) , ( ( one_minus_c52_g24521 * axis_y37_g24521 * axis_z29_g24521 ) + ( axis_x25_g24521 * s67_g24521 ) ) , ( ( one_minus_c52_g24521 * axis_z29_g24521 * axis_z29_g24521 ) + c66_g24521 )));
			float3 _WIND_SECONDARY_PIVOT846_g24504 = WIND_SECONDARY_PIVOT1206_g24488;
			float3 temp_output_38_0_g24521 = ( ase_vertex3Pos - (_WIND_SECONDARY_PIVOT846_g24504).xyz );
			float3 VALUE_FACING_WIND1042_g24504 = ( mul( float3x3(appendResult83_g24521, appendResult81_g24521, appendResult82_g24521), temp_output_38_0_g24521 ) - temp_output_38_0_g24521 );
			float2 temp_output_1_0_g24526 = (_WIND_SECONDARY_PIVOT846_g24504).xz;
			float _WIND_GUST_BRANCH_FIELD_SIZE1011_g24504 = WIND_GUST_BRANCH_FIELD_SIZE1222_g24488;
			float temp_output_2_0_g24528 = _WIND_GUST_BRANCH_FIELD_SIZE1011_g24504;
			float2 temp_cast_22 = (( 1.0 / (( temp_output_2_0_g24528 == 0.0 ) ? 1.0 :  temp_output_2_0_g24528 ) )).xx;
			float2 temp_output_2_0_g24526 = temp_cast_22;
			float _WIND_GUST_BRANCH_VARIATION_STRENGTH1008_g24504 = WIND_GUST_BRANCH_VARIATION_STRENGTH1223_g24488;
			float2 temp_cast_23 = (( ( _WIND_PHASE852_g24504 * _WIND_GUST_BRANCH_VARIATION_STRENGTH1008_g24504 ) * UNITY_PI )).xx;
			float temp_output_2_0_g24593 = _WIND_GUST_BRANCH_CYCLE_TIME;
			float WIND_GUST_BRANCH_FREQUENCY1221_g24488 = ( 1.0 / (( temp_output_2_0_g24593 == 0.0 ) ? 1.0 :  temp_output_2_0_g24593 ) );
			float _WIND_GUST_BRANCH_FREQUENCY1012_g24504 = WIND_GUST_BRANCH_FREQUENCY1221_g24488;
			float2 break298_g24522 = ( ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g24526 / temp_output_2_0_g24526 ) :  ( temp_output_1_0_g24526 * temp_output_2_0_g24526 ) ) + temp_cast_23 ) + ( (_WIND_GUST_BRANCH_FREQUENCY1012_g24504).xx * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g24522 = (float2(sin( break298_g24522.x ) , cos( break298_g24522.y )));
			float4 temp_output_273_0_g24522 = (-1.0).xxxx;
			float4 temp_output_271_0_g24522 = (1.0).xxxx;
			float2 clampResult26_g24522 = clamp( appendResult299_g24522 , temp_output_273_0_g24522.xy , temp_output_271_0_g24522.xy );
			float2 break305_g24522 = float2( -0.25,1 );
			float temp_output_15_0_g24585 = ( 1.0 - break655_g24665.r );
			float temp_output_16_0_g24585 = break655_g24665.g;
			float _BRANCH_PERPENDICULAR1431_g24488 = ( (-0.1 + (( ( temp_output_15_0_g24585 + temp_output_16_0_g24585 ) / 2.0 ) - _Vector0.x) * (0.9 - -0.1) / (_Vector1.x - _Vector0.x)) * temp_output_1517_14_g24488 * WIND_GUST_BRANCH_STRENGTH1229_g24488 );
			float _GUST_STRENGTH_PERPENDICULAR999_g24504 = _BRANCH_PERPENDICULAR1431_g24488;
			float2 break1067_g24504 = ( ( ((break305_g24522.x).xxxx.xy + (clampResult26_g24522 - temp_output_273_0_g24522.xy) * ((break305_g24522.y).xxxx.xy - (break305_g24522.x).xxxx.xy) / (temp_output_271_0_g24522.xy - temp_output_273_0_g24522.xy)) * (_GUST_STRENGTH_PERPENDICULAR999_g24504).xx ) * _WIND_SECONDARY_ROLL650_g24504 );
			float3 appendResult1066_g24504 = (float3(break1067_g24504.x , 0.0 , break1067_g24504.y));
			float3 worldToObjDir1089_g24504 = normalize( mul( unity_WorldToObject, float4( _WIND_DIRECTION856_g24504, 0 ) ).xyz );
			float3 BRANCH_SWIRL972_g24504 = ( appendResult1066_g24504 * worldToObjDir1089_g24504 );
			float3 VALUE_PERPENDICULAR1041_g24504 = BRANCH_SWIRL972_g24504;
			float3 temp_output_3_0_g24532 = VALUE_PERPENDICULAR1041_g24504;
			float3 lerpResult1_g24538 = lerp( VALUE_FACING_WIND1042_g24504 , temp_output_3_0_g24532 , saturate( ( 1.0 + clampResult13_g24532 ) ));
			float temp_output_15_0_g24664 = break655_g24665.b;
			float temp_output_16_0_g24664 = ( 1.0 - break655_g24665.a );
			float clampResult3_g24489 = clamp( ( ( temp_output_15_0_g24664 + temp_output_16_0_g24664 ) / 2.0 ) , 0.0 , 1.0 );
			float _BRANCH_PARALLEL1432_g24488 = ( ( ( clampResult3_g24489 * 2.0 ) - 1.0 ) * temp_output_1516_14_g24488 * WIND_GUST_BRANCH_STRENGTH1229_g24488 );
			float _GUST_STRENGTH_PARALLEL1110_g24504 = _BRANCH_PARALLEL1432_g24488;
			float clampResult1167_g24504 = clamp( ( _GUST_STRENGTH_PARALLEL1110_g24504 * _WIND_SECONDARY_BEND849_g24504 ) , -1.5 , 1.5 );
			float temp_output_54_0_g24539 = clampResult1167_g24504;
			float temp_output_72_0_g24539 = cos( temp_output_54_0_g24539 );
			float one_minus_c52_g24539 = ( 1.0 - temp_output_72_0_g24539 );
			float3 break70_g24539 = float3(0,1,0);
			float axis_x25_g24539 = break70_g24539.x;
			float c66_g24539 = temp_output_72_0_g24539;
			float axis_y37_g24539 = break70_g24539.y;
			float axis_z29_g24539 = break70_g24539.z;
			float s67_g24539 = sin( temp_output_54_0_g24539 );
			float3 appendResult83_g24539 = (float3(( ( one_minus_c52_g24539 * axis_x25_g24539 * axis_x25_g24539 ) + c66_g24539 ) , ( ( one_minus_c52_g24539 * axis_x25_g24539 * axis_y37_g24539 ) - ( axis_z29_g24539 * s67_g24539 ) ) , ( ( one_minus_c52_g24539 * axis_z29_g24539 * axis_x25_g24539 ) + ( axis_y37_g24539 * s67_g24539 ) )));
			float3 appendResult81_g24539 = (float3(( ( one_minus_c52_g24539 * axis_x25_g24539 * axis_y37_g24539 ) + ( axis_z29_g24539 * s67_g24539 ) ) , ( ( one_minus_c52_g24539 * axis_y37_g24539 * axis_y37_g24539 ) + c66_g24539 ) , ( ( one_minus_c52_g24539 * axis_y37_g24539 * axis_z29_g24539 ) - ( axis_x25_g24539 * s67_g24539 ) )));
			float3 appendResult82_g24539 = (float3(( ( one_minus_c52_g24539 * axis_z29_g24539 * axis_x25_g24539 ) - ( axis_y37_g24539 * s67_g24539 ) ) , ( ( one_minus_c52_g24539 * axis_y37_g24539 * axis_z29_g24539 ) + ( axis_x25_g24539 * s67_g24539 ) ) , ( ( one_minus_c52_g24539 * axis_z29_g24539 * axis_z29_g24539 ) + c66_g24539 )));
			float3 temp_output_38_0_g24539 = ( ase_vertex3Pos - (_WIND_SECONDARY_PIVOT846_g24504).xyz );
			float3 VALUE_AWAY_FROM_WIND1040_g24504 = ( mul( float3x3(appendResult83_g24539, appendResult81_g24539, appendResult82_g24539), temp_output_38_0_g24539 ) - temp_output_38_0_g24539 );
			float3 lerpResult1_g24533 = lerp( temp_output_3_0_g24532 , VALUE_AWAY_FROM_WIND1040_g24504 , saturate( clampResult13_g24532 ));
			float3 lerpResult631_g24504 = lerp( VALUE_ROLL1034_g24504 , (( clampResult13_g24532 < 0.0 ) ? lerpResult1_g24538 :  lerpResult1_g24533 ) , WIND_GUST_AUDIO_STRENGTH1242_g24488);
			float3 MOTION_BRANCH1339_g24488 = lerpResult631_g24504;
			float WIND_LEAF_STRENGTH1179_g24488 = _WIND_LEAF_STRENGTH;
			float temp_output_17_0_g24540 = 3.0;
			float TYPE_DESIGNATOR1209_g24488 = round( v.texcoord2.w );
			float temp_output_18_0_g24540 = TYPE_DESIGNATOR1209_g24488;
			float WIND_TERTIARY_ROLL1210_g24488 = v.color.b;
			float _WIND_TERTIARY_ROLL669_g24545 = WIND_TERTIARY_ROLL1210_g24488;
			float3 temp_output_615_0_g24543 = ( float3( 0,0,0 ) + ase_vertex3Pos );
			float3 WIND_POSITION_VERTEX_OBJECT1193_g24488 = temp_output_615_0_g24543;
			float2 temp_output_1_0_g24546 = (WIND_POSITION_VERTEX_OBJECT1193_g24488).xz;
			float WIND_BASE_LEAF_FIELD_SIZE1182_g24488 = _WIND_BASE_LEAF_FIELD_SIZE;
			float2 temp_output_2_0_g24546 = (WIND_BASE_LEAF_FIELD_SIZE1182_g24488).xx;
			float _WIND_VARIATION662_g24545 = WIND_PHASE1212_g24488;
			float2 temp_output_704_0_g24545 = ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g24546 / temp_output_2_0_g24546 ) :  ( temp_output_1_0_g24546 * temp_output_2_0_g24546 ) ) + (_WIND_VARIATION662_g24545).xx );
			float temp_output_2_0_g24570 = _WIND_BASE_LEAF_CYCLE_TIME;
			float WIND_BASE_LEAF_FREQUENCY1264_g24488 = ( 1.0 / (( temp_output_2_0_g24570 == 0.0 ) ? 1.0 :  temp_output_2_0_g24570 ) );
			float temp_output_618_0_g24545 = WIND_BASE_LEAF_FREQUENCY1264_g24488;
			float2 break298_g24547 = ( temp_output_704_0_g24545 + ( (temp_output_618_0_g24545).xx * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g24547 = (float2(sin( break298_g24547.x ) , cos( break298_g24547.y )));
			float4 temp_output_273_0_g24547 = (-1.0).xxxx;
			float4 temp_output_271_0_g24547 = (1.0).xxxx;
			float2 clampResult26_g24547 = clamp( appendResult299_g24547 , temp_output_273_0_g24547.xy , temp_output_271_0_g24547.xy );
			float WIND_BASE_LEAF_STRENGTH1180_g24488 = _WIND_BASE_LEAF_STRENGTH;
			float2 temp_output_1031_0_g24545 = (( WIND_BASE_LEAF_STRENGTH1180_g24488 * WIND_BASE_AMPLITUDE1197_g24488 )).xx;
			float2 break699_g24545 = ( clampResult26_g24547 * temp_output_1031_0_g24545 );
			float2 break298_g24551 = ( temp_output_704_0_g24545 + ( (( 0.71 * temp_output_618_0_g24545 )).xx * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g24551 = (float2(sin( break298_g24551.x ) , cos( break298_g24551.y )));
			float4 temp_output_273_0_g24551 = (-1.0).xxxx;
			float4 temp_output_271_0_g24551 = (1.0).xxxx;
			float2 clampResult26_g24551 = clamp( appendResult299_g24551 , temp_output_273_0_g24551.xy , temp_output_271_0_g24551.xy );
			float3 appendResult698_g24545 = (float3(break699_g24545.x , ( clampResult26_g24551 * temp_output_1031_0_g24545 )));
			float3 temp_output_684_0_g24545 = ( _WIND_TERTIARY_ROLL669_g24545 * appendResult698_g24545 );
			float3 _WIND_DIRECTION671_g24545 = WIND_DIRECTION1192_g24488;
			float3 worldToObjDir1006_g24545 = mul( unity_WorldToObject, float4( _WIND_DIRECTION671_g24545, 0 ) ).xyz;
			float WIND_GUST_LEAF_STRENGTH1183_g24488 = _WIND_GUST_LEAF_STRENGTH;
			float lerpResult638_g24639 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_VERYHIGH , _WIND_AUDIO_INFLUENCE);
			float WIND_GUST_AUDIO_VERYHIGH1243_g24488 = lerpResult638_g24639;
			float4 color658_g24609 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float2 temp_output_61_0_g24614 = float2( 0,0 );
			float WIND_VARIATION1211_g24488 = v.texcoord.w;
			half localunity_ObjectToWorld0w1_g24597 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld2w3_g24597 = ( unity_ObjectToWorld[2].w );
			float2 appendResult1374_g24488 = (float2(localunity_ObjectToWorld0w1_g24597 , localunity_ObjectToWorld2w3_g24597));
			float2 temp_output_1_0_g24615 = ( ( 10.0 * WIND_VARIATION1211_g24488 ) + appendResult1374_g24488 );
			float WIND_GUST_LEAF_FIELD_SIZE1185_g24488 = _WIND_GUST_LEAF_FIELD_SIZE;
			float temp_output_2_0_g24621 = WIND_GUST_LEAF_FIELD_SIZE1185_g24488;
			float temp_output_40_0_g24614 = ( 1.0 / (( temp_output_2_0_g24621 == 0.0 ) ? 1.0 :  temp_output_2_0_g24621 ) );
			float2 temp_cast_36 = (temp_output_40_0_g24614).xx;
			float2 temp_output_2_0_g24615 = temp_cast_36;
			float clampResult3_g24502 = clamp( WIND_VARIATION1211_g24488 , 0.0 , 1.0 );
			float WIND_GUST_LEAF_CYCLE_TIME1184_g24488 = _WIND_GUST_LEAF_CYCLE_TIME;
			float temp_output_2_0_g24610 = ( ( ( ( clampResult3_g24502 * 2.0 ) - 1.0 ) * 0.3 * WIND_GUST_LEAF_CYCLE_TIME1184_g24488 ) + WIND_GUST_LEAF_CYCLE_TIME1184_g24488 );
			float mulTime37_g24614 = _Time.y * ( 1.0 / (( temp_output_2_0_g24610 == 0.0 ) ? 1.0 :  temp_output_2_0_g24610 ) );
			float temp_output_220_0_g24617 = -1.0;
			float4 temp_cast_37 = (temp_output_220_0_g24617).xxxx;
			float temp_output_219_0_g24617 = 1.0;
			float4 temp_cast_38 = (temp_output_219_0_g24617).xxxx;
			float4 clampResult26_g24617 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g24614 > float2( 0,0 ) ) ? ( temp_output_1_0_g24615 / temp_output_2_0_g24615 ) :  ( temp_output_1_0_g24615 * temp_output_2_0_g24615 ) ) + temp_output_61_0_g24614 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g24614 ) ) , temp_cast_37 , temp_cast_38 );
			float4 temp_cast_39 = (temp_output_220_0_g24617).xxxx;
			float4 temp_cast_40 = (temp_output_219_0_g24617).xxxx;
			float4 temp_cast_41 = (0.0).xxxx;
			float4 temp_cast_42 = (temp_output_219_0_g24617).xxxx;
			float temp_output_679_0_g24609 = 1.0;
			float4 temp_cast_43 = (temp_output_679_0_g24609).xxxx;
			float4 temp_output_52_0_g24614 = saturate( pow( abs( (temp_cast_41 + (clampResult26_g24617 - temp_cast_39) * (temp_cast_42 - temp_cast_41) / (temp_cast_40 - temp_cast_39)) ) , temp_cast_43 ) );
			float4 lerpResult656_g24609 = lerp( color658_g24609 , temp_output_52_0_g24614 , temp_output_679_0_g24609);
			float4 break655_g24609 = lerpResult656_g24609;
			float LEAF_GUST1375_g24488 = ( WIND_GUST_LEAF_STRENGTH1183_g24488 * WIND_GUST_AUDIO_VERYHIGH1243_g24488 * break655_g24609.g );
			float _WIND_GUST_STRENGTH703_g24545 = LEAF_GUST1375_g24488;
			float3 _GUST1018_g24545 = ( worldToObjDir1006_g24545 * _WIND_GUST_STRENGTH703_g24545 );
			float WIND_GUST_LEAF_MID_STRENGTH1186_g24488 = _WIND_GUST_LEAF_MID_STRENGTH;
			float lerpResult633_g24639 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_HIGH , _WIND_AUDIO_INFLUENCE);
			float WIND_GUST_AUDIO_HIGH1244_g24488 = lerpResult633_g24639;
			float4 color658_g24652 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float WIND_GUST_LEAF_MID_CYCLE_TIME1187_g24488 = _WIND_GUST_LEAF_MID_CYCLE_TIME;
			float temp_output_2_0_g24653 = ( WIND_GUST_LEAF_MID_CYCLE_TIME1187_g24488 + ( WIND_VARIATION1211_g24488 * -0.05 ) );
			float2 temp_cast_44 = (( 1.0 / (( temp_output_2_0_g24653 == 0.0 ) ? 1.0 :  temp_output_2_0_g24653 ) )).xx;
			float2 temp_output_61_0_g24662 = float2( 0,0 );
			float2 appendResult1400_g24488 = (float2(ase_vertex3Pos.x , ase_vertex3Pos.z));
			float2 temp_output_1_0_g24663 = ( (WIND_VARIATION1211_g24488).xx + appendResult1400_g24488 );
			float WIND_GUST_LEAF_MID_FIELD_SIZE1188_g24488 = _WIND_GUST_LEAF_MID_FIELD_SIZE;
			float temp_output_2_0_g24658 = WIND_GUST_LEAF_MID_FIELD_SIZE1188_g24488;
			float temp_output_40_0_g24662 = ( 1.0 / (( temp_output_2_0_g24658 == 0.0 ) ? 1.0 :  temp_output_2_0_g24658 ) );
			float2 temp_cast_45 = (temp_output_40_0_g24662).xx;
			float2 temp_output_2_0_g24663 = temp_cast_45;
			float2 panner90_g24662 = ( _Time.y * temp_cast_44 + ( (( temp_output_61_0_g24662 > float2( 0,0 ) ) ? ( temp_output_1_0_g24663 / temp_output_2_0_g24663 ) :  ( temp_output_1_0_g24663 * temp_output_2_0_g24663 ) ) + temp_output_61_0_g24662 ));
			float temp_output_679_0_g24652 = 1.0;
			float4 temp_cast_46 = (temp_output_679_0_g24652).xxxx;
			float4 temp_output_52_0_g24662 = saturate( pow( tex2Dlod( _WIND_GUST_TEXTURE, float4( panner90_g24662, 0, 0.0) ) , temp_cast_46 ) );
			float4 lerpResult656_g24652 = lerp( color658_g24652 , temp_output_52_0_g24662 , temp_output_679_0_g24652);
			float4 break655_g24652 = lerpResult656_g24652;
			float temp_output_1557_630_g24488 = break655_g24652.r;
			float LEAF_GUST_MID1397_g24488 = ( WIND_GUST_LEAF_MID_STRENGTH1186_g24488 * WIND_GUST_AUDIO_HIGH1244_g24488 * temp_output_1557_630_g24488 * temp_output_1557_630_g24488 );
			float _WIND_GUST_STRENGTH_MID829_g24545 = LEAF_GUST_MID1397_g24488;
			float3 _GUST_MID1019_g24545 = ( worldToObjDir1006_g24545 * _WIND_GUST_STRENGTH_MID829_g24545 );
			float3 ase_vertexNormal = v.normal.xyz;
			float3 _LEAF_NORMAL992_g24545 = ase_vertexNormal;
			float dotResult1_g24557 = dot( worldToObjDir1006_g24545 , _LEAF_NORMAL992_g24545 );
			float clampResult13_g24558 = clamp( dotResult1_g24557 , -1.0 , 1.0 );
			float WIND_GUST_LEAF_MICRO_STRENGTH1189_g24488 = _WIND_GUST_LEAF_MICRO_STRENGTH;
			float4 color658_g24626 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float WIND_GUST_LEAF_MICRO_CYCLE_TIME1190_g24488 = _WIND_GUST_LEAF_MICRO_CYCLE_TIME;
			float temp_output_2_0_g24627 = ( WIND_GUST_LEAF_MICRO_CYCLE_TIME1190_g24488 + ( WIND_VARIATION1211_g24488 * 0.1 ) );
			float2 temp_cast_47 = (( 1.0 / (( temp_output_2_0_g24627 == 0.0 ) ? 1.0 :  temp_output_2_0_g24627 ) )).xx;
			float2 temp_output_61_0_g24636 = float2( 0,0 );
			float2 appendResult1409_g24488 = (float2(ase_vertex3Pos.y , ase_vertex3Pos.z));
			float2 temp_output_1_0_g24637 = ( (WIND_VARIATION1211_g24488).xx + appendResult1409_g24488 );
			float WIND_GUST_LEAF_MICRO_FIELD_SIZE1191_g24488 = _WIND_GUST_LEAF_MICRO_FIELD_SIZE;
			float temp_output_2_0_g24632 = WIND_GUST_LEAF_MICRO_FIELD_SIZE1191_g24488;
			float temp_output_40_0_g24636 = ( 1.0 / (( temp_output_2_0_g24632 == 0.0 ) ? 1.0 :  temp_output_2_0_g24632 ) );
			float2 temp_cast_48 = (temp_output_40_0_g24636).xx;
			float2 temp_output_2_0_g24637 = temp_cast_48;
			float2 panner90_g24636 = ( _Time.y * temp_cast_47 + ( (( temp_output_61_0_g24636 > float2( 0,0 ) ) ? ( temp_output_1_0_g24637 / temp_output_2_0_g24637 ) :  ( temp_output_1_0_g24637 * temp_output_2_0_g24637 ) ) + temp_output_61_0_g24636 ));
			float temp_output_679_0_g24626 = 1.0;
			float4 temp_cast_49 = (temp_output_679_0_g24626).xxxx;
			float4 temp_output_52_0_g24636 = saturate( pow( tex2Dlod( _WIND_GUST_TEXTURE, float4( panner90_g24636, 0, 0.0) ) , temp_cast_49 ) );
			float4 lerpResult656_g24626 = lerp( color658_g24626 , temp_output_52_0_g24636 , temp_output_679_0_g24626);
			float4 break655_g24626 = lerpResult656_g24626;
			float LEAF_GUST_MICRO1408_g24488 = ( WIND_GUST_LEAF_MICRO_STRENGTH1189_g24488 * WIND_GUST_AUDIO_VERYHIGH1243_g24488 * break655_g24626.a );
			float _WIND_GUST_STRENGTH_MICRO851_g24545 = LEAF_GUST_MICRO1408_g24488;
			float clampResult3_g24555 = clamp( _WIND_GUST_STRENGTH_MICRO851_g24545 , 0.0 , 1.0 );
			float temp_output_3_0_g24558 = ( ( clampResult3_g24555 * 2.0 ) - 1.0 );
			float lerpResult1_g24564 = lerp( ( _WIND_GUST_STRENGTH_MICRO851_g24545 - 1.0 ) , temp_output_3_0_g24558 , saturate( ( 1.0 + clampResult13_g24558 ) ));
			float lerpResult1_g24559 = lerp( temp_output_3_0_g24558 , _WIND_GUST_STRENGTH_MICRO851_g24545 , saturate( clampResult13_g24558 ));
			float3 _GUST_MICRO1020_g24545 = ( worldToObjDir1006_g24545 * (( clampResult13_g24558 < 0.0 ) ? lerpResult1_g24564 :  lerpResult1_g24559 ) );
			float3 lerpResult538_g24545 = lerp( temp_output_684_0_g24545 , ( temp_output_684_0_g24545 + ( ( _GUST1018_g24545 + _GUST_MID1019_g24545 + _GUST_MICRO1020_g24545 ) * _WIND_TERTIARY_ROLL669_g24545 ) ) , WIND_GUST_AUDIO_STRENGTH1242_g24488);
			float3 MOTION_LEAF1343_g24488 = lerpResult538_g24545;
			float3 temp_output_19_0_g24540 = MOTION_LEAF1343_g24488;
			float3 temp_output_20_0_g24540 = float3(0,0,0);
			float4 break360_g24453 = v.ase_texcoord4;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 temp_output_356_0_g24453 = ( ase_worldPos - (_WorldSpaceCameraPos).xyz );
			float3 normalizeResult358_g24453 = normalize( temp_output_356_0_g24453 );
			float3 cam_pos_axis_z384_g24453 = normalizeResult358_g24453;
			float3 normalizeResult366_g24453 = normalize( cross( float3(0,1,0) , cam_pos_axis_z384_g24453 ) );
			float3 cam_pos_axis_x385_g24453 = normalizeResult366_g24453;
			float4x4 break375_g24453 = UNITY_MATRIX_V;
			float3 appendResult377_g24453 = (float3(break375_g24453[ 0 ][ 0 ] , break375_g24453[ 0 ][ 1 ] , break375_g24453[ 0 ][ 2 ]));
			float3 cam_rot_axis_x378_g24453 = appendResult377_g24453;
			float dotResult436_g24453 = dot( float3(0,1,0) , temp_output_356_0_g24453 );
			float temp_output_438_0_g24453 = saturate( abs( dotResult436_g24453 ) );
			float3 lerpResult424_g24453 = lerp( cam_pos_axis_x385_g24453 , cam_rot_axis_x378_g24453 , temp_output_438_0_g24453);
			float3 xAxis346_g24453 = lerpResult424_g24453;
			float3 cam_pos_axis_y383_g24453 = cross( cam_pos_axis_z384_g24453 , normalizeResult366_g24453 );
			float3 appendResult381_g24453 = (float3(break375_g24453[ 1 ][ 0 ] , break375_g24453[ 1 ][ 1 ] , break375_g24453[ 1 ][ 2 ]));
			float3 cam_rot_axis_y379_g24453 = appendResult381_g24453;
			float3 lerpResult423_g24453 = lerp( cam_pos_axis_y383_g24453 , cam_rot_axis_y379_g24453 , temp_output_438_0_g24453);
			float3 yAxis362_g24453 = lerpResult423_g24453;
			float isBillboard343_g24453 = (( break360_g24453.w < -0.99999 ) ? 1.0 :  0.0 );
			float3 temp_output_41_0_g24701 = ( ( ( WIND_TRUNK_STRENGTH1235_g24488 * MOTION_TRUNK1337_g24488 ) + ( WIND_BRANCH_STRENGTH1224_g24488 * MOTION_BRANCH1339_g24488 ) + ( WIND_LEAF_STRENGTH1179_g24488 * (( temp_output_17_0_g24540 == temp_output_18_0_g24540 ) ? temp_output_19_0_g24540 :  temp_output_20_0_g24540 ) ) ) + ( -( ( break360_g24453.x * xAxis346_g24453 ) + ( break360_g24453.y * yAxis362_g24453 ) ) * isBillboard343_g24453 * -1.0 ) );
			float temp_output_63_0_g24702 = (( unity_LODFade.x >= 1E-06 && unity_LODFade.x <= 0.999999 ) ? unity_LODFade.x :  1.0 );
			float3 lerpResult57_g24702 = lerp( temp_output_41_0_g24701 , -ase_vertex3Pos , ( 1.0 - temp_output_63_0_g24702 ));
			#ifdef INTERNAL_LODFADE_SCALE
				float3 staticSwitch58_g24701 = lerpResult57_g24702;
			#else
				float3 staticSwitch58_g24701 = temp_output_41_0_g24701;
			#endif
			#ifdef LOD_FADE_CROSSFADE
				float3 staticSwitch62_g24701 = staticSwitch58_g24701;
			#else
				float3 staticSwitch62_g24701 = temp_output_41_0_g24701;
			#endif
			v.vertex.xyz += staticSwitch62_g24701;
			float3 appendResult382_g24453 = (float3(break375_g24453[ 2 ][ 0 ] , break375_g24453[ 2 ][ 1 ] , break375_g24453[ 2 ][ 2 ]));
			float3 cam_rot_axis_z380_g24453 = appendResult382_g24453;
			float3 lerpResult422_g24453 = lerp( cam_pos_axis_z384_g24453 , cam_rot_axis_z380_g24453 , temp_output_438_0_g24453);
			float3 zAxis421_g24453 = lerpResult422_g24453;
			float3 lerpResult331_g24453 = lerp( ase_vertexNormal , ( -1.0 * zAxis421_g24453 ) , isBillboard343_g24453);
			float3 normalizeResult326_g24453 = normalize( lerpResult331_g24453 );
			v.normal = normalizeResult326_g24453;
			float4 ase_vertexTangent = v.tangent;
			float4 appendResult345_g24453 = (float4(xAxis346_g24453 , -1.0));
			float4 lerpResult341_g24453 = lerp( float4( ase_vertexTangent.xyz , 0.0 ) , appendResult345_g24453 , isBillboard343_g24453);
			v.tangent = lerpResult341_g24453;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap1164 = i.uv_texcoord;
			float3 temp_output_13_0_g23574 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap1164 ), _BumpScale );
			float3 switchResult20_g23574 = (((i.ASEVFace>0)?(temp_output_13_0_g23574):(-temp_output_13_0_g23574)));
			half3 MainBumpMap1172 = switchResult20_g23574;
			o.Normal = MainBumpMap1172;
			float2 uv_MainTex1135 = i.uv_texcoord;
			float4 tex2DNode1135 = tex2D( _MainTex, uv_MainTex1135 );
			half4 Main_MainTex1142 = tex2DNode1135;
			float3 temp_output_2_0_g23004 = Main_MainTex1142.rgb;
			float4 color107_g24748 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
			float2 appendResult102_g24748 = (float2(0.0 , _SecondaryColor.a));
			float4 temp_output_108_0_g24748 = _Color;
			float2 weightedBlendVar103_g24748 = appendResult102_g24748;
			float4 weightedAvg103_g24748 = ( ( weightedBlendVar103_g24748.x*temp_output_108_0_g24748 + weightedBlendVar103_g24748.y*_SecondaryColor )/( weightedBlendVar103_g24748.x + weightedBlendVar103_g24748.y ) );
			float2 uv_MetallicGlossMap1136 = i.uv_texcoord;
			float4 tex2DNode1136 = tex2D( _MetallicGlossMap, uv_MetallicGlossMap1136 );
			half Main_MetallicGlossMap_B1138 = tex2DNode1136.b;
			float temp_output_86_0_g24748 = ( 1.0 - Main_MetallicGlossMap_B1138 );
			float4 lerpResult1_g24759 = lerp( (( max( 0.0 , _SecondaryColor.a ) == 0.0 ) ? color107_g24748 :  weightedAvg103_g24748 ) , _MaskedColor , saturate( temp_output_86_0_g24748 ));
			float4 temp_output_8_0_g23004 = lerpResult1_g24759;
			float3 temp_output_10_0_g23004 = (temp_output_8_0_g23004).rgb;
			float3 lerpResult1_g23005 = lerp( temp_output_2_0_g23004 , ( temp_output_2_0_g23004 * temp_output_10_0_g23004 ) , saturate( saturate( (temp_output_8_0_g23004).a ) ));
			half3 Main_MainTex_RGB1139 = (tex2DNode1135).rgb;
			float3 temp_output_2_0_g23002 = Main_MainTex_RGB1139;
			float3 ase_worldPos = i.worldPos;
			float2 appendResult54_g24748 = (float2(( ase_worldPos.x + ase_worldPos.z ) , ase_worldPos.y));
			float2 temp_output_1_0_g24750 = appendResult54_g24748;
			float2 temp_output_2_0_g24750 = (_ColorMapScale).xx;
			float4 temp_output_1_0_g24752 = tex2D( _ColorMap, ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g24750 / temp_output_2_0_g24750 ) :  ( temp_output_1_0_g24750 * temp_output_2_0_g24750 ) ) + float2( 0,0 ) ) );
			float temp_output_2_0_g24752 = _ColorMapChannel;
			float temp_output_7_0_g24755 = temp_output_2_0_g24752;
			float4 lerpResult4_g24755 = lerp( float4(1,0,0,0) , float4(0,1,0,0) , saturate( temp_output_7_0_g24755 ));
			float4 lerpResult6_g24755 = lerp( lerpResult4_g24755 , float4(0,0,1,0) , step( 2.0 , temp_output_7_0_g24755 ));
			float4 lerpResult12_g24755 = lerp( lerpResult6_g24755 , float4(0,0,0,1) , step( 3.0 , temp_output_7_0_g24755 ));
			half4 FOUR16_g24755 = lerpResult12_g24755;
			float4 temp_output_17_0_g24752 = ( (temp_output_1_0_g24752).xyzw * FOUR16_g24755 );
			float4 break37_g24752 = temp_output_17_0_g24752;
			float4 lerpResult1_g24749 = lerp( temp_output_108_0_g24748 , _SecondaryColor , saturate( ( _ColorMapBias + (CalculateContrast(_ColorMapContrast,(saturate( max( max( max( break37_g24752.x , break37_g24752.y ) , break37_g24752.z ) , break37_g24752.w ) )).xxxx)).r ) ));
			float4 temp_output_8_0_g23002 = lerpResult1_g24749;
			float3 temp_output_10_0_g23002 = (temp_output_8_0_g23002).rgb;
			float3 lerpResult1_g23003 = lerp( temp_output_2_0_g23002 , ( temp_output_2_0_g23002 * temp_output_10_0_g23002 ) , saturate( saturate( (temp_output_8_0_g23002).a ) ));
			float3 lerpResult1_g23032 = lerp( (lerpResult1_g23005).xyz , (lerpResult1_g23003).xyz , saturate( ( 2.0 * Main_MetallicGlossMap_B1138 ) ));
			float3 ALBEDO1166 = saturate( lerpResult1_g23032 );
			o.Albedo = ALBEDO1166;
			half SMOOTHNESS1174 = saturate( ( tex2DNode1136.a * _Glossiness ) );
			o.Smoothness = SMOOTHNESS1174;
			half Main_MetallicGlossMap_G1169 = tex2DNode1136.g;
			o.Occlusion = Main_MetallicGlossMap_G1169;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Unlit/Color"
	CustomEditor "InternalShaderGUI"
}
/*ASEBEGIN
Version=17500
0;-864;1536;843;3085.67;3191.871;1.3;True;False
Node;AmplifyShaderEditor.SamplerNode;1136;-2455.892,-924.5289;Inherit;True;Property;_MetallicGlossMap;Leaf Surface;14;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;337f4ef7359fbd14e827ec62fb33bb48;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1135;-4360.188,-898.3883;Inherit;True;Property;_MainTex;Leaf Albedo;11;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;2c0831ff3fcdc304fa67fd9f5abab4aa;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;1137;-3990.619,-800.2743;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1138;-2107.892,-857.4169;Half;False;Main_MetallicGlossMap_B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1213;-4628.298,-1783.483;Half;False;Property;_Color;Primary Color;16;0;Create;False;0;0;False;0;1,1,1,1;0.4823529,0.5882353,0.2941175,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1140;-4548.65,-1596.801;Inherit;False;1138;Main_MetallicGlossMap_B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1142;-3976.188,-898.3883;Half;False;Main_MainTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1139;-3776.619,-801.2743;Half;False;Main_MainTex_RGB;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1146;-3438.12,-1401.992;Inherit;False;const;-1;;23001;5b64729fb717c5f49a1bc2dab81d5e1c;4,21,0,3,6,22,0,28,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1217;-4246.637,-1658.95;Inherit;False;Color Map;17;;24748;75394c603df4334428b014264f3883db;2,111,0,110,0;2;108;COLOR;1,1,1,1;False;83;FLOAT;0;False;3;COLOR;84;COLOR;0;FLOAT;116
Node;AmplifyShaderEditor.GetLocalVarNode;1143;-4218.349,-1547.082;Inherit;False;1139;Main_MainTex_RGB;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1147;-4190.78,-1746.906;Inherit;False;1142;Main_MainTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1149;-3573.32,-1307.892;Inherit;False;1138;Main_MetallicGlossMap_B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1151;-3304.311,-1370.053;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1152;-3863.529,-1654.312;Inherit;False;Color Blend;-1;;23004;e23fbae801d69e440a1b323378db49a5;2,11,0,14,1;3;2;FLOAT3;0,0,0;False;8;COLOR;0,0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1160;-3499.188,-882.3883;Half;False;Property;_BumpScale;Leaf Normal Scale;13;0;Create;False;0;0;False;0;1;3;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1163;-2422.532,-716.7355;Half;False;Property;_Glossiness;Leaf Smoothness;15;0;Create;False;0;0;False;0;0.1;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1148;-3863.878,-1537.393;Inherit;False;Color Blend;-1;;23002;e23fbae801d69e440a1b323378db49a5;2,11,0,14,1;3;2;FLOAT3;0,0,0;False;8;COLOR;0,0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1155;-3152.056,-1658.315;Inherit;False;Lerp (Clamped);-1;;23032;cad3f473268ed2641979326c3e8290ec;0;3;2;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1165;-2100.531,-751.7355;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1164;-3209.94,-926.9021;Inherit;True;Property;_BumpMap;Leaf Normal;12;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;b7a5f82d4969ed94e99c3d78803cb8ed;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1168;-2901.42,-908.9341;Inherit;False;Normal BackFace;-1;;23574;121446c878db06f4c847f9c5afed7cfe;0;1;13;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;1161;-2924.306,-1677.667;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1187;-2419.565,-2421.038;Inherit;False;Pivot Billboard;-1;;24453;50ed44a1d0e6ecb498e997b8969f8558;3,431,2,432,2,433,2;0;3;FLOAT3;370;FLOAT3;369;FLOAT4;371
Node;AmplifyShaderEditor.RegisterLocalVarNode;1167;-3987.188,-703.3884;Half;False;Opacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1173;-1943.85,-759.8676;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1188;-2760.393,-2605.653;Inherit;False;Wind (Tree Complex);26;;24488;76dbe6e88a5c02e42a177b05b9981ead;2,981,1,983,1;0;8;FLOAT3;0;FLOAT;1021;FLOAT;1022;FLOAT;1023;FLOAT;1024;FLOAT;1027;FLOAT;1025;FLOAT;1454
Node;AmplifyShaderEditor.SimpleAddOpNode;1191;-2229.652,-2606.507;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1169;-2101.892,-942.4169;Half;False;Main_MetallicGlossMap_G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1172;-2702.188,-917.3883;Half;False;MainBumpMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;1196;-1489.367,-1911.791;Inherit;False;797.8645;735.9034;DRAWERS;7;1208;1207;1206;1205;1204;1202;1199;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1166;-2631.58,-1677.103;Inherit;False;ALBEDO;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1192;-2273.475,-2687.69;Inherit;False;1167;Opacity;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1174;-1779.532,-778.3356;Half;False;SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1198;-1686.361,-2288.24;Inherit;False;Cutoff Distance;3;;24708;5fa78795cf865fc4fba7d47ebe2d2d92;0;2;33;FLOAT;0;False;16;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1207;-1457.367,-1655.79;Half;False;Property;_LEAFF;[ LEAFF ];10;0;Create;True;0;0;True;1;InternalCategory(Leaf);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1205;-1461.367,-1550.79;Inherit;False;Internal Features Support;-1;;24711;3c493d142aeebd840af72d626f6915c6;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1197;-1779.139,-2797.854;Inherit;False;Property;_Cutoff;Depth Cutoff;2;0;Create;False;0;0;False;0;0.7;0.9;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1171;-3091.13,-3152.299;Inherit;False;1166;ALBEDO;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1176;-3133.018,-2900.11;Inherit;False;1169;Main_MetallicGlossMap_G;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1194;-2055.567,-2682.52;Inherit;False;Execute LOD Fade;-1;;24694;18ea34bd83a0d6c4db425672111543e6;0;2;41;FLOAT;0;False;58;FLOAT3;0,0,0;False;3;FLOAT;0;FLOAT3;91;FLOAT;96
Node;AmplifyShaderEditor.FunctionNode;1195;-2113.365,-2289.747;Inherit;False;Mesh Values (Tree) (Complex) (Vertex Colors);-1;;24707;9cacaefc2ecfddf4c8e070f9be99b854;0;0;4;FLOAT;495;FLOAT;501;FLOAT;550;FLOAT;552
Node;AmplifyShaderEditor.RangedFloatNode;1202;-1471.367,-1296.791;Half;False;Property;_IsBark;Is Bark;53;1;[Toggle];Create;True;2;Off;0;On;1;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1206;-1151.369,-1296.791;Half;False;Property;_IsShadow;Is Shadow;54;1;[Toggle];Create;True;2;Off;0;On;1;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1199;-1457.367,-1751.79;Half;False;Property;_RENDERINGG;[ RENDERINGG ];1;0;Create;True;0;0;True;1;InternalCategory(Rendering);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1182;-3105.03,-2983.886;Inherit;False;1174;SMOOTHNESS;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1181;-3108.297,-3067.238;Inherit;False;1172;MainBumpMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1204;-1457.367,-1847.791;Half;False;Property;_BANNER;BANNER;0;0;Create;True;0;0;True;1;InternalBanner(Internal, Leaf);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1208;-1311.368,-1296.791;Half;False;Property;_IsLeaf;Is Leaf;52;1;[Toggle];Create;True;2;Off;0;On;1;0;True;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-1220.608,-3079.287;Float;False;True;-1;2;InternalShaderGUI;200;0;Standard;internal/fallback-cutout;False;False;False;False;False;True;True;True;True;False;True;True;False;False;False;False;True;False;False;False;False;Off;0;False;925;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0;True;True;0;True;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;550;10;False;553;0;1;False;550;10;False;553;21;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;200;Unlit/Color;-1;-1;-1;-1;0;False;0;0;False;743;-1;0;False;1197;0;0;0;False;0.1;False;-1;0;False;-1;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;14;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;1211;-4360.188,-1058.388;Inherit;False;578.3026;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1210;-2440.188,-1058.388;Inherit;False;826;100;Surface Texture (Metallic, AO, SubSurface, Smoothness);0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1212;-4492.286,-1966.285;Inherit;False;2871.096;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1209;-3499.188,-1058.388;Inherit;False;1027.031;100;Normal Texture;0;;0.5019608,0.5019608,1,1;0;0
WireConnection;1137;0;1135;0
WireConnection;1138;0;1136;3
WireConnection;1142;0;1135;0
WireConnection;1139;0;1137;0
WireConnection;1217;108;1213;0
WireConnection;1217;83;1140;0
WireConnection;1151;0;1146;0
WireConnection;1151;1;1149;0
WireConnection;1152;2;1147;0
WireConnection;1152;8;1217;0
WireConnection;1148;2;1143;0
WireConnection;1148;8;1217;84
WireConnection;1155;2;1152;0
WireConnection;1155;4;1148;0
WireConnection;1155;5;1151;0
WireConnection;1165;0;1136;4
WireConnection;1165;1;1163;0
WireConnection;1164;5;1160;0
WireConnection;1168;13;1164;0
WireConnection;1161;0;1155;0
WireConnection;1167;0;1135;4
WireConnection;1173;0;1165;0
WireConnection;1191;0;1188;0
WireConnection;1191;1;1187;370
WireConnection;1169;0;1136;2
WireConnection;1172;0;1168;0
WireConnection;1166;0;1161;0
WireConnection;1174;0;1173;0
WireConnection;1198;33;1194;0
WireConnection;1198;16;1195;550
WireConnection;1194;41;1192;0
WireConnection;1194;58;1191;0
WireConnection;0;0;1171;0
WireConnection;0;1;1181;0
WireConnection;0;4;1182;0
WireConnection;0;5;1176;0
WireConnection;0;10;1197;0
WireConnection;0;11;1194;91
WireConnection;0;12;1187;369
WireConnection;0;13;1187;371
ASEEND*/
//CHKSM=F5AB97F078E1B6600169AA1C4F64EAC2DD83908A