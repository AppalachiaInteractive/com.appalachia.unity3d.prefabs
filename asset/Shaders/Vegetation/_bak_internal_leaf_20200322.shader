Shader "appalachia/backup/leaf-20200322"
{
	Properties
	{
		[Header(Translucency)]
		_Translucency("Strength", Range( 0 , 50)) = 1
		_TransNormalDistortion("Normal Distortion", Range( 0 , 1)) = 0.1
		_TransScattering("Scattering Falloff", Range( 0 , 50)) = 2
		_TransDirect("Direct", Range( 0 , 1)) = 1
		_TransAmbient("Ambient", Range( 0 , 1)) = 0.2
		_TransShadow("Shadow", Range( 0 , 1)) = 0.9
		[AppalachiaBanner(Internal, Leaf)]_BANNER("BANNER", Float) = 1
		[AppalachiaCategory(Rendering)]_RENDERINGG("[ RENDERINGG ]", Float) = 0
		[Enum(Two Sided,0,Back,1,Front,2)]_RenderFaces("Render Faces", Float) = 0
		_CutoffLowNear("Cutoff Low (Near)", Range( 0 , 1)) = 0.75
		_CutoffHighNear("Cutoff High (Near)", Range( 0 , 1)) = 1
		_CutoffFar("Cutoff Far", Range( 64 , 1024)) = 64
		_CutoffLowFar("Cutoff Low (Far)", Range( 0 , 1)) = 0.1
		_CutoffHighFar("Cutoff High (Far)", Range( 0 , 1)) = 0.6
		[AppalachiaCategory(Leaf)]_LEAFF("[ LEAFF ]", Float) = 0
		[NoScaleOffset]_MainTex("Leaf Albedo", 2D) = "white" {}
		_Color("Leaf Color", Color) = (1,1,1,1)
		_Color3("Non-Leaf Color", Color) = (1,1,1,1)
		_Saturation("Leaf Saturation", Range( 0.1 , 2)) = 1
		_Brightness("Leaf Brightness", Range( 0.1 , 2)) = 1
		[NoScaleOffset]BumpMap("Leaf Normal", 2D) = "bump" {}
		_NormalScale("Leaf Normal Scale", Range( 0 , 5)) = 1
		[NoScaleOffset]_MetallicGlossMap("Leaf Surface", 2D) = "white" {}
		_Smoothness("Leaf Smoothness", Range( 0 , 1)) = 0.5
		_Occlusion("Texture Occlusion", Range( 0 , 1)) = 0
		_VertexOcclusion("Vertex Occlusion", Range( 0 , 1)) = 0
		[AppalachiaCategory(Transmission)]_TRANSMISSION("[ TRANSMISSION ]", Float) = 0
		[AppalachiaCategory(Translucency)]_TRANSLUCENCYY("[ TRANSLUCENCYY ]", Float) = 0
		[Toggle(_ENABLETRANSLUCENCY_ON)] _EnableTranslucency("Enable Translucency", Float) = 1
		[AppalachiaCategory(Settings)]_SETTINGSS("[ SETTINGSS ]", Float) = 0
		[Toggle(_ENABLEBILLBOARDS_ON)] _EnableBillboards("Enable Billboards", Float) = 1
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "DisableBatching" = "True" }
		LOD 300
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma shader_feature_local _ENABLEBILLBOARDS_ON
		#pragma shader_feature_local _ENABLETRANSLUCENCY_ON
		#pragma exclude_renderers gles vulkan 
		#pragma surface surf StandardCustom keepalpha addshadow fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 
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
		};

		struct SurfaceOutputStandardCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			half3 Translucency;
		};

		uniform half _CutoffFar;
		uniform half _CutoffLowNear;
		uniform half _CutoffLowFar;
		uniform half _CutoffHighFar;
		uniform half _CutoffHighNear;
		uniform half _TRANSLUCENCYY;
		uniform half _RenderFaces;
		uniform half _SETTINGSS;
		uniform half _BANNER;
		uniform half _TRANSMISSION;
		uniform half _LEAFF;
		uniform half _RENDERINGG;
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
		uniform half _NormalScale;
		uniform sampler2D BumpMap;
		uniform sampler2D _MainTex;
		uniform float _Saturation;
		uniform float _Brightness;
		uniform half4 _Color3;
		uniform half4 _Color;
		uniform sampler2D _MetallicGlossMap;
		uniform half _Smoothness;
		uniform half _Occlusion;
		uniform half _VertexOcclusion;
		uniform half _Translucency;
		uniform half _TransNormalDistortion;
		uniform half _TransScattering;
		uniform half _TransDirect;
		uniform half _TransAmbient;
		uniform half _TransShadow;


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
			float WIND_TRUNK_STRENGTH1235_g3999 = _WIND_TRUNK_STRENGTH;
			half localunity_ObjectToWorld0w1_g5875 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g5875 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g5875 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g5875 = (float3(localunity_ObjectToWorld0w1_g5875 , localunity_ObjectToWorld1w2_g5875 , localunity_ObjectToWorld2w3_g5875));
			float3 WIND_POSITION_OBJECT1195_g3999 = appendResult6_g5875;
			float2 temp_output_1_0_g5836 = (WIND_POSITION_OBJECT1195_g3999).xz;
			float WIND_BASE_TRUNK_FIELD_SIZE1238_g3999 = _WIND_BASE_TRUNK_FIELD_SIZE;
			float temp_output_2_0_g5830 = WIND_BASE_TRUNK_FIELD_SIZE1238_g3999;
			float2 temp_cast_0 = (( 1.0 / (( temp_output_2_0_g5830 == 0.0 ) ? 1.0 :  temp_output_2_0_g5830 ) )).xx;
			float2 temp_output_2_0_g5836 = temp_cast_0;
			float2 temp_output_3_0_g5836 = float2( 0,0 );
			float2 temp_output_704_0_g5824 = ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g5836 / temp_output_2_0_g5836 ) :  ( temp_output_1_0_g5836 * temp_output_2_0_g5836 ) ) + temp_output_3_0_g5836 );
			float temp_output_2_0_g5840 = _WIND_BASE_TRUNK_CYCLE_TIME;
			float WIND_BASE_TRUNK_FREQUENCY1237_g3999 = ( 1.0 / (( temp_output_2_0_g5840 == 0.0 ) ? 1.0 :  temp_output_2_0_g5840 ) );
			float2 temp_output_721_0_g5824 = (WIND_BASE_TRUNK_FREQUENCY1237_g3999).xx;
			float2 break298_g5826 = ( temp_output_704_0_g5824 + ( temp_output_721_0_g5824 * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g5826 = (float2(sin( break298_g5826.x ) , cos( break298_g5826.y )));
			float4 temp_output_273_0_g5826 = (-1.0).xxxx;
			float4 temp_output_271_0_g5826 = (1.0).xxxx;
			float2 clampResult26_g5826 = clamp( appendResult299_g5826 , temp_output_273_0_g5826.xy , temp_output_271_0_g5826.xy );
			float WIND_BASE_AMPLITUDE1197_g3999 = _WIND_BASE_AMPLITUDE;
			float WIND_BASE_TRUNK_STRENGTH1236_g3999 = _WIND_BASE_TRUNK_STRENGTH;
			float2 temp_output_720_0_g5824 = (( WIND_BASE_AMPLITUDE1197_g3999 * WIND_BASE_TRUNK_STRENGTH1236_g3999 )).xx;
			float2 TRUNK_PIVOT_ROCKING701_g5824 = ( clampResult26_g5826 * temp_output_720_0_g5824 );
			float WIND_PRIMARY_ROLL1202_g3999 = v.color.r;
			float _WIND_PRIMARY_ROLL669_g5824 = WIND_PRIMARY_ROLL1202_g3999;
			float temp_output_54_0_g5825 = ( TRUNK_PIVOT_ROCKING701_g5824 * 0.05 * _WIND_PRIMARY_ROLL669_g5824 ).x;
			float temp_output_72_0_g5825 = cos( temp_output_54_0_g5825 );
			float one_minus_c52_g5825 = ( 1.0 - temp_output_72_0_g5825 );
			float3 break70_g5825 = float3(0,1,0);
			float axis_x25_g5825 = break70_g5825.x;
			float c66_g5825 = temp_output_72_0_g5825;
			float axis_y37_g5825 = break70_g5825.y;
			float axis_z29_g5825 = break70_g5825.z;
			float s67_g5825 = sin( temp_output_54_0_g5825 );
			float3 appendResult83_g5825 = (float3(( ( one_minus_c52_g5825 * axis_x25_g5825 * axis_x25_g5825 ) + c66_g5825 ) , ( ( one_minus_c52_g5825 * axis_x25_g5825 * axis_y37_g5825 ) - ( axis_z29_g5825 * s67_g5825 ) ) , ( ( one_minus_c52_g5825 * axis_z29_g5825 * axis_x25_g5825 ) + ( axis_y37_g5825 * s67_g5825 ) )));
			float3 appendResult81_g5825 = (float3(( ( one_minus_c52_g5825 * axis_x25_g5825 * axis_y37_g5825 ) + ( axis_z29_g5825 * s67_g5825 ) ) , ( ( one_minus_c52_g5825 * axis_y37_g5825 * axis_y37_g5825 ) + c66_g5825 ) , ( ( one_minus_c52_g5825 * axis_y37_g5825 * axis_z29_g5825 ) - ( axis_x25_g5825 * s67_g5825 ) )));
			float3 appendResult82_g5825 = (float3(( ( one_minus_c52_g5825 * axis_z29_g5825 * axis_x25_g5825 ) - ( axis_y37_g5825 * s67_g5825 ) ) , ( ( one_minus_c52_g5825 * axis_y37_g5825 * axis_z29_g5825 ) + ( axis_x25_g5825 * s67_g5825 ) ) , ( ( one_minus_c52_g5825 * axis_z29_g5825 * axis_z29_g5825 ) + c66_g5825 )));
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 WIND_PRIMARY_PIVOT1203_g3999 = (v.texcoord1).xyz;
			float3 _WIND_PRIMARY_PIVOT655_g5824 = WIND_PRIMARY_PIVOT1203_g3999;
			float3 temp_output_38_0_g5825 = ( ase_vertex3Pos - (_WIND_PRIMARY_PIVOT655_g5824).xyz );
			float2 break298_g5832 = ( temp_output_704_0_g5824 + ( temp_output_721_0_g5824 * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g5832 = (float2(sin( break298_g5832.x ) , cos( break298_g5832.y )));
			float4 temp_output_273_0_g5832 = (-1.0).xxxx;
			float4 temp_output_271_0_g5832 = (1.0).xxxx;
			float2 clampResult26_g5832 = clamp( appendResult299_g5832 , temp_output_273_0_g5832.xy , temp_output_271_0_g5832.xy );
			float2 TRUNK_SWIRL700_g5824 = ( clampResult26_g5832 * temp_output_720_0_g5824 );
			float2 break699_g5824 = TRUNK_SWIRL700_g5824;
			float3 appendResult698_g5824 = (float3(break699_g5824.x , 0.0 , break699_g5824.y));
			float3 temp_output_694_0_g5824 = ( ( mul( float3x3(appendResult83_g5825, appendResult81_g5825, appendResult82_g5825), temp_output_38_0_g5825 ) - temp_output_38_0_g5825 ) + ( _WIND_PRIMARY_ROLL669_g5824 * appendResult698_g5824 * 0.5 ) );
			float lerpResult632_g5837 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH , _WIND_AUDIO_INFLUENCE);
			float WIND_GUST_AUDIO_STRENGTH1242_g3999 = lerpResult632_g5837;
			float temp_output_15_0_g5923 = WIND_GUST_AUDIO_STRENGTH1242_g3999;
			float lerpResult635_g5837 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_LOW , _WIND_AUDIO_INFLUENCE);
			float WIND_GUST_AUDIO_LOW1246_g3999 = lerpResult635_g5837;
			float temp_output_16_0_g5923 = WIND_GUST_AUDIO_LOW1246_g3999;
			float WIND_GUST_TRUNK_STRENGTH1240_g3999 = _WIND_GUST_TRUNK_STRENGTH;
			float4 color658_g5812 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float WIND_GUST_TRUNK_CYCLE_TIME1241_g3999 = _WIND_GUST_TRUNK_CYCLE_TIME;
			float temp_output_2_0_g5813 = WIND_GUST_TRUNK_CYCLE_TIME1241_g3999;
			float2 temp_cast_6 = (( 1.0 / (( temp_output_2_0_g5813 == 0.0 ) ? 1.0 :  temp_output_2_0_g5813 ) )).xx;
			float2 temp_output_61_0_g5816 = float2( 0,0 );
			float2 temp_output_1_0_g5817 = (WIND_POSITION_OBJECT1195_g3999).xz;
			float WIND_GUST_TRUNK_FIELD_SIZE1239_g3999 = _WIND_GUST_TRUNK_FIELD_SIZE;
			float temp_output_2_0_g5815 = WIND_GUST_TRUNK_FIELD_SIZE1239_g3999;
			float temp_output_40_0_g5816 = ( 1.0 / (( temp_output_2_0_g5815 == 0.0 ) ? 1.0 :  temp_output_2_0_g5815 ) );
			float2 temp_cast_7 = (temp_output_40_0_g5816).xx;
			float2 temp_output_2_0_g5817 = temp_cast_7;
			float2 temp_output_3_0_g5817 = temp_output_61_0_g5816;
			float2 panner90_g5816 = ( _Time.y * temp_cast_6 + ( (( temp_output_61_0_g5816 > float2( 0,0 ) ) ? ( temp_output_1_0_g5817 / temp_output_2_0_g5817 ) :  ( temp_output_1_0_g5817 * temp_output_2_0_g5817 ) ) + temp_output_3_0_g5817 ));
			float temp_output_679_0_g5812 = 1.0;
			float4 temp_cast_8 = (temp_output_679_0_g5812).xxxx;
			float4 temp_output_52_0_g5816 = saturate( pow( tex2Dlod( _WIND_GUST_TEXTURE, float4( panner90_g5816, 0, 0.0) ) , temp_cast_8 ) );
			float4 lerpResult656_g5812 = lerp( color658_g5812 , temp_output_52_0_g5816 , temp_output_679_0_g5812);
			float4 break655_g5812 = lerpResult656_g5812;
			float4 _Vector0 = float4(0,0,0,0);
			float4 _Vector1 = float4(1,1,1,1);
			float _TRUNK1350_g3999 = ( ( ( temp_output_15_0_g5923 + temp_output_16_0_g5923 ) / 2.0 ) * WIND_GUST_TRUNK_STRENGTH1240_g3999 * (-0.45 + (( 1.0 - break655_g5812.b ) - _Vector0.x) * (1.0 - -0.45) / (_Vector1.x - _Vector0.x)) );
			float _WIND_GUST_STRENGTH703_g5824 = _TRUNK1350_g3999;
			float WIND_PRIMARY_BEND1204_g3999 = v.texcoord1.w;
			float _WIND_PRIMARY_BEND662_g5824 = WIND_PRIMARY_BEND1204_g3999;
			float temp_output_54_0_g5831 = ( -_WIND_GUST_STRENGTH703_g5824 * _WIND_PRIMARY_BEND662_g5824 );
			float temp_output_72_0_g5831 = cos( temp_output_54_0_g5831 );
			float one_minus_c52_g5831 = ( 1.0 - temp_output_72_0_g5831 );
			float3 WIND_DIRECTION1192_g3999 = _WIND_DIRECTION;
			float3 _WIND_DIRECTION671_g5824 = WIND_DIRECTION1192_g3999;
			float3 worldToObjDir719_g5824 = mul( unity_WorldToObject, float4( cross( _WIND_DIRECTION671_g5824 , float3(0,1,0) ), 0 ) ).xyz;
			float3 break70_g5831 = worldToObjDir719_g5824;
			float axis_x25_g5831 = break70_g5831.x;
			float c66_g5831 = temp_output_72_0_g5831;
			float axis_y37_g5831 = break70_g5831.y;
			float axis_z29_g5831 = break70_g5831.z;
			float s67_g5831 = sin( temp_output_54_0_g5831 );
			float3 appendResult83_g5831 = (float3(( ( one_minus_c52_g5831 * axis_x25_g5831 * axis_x25_g5831 ) + c66_g5831 ) , ( ( one_minus_c52_g5831 * axis_x25_g5831 * axis_y37_g5831 ) - ( axis_z29_g5831 * s67_g5831 ) ) , ( ( one_minus_c52_g5831 * axis_z29_g5831 * axis_x25_g5831 ) + ( axis_y37_g5831 * s67_g5831 ) )));
			float3 appendResult81_g5831 = (float3(( ( one_minus_c52_g5831 * axis_x25_g5831 * axis_y37_g5831 ) + ( axis_z29_g5831 * s67_g5831 ) ) , ( ( one_minus_c52_g5831 * axis_y37_g5831 * axis_y37_g5831 ) + c66_g5831 ) , ( ( one_minus_c52_g5831 * axis_y37_g5831 * axis_z29_g5831 ) - ( axis_x25_g5831 * s67_g5831 ) )));
			float3 appendResult82_g5831 = (float3(( ( one_minus_c52_g5831 * axis_z29_g5831 * axis_x25_g5831 ) - ( axis_y37_g5831 * s67_g5831 ) ) , ( ( one_minus_c52_g5831 * axis_y37_g5831 * axis_z29_g5831 ) + ( axis_x25_g5831 * s67_g5831 ) ) , ( ( one_minus_c52_g5831 * axis_z29_g5831 * axis_z29_g5831 ) + c66_g5831 )));
			float3 temp_output_38_0_g5831 = ( ase_vertex3Pos - (_WIND_PRIMARY_PIVOT655_g5824).xyz );
			float3 lerpResult538_g5824 = lerp( temp_output_694_0_g5824 , ( temp_output_694_0_g5824 + ( mul( float3x3(appendResult83_g5831, appendResult81_g5831, appendResult82_g5831), temp_output_38_0_g5831 ) - temp_output_38_0_g5831 ) ) , WIND_GUST_AUDIO_STRENGTH1242_g3999);
			float3 MOTION_TRUNK1337_g3999 = lerpResult538_g5824;
			float WIND_BRANCH_STRENGTH1224_g3999 = _WIND_BRANCH_STRENGTH;
			float3 _WIND_POSITION_ROOT1002_g5957 = WIND_POSITION_OBJECT1195_g3999;
			float2 temp_output_1_0_g5973 = (_WIND_POSITION_ROOT1002_g5957).xz;
			float WIND_BASE_BRANCH_FIELD_SIZE1218_g3999 = _WIND_BASE_BRANCH_FIELD_SIZE;
			float _WIND_BASE_BRANCH_FIELD_SIZE1004_g5957 = WIND_BASE_BRANCH_FIELD_SIZE1218_g3999;
			float temp_output_2_0_g5978 = _WIND_BASE_BRANCH_FIELD_SIZE1004_g5957;
			float2 temp_cast_11 = (( 1.0 / (( temp_output_2_0_g5978 == 0.0 ) ? 1.0 :  temp_output_2_0_g5978 ) )).xx;
			float2 temp_output_2_0_g5973 = temp_cast_11;
			float temp_output_587_552_g5859 = v.color.a;
			float WIND_PHASE1212_g3999 = temp_output_587_552_g5859;
			float _WIND_PHASE852_g5957 = WIND_PHASE1212_g3999;
			float WIND_BASE_BRANCH_VARIATION_STRENGTH1219_g3999 = _WIND_BASE_BRANCH_VARIATION_STRENGTH;
			float _WIND_BASE_BRANCH_VARIATION_STRENGTH1006_g5957 = WIND_BASE_BRANCH_VARIATION_STRENGTH1219_g3999;
			float2 temp_cast_12 = (( ( _WIND_PHASE852_g5957 * _WIND_BASE_BRANCH_VARIATION_STRENGTH1006_g5957 ) * UNITY_PI )).xx;
			float2 temp_output_3_0_g5973 = temp_cast_12;
			float temp_output_2_0_g5934 = _WIND_BASE_BRANCH_CYCLE_TIME;
			float WIND_BASE_BRANCH_FREQUENCY1217_g3999 = ( 1.0 / (( temp_output_2_0_g5934 == 0.0 ) ? 1.0 :  temp_output_2_0_g5934 ) );
			float2 break298_g5974 = ( ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g5973 / temp_output_2_0_g5973 ) :  ( temp_output_1_0_g5973 * temp_output_2_0_g5973 ) ) + temp_output_3_0_g5973 ) + ( (( WIND_BASE_BRANCH_FREQUENCY1217_g3999 * _WIND_PHASE852_g5957 )).xx * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g5974 = (float2(sin( break298_g5974.x ) , cos( break298_g5974.y )));
			float4 temp_output_273_0_g5974 = (-1.0).xxxx;
			float4 temp_output_271_0_g5974 = (1.0).xxxx;
			float2 clampResult26_g5974 = clamp( appendResult299_g5974 , temp_output_273_0_g5974.xy , temp_output_271_0_g5974.xy );
			float WIND_BASE_BRANCH_STRENGTH1227_g3999 = _WIND_BASE_BRANCH_STRENGTH;
			float2 BRANCH_SWIRL931_g5957 = ( clampResult26_g5974 * (( WIND_BASE_AMPLITUDE1197_g3999 * WIND_BASE_BRANCH_STRENGTH1227_g3999 )).xx );
			float2 break932_g5957 = BRANCH_SWIRL931_g5957;
			float3 appendResult933_g5957 = (float3(break932_g5957.x , 0.0 , break932_g5957.y));
			float WIND_SECONDARY_ROLL1205_g3999 = v.color.g;
			float _WIND_SECONDARY_ROLL650_g5957 = WIND_SECONDARY_ROLL1205_g3999;
			float3 VALUE_ROLL1034_g5957 = ( appendResult933_g5957 * _WIND_SECONDARY_ROLL650_g5957 * 0.5 );
			float3 _WIND_DIRECTION856_g5957 = WIND_DIRECTION1192_g3999;
			float3 WIND_SECONDARY_GROWTH_DIRECTION1208_g3999 = (v.texcoord2).xyz;
			float3 temp_output_839_0_g5957 = WIND_SECONDARY_GROWTH_DIRECTION1208_g3999;
			float3 _WIND_SECONDARY_GROWTH_DIRECTION = float3(0,1,0);
			float3 objToWorldDir1174_g5957 = mul( unity_ObjectToWorld, float4( (( length( temp_output_839_0_g5957 ) == 0.0 ) ? _WIND_SECONDARY_GROWTH_DIRECTION :  temp_output_839_0_g5957 ), 0 ) ).xyz;
			float3 _WIND_SECONDARY_GROWTH_DIRECTION840_g5957 = (objToWorldDir1174_g5957).xyz;
			float dotResult565_g5957 = dot( _WIND_DIRECTION856_g5957 , _WIND_SECONDARY_GROWTH_DIRECTION840_g5957 );
			float clampResult13_g5966 = clamp( dotResult565_g5957 , -1.0 , 1.0 );
			float4 color658_g5806 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float WIND_GUST_BRANCH_CYCLE_TIME1220_g3999 = _WIND_GUST_BRANCH_CYCLE_TIME;
			float clampResult3_g5868 = clamp( temp_output_587_552_g5859 , 0.0 , 1.0 );
			float WIND_PHASE_UNPACKED1530_g3999 = ( ( clampResult3_g5868 * 2.0 ) - 1.0 );
			float temp_output_2_0_g5807 = ( WIND_GUST_BRANCH_CYCLE_TIME1220_g3999 + ( WIND_GUST_BRANCH_CYCLE_TIME1220_g3999 * WIND_PHASE_UNPACKED1530_g3999 * 0.1 ) );
			float2 temp_cast_15 = (( 1.0 / (( temp_output_2_0_g5807 == 0.0 ) ? 1.0 :  temp_output_2_0_g5807 ) )).xx;
			float2 temp_output_61_0_g5810 = float2( 0,0 );
			float3 WIND_SECONDARY_PIVOT1206_g3999 = (v.texcoord3).xyz;
			float WIND_GUST_BRANCH_VARIATION_STRENGTH1223_g3999 = _WIND_GUST_BRANCH_VARIATION_STRENGTH;
			float2 temp_output_1_0_g5811 = ( (WIND_POSITION_OBJECT1195_g3999).xz + (WIND_SECONDARY_PIVOT1206_g3999).xy + ( WIND_PHASE1212_g3999 * WIND_GUST_BRANCH_VARIATION_STRENGTH1223_g3999 ) );
			float WIND_GUST_BRANCH_FIELD_SIZE1222_g3999 = _WIND_GUST_BRANCH_FIELD_SIZE;
			float temp_output_2_0_g5809 = WIND_GUST_BRANCH_FIELD_SIZE1222_g3999;
			float temp_output_40_0_g5810 = ( 1.0 / (( temp_output_2_0_g5809 == 0.0 ) ? 1.0 :  temp_output_2_0_g5809 ) );
			float2 temp_cast_16 = (temp_output_40_0_g5810).xx;
			float2 temp_output_2_0_g5811 = temp_cast_16;
			float2 temp_output_3_0_g5811 = temp_output_61_0_g5810;
			float2 panner90_g5810 = ( _Time.y * temp_cast_15 + ( (( temp_output_61_0_g5810 > float2( 0,0 ) ) ? ( temp_output_1_0_g5811 / temp_output_2_0_g5811 ) :  ( temp_output_1_0_g5811 * temp_output_2_0_g5811 ) ) + temp_output_3_0_g5811 ));
			float temp_output_679_0_g5806 = 1.0;
			float4 temp_cast_17 = (temp_output_679_0_g5806).xxxx;
			float4 temp_output_52_0_g5810 = saturate( pow( tex2Dlod( _WIND_GUST_TEXTURE, float4( panner90_g5810, 0, 0.0) ) , temp_cast_17 ) );
			float4 lerpResult656_g5806 = lerp( color658_g5806 , temp_output_52_0_g5810 , temp_output_679_0_g5806);
			float4 break655_g5806 = lerpResult656_g5806;
			float temp_output_15_0_g5873 = break655_g5806.r;
			float temp_output_16_0_g5873 = ( 1.0 - break655_g5806.b );
			float temp_output_15_0_g5936 = WIND_GUST_AUDIO_STRENGTH1242_g3999;
			float lerpResult634_g5837 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_MID , _WIND_AUDIO_INFLUENCE);
			float WIND_GUST_AUDIO_MID1245_g3999 = lerpResult634_g5837;
			float temp_output_16_0_g5936 = WIND_GUST_AUDIO_MID1245_g3999;
			float temp_output_1516_14_g3999 = ( ( temp_output_15_0_g5936 + temp_output_16_0_g5936 ) / 2.0 );
			float WIND_GUST_BRANCH_STRENGTH1229_g3999 = _WIND_GUST_BRANCH_STRENGTH;
			float WIND_GUST_BRANCH_STRENGTH_OPPOSITE1573_g3999 = _WIND_GUST_BRANCH_STRENGTH_OPPOSITE;
			float _BRANCH_OPPOSITE_DOWN1466_g3999 = ( (-0.1 + (( ( temp_output_15_0_g5873 + temp_output_16_0_g5873 ) / 2.0 ) - _Vector0.x) * (0.75 - -0.1) / (_Vector1.x - _Vector0.x)) * temp_output_1516_14_g3999 * WIND_GUST_BRANCH_STRENGTH1229_g3999 * WIND_GUST_BRANCH_STRENGTH_OPPOSITE1573_g3999 );
			float _GUST_STRENGTH_OPPOSITE_DOWN1188_g5957 = _BRANCH_OPPOSITE_DOWN1466_g3999;
			float temp_output_15_0_g5856 = ( 1.0 - break655_g5806.g );
			float temp_output_16_0_g5856 = break655_g5806.a;
			float _BRANCH_OPPOSITE_UP1348_g3999 = ( (-0.3 + (( ( temp_output_15_0_g5856 + temp_output_16_0_g5856 ) / 2.0 ) - _Vector0.x) * (1.0 - -0.3) / (_Vector1.x - _Vector0.x)) * temp_output_1516_14_g3999 * WIND_GUST_BRANCH_STRENGTH1229_g3999 * WIND_GUST_BRANCH_STRENGTH_OPPOSITE1573_g3999 );
			float _GUST_STRENGTH_OPPOSITE_UP871_g5957 = _BRANCH_OPPOSITE_UP1348_g3999;
			float dotResult1180_g5957 = dot( _WIND_SECONDARY_GROWTH_DIRECTION840_g5957 , float3(0,1,0) );
			float clampResult8_g5979 = clamp( dotResult1180_g5957 , -1.0 , 1.0 );
			float _WIND_SECONDARY_VERTICALITY843_g5957 = ( ( clampResult8_g5979 * 0.5 ) + 0.5 );
			float temp_output_2_0_g5981 = _WIND_SECONDARY_VERTICALITY843_g5957;
			float temp_output_3_0_g5981 = 0.5;
			float temp_output_21_0_g5981 = 1.0;
			float temp_output_26_0_g5981 = 0.0;
			float lerpResult1_g5985 = lerp( _GUST_STRENGTH_OPPOSITE_DOWN1188_g5957 , -_GUST_STRENGTH_OPPOSITE_UP871_g5957 , saturate( saturate( (( temp_output_2_0_g5981 >= temp_output_3_0_g5981 ) ? temp_output_21_0_g5981 :  temp_output_26_0_g5981 ) ) ));
			float WIND_SECONDARY_BEND1207_g3999 = v.texcoord3.w;
			float _WIND_SECONDARY_BEND849_g5957 = WIND_SECONDARY_BEND1207_g3999;
			float clampResult1170_g5957 = clamp( _WIND_SECONDARY_BEND849_g5957 , 0.0 , 0.75 );
			float clampResult1175_g5957 = clamp( ( lerpResult1_g5985 * clampResult1170_g5957 ) , -1.5 , 1.5 );
			float temp_output_54_0_g5963 = clampResult1175_g5957;
			float temp_output_72_0_g5963 = cos( temp_output_54_0_g5963 );
			float one_minus_c52_g5963 = ( 1.0 - temp_output_72_0_g5963 );
			float3 worldToObjDir1173_g5957 = mul( unity_WorldToObject, float4( cross( _WIND_DIRECTION856_g5957 , float3(0,1,0) ), 0 ) ).xyz;
			float3 break70_g5963 = worldToObjDir1173_g5957;
			float axis_x25_g5963 = break70_g5963.x;
			float c66_g5963 = temp_output_72_0_g5963;
			float axis_y37_g5963 = break70_g5963.y;
			float axis_z29_g5963 = break70_g5963.z;
			float s67_g5963 = sin( temp_output_54_0_g5963 );
			float3 appendResult83_g5963 = (float3(( ( one_minus_c52_g5963 * axis_x25_g5963 * axis_x25_g5963 ) + c66_g5963 ) , ( ( one_minus_c52_g5963 * axis_x25_g5963 * axis_y37_g5963 ) - ( axis_z29_g5963 * s67_g5963 ) ) , ( ( one_minus_c52_g5963 * axis_z29_g5963 * axis_x25_g5963 ) + ( axis_y37_g5963 * s67_g5963 ) )));
			float3 appendResult81_g5963 = (float3(( ( one_minus_c52_g5963 * axis_x25_g5963 * axis_y37_g5963 ) + ( axis_z29_g5963 * s67_g5963 ) ) , ( ( one_minus_c52_g5963 * axis_y37_g5963 * axis_y37_g5963 ) + c66_g5963 ) , ( ( one_minus_c52_g5963 * axis_y37_g5963 * axis_z29_g5963 ) - ( axis_x25_g5963 * s67_g5963 ) )));
			float3 appendResult82_g5963 = (float3(( ( one_minus_c52_g5963 * axis_z29_g5963 * axis_x25_g5963 ) - ( axis_y37_g5963 * s67_g5963 ) ) , ( ( one_minus_c52_g5963 * axis_y37_g5963 * axis_z29_g5963 ) + ( axis_x25_g5963 * s67_g5963 ) ) , ( ( one_minus_c52_g5963 * axis_z29_g5963 * axis_z29_g5963 ) + c66_g5963 )));
			float3 _WIND_SECONDARY_PIVOT846_g5957 = WIND_SECONDARY_PIVOT1206_g3999;
			float3 temp_output_38_0_g5963 = ( ase_vertex3Pos - (_WIND_SECONDARY_PIVOT846_g5957).xyz );
			float3 VALUE_FACING_WIND1042_g5957 = ( mul( float3x3(appendResult83_g5963, appendResult81_g5963, appendResult82_g5963), temp_output_38_0_g5963 ) - temp_output_38_0_g5963 );
			float2 temp_output_1_0_g5958 = (_WIND_SECONDARY_PIVOT846_g5957).xz;
			float _WIND_GUST_BRANCH_FIELD_SIZE1011_g5957 = WIND_GUST_BRANCH_FIELD_SIZE1222_g3999;
			float temp_output_2_0_g5965 = _WIND_GUST_BRANCH_FIELD_SIZE1011_g5957;
			float2 temp_cast_22 = (( 1.0 / (( temp_output_2_0_g5965 == 0.0 ) ? 1.0 :  temp_output_2_0_g5965 ) )).xx;
			float2 temp_output_2_0_g5958 = temp_cast_22;
			float _WIND_GUST_BRANCH_VARIATION_STRENGTH1008_g5957 = WIND_GUST_BRANCH_VARIATION_STRENGTH1223_g3999;
			float2 temp_cast_23 = (( ( _WIND_PHASE852_g5957 * _WIND_GUST_BRANCH_VARIATION_STRENGTH1008_g5957 ) * UNITY_PI )).xx;
			float2 temp_output_3_0_g5958 = temp_cast_23;
			float temp_output_2_0_g5935 = _WIND_GUST_BRANCH_CYCLE_TIME;
			float WIND_GUST_BRANCH_FREQUENCY1221_g3999 = ( 1.0 / (( temp_output_2_0_g5935 == 0.0 ) ? 1.0 :  temp_output_2_0_g5935 ) );
			float _WIND_GUST_BRANCH_FREQUENCY1012_g5957 = WIND_GUST_BRANCH_FREQUENCY1221_g3999;
			float2 break298_g5959 = ( ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g5958 / temp_output_2_0_g5958 ) :  ( temp_output_1_0_g5958 * temp_output_2_0_g5958 ) ) + temp_output_3_0_g5958 ) + ( (_WIND_GUST_BRANCH_FREQUENCY1012_g5957).xx * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g5959 = (float2(sin( break298_g5959.x ) , cos( break298_g5959.y )));
			float4 temp_output_273_0_g5959 = (-1.0).xxxx;
			float4 temp_output_271_0_g5959 = (1.0).xxxx;
			float2 clampResult26_g5959 = clamp( appendResult299_g5959 , temp_output_273_0_g5959.xy , temp_output_271_0_g5959.xy );
			float2 break305_g5959 = float2( -0.25,1 );
			float temp_output_15_0_g5872 = ( 1.0 - break655_g5806.r );
			float temp_output_16_0_g5872 = break655_g5806.g;
			float WIND_GUST_BRANCH_STRENGTH_PERPENDICULAR1574_g3999 = _WIND_GUST_BRANCH_STRENGTH_PERPENDICULAR;
			float _BRANCH_PERPENDICULAR1431_g3999 = ( (-0.1 + (( ( temp_output_15_0_g5872 + temp_output_16_0_g5872 ) / 2.0 ) - _Vector0.x) * (0.9 - -0.1) / (_Vector1.x - _Vector0.x)) * temp_output_1516_14_g3999 * WIND_GUST_BRANCH_STRENGTH1229_g3999 * WIND_GUST_BRANCH_STRENGTH_PERPENDICULAR1574_g3999 );
			float _GUST_STRENGTH_PERPENDICULAR999_g5957 = _BRANCH_PERPENDICULAR1431_g3999;
			float2 break1067_g5957 = ( ( ((break305_g5959.x).xxxx.xy + (clampResult26_g5959 - temp_output_273_0_g5959.xy) * ((break305_g5959.y).xxxx.xy - (break305_g5959.x).xxxx.xy) / (temp_output_271_0_g5959.xy - temp_output_273_0_g5959.xy)) * (_GUST_STRENGTH_PERPENDICULAR999_g5957).xx ) * _WIND_SECONDARY_ROLL650_g5957 );
			float3 appendResult1066_g5957 = (float3(break1067_g5957.x , 0.0 , break1067_g5957.y));
			float3 worldToObjDir1089_g5957 = normalize( mul( unity_WorldToObject, float4( _WIND_DIRECTION856_g5957, 0 ) ).xyz );
			float3 BRANCH_SWIRL972_g5957 = ( appendResult1066_g5957 * worldToObjDir1089_g5957 );
			float3 VALUE_PERPENDICULAR1041_g5957 = BRANCH_SWIRL972_g5957;
			float3 temp_output_3_0_g5966 = VALUE_PERPENDICULAR1041_g5957;
			float3 lerpResult1_g5972 = lerp( VALUE_FACING_WIND1042_g5957 , temp_output_3_0_g5966 , saturate( ( 1.0 + clampResult13_g5966 ) ));
			float temp_output_15_0_g5799 = break655_g5806.b;
			float temp_output_16_0_g5799 = ( 1.0 - break655_g5806.a );
			float clampResult3_g5857 = clamp( ( ( temp_output_15_0_g5799 + temp_output_16_0_g5799 ) / 2.0 ) , 0.0 , 1.0 );
			float WIND_GUST_BRANCH_STRENGTH_PARALLEL1575_g3999 = _WIND_GUST_BRANCH_STRENGTH_PARALLEL;
			float _BRANCH_PARALLEL1432_g3999 = ( ( ( clampResult3_g5857 * 2.0 ) - 1.0 ) * temp_output_1516_14_g3999 * WIND_GUST_BRANCH_STRENGTH1229_g3999 * WIND_GUST_BRANCH_STRENGTH_PARALLEL1575_g3999 );
			float _GUST_STRENGTH_PARALLEL1110_g5957 = _BRANCH_PARALLEL1432_g3999;
			float clampResult1167_g5957 = clamp( ( _GUST_STRENGTH_PARALLEL1110_g5957 * _WIND_SECONDARY_BEND849_g5957 ) , -1.5 , 1.5 );
			float temp_output_54_0_g5964 = clampResult1167_g5957;
			float temp_output_72_0_g5964 = cos( temp_output_54_0_g5964 );
			float one_minus_c52_g5964 = ( 1.0 - temp_output_72_0_g5964 );
			float3 break70_g5964 = float3(0,1,0);
			float axis_x25_g5964 = break70_g5964.x;
			float c66_g5964 = temp_output_72_0_g5964;
			float axis_y37_g5964 = break70_g5964.y;
			float axis_z29_g5964 = break70_g5964.z;
			float s67_g5964 = sin( temp_output_54_0_g5964 );
			float3 appendResult83_g5964 = (float3(( ( one_minus_c52_g5964 * axis_x25_g5964 * axis_x25_g5964 ) + c66_g5964 ) , ( ( one_minus_c52_g5964 * axis_x25_g5964 * axis_y37_g5964 ) - ( axis_z29_g5964 * s67_g5964 ) ) , ( ( one_minus_c52_g5964 * axis_z29_g5964 * axis_x25_g5964 ) + ( axis_y37_g5964 * s67_g5964 ) )));
			float3 appendResult81_g5964 = (float3(( ( one_minus_c52_g5964 * axis_x25_g5964 * axis_y37_g5964 ) + ( axis_z29_g5964 * s67_g5964 ) ) , ( ( one_minus_c52_g5964 * axis_y37_g5964 * axis_y37_g5964 ) + c66_g5964 ) , ( ( one_minus_c52_g5964 * axis_y37_g5964 * axis_z29_g5964 ) - ( axis_x25_g5964 * s67_g5964 ) )));
			float3 appendResult82_g5964 = (float3(( ( one_minus_c52_g5964 * axis_z29_g5964 * axis_x25_g5964 ) - ( axis_y37_g5964 * s67_g5964 ) ) , ( ( one_minus_c52_g5964 * axis_y37_g5964 * axis_z29_g5964 ) + ( axis_x25_g5964 * s67_g5964 ) ) , ( ( one_minus_c52_g5964 * axis_z29_g5964 * axis_z29_g5964 ) + c66_g5964 )));
			float3 temp_output_38_0_g5964 = ( ase_vertex3Pos - (_WIND_SECONDARY_PIVOT846_g5957).xyz );
			float3 VALUE_AWAY_FROM_WIND1040_g5957 = ( mul( float3x3(appendResult83_g5964, appendResult81_g5964, appendResult82_g5964), temp_output_38_0_g5964 ) - temp_output_38_0_g5964 );
			float3 lerpResult1_g5967 = lerp( temp_output_3_0_g5966 , VALUE_AWAY_FROM_WIND1040_g5957 , saturate( clampResult13_g5966 ));
			float3 lerpResult631_g5957 = lerp( VALUE_ROLL1034_g5957 , (( clampResult13_g5966 < 0.0 ) ? lerpResult1_g5972 :  lerpResult1_g5967 ) , WIND_GUST_AUDIO_STRENGTH1242_g3999);
			float3 MOTION_BRANCH1339_g3999 = lerpResult631_g5957;
			float WIND_LEAF_STRENGTH1179_g3999 = _WIND_LEAF_STRENGTH;
			float temp_output_17_0_g5852 = 3.0;
			float TYPE_DESIGNATOR1209_g3999 = round( v.texcoord2.w );
			float temp_output_18_0_g5852 = TYPE_DESIGNATOR1209_g3999;
			float WIND_TERTIARY_ROLL1210_g3999 = v.color.b;
			float _WIND_TERTIARY_ROLL669_g5937 = WIND_TERTIARY_ROLL1210_g3999;
			float3 temp_output_615_0_g5874 = ( float3( 0,0,0 ) + ase_vertex3Pos );
			float3 WIND_POSITION_VERTEX_OBJECT1193_g3999 = temp_output_615_0_g5874;
			float2 temp_output_1_0_g5938 = (WIND_POSITION_VERTEX_OBJECT1193_g3999).xz;
			float WIND_BASE_LEAF_FIELD_SIZE1182_g3999 = _WIND_BASE_LEAF_FIELD_SIZE;
			float2 temp_output_2_0_g5938 = (WIND_BASE_LEAF_FIELD_SIZE1182_g3999).xx;
			float _WIND_VARIATION662_g5937 = WIND_PHASE1212_g3999;
			float2 temp_output_3_0_g5938 = (_WIND_VARIATION662_g5937).xx;
			float2 temp_output_704_0_g5937 = ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g5938 / temp_output_2_0_g5938 ) :  ( temp_output_1_0_g5938 * temp_output_2_0_g5938 ) ) + temp_output_3_0_g5938 );
			float temp_output_2_0_g5908 = _WIND_BASE_LEAF_CYCLE_TIME;
			float WIND_BASE_LEAF_FREQUENCY1264_g3999 = ( 1.0 / (( temp_output_2_0_g5908 == 0.0 ) ? 1.0 :  temp_output_2_0_g5908 ) );
			float temp_output_618_0_g5937 = WIND_BASE_LEAF_FREQUENCY1264_g3999;
			float2 break298_g5939 = ( temp_output_704_0_g5937 + ( (temp_output_618_0_g5937).xx * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g5939 = (float2(sin( break298_g5939.x ) , cos( break298_g5939.y )));
			float4 temp_output_273_0_g5939 = (-1.0).xxxx;
			float4 temp_output_271_0_g5939 = (1.0).xxxx;
			float2 clampResult26_g5939 = clamp( appendResult299_g5939 , temp_output_273_0_g5939.xy , temp_output_271_0_g5939.xy );
			float WIND_BASE_LEAF_STRENGTH1180_g3999 = _WIND_BASE_LEAF_STRENGTH;
			float2 temp_output_1031_0_g5937 = (( WIND_BASE_LEAF_STRENGTH1180_g3999 * WIND_BASE_AMPLITUDE1197_g3999 )).xx;
			float2 break699_g5937 = ( clampResult26_g5939 * temp_output_1031_0_g5937 );
			float2 break298_g5943 = ( temp_output_704_0_g5937 + ( (( 0.71 * temp_output_618_0_g5937 )).xx * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g5943 = (float2(sin( break298_g5943.x ) , cos( break298_g5943.y )));
			float4 temp_output_273_0_g5943 = (-1.0).xxxx;
			float4 temp_output_271_0_g5943 = (1.0).xxxx;
			float2 clampResult26_g5943 = clamp( appendResult299_g5943 , temp_output_273_0_g5943.xy , temp_output_271_0_g5943.xy );
			float3 appendResult698_g5937 = (float3(break699_g5937.x , ( clampResult26_g5943 * temp_output_1031_0_g5937 ).x , break699_g5937.y));
			float3 temp_output_684_0_g5937 = ( _WIND_TERTIARY_ROLL669_g5937 * appendResult698_g5937 );
			float3 _WIND_DIRECTION671_g5937 = WIND_DIRECTION1192_g3999;
			float3 worldToObjDir1006_g5937 = mul( unity_WorldToObject, float4( _WIND_DIRECTION671_g5937, 0 ) ).xyz;
			float WIND_GUST_LEAF_STRENGTH1183_g3999 = _WIND_GUST_LEAF_STRENGTH;
			float lerpResult638_g5837 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_VERYHIGH , _WIND_AUDIO_INFLUENCE);
			float WIND_GUST_AUDIO_VERYHIGH1243_g3999 = lerpResult638_g5837;
			float4 color658_g5841 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float2 temp_output_61_0_g5843 = float2( 0,0 );
			float WIND_VARIATION1211_g3999 = v.texcoord.w;
			half localunity_ObjectToWorld0w1_g5651 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld2w3_g5651 = ( unity_ObjectToWorld[2].w );
			float2 appendResult1374_g3999 = (float2(localunity_ObjectToWorld0w1_g5651 , localunity_ObjectToWorld2w3_g5651));
			float2 temp_output_1_0_g5844 = ( ( 10.0 * WIND_VARIATION1211_g3999 ) + appendResult1374_g3999 );
			float WIND_GUST_LEAF_FIELD_SIZE1185_g3999 = _WIND_GUST_LEAF_FIELD_SIZE;
			float temp_output_2_0_g5850 = WIND_GUST_LEAF_FIELD_SIZE1185_g3999;
			float temp_output_40_0_g5843 = ( 1.0 / (( temp_output_2_0_g5850 == 0.0 ) ? 1.0 :  temp_output_2_0_g5850 ) );
			float2 temp_cast_37 = (temp_output_40_0_g5843).xx;
			float2 temp_output_2_0_g5844 = temp_cast_37;
			float2 temp_output_3_0_g5844 = temp_output_61_0_g5843;
			float clampResult3_g5853 = clamp( WIND_VARIATION1211_g3999 , 0.0 , 1.0 );
			float WIND_GUST_LEAF_CYCLE_TIME1184_g3999 = _WIND_GUST_LEAF_CYCLE_TIME;
			float temp_output_2_0_g5842 = ( ( ( ( clampResult3_g5853 * 2.0 ) - 1.0 ) * 0.3 * WIND_GUST_LEAF_CYCLE_TIME1184_g3999 ) + WIND_GUST_LEAF_CYCLE_TIME1184_g3999 );
			float mulTime37_g5843 = _Time.y * ( 1.0 / (( temp_output_2_0_g5842 == 0.0 ) ? 1.0 :  temp_output_2_0_g5842 ) );
			float temp_output_220_0_g5846 = -1.0;
			float4 temp_cast_38 = (temp_output_220_0_g5846).xxxx;
			float temp_output_219_0_g5846 = 1.0;
			float4 temp_cast_39 = (temp_output_219_0_g5846).xxxx;
			float4 clampResult26_g5846 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g5843 > float2( 0,0 ) ) ? ( temp_output_1_0_g5844 / temp_output_2_0_g5844 ) :  ( temp_output_1_0_g5844 * temp_output_2_0_g5844 ) ) + temp_output_3_0_g5844 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g5843 ) ) , temp_cast_38 , temp_cast_39 );
			float4 temp_cast_40 = (temp_output_220_0_g5846).xxxx;
			float4 temp_cast_41 = (temp_output_219_0_g5846).xxxx;
			float4 temp_cast_42 = (0.0).xxxx;
			float4 temp_cast_43 = (temp_output_219_0_g5846).xxxx;
			float temp_output_679_0_g5841 = 1.0;
			float4 temp_cast_44 = (temp_output_679_0_g5841).xxxx;
			float4 temp_output_52_0_g5843 = saturate( pow( abs( (temp_cast_42 + (clampResult26_g5846 - temp_cast_40) * (temp_cast_43 - temp_cast_42) / (temp_cast_41 - temp_cast_40)) ) , temp_cast_44 ) );
			float4 lerpResult656_g5841 = lerp( color658_g5841 , temp_output_52_0_g5843 , temp_output_679_0_g5841);
			float4 break655_g5841 = lerpResult656_g5841;
			float LEAF_GUST1375_g3999 = ( WIND_GUST_LEAF_STRENGTH1183_g3999 * WIND_GUST_AUDIO_VERYHIGH1243_g3999 * break655_g5841.g );
			float _WIND_GUST_STRENGTH703_g5937 = LEAF_GUST1375_g3999;
			float3 _GUST1018_g5937 = ( worldToObjDir1006_g5937 * _WIND_GUST_STRENGTH703_g5937 );
			float WIND_GUST_LEAF_MID_STRENGTH1186_g3999 = _WIND_GUST_LEAF_MID_STRENGTH;
			float lerpResult633_g5837 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_HIGH , _WIND_AUDIO_INFLUENCE);
			float WIND_GUST_AUDIO_HIGH1244_g3999 = lerpResult633_g5837;
			float4 color658_g5800 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float WIND_GUST_LEAF_MID_CYCLE_TIME1187_g3999 = _WIND_GUST_LEAF_MID_CYCLE_TIME;
			float temp_output_2_0_g5801 = ( WIND_GUST_LEAF_MID_CYCLE_TIME1187_g3999 + ( WIND_VARIATION1211_g3999 * -0.05 ) );
			float2 temp_cast_45 = (( 1.0 / (( temp_output_2_0_g5801 == 0.0 ) ? 1.0 :  temp_output_2_0_g5801 ) )).xx;
			float2 temp_output_61_0_g5804 = float2( 0,0 );
			float2 appendResult1400_g3999 = (float2(ase_vertex3Pos.x , ase_vertex3Pos.z));
			float2 temp_output_1_0_g5805 = ( (WIND_VARIATION1211_g3999).xx + appendResult1400_g3999 );
			float WIND_GUST_LEAF_MID_FIELD_SIZE1188_g3999 = _WIND_GUST_LEAF_MID_FIELD_SIZE;
			float temp_output_2_0_g5803 = WIND_GUST_LEAF_MID_FIELD_SIZE1188_g3999;
			float temp_output_40_0_g5804 = ( 1.0 / (( temp_output_2_0_g5803 == 0.0 ) ? 1.0 :  temp_output_2_0_g5803 ) );
			float2 temp_cast_46 = (temp_output_40_0_g5804).xx;
			float2 temp_output_2_0_g5805 = temp_cast_46;
			float2 temp_output_3_0_g5805 = temp_output_61_0_g5804;
			float2 panner90_g5804 = ( _Time.y * temp_cast_45 + ( (( temp_output_61_0_g5804 > float2( 0,0 ) ) ? ( temp_output_1_0_g5805 / temp_output_2_0_g5805 ) :  ( temp_output_1_0_g5805 * temp_output_2_0_g5805 ) ) + temp_output_3_0_g5805 ));
			float temp_output_679_0_g5800 = 1.0;
			float4 temp_cast_47 = (temp_output_679_0_g5800).xxxx;
			float4 temp_output_52_0_g5804 = saturate( pow( tex2Dlod( _WIND_GUST_TEXTURE, float4( panner90_g5804, 0, 0.0) ) , temp_cast_47 ) );
			float4 lerpResult656_g5800 = lerp( color658_g5800 , temp_output_52_0_g5804 , temp_output_679_0_g5800);
			float4 break655_g5800 = lerpResult656_g5800;
			float temp_output_1557_630_g3999 = break655_g5800.r;
			float LEAF_GUST_MID1397_g3999 = ( WIND_GUST_LEAF_MID_STRENGTH1186_g3999 * WIND_GUST_AUDIO_HIGH1244_g3999 * temp_output_1557_630_g3999 * temp_output_1557_630_g3999 );
			float _WIND_GUST_STRENGTH_MID829_g5937 = LEAF_GUST_MID1397_g3999;
			float3 _GUST_MID1019_g5937 = ( worldToObjDir1006_g5937 * _WIND_GUST_STRENGTH_MID829_g5937 );
			float3 ase_vertexNormal = v.normal.xyz;
			float3 _LEAF_NORMAL992_g5937 = ase_vertexNormal;
			float dotResult1_g5949 = dot( worldToObjDir1006_g5937 , _LEAF_NORMAL992_g5937 );
			float clampResult13_g5950 = clamp( dotResult1_g5949 , -1.0 , 1.0 );
			float WIND_GUST_LEAF_MICRO_STRENGTH1189_g3999 = _WIND_GUST_LEAF_MICRO_STRENGTH;
			float4 color658_g5818 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float WIND_GUST_LEAF_MICRO_CYCLE_TIME1190_g3999 = _WIND_GUST_LEAF_MICRO_CYCLE_TIME;
			float temp_output_2_0_g5819 = ( WIND_GUST_LEAF_MICRO_CYCLE_TIME1190_g3999 + ( WIND_VARIATION1211_g3999 * 0.1 ) );
			float2 temp_cast_48 = (( 1.0 / (( temp_output_2_0_g5819 == 0.0 ) ? 1.0 :  temp_output_2_0_g5819 ) )).xx;
			float2 temp_output_61_0_g5822 = float2( 0,0 );
			float2 appendResult1409_g3999 = (float2(ase_vertex3Pos.y , ase_vertex3Pos.z));
			float2 temp_output_1_0_g5823 = ( (WIND_VARIATION1211_g3999).xx + appendResult1409_g3999 );
			float WIND_GUST_LEAF_MICRO_FIELD_SIZE1191_g3999 = _WIND_GUST_LEAF_MICRO_FIELD_SIZE;
			float temp_output_2_0_g5821 = WIND_GUST_LEAF_MICRO_FIELD_SIZE1191_g3999;
			float temp_output_40_0_g5822 = ( 1.0 / (( temp_output_2_0_g5821 == 0.0 ) ? 1.0 :  temp_output_2_0_g5821 ) );
			float2 temp_cast_49 = (temp_output_40_0_g5822).xx;
			float2 temp_output_2_0_g5823 = temp_cast_49;
			float2 temp_output_3_0_g5823 = temp_output_61_0_g5822;
			float2 panner90_g5822 = ( _Time.y * temp_cast_48 + ( (( temp_output_61_0_g5822 > float2( 0,0 ) ) ? ( temp_output_1_0_g5823 / temp_output_2_0_g5823 ) :  ( temp_output_1_0_g5823 * temp_output_2_0_g5823 ) ) + temp_output_3_0_g5823 ));
			float temp_output_679_0_g5818 = 1.0;
			float4 temp_cast_50 = (temp_output_679_0_g5818).xxxx;
			float4 temp_output_52_0_g5822 = saturate( pow( tex2Dlod( _WIND_GUST_TEXTURE, float4( panner90_g5822, 0, 0.0) ) , temp_cast_50 ) );
			float4 lerpResult656_g5818 = lerp( color658_g5818 , temp_output_52_0_g5822 , temp_output_679_0_g5818);
			float4 break655_g5818 = lerpResult656_g5818;
			float LEAF_GUST_MICRO1408_g3999 = ( WIND_GUST_LEAF_MICRO_STRENGTH1189_g3999 * WIND_GUST_AUDIO_VERYHIGH1243_g3999 * break655_g5818.a );
			float _WIND_GUST_STRENGTH_MICRO851_g5937 = LEAF_GUST_MICRO1408_g3999;
			float clampResult3_g5947 = clamp( _WIND_GUST_STRENGTH_MICRO851_g5937 , 0.0 , 1.0 );
			float temp_output_3_0_g5950 = ( ( clampResult3_g5947 * 2.0 ) - 1.0 );
			float lerpResult1_g5956 = lerp( ( _WIND_GUST_STRENGTH_MICRO851_g5937 - 1.0 ) , temp_output_3_0_g5950 , saturate( ( 1.0 + clampResult13_g5950 ) ));
			float lerpResult1_g5951 = lerp( temp_output_3_0_g5950 , _WIND_GUST_STRENGTH_MICRO851_g5937 , saturate( clampResult13_g5950 ));
			float3 _GUST_MICRO1020_g5937 = ( worldToObjDir1006_g5937 * (( clampResult13_g5950 < 0.0 ) ? lerpResult1_g5956 :  lerpResult1_g5951 ) );
			float3 lerpResult538_g5937 = lerp( temp_output_684_0_g5937 , ( temp_output_684_0_g5937 + ( ( _GUST1018_g5937 + _GUST_MID1019_g5937 + _GUST_MICRO1020_g5937 ) * _WIND_TERTIARY_ROLL669_g5937 ) ) , WIND_GUST_AUDIO_STRENGTH1242_g3999);
			float3 MOTION_LEAF1343_g3999 = lerpResult538_g5937;
			float3 temp_output_19_0_g5852 = MOTION_LEAF1343_g3999;
			float3 temp_output_20_0_g5852 = float3(0,0,0);
			float3 temp_cast_51 = (0.0).xxx;
			float4 break360_g3995 = v.ase_texcoord4;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 temp_output_356_0_g3995 = ( ase_worldPos - (_WorldSpaceCameraPos).xyz );
			float3 normalizeResult358_g3995 = normalize( temp_output_356_0_g3995 );
			float3 cam_pos_axis_z384_g3995 = normalizeResult358_g3995;
			float3 normalizeResult366_g3995 = normalize( cross( float3(0,1,0) , cam_pos_axis_z384_g3995 ) );
			float3 cam_pos_axis_x385_g3995 = normalizeResult366_g3995;
			float4x4 break375_g3995 = UNITY_MATRIX_V;
			float3 appendResult377_g3995 = (float3(break375_g3995[ 0 ][ 0 ] , break375_g3995[ 0 ][ 1 ] , break375_g3995[ 0 ][ 2 ]));
			float3 cam_rot_axis_x378_g3995 = appendResult377_g3995;
			float dotResult436_g3995 = dot( float3(0,1,0) , temp_output_356_0_g3995 );
			float temp_output_438_0_g3995 = saturate( abs( dotResult436_g3995 ) );
			float3 lerpResult424_g3995 = lerp( cam_pos_axis_x385_g3995 , cam_rot_axis_x378_g3995 , temp_output_438_0_g3995);
			float3 xAxis346_g3995 = lerpResult424_g3995;
			float3 cam_pos_axis_y383_g3995 = cross( cam_pos_axis_z384_g3995 , normalizeResult366_g3995 );
			float3 appendResult381_g3995 = (float3(break375_g3995[ 1 ][ 0 ] , break375_g3995[ 1 ][ 1 ] , break375_g3995[ 1 ][ 2 ]));
			float3 cam_rot_axis_y379_g3995 = appendResult381_g3995;
			float3 lerpResult423_g3995 = lerp( cam_pos_axis_y383_g3995 , cam_rot_axis_y379_g3995 , temp_output_438_0_g3995);
			float3 yAxis362_g3995 = lerpResult423_g3995;
			float isBillboard343_g3995 = (( break360_g3995.w < -0.99999 ) ? 1.0 :  0.0 );
			#ifdef _ENABLEBILLBOARDS_ON
				float3 staticSwitch2151 = ( -( ( break360_g3995.x * xAxis346_g3995 ) + ( break360_g3995.y * yAxis362_g3995 ) ) * isBillboard343_g3995 * -1.0 );
			#else
				float3 staticSwitch2151 = temp_cast_51;
			#endif
			v.vertex.xyz += ( ( ( WIND_TRUNK_STRENGTH1235_g3999 * MOTION_TRUNK1337_g3999 ) + ( WIND_BRANCH_STRENGTH1224_g3999 * MOTION_BRANCH1339_g3999 ) + ( WIND_LEAF_STRENGTH1179_g3999 * (( temp_output_17_0_g5852 == temp_output_18_0_g5852 ) ? temp_output_19_0_g5852 :  temp_output_20_0_g5852 ) ) ) + staticSwitch2151 );
			float3 appendResult382_g3995 = (float3(break375_g3995[ 2 ][ 0 ] , break375_g3995[ 2 ][ 1 ] , break375_g3995[ 2 ][ 2 ]));
			float3 cam_rot_axis_z380_g3995 = appendResult382_g3995;
			float3 lerpResult422_g3995 = lerp( cam_pos_axis_z384_g3995 , cam_rot_axis_z380_g3995 , temp_output_438_0_g3995);
			float3 zAxis421_g3995 = lerpResult422_g3995;
			float3 lerpResult331_g3995 = lerp( ase_vertexNormal , ( -1.0 * zAxis421_g3995 ) , isBillboard343_g3995);
			float3 normalizeResult326_g3995 = normalize( lerpResult331_g3995 );
			#ifdef _ENABLEBILLBOARDS_ON
				float3 staticSwitch2156 = normalizeResult326_g3995;
			#else
				float3 staticSwitch2156 = ase_vertexNormal;
			#endif
			v.normal = staticSwitch2156;
			float4 ase_vertexTangent = v.tangent;
			float4 appendResult345_g3995 = (float4(xAxis346_g3995 , -1.0));
			float4 lerpResult341_g3995 = lerp( float4( ase_vertexTangent.xyz , 0.0 ) , appendResult345_g3995 , isBillboard343_g3995);
			#ifdef _ENABLEBILLBOARDS_ON
				float4 staticSwitch2157 = lerpResult341_g3995;
			#else
				float4 staticSwitch2157 = float4( ase_vertexTangent.xyz , 0.0 );
			#endif
			v.tangent = staticSwitch2157;
		}

		inline half4 LightingStandardCustom(SurfaceOutputStandardCustom s, half3 viewDir, UnityGI gi )
		{
			#if !DIRECTIONAL
			float3 lightAtten = gi.light.color;
			#else
			float3 lightAtten = lerp( _LightColor0.rgb, gi.light.color, _TransShadow );
			#endif
			half3 lightDir = gi.light.dir + s.Normal * _TransNormalDistortion;
			half transVdotL = pow( saturate( dot( viewDir, -lightDir ) ), _TransScattering );
			half3 translucency = lightAtten * (transVdotL * _TransDirect + gi.indirect.diffuse * _TransAmbient) * s.Translucency;
			half4 c = half4( s.Albedo * translucency * _Translucency, 0 );

			SurfaceOutputStandard r;
			r.Albedo = s.Albedo;
			r.Normal = s.Normal;
			r.Emission = s.Emission;
			r.Metallic = s.Metallic;
			r.Smoothness = s.Smoothness;
			r.Occlusion = s.Occlusion;
			r.Alpha = s.Alpha;
			return LightingStandard (r, viewDir, gi) + c;
		}

		inline void LightingStandardCustom_GI(SurfaceOutputStandardCustom s, UnityGIInput data, inout UnityGI gi )
		{
			#if defined(UNITY_PASS_DEFERRED) && UNITY_ENABLE_REFLECTION_BUFFERS
				gi = UnityGlobalIllumination(data, s.Occlusion, s.Normal);
			#else
				UNITY_GLOSSY_ENV_FROM_SURFACE( g, s, data );
				gi = UnityGlobalIllumination( data, s.Occlusion, s.Normal, g );
			#endif
		}

		void surf( Input i , inout SurfaceOutputStandardCustom o )
		{
			float2 uvBumpMap607 = i.uv_texcoord;
			float3 tex2DNode607 = UnpackScaleNormal( tex2D( BumpMap, uvBumpMap607 ), _NormalScale );
			half3 MainBumpMap620 = tex2DNode607;
			o.Normal = MainBumpMap620;
			float2 uv_MainTex18 = i.uv_texcoord;
			float4 tex2DNode18 = tex2D( _MainTex, uv_MainTex18 );
			float3 hsvTorgb1964 = RGBToHSV( tex2DNode18.rgb );
			float3 hsvTorgb1963 = HSVToRGB( float3(hsvTorgb1964.x,( hsvTorgb1964.y * _Saturation ),( hsvTorgb1964.z * _Brightness )) );
			half3 Main_MainTex487 = hsvTorgb1963;
			half4 Other_Color1998 = _Color3;
			half4 Leaf_Color486 = _Color;
			float2 uv_MetallicGlossMap645 = i.uv_texcoord;
			float4 tex2DNode645 = tex2D( _MetallicGlossMap, uv_MetallicGlossMap645 );
			half Main_MetallicGlossMap_B1836 = tex2DNode645.b;
			float4 lerpResult2000 = lerp( Other_Color1998 , Leaf_Color486 , Main_MetallicGlossMap_B1836);
			o.Albedo = saturate( ( float4( Main_MainTex487 , 0.0 ) * lerpResult2000 ) ).rgb;
			half Main_MetallicGlossMap_A744 = tex2DNode645.a;
			half SMOOTHNESS660 = ( Main_MetallicGlossMap_A744 * _Smoothness );
			o.Smoothness = SMOOTHNESS660;
			half Main_MetallicGlossMap_G1788 = tex2DNode645.g;
			float lerpResult1793 = lerp( 1.0 , Main_MetallicGlossMap_G1788 , _Occlusion);
			half Main_Occlusion1794 = lerpResult1793;
			float lerpResult1308 = lerp( 1.0 , i.uv_tex4coord.z , _VertexOcclusion);
			half Vertex_Occlusion1312 = lerpResult1308;
			o.Occlusion = ( Main_Occlusion1794 * Vertex_Occlusion1312 );
			float temp_output_2217_0 = 0.0;
			half OUT_TRANSLUCENCY2166 = Main_MetallicGlossMap_B1836;
			#ifdef _ENABLETRANSLUCENCY_ON
				float staticSwitch2148 = OUT_TRANSLUCENCY2166;
			#else
				float staticSwitch2148 = temp_output_2217_0;
			#endif
			float3 temp_cast_3 = (staticSwitch2148).xxx;
			o.Translucency = temp_cast_3;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AppalachiaShaderGUI"
}
/*ASEBEGIN
Version=17500
-429.3333;-960;1706.667;939;-1625.478;2352.521;1;True;False
Node;AmplifyShaderEditor.SamplerNode;18;-1786,-854.5;Inherit;True;Property;_MainTex;Leaf Albedo;18;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1965;-1488,-512;Inherit;False;Property;_Brightness;Leaf Brightness;22;0;Create;False;0;0;False;0;1;1;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;645;1536,-896;Inherit;True;Property;_MetallicGlossMap;Leaf Surface;25;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1967;-1488,-592;Inherit;False;Property;_Saturation;Leaf Saturation;21;0;Create;False;0;0;False;0;1;1;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;1964;-1376,-848;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode;409;-400,-864;Half;False;Property;_Color;Leaf Color;19;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1788;1920,-803;Half;False;Main_MetallicGlossMap_G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1966;-1120,-704;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1997;-383,-688;Half;False;Property;_Color3;Non-Leaf Color;20;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1968;-1120,-592;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1836;1922,-733;Half;False;Main_MetallicGlossMap_B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1309;0,192;Half;False;Property;_VertexOcclusion;Vertex Occlusion;28;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;744;1922,-632;Half;False;Main_MetallicGlossMap_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;-128,-864;Half;False;Leaf_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1792;896,192;Half;False;Property;_Occlusion;Texture Occlusion;27;0;Create;False;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1795;896,0;Inherit;False;1788;Main_MetallicGlossMap_G;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1932;3157.72,-876.6875;Inherit;False;1836;Main_MetallicGlossMap_B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.HSVToRGBNode;1963;-928,-816;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FunctionNode;2210;895.382,-127.3066;Inherit;False;const;-1;;1668;5b64729fb717c5f49a1bc2dab81d5e1c;4,21,0,3,1,22,0,28,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2209;0,-128;Inherit;False;const;-1;;1667;5b64729fb717c5f49a1bc2dab81d5e1c;4,21,0,3,1,22,0,28,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1814;0,0;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1998;-112,-688;Half;False;Other_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1999;-227,-2817;Inherit;False;1998;Other_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;655;251,-875;Half;False;Property;_NormalScale;Leaf Normal Scale;24;0;Create;False;0;0;False;0;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;294;2304,-816;Half;False;Property;_Smoothness;Leaf Smoothness;26;0;Create;False;0;0;False;0;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1308;384,-128;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1076;-238,-2731;Inherit;False;486;Leaf_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;2167;3556.386,-891.8448;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1793;1280,-128;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2001;-293,-2636;Inherit;False;1836;Main_MetallicGlossMap_B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;-672,-816;Half;False;Main_MainTex;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;749;2304,-896;Inherit;False;744;Main_MetallicGlossMap_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;745;2624,-896;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2214;1558,-1310;Inherit;False;const;-1;;3994;5b64729fb717c5f49a1bc2dab81d5e1c;4,21,0,3,0,22,0,28,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2212;1536,-1408;Inherit;False;Pivot Billboard;-1;;3995;50ed44a1d0e6ecb498e997b8969f8558;3,431,2,432,2,433,2;0;3;FLOAT3;370;FLOAT3;369;FLOAT4;371
Node;AmplifyShaderEditor.LerpOp;2000;197.1434,-2623.154;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;607;577,-897;Inherit;True;Property;BumpMap;Leaf Normal;23;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1312;576,-128;Half;False;Vertex_Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;36;-256,-3008;Inherit;False;487;Main_MainTex;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2166;4224,-898.7999;Half;False;OUT_TRANSLUCENCY;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1794;1472,-128;Half;False;Main_Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2217;1312,-1920;Inherit;False;const;-1;;5986;5b64729fb717c5f49a1bc2dab81d5e1c;4,21,0,3,0,22,0,28,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;2151;1792,-1408;Inherit;False;Property;_EnableBillboards;Enable Billboards;38;0;Create;True;0;0;False;0;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TangentVertexDataNode;2182;1379.794,-1188.692;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1800;338.1745,-2149.904;Inherit;False;1794;Main_Occlusion;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;620;1211.056,-888.0615;Half;False;MainBumpMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2168;1078.2,-1759.24;Inherit;False;2166;OUT_TRANSLUCENCY;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;660;2816,-896;Half;False;SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1075;439.3946,-2644.607;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1313;-391.4934,-2014.11;Inherit;False;1312;Vertex_Occlusion;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;2181;1358.794,-1284.692;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;2213;1280,-1504;Inherit;False;Wind (Tree Complex);39;;3999;76dbe6e88a5c02e42a177b05b9981ead;2,981,1,983,1;0;8;FLOAT3;0;FLOAT;1021;FLOAT;1022;FLOAT;1023;FLOAT;1024;FLOAT;1027;FLOAT;1025;FLOAT;1454
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1898;727.225,-2027.046;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1306;-536.4846,-140.9208;Half;False;Opacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1783;345.9734,-1479.933;Inherit;False;1306;Opacity;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1985;634.9156,-1365.517;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2125;0,-1248;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2211;939.5969,-1716.612;Inherit;False;const;-1;;3993;5b64729fb717c5f49a1bc2dab81d5e1c;4,21,0,3,1,22,0,28,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2138;222.469,-1281.65;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1819;-1158,838.6452;Half;False;Packed_Leaf;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2132;0,-1392;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;1981;844.3677,-1552.961;Inherit;False;clip( opacity - cutoff )@;7;False;2;True;opacity;FLOAT;0;In;;Float;False;True;cutoff;FLOAT;0;In;;Float;False;My Custom Expression;False;False;0;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1889;-945.4851,-123.9208;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1982;-640,-1200;Half;False;Property;_CutoffHighFar;Cutoff High (Far);16;0;Create;True;3;Off;0;Front;1;Back;2;0;True;0;0.6;0.6;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;1804;-1542,678.6452;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;1890;-680.485,-140.9208;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;862;-640,-1280;Half;False;Property;_CutoffLowFar;Cutoff Low (Far);15;0;Create;True;3;Off;0;Front;1;Back;2;0;True;0;0.1;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1958;-321.4361,-1766.298;Half;False;Property;_OcclusionTransmissionDamping;Occlusion Transmission Damping;29;0;Create;False;0;0;False;0;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2124;-640,-1664;Half;False;Property;_CutoffLowNear;Cutoff Low (Near);12;0;Create;True;3;Off;0;Front;1;Back;2;0;True;0;0.75;0.75;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2123;-640,-1584;Half;False;Property;_CutoffHighNear;Cutoff High (Near);13;0;Create;True;3;Off;0;Front;1;Back;2;0;True;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;2133;-720,-1440;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1343;732.8427,-2545.256;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1809;-902.0001,934.6452;Half;False;Packed_Trunk2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1973;-299.6173,-1874.01;Inherit;False;Constant;_Float6;Float 6;58;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1888;-1207.485,-128.9208;Inherit;False;616;Main_MainTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2126;-1294,-1237;Half;False;Property;_CutoffFar;Cutoff Far;14;0;Create;True;3;Off;0;Front;1;Back;2;0;True;0;64;64;64;1024;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;2131;-1229,-1386;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMaxOpNode;2178;1046.597,-1629.612;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;2128;-1229,-1562;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;616;-1456,-688;Half;False;Main_MainTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2165;3631.557,-814.8096;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2163;3491.557,-831.8096;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2216;1344,-2048;Inherit;False;const;-1;;5987;5b64729fb717c5f49a1bc2dab81d5e1c;4,21,0,3,1,22,0,28,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1934;4043.401,-535.0499;Inherit;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1933;3207.432,-532.6932;Half;False;Property;_SubsurfaceColor;Leaf Subsurface Color;32;0;Create;False;0;0;False;0;1,1,1,1;0.7416955,0.85,0.2655126,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1954;3171.987,-340.1649;Half;False;Property;_Transmission;Leaf Transmission;33;0;Create;False;0;0;False;0;0.5;4.9;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;2129;-921.9014,-1505.571;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1976;3791.683,-689.1483;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;2164;3485.557,-694.8096;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1815;-1158,1062.645;Half;False;Packed_Variation;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2134;-576,-1440;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1938;582.0828,-1807.159;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;549;2433.32,985.7433;Half;False;Property;_RenderType;Render Type;10;1;[Enum];Create;True;2;Opaque;0;Cutout;1;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;654;-377.3445,-2365.83;Inherit;False;660;SMOOTHNESS;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1935;4224,-544;Half;False;OUT_TRANSMISSION;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1974;3143.968,-781.4052;Half;False;Property;_TransmissionCutoff;Leaf Transmission Cutoff;34;0;Create;False;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1931;-1519.281,-24.19777;Inherit;False;Appalachia Leaves Amount;-1;;5988;ee8761bdf5e2c1e4b8e0ff49e8488b33;0;1;152;FLOAT;0;False;3;FLOAT;154;FLOAT;148;FLOAT;167
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1808;-1158,934.6452;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;2147;1565,-1920;Inherit;False;Property;_EnableTransmission;Enable Transmission;31;0;Create;True;0;0;False;0;0;1;0;True;;Toggle;2;Key0;Key1;Create;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1924;-1759.281,-104.1978;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1830;-1158,758.6452;Half;False;Packed_Branch;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;2156;1792,-1296;Inherit;False;Property;_Billboards;Billboards;65;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Reference;2151;True;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1865;-1158,678.6452;Half;False;Packed_Trunk;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2159;640,1168;Half;False;Property;_TRANSLUCENCYY;[ TRANSLUCENCYY ];35;0;Create;True;0;0;True;1;InternalCategory(Translucency);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1978;-1119.281,-24.19777;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1977;916.9426,-733.5687;Inherit;False;Normal BackFace;-1;;5990;121446c878db06f4c847f9c5afed7cfe;0;1;13;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;2148;1536,-1808;Inherit;False;Property;_EnableTranslucency;Enable Translucency;36;0;Create;True;0;0;False;0;0;1;0;True;;Toggle;2;Key0;Key1;Create;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;743;2609.32,985.7433;Half;False;Property;_RenderFaces;Render Faces;11;1;[Enum];Create;True;3;Two Sided;0;Back;1;Front;2;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1996;-1334.802,429.8153;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1992;-1564,420.6451;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1986;275.7517,-1366.932;Inherit;False;1819;Packed_Leaf;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;624;1382.341,-2264.02;Inherit;False;620;MainBumpMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;553;2113.32,985.7433;Half;False;Property;_DstBlend;_DstBlend;72;1;[HideInInspector];Create;True;0;0;False;0;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1941;576.1029,-1472.322;Inherit;False;Appalachia LODFade Dither;-1;;3984;f1eaf6a5452c7c7458970a3fc3fa22c1;0;0;0
Node;AmplifyShaderEditor.SimpleMinOpNode;2179;1218.597,-1688.612;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1937;135.9433,-1691.649;Inherit;False;1935;OUT_TRANSMISSION;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;2157;1792,-1184;Inherit;False;Property;_Billboards;Billboards;53;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Reference;2151;True;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1908;-704,1920;Half;False;Gloabl_Tint;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1469;1217.32,1081.743;Half;False;Property;_SETTINGSS;[ SETTINGSS ];37;0;Create;True;0;0;True;1;InternalCategory(Settings);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;925;2273.32,985.7433;Half;False;Property;_ZWrite;_ZWrite;73;1;[HideInInspector];Create;True;2;Off;0;On;1;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1472;673.3196,985.7433;Half;False;Property;_BANNER;BANNER;8;0;Create;True;0;0;True;1;InternalBanner(Internal, Leaf);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;646;1920,-896;Half;False;Main_MetallicGlossMap_R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1990;897.3197,1177.743;Half;False;Property;_TRANSMISSION;[ TRANSMISSION ];30;0;Create;True;0;0;True;1;InternalCategory(Transmission);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2218;-1024,1920;Inherit;False;Appalachia Global Settings;66;;5991;95705fd913244e94ba3077d52471de69;0;1;171;FLOAT;0;False;3;COLOR;85;COLOR;165;FLOAT;157
Node;AmplifyShaderEditor.SimpleAddOpNode;2006;2048,-1664;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;550;1953.32,985.7433;Half;False;Property;_SrcBlend;_SrcBlend;71;1;[HideInInspector];Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1468;865.3197,1081.743;Half;False;Property;_LEAFF;[ LEAFF ];17;0;Create;True;0;0;True;1;InternalCategory(Leaf);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1995;-1137.802,520.8154;Half;False;Is_Billboard;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1466;673.3196,1081.743;Half;False;Property;_RENDERINGG;[ RENDERINGG ];9;0;Create;True;0;0;True;1;InternalCategory(Rendering);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1905;-1281,1921;Inherit;False;1815;Packed_Variation;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1993;-1139.802,419.8153;Half;False;Billboard_Pivot;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;1972;36.97489,-1890.025;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2623.32,-2094.93;Float;False;True;-1;2;AppalachiaShaderGUI;300;0;Standard;appalachia/backup/leaf-20200322;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;False;True;False;False;False;True;Off;0;False;925;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0;True;True;0;False;TransparentCutout;;AlphaTest;ForwardOnly;12;d3d9;d3d11_9x;d3d11;glcore;gles3;metal;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;550;10;False;553;0;1;False;550;10;False;553;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;False;False;_BILLBOARD_ON;Relative;300;;0;1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;14;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;1544;0,-256;Inherit;False;1668.041;100;Ambient Occlusion;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;683;1953.32,857.7433;Inherit;False;1104;100;Rendering (Unused);0;;1,0,0.503,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;715;1536,-1024;Inherit;False;638;100;Surface Texture (Metallic, AO, SubSurface, Smoothness);0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;760;-1776,-1024;Inherit;False;1837.602;125.5097;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1465;673.3196,857.7433;Inherit;False;1137.724;100;Drawers;0;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1543;-1759.281,-280.1978;Inherit;False;1412.571;104.0218;Leaf Amount;0;;0.5,0.5,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;751;2304,-1024;Inherit;False;709.9668;100;Metallic / Smoothness;0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1913;-1280,1792;Inherit;False;772.918;100;Globals;0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1936;3200,-1024;Inherit;False;770.26;100;Transmission;0;;0.7843137,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;708;384,-1024;Inherit;False;1027.031;100;Normal Texture;0;;0.5019608,0.5019608,1,1;0;0
WireConnection;1964;0;18;0
WireConnection;1788;0;645;2
WireConnection;1966;0;1964;2
WireConnection;1966;1;1967;0
WireConnection;1968;0;1964;3
WireConnection;1968;1;1965;0
WireConnection;1836;0;645;3
WireConnection;744;0;645;4
WireConnection;486;0;409;0
WireConnection;1963;0;1964;1
WireConnection;1963;1;1966;0
WireConnection;1963;2;1968;0
WireConnection;1998;0;1997;0
WireConnection;1308;0;2209;0
WireConnection;1308;1;1814;3
WireConnection;1308;2;1309;0
WireConnection;2167;0;1932;0
WireConnection;1793;0;2210;0
WireConnection;1793;1;1795;0
WireConnection;1793;2;1792;0
WireConnection;487;0;1963;0
WireConnection;745;0;749;0
WireConnection;745;1;294;0
WireConnection;2000;0;1999;0
WireConnection;2000;1;1076;0
WireConnection;2000;2;2001;0
WireConnection;607;5;655;0
WireConnection;1312;0;1308;0
WireConnection;2166;0;2167;0
WireConnection;1794;0;1793;0
WireConnection;2151;1;2214;0
WireConnection;2151;0;2212;370
WireConnection;620;0;607;0
WireConnection;660;0;745;0
WireConnection;1075;0;36;0
WireConnection;1075;1;2000;0
WireConnection;1898;0;1800;0
WireConnection;1898;1;1313;0
WireConnection;1306;0;1890;0
WireConnection;1985;0;1986;0
WireConnection;1985;3;2138;0
WireConnection;1985;4;2125;0
WireConnection;2125;0;2123;0
WireConnection;2125;1;1982;0
WireConnection;2125;2;2134;0
WireConnection;2138;0;2132;0
WireConnection;1819;0;1804;3
WireConnection;2132;0;2124;0
WireConnection;2132;1;862;0
WireConnection;2132;2;2134;0
WireConnection;1981;2;1985;0
WireConnection;1889;0;1888;0
WireConnection;1890;0;1889;0
WireConnection;2133;0;2129;0
WireConnection;2133;1;2126;0
WireConnection;1343;0;1075;0
WireConnection;1809;0;1808;0
WireConnection;2178;0;2211;0
WireConnection;2178;1;1981;0
WireConnection;616;0;18;4
WireConnection;2165;0;2163;0
WireConnection;2163;0;1932;0
WireConnection;2163;1;1974;0
WireConnection;1934;0;1976;0
WireConnection;1934;1;1933;0
WireConnection;1934;2;1954;0
WireConnection;2129;0;2128;0
WireConnection;2129;1;2131;0
WireConnection;1976;0;2165;0
WireConnection;1976;2;2164;0
WireConnection;2164;0;1974;0
WireConnection;1815;0;1804;4
WireConnection;2134;0;2133;0
WireConnection;1938;0;1972;0
WireConnection;1938;1;1937;0
WireConnection;1935;0;1934;0
WireConnection;1931;152;1924;4
WireConnection;1808;0;1804;1
WireConnection;1808;1;1804;1
WireConnection;2147;1;2217;0
WireConnection;2147;0;1938;0
WireConnection;1830;0;1804;2
WireConnection;2156;1;2181;0
WireConnection;2156;0;2212;369
WireConnection;1865;0;1804;1
WireConnection;1978;0;1931;154
WireConnection;1977;13;607;0
WireConnection;2148;1;2217;0
WireConnection;2148;0;2168;0
WireConnection;1996;0;1992;1
WireConnection;1996;1;1992;2
WireConnection;1996;2;1992;3
WireConnection;2179;0;2211;0
WireConnection;2179;1;2178;0
WireConnection;2157;1;2182;0
WireConnection;2157;0;2212;371
WireConnection;1908;0;2218;165
WireConnection;646;0;645;1
WireConnection;2218;171;1905;0
WireConnection;2006;0;2213;0
WireConnection;2006;1;2151;0
WireConnection;1995;0;1992;4
WireConnection;1993;0;1996;0
WireConnection;1972;0;1973;0
WireConnection;1972;1;1313;0
WireConnection;1972;2;1958;0
WireConnection;0;0;1343;0
WireConnection;0;1;624;0
WireConnection;0;4;654;0
WireConnection;0;5;1898;0
WireConnection;0;7;2148;0
WireConnection;0;11;2006;0
WireConnection;0;12;2156;0
WireConnection;0;13;2157;0
ASEEND*/
//CHKSM=1A93FEF6A6F227035F9978AFCD11FB88A2F44F8D