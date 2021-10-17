// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "appalachia/fungus-emissive"
{
	Properties
	{
		[InternalBanner(Internal, Plant)]_BANNER("BANNER", Float) = 1
		[InternalCategory(Rendering)]_RENDERINGG("[ RENDERINGG ]", Float) = 0
		[Enum(Two Sided,0,Back,1,Front,2)]_RenderFaces("Render Faces", Float) = 0
		_Cutoff("Cutout", Range( 0 , 1)) = 0.5
		[InternalCategory(Main)]_MAINN("[ MAINN ]", Float) = 0
		_MainTex("Plant Albedo", 2D) = "white" {}
		_EmissionMap1("Plant Emission Map", 2D) = "white" {}
		_Color("Plant Color", Color) = (1,1,1,1)
		_BumpMap("Plant Normal", 2D) = "white" {}
		_NormalScale("Plant Normal Scale", Float) = 1
		_Float6("Plant AO (G)", Range( 0 , 1)) = 1
		_Smoothness("Plant Smoothness (A)", Range( 0 , 1)) = 1
		_MetallicGlossMap("Plant Surface", 2D) = "white" {}
		[InternalCategory(Settings)]_SETTINGS("[ SETTINGS ]", Float) = 0
		_Invisible("Invisible", Range( 0 , 1)) = 0
		[InternalCategory(Advanced)]_ADVANCEDD("[ ADVANCEDD ]", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "DisableBatching" = "True" "IsEmissive" = "true"  }
		LOD 300
		Cull [_RenderFaces]
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 4.0
		#pragma multi_compile_instancing
		 
		// INTERNAL_SHADER_FEATURE_START
		// INTERNAL_SHADER_FEATURE_END
		  
		#pragma exclude_renderers gles vulkan 
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
			half ASEVFace : VFACE;
			float4 screenPosition;
		};

		uniform half _MAINN;
		uniform half _ADVANCEDD;
		uniform half _RENDERINGG;
		uniform half _SETTINGS;
		uniform half _RenderFaces;
		uniform half _Cutoff;
		uniform half _BANNER;
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
		uniform half _WIND_LEAF_STRENGTH;
		uniform half _WIND_BASE_LEAF_FIELD_SIZE;
		uniform half _WIND_BASE_LEAF_CYCLE_TIME;
		uniform half _WIND_GUST_LEAF_FIELD_SIZE;
		uniform half _WIND_GUST_LEAF_CYCLE_TIME;
		uniform half _NormalScale;
		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform half4 _Color;
		uniform sampler2D _EmissionMap1;
		uniform float4 _EmissionMap1_ST;
		uniform float _GLOBAL_SOLAR_TIME;
		uniform sampler2D _MetallicGlossMap;
		uniform float4 _MetallicGlossMap_ST;
		uniform half _Smoothness;
		uniform half _Float6;
		uniform float _Invisible;


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


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			half localunity_ObjectToWorld0w1_g6117 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g6117 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g6117 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g6117 = (float3(localunity_ObjectToWorld0w1_g6117 , localunity_ObjectToWorld1w2_g6117 , localunity_ObjectToWorld2w3_g6117));
			float3 temp_output_1050_510_g6036 = appendResult6_g6117;
			float2 temp_output_1_0_g6071 = (temp_output_1050_510_g6036).xz;
			float temp_output_2_0_g6075 = _WIND_BASE_TRUNK_FIELD_SIZE;
			float2 temp_cast_0 = (( 1.0 / (( temp_output_2_0_g6075 == 0.0 ) ? 1.0 :  temp_output_2_0_g6075 ) )).xx;
			float2 temp_output_2_0_g6071 = temp_cast_0;
			float2 temp_output_704_0_g6064 = ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g6071 / temp_output_2_0_g6071 ) :  ( temp_output_1_0_g6071 * temp_output_2_0_g6071 ) ) + float2( 0,0 ) );
			float temp_output_2_0_g6113 = _WIND_BASE_TRUNK_CYCLE_TIME;
			float temp_output_618_0_g6064 = ( 1.0 / (( temp_output_2_0_g6113 == 0.0 ) ? 1.0 :  temp_output_2_0_g6113 ) );
			float2 break298_g6068 = ( temp_output_704_0_g6064 + ( temp_output_618_0_g6064 * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g6068 = (float2(sin( break298_g6068.x ) , cos( break298_g6068.y )));
			float4 temp_output_273_0_g6068 = (-1.0).xxxx;
			float4 temp_output_271_0_g6068 = (1.0).xxxx;
			float2 clampResult26_g6068 = clamp( appendResult299_g6068 , temp_output_273_0_g6068.xy , temp_output_271_0_g6068.xy );
			float temp_output_1050_495_g6036 = _WIND_BASE_AMPLITUDE;
			float temp_output_1050_501_g6036 = _WIND_BASE_TO_GUST_RATIO;
			float temp_output_524_0_g6064 = ( temp_output_1050_495_g6036 * temp_output_1050_501_g6036 );
			float2 TRUNK_PIVOT_ROCKING701_g6064 = ( clampResult26_g6068 * temp_output_524_0_g6064 );
			float temp_output_1273_495 = v.color.r;
			float _WIND_PRIMARY_ROLL669_g6064 = temp_output_1273_495;
			float temp_output_54_0_g6073 = ( TRUNK_PIVOT_ROCKING701_g6064 * 0.15 * _WIND_PRIMARY_ROLL669_g6064 ).x;
			float temp_output_72_0_g6073 = cos( temp_output_54_0_g6073 );
			float one_minus_c52_g6073 = ( 1.0 - temp_output_72_0_g6073 );
			float3 break70_g6073 = float3(0,1,0);
			float axis_x25_g6073 = break70_g6073.x;
			float c66_g6073 = temp_output_72_0_g6073;
			float axis_y37_g6073 = break70_g6073.y;
			float axis_z29_g6073 = break70_g6073.z;
			float s67_g6073 = sin( temp_output_54_0_g6073 );
			float3 appendResult83_g6073 = (float3(( ( one_minus_c52_g6073 * axis_x25_g6073 * axis_x25_g6073 ) + c66_g6073 ) , ( ( one_minus_c52_g6073 * axis_x25_g6073 * axis_y37_g6073 ) - ( axis_z29_g6073 * s67_g6073 ) ) , ( ( one_minus_c52_g6073 * axis_z29_g6073 * axis_x25_g6073 ) + ( axis_y37_g6073 * s67_g6073 ) )));
			float3 appendResult81_g6073 = (float3(( ( one_minus_c52_g6073 * axis_x25_g6073 * axis_y37_g6073 ) + ( axis_z29_g6073 * s67_g6073 ) ) , ( ( one_minus_c52_g6073 * axis_y37_g6073 * axis_y37_g6073 ) + c66_g6073 ) , ( ( one_minus_c52_g6073 * axis_y37_g6073 * axis_z29_g6073 ) - ( axis_x25_g6073 * s67_g6073 ) )));
			float3 appendResult82_g6073 = (float3(( ( one_minus_c52_g6073 * axis_z29_g6073 * axis_x25_g6073 ) - ( axis_y37_g6073 * s67_g6073 ) ) , ( ( one_minus_c52_g6073 * axis_y37_g6073 * axis_z29_g6073 ) + ( axis_x25_g6073 * s67_g6073 ) ) , ( ( one_minus_c52_g6073 * axis_z29_g6073 * axis_z29_g6073 ) + c66_g6073 )));
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 temp_output_38_0_g6073 = ( ase_vertex3Pos - (float3(0,0,0)).xyz );
			float2 break298_g6065 = ( temp_output_704_0_g6064 + ( temp_output_618_0_g6064 * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g6065 = (float2(sin( break298_g6065.x ) , cos( break298_g6065.y )));
			float4 temp_output_273_0_g6065 = (-1.0).xxxx;
			float4 temp_output_271_0_g6065 = (1.0).xxxx;
			float2 clampResult26_g6065 = clamp( appendResult299_g6065 , temp_output_273_0_g6065.xy , temp_output_271_0_g6065.xy );
			float2 TRUNK_SWIRL700_g6064 = ( clampResult26_g6065 * temp_output_524_0_g6064 );
			float2 break699_g6064 = TRUNK_SWIRL700_g6064;
			float4 appendResult698_g6064 = (float4(break699_g6064.x , 0.0 , break699_g6064.y , 0.0));
			float4 temp_output_694_0_g6064 = ( float4( ( mul( float3x3(appendResult83_g6073, appendResult81_g6073, appendResult82_g6073), temp_output_38_0_g6073 ) - temp_output_38_0_g6073 ) , 0.0 ) + ( _WIND_PRIMARY_ROLL669_g6064 * appendResult698_g6064 ) );
			float4 color658_g6118 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float2 temp_output_61_0_g6128 = float2( 0,0 );
			float2 temp_output_1_0_g6133 = temp_output_1050_510_g6036.xy;
			float temp_output_2_0_g6123 = _WIND_GUST_TRUNK_FIELD_SIZE;
			float temp_output_40_0_g6128 = ( 1.0 / (( temp_output_2_0_g6123 == 0.0 ) ? 1.0 :  temp_output_2_0_g6123 ) );
			float2 temp_cast_9 = (temp_output_40_0_g6128).xx;
			float2 temp_output_2_0_g6133 = temp_cast_9;
			float temp_output_2_0_g6119 = _WIND_GUST_TRUNK_CYCLE_TIME;
			float mulTime37_g6128 = _Time.y * ( 1.0 / (( temp_output_2_0_g6119 == 0.0 ) ? 1.0 :  temp_output_2_0_g6119 ) );
			float temp_output_220_0_g6129 = -1.0;
			float4 temp_cast_10 = (temp_output_220_0_g6129).xxxx;
			float temp_output_219_0_g6129 = 1.0;
			float4 temp_cast_11 = (temp_output_219_0_g6129).xxxx;
			float4 clampResult26_g6129 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g6128 > float2( 0,0 ) ) ? ( temp_output_1_0_g6133 / temp_output_2_0_g6133 ) :  ( temp_output_1_0_g6133 * temp_output_2_0_g6133 ) ) + temp_output_61_0_g6128 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g6128 ) ) , temp_cast_10 , temp_cast_11 );
			float4 temp_cast_12 = (temp_output_220_0_g6129).xxxx;
			float4 temp_cast_13 = (temp_output_219_0_g6129).xxxx;
			float4 temp_cast_14 = (0.0).xxxx;
			float4 temp_cast_15 = (temp_output_219_0_g6129).xxxx;
			float4 temp_cast_16 = (_WIND_GUST_CONTRAST).xxxx;
			float4 temp_output_52_0_g6128 = saturate( pow( abs( (temp_cast_14 + (clampResult26_g6129 - temp_cast_12) * (temp_cast_15 - temp_cast_14) / (temp_cast_13 - temp_cast_12)) ) , temp_cast_16 ) );
			float4 lerpResult656_g6118 = lerp( color658_g6118 , temp_output_52_0_g6128 , _WIND_GUST_TEXTURE_ON);
			float2 weightedBlendVar660_g6118 = (0.5).xx;
			float4 weightedBlend660_g6118 = ( weightedBlendVar660_g6118.x*(_WIND_GUST_AUDIO_STRENGTH).xxxx + weightedBlendVar660_g6118.y*lerpResult656_g6118 );
			float4 break655_g6118 = weightedBlend660_g6118;
			float temp_output_1046_630_g6036 = break655_g6118.x;
			float _WIND_GUST_STRENGTH703_g6064 = temp_output_1046_630_g6036;
			float _WIND_PRIMARY_BEND662_g6064 = temp_output_1273_495;
			float temp_output_54_0_g6074 = ( ( _WIND_GUST_STRENGTH703_g6064 * -1.0 ) * _WIND_PRIMARY_BEND662_g6064 );
			float temp_output_72_0_g6074 = cos( temp_output_54_0_g6074 );
			float one_minus_c52_g6074 = ( 1.0 - temp_output_72_0_g6074 );
			float3 _WIND_DIRECTION671_g6064 = _WIND_DIRECTION;
			float4 transform641_g6064 = mul(unity_WorldToObject,float4( cross( _WIND_DIRECTION671_g6064 , float3(0,1,0) ) , 0.0 ));
			float3 break70_g6074 = transform641_g6064.xyz;
			float axis_x25_g6074 = break70_g6074.x;
			float c66_g6074 = temp_output_72_0_g6074;
			float axis_y37_g6074 = break70_g6074.y;
			float axis_z29_g6074 = break70_g6074.z;
			float s67_g6074 = sin( temp_output_54_0_g6074 );
			float3 appendResult83_g6074 = (float3(( ( one_minus_c52_g6074 * axis_x25_g6074 * axis_x25_g6074 ) + c66_g6074 ) , ( ( one_minus_c52_g6074 * axis_x25_g6074 * axis_y37_g6074 ) - ( axis_z29_g6074 * s67_g6074 ) ) , ( ( one_minus_c52_g6074 * axis_z29_g6074 * axis_x25_g6074 ) + ( axis_y37_g6074 * s67_g6074 ) )));
			float3 appendResult81_g6074 = (float3(( ( one_minus_c52_g6074 * axis_x25_g6074 * axis_y37_g6074 ) + ( axis_z29_g6074 * s67_g6074 ) ) , ( ( one_minus_c52_g6074 * axis_y37_g6074 * axis_y37_g6074 ) + c66_g6074 ) , ( ( one_minus_c52_g6074 * axis_y37_g6074 * axis_z29_g6074 ) - ( axis_x25_g6074 * s67_g6074 ) )));
			float3 appendResult82_g6074 = (float3(( ( one_minus_c52_g6074 * axis_z29_g6074 * axis_x25_g6074 ) - ( axis_y37_g6074 * s67_g6074 ) ) , ( ( one_minus_c52_g6074 * axis_y37_g6074 * axis_z29_g6074 ) + ( axis_x25_g6074 * s67_g6074 ) ) , ( ( one_minus_c52_g6074 * axis_z29_g6074 * axis_z29_g6074 ) + c66_g6074 )));
			float3 temp_output_38_0_g6074 = ( ase_vertex3Pos - (float3(0,0,0)).xyz );
			float temp_output_1050_498_g6036 = _WIND_GUST_AMPLITUDE;
			float smoothstepResult551_g6064 = smoothstep( 0.0 , 1.0 , temp_output_1050_498_g6036);
			float4 lerpResult538_g6064 = lerp( temp_output_694_0_g6064 , ( temp_output_694_0_g6064 + float4( ( mul( float3x3(appendResult83_g6074, appendResult81_g6074, appendResult82_g6074), temp_output_38_0_g6074 ) - temp_output_38_0_g6074 ) , 0.0 ) ) , smoothstepResult551_g6064);
			float3 _WIND_POSITION_ROOT1002_g6079 = temp_output_1050_510_g6036;
			float2 temp_output_1_0_g6091 = (_WIND_POSITION_ROOT1002_g6079).xz;
			float _WIND_BASE_BRANCH_FIELD_SIZE1004_g6079 = _WIND_BASE_BRANCH_FIELD_SIZE;
			float temp_output_2_0_g6087 = _WIND_BASE_BRANCH_FIELD_SIZE1004_g6079;
			float2 temp_cast_21 = (( 1.0 / (( temp_output_2_0_g6087 == 0.0 ) ? 1.0 :  temp_output_2_0_g6087 ) )).xx;
			float2 temp_output_2_0_g6091 = temp_cast_21;
			float _WIND_PHASE852_g6079 = v.color.a;
			float _WIND_BASE_BRANCH_VARIATION_STRENGTH1006_g6079 = _WIND_BASE_BRANCH_VARIATION_STRENGTH;
			float2 temp_cast_22 = (( ( _WIND_PHASE852_g6079 * _WIND_BASE_BRANCH_VARIATION_STRENGTH1006_g6079 ) * UNITY_PI )).xx;
			float temp_output_2_0_g6105 = _WIND_BASE_BRANCH_CYCLE_TIME;
			float _WIND_BASE_FREQUENCY1176_g6079 = ( 1.0 / (( temp_output_2_0_g6105 == 0.0 ) ? 1.0 :  temp_output_2_0_g6105 ) );
			float2 break298_g6080 = ( ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g6091 / temp_output_2_0_g6091 ) :  ( temp_output_1_0_g6091 * temp_output_2_0_g6091 ) ) + temp_cast_22 ) + ( ( _WIND_BASE_FREQUENCY1176_g6079 * _WIND_PHASE852_g6079 ) * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g6080 = (float2(sin( break298_g6080.x ) , cos( break298_g6080.y )));
			float4 temp_output_273_0_g6080 = (-1.0).xxxx;
			float4 temp_output_271_0_g6080 = (1.0).xxxx;
			float2 clampResult26_g6080 = clamp( appendResult299_g6080 , temp_output_273_0_g6080.xy , temp_output_271_0_g6080.xy );
			float _WIND_BASE_AMPLITUDE1174_g6079 = temp_output_1050_495_g6036;
			float _WIND_BASE_TO_GUST_RATIO1175_g6079 = temp_output_1050_501_g6036;
			float2 BRANCH_SWIRL931_g6079 = ( clampResult26_g6080 * ( _WIND_BASE_AMPLITUDE1174_g6079 * _WIND_BASE_TO_GUST_RATIO1175_g6079 ) );
			float2 break932_g6079 = BRANCH_SWIRL931_g6079;
			float4 appendResult933_g6079 = (float4(break932_g6079.x , 0.0 , break932_g6079.y , 0.0));
			float _WIND_SECONDARY_ROLL650_g6079 = v.color.g;
			float4 VALUE_ROLL1034_g6079 = ( appendResult933_g6079 * _WIND_SECONDARY_ROLL650_g6079 );
			float temp_output_2_0_g6083 = _WIND_BASE_TO_GUST_RATIO1175_g6079;
			float _WIND_GUST_STRENGTH1185_g6079 = break655_g6118.w;
			float _WIND_GUST_AMPLITUDE1182_g6079 = temp_output_1050_498_g6036;
			float smoothstepResult636_g6079 = smoothstep( 0.0 , 1.0 , _WIND_GUST_AMPLITUDE1182_g6079);
			float4 lerpResult631_g6079 = lerp( VALUE_ROLL1034_g6079 , ( VALUE_ROLL1034_g6079 * ( 1.0 / (( temp_output_2_0_g6083 == 0.0 ) ? 1.0 :  temp_output_2_0_g6083 ) ) * _WIND_GUST_STRENGTH1185_g6079 ) , smoothstepResult636_g6079);
			float _WIND_TERTIARY_ROLL669_g6037 = v.color.b;
			float2 temp_output_1_0_g6052 = v.texcoord.xy;
			float temp_output_2_0_g6060 = _WIND_BASE_LEAF_FIELD_SIZE;
			float2 temp_output_2_0_g6052 = (( 1.0 / (( temp_output_2_0_g6060 == 0.0 ) ? 1.0 :  temp_output_2_0_g6060 ) )).xxxx.xy;
			float _WIND_VARIATION662_g6037 = v.texcoord.w;
			float2 temp_output_704_0_g6037 = ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g6052 / temp_output_2_0_g6052 ) :  ( temp_output_1_0_g6052 * temp_output_2_0_g6052 ) ) + ( 5.346104 * (_WIND_VARIATION662_g6037).xx ) );
			float temp_output_2_0_g6101 = _WIND_BASE_LEAF_CYCLE_TIME;
			float temp_output_618_0_g6037 = ( 1.0 / (( temp_output_2_0_g6101 == 0.0 ) ? 1.0 :  temp_output_2_0_g6101 ) );
			float2 break298_g6049 = ( temp_output_704_0_g6037 + ( temp_output_618_0_g6037 * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g6049 = (float2(sin( break298_g6049.x ) , cos( break298_g6049.y )));
			float4 temp_output_273_0_g6049 = (-1.0).xxxx;
			float4 temp_output_271_0_g6049 = (1.0).xxxx;
			float2 clampResult26_g6049 = clamp( appendResult299_g6049 , temp_output_273_0_g6049.xy , temp_output_271_0_g6049.xy );
			float temp_output_524_0_g6037 = ( temp_output_1050_495_g6036 * temp_output_1050_501_g6036 );
			float2 break699_g6037 = ( clampResult26_g6049 * temp_output_524_0_g6037 );
			float2 break298_g6041 = ( temp_output_704_0_g6037 + ( ( 0.71 * temp_output_618_0_g6037 ) * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g6041 = (float2(sin( break298_g6041.x ) , cos( break298_g6041.y )));
			float4 temp_output_273_0_g6041 = (-1.0).xxxx;
			float4 temp_output_271_0_g6041 = (1.0).xxxx;
			float2 clampResult26_g6041 = clamp( appendResult299_g6041 , temp_output_273_0_g6041.xy , temp_output_271_0_g6041.xy );
			float4 appendResult698_g6037 = (float4(break699_g6037.x , ( clampResult26_g6041 * temp_output_524_0_g6037 ).x , break699_g6037.y , 0.0));
			float4 temp_output_684_0_g6037 = ( _WIND_TERTIARY_ROLL669_g6037 * appendResult698_g6037 );
			float2 temp_output_1_0_g6048 = v.texcoord.xy;
			float temp_output_2_0_g6053 = _WIND_GUST_LEAF_FIELD_SIZE;
			float2 temp_output_2_0_g6048 = (( 1.0 / (( temp_output_2_0_g6053 == 0.0 ) ? 1.0 :  temp_output_2_0_g6053 ) )).xxxx.xy;
			float2 temp_output_793_0_g6037 = ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g6048 / temp_output_2_0_g6048 ) :  ( temp_output_1_0_g6048 * temp_output_2_0_g6048 ) ) + ( 5.346104 * (_WIND_VARIATION662_g6037).xx ) );
			float temp_output_2_0_g6109 = _WIND_GUST_LEAF_CYCLE_TIME;
			float temp_output_801_0_g6037 = ( 1.0 / (( temp_output_2_0_g6109 == 0.0 ) ? 1.0 :  temp_output_2_0_g6109 ) );
			float2 break298_g6057 = ( temp_output_793_0_g6037 + ( temp_output_801_0_g6037 * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g6057 = (float2(sin( break298_g6057.x ) , cos( break298_g6057.y )));
			float4 temp_output_273_0_g6057 = (-1.0).xxxx;
			float4 temp_output_271_0_g6057 = (1.0).xxxx;
			float2 clampResult26_g6057 = clamp( appendResult299_g6057 , temp_output_273_0_g6057.xy , temp_output_271_0_g6057.xy );
			float _WIND_GUST_STRENGTH_A703_g6037 = temp_output_1046_630_g6036;
			float temp_output_15_0_g6044 = _WIND_GUST_STRENGTH_A703_g6037;
			float _WIND_GUST_STRENGTH_C851_g6037 = break655_g6118.z;
			float temp_output_16_0_g6044 = _WIND_GUST_STRENGTH_C851_g6037;
			float4 _Vector0 = float4(0,0,0,0);
			float4 _Vector1 = float4(1,1,1,1);
			float2 break779_g6037 = ( ( clampResult26_g6057 * float2( 1,1 ) ) * (0.25 + (( ( temp_output_15_0_g6044 + temp_output_16_0_g6044 ) / 2.0 ) - _Vector0.x) * (_Vector1.x - 0.25) / (_Vector1.x - _Vector0.x)) );
			float2 break298_g6038 = ( temp_output_793_0_g6037 + ( ( 0.57 * temp_output_801_0_g6037 ) * ( _Time.y + ( _WIND_VARIATION662_g6037 * 500.0 ) ) ) );
			float2 appendResult299_g6038 = (float2(sin( break298_g6038.x ) , cos( break298_g6038.y )));
			float4 temp_output_273_0_g6038 = (-1.0).xxxx;
			float4 temp_output_271_0_g6038 = (1.0).xxxx;
			float2 clampResult26_g6038 = clamp( appendResult299_g6038 , temp_output_273_0_g6038.xy , temp_output_271_0_g6038.xy );
			float temp_output_15_0_g6045 = _WIND_GUST_STRENGTH_C851_g6037;
			float _WIND_GUST_STRENGTH_B829_g6037 = break655_g6118.y;
			float temp_output_16_0_g6045 = _WIND_GUST_STRENGTH_B829_g6037;
			float4 appendResult784_g6037 = (float4(break779_g6037.x , ( ( clampResult26_g6038 * float2( 1,1 ) ) * (0.25 + (( ( temp_output_15_0_g6045 + temp_output_16_0_g6045 ) / 2.0 ) - _Vector0.x) * (_Vector1.x - 0.25) / (_Vector1.x - _Vector0.x)) ).x , break779_g6037.y , 0.0));
			float smoothstepResult551_g6037 = smoothstep( 0.0 , 1.0 , temp_output_1050_498_g6036);
			float4 lerpResult538_g6037 = lerp( temp_output_684_0_g6037 , ( temp_output_684_0_g6037 + ( _WIND_TERTIARY_ROLL669_g6037 * appendResult784_g6037 ) ) , smoothstepResult551_g6037);
			float3 temp_output_41_0_g6137 = (( ( _WIND_TRUNK_STRENGTH * lerpResult538_g6064 ) + ( _WIND_BRANCH_STRENGTH * lerpResult631_g6079 ) + ( _WIND_LEAF_STRENGTH * lerpResult538_g6037 ) )).xyz;
			float3 temp_cast_43 = (0.0).xxx;
			float temp_output_63_0_g6138 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
			float3 lerpResult57_g6138 = lerp( temp_cast_43 , -ase_vertex3Pos , ( 1.0 - temp_output_63_0_g6138 ));
			#ifdef INTERNAL_LODFADE_SCALE
				float3 staticSwitch58_g6137 = lerpResult57_g6138;
			#else
				float3 staticSwitch58_g6137 = temp_output_41_0_g6137;
			#endif
			#ifdef LOD_FADE_CROSSFADE
				float3 staticSwitch62_g6137 = staticSwitch58_g6137;
			#else
				float3 staticSwitch62_g6137 = temp_output_41_0_g6137;
			#endif
			v.vertex.xyz += staticSwitch62_g6137;
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			o.screenPosition = ase_screenPos;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float3 break17_g6135 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap ), _NormalScale );
			float switchResult12_g6135 = (((i.ASEVFace>0)?(break17_g6135.z):(-break17_g6135.z)));
			float3 appendResult18_g6135 = (float3(break17_g6135.x , break17_g6135.y , switchResult12_g6135));
			half3 MainBumpMap620 = appendResult18_g6135;
			o.Normal = MainBumpMap620;
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode1258 = tex2D( _MainTex, uv_MainTex );
			half4 Main_MainTex487 = tex2DNode1258;
			half4 Main_Color486 = _Color;
			o.Albedo = saturate( ( Main_MainTex487 * Main_Color486 ) ).rgb;
			float2 uv_EmissionMap1 = i.uv_texcoord * _EmissionMap1_ST.xy + _EmissionMap1_ST.zw;
			float smoothstepResult4_g6033 = smoothstep( 0.0 , 1.0 , (( _GLOBAL_SOLAR_TIME > 0.5 ) ? 0.0 :  ( 1.0 - ( _GLOBAL_SOLAR_TIME * 2.0 ) ) ));
			float4 emission1280 = saturate( ( tex2D( _EmissionMap1, uv_EmissionMap1 ) * float4( (smoothstepResult4_g6033).xxx , 0.0 ) ) );
			o.Emission = emission1280.rgb;
			float2 uv_MetallicGlossMap = i.uv_texcoord * _MetallicGlossMap_ST.xy + _MetallicGlossMap_ST.zw;
			float4 tex2DNode1260 = tex2D( _MetallicGlossMap, uv_MetallicGlossMap );
			half Main_MetallicGlossMap_A744 = tex2DNode1260.a;
			half OUT_SMOOTHNESS660 = ( Main_MetallicGlossMap_A744 * _Smoothness );
			o.Smoothness = OUT_SMOOTHNESS660;
			half Main_MetallicGlossMap_G1261 = tex2DNode1260.g;
			half OUT_AO1266 = ( _Float6 * Main_MetallicGlossMap_G1261 );
			o.Occlusion = OUT_AO1266;
			o.Alpha = 1;
			half Main_MainTex_A616 = tex2DNode1258.a;
			float temp_output_41_0_g6143 = Main_MainTex_A616;
			float4 ase_screenPos = i.screenPosition;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 clipScreen45_g6144 = ase_screenPosNorm.xy * _ScreenParams.xy;
			float dither45_g6144 = Dither8x8Bayer( fmod(clipScreen45_g6144.x, 8), fmod(clipScreen45_g6144.y, 8) );
			float temp_output_56_0_g6144 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
			dither45_g6144 = step( dither45_g6144, temp_output_56_0_g6144 );
			#ifdef INTERNAL_LODFADE_DITHER
				float staticSwitch50_g6143 = ( temp_output_41_0_g6143 * dither45_g6144 );
			#else
				float staticSwitch50_g6143 = temp_output_41_0_g6143;
			#endif
			#ifdef LOD_FADE_CROSSFADE
				float staticSwitch56_g6143 = staticSwitch50_g6143;
			#else
				float staticSwitch56_g6143 = temp_output_41_0_g6143;
			#endif
			clip( (( _Invisible > 0.5 ) ? 1.0 :  staticSwitch56_g6143 ) - _Cutoff );
		}

		ENDCG
	}
	Fallback "Utils/ADS Fallback"
	CustomEditor "ADSShaderGUI"
}
/*ASEBEGIN
Version=17500
0;-864;1536;843;1879.626;2421.642;1.3;True;False
Node;AmplifyShaderEditor.SamplerNode;1260;1197.172,-883.2394;Inherit;True;Property;_MetallicGlossMap;Plant Surface;12;0;Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1277;-2806.813,-794.9086;Inherit;False;SOLAR_TIME;-1;;6033;10a1c1e0534af5c448836def207ff37c;0;0;3;FLOAT;0;FLOAT;14;FLOAT3;8
Node;AmplifyShaderEditor.SamplerNode;1258;-1320.405,-869.6622;Inherit;True;Property;_MainTex;Plant Albedo;5;0;Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;409;-592,-896;Half;False;Property;_Color;Plant Color;7;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1276;-2801.793,-996.1388;Inherit;True;Property;_EmissionMap1;Plant Emission Map;6;0;Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;744;1543,-722;Half;False;Main_MetallicGlossMap_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1261;1552,-880;Half;False;Main_MetallicGlossMap_G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;655;0,-896;Half;False;Property;_NormalScale;Plant Normal Scale;9;0;Create;False;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1265;1920,-624;Inherit;False;1261;Main_MetallicGlossMap_G;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1262;1920,-704;Half;False;Property;_Float6;Plant AO (G);10;0;Create;False;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;294;1920,-817;Half;False;Property;_Smoothness;Plant Smoothness (A);11;0;Create;False;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;616;-976,-768;Half;False;Main_MainTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1273;-1997.726,-1588.494;Inherit;False;Mesh Values (Tree) (Complex) (Vertex Colors);-1;;6035;9cacaefc2ecfddf4c8e070f9be99b854;0;0;4;FLOAT;495;FLOAT;501;FLOAT;550;FLOAT;552
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1278;-2431.964,-863.3776;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;-336,-896;Half;False;Main_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1272;-1924.726,-1416.494;Inherit;False;Mesh Values (Tree) (Complex) (UV1);-1;;6034;81bcd0c413f1b344ab52b9f96eee6f68;0;0;2;FLOAT;551;FLOAT;567
Node;AmplifyShaderEditor.SamplerNode;1259;240.5953,-904.6622;Inherit;True;Property;_BumpMap;Plant Normal;8;0;Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;-976,-896;Half;False;Main_MainTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;749;1920,-896;Inherit;False;744;Main_MetallicGlossMap_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1083;-1281.307,-2304.148;Inherit;False;486;Main_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;745;2238,-896;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;791;-1422.255,-1722.032;Inherit;False;616;Main_MainTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1231;592,-896;Inherit;False;Normal BackFace;-1;;6135;121446c878db06f4c847f9c5afed7cfe;0;1;13;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1270;-1513.032,-1597.56;Inherit;False;Wind (Tree Simple);16;;6036;e08118e08be3b4140bb32f9f7d5cc4cb;2,981,1,983,1;6;1152;FLOAT;0;False;1153;FLOAT;0;False;1154;FLOAT;0;False;1155;FLOAT;0;False;1156;FLOAT;0;False;1157;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;36;-1281.307,-2368.148;Inherit;False;487;Main_MainTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;1279;-2282.756,-852.7087;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1264;2224,-672;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1280;-2097.703,-858.5114;Inherit;False;emission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;620;832,-896;Half;False;MainBumpMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1266;2432,-704;Half;False;OUT_AO;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1074;-769.3071,-2368.148;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;1112;264.4814,-2252.256;Inherit;False;317.573;603.8616;Drawers;6;1275;1118;1116;1115;1113;1119;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.FunctionNode;1274;-1023.365,-1698.558;Inherit;False;Execute LOD Fade;-1;;6136;18ea34bd83a0d6c4db425672111543e6;0;2;41;FLOAT;0;False;58;FLOAT3;0,0,0;False;3;FLOAT;0;FLOAT3;91;FLOAT;96
Node;AmplifyShaderEditor.RegisterLocalVarNode;660;2400,-896;Half;False;OUT_SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1269;-1070.187,-1842.002;Inherit;False;Property;_Invisible;Invisible;14;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1119;296.4815,-2188.256;Half;False;Property;_BANNER;BANNER;0;0;Create;True;0;0;True;1;InternalBanner(Internal, Plant);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;624;-1304.607,-2216.884;Inherit;False;620;MainBumpMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;862;461.4816,-1356.256;Half;False;Property;_Cutoff;Cutout;3;0;Create;False;3;Off;0;Front;1;Back;2;0;True;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1275;296.4815,-1724.256;Inherit;False;Internal Features Support;-1;;6149;3c493d142aeebd840af72d626f6915c6;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;743;264.4814,-1356.256;Half;False;Property;_RenderFaces;Render Faces;2;1;[Enum];Create;True;3;Two Sided;0;Back;1;Front;2;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1230;1545,-806;Half;False;Main_MetallicGlossMap_B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1113;296.4815,-2092.256;Half;False;Property;_RENDERINGG;[ RENDERINGG ];1;0;Create;True;0;0;True;1;InternalCategory(Rendering);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1116;296.4815,-1900.256;Half;False;Property;_SETTINGS;[ SETTINGS ];13;0;Create;True;0;0;True;1;InternalCategory(Settings);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1115;296.4815,-1996.256;Half;False;Property;_MAINN;[ MAINN ];4;0;Create;True;0;0;True;1;InternalCategory(Main);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;654;-1349.607,-2023.884;Inherit;False;660;OUT_SMOOTHNESS;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1282;-1290.622,-2109.035;Inherit;False;1280;emission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1267;-1312.607,-1955.884;Inherit;False;1266;OUT_AO;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareGreater;1268;-608.6682,-1827.791;Inherit;False;4;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1109;-577.3071,-2368.148;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1118;296.4815,-1804.256;Half;False;Property;_ADVANCEDD;[ ADVANCEDD ];15;0;Create;True;0;0;True;1;InternalCategory(Advanced);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-128,-2048;Float;False;True;-1;4;ADSShaderGUI;300;0;Standard;appalachia/fungus-emissive;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;False;True;False;False;False;True;Off;0;False;925;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Opaque;;AlphaTest;All;12;d3d9;d3d11_9x;d3d11;glcore;gles3;metal;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;550;10;False;553;0;1;False;550;10;False;553;0;True;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;300;Utils/ADS Fallback;-1;-1;-1;-1;0;False;0;0;True;743;-1;0;True;862;0;0;0;False;0.1;False;-1;0;False;-1;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;14;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;708;0,-1024;Inherit;False;1024.6;100;Normal Texture;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1281;-2812.793,-1139.139;Inherit;False;1152.612;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;683;264.4814,-1484.256;Inherit;False;417.3682;100;Rendering And Settings;0;;1,0,0.503,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;760;-1280,-1024;Inherit;False;1152.612;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;715;1152,-1024;Inherit;False;1473.26;100;Surface Input;0;;1,0.7686275,0,1;0;0
WireConnection;744;0;1260;4
WireConnection;1261;0;1260;2
WireConnection;616;0;1258;4
WireConnection;1278;0;1276;0
WireConnection;1278;1;1277;8
WireConnection;486;0;409;0
WireConnection;1259;5;655;0
WireConnection;487;0;1258;0
WireConnection;745;0;749;0
WireConnection;745;1;294;0
WireConnection;1231;13;1259;0
WireConnection;1270;1152;1273;495
WireConnection;1270;1153;1273;495
WireConnection;1270;1154;1273;501
WireConnection;1270;1155;1273;550
WireConnection;1270;1156;1273;552
WireConnection;1270;1157;1272;551
WireConnection;1279;0;1278;0
WireConnection;1264;0;1262;0
WireConnection;1264;1;1265;0
WireConnection;1280;0;1279;0
WireConnection;620;0;1231;0
WireConnection;1266;0;1264;0
WireConnection;1074;0;36;0
WireConnection;1074;1;1083;0
WireConnection;1274;41;791;0
WireConnection;1274;58;1270;0
WireConnection;660;0;745;0
WireConnection;1230;0;1260;3
WireConnection;1268;0;1269;0
WireConnection;1268;3;1274;0
WireConnection;1109;0;1074;0
WireConnection;0;0;1109;0
WireConnection;0;1;624;0
WireConnection;0;2;1282;0
WireConnection;0;4;654;0
WireConnection;0;5;1267;0
WireConnection;0;10;1268;0
WireConnection;0;11;1274;91
ASEEND*/
//CHKSM=D891C45E1D0BD0C20A68494BC652C5541A2D6A3E