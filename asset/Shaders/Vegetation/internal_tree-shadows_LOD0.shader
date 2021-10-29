// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "appalachia/tree-shadows_LOD0"
{
	Properties
	{
		[InternalBanner(Internal,Tree Shadows)]_BANNER("BANNER", Float) = 1
		[InternalCategory(Rendering)]_RENDERINGG("[ RENDERINGG ]", Float) = 0
		_CutoffLowNear("Cutoff Low (Near)", Range( 0 , 1)) = 0.75
		_CutoffHighNear("Cutoff High (Near)", Range( 0 , 1)) = 1
		_CutoffFar("Cutoff Far", Range( 64 , 1024)) = 64
		[HideInInspector]_cutoff("_cutoff", Float) = 0
		_CutoffLowFar("Cutoff Low (Far)", Range( 0 , 1)) = 0.1
		_CutoffHighFar("Cutoff High (Far)", Range( 0 , 1)) = 0.6
		[NoScaleOffset]_MainTex("Albedo", 2D) = "white" {}
		[HideInInspector][Toggle]_IsBark("Is Bark", Float) = 0
		[HideInInspector][Toggle]_IsLeaf("Is Leaf", Float) = 0
		[HideInInspector][Toggle]_IsShadow("Is Shadow", Float) = 1
		[HideInInspector] _tex4coord3( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "DisableBatching" = "True" }
		LOD 100
		Cull Off
		CGPROGRAM

		#include "UnityShaderVariables.cginc"
		#pragma target 4.0
		 


		// INTERNAL_SHADER_FEATURE_START

		// FEATURE_GPU_INSTANCER
		#include "UnityCG.cginc"
		#include "Assets/Resources/CGIncludes/Appalachia/GPUInstancerInclude.cginc"
		#pragma instancing_options procedural:setupGPUI


		// FEATURE_LODFADE_DITHER
		#define INTERNAL_LODFADE_DITHER
		#pragma multi_compile _ LOD_FADE_CROSSFADE

		// INTERNAL_SHADER_FEATURE_END
		  
		#pragma exclude_renderers gles vulkan 
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
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
			float4 uv3_tex4coord3;
			float2 uv_texcoord;
			float4 screenPosition;
			float4 vertexColor : COLOR;
		};

		uniform half _IsShadow;
		uniform half _BANNER;
		uniform half _IsBark;
		uniform half _IsLeaf;
		uniform half _RENDERINGG;
		uniform half _WIND_TRUNK_STRENGTH;
		uniform half _WIND_BASE_TRUNK_FIELD_SIZE;
		uniform half _WIND_BASE_TRUNK_CYCLE_TIME;
		uniform half _WIND_BASE_AMPLITUDE;
		uniform half _WIND_BASE_TO_GUST_RATIO;
		uniform half _WIND_GUST_AMPLITUDE;
		uniform half _WIND_GUST_AUDIO_STRENGTH_LOW;
		uniform half _WIND_AUDIO_INFLUENCE;
		uniform sampler2D _WIND_GUST_TEXTURE;
		uniform half _WIND_GUST_TRUNK_FIELD_SIZE;
		uniform half _WIND_GUST_TRUNK_CYCLE_TIME;
		uniform half _WIND_GUST_CONTRAST;
		uniform half3 _WIND_DIRECTION;
		uniform half _WIND_BRANCH_STRENGTH;
		uniform half _WIND_BASE_BRANCH_FIELD_SIZE;
		uniform half _WIND_BASE_BRANCH_VARIATION_STRENGTH;
		uniform half _WIND_BASE_BRANCH_CYCLE_TIME;
		uniform half _WIND_GUST_BRANCH_FIELD_SIZE;
		uniform half _WIND_GUST_BRANCH_CYCLE_TIME;
		uniform half _WIND_GUST_AUDIO_STRENGTH_MID;
		uniform half _WIND_GUST_BRANCH_VARIATION_STRENGTH;
		uniform half _WIND_LEAF_STRENGTH;
		uniform half _WIND_BASE_LEAF_FIELD_SIZE;
		uniform half _WIND_BASE_LEAF_CYCLE_TIME;
		uniform half _WIND_GUST_AUDIO_STRENGTH_HIGH;
		uniform half _WIND_GUST_LEAF_FIELD_SIZE;
		uniform half _WIND_GUST_LEAF_CYCLE_TIME;
		uniform sampler2D _MainTex;
		uniform half _CutoffLowNear;
		uniform half _CutoffLowFar;
		uniform half _CutoffFar;
		uniform half _CutoffHighNear;
		uniform half _CutoffHighFar;
		uniform float _cutoff;


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
			half localunity_ObjectToWorld0w1_g9775 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g9775 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g9775 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g9775 = (float3(localunity_ObjectToWorld0w1_g9775 , localunity_ObjectToWorld1w2_g9775 , localunity_ObjectToWorld2w3_g9775));
			float3 temp_output_1062_510_g9657 = appendResult6_g9775;
			float2 temp_output_1_0_g9781 = (temp_output_1062_510_g9657).xz;
			float temp_output_2_0_g9787 = _WIND_BASE_TRUNK_FIELD_SIZE;
			float2 temp_cast_0 = (( 1.0 / (( temp_output_2_0_g9787 == 0.0 ) ? 1.0 :  temp_output_2_0_g9787 ) )).xx;
			float2 temp_output_2_0_g9781 = temp_cast_0;
			float2 temp_output_704_0_g9776 = ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g9781 / temp_output_2_0_g9781 ) :  ( temp_output_1_0_g9781 * temp_output_2_0_g9781 ) ) + float2( 0,0 ) );
			float temp_output_2_0_g9674 = _WIND_BASE_TRUNK_CYCLE_TIME;
			float temp_output_618_0_g9776 = ( 1.0 / (( temp_output_2_0_g9674 == 0.0 ) ? 1.0 :  temp_output_2_0_g9674 ) );
			float2 break298_g9783 = ( temp_output_704_0_g9776 + ( temp_output_618_0_g9776 * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g9783 = (float2(sin( break298_g9783.x ) , cos( break298_g9783.y )));
			float4 temp_output_273_0_g9783 = (-1.0).xxxx;
			float4 temp_output_271_0_g9783 = (1.0).xxxx;
			float2 clampResult26_g9783 = clamp( appendResult299_g9783 , temp_output_273_0_g9783.xy , temp_output_271_0_g9783.xy );
			float temp_output_1062_495_g9657 = _WIND_BASE_AMPLITUDE;
			float temp_output_1062_501_g9657 = _WIND_BASE_TO_GUST_RATIO;
			float temp_output_524_0_g9776 = ( temp_output_1062_495_g9657 * temp_output_1062_501_g9657 );
			float2 TRUNK_PIVOT_ROCKING701_g9776 = ( clampResult26_g9783 * temp_output_524_0_g9776 );
			float _WIND_PRIMARY_ROLL669_g9776 = v.color.r;
			float temp_output_54_0_g9791 = ( TRUNK_PIVOT_ROCKING701_g9776 * 0.05 * _WIND_PRIMARY_ROLL669_g9776 ).x;
			float temp_output_72_0_g9791 = cos( temp_output_54_0_g9791 );
			float one_minus_c52_g9791 = ( 1.0 - temp_output_72_0_g9791 );
			float3 break70_g9791 = float3(0,1,0);
			float axis_x25_g9791 = break70_g9791.x;
			float c66_g9791 = temp_output_72_0_g9791;
			float axis_y37_g9791 = break70_g9791.y;
			float axis_z29_g9791 = break70_g9791.z;
			float s67_g9791 = sin( temp_output_54_0_g9791 );
			float3 appendResult83_g9791 = (float3(( ( one_minus_c52_g9791 * axis_x25_g9791 * axis_x25_g9791 ) + c66_g9791 ) , ( ( one_minus_c52_g9791 * axis_x25_g9791 * axis_y37_g9791 ) - ( axis_z29_g9791 * s67_g9791 ) ) , ( ( one_minus_c52_g9791 * axis_z29_g9791 * axis_x25_g9791 ) + ( axis_y37_g9791 * s67_g9791 ) )));
			float3 appendResult81_g9791 = (float3(( ( one_minus_c52_g9791 * axis_x25_g9791 * axis_y37_g9791 ) + ( axis_z29_g9791 * s67_g9791 ) ) , ( ( one_minus_c52_g9791 * axis_y37_g9791 * axis_y37_g9791 ) + c66_g9791 ) , ( ( one_minus_c52_g9791 * axis_y37_g9791 * axis_z29_g9791 ) - ( axis_x25_g9791 * s67_g9791 ) )));
			float3 appendResult82_g9791 = (float3(( ( one_minus_c52_g9791 * axis_z29_g9791 * axis_x25_g9791 ) - ( axis_y37_g9791 * s67_g9791 ) ) , ( ( one_minus_c52_g9791 * axis_y37_g9791 * axis_z29_g9791 ) + ( axis_x25_g9791 * s67_g9791 ) ) , ( ( one_minus_c52_g9791 * axis_z29_g9791 * axis_z29_g9791 ) + c66_g9791 )));
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 _WIND_PRIMARY_PIVOT655_g9776 = (v.texcoord1).xyz;
			float3 temp_output_38_0_g9791 = ( ase_vertex3Pos - (_WIND_PRIMARY_PIVOT655_g9776).xyz );
			float2 break298_g9777 = ( temp_output_704_0_g9776 + ( temp_output_618_0_g9776 * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g9777 = (float2(sin( break298_g9777.x ) , cos( break298_g9777.y )));
			float4 temp_output_273_0_g9777 = (-1.0).xxxx;
			float4 temp_output_271_0_g9777 = (1.0).xxxx;
			float2 clampResult26_g9777 = clamp( appendResult299_g9777 , temp_output_273_0_g9777.xy , temp_output_271_0_g9777.xy );
			float2 TRUNK_SWIRL700_g9776 = ( clampResult26_g9777 * temp_output_524_0_g9776 );
			float2 break699_g9776 = TRUNK_SWIRL700_g9776;
			float3 appendResult698_g9776 = (float3(break699_g9776.x , 0.0 , break699_g9776.y));
			float3 temp_output_694_0_g9776 = ( ( mul( float3x3(appendResult83_g9791, appendResult81_g9791, appendResult82_g9791), temp_output_38_0_g9791 ) - temp_output_38_0_g9791 ) + ( _WIND_PRIMARY_ROLL669_g9776 * appendResult698_g9776 * 0.5 ) );
			float temp_output_1072_498_g9657 = _WIND_GUST_AMPLITUDE;
			float temp_output_641_0_g9853 = temp_output_1072_498_g9657;
			float lerpResult635_g9853 = lerp( temp_output_641_0_g9853 , _WIND_GUST_AUDIO_STRENGTH_LOW , _WIND_AUDIO_INFLUENCE);
			float4 color658_g9826 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float2 temp_output_61_0_g9832 = float2( 0,0 );
			half localunity_ObjectToWorld0w1_g9668 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g9668 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g9668 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g9668 = (float3(localunity_ObjectToWorld0w1_g9668 , localunity_ObjectToWorld1w2_g9668 , localunity_ObjectToWorld2w3_g9668));
			float3 temp_output_1072_510_g9657 = appendResult6_g9668;
			float2 temp_output_1_0_g9838 = temp_output_1072_510_g9657.xy;
			float temp_output_2_0_g9839 = _WIND_GUST_TRUNK_FIELD_SIZE;
			float temp_output_40_0_g9832 = ( 1.0 / (( temp_output_2_0_g9839 == 0.0 ) ? 1.0 :  temp_output_2_0_g9839 ) );
			float2 temp_cast_7 = (temp_output_40_0_g9832).xx;
			float2 temp_output_2_0_g9838 = temp_cast_7;
			float temp_output_2_0_g9828 = _WIND_GUST_TRUNK_CYCLE_TIME;
			float mulTime37_g9832 = _Time.y * ( 1.0 / (( temp_output_2_0_g9828 == 0.0 ) ? 1.0 :  temp_output_2_0_g9828 ) );
			float temp_output_220_0_g9833 = -1.0;
			float4 temp_cast_8 = (temp_output_220_0_g9833).xxxx;
			float temp_output_219_0_g9833 = 1.0;
			float4 temp_cast_9 = (temp_output_219_0_g9833).xxxx;
			float4 clampResult26_g9833 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g9832 > float2( 0,0 ) ) ? ( temp_output_1_0_g9838 / temp_output_2_0_g9838 ) :  ( temp_output_1_0_g9838 * temp_output_2_0_g9838 ) ) + temp_output_61_0_g9832 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g9832 ) ) , temp_cast_8 , temp_cast_9 );
			float4 temp_cast_10 = (temp_output_220_0_g9833).xxxx;
			float4 temp_cast_11 = (temp_output_219_0_g9833).xxxx;
			float4 temp_cast_12 = (0.0).xxxx;
			float4 temp_cast_13 = (temp_output_219_0_g9833).xxxx;
			float temp_output_1072_526_g9657 = _WIND_GUST_CONTRAST;
			float4 temp_cast_14 = (temp_output_1072_526_g9657).xxxx;
			float4 temp_output_52_0_g9832 = saturate( pow( abs( (temp_cast_12 + (clampResult26_g9833 - temp_cast_10) * (temp_cast_13 - temp_cast_12) / (temp_cast_11 - temp_cast_10)) ) , temp_cast_14 ) );
			float temp_output_679_0_g9826 = 1.0;
			float4 lerpResult656_g9826 = lerp( color658_g9826 , temp_output_52_0_g9832 , temp_output_679_0_g9826);
			float4 break1078_g9657 = ( (lerpResult635_g9853).xxxx * lerpResult656_g9826 );
			float temp_output_15_0_g9843 = break1078_g9657.x;
			float temp_output_16_0_g9843 = break1078_g9657.w;
			float _WIND_GUST_STRENGTH703_g9776 = ( ( temp_output_15_0_g9843 + temp_output_16_0_g9843 ) / 2.0 );
			float temp_output_1049_497_g9657 = v.texcoord1.w;
			float _WIND_PRIMARY_BEND662_g9776 = temp_output_1049_497_g9657;
			float temp_output_54_0_g9782 = ( ( _WIND_GUST_STRENGTH703_g9776 * -1.0 ) * _WIND_PRIMARY_BEND662_g9776 * 0.5 );
			float temp_output_72_0_g9782 = cos( temp_output_54_0_g9782 );
			float one_minus_c52_g9782 = ( 1.0 - temp_output_72_0_g9782 );
			float3 temp_output_1062_494_g9657 = _WIND_DIRECTION;
			float3 _WIND_DIRECTION671_g9776 = temp_output_1062_494_g9657;
			float3 worldToObjDir719_g9776 = mul( unity_WorldToObject, float4( cross( _WIND_DIRECTION671_g9776 , float3(0,1,0) ), 0 ) ).xyz;
			float3 break70_g9782 = worldToObjDir719_g9776;
			float axis_x25_g9782 = break70_g9782.x;
			float c66_g9782 = temp_output_72_0_g9782;
			float axis_y37_g9782 = break70_g9782.y;
			float axis_z29_g9782 = break70_g9782.z;
			float s67_g9782 = sin( temp_output_54_0_g9782 );
			float3 appendResult83_g9782 = (float3(( ( one_minus_c52_g9782 * axis_x25_g9782 * axis_x25_g9782 ) + c66_g9782 ) , ( ( one_minus_c52_g9782 * axis_x25_g9782 * axis_y37_g9782 ) - ( axis_z29_g9782 * s67_g9782 ) ) , ( ( one_minus_c52_g9782 * axis_z29_g9782 * axis_x25_g9782 ) + ( axis_y37_g9782 * s67_g9782 ) )));
			float3 appendResult81_g9782 = (float3(( ( one_minus_c52_g9782 * axis_x25_g9782 * axis_y37_g9782 ) + ( axis_z29_g9782 * s67_g9782 ) ) , ( ( one_minus_c52_g9782 * axis_y37_g9782 * axis_y37_g9782 ) + c66_g9782 ) , ( ( one_minus_c52_g9782 * axis_y37_g9782 * axis_z29_g9782 ) - ( axis_x25_g9782 * s67_g9782 ) )));
			float3 appendResult82_g9782 = (float3(( ( one_minus_c52_g9782 * axis_z29_g9782 * axis_x25_g9782 ) - ( axis_y37_g9782 * s67_g9782 ) ) , ( ( one_minus_c52_g9782 * axis_y37_g9782 * axis_z29_g9782 ) + ( axis_x25_g9782 * s67_g9782 ) ) , ( ( one_minus_c52_g9782 * axis_z29_g9782 * axis_z29_g9782 ) + c66_g9782 )));
			float3 temp_output_38_0_g9782 = ( ase_vertex3Pos - (_WIND_PRIMARY_PIVOT655_g9776).xyz );
			float temp_output_641_0_g9808 = temp_output_1072_498_g9657;
			float lerpResult635_g9808 = lerp( temp_output_641_0_g9808 , _WIND_GUST_AUDIO_STRENGTH_LOW , _WIND_AUDIO_INFLUENCE);
			float smoothstepResult551_g9776 = smoothstep( 0.0 , 1.0 , lerpResult635_g9808);
			float3 lerpResult538_g9776 = lerp( temp_output_694_0_g9776 , ( temp_output_694_0_g9776 + ( mul( float3x3(appendResult83_g9782, appendResult81_g9782, appendResult82_g9782), temp_output_38_0_g9782 ) - temp_output_38_0_g9782 ) ) , smoothstepResult551_g9776);
			float3 _WIND_POSITION_ROOT1002_g9678 = temp_output_1062_510_g9657;
			float2 temp_output_1_0_g9679 = (_WIND_POSITION_ROOT1002_g9678).xz;
			float _WIND_BASE_BRANCH_FIELD_SIZE1004_g9678 = _WIND_BASE_BRANCH_FIELD_SIZE;
			float temp_output_2_0_g9681 = _WIND_BASE_BRANCH_FIELD_SIZE1004_g9678;
			float2 temp_cast_16 = (( 1.0 / (( temp_output_2_0_g9681 == 0.0 ) ? 1.0 :  temp_output_2_0_g9681 ) )).xx;
			float2 temp_output_2_0_g9679 = temp_cast_16;
			float temp_output_1049_552_g9657 = v.color.a;
			float _WIND_PHASE852_g9678 = temp_output_1049_552_g9657;
			float _WIND_BASE_BRANCH_VARIATION_STRENGTH1006_g9678 = _WIND_BASE_BRANCH_VARIATION_STRENGTH;
			float2 temp_cast_17 = (( ( _WIND_PHASE852_g9678 * _WIND_BASE_BRANCH_VARIATION_STRENGTH1006_g9678 ) * UNITY_PI )).xx;
			float temp_output_2_0_g9845 = _WIND_BASE_BRANCH_CYCLE_TIME;
			float2 break298_g9685 = ( ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g9679 / temp_output_2_0_g9679 ) :  ( temp_output_1_0_g9679 * temp_output_2_0_g9679 ) ) + temp_cast_17 ) + ( ( ( 1.0 / (( temp_output_2_0_g9845 == 0.0 ) ? 1.0 :  temp_output_2_0_g9845 ) ) * _WIND_PHASE852_g9678 ) * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g9685 = (float2(sin( break298_g9685.x ) , cos( break298_g9685.y )));
			float4 temp_output_273_0_g9685 = (-1.0).xxxx;
			float4 temp_output_271_0_g9685 = (1.0).xxxx;
			float2 clampResult26_g9685 = clamp( appendResult299_g9685 , temp_output_273_0_g9685.xy , temp_output_271_0_g9685.xy );
			float2 BRANCH_SWIRL931_g9678 = ( clampResult26_g9685 * ( temp_output_1062_495_g9657 * temp_output_1062_501_g9657 ) );
			float2 break932_g9678 = BRANCH_SWIRL931_g9678;
			float3 appendResult933_g9678 = (float3(break932_g9678.x , 0.0 , break932_g9678.y));
			float _WIND_SECONDARY_ROLL650_g9678 = v.color.g;
			float3 VALUE_ROLL1034_g9678 = ( appendResult933_g9678 * _WIND_SECONDARY_ROLL650_g9678 * 0.5 );
			float3 _WIND_DIRECTION856_g9678 = temp_output_1062_494_g9657;
			float3 temp_output_839_0_g9678 = (v.texcoord2).xyz;
			float3 _WIND_SECONDARY_GROWTH_DIRECTION = float3(0,1,0);
			float3 _WIND_SECONDARY_GROWTH_DIRECTION840_g9678 = (( length( temp_output_839_0_g9678 ) == 0.0 ) ? _WIND_SECONDARY_GROWTH_DIRECTION :  temp_output_839_0_g9678 );
			float3 objToWorldDir1174_g9678 = mul( unity_ObjectToWorld, float4( _WIND_SECONDARY_GROWTH_DIRECTION840_g9678, 0 ) ).xyz;
			float dotResult565_g9678 = dot( _WIND_DIRECTION856_g9678 , (objToWorldDir1174_g9678).xyz );
			float clampResult13_g9706 = clamp( dotResult565_g9678 , -1.0 , 1.0 );
			float4 color658_g9809 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float2 temp_output_61_0_g9815 = float2( 0,0 );
			float3 temp_output_1049_498_g9657 = (v.texcoord3).xyz;
			float2 temp_output_1_0_g9821 = ( temp_output_1072_510_g9657 + temp_output_1049_498_g9657 + temp_output_1049_552_g9657 ).xy;
			float temp_output_1065_571_g9657 = _WIND_GUST_BRANCH_FIELD_SIZE;
			float temp_output_2_0_g9822 = temp_output_1065_571_g9657;
			float temp_output_40_0_g9815 = ( 1.0 / (( temp_output_2_0_g9822 == 0.0 ) ? 1.0 :  temp_output_2_0_g9822 ) );
			float2 temp_cast_21 = (temp_output_40_0_g9815).xx;
			float2 temp_output_2_0_g9821 = temp_cast_21;
			float temp_output_2_0_g9811 = _WIND_GUST_BRANCH_CYCLE_TIME;
			float mulTime37_g9815 = _Time.y * ( 1.0 / (( temp_output_2_0_g9811 == 0.0 ) ? 1.0 :  temp_output_2_0_g9811 ) );
			float temp_output_220_0_g9816 = -1.0;
			float4 temp_cast_22 = (temp_output_220_0_g9816).xxxx;
			float temp_output_219_0_g9816 = 1.0;
			float4 temp_cast_23 = (temp_output_219_0_g9816).xxxx;
			float4 clampResult26_g9816 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g9815 > float2( 0,0 ) ) ? ( temp_output_1_0_g9821 / temp_output_2_0_g9821 ) :  ( temp_output_1_0_g9821 * temp_output_2_0_g9821 ) ) + temp_output_61_0_g9815 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g9815 ) ) , temp_cast_22 , temp_cast_23 );
			float4 temp_cast_24 = (temp_output_220_0_g9816).xxxx;
			float4 temp_cast_25 = (temp_output_219_0_g9816).xxxx;
			float4 temp_cast_26 = (0.0).xxxx;
			float4 temp_cast_27 = (temp_output_219_0_g9816).xxxx;
			float4 temp_cast_28 = (temp_output_1072_526_g9657).xxxx;
			float4 temp_output_52_0_g9815 = saturate( pow( abs( (temp_cast_26 + (clampResult26_g9816 - temp_cast_24) * (temp_cast_27 - temp_cast_26) / (temp_cast_25 - temp_cast_24)) ) , temp_cast_28 ) );
			float temp_output_679_0_g9809 = 1.0;
			float4 lerpResult656_g9809 = lerp( color658_g9809 , temp_output_52_0_g9815 , temp_output_679_0_g9809);
			float lerpResult634_g9853 = lerp( temp_output_641_0_g9853 , _WIND_GUST_AUDIO_STRENGTH_MID , _WIND_AUDIO_INFLUENCE);
			float4 break1075_g9657 = ( lerpResult656_g9809 * (lerpResult634_g9853).xxxx );
			float _WIND_GUST_STRENGTH_A871_g9678 = break1075_g9657.r;
			float temp_output_1049_499_g9657 = v.texcoord3.w;
			float _WIND_SECONDARY_BEND849_g9678 = temp_output_1049_499_g9657;
			float clampResult1170_g9678 = clamp( _WIND_SECONDARY_BEND849_g9678 , 0.0 , 0.75 );
			float temp_output_54_0_g9705 = ( ( _WIND_GUST_STRENGTH_A871_g9678 * -1.0 ) * clampResult1170_g9678 );
			float temp_output_72_0_g9705 = cos( temp_output_54_0_g9705 );
			float one_minus_c52_g9705 = ( 1.0 - temp_output_72_0_g9705 );
			float3 worldToObjDir1173_g9678 = mul( unity_WorldToObject, float4( cross( _WIND_DIRECTION856_g9678 , float3(0,1,0) ), 0 ) ).xyz;
			float3 break70_g9705 = worldToObjDir1173_g9678;
			float axis_x25_g9705 = break70_g9705.x;
			float c66_g9705 = temp_output_72_0_g9705;
			float axis_y37_g9705 = break70_g9705.y;
			float axis_z29_g9705 = break70_g9705.z;
			float s67_g9705 = sin( temp_output_54_0_g9705 );
			float3 appendResult83_g9705 = (float3(( ( one_minus_c52_g9705 * axis_x25_g9705 * axis_x25_g9705 ) + c66_g9705 ) , ( ( one_minus_c52_g9705 * axis_x25_g9705 * axis_y37_g9705 ) - ( axis_z29_g9705 * s67_g9705 ) ) , ( ( one_minus_c52_g9705 * axis_z29_g9705 * axis_x25_g9705 ) + ( axis_y37_g9705 * s67_g9705 ) )));
			float3 appendResult81_g9705 = (float3(( ( one_minus_c52_g9705 * axis_x25_g9705 * axis_y37_g9705 ) + ( axis_z29_g9705 * s67_g9705 ) ) , ( ( one_minus_c52_g9705 * axis_y37_g9705 * axis_y37_g9705 ) + c66_g9705 ) , ( ( one_minus_c52_g9705 * axis_y37_g9705 * axis_z29_g9705 ) - ( axis_x25_g9705 * s67_g9705 ) )));
			float3 appendResult82_g9705 = (float3(( ( one_minus_c52_g9705 * axis_z29_g9705 * axis_x25_g9705 ) - ( axis_y37_g9705 * s67_g9705 ) ) , ( ( one_minus_c52_g9705 * axis_y37_g9705 * axis_z29_g9705 ) + ( axis_x25_g9705 * s67_g9705 ) ) , ( ( one_minus_c52_g9705 * axis_z29_g9705 * axis_z29_g9705 ) + c66_g9705 )));
			float3 _WIND_SECONDARY_PIVOT846_g9678 = temp_output_1049_498_g9657;
			float3 temp_output_38_0_g9705 = ( ase_vertex3Pos - (_WIND_SECONDARY_PIVOT846_g9678).xyz );
			float3 VALUE_FACING_WIND1042_g9678 = ( mul( float3x3(appendResult83_g9705, appendResult81_g9705, appendResult82_g9705), temp_output_38_0_g9705 ) - temp_output_38_0_g9705 );
			float2 temp_output_1_0_g9695 = (_WIND_SECONDARY_PIVOT846_g9678).xz;
			float _WIND_GUST_BRANCH_FIELD_SIZE1011_g9678 = temp_output_1065_571_g9657;
			float temp_output_2_0_g9696 = _WIND_GUST_BRANCH_FIELD_SIZE1011_g9678;
			float2 temp_cast_30 = (( 1.0 / (( temp_output_2_0_g9696 == 0.0 ) ? 1.0 :  temp_output_2_0_g9696 ) )).xx;
			float2 temp_output_2_0_g9695 = temp_cast_30;
			float _WIND_GUST_BRANCH_VARIATION_STRENGTH1008_g9678 = _WIND_GUST_BRANCH_VARIATION_STRENGTH;
			float2 temp_cast_31 = (( ( _WIND_PHASE852_g9678 * _WIND_GUST_BRANCH_VARIATION_STRENGTH1008_g9678 ) * UNITY_PI )).xx;
			float temp_output_2_0_g9849 = _WIND_GUST_BRANCH_CYCLE_TIME;
			float _WIND_GUST_BRANCH_FREQUENCY1012_g9678 = ( 1.0 / (( temp_output_2_0_g9849 == 0.0 ) ? 1.0 :  temp_output_2_0_g9849 ) );
			float2 break298_g9691 = ( ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g9695 / temp_output_2_0_g9695 ) :  ( temp_output_1_0_g9695 * temp_output_2_0_g9695 ) ) + temp_cast_31 ) + ( _WIND_GUST_BRANCH_FREQUENCY1012_g9678 * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g9691 = (float2(sin( break298_g9691.x ) , cos( break298_g9691.y )));
			float4 temp_output_273_0_g9691 = (-1.0).xxxx;
			float4 temp_output_271_0_g9691 = (1.0).xxxx;
			float2 clampResult26_g9691 = clamp( appendResult299_g9691 , temp_output_273_0_g9691.xy , temp_output_271_0_g9691.xy );
			float2 break305_g9691 = float2( -0.25,1 );
			float _WIND_GUST_STRENGTH_B999_g9678 = break1075_g9657.b;
			float2 break1067_g9678 = ( ( ((break305_g9691.x).xxxx.xy + (clampResult26_g9691 - temp_output_273_0_g9691.xy) * ((break305_g9691.y).xxxx.xy - (break305_g9691.x).xxxx.xy) / (temp_output_271_0_g9691.xy - temp_output_273_0_g9691.xy)) * saturate( _WIND_GUST_STRENGTH_B999_g9678 ) ) * _WIND_SECONDARY_ROLL650_g9678 );
			float3 appendResult1066_g9678 = (float3(break1067_g9678.x , 0.0 , break1067_g9678.y));
			float3 worldToObjDir1089_g9678 = normalize( mul( unity_WorldToObject, float4( _WIND_DIRECTION856_g9678, 0 ) ).xyz );
			float3 BRANCH_SWIRL972_g9678 = ( appendResult1066_g9678 * worldToObjDir1089_g9678 );
			float3 VALUE_PERPENDICULAR1041_g9678 = BRANCH_SWIRL972_g9678;
			float3 temp_output_3_0_g9706 = VALUE_PERPENDICULAR1041_g9678;
			float3 lerpResult2_g9706 = lerp( VALUE_FACING_WIND1042_g9678 , temp_output_3_0_g9706 , ( 1.0 + clampResult13_g9706 ));
			float _WIND_GUST_STRENGTH_C1110_g9678 = break1075_g9657.a;
			float clampResult3_g9700 = clamp( _WIND_GUST_STRENGTH_C1110_g9678 , 0.0 , 1.0 );
			float temp_output_15_0_g9702 = _WIND_PHASE852_g9678;
			float temp_output_16_0_g9702 = ( _WIND_GUST_BRANCH_VARIATION_STRENGTH1008_g9678 / 100.0 );
			float mulTime1151_g9678 = _Time.y * _WIND_PHASE852_g9678;
			float clampResult8_g9689 = clamp( sin( mulTime1151_g9678 ) , -1.0 , 1.0 );
			float clampResult1167_g9678 = clamp( ( ( ( clampResult3_g9700 * 2.0 ) - 1.0 ) * _WIND_SECONDARY_BEND849_g9678 * ( ( ( temp_output_15_0_g9702 + temp_output_16_0_g9702 ) / 2.0 ) * ( ( clampResult8_g9689 * 0.5 ) + 0.5 ) ) ) , -2.0 , 2.0 );
			float temp_output_54_0_g9703 = clampResult1167_g9678;
			float temp_output_72_0_g9703 = cos( temp_output_54_0_g9703 );
			float one_minus_c52_g9703 = ( 1.0 - temp_output_72_0_g9703 );
			float3 break70_g9703 = float3(0,1,0);
			float axis_x25_g9703 = break70_g9703.x;
			float c66_g9703 = temp_output_72_0_g9703;
			float axis_y37_g9703 = break70_g9703.y;
			float axis_z29_g9703 = break70_g9703.z;
			float s67_g9703 = sin( temp_output_54_0_g9703 );
			float3 appendResult83_g9703 = (float3(( ( one_minus_c52_g9703 * axis_x25_g9703 * axis_x25_g9703 ) + c66_g9703 ) , ( ( one_minus_c52_g9703 * axis_x25_g9703 * axis_y37_g9703 ) - ( axis_z29_g9703 * s67_g9703 ) ) , ( ( one_minus_c52_g9703 * axis_z29_g9703 * axis_x25_g9703 ) + ( axis_y37_g9703 * s67_g9703 ) )));
			float3 appendResult81_g9703 = (float3(( ( one_minus_c52_g9703 * axis_x25_g9703 * axis_y37_g9703 ) + ( axis_z29_g9703 * s67_g9703 ) ) , ( ( one_minus_c52_g9703 * axis_y37_g9703 * axis_y37_g9703 ) + c66_g9703 ) , ( ( one_minus_c52_g9703 * axis_y37_g9703 * axis_z29_g9703 ) - ( axis_x25_g9703 * s67_g9703 ) )));
			float3 appendResult82_g9703 = (float3(( ( one_minus_c52_g9703 * axis_z29_g9703 * axis_x25_g9703 ) - ( axis_y37_g9703 * s67_g9703 ) ) , ( ( one_minus_c52_g9703 * axis_y37_g9703 * axis_z29_g9703 ) + ( axis_x25_g9703 * s67_g9703 ) ) , ( ( one_minus_c52_g9703 * axis_z29_g9703 * axis_z29_g9703 ) + c66_g9703 )));
			float3 temp_output_38_0_g9703 = ( ase_vertex3Pos - (_WIND_SECONDARY_PIVOT846_g9678).xyz );
			float3 VALUE_AWAY_FROM_WIND1040_g9678 = ( mul( float3x3(appendResult83_g9703, appendResult81_g9703, appendResult82_g9703), temp_output_38_0_g9703 ) - temp_output_38_0_g9703 );
			float3 lerpResult5_g9706 = lerp( temp_output_3_0_g9706 , VALUE_AWAY_FROM_WIND1040_g9678 , clampResult13_g9706);
			float lerpResult634_g9808 = lerp( temp_output_641_0_g9808 , _WIND_GUST_AUDIO_STRENGTH_MID , _WIND_AUDIO_INFLUENCE);
			float smoothstepResult636_g9678 = smoothstep( 0.0 , 1.0 , lerpResult634_g9808);
			float3 lerpResult631_g9678 = lerp( VALUE_ROLL1034_g9678 , (( clampResult13_g9706 < 0.0 ) ? lerpResult2_g9706 :  lerpResult5_g9706 ) , smoothstepResult636_g9678);
			float temp_output_17_0_g9730 = 3.0;
			float temp_output_18_0_g9730 = round( v.texcoord2.w );
			float temp_output_1049_550_g9657 = v.color.b;
			float _WIND_TERTIARY_ROLL669_g9794 = temp_output_1049_550_g9657;
			float3 temp_output_615_0_g9774 = ( float3( 0,0,0 ) + ase_vertex3Pos );
			float2 temp_output_1_0_g9795 = (temp_output_615_0_g9774).xz;
			float2 temp_output_2_0_g9795 = (_WIND_BASE_LEAF_FIELD_SIZE).xxxx.xy;
			float _WIND_VARIATION662_g9794 = temp_output_1049_552_g9657;
			float2 temp_output_704_0_g9794 = ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g9795 / temp_output_2_0_g9795 ) :  ( temp_output_1_0_g9795 * temp_output_2_0_g9795 ) ) + (_WIND_VARIATION662_g9794).xx );
			float temp_output_2_0_g9717 = _WIND_BASE_LEAF_CYCLE_TIME;
			float temp_output_618_0_g9794 = ( 1.0 / (( temp_output_2_0_g9717 == 0.0 ) ? 1.0 :  temp_output_2_0_g9717 ) );
			float2 break298_g9804 = ( temp_output_704_0_g9794 + ( temp_output_618_0_g9794 * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g9804 = (float2(sin( break298_g9804.x ) , cos( break298_g9804.y )));
			float4 temp_output_273_0_g9804 = (-1.0).xxxx;
			float4 temp_output_271_0_g9804 = (1.0).xxxx;
			float2 clampResult26_g9804 = clamp( appendResult299_g9804 , temp_output_273_0_g9804.xy , temp_output_271_0_g9804.xy );
			float temp_output_524_0_g9794 = ( temp_output_1062_495_g9657 * temp_output_1062_501_g9657 );
			float2 break699_g9794 = ( clampResult26_g9804 * temp_output_524_0_g9794 );
			float2 break298_g9796 = ( temp_output_704_0_g9794 + ( ( 0.71 * temp_output_618_0_g9794 ) * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g9796 = (float2(sin( break298_g9796.x ) , cos( break298_g9796.y )));
			float4 temp_output_273_0_g9796 = (-1.0).xxxx;
			float4 temp_output_271_0_g9796 = (1.0).xxxx;
			float2 clampResult26_g9796 = clamp( appendResult299_g9796 , temp_output_273_0_g9796.xy , temp_output_271_0_g9796.xy );
			float3 appendResult698_g9794 = (float3(break699_g9794.x , ( clampResult26_g9796 * temp_output_524_0_g9794 ).x , break699_g9794.y));
			float3 temp_output_684_0_g9794 = ( _WIND_TERTIARY_ROLL669_g9794 * appendResult698_g9794 );
			float3 _WIND_DIRECTION671_g9794 = temp_output_1062_494_g9657;
			float3 worldToObjDir1006_g9794 = mul( unity_WorldToObject, float4( _WIND_DIRECTION671_g9794, 0 ) ).xyz;
			float lerpResult633_g9808 = lerp( temp_output_641_0_g9808 , _WIND_GUST_AUDIO_STRENGTH_HIGH , _WIND_AUDIO_INFLUENCE);
			float temp_output_1173_627_g9657 = lerpResult633_g9808;
			float4 color658_g9733 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float2 temp_output_61_0_g9742 = float2( 0,0 );
			float temp_output_1049_551_g9657 = v.texcoord.w;
			float2 uv_TexCoord1118_g9657 = v.texcoord.xy + (temp_output_1049_551_g9657).xx;
			float2 temp_output_1_0_g9743 = uv_TexCoord1118_g9657;
			float temp_output_2_0_g9761 = _WIND_GUST_LEAF_FIELD_SIZE;
			float temp_output_40_0_g9742 = ( 1.0 / (( temp_output_2_0_g9761 == 0.0 ) ? 1.0 :  temp_output_2_0_g9761 ) );
			float2 temp_cast_45 = (temp_output_40_0_g9742).xx;
			float2 temp_output_2_0_g9743 = temp_cast_45;
			float4 break96_g9742 = ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g9742 > float2( 0,0 ) ) ? ( temp_output_1_0_g9743 / temp_output_2_0_g9743 ) :  ( temp_output_1_0_g9743 * temp_output_2_0_g9743 ) ) + temp_output_61_0_g9742 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) );
			float temp_output_1159_0_g9657 = ( _WIND_GUST_LEAF_CYCLE_TIME + ( temp_output_1049_551_g9657 * 0.15 ) );
			float temp_output_2_0_g9765 = temp_output_1159_0_g9657;
			float mulTime37_g9742 = _Time.y * ( 1.0 / (( temp_output_2_0_g9765 == 0.0 ) ? 1.0 :  temp_output_2_0_g9765 ) );
			float temp_output_220_0_g9745 = -1.0;
			float temp_output_219_0_g9745 = 1.0;
			float clampResult26_g9745 = clamp( sin( ( break96_g9742.r + mulTime37_g9742 ) ) , temp_output_220_0_g9745 , temp_output_219_0_g9745 );
			float temp_output_52_0_g9742 = saturate( pow( abs( (0.0 + (clampResult26_g9745 - temp_output_220_0_g9745) * (temp_output_219_0_g9745 - 0.0) / (temp_output_219_0_g9745 - temp_output_220_0_g9745)) ) , _WIND_GUST_CONTRAST ) );
			float temp_output_2_0_g9769 = ( temp_output_1159_0_g9657 * 1.23 );
			float mulTime97_g9742 = _Time.y * ( 1.0 / (( temp_output_2_0_g9769 == 0.0 ) ? 1.0 :  temp_output_2_0_g9769 ) );
			float temp_output_220_0_g9757 = -1.0;
			float temp_output_219_0_g9757 = 1.0;
			float clampResult26_g9757 = clamp( sin( ( break96_g9742.g + mulTime97_g9742 ) ) , temp_output_220_0_g9757 , temp_output_219_0_g9757 );
			float temp_output_693_0_g9733 = 1.0;
			float temp_output_114_0_g9742 = saturate( pow( abs( (0.0 + (clampResult26_g9757 - temp_output_220_0_g9757) * (temp_output_219_0_g9757 - 0.0) / (temp_output_219_0_g9757 - temp_output_220_0_g9757)) ) , temp_output_693_0_g9733 ) );
			float temp_output_2_0_g9738 = ( temp_output_1159_0_g9657 * 0.52 );
			float mulTime102_g9742 = _Time.y * ( 1.0 / (( temp_output_2_0_g9738 == 0.0 ) ? 1.0 :  temp_output_2_0_g9738 ) );
			float temp_output_220_0_g9749 = -1.0;
			float temp_output_219_0_g9749 = 1.0;
			float clampResult26_g9749 = clamp( sin( ( break96_g9742.b + mulTime102_g9742 ) ) , temp_output_220_0_g9749 , temp_output_219_0_g9749 );
			float temp_output_119_0_g9742 = saturate( pow( abs( (0.0 + (clampResult26_g9749 - temp_output_220_0_g9749) * (temp_output_219_0_g9749 - 0.0) / (temp_output_219_0_g9749 - temp_output_220_0_g9749)) ) , temp_output_693_0_g9733 ) );
			float temp_output_2_0_g9734 = ( temp_output_1159_0_g9657 * 0.47 );
			float mulTime106_g9742 = _Time.y * ( 1.0 / (( temp_output_2_0_g9734 == 0.0 ) ? 1.0 :  temp_output_2_0_g9734 ) );
			float temp_output_220_0_g9753 = -1.0;
			float temp_output_219_0_g9753 = 1.0;
			float clampResult26_g9753 = clamp( sin( ( break96_g9742.a + mulTime106_g9742 ) ) , temp_output_220_0_g9753 , temp_output_219_0_g9753 );
			float temp_output_124_0_g9742 = saturate( pow( abs( (0.0 + (clampResult26_g9753 - temp_output_220_0_g9753) * (temp_output_219_0_g9753 - 0.0) / (temp_output_219_0_g9753 - temp_output_220_0_g9753)) ) , temp_output_693_0_g9733 ) );
			float4 appendResult125_g9742 = (float4(temp_output_52_0_g9742 , temp_output_114_0_g9742 , temp_output_119_0_g9742 , temp_output_124_0_g9742));
			float4 lerpResult656_g9733 = lerp( color658_g9733 , appendResult125_g9742 , temp_output_693_0_g9733);
			float4 break1068_g9657 = ( (temp_output_1173_627_g9657).xxxx * lerpResult656_g9733 );
			float _WIND_GUST_STRENGTH_A703_g9794 = break1068_g9657.x;
			float _WIND_GUST_STRENGTH_B829_g9794 = break1068_g9657.y;
			float3 ase_vertexNormal = v.normal.xyz;
			float3 _LEAF_NORMAL992_g9794 = ase_vertexNormal;
			float _WIND_GUST_STRENGTH_C851_g9794 = break1068_g9657.z;
			float clampResult3_g9802 = clamp( _WIND_GUST_STRENGTH_C851_g9794 , 0.0 , 1.0 );
			float _WIND_GUST_STRENGTH_D1004_g9794 = break1068_g9657.w;
			float clampResult3_g9800 = clamp( _WIND_GUST_STRENGTH_D1004_g9794 , 0.0 , 1.0 );
			float smoothstepResult551_g9794 = smoothstep( 0.0 , 1.0 , temp_output_1173_627_g9657);
			float3 lerpResult538_g9794 = lerp( temp_output_684_0_g9794 , ( temp_output_684_0_g9794 + ( ( ( (worldToObjDir1006_g9794).xyz * ( _WIND_GUST_STRENGTH_A703_g9794 + _WIND_GUST_STRENGTH_B829_g9794 ) * 1.25 ) + ( _LEAF_NORMAL992_g9794 * ( ( ( clampResult3_g9802 * 2.0 ) - 1.0 ) + ( ( clampResult3_g9800 * 2.0 ) - 1.0 ) ) * 0.5 ) ) * _WIND_TERTIARY_ROLL669_g9794 ) ) , smoothstepResult551_g9794);
			float3 temp_output_19_0_g9730 = lerpResult538_g9794;
			float3 _Vector3 = float3(0,0,0);
			float3 temp_output_20_0_g9730 = _Vector3;
			float4 break360_g9652 = v.ase_texcoord4;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 temp_output_356_0_g9652 = ( ase_worldPos - (_WorldSpaceCameraPos).xyz );
			float3 normalizeResult358_g9652 = normalize( temp_output_356_0_g9652 );
			float3 cam_pos_axis_z384_g9652 = normalizeResult358_g9652;
			float3 normalizeResult366_g9652 = normalize( cross( float3(0,1,0) , cam_pos_axis_z384_g9652 ) );
			float3 cam_pos_axis_x385_g9652 = normalizeResult366_g9652;
			float4x4 break375_g9652 = UNITY_MATRIX_V;
			float3 appendResult377_g9652 = (float3(break375_g9652[ 0 ][ 0 ] , break375_g9652[ 0 ][ 1 ] , break375_g9652[ 0 ][ 2 ]));
			float3 cam_rot_axis_x378_g9652 = appendResult377_g9652;
			float dotResult436_g9652 = dot( float3(0,1,0) , temp_output_356_0_g9652 );
			float temp_output_438_0_g9652 = saturate( abs( dotResult436_g9652 ) );
			float3 lerpResult424_g9652 = lerp( cam_pos_axis_x385_g9652 , cam_rot_axis_x378_g9652 , temp_output_438_0_g9652);
			float3 xAxis346_g9652 = lerpResult424_g9652;
			float3 cam_pos_axis_y383_g9652 = cross( cam_pos_axis_z384_g9652 , normalizeResult366_g9652 );
			float3 appendResult381_g9652 = (float3(break375_g9652[ 1 ][ 0 ] , break375_g9652[ 1 ][ 1 ] , break375_g9652[ 1 ][ 2 ]));
			float3 cam_rot_axis_y379_g9652 = appendResult381_g9652;
			float3 lerpResult423_g9652 = lerp( cam_pos_axis_y383_g9652 , cam_rot_axis_y379_g9652 , temp_output_438_0_g9652);
			float3 yAxis362_g9652 = lerpResult423_g9652;
			float isBillboard343_g9652 = (( break360_g9652.w < -0.99999 ) ? 1.0 :  0.0 );
			float3 temp_output_41_0_g9867 = ( ( ( _WIND_TRUNK_STRENGTH * lerpResult538_g9776 ) + ( _WIND_BRANCH_STRENGTH * lerpResult631_g9678 ) + ( _WIND_LEAF_STRENGTH * (( temp_output_17_0_g9730 == temp_output_18_0_g9730 ) ? temp_output_19_0_g9730 :  temp_output_20_0_g9730 ) ) ) + ( -( ( break360_g9652.x * xAxis346_g9652 ) + ( break360_g9652.y * yAxis362_g9652 ) ) * isBillboard343_g9652 * -1.0 ) );
			float temp_output_63_0_g9868 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
			float3 lerpResult57_g9868 = lerp( temp_output_41_0_g9867 , -ase_vertex3Pos , ( 1.0 - temp_output_63_0_g9868 ));
			#ifdef INTERNAL_LODFADE_SCALE
				float3 staticSwitch58_g9867 = lerpResult57_g9868;
			#else
				float3 staticSwitch58_g9867 = temp_output_41_0_g9867;
			#endif
			#ifdef LOD_FADE_CROSSFADE
				float3 staticSwitch62_g9867 = staticSwitch58_g9867;
			#else
				float3 staticSwitch62_g9867 = temp_output_41_0_g9867;
			#endif
			v.vertex.xyz += staticSwitch62_g9867;
			float3 appendResult382_g9652 = (float3(break375_g9652[ 2 ][ 0 ] , break375_g9652[ 2 ][ 1 ] , break375_g9652[ 2 ][ 2 ]));
			float3 cam_rot_axis_z380_g9652 = appendResult382_g9652;
			float3 lerpResult422_g9652 = lerp( cam_pos_axis_z384_g9652 , cam_rot_axis_z380_g9652 , temp_output_438_0_g9652);
			float3 zAxis421_g9652 = lerpResult422_g9652;
			float3 lerpResult331_g9652 = lerp( ase_vertexNormal , ( -1.0 * zAxis421_g9652 ) , isBillboard343_g9652);
			float3 normalizeResult326_g9652 = normalize( lerpResult331_g9652 );
			float3 bb_normal2370 = normalizeResult326_g9652;
			v.normal = bb_normal2370;
			float4 ase_vertexTangent = v.tangent;
			float4 appendResult345_g9652 = (float4(xAxis346_g9652 , -1.0));
			float4 lerpResult341_g9652 = lerp( float4( ase_vertexTangent.xyz , 0.0 ) , appendResult345_g9652 , isBillboard343_g9652);
			float4 bb_tangent2371 = lerpResult341_g9652;
			v.tangent = bb_tangent2371;
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			o.screenPosition = ase_screenPos;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Alpha = 1;
			float localMyCustomExpression1981 = ( 0.0 );
			float temp_output_17_0_g9857 = round( i.uv3_tex4coord3.w );
			float temp_output_18_0_g9857 = 3.0;
			float2 uv_MainTex18 = i.uv_texcoord;
			float temp_output_19_0_g9857 = tex2D( _MainTex, uv_MainTex18 ).a;
			float temp_output_20_0_g9857 = 1.0;
			float temp_output_41_0_g9861 = (( temp_output_17_0_g9857 == temp_output_18_0_g9857 ) ? temp_output_19_0_g9857 :  temp_output_20_0_g9857 );
			float4 ase_screenPos = i.screenPosition;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 clipScreen45_g9862 = ase_screenPosNorm.xy * _ScreenParams.xy;
			float dither45_g9862 = Dither8x8Bayer( fmod(clipScreen45_g9862.x, 8), fmod(clipScreen45_g9862.y, 8) );
			float temp_output_56_0_g9862 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
			dither45_g9862 = step( dither45_g9862, temp_output_56_0_g9862 );
			#ifdef INTERNAL_LODFADE_DITHER
				float staticSwitch50_g9861 = ( temp_output_41_0_g9861 * dither45_g9862 );
			#else
				float staticSwitch50_g9861 = temp_output_41_0_g9861;
			#endif
			#ifdef LOD_FADE_CROSSFADE
				float staticSwitch56_g9861 = staticSwitch50_g9861;
			#else
				float staticSwitch56_g9861 = temp_output_41_0_g9861;
			#endif
			float opacity1981 = staticSwitch56_g9861;
			float temp_output_17_0_g9873 = round( i.uv3_tex4coord3.w );
			float temp_output_18_0_g9873 = 3.0;
			float3 ase_worldPos = i.worldPos;
			float temp_output_9_0_g9856 = saturate( ( distance( _WorldSpaceCameraPos , ase_worldPos ) / _CutoffFar ) );
			float lerpResult12_g9856 = lerp( _CutoffLowNear , _CutoffLowFar , temp_output_9_0_g9856);
			float lerpResult11_g9856 = lerp( _CutoffHighNear , _CutoffHighFar , temp_output_9_0_g9856);
			float temp_output_19_0_g9873 = (lerpResult12_g9856 + (i.vertexColor.b - 0.0) * (lerpResult11_g9856 - lerpResult12_g9856) / (1.0 - 0.0));
			float temp_output_20_0_g9873 = 0.0;
			float cutoff1981 = (( temp_output_17_0_g9873 == temp_output_18_0_g9873 ) ? temp_output_19_0_g9873 :  temp_output_20_0_g9873 );
			clip( opacity1981 - cutoff1981 );
			clip( localMyCustomExpression1981 - _cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AppalachiaShaderGUI"
}
/*ASEBEGIN
Version=17500
105.6;-712.8;1281;659;-810.9261;2500.769;2.308267;True;False
Node;AmplifyShaderEditor.RangedFloatNode;862;-1088,-1552;Half;False;Property;_CutoffLowFar;Cutoff Low (Far);5;0;Create;True;3;Off;0;Front;1;Back;2;0;True;0;0.1;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2504;-1551.573,-2842.206;Inherit;False;Constant;_Float0;Float 0;18;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2465;-1102.549,-1952.639;Inherit;False;Mesh Values (Tree) (Complex) (Vertex Colors);-1;;9855;9cacaefc2ecfddf4c8e070f9be99b854;0;0;4;FLOAT;495;FLOAT;501;FLOAT;550;FLOAT;552
Node;AmplifyShaderEditor.RangedFloatNode;1982;-1024,-1408;Half;False;Property;_CutoffHighFar;Cutoff High (Far);6;0;Create;True;3;Off;0;Front;1;Back;2;0;True;0;0.6;0.6;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2124;-1024,-1792;Half;False;Property;_CutoffLowNear;Cutoff Low (Near);2;0;Create;True;3;Off;0;Front;1;Back;2;0;True;0;0.75;0.75;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2501;-1850.38,-2993.366;Inherit;False;Mesh Values (Tree) (Complex) (UV3);-1;;9854;8e1e1d817f2a77d4ea50f9fe634408b6;0;0;2;FLOAT3;500;FLOAT;549
Node;AmplifyShaderEditor.RangedFloatNode;2123;-1088,-1664;Half;False;Property;_CutoffHighNear;Cutoff High (Near);3;0;Create;True;3;Off;0;Front;1;Back;2;0;True;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2502;-1683.792,-2569.16;Inherit;False;const;-1;;9656;5b64729fb717c5f49a1bc2dab81d5e1c;4,21,0,3,1,22,0,28,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;18;-1970.829,-2837.913;Inherit;True;Property;_MainTex;Albedo;7;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;0b3c7a589cd169e43884463565bd36d7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;2428;-1792,-1920;Inherit;False;Pivot Billboard;-1;;9652;50ed44a1d0e6ecb498e997b8969f8558;3,433,2,432,2,431,2;0;3;FLOAT3;370;FLOAT3;369;FLOAT4;371
Node;AmplifyShaderEditor.RangedFloatNode;2126;-960,-1280;Half;False;Property;_CutoffFar;Cutoff Far;4;0;Create;True;3;Off;0;Front;1;Back;2;0;True;0;64;64;64;1024;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2508;-1536,-2304;Inherit;False;Wind (Tree Complex);8;;9657;76dbe6e88a5c02e42a177b05b9981ead;2,981,1,983,1;0;7;FLOAT3;0;FLOAT;1021;FLOAT;1022;FLOAT;1023;FLOAT;1024;FLOAT;1027;FLOAT;1025
Node;AmplifyShaderEditor.FunctionNode;2500;344.0255,-520.6302;Inherit;False;const;-1;;9859;5b64729fb717c5f49a1bc2dab81d5e1c;4,21,0,3,0,22,0,28,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2416;-539.3831,-1642.936;Inherit;False;Cutoff Distance;-1;;9856;5fa78795cf865fc4fba7d47ebe2d2d92;0;6;16;FLOAT;0;False;20;FLOAT;0;False;21;FLOAT;0;False;18;FLOAT;0;False;19;FLOAT;0;False;17;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2499;289.9001,-657.0778;Inherit;False;Constant;_Float0;Float 0;18;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2006;-1082.804,-2121.974;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;2503;-1267.879,-2667.804;Inherit;False;Multi Comparison;-1;;9857;8cbe358a30145e843bfece526f25c2c8;1,4,1;4;17;FLOAT;0;False;18;FLOAT;0;False;19;FLOAT;0;False;20;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2497;5.667406,-749.9389;Inherit;False;Mesh Values (Tree) (Complex) (UV3);-1;;9858;8e1e1d817f2a77d4ea50f9fe634408b6;0;0;2;FLOAT3;500;FLOAT;549
Node;AmplifyShaderEditor.FunctionNode;2498;579.3002,-702.0776;Inherit;False;Multi Comparison;-1;;9873;8cbe358a30145e843bfece526f25c2c8;1,4,1;4;17;FLOAT;0;False;18;FLOAT;0;False;19;FLOAT;0;False;20;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2487;-340.0484,-2118.115;Inherit;False;Execute LOD Fade;-1;;9860;18ea34bd83a0d6c4db425672111543e6;0;2;41;FLOAT;0;False;58;FLOAT3;0,0,0;False;3;FLOAT;0;FLOAT3;91;FLOAT;96
Node;AmplifyShaderEditor.RegisterLocalVarNode;2370;-1408,-1920;Inherit;False;bb_normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2371;-1408,-1792;Inherit;False;bb_tangent;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;1465;2912,-2112;Inherit;False;675.8645;442.9034;DRAWERS;7;2391;2491;2492;2433;2366;1472;1466;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.CustomExpressionNode;1981;894.2627,-958.139;Inherit;False;clip( opacity - cutoff )@;7;False;2;True;opacity;FLOAT;0;In;;Float;False;True;cutoff;FLOAT;0;In;;Float;False;My Custom Expression;False;False;0;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2373;1735.161,-1595.224;Inherit;False;2370;bb_normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;2506;648.404,-985.5981;Inherit;False;const;-1;;9875;5b64729fb717c5f49a1bc2dab81d5e1c;4,21,0,3,1,22,0,28,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2505;644.404,-904.5981;Inherit;False;const;-1;;9874;5b64729fb717c5f49a1bc2dab81d5e1c;4,21,0,3,0,22,0,28,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1466;2944,-1952;Half;False;Property;_RENDERINGG;[ RENDERINGG ];1;0;Create;True;0;0;True;1;InternalCategory(Rendering);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2491;3104,-1760;Half;False;Property;_IsLeaf;Is Leaf;23;2;[HideInInspector];[Toggle];Create;True;2;Off;0;On;1;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2374;1717.849,-1432.677;Inherit;False;2371;bb_tangent;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;1472;2944,-2048;Half;False;Property;_BANNER;BANNER;0;0;Create;True;0;0;True;1;InternalBanner(Internal,Tree Shadows);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2366;2944,-1856;Inherit;False;Internal Features Support;-1;;9876;3c493d142aeebd840af72d626f6915c6;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2492;3264,-1760;Half;False;Property;_IsShadow;Is Shadow;24;2;[HideInInspector];[Toggle];Create;True;2;Off;0;On;1;0;True;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2391;3424,-1760;Inherit;False;Constant;_cutoff;_cutoff;4;1;[HideInInspector];Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2386;562.188,-1734.744;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;2434;1108.586,-1656.849;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2433;2944,-1760;Half;False;Property;_IsBark;Is Bark;22;2;[HideInInspector];[Toggle];Create;True;2;Off;0;On;1;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2623.32,-2094.93;Float;False;True;-1;4;AppalachiaShaderGUI;100;0;Standard;appalachia/tree-shadows_LOD0;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;False;True;False;False;False;True;Off;0;False;925;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;All;12;d3d9;d3d11_9x;d3d11;glcore;gles3;metal;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;550;10;False;553;0;1;False;550;10;False;553;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;100;;-1;-1;-1;-1;0;False;0;0;False;743;-1;0;True;2391;0;0;0;False;0.1;False;-1;0;False;-1;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;14;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT3;0,0,0;False;0
WireConnection;2416;16;2465;550
WireConnection;2416;20;2124;0
WireConnection;2416;21;2123;0
WireConnection;2416;18;862;0
WireConnection;2416;19;1982;0
WireConnection;2416;17;2126;0
WireConnection;2006;0;2508;0
WireConnection;2006;1;2428;370
WireConnection;2503;17;2501;549
WireConnection;2503;18;2504;0
WireConnection;2503;19;18;4
WireConnection;2503;20;2502;0
WireConnection;2498;17;2497;549
WireConnection;2498;18;2499;0
WireConnection;2498;19;2416;0
WireConnection;2498;20;2500;0
WireConnection;2487;41;2503;0
WireConnection;2487;58;2006;0
WireConnection;2370;0;2428;369
WireConnection;2371;0;2428;371
WireConnection;1981;1;2487;0
WireConnection;1981;2;2498;0
WireConnection;2386;0;2487;91
WireConnection;2434;0;1981;0
WireConnection;0;10;2434;0
WireConnection;0;11;2386;0
WireConnection;0;12;2373;0
WireConnection;0;13;2374;0
ASEEND*/
//CHKSM=A20A876EC56C089CE239981542B474C1E9E51496
