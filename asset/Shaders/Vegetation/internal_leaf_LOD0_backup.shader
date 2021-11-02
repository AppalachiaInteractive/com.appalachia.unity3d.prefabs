Shader "appalachia/leaf_LOD0_backup"
{
	Properties
	{
		[Header(Translucency)]
		[HideInInspector][AppalachiaCategory(Backshading)]_BACKSHADINGG("[ BACKSHADINGG ]", Float) = 0
		_Backshade("Backshade", Color) = (0,0,0,0.3294118)
		_Translucency("Strength", Range( 0 , 50)) = 1
		_BackshadingBias("Backshading Bias", Range( -1 , 1)) = 0
		_TransNormalDistortion("Normal Distortion", Range( 0 , 1)) = 0.1
		_BackshadingPower("Backshading Power", Range( 1 , 10)) = 2
		_TransScattering("Scattering Falloff", Range( 0 , 50)) = 2
		_BackshadingContrast("Backshading Contrast", Range( 0.1 , 5)) = 3
		_TransDirect("Direct", Range( 0 , 1)) = 1
		_TransAmbient("Ambient", Range( 0 , 1)) = 0.2
		_TransShadow("Shadow", Range( 0 , 1)) = 0.9
		[AppalachiaCategory(Cutoff)]_CUTOFFF("[ CUTOFFF ]", Float) = 0
		[AppalachiaBanner(Internal, Leaf)]_BANNER("BANNER", Float) = 1
		[AppalachiaCategory(Rendering)]_RENDERINGG("[ RENDERINGG ]", Float) = 0
		_CutoffLowNear("Cutoff Low (Near)", Range( 0 , 1)) = 0.75
		_CutoffHighNear("Cutoff High (Near)", Range( 0 , 1)) = 1
		_CutoffFar("Cutoff Far", Range( 64 , 1024)) = 64
		_CutoffLowFar("Cutoff Low (Far)", Range( 0 , 1)) = 0.1
		_CutoffHighFar("Cutoff High (Far)", Range( 0 , 1)) = 0.6
		[AppalachiaCategory(Leaf)]_LEAFF("[ LEAFF ]", Float) = 0
		[NoScaleOffset]_MainTex("Leaf Albedo", 2D) = "white" {}
		[NoScaleOffset]_BumpMap("Leaf Normal", 2D) = "bump" {}
		_BumpScale("Leaf Normal Scale", Range( 0 , 5)) = 1
		[NoScaleOffset]_MetallicGlossMap("Leaf Surface", 2D) = "white" {}
		_Glossiness("Leaf Smoothness", Range( 0 , 1)) = 0.5
		_Occlusion("Texture Occlusion", Range( 0 , 1)) = 0.5
		_VertexOcclusion("Vertex Occlusion", Range( 0 , 1)) = 0.5
		[AppalachiaCategory(Color)]_COLORR("[ COLORR ]", Float) = 0
		_Saturation("Leaf Saturation", Range( 0 , 4)) = 1
		_Brightness("Leaf Brightness", Range( 0 , 4)) = 1
		_Color("Leaf Color", Color) = (1,1,1,1)
		_LeafColor2("Leaf Color 2", Color) = (1,1,1,1)
		_NonLeafColor("Non-Leaf Color", Color) = (1,1,1,1)
		[NoScaleOffset]_ColorMap("Color Map", 2D) = "white" {}
		_ColorMapScale("Color Map Scale", Range( 0.1 , 2048)) = 10
		_ColorMapContrast("Color Map Contrast", Range( 0.1 , 2)) = 1
		_NonLeafFadeColor("Non-Leaf Fade Color", Color) = (0.3773585,0.3773585,0.3773585,1)
		_NonLeafFadeStrength("Non-Leaf Fade Strength", Range( 0 , 2)) = 0.1
		[AppalachiaCategory(Translucency)]_TRANSLUCENCYY("[ TRANSLUCENCYY ]", Float) = 0
		_OcclusionTransmissionDamping("Occlusion Transmission Damping", Range( 0 , 1)) = 0.5
		_TranlucencyFadeDistance("Tranlucency Fade Distance", Range( 12 , 256)) = 64
		_TranlucencyFadeOffset("Tranlucency Fade Offset", Range( 12 , 256)) = 24
		_SubsurfaceColor("Leaf Subsurface Color", Color) = (1,1,1,1)
		_TransmissionCutoff("Leaf Transmission Cutoff", Range( 0 , 0.25)) = 0.25
		_TransmissionCutoff1("Leaf Transmission Albedo Blend", Range( 0 , 1)) = 0.25
		[AppalachiaCategory(Backshading)]_BACKSHADINGG("[ BACKSHADINGG ]", Float) = 0
		[AppalachiaCategory(Settings)]_SETTINGSS("[ SETTINGSS ]", Float) = 0
		[HideInInspector][Toggle]_IsLeaf("Is Leaf", Float) = 0
		[HideInInspector][Toggle]_IsBark("Is Bark", Float) = 0
		[HideInInspector][Toggle]_IsShadow("Is Shadow", Float) = 0
		[HideInInspector] _tex4coord3( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "DisableBatching" = "True" }
		LOD 400
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#pragma target 4.0
		#pragma multi_compile_instancing
		 
		// INTERNAL_SHADER_FEATURE_START
		// INTERNAL_SHADER_FEATURE_END
		  
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
			half ASEVFace : VFACE;
			float4 uv3_tex4coord3;
			float4 vertexColor : COLOR;
			float4 uv_tex4coord;
			float eyeDepth;
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

		uniform half _CutoffLowNear;
		uniform half _CutoffHighNear;
		uniform half _CutoffHighFar;
		uniform half _CutoffLowFar;
		uniform half _CutoffFar;
		uniform half _CUTOFFF;
		uniform half _BACKSHADINGG;
		uniform half _TRANSLUCENCYY;
		uniform half _COLORR;
		uniform half _SETTINGSS;
		uniform half _LEAFF;
		uniform half _IsBark;
		uniform half _IsShadow;
		uniform half _RENDERINGG;
		uniform half _IsLeaf;
		uniform half _BANNER;
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
		uniform half _BumpScale;
		uniform sampler2D _BumpMap;
		uniform sampler2D _MainTex;
		uniform half4 _Color;
		uniform half4 _LeafColor2;
		uniform half4 _NonLeafColor;
		uniform float _ColorMapContrast;
		uniform sampler2D _ColorMap;
		uniform float _ColorMapScale;
		uniform float _Saturation;
		uniform float _Brightness;
		uniform sampler2D _MetallicGlossMap;
		uniform half4 _NonLeafFadeColor;
		uniform float _NonLeafFadeStrength;
		uniform float4 _Backshade;
		uniform float _BackshadingContrast;
		uniform float _BackshadingBias;
		uniform float _BackshadingPower;
		uniform half _Glossiness;
		uniform half _Occlusion;
		uniform half _VertexOcclusion;
		uniform half _Translucency;
		uniform half _TransNormalDistortion;
		uniform half _TransScattering;
		uniform half _TransDirect;
		uniform half _TransAmbient;
		uniform half _TransShadow;
		uniform half _OcclusionTransmissionDamping;
		uniform half _TransmissionCutoff;
		uniform half4 _SubsurfaceColor;
		uniform half _TransmissionCutoff1;
		uniform half _TranlucencyFadeDistance;
		uniform half _TranlucencyFadeOffset;


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

		void vertexDataFunc( inout appdata_full_custom v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float WIND_TRUNK_STRENGTH1235_g18688 = _WIND_TRUNK_STRENGTH;
			half localunity_ObjectToWorld0w1_g18767 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g18767 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g18767 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g18767 = (float3(localunity_ObjectToWorld0w1_g18767 , localunity_ObjectToWorld1w2_g18767 , localunity_ObjectToWorld2w3_g18767));
			float3 WIND_POSITION_OBJECT1195_g18688 = appendResult6_g18767;
			float2 temp_output_1_0_g18728 = (WIND_POSITION_OBJECT1195_g18688).xz;
			float WIND_BASE_TRUNK_FIELD_SIZE1238_g18688 = _WIND_BASE_TRUNK_FIELD_SIZE;
			float temp_output_2_0_g18722 = WIND_BASE_TRUNK_FIELD_SIZE1238_g18688;
			float2 temp_cast_0 = (( 1.0 / (( temp_output_2_0_g18722 == 0.0 ) ? 1.0 :  temp_output_2_0_g18722 ) )).xx;
			float2 temp_output_2_0_g18728 = temp_cast_0;
			float2 temp_output_3_0_g18728 = float2( 0,0 );
			float2 temp_output_704_0_g18716 = ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g18728 / temp_output_2_0_g18728 ) :  ( temp_output_1_0_g18728 * temp_output_2_0_g18728 ) ) + temp_output_3_0_g18728 );
			float temp_output_2_0_g18732 = _WIND_BASE_TRUNK_CYCLE_TIME;
			float WIND_BASE_TRUNK_FREQUENCY1237_g18688 = ( 1.0 / (( temp_output_2_0_g18732 == 0.0 ) ? 1.0 :  temp_output_2_0_g18732 ) );
			float2 temp_output_721_0_g18716 = (WIND_BASE_TRUNK_FREQUENCY1237_g18688).xx;
			float2 break298_g18718 = ( temp_output_704_0_g18716 + ( temp_output_721_0_g18716 * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g18718 = (float2(sin( break298_g18718.x ) , cos( break298_g18718.y )));
			float4 temp_output_273_0_g18718 = (-1.0).xxxx;
			float4 temp_output_271_0_g18718 = (1.0).xxxx;
			float2 clampResult26_g18718 = clamp( appendResult299_g18718 , temp_output_273_0_g18718.xy , temp_output_271_0_g18718.xy );
			float WIND_BASE_AMPLITUDE1197_g18688 = _WIND_BASE_AMPLITUDE;
			float WIND_BASE_TRUNK_STRENGTH1236_g18688 = _WIND_BASE_TRUNK_STRENGTH;
			float2 temp_output_720_0_g18716 = (( WIND_BASE_AMPLITUDE1197_g18688 * WIND_BASE_TRUNK_STRENGTH1236_g18688 )).xx;
			float2 TRUNK_PIVOT_ROCKING701_g18716 = ( clampResult26_g18718 * temp_output_720_0_g18716 );
			float WIND_PRIMARY_ROLL1202_g18688 = v.color.r;
			float _WIND_PRIMARY_ROLL669_g18716 = WIND_PRIMARY_ROLL1202_g18688;
			float temp_output_54_0_g18717 = ( TRUNK_PIVOT_ROCKING701_g18716 * 0.05 * _WIND_PRIMARY_ROLL669_g18716 ).x;
			float temp_output_72_0_g18717 = cos( temp_output_54_0_g18717 );
			float one_minus_c52_g18717 = ( 1.0 - temp_output_72_0_g18717 );
			float3 break70_g18717 = float3(0,1,0);
			float axis_x25_g18717 = break70_g18717.x;
			float c66_g18717 = temp_output_72_0_g18717;
			float axis_y37_g18717 = break70_g18717.y;
			float axis_z29_g18717 = break70_g18717.z;
			float s67_g18717 = sin( temp_output_54_0_g18717 );
			float3 appendResult83_g18717 = (float3(( ( one_minus_c52_g18717 * axis_x25_g18717 * axis_x25_g18717 ) + c66_g18717 ) , ( ( one_minus_c52_g18717 * axis_x25_g18717 * axis_y37_g18717 ) - ( axis_z29_g18717 * s67_g18717 ) ) , ( ( one_minus_c52_g18717 * axis_z29_g18717 * axis_x25_g18717 ) + ( axis_y37_g18717 * s67_g18717 ) )));
			float3 appendResult81_g18717 = (float3(( ( one_minus_c52_g18717 * axis_x25_g18717 * axis_y37_g18717 ) + ( axis_z29_g18717 * s67_g18717 ) ) , ( ( one_minus_c52_g18717 * axis_y37_g18717 * axis_y37_g18717 ) + c66_g18717 ) , ( ( one_minus_c52_g18717 * axis_y37_g18717 * axis_z29_g18717 ) - ( axis_x25_g18717 * s67_g18717 ) )));
			float3 appendResult82_g18717 = (float3(( ( one_minus_c52_g18717 * axis_z29_g18717 * axis_x25_g18717 ) - ( axis_y37_g18717 * s67_g18717 ) ) , ( ( one_minus_c52_g18717 * axis_y37_g18717 * axis_z29_g18717 ) + ( axis_x25_g18717 * s67_g18717 ) ) , ( ( one_minus_c52_g18717 * axis_z29_g18717 * axis_z29_g18717 ) + c66_g18717 )));
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 WIND_PRIMARY_PIVOT1203_g18688 = (v.texcoord1).xyz;
			float3 _WIND_PRIMARY_PIVOT655_g18716 = WIND_PRIMARY_PIVOT1203_g18688;
			float3 temp_output_38_0_g18717 = ( ase_vertex3Pos - (_WIND_PRIMARY_PIVOT655_g18716).xyz );
			float2 break298_g18724 = ( temp_output_704_0_g18716 + ( temp_output_721_0_g18716 * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g18724 = (float2(sin( break298_g18724.x ) , cos( break298_g18724.y )));
			float4 temp_output_273_0_g18724 = (-1.0).xxxx;
			float4 temp_output_271_0_g18724 = (1.0).xxxx;
			float2 clampResult26_g18724 = clamp( appendResult299_g18724 , temp_output_273_0_g18724.xy , temp_output_271_0_g18724.xy );
			float2 TRUNK_SWIRL700_g18716 = ( clampResult26_g18724 * temp_output_720_0_g18716 );
			float2 break699_g18716 = TRUNK_SWIRL700_g18716;
			float3 appendResult698_g18716 = (float3(break699_g18716.x , 0.0 , break699_g18716.y));
			float3 temp_output_694_0_g18716 = ( ( mul( float3x3(appendResult83_g18717, appendResult81_g18717, appendResult82_g18717), temp_output_38_0_g18717 ) - temp_output_38_0_g18717 ) + ( _WIND_PRIMARY_ROLL669_g18716 * appendResult698_g18716 * 0.5 ) );
			float lerpResult632_g18729 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH , _WIND_AUDIO_INFLUENCE);
			float WIND_GUST_AUDIO_STRENGTH1242_g18688 = lerpResult632_g18729;
			float temp_output_15_0_g18773 = WIND_GUST_AUDIO_STRENGTH1242_g18688;
			float lerpResult635_g18729 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_LOW , _WIND_AUDIO_INFLUENCE);
			float WIND_GUST_AUDIO_LOW1246_g18688 = lerpResult635_g18729;
			float temp_output_16_0_g18773 = WIND_GUST_AUDIO_LOW1246_g18688;
			float WIND_GUST_TRUNK_STRENGTH1240_g18688 = _WIND_GUST_TRUNK_STRENGTH;
			float4 color658_g18704 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float WIND_GUST_TRUNK_CYCLE_TIME1241_g18688 = _WIND_GUST_TRUNK_CYCLE_TIME;
			float temp_output_2_0_g18705 = WIND_GUST_TRUNK_CYCLE_TIME1241_g18688;
			float2 temp_cast_6 = (( 1.0 / (( temp_output_2_0_g18705 == 0.0 ) ? 1.0 :  temp_output_2_0_g18705 ) )).xx;
			float2 temp_output_61_0_g18708 = float2( 0,0 );
			float2 temp_output_1_0_g18709 = (WIND_POSITION_OBJECT1195_g18688).xz;
			float WIND_GUST_TRUNK_FIELD_SIZE1239_g18688 = _WIND_GUST_TRUNK_FIELD_SIZE;
			float temp_output_2_0_g18707 = WIND_GUST_TRUNK_FIELD_SIZE1239_g18688;
			float temp_output_40_0_g18708 = ( 1.0 / (( temp_output_2_0_g18707 == 0.0 ) ? 1.0 :  temp_output_2_0_g18707 ) );
			float2 temp_cast_7 = (temp_output_40_0_g18708).xx;
			float2 temp_output_2_0_g18709 = temp_cast_7;
			float2 temp_output_3_0_g18709 = temp_output_61_0_g18708;
			float2 panner90_g18708 = ( _Time.y * temp_cast_6 + ( (( temp_output_61_0_g18708 > float2( 0,0 ) ) ? ( temp_output_1_0_g18709 / temp_output_2_0_g18709 ) :  ( temp_output_1_0_g18709 * temp_output_2_0_g18709 ) ) + temp_output_3_0_g18709 ));
			float temp_output_679_0_g18704 = 1.0;
			float4 temp_cast_8 = (temp_output_679_0_g18704).xxxx;
			float4 temp_output_52_0_g18708 = saturate( pow( tex2Dlod( _WIND_GUST_TEXTURE, float4( panner90_g18708, 0, 0.0) ) , temp_cast_8 ) );
			float4 lerpResult656_g18704 = lerp( color658_g18704 , temp_output_52_0_g18708 , temp_output_679_0_g18704);
			float4 break655_g18704 = lerpResult656_g18704;
			float4 _Vector0 = float4(0,0,0,0);
			float4 _Vector1 = float4(1,1,1,1);
			float _TRUNK1350_g18688 = ( ( ( temp_output_15_0_g18773 + temp_output_16_0_g18773 ) / 2.0 ) * WIND_GUST_TRUNK_STRENGTH1240_g18688 * (-0.45 + (( 1.0 - break655_g18704.b ) - _Vector0.x) * (1.0 - -0.45) / (_Vector1.x - _Vector0.x)) );
			float _WIND_GUST_STRENGTH703_g18716 = _TRUNK1350_g18688;
			float WIND_PRIMARY_BEND1204_g18688 = v.texcoord1.w;
			float _WIND_PRIMARY_BEND662_g18716 = WIND_PRIMARY_BEND1204_g18688;
			float temp_output_54_0_g18723 = ( -_WIND_GUST_STRENGTH703_g18716 * _WIND_PRIMARY_BEND662_g18716 );
			float temp_output_72_0_g18723 = cos( temp_output_54_0_g18723 );
			float one_minus_c52_g18723 = ( 1.0 - temp_output_72_0_g18723 );
			float3 WIND_DIRECTION1192_g18688 = _WIND_DIRECTION;
			float3 _WIND_DIRECTION671_g18716 = WIND_DIRECTION1192_g18688;
			float3 worldToObjDir719_g18716 = mul( unity_WorldToObject, float4( cross( _WIND_DIRECTION671_g18716 , float3(0,1,0) ), 0 ) ).xyz;
			float3 break70_g18723 = worldToObjDir719_g18716;
			float axis_x25_g18723 = break70_g18723.x;
			float c66_g18723 = temp_output_72_0_g18723;
			float axis_y37_g18723 = break70_g18723.y;
			float axis_z29_g18723 = break70_g18723.z;
			float s67_g18723 = sin( temp_output_54_0_g18723 );
			float3 appendResult83_g18723 = (float3(( ( one_minus_c52_g18723 * axis_x25_g18723 * axis_x25_g18723 ) + c66_g18723 ) , ( ( one_minus_c52_g18723 * axis_x25_g18723 * axis_y37_g18723 ) - ( axis_z29_g18723 * s67_g18723 ) ) , ( ( one_minus_c52_g18723 * axis_z29_g18723 * axis_x25_g18723 ) + ( axis_y37_g18723 * s67_g18723 ) )));
			float3 appendResult81_g18723 = (float3(( ( one_minus_c52_g18723 * axis_x25_g18723 * axis_y37_g18723 ) + ( axis_z29_g18723 * s67_g18723 ) ) , ( ( one_minus_c52_g18723 * axis_y37_g18723 * axis_y37_g18723 ) + c66_g18723 ) , ( ( one_minus_c52_g18723 * axis_y37_g18723 * axis_z29_g18723 ) - ( axis_x25_g18723 * s67_g18723 ) )));
			float3 appendResult82_g18723 = (float3(( ( one_minus_c52_g18723 * axis_z29_g18723 * axis_x25_g18723 ) - ( axis_y37_g18723 * s67_g18723 ) ) , ( ( one_minus_c52_g18723 * axis_y37_g18723 * axis_z29_g18723 ) + ( axis_x25_g18723 * s67_g18723 ) ) , ( ( one_minus_c52_g18723 * axis_z29_g18723 * axis_z29_g18723 ) + c66_g18723 )));
			float3 temp_output_38_0_g18723 = ( ase_vertex3Pos - (_WIND_PRIMARY_PIVOT655_g18716).xyz );
			float3 lerpResult538_g18716 = lerp( temp_output_694_0_g18716 , ( temp_output_694_0_g18716 + ( mul( float3x3(appendResult83_g18723, appendResult81_g18723, appendResult82_g18723), temp_output_38_0_g18723 ) - temp_output_38_0_g18723 ) ) , WIND_GUST_AUDIO_STRENGTH1242_g18688);
			float3 MOTION_TRUNK1337_g18688 = lerpResult538_g18716;
			float WIND_BRANCH_STRENGTH1224_g18688 = _WIND_BRANCH_STRENGTH;
			float3 _WIND_POSITION_ROOT1002_g18799 = WIND_POSITION_OBJECT1195_g18688;
			float2 temp_output_1_0_g18815 = (_WIND_POSITION_ROOT1002_g18799).xz;
			float WIND_BASE_BRANCH_FIELD_SIZE1218_g18688 = _WIND_BASE_BRANCH_FIELD_SIZE;
			float _WIND_BASE_BRANCH_FIELD_SIZE1004_g18799 = WIND_BASE_BRANCH_FIELD_SIZE1218_g18688;
			float temp_output_2_0_g18820 = _WIND_BASE_BRANCH_FIELD_SIZE1004_g18799;
			float2 temp_cast_11 = (( 1.0 / (( temp_output_2_0_g18820 == 0.0 ) ? 1.0 :  temp_output_2_0_g18820 ) )).xx;
			float2 temp_output_2_0_g18815 = temp_cast_11;
			float temp_output_587_552_g18751 = v.color.a;
			float WIND_PHASE1212_g18688 = temp_output_587_552_g18751;
			float _WIND_PHASE852_g18799 = WIND_PHASE1212_g18688;
			float WIND_BASE_BRANCH_VARIATION_STRENGTH1219_g18688 = _WIND_BASE_BRANCH_VARIATION_STRENGTH;
			float _WIND_BASE_BRANCH_VARIATION_STRENGTH1006_g18799 = WIND_BASE_BRANCH_VARIATION_STRENGTH1219_g18688;
			float2 temp_cast_12 = (( ( _WIND_PHASE852_g18799 * _WIND_BASE_BRANCH_VARIATION_STRENGTH1006_g18799 ) * UNITY_PI )).xx;
			float2 temp_output_3_0_g18815 = temp_cast_12;
			float temp_output_2_0_g18776 = _WIND_BASE_BRANCH_CYCLE_TIME;
			float WIND_BASE_BRANCH_FREQUENCY1217_g18688 = ( 1.0 / (( temp_output_2_0_g18776 == 0.0 ) ? 1.0 :  temp_output_2_0_g18776 ) );
			float2 break298_g18816 = ( ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g18815 / temp_output_2_0_g18815 ) :  ( temp_output_1_0_g18815 * temp_output_2_0_g18815 ) ) + temp_output_3_0_g18815 ) + ( (( WIND_BASE_BRANCH_FREQUENCY1217_g18688 * _WIND_PHASE852_g18799 )).xx * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g18816 = (float2(sin( break298_g18816.x ) , cos( break298_g18816.y )));
			float4 temp_output_273_0_g18816 = (-1.0).xxxx;
			float4 temp_output_271_0_g18816 = (1.0).xxxx;
			float2 clampResult26_g18816 = clamp( appendResult299_g18816 , temp_output_273_0_g18816.xy , temp_output_271_0_g18816.xy );
			float WIND_BASE_BRANCH_STRENGTH1227_g18688 = _WIND_BASE_BRANCH_STRENGTH;
			float2 BRANCH_SWIRL931_g18799 = ( clampResult26_g18816 * (( WIND_BASE_AMPLITUDE1197_g18688 * WIND_BASE_BRANCH_STRENGTH1227_g18688 )).xx );
			float2 break932_g18799 = BRANCH_SWIRL931_g18799;
			float3 appendResult933_g18799 = (float3(break932_g18799.x , 0.0 , break932_g18799.y));
			float WIND_SECONDARY_ROLL1205_g18688 = v.color.g;
			float _WIND_SECONDARY_ROLL650_g18799 = WIND_SECONDARY_ROLL1205_g18688;
			float3 VALUE_ROLL1034_g18799 = ( appendResult933_g18799 * _WIND_SECONDARY_ROLL650_g18799 * 0.5 );
			float3 _WIND_DIRECTION856_g18799 = WIND_DIRECTION1192_g18688;
			float3 WIND_SECONDARY_GROWTH_DIRECTION1208_g18688 = (v.texcoord2).xyz;
			float3 temp_output_839_0_g18799 = WIND_SECONDARY_GROWTH_DIRECTION1208_g18688;
			float3 _WIND_SECONDARY_GROWTH_DIRECTION = float3(0,1,0);
			float3 objToWorldDir1174_g18799 = mul( unity_ObjectToWorld, float4( (( length( temp_output_839_0_g18799 ) == 0.0 ) ? _WIND_SECONDARY_GROWTH_DIRECTION :  temp_output_839_0_g18799 ), 0 ) ).xyz;
			float3 _WIND_SECONDARY_GROWTH_DIRECTION840_g18799 = (objToWorldDir1174_g18799).xyz;
			float dotResult565_g18799 = dot( _WIND_DIRECTION856_g18799 , _WIND_SECONDARY_GROWTH_DIRECTION840_g18799 );
			float clampResult13_g18808 = clamp( dotResult565_g18799 , -1.0 , 1.0 );
			float4 color658_g18698 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float WIND_GUST_BRANCH_CYCLE_TIME1220_g18688 = _WIND_GUST_BRANCH_CYCLE_TIME;
			float clampResult3_g18760 = clamp( temp_output_587_552_g18751 , 0.0 , 1.0 );
			float WIND_PHASE_UNPACKED1530_g18688 = ( ( clampResult3_g18760 * 2.0 ) - 1.0 );
			float temp_output_2_0_g18699 = ( WIND_GUST_BRANCH_CYCLE_TIME1220_g18688 + ( WIND_GUST_BRANCH_CYCLE_TIME1220_g18688 * WIND_PHASE_UNPACKED1530_g18688 * 0.1 ) );
			float2 temp_cast_15 = (( 1.0 / (( temp_output_2_0_g18699 == 0.0 ) ? 1.0 :  temp_output_2_0_g18699 ) )).xx;
			float2 temp_output_61_0_g18702 = float2( 0,0 );
			float3 WIND_SECONDARY_PIVOT1206_g18688 = (v.texcoord3).xyz;
			float WIND_GUST_BRANCH_VARIATION_STRENGTH1223_g18688 = _WIND_GUST_BRANCH_VARIATION_STRENGTH;
			float2 temp_output_1_0_g18703 = ( (WIND_POSITION_OBJECT1195_g18688).xz + (WIND_SECONDARY_PIVOT1206_g18688).xy + ( WIND_PHASE1212_g18688 * WIND_GUST_BRANCH_VARIATION_STRENGTH1223_g18688 ) );
			float WIND_GUST_BRANCH_FIELD_SIZE1222_g18688 = _WIND_GUST_BRANCH_FIELD_SIZE;
			float temp_output_2_0_g18701 = WIND_GUST_BRANCH_FIELD_SIZE1222_g18688;
			float temp_output_40_0_g18702 = ( 1.0 / (( temp_output_2_0_g18701 == 0.0 ) ? 1.0 :  temp_output_2_0_g18701 ) );
			float2 temp_cast_16 = (temp_output_40_0_g18702).xx;
			float2 temp_output_2_0_g18703 = temp_cast_16;
			float2 temp_output_3_0_g18703 = temp_output_61_0_g18702;
			float2 panner90_g18702 = ( _Time.y * temp_cast_15 + ( (( temp_output_61_0_g18702 > float2( 0,0 ) ) ? ( temp_output_1_0_g18703 / temp_output_2_0_g18703 ) :  ( temp_output_1_0_g18703 * temp_output_2_0_g18703 ) ) + temp_output_3_0_g18703 ));
			float temp_output_679_0_g18698 = 1.0;
			float4 temp_cast_17 = (temp_output_679_0_g18698).xxxx;
			float4 temp_output_52_0_g18702 = saturate( pow( tex2Dlod( _WIND_GUST_TEXTURE, float4( panner90_g18702, 0, 0.0) ) , temp_cast_17 ) );
			float4 lerpResult656_g18698 = lerp( color658_g18698 , temp_output_52_0_g18702 , temp_output_679_0_g18698);
			float4 break655_g18698 = lerpResult656_g18698;
			float temp_output_15_0_g18765 = break655_g18698.r;
			float temp_output_16_0_g18765 = ( 1.0 - break655_g18698.b );
			float temp_output_15_0_g18778 = WIND_GUST_AUDIO_STRENGTH1242_g18688;
			float lerpResult634_g18729 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_MID , _WIND_AUDIO_INFLUENCE);
			float WIND_GUST_AUDIO_MID1245_g18688 = lerpResult634_g18729;
			float temp_output_16_0_g18778 = WIND_GUST_AUDIO_MID1245_g18688;
			float temp_output_1516_14_g18688 = ( ( temp_output_15_0_g18778 + temp_output_16_0_g18778 ) / 2.0 );
			float WIND_GUST_BRANCH_STRENGTH1229_g18688 = _WIND_GUST_BRANCH_STRENGTH;
			float WIND_GUST_BRANCH_STRENGTH_OPPOSITE1573_g18688 = _WIND_GUST_BRANCH_STRENGTH_OPPOSITE;
			float _BRANCH_OPPOSITE_DOWN1466_g18688 = ( (-0.1 + (( ( temp_output_15_0_g18765 + temp_output_16_0_g18765 ) / 2.0 ) - _Vector0.x) * (0.75 - -0.1) / (_Vector1.x - _Vector0.x)) * temp_output_1516_14_g18688 * WIND_GUST_BRANCH_STRENGTH1229_g18688 * WIND_GUST_BRANCH_STRENGTH_OPPOSITE1573_g18688 );
			float _GUST_STRENGTH_OPPOSITE_DOWN1188_g18799 = _BRANCH_OPPOSITE_DOWN1466_g18688;
			float temp_output_15_0_g18748 = ( 1.0 - break655_g18698.g );
			float temp_output_16_0_g18748 = break655_g18698.a;
			float _BRANCH_OPPOSITE_UP1348_g18688 = ( (-0.3 + (( ( temp_output_15_0_g18748 + temp_output_16_0_g18748 ) / 2.0 ) - _Vector0.x) * (1.0 - -0.3) / (_Vector1.x - _Vector0.x)) * temp_output_1516_14_g18688 * WIND_GUST_BRANCH_STRENGTH1229_g18688 * WIND_GUST_BRANCH_STRENGTH_OPPOSITE1573_g18688 );
			float _GUST_STRENGTH_OPPOSITE_UP871_g18799 = _BRANCH_OPPOSITE_UP1348_g18688;
			float dotResult1180_g18799 = dot( _WIND_SECONDARY_GROWTH_DIRECTION840_g18799 , float3(0,1,0) );
			float clampResult8_g18821 = clamp( dotResult1180_g18799 , -1.0 , 1.0 );
			float _WIND_SECONDARY_VERTICALITY843_g18799 = ( ( clampResult8_g18821 * 0.5 ) + 0.5 );
			float temp_output_2_0_g18823 = _WIND_SECONDARY_VERTICALITY843_g18799;
			float temp_output_3_0_g18823 = 0.5;
			float temp_output_21_0_g18823 = 1.0;
			float temp_output_26_0_g18823 = 0.0;
			float lerpResult1_g18827 = lerp( _GUST_STRENGTH_OPPOSITE_DOWN1188_g18799 , -_GUST_STRENGTH_OPPOSITE_UP871_g18799 , saturate( saturate( (( temp_output_2_0_g18823 >= temp_output_3_0_g18823 ) ? temp_output_21_0_g18823 :  temp_output_26_0_g18823 ) ) ));
			float WIND_SECONDARY_BEND1207_g18688 = v.texcoord3.w;
			float _WIND_SECONDARY_BEND849_g18799 = WIND_SECONDARY_BEND1207_g18688;
			float clampResult1170_g18799 = clamp( _WIND_SECONDARY_BEND849_g18799 , 0.0 , 0.75 );
			float clampResult1175_g18799 = clamp( ( lerpResult1_g18827 * clampResult1170_g18799 ) , -1.5 , 1.5 );
			float temp_output_54_0_g18805 = clampResult1175_g18799;
			float temp_output_72_0_g18805 = cos( temp_output_54_0_g18805 );
			float one_minus_c52_g18805 = ( 1.0 - temp_output_72_0_g18805 );
			float3 worldToObjDir1173_g18799 = mul( unity_WorldToObject, float4( cross( _WIND_DIRECTION856_g18799 , float3(0,1,0) ), 0 ) ).xyz;
			float3 break70_g18805 = worldToObjDir1173_g18799;
			float axis_x25_g18805 = break70_g18805.x;
			float c66_g18805 = temp_output_72_0_g18805;
			float axis_y37_g18805 = break70_g18805.y;
			float axis_z29_g18805 = break70_g18805.z;
			float s67_g18805 = sin( temp_output_54_0_g18805 );
			float3 appendResult83_g18805 = (float3(( ( one_minus_c52_g18805 * axis_x25_g18805 * axis_x25_g18805 ) + c66_g18805 ) , ( ( one_minus_c52_g18805 * axis_x25_g18805 * axis_y37_g18805 ) - ( axis_z29_g18805 * s67_g18805 ) ) , ( ( one_minus_c52_g18805 * axis_z29_g18805 * axis_x25_g18805 ) + ( axis_y37_g18805 * s67_g18805 ) )));
			float3 appendResult81_g18805 = (float3(( ( one_minus_c52_g18805 * axis_x25_g18805 * axis_y37_g18805 ) + ( axis_z29_g18805 * s67_g18805 ) ) , ( ( one_minus_c52_g18805 * axis_y37_g18805 * axis_y37_g18805 ) + c66_g18805 ) , ( ( one_minus_c52_g18805 * axis_y37_g18805 * axis_z29_g18805 ) - ( axis_x25_g18805 * s67_g18805 ) )));
			float3 appendResult82_g18805 = (float3(( ( one_minus_c52_g18805 * axis_z29_g18805 * axis_x25_g18805 ) - ( axis_y37_g18805 * s67_g18805 ) ) , ( ( one_minus_c52_g18805 * axis_y37_g18805 * axis_z29_g18805 ) + ( axis_x25_g18805 * s67_g18805 ) ) , ( ( one_minus_c52_g18805 * axis_z29_g18805 * axis_z29_g18805 ) + c66_g18805 )));
			float3 _WIND_SECONDARY_PIVOT846_g18799 = WIND_SECONDARY_PIVOT1206_g18688;
			float3 temp_output_38_0_g18805 = ( ase_vertex3Pos - (_WIND_SECONDARY_PIVOT846_g18799).xyz );
			float3 VALUE_FACING_WIND1042_g18799 = ( mul( float3x3(appendResult83_g18805, appendResult81_g18805, appendResult82_g18805), temp_output_38_0_g18805 ) - temp_output_38_0_g18805 );
			float2 temp_output_1_0_g18800 = (_WIND_SECONDARY_PIVOT846_g18799).xz;
			float _WIND_GUST_BRANCH_FIELD_SIZE1011_g18799 = WIND_GUST_BRANCH_FIELD_SIZE1222_g18688;
			float temp_output_2_0_g18807 = _WIND_GUST_BRANCH_FIELD_SIZE1011_g18799;
			float2 temp_cast_22 = (( 1.0 / (( temp_output_2_0_g18807 == 0.0 ) ? 1.0 :  temp_output_2_0_g18807 ) )).xx;
			float2 temp_output_2_0_g18800 = temp_cast_22;
			float _WIND_GUST_BRANCH_VARIATION_STRENGTH1008_g18799 = WIND_GUST_BRANCH_VARIATION_STRENGTH1223_g18688;
			float2 temp_cast_23 = (( ( _WIND_PHASE852_g18799 * _WIND_GUST_BRANCH_VARIATION_STRENGTH1008_g18799 ) * UNITY_PI )).xx;
			float2 temp_output_3_0_g18800 = temp_cast_23;
			float temp_output_2_0_g18777 = _WIND_GUST_BRANCH_CYCLE_TIME;
			float WIND_GUST_BRANCH_FREQUENCY1221_g18688 = ( 1.0 / (( temp_output_2_0_g18777 == 0.0 ) ? 1.0 :  temp_output_2_0_g18777 ) );
			float _WIND_GUST_BRANCH_FREQUENCY1012_g18799 = WIND_GUST_BRANCH_FREQUENCY1221_g18688;
			float2 break298_g18801 = ( ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g18800 / temp_output_2_0_g18800 ) :  ( temp_output_1_0_g18800 * temp_output_2_0_g18800 ) ) + temp_output_3_0_g18800 ) + ( (_WIND_GUST_BRANCH_FREQUENCY1012_g18799).xx * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g18801 = (float2(sin( break298_g18801.x ) , cos( break298_g18801.y )));
			float4 temp_output_273_0_g18801 = (-1.0).xxxx;
			float4 temp_output_271_0_g18801 = (1.0).xxxx;
			float2 clampResult26_g18801 = clamp( appendResult299_g18801 , temp_output_273_0_g18801.xy , temp_output_271_0_g18801.xy );
			float2 break305_g18801 = float2( -0.25,1 );
			float temp_output_15_0_g18764 = ( 1.0 - break655_g18698.r );
			float temp_output_16_0_g18764 = break655_g18698.g;
			float WIND_GUST_BRANCH_STRENGTH_PERPENDICULAR1574_g18688 = _WIND_GUST_BRANCH_STRENGTH_PERPENDICULAR;
			float _BRANCH_PERPENDICULAR1431_g18688 = ( (-0.1 + (( ( temp_output_15_0_g18764 + temp_output_16_0_g18764 ) / 2.0 ) - _Vector0.x) * (0.9 - -0.1) / (_Vector1.x - _Vector0.x)) * temp_output_1516_14_g18688 * WIND_GUST_BRANCH_STRENGTH1229_g18688 * WIND_GUST_BRANCH_STRENGTH_PERPENDICULAR1574_g18688 );
			float _GUST_STRENGTH_PERPENDICULAR999_g18799 = _BRANCH_PERPENDICULAR1431_g18688;
			float2 break1067_g18799 = ( ( ((break305_g18801.x).xxxx.xy + (clampResult26_g18801 - temp_output_273_0_g18801.xy) * ((break305_g18801.y).xxxx.xy - (break305_g18801.x).xxxx.xy) / (temp_output_271_0_g18801.xy - temp_output_273_0_g18801.xy)) * (_GUST_STRENGTH_PERPENDICULAR999_g18799).xx ) * _WIND_SECONDARY_ROLL650_g18799 );
			float3 appendResult1066_g18799 = (float3(break1067_g18799.x , 0.0 , break1067_g18799.y));
			float3 worldToObjDir1089_g18799 = normalize( mul( unity_WorldToObject, float4( _WIND_DIRECTION856_g18799, 0 ) ).xyz );
			float3 BRANCH_SWIRL972_g18799 = ( appendResult1066_g18799 * worldToObjDir1089_g18799 );
			float3 VALUE_PERPENDICULAR1041_g18799 = BRANCH_SWIRL972_g18799;
			float3 temp_output_3_0_g18808 = VALUE_PERPENDICULAR1041_g18799;
			float3 lerpResult1_g18814 = lerp( VALUE_FACING_WIND1042_g18799 , temp_output_3_0_g18808 , saturate( ( 1.0 + clampResult13_g18808 ) ));
			float temp_output_15_0_g18691 = break655_g18698.b;
			float temp_output_16_0_g18691 = ( 1.0 - break655_g18698.a );
			float clampResult3_g18749 = clamp( ( ( temp_output_15_0_g18691 + temp_output_16_0_g18691 ) / 2.0 ) , 0.0 , 1.0 );
			float WIND_GUST_BRANCH_STRENGTH_PARALLEL1575_g18688 = _WIND_GUST_BRANCH_STRENGTH_PARALLEL;
			float _BRANCH_PARALLEL1432_g18688 = ( ( ( clampResult3_g18749 * 2.0 ) - 1.0 ) * temp_output_1516_14_g18688 * WIND_GUST_BRANCH_STRENGTH1229_g18688 * WIND_GUST_BRANCH_STRENGTH_PARALLEL1575_g18688 );
			float _GUST_STRENGTH_PARALLEL1110_g18799 = _BRANCH_PARALLEL1432_g18688;
			float clampResult1167_g18799 = clamp( ( _GUST_STRENGTH_PARALLEL1110_g18799 * _WIND_SECONDARY_BEND849_g18799 ) , -1.5 , 1.5 );
			float temp_output_54_0_g18806 = clampResult1167_g18799;
			float temp_output_72_0_g18806 = cos( temp_output_54_0_g18806 );
			float one_minus_c52_g18806 = ( 1.0 - temp_output_72_0_g18806 );
			float3 break70_g18806 = float3(0,1,0);
			float axis_x25_g18806 = break70_g18806.x;
			float c66_g18806 = temp_output_72_0_g18806;
			float axis_y37_g18806 = break70_g18806.y;
			float axis_z29_g18806 = break70_g18806.z;
			float s67_g18806 = sin( temp_output_54_0_g18806 );
			float3 appendResult83_g18806 = (float3(( ( one_minus_c52_g18806 * axis_x25_g18806 * axis_x25_g18806 ) + c66_g18806 ) , ( ( one_minus_c52_g18806 * axis_x25_g18806 * axis_y37_g18806 ) - ( axis_z29_g18806 * s67_g18806 ) ) , ( ( one_minus_c52_g18806 * axis_z29_g18806 * axis_x25_g18806 ) + ( axis_y37_g18806 * s67_g18806 ) )));
			float3 appendResult81_g18806 = (float3(( ( one_minus_c52_g18806 * axis_x25_g18806 * axis_y37_g18806 ) + ( axis_z29_g18806 * s67_g18806 ) ) , ( ( one_minus_c52_g18806 * axis_y37_g18806 * axis_y37_g18806 ) + c66_g18806 ) , ( ( one_minus_c52_g18806 * axis_y37_g18806 * axis_z29_g18806 ) - ( axis_x25_g18806 * s67_g18806 ) )));
			float3 appendResult82_g18806 = (float3(( ( one_minus_c52_g18806 * axis_z29_g18806 * axis_x25_g18806 ) - ( axis_y37_g18806 * s67_g18806 ) ) , ( ( one_minus_c52_g18806 * axis_y37_g18806 * axis_z29_g18806 ) + ( axis_x25_g18806 * s67_g18806 ) ) , ( ( one_minus_c52_g18806 * axis_z29_g18806 * axis_z29_g18806 ) + c66_g18806 )));
			float3 temp_output_38_0_g18806 = ( ase_vertex3Pos - (_WIND_SECONDARY_PIVOT846_g18799).xyz );
			float3 VALUE_AWAY_FROM_WIND1040_g18799 = ( mul( float3x3(appendResult83_g18806, appendResult81_g18806, appendResult82_g18806), temp_output_38_0_g18806 ) - temp_output_38_0_g18806 );
			float3 lerpResult1_g18809 = lerp( temp_output_3_0_g18808 , VALUE_AWAY_FROM_WIND1040_g18799 , saturate( clampResult13_g18808 ));
			float3 lerpResult631_g18799 = lerp( VALUE_ROLL1034_g18799 , (( clampResult13_g18808 < 0.0 ) ? lerpResult1_g18814 :  lerpResult1_g18809 ) , WIND_GUST_AUDIO_STRENGTH1242_g18688);
			float3 MOTION_BRANCH1339_g18688 = lerpResult631_g18799;
			float WIND_LEAF_STRENGTH1179_g18688 = _WIND_LEAF_STRENGTH;
			float temp_output_17_0_g18744 = 3.0;
			float TYPE_DESIGNATOR1209_g18688 = round( v.texcoord2.w );
			float temp_output_18_0_g18744 = TYPE_DESIGNATOR1209_g18688;
			float WIND_TERTIARY_ROLL1210_g18688 = v.color.b;
			float _WIND_TERTIARY_ROLL669_g18779 = WIND_TERTIARY_ROLL1210_g18688;
			float3 temp_output_615_0_g18766 = ( float3( 0,0,0 ) + ase_vertex3Pos );
			float3 WIND_POSITION_VERTEX_OBJECT1193_g18688 = temp_output_615_0_g18766;
			float2 temp_output_1_0_g18780 = (WIND_POSITION_VERTEX_OBJECT1193_g18688).xz;
			float WIND_BASE_LEAF_FIELD_SIZE1182_g18688 = _WIND_BASE_LEAF_FIELD_SIZE;
			float2 temp_output_2_0_g18780 = (WIND_BASE_LEAF_FIELD_SIZE1182_g18688).xx;
			float _WIND_VARIATION662_g18779 = WIND_PHASE1212_g18688;
			float2 temp_output_3_0_g18780 = (_WIND_VARIATION662_g18779).xx;
			float2 temp_output_704_0_g18779 = ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g18780 / temp_output_2_0_g18780 ) :  ( temp_output_1_0_g18780 * temp_output_2_0_g18780 ) ) + temp_output_3_0_g18780 );
			float temp_output_2_0_g18770 = _WIND_BASE_LEAF_CYCLE_TIME;
			float WIND_BASE_LEAF_FREQUENCY1264_g18688 = ( 1.0 / (( temp_output_2_0_g18770 == 0.0 ) ? 1.0 :  temp_output_2_0_g18770 ) );
			float temp_output_618_0_g18779 = WIND_BASE_LEAF_FREQUENCY1264_g18688;
			float2 break298_g18781 = ( temp_output_704_0_g18779 + ( (temp_output_618_0_g18779).xx * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g18781 = (float2(sin( break298_g18781.x ) , cos( break298_g18781.y )));
			float4 temp_output_273_0_g18781 = (-1.0).xxxx;
			float4 temp_output_271_0_g18781 = (1.0).xxxx;
			float2 clampResult26_g18781 = clamp( appendResult299_g18781 , temp_output_273_0_g18781.xy , temp_output_271_0_g18781.xy );
			float WIND_BASE_LEAF_STRENGTH1180_g18688 = _WIND_BASE_LEAF_STRENGTH;
			float2 temp_output_1031_0_g18779 = (( WIND_BASE_LEAF_STRENGTH1180_g18688 * WIND_BASE_AMPLITUDE1197_g18688 )).xx;
			float2 break699_g18779 = ( clampResult26_g18781 * temp_output_1031_0_g18779 );
			float2 break298_g18785 = ( temp_output_704_0_g18779 + ( (( 0.71 * temp_output_618_0_g18779 )).xx * ( _Time.y + 0.0 ) ) );
			float2 appendResult299_g18785 = (float2(sin( break298_g18785.x ) , cos( break298_g18785.y )));
			float4 temp_output_273_0_g18785 = (-1.0).xxxx;
			float4 temp_output_271_0_g18785 = (1.0).xxxx;
			float2 clampResult26_g18785 = clamp( appendResult299_g18785 , temp_output_273_0_g18785.xy , temp_output_271_0_g18785.xy );
			float3 appendResult698_g18779 = (float3(break699_g18779.x , ( clampResult26_g18785 * temp_output_1031_0_g18779 ).x , break699_g18779.y));
			float3 temp_output_684_0_g18779 = ( _WIND_TERTIARY_ROLL669_g18779 * appendResult698_g18779 );
			float3 _WIND_DIRECTION671_g18779 = WIND_DIRECTION1192_g18688;
			float3 worldToObjDir1006_g18779 = mul( unity_WorldToObject, float4( _WIND_DIRECTION671_g18779, 0 ) ).xyz;
			float WIND_GUST_LEAF_STRENGTH1183_g18688 = _WIND_GUST_LEAF_STRENGTH;
			float lerpResult638_g18729 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_VERYHIGH , _WIND_AUDIO_INFLUENCE);
			float WIND_GUST_AUDIO_VERYHIGH1243_g18688 = lerpResult638_g18729;
			float4 color658_g18733 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float2 temp_output_61_0_g18735 = float2( 0,0 );
			float WIND_VARIATION1211_g18688 = v.texcoord.w;
			half localunity_ObjectToWorld0w1_g18689 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld2w3_g18689 = ( unity_ObjectToWorld[2].w );
			float2 appendResult1374_g18688 = (float2(localunity_ObjectToWorld0w1_g18689 , localunity_ObjectToWorld2w3_g18689));
			float2 temp_output_1_0_g18736 = ( ( 10.0 * WIND_VARIATION1211_g18688 ) + appendResult1374_g18688 );
			float WIND_GUST_LEAF_FIELD_SIZE1185_g18688 = _WIND_GUST_LEAF_FIELD_SIZE;
			float temp_output_2_0_g18742 = WIND_GUST_LEAF_FIELD_SIZE1185_g18688;
			float temp_output_40_0_g18735 = ( 1.0 / (( temp_output_2_0_g18742 == 0.0 ) ? 1.0 :  temp_output_2_0_g18742 ) );
			float2 temp_cast_37 = (temp_output_40_0_g18735).xx;
			float2 temp_output_2_0_g18736 = temp_cast_37;
			float2 temp_output_3_0_g18736 = temp_output_61_0_g18735;
			float clampResult3_g18745 = clamp( WIND_VARIATION1211_g18688 , 0.0 , 1.0 );
			float WIND_GUST_LEAF_CYCLE_TIME1184_g18688 = _WIND_GUST_LEAF_CYCLE_TIME;
			float temp_output_2_0_g18734 = ( ( ( ( clampResult3_g18745 * 2.0 ) - 1.0 ) * 0.3 * WIND_GUST_LEAF_CYCLE_TIME1184_g18688 ) + WIND_GUST_LEAF_CYCLE_TIME1184_g18688 );
			float mulTime37_g18735 = _Time.y * ( 1.0 / (( temp_output_2_0_g18734 == 0.0 ) ? 1.0 :  temp_output_2_0_g18734 ) );
			float temp_output_220_0_g18738 = -1.0;
			float4 temp_cast_38 = (temp_output_220_0_g18738).xxxx;
			float temp_output_219_0_g18738 = 1.0;
			float4 temp_cast_39 = (temp_output_219_0_g18738).xxxx;
			float4 clampResult26_g18738 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g18735 > float2( 0,0 ) ) ? ( temp_output_1_0_g18736 / temp_output_2_0_g18736 ) :  ( temp_output_1_0_g18736 * temp_output_2_0_g18736 ) ) + temp_output_3_0_g18736 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g18735 ) ) , temp_cast_38 , temp_cast_39 );
			float4 temp_cast_40 = (temp_output_220_0_g18738).xxxx;
			float4 temp_cast_41 = (temp_output_219_0_g18738).xxxx;
			float4 temp_cast_42 = (0.0).xxxx;
			float4 temp_cast_43 = (temp_output_219_0_g18738).xxxx;
			float temp_output_679_0_g18733 = 1.0;
			float4 temp_cast_44 = (temp_output_679_0_g18733).xxxx;
			float4 temp_output_52_0_g18735 = saturate( pow( abs( (temp_cast_42 + (clampResult26_g18738 - temp_cast_40) * (temp_cast_43 - temp_cast_42) / (temp_cast_41 - temp_cast_40)) ) , temp_cast_44 ) );
			float4 lerpResult656_g18733 = lerp( color658_g18733 , temp_output_52_0_g18735 , temp_output_679_0_g18733);
			float4 break655_g18733 = lerpResult656_g18733;
			float LEAF_GUST1375_g18688 = ( WIND_GUST_LEAF_STRENGTH1183_g18688 * WIND_GUST_AUDIO_VERYHIGH1243_g18688 * break655_g18733.g );
			float _WIND_GUST_STRENGTH703_g18779 = LEAF_GUST1375_g18688;
			float3 _GUST1018_g18779 = ( worldToObjDir1006_g18779 * _WIND_GUST_STRENGTH703_g18779 );
			float WIND_GUST_LEAF_MID_STRENGTH1186_g18688 = _WIND_GUST_LEAF_MID_STRENGTH;
			float lerpResult633_g18729 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_HIGH , _WIND_AUDIO_INFLUENCE);
			float WIND_GUST_AUDIO_HIGH1244_g18688 = lerpResult633_g18729;
			float4 color658_g18692 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float WIND_GUST_LEAF_MID_CYCLE_TIME1187_g18688 = _WIND_GUST_LEAF_MID_CYCLE_TIME;
			float temp_output_2_0_g18693 = ( WIND_GUST_LEAF_MID_CYCLE_TIME1187_g18688 + ( WIND_VARIATION1211_g18688 * -0.05 ) );
			float2 temp_cast_45 = (( 1.0 / (( temp_output_2_0_g18693 == 0.0 ) ? 1.0 :  temp_output_2_0_g18693 ) )).xx;
			float2 temp_output_61_0_g18696 = float2( 0,0 );
			float2 appendResult1400_g18688 = (float2(ase_vertex3Pos.x , ase_vertex3Pos.z));
			float2 temp_output_1_0_g18697 = ( (WIND_VARIATION1211_g18688).xx + appendResult1400_g18688 );
			float WIND_GUST_LEAF_MID_FIELD_SIZE1188_g18688 = _WIND_GUST_LEAF_MID_FIELD_SIZE;
			float temp_output_2_0_g18695 = WIND_GUST_LEAF_MID_FIELD_SIZE1188_g18688;
			float temp_output_40_0_g18696 = ( 1.0 / (( temp_output_2_0_g18695 == 0.0 ) ? 1.0 :  temp_output_2_0_g18695 ) );
			float2 temp_cast_46 = (temp_output_40_0_g18696).xx;
			float2 temp_output_2_0_g18697 = temp_cast_46;
			float2 temp_output_3_0_g18697 = temp_output_61_0_g18696;
			float2 panner90_g18696 = ( _Time.y * temp_cast_45 + ( (( temp_output_61_0_g18696 > float2( 0,0 ) ) ? ( temp_output_1_0_g18697 / temp_output_2_0_g18697 ) :  ( temp_output_1_0_g18697 * temp_output_2_0_g18697 ) ) + temp_output_3_0_g18697 ));
			float temp_output_679_0_g18692 = 1.0;
			float4 temp_cast_47 = (temp_output_679_0_g18692).xxxx;
			float4 temp_output_52_0_g18696 = saturate( pow( tex2Dlod( _WIND_GUST_TEXTURE, float4( panner90_g18696, 0, 0.0) ) , temp_cast_47 ) );
			float4 lerpResult656_g18692 = lerp( color658_g18692 , temp_output_52_0_g18696 , temp_output_679_0_g18692);
			float4 break655_g18692 = lerpResult656_g18692;
			float temp_output_1557_630_g18688 = break655_g18692.r;
			float LEAF_GUST_MID1397_g18688 = ( WIND_GUST_LEAF_MID_STRENGTH1186_g18688 * WIND_GUST_AUDIO_HIGH1244_g18688 * temp_output_1557_630_g18688 * temp_output_1557_630_g18688 );
			float _WIND_GUST_STRENGTH_MID829_g18779 = LEAF_GUST_MID1397_g18688;
			float3 _GUST_MID1019_g18779 = ( worldToObjDir1006_g18779 * _WIND_GUST_STRENGTH_MID829_g18779 );
			float3 ase_vertexNormal = v.normal.xyz;
			float3 _LEAF_NORMAL992_g18779 = ase_vertexNormal;
			float dotResult1_g18791 = dot( worldToObjDir1006_g18779 , _LEAF_NORMAL992_g18779 );
			float clampResult13_g18792 = clamp( dotResult1_g18791 , -1.0 , 1.0 );
			float WIND_GUST_LEAF_MICRO_STRENGTH1189_g18688 = _WIND_GUST_LEAF_MICRO_STRENGTH;
			float4 color658_g18710 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float WIND_GUST_LEAF_MICRO_CYCLE_TIME1190_g18688 = _WIND_GUST_LEAF_MICRO_CYCLE_TIME;
			float temp_output_2_0_g18711 = ( WIND_GUST_LEAF_MICRO_CYCLE_TIME1190_g18688 + ( WIND_VARIATION1211_g18688 * 0.1 ) );
			float2 temp_cast_48 = (( 1.0 / (( temp_output_2_0_g18711 == 0.0 ) ? 1.0 :  temp_output_2_0_g18711 ) )).xx;
			float2 temp_output_61_0_g18714 = float2( 0,0 );
			float2 appendResult1409_g18688 = (float2(ase_vertex3Pos.y , ase_vertex3Pos.z));
			float2 temp_output_1_0_g18715 = ( (WIND_VARIATION1211_g18688).xx + appendResult1409_g18688 );
			float WIND_GUST_LEAF_MICRO_FIELD_SIZE1191_g18688 = _WIND_GUST_LEAF_MICRO_FIELD_SIZE;
			float temp_output_2_0_g18713 = WIND_GUST_LEAF_MICRO_FIELD_SIZE1191_g18688;
			float temp_output_40_0_g18714 = ( 1.0 / (( temp_output_2_0_g18713 == 0.0 ) ? 1.0 :  temp_output_2_0_g18713 ) );
			float2 temp_cast_49 = (temp_output_40_0_g18714).xx;
			float2 temp_output_2_0_g18715 = temp_cast_49;
			float2 temp_output_3_0_g18715 = temp_output_61_0_g18714;
			float2 panner90_g18714 = ( _Time.y * temp_cast_48 + ( (( temp_output_61_0_g18714 > float2( 0,0 ) ) ? ( temp_output_1_0_g18715 / temp_output_2_0_g18715 ) :  ( temp_output_1_0_g18715 * temp_output_2_0_g18715 ) ) + temp_output_3_0_g18715 ));
			float temp_output_679_0_g18710 = 1.0;
			float4 temp_cast_50 = (temp_output_679_0_g18710).xxxx;
			float4 temp_output_52_0_g18714 = saturate( pow( tex2Dlod( _WIND_GUST_TEXTURE, float4( panner90_g18714, 0, 0.0) ) , temp_cast_50 ) );
			float4 lerpResult656_g18710 = lerp( color658_g18710 , temp_output_52_0_g18714 , temp_output_679_0_g18710);
			float4 break655_g18710 = lerpResult656_g18710;
			float LEAF_GUST_MICRO1408_g18688 = ( WIND_GUST_LEAF_MICRO_STRENGTH1189_g18688 * WIND_GUST_AUDIO_VERYHIGH1243_g18688 * break655_g18710.a );
			float _WIND_GUST_STRENGTH_MICRO851_g18779 = LEAF_GUST_MICRO1408_g18688;
			float clampResult3_g18789 = clamp( _WIND_GUST_STRENGTH_MICRO851_g18779 , 0.0 , 1.0 );
			float temp_output_3_0_g18792 = ( ( clampResult3_g18789 * 2.0 ) - 1.0 );
			float lerpResult1_g18798 = lerp( ( _WIND_GUST_STRENGTH_MICRO851_g18779 - 1.0 ) , temp_output_3_0_g18792 , saturate( ( 1.0 + clampResult13_g18792 ) ));
			float lerpResult1_g18793 = lerp( temp_output_3_0_g18792 , _WIND_GUST_STRENGTH_MICRO851_g18779 , saturate( clampResult13_g18792 ));
			float3 _GUST_MICRO1020_g18779 = ( worldToObjDir1006_g18779 * (( clampResult13_g18792 < 0.0 ) ? lerpResult1_g18798 :  lerpResult1_g18793 ) );
			float3 lerpResult538_g18779 = lerp( temp_output_684_0_g18779 , ( temp_output_684_0_g18779 + ( ( _GUST1018_g18779 + _GUST_MID1019_g18779 + _GUST_MICRO1020_g18779 ) * _WIND_TERTIARY_ROLL669_g18779 ) ) , WIND_GUST_AUDIO_STRENGTH1242_g18688);
			float3 MOTION_LEAF1343_g18688 = lerpResult538_g18779;
			float3 temp_output_19_0_g18744 = MOTION_LEAF1343_g18688;
			float3 temp_output_20_0_g18744 = float3(0,0,0);
			float4 break360_g19129 = v.ase_texcoord4;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 temp_output_356_0_g19129 = ( ase_worldPos - (_WorldSpaceCameraPos).xyz );
			float3 normalizeResult358_g19129 = normalize( temp_output_356_0_g19129 );
			float3 cam_pos_axis_z384_g19129 = normalizeResult358_g19129;
			float3 normalizeResult366_g19129 = normalize( cross( float3(0,1,0) , cam_pos_axis_z384_g19129 ) );
			float3 cam_pos_axis_x385_g19129 = normalizeResult366_g19129;
			float4x4 break375_g19129 = UNITY_MATRIX_V;
			float3 appendResult377_g19129 = (float3(break375_g19129[ 0 ][ 0 ] , break375_g19129[ 0 ][ 1 ] , break375_g19129[ 0 ][ 2 ]));
			float3 cam_rot_axis_x378_g19129 = appendResult377_g19129;
			float dotResult436_g19129 = dot( float3(0,1,0) , temp_output_356_0_g19129 );
			float temp_output_438_0_g19129 = saturate( abs( dotResult436_g19129 ) );
			float3 lerpResult424_g19129 = lerp( cam_pos_axis_x385_g19129 , cam_rot_axis_x378_g19129 , temp_output_438_0_g19129);
			float3 xAxis346_g19129 = lerpResult424_g19129;
			float3 cam_pos_axis_y383_g19129 = cross( cam_pos_axis_z384_g19129 , normalizeResult366_g19129 );
			float3 appendResult381_g19129 = (float3(break375_g19129[ 1 ][ 0 ] , break375_g19129[ 1 ][ 1 ] , break375_g19129[ 1 ][ 2 ]));
			float3 cam_rot_axis_y379_g19129 = appendResult381_g19129;
			float3 lerpResult423_g19129 = lerp( cam_pos_axis_y383_g19129 , cam_rot_axis_y379_g19129 , temp_output_438_0_g19129);
			float3 yAxis362_g19129 = lerpResult423_g19129;
			float isBillboard343_g19129 = (( break360_g19129.w < -0.99999 ) ? 1.0 :  0.0 );
			float3 temp_output_41_0_g19170 = ( ( ( WIND_TRUNK_STRENGTH1235_g18688 * MOTION_TRUNK1337_g18688 ) + ( WIND_BRANCH_STRENGTH1224_g18688 * MOTION_BRANCH1339_g18688 ) + ( WIND_LEAF_STRENGTH1179_g18688 * (( temp_output_17_0_g18744 == temp_output_18_0_g18744 ) ? temp_output_19_0_g18744 :  temp_output_20_0_g18744 ) ) ) + ( -( ( break360_g19129.x * xAxis346_g19129 ) + ( break360_g19129.y * yAxis362_g19129 ) ) * isBillboard343_g19129 * -1.0 ) );
			float temp_output_63_0_g19171 = (( unity_LODFade.x >= 1E-06 && unity_LODFade.x <= 0.999999 ) ? unity_LODFade.x :  1.0 );
			float3 lerpResult57_g19171 = lerp( temp_output_41_0_g19170 , -ase_vertex3Pos , ( 1.0 - temp_output_63_0_g19171 ));
			#ifdef INTERNAL_LODFADE_SCALE
				float3 staticSwitch58_g19170 = lerpResult57_g19171;
			#else
				float3 staticSwitch58_g19170 = temp_output_41_0_g19170;
			#endif
			#ifdef LOD_FADE_CROSSFADE
				float3 staticSwitch62_g19170 = staticSwitch58_g19170;
			#else
				float3 staticSwitch62_g19170 = temp_output_41_0_g19170;
			#endif
			v.vertex.xyz += staticSwitch62_g19170;
			float3 appendResult382_g19129 = (float3(break375_g19129[ 2 ][ 0 ] , break375_g19129[ 2 ][ 1 ] , break375_g19129[ 2 ][ 2 ]));
			float3 cam_rot_axis_z380_g19129 = appendResult382_g19129;
			float3 lerpResult422_g19129 = lerp( cam_pos_axis_z384_g19129 , cam_rot_axis_z380_g19129 , temp_output_438_0_g19129);
			float3 zAxis421_g19129 = lerpResult422_g19129;
			float3 lerpResult331_g19129 = lerp( ase_vertexNormal , ( -1.0 * zAxis421_g19129 ) , isBillboard343_g19129);
			float3 normalizeResult326_g19129 = normalize( lerpResult331_g19129 );
			float3 bb_normal2370 = normalizeResult326_g19129;
			v.normal = bb_normal2370;
			float4 ase_vertexTangent = v.tangent;
			float4 appendResult345_g19129 = (float4(xAxis346_g19129 , -1.0));
			float4 lerpResult341_g19129 = lerp( float4( ase_vertexTangent.xyz , 0.0 ) , appendResult345_g19129 , isBillboard343_g19129);
			float4 bb_tangent2371 = lerpResult341_g19129;
			v.tangent = bb_tangent2371;
			o.eyeDepth = -UnityObjectToViewPos( v.vertex.xyz ).z;
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
			float2 uv_BumpMap607 = i.uv_texcoord;
			float3 temp_output_13_0_g19159 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap607 ), _BumpScale );
			float3 switchResult20_g19159 = (((i.ASEVFace>0)?(temp_output_13_0_g19159):(-temp_output_13_0_g19159)));
			half3 MainBumpMap620 = switchResult20_g19159;
			o.Normal = MainBumpMap620;
			float temp_output_17_0_g19121 = round( i.uv3_tex4coord3.w );
			float temp_output_18_0_g19121 = 3.0;
			float2 uv_MainTex18 = i.uv_texcoord;
			float4 tex2DNode18 = tex2D( _MainTex, uv_MainTex18 );
			half4 Main_MainTex487 = tex2DNode18;
			float3 temp_output_2_0_g19115 = Main_MainTex487.rgb;
			float4 temp_output_15_0_g18657 = _Color;
			float4 temp_output_16_0_g18657 = _LeafColor2;
			half Opacity1306 = tex2DNode18.a;
			float4 lerpResult1_g18685 = lerp( ( ( temp_output_15_0_g18657 + temp_output_16_0_g18657 ) / 2.0 ) , _NonLeafColor , saturate( Opacity1306 ));
			half4 Other_Color1998 = lerpResult1_g18685;
			float4 temp_output_8_0_g19115 = Other_Color1998;
			float3 temp_output_10_0_g19115 = (temp_output_8_0_g19115).rgb;
			float3 lerpResult1_g19116 = lerp( temp_output_2_0_g19115 , ( temp_output_2_0_g19115 * temp_output_10_0_g19115 ) , saturate( saturate( (temp_output_8_0_g19115).a ) ));
			half3 Main_MainTex_RGB2572 = (tex2DNode18).rgb;
			float3 temp_output_2_0_g18686 = Main_MainTex_RGB2572;
			float3 ase_worldPos = i.worldPos;
			float2 appendResult2272 = (float2(( ase_worldPos.x + ase_worldPos.z ) , ase_worldPos.y));
			float2 temp_output_1_0_g4981 = appendResult2272;
			float2 temp_output_2_0_g4981 = (_ColorMapScale).xx;
			float2 temp_output_3_0_g4981 = float2( 0,0 );
			float4 lerpResult1_g18656 = lerp( _Color , _LeafColor2 , saturate( (CalculateContrast(_ColorMapContrast,(saturate( tex2D( _ColorMap, ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g4981 / temp_output_2_0_g4981 ) :  ( temp_output_1_0_g4981 * temp_output_2_0_g4981 ) ) + temp_output_3_0_g4981 ) ).r )).xxxx)).r ));
			half4 Leaf_Color486 = lerpResult1_g18656;
			float4 temp_output_8_0_g18686 = Leaf_Color486;
			float3 temp_output_10_0_g18686 = (temp_output_8_0_g18686).rgb;
			float3 lerpResult1_g18687 = lerp( temp_output_2_0_g18686 , ( temp_output_2_0_g18686 * temp_output_10_0_g18686 ) , saturate( saturate( (temp_output_8_0_g18686).a ) ));
			float3 hsvTorgb1964 = RGBToHSV( (lerpResult1_g18687).xyz );
			float3 hsvTorgb1963 = HSVToRGB( float3(hsvTorgb1964.x,( hsvTorgb1964.y * _Saturation ),( hsvTorgb1964.z * _Brightness )) );
			float2 uv_MetallicGlossMap645 = i.uv_texcoord;
			float4 tex2DNode645 = tex2D( _MetallicGlossMap, uv_MetallicGlossMap645 );
			half Main_MetallicGlossMap_B1836 = tex2DNode645.b;
			float3 lerpResult1_g19117 = lerp( (lerpResult1_g19116).xyz , hsvTorgb1963 , saturate( ( Main_MetallicGlossMap_B1836 * 2.0 ) ));
			float WIND_PRIMARY_ROLL1202_g18688 = i.vertexColor.r;
			float primary2362 = WIND_PRIMARY_ROLL1202_g18688;
			float4 lerpResult1_g19118 = lerp( float4( lerpResult1_g19117 , 0.0 ) , _NonLeafFadeColor , saturate( ( primary2362 * ( 1.0 - Main_MetallicGlossMap_B1836 ) * _NonLeafFadeStrength ) ));
			float4 temp_output_19_0_g19121 = lerpResult1_g19118;
			float4 temp_output_20_0_g19121 = Main_MainTex487;
			float4 temp_output_1343_0 = saturate( (( temp_output_17_0_g19121 == temp_output_18_0_g19121 ) ? temp_output_19_0_g19121 :  temp_output_20_0_g19121 ) );
			float3 temp_output_2_0_g19184 = temp_output_1343_0.rgb;
			float4 temp_output_8_0_g19184 = _Backshade;
			float3 temp_output_10_0_g19184 = (temp_output_8_0_g19184).rgb;
			half localunity_ObjectToWorld0w1_g19182 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g19182 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g19182 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g19182 = (float3(localunity_ObjectToWorld0w1_g19182 , localunity_ObjectToWorld1w2_g19182 , localunity_ObjectToWorld2w3_g19182));
			float3 normalizeResult7_g19176 = normalize( ( _WorldSpaceCameraPos - appendResult6_g19182 ) );
			half localunity_ObjectToWorld0w1_g19183 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g19183 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g19183 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g19183 = (float3(localunity_ObjectToWorld0w1_g19183 , localunity_ObjectToWorld1w2_g19183 , localunity_ObjectToWorld2w3_g19183));
			float3 normalizeResult8_g19176 = normalize( ( ase_worldPos - appendResult6_g19183 ) );
			float dotResult9_g19176 = dot( normalizeResult7_g19176 , normalizeResult8_g19176 );
			float clampResult46_g19176 = clamp( ( _BackshadingBias + saturate( dotResult9_g19176 ) ) , 1E-06 , 2.0 );
			float3 lerpResult1_g19185 = lerp( temp_output_2_0_g19184 , temp_output_10_0_g19184 , saturate( saturate( ( (_Backshade).a * ( 1.0 - saturate( (CalculateContrast(_BackshadingContrast,(saturate( pow( clampResult46_g19176 , _BackshadingPower ) )).xxxx)).r ) ) ) ) ));
			o.Albedo = saturate( ((lerpResult1_g19185).xyz).xyz );
			half Main_MetallicGlossMap_A744 = tex2DNode645.a;
			half SMOOTHNESS660 = ( Main_MetallicGlossMap_A744 * _Glossiness );
			o.Smoothness = saturate( SMOOTHNESS660 );
			half Main_MetallicGlossMap_G1788 = tex2DNode645.g;
			float lerpResult1793 = lerp( 1.0 , Main_MetallicGlossMap_G1788 , _Occlusion);
			half Main_Occlusion1794 = lerpResult1793;
			float lerpResult1308 = lerp( 1.0 , i.uv_tex4coord.z , _VertexOcclusion);
			half Vertex_Occlusion1312 = lerpResult1308;
			o.Occlusion = saturate( ( Main_Occlusion1794 * Vertex_Occlusion1312 ) );
			float lerpResult1972 = lerp( 1.0 , Vertex_Occlusion1312 , _OcclusionTransmissionDamping);
			float4 ALBEDO_PREBACKSHADE2580 = temp_output_1343_0;
			float4 lerpResult1_g19122 = lerp( _SubsurfaceColor , ALBEDO_PREBACKSHADE2580 , saturate( _TransmissionCutoff1 ));
			float4 temp_output_2583_0 = lerpResult1_g19122;
			half3 OUT_TRANSLUCENCY2166 = ( ( (0.0 + (saturate( ( Main_MetallicGlossMap_B1836 - _TransmissionCutoff ) ) - 0.0) * (1.0 - 0.0) / (( 1.0 - _TransmissionCutoff ) - 0.0)) * (temp_output_2583_0).a ) * (temp_output_2583_0).rgb );
			float cameraDepthFade2397 = (( i.eyeDepth -_ProjectionParams.y - _TranlucencyFadeOffset ) / _TranlucencyFadeDistance);
			o.Translucency = saturate( saturate( ( ( lerpResult1972 * OUT_TRANSLUCENCY2166 ) * ( 1.0 - cameraDepthFade2397 ) ) ) );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AppalachiaShaderGUI"
}
/*ASEBEGIN
Version=17500
-429.3333;-960;1706.667;939;-2077.968;2378.897;1;True;False
Node;AmplifyShaderEditor.WorldPosInputsNode;2230;1216,-720;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;2271;1424,-720;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;409;1536,-320;Half;False;Property;_Color;Leaf Color;33;0;Create;False;0;0;False;0;1,1,1,1;0.355839,0.552,0,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2244;1280,-560;Inherit;False;Property;_ColorMapScale;Color Map Scale;37;0;Create;True;0;0;False;0;10;478;0.1;2048;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2227;1920,-320;Half;False;Property;_LeafColor2;Leaf Color 2;34;0;Create;True;0;0;False;0;1,1,1,1;0.6579673,0.86,0,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;2438;1456,-608;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;2267;1600,-592;Inherit;False;FLOAT2;0;1;2;3;1;0;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;2272;1600,-720;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;2449;1904,-400;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;2446;2160,-336;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;2450;2160,-400;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;2249;1920,-896;Inherit;True;Property;_ColorMap;Color Map;36;1;[NoScaleOffset];Create;True;0;0;False;0;026dfc64f1bab7b4eae0975faef4dd55;b49712b1433bff9489d25d5e55859228;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FunctionNode;2265;1920,-688;Inherit;False;Scale UV;-1;;4981;a7c3af85c9e65044ba7f9e64bc17320c;1,10,0;4;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;0,0;False;8;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;2452;2416,-336;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2264;2240,-688;Inherit;True;Property;_TextureSample0;Texture Sample 0;46;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;2447;2416,-400;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2276;2240,-480;Inherit;False;Property;_ColorMapContrast;Color Map Contrast;38;0;Create;True;0;0;False;0;1;2;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2448;1904,-384;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;2454;2160,-352;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;2453;2672,-368;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;2456;2800,-592;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;18;-1792,-864;Inherit;True;Property;_MainTex;Leaf Albedo;23;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;2457;2832,-592;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;2455;2416,-352;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2275;2624,-688;Inherit;False;Value Contrast;-1;;5269;86281d53297b6244a8973a79bcae14e0;0;2;1;FLOAT;0;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2451;2160,-384;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;2445;2416,-384;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;2444;2645,-440;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2566;2939.145,-716.757;Inherit;False;Lerp (Clamped);-1;;18656;cad3f473268ed2641979326c3e8290ec;0;3;2;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;2571;-1422.431,-765.886;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;1997;2431,-287;Half;False;Property;_NonLeafColor;Non-Leaf Color;35;0;Create;True;0;0;False;0;1,1,1,1;0.706,0.6903853,0.65658,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;2461;2800,-336;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;2459;2864,-528;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1306;-1393,-632;Half;False;Opacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2458;2864,-560;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2572;-1208.431,-766.886;Half;False;Main_MainTex_RGB;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;3264,-720;Half;False;Leaf_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1076;-2099,-3335;Inherit;False;486;Leaf_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;36;-2143,-3433;Inherit;False;2572;Main_MainTex_RGB;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;2442;3056,-480;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2278;2944,-592;Inherit;False;Average;-1;;18657;3cc639c87d4059642bd54021d04a32cc;2,5,0,4,0;9;15;COLOR;0,0,0,0;False;16;COLOR;0,0,0,0;False;17;FLOAT;0;False;18;FLOAT;0;False;19;FLOAT;0;False;20;FLOAT;0;False;21;FLOAT;0;False;22;FLOAT;0;False;23;FLOAT;0;False;1;COLOR;14
Node;AmplifyShaderEditor.GetLocalVarNode;2437;2816,-256;Inherit;False;1306;Opacity;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;645;128,-896;Inherit;True;Property;_MetallicGlossMap;Leaf Surface;26;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;2574;-1829,-3350;Inherit;False;Color Blend;-1;;18686;e23fbae801d69e440a1b323378db49a5;2,11,0,14,1;3;2;FLOAT3;0,0,0;False;8;COLOR;0,0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;2567;3125.145,-589.757;Inherit;False;Lerp (Clamped);-1;;18685;cad3f473268ed2641979326c3e8290ec;0;3;2;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1965;-1409.985,-2951.07;Inherit;False;Property;_Brightness;Leaf Brightness;32;0;Create;False;0;0;False;0;1;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;1964;-1374.405,-3222.195;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;1967;-1388.603,-3047.107;Inherit;False;Property;_Saturation;Leaf Saturation;31;0;Create;False;0;0;False;0;1;1.05;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2611;-1536,-2304;Inherit;False;Wind (Tree Complex);54;;18688;76dbe6e88a5c02e42a177b05b9981ead;2,981,1,983,1;0;8;FLOAT3;0;FLOAT;1021;FLOAT;1022;FLOAT;1023;FLOAT;1024;FLOAT;1027;FLOAT;1025;FLOAT;1454
Node;AmplifyShaderEditor.RegisterLocalVarNode;1836;512,-704;Half;False;Main_MetallicGlossMap_B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1998;3344.9,-579;Half;False;Other_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;-1408,-864;Half;False;Main_MainTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1968;-1041.985,-2972.269;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2251;-938.7305,-3123.196;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2362;-1065.086,-2306.127;Inherit;False;primary;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2470;-766,-2752;Inherit;False;const;-1;;19114;5b64729fb717c5f49a1bc2dab81d5e1c;4,21,0,3,6,22,0,28,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2261;-1174.098,-3538.5;Inherit;False;487;Main_MainTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1966;-1036.639,-3064.668;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1999;-1185.086,-3453.198;Inherit;False;1998;Other_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2001;-960,-2848;Inherit;False;1836;Main_MetallicGlossMap_B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2358;-482.8973,-2788.158;Inherit;False;1836;Main_MetallicGlossMap_B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;2364;-184.8972,-2778.158;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2360;-354.8973,-2692.158;Inherit;False;Property;_NonLeafFadeStrength;Non-Leaf Fade Strength;40;0;Create;True;0;0;False;0;0.1;0.05;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2577;-872.3656,-3473.559;Inherit;False;Color Blend;-1;;19115;e23fbae801d69e440a1b323378db49a5;2,11,0,14,1;3;2;FLOAT3;0,0,0;False;8;COLOR;0,0,0,0;False;12;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.HSVToRGBNode;1963;-867.8036,-3060.846;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2469;-626.1912,-2885.461;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2363;-354.8973,-2884.158;Inherit;False;2362;primary;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2568;-386.3371,-3065.223;Inherit;False;Lerp (Clamped);-1;;19117;cad3f473268ed2641979326c3e8290ec;0;3;2;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;2357;-124.8006,-3193.814;Half;False;Property;_NonLeafFadeColor;Non-Leaf Fade Color;39;0;Create;True;0;0;False;0;0.3773585,0.3773585,0.3773585,1;0.3773578,0.3773578,0.3773578,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2361;55.65979,-2797.214;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2258;859.512,-2608.943;Inherit;False;487;Main_MainTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2565;285.748,-2844.891;Inherit;False;Lerp (Clamped);-1;;19118;cad3f473268ed2641979326c3e8290ec;0;3;2;FLOAT3;0,0,0;False;4;COLOR;0,0,0,0;False;5;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2464;716.246,-2944.693;Inherit;False;Mesh Values (Tree) (Complex) (UV3);-1;;19119;8e1e1d817f2a77d4ea50f9fe634408b6;0;0;2;FLOAT3;500;FLOAT;549
Node;AmplifyShaderEditor.FunctionNode;2256;887.9677,-2807.507;Inherit;False;Tree Component ID;-1;;19120;5271313988492174092a46e3f289ae62;1,4,3;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2255;1211.013,-2739.906;Inherit;False;Multi Comparison;-1;;19121;8cbe358a30145e843bfece526f25c2c8;1,4,1;4;17;FLOAT;0;False;18;FLOAT;0;False;19;COLOR;0,0,0,0;False;20;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;1343;1424.609,-2733.656;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1974;977.0313,399.9056;Half;False;Property;_TransmissionCutoff;Leaf Transmission Cutoff;46;0;Create;False;0;0;False;0;0.25;0.05;0;0.25;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2580;1574.235,-2542.391;Inherit;False;ALBEDO_PREBACKSHADE;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1932;977.0313,271.9056;Inherit;False;1836;Main_MetallicGlossMap_B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2582;640,896;Half;False;Property;_TransmissionCutoff1;Leaf Transmission Albedo Blend;47;0;Create;False;0;0;False;0;0.25;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2543;593.2769,777.0731;Inherit;False;2580;ALBEDO_PREBACKSHADE;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1933;575.5095,593.5618;Half;False;Property;_SubsurfaceColor;Leaf Subsurface Color;45;0;Create;False;0;0;False;0;1,1,1,1;0.7416955,0.85,0.2655126,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2163;1297.031,271.9056;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;2164;1297.031,399.9056;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2165;1457.031,271.9056;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2583;1024,640;Inherit;False;Lerp (Clamped);-1;;19122;cad3f473268ed2641979326c3e8290ec;0;3;2;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;1976;1617.031,319.9057;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1309;-1920,448;Half;False;Property;_VertexOcclusion;Vertex Occlusion;29;0;Create;True;0;0;False;0;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2419;-1920,128;Inherit;False;const;-1;;19123;5b64729fb717c5f49a1bc2dab81d5e1c;4,21,0,3,1,22,0,28,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1814;-1920,256;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;2549;1484.777,736.3731;Inherit;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2552;1868.777,528.3731;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1308;-1664,128;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;2553;1484.777,624.3731;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2555;2316.777,608.3731;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1312;-1472,128;Half;False;Vertex_Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1788;512,-800;Half;False;Main_MetallicGlossMap_G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2425;-1152,128;Inherit;False;const;-1;;19128;5b64729fb717c5f49a1bc2dab81d5e1c;4,21,0,3,1,22,0,28,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2166;2524.627,620.636;Half;False;OUT_TRANSLUCENCY;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1973;542.0725,-2144.139;Inherit;False;Constant;_Float6;Float 6;58;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1795;-1152,256;Inherit;False;1788;Main_MetallicGlossMap_G;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2396;492.4708,-1922.878;Half;False;Property;_TranlucencyFadeDistance;Tranlucency Fade Distance;43;0;Create;True;0;0;False;0;64;256;12;256;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1792;-1152,448;Half;False;Property;_Occlusion;Texture Occlusion;28;0;Create;False;0;0;False;0;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2398;499.7979,-1837.691;Half;False;Property;_TranlucencyFadeOffset;Tranlucency Fade Offset;44;0;Create;True;0;0;False;0;24;128;12;256;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1313;523.8236,-2222.883;Inherit;False;1312;Vertex_Occlusion;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;744;512,-608;Half;False;Main_MetallicGlossMap_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1958;443.3562,-2047.928;Half;False;Property;_OcclusionTransmissionDamping;Occlusion Transmission Damping;42;0;Create;False;0;0;False;0;0.5;0.386;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CameraDepthFade;2397;877.4091,-1871.176;Inherit;False;3;2;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;749;-128,128;Inherit;False;744;Main_MetallicGlossMap_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;294;-128,208;Half;False;Property;_Glossiness;Leaf Smoothness;27;0;Create;False;0;0;False;0;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1972;883.5731,-2142.975;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2168;799.9183,-1994.376;Inherit;False;2166;OUT_TRANSLUCENCY;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;655;-1024,-848;Half;False;Property;_BumpScale;Leaf Normal Scale;25;0;Create;False;0;0;False;0;1;3;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1793;-832,128;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;2399;1127.981,-1867.067;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;607;-734.7517,-892.5138;Inherit;True;Property;_BumpMap;Leaf Normal;24;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;745;192,128;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1938;1134.081,-2065.563;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1794;-576,128;Half;False;Main_Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2428;-1792,-1920;Inherit;False;Pivot Billboard;-1;;19129;50ed44a1d0e6ecb498e997b8969f8558;3,431,2,432,2,433,2;0;3;FLOAT3;370;FLOAT3;369;FLOAT4;371
Node;AmplifyShaderEditor.FunctionNode;1977;-427,-893;Inherit;False;Normal BackFace;-1;;19159;121446c878db06f4c847f9c5afed7cfe;0;1;13;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2006;-1082.804,-2121.974;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;660;384,128;Half;False;SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1800;659.2943,-2321.05;Inherit;False;1794;Main_Occlusion;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1783;-1060.781,-2210.117;Inherit;False;1306;Opacity;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2395;1338.653,-1900.816;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;2487;-808.2715,-2129.253;Inherit;False;Execute LOD Fade;-1;;19163;18ea34bd83a0d6c4db425672111543e6;0;2;41;FLOAT;0;False;58;FLOAT3;0,0,0;False;3;FLOAT;0;FLOAT3;91;FLOAT;96
Node;AmplifyShaderEditor.GetLocalVarNode;654;1819.393,-2171.265;Inherit;False;660;SMOOTHNESS;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2370;-1408,-1920;Inherit;False;bb_normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;1465;2911.073,-2294.233;Inherit;False;797.8645;735.9034;DRAWERS;12;2391;2159;1469;1468;2432;2366;2247;1466;1472;2492;2491;2433;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.SaturateNode;2400;1559.371,-1891.277;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2371;-1408,-1792;Inherit;False;bb_tangent;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;620;-206,-880;Half;False;MainBumpMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;2573;1884.073,-2726.479;Inherit;False;Backshade;-1;;19176;ef1e6c9fe3ccd0a469022ea4da76c89a;0;1;25;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1898;884.1817,-2252.999;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2432;2943.073,-1846.233;Half;False;Property;_BACKSHADINGG;[ BACKSHADINGG ];48;0;Create;True;0;0;True;1;InternalCategory(Backshading);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2373;1920.161,-1606.224;Inherit;False;2370;bb_normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;2612;2404.444,-2206.387;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1468;2943.073,-2038.233;Half;False;Property;_LEAFF;[ LEAFF ];22;0;Create;True;0;0;True;1;InternalCategory(Leaf);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1472;2943.073,-2230.233;Half;False;Property;_BANNER;BANNER;14;0;Create;True;0;0;True;1;InternalBanner(Internal, Leaf);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2366;2943.073,-1750.233;Inherit;False;Internal Features Support;-1;;19186;3c493d142aeebd840af72d626f6915c6;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2386;562.188,-1734.744;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;2557;216.1397,-1698.837;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2391;3423.073,-1654.233;Inherit;False;Property;_Cutoff;_Cutoff;16;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2492;3263.073,-1654.233;Half;False;Property;_IsShadow;Is Shadow;82;2;[HideInInspector];[Toggle];Create;True;2;Off;0;On;1;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;624;1818.87,-2284.993;Inherit;False;620;MainBumpMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1466;2943.073,-2134.233;Half;False;Property;_RENDERINGG;[ RENDERINGG ];15;0;Create;True;0;0;True;1;InternalCategory(Rendering);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2615;2432,-1888;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2491;3103.073,-1654.233;Half;False;Property;_IsLeaf;Is Leaf;80;2;[HideInInspector];[Toggle];Create;True;2;Off;0;On;1;0;True;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2374;1962.249,-1488.577;Inherit;False;2371;bb_tangent;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;2433;2943.073,-1654.233;Half;False;Property;_IsBark;Is Bark;81;2;[HideInInspector];[Toggle];Create;True;2;Off;0;On;1;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1469;3167.073,-1846.233;Half;False;Property;_SETTINGSS;[ SETTINGSS ];53;0;Create;True;0;0;True;1;InternalCategory(Settings);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2352;1310.331,-3269.663;Inherit;False;Property;_Backshade;Backshade;49;0;Create;True;0;0;False;0;0.4528302,0.4528302,0.4528302,1;0,0,0,0.6627451;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;2614;2432,-1968;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2124;-1024,-1792;Half;False;Property;_CutoffLowNear;Cutoff Low (Near);17;0;Create;True;3;Off;0;Front;1;Back;2;0;True;0;0.75;0.7;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2123;-1088,-1664;Half;False;Property;_CutoffHighNear;Cutoff High (Near);18;0;Create;True;3;Off;0;Front;1;Back;2;0;True;0;1;0.9;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2465;-1102.549,-1952.639;Inherit;False;Mesh Values (Tree) (Complex) (Vertex Colors);-1;;19133;9cacaefc2ecfddf4c8e070f9be99b854;0;0;4;FLOAT;495;FLOAT;501;FLOAT;550;FLOAT;552
Node;AmplifyShaderEditor.RangedFloatNode;1982;-1024,-1408;Half;False;Property;_CutoffHighFar;Cutoff High (Far);21;0;Create;True;3;Off;0;Front;1;Back;2;0;True;0;0.6;0.333;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2613;2432,-2048;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2126;-960,-1280;Half;False;Property;_CutoffFar;Cutoff Far;19;0;Create;True;3;Off;0;Front;1;Back;2;0;True;0;64;128;64;1024;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2313;1273.608,-3005.852;Inherit;False;Property;_BackshadingPower;Backshading Power;51;0;Create;True;0;0;False;0;1;2.91;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;862;-1088,-1552;Half;False;Property;_CutoffLowFar;Cutoff Low (Far);20;0;Create;True;3;Off;0;Front;1;Back;2;0;True;0;0.1;0.158;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2416;-539.3831,-1642.936;Inherit;False;Cutoff Distance;7;;19160;5fa78795cf865fc4fba7d47ebe2d2d92;0;2;33;FLOAT;0;False;16;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2297;1282.864,-2929.525;Inherit;False;Property;_BackshadingContrast;Backshading Contrast;52;0;Create;True;0;0;False;0;1;1.93;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;1981;-130.7867,-1690.556;Inherit;False;clip( opacity - cutoff )@;7;False;2;True;opacity;FLOAT;0;In;;Float;False;True;cutoff;FLOAT;0;In;;Float;False;My Custom Expression;False;False;0;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2558;46.13968,-1603.837;Inherit;False;Constant;_Float14;Float 14;52;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2159;2943.073,-1942.233;Half;False;Property;_TRANSLUCENCYY;[ TRANSLUCENCYY ];41;0;Create;True;0;0;True;1;InternalCategory(Translucency);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2247;3103.073,-2038.233;Half;False;Property;_COLORR;[ COLORR ];30;0;Create;True;0;0;True;1;InternalCategory(Color);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2315;1284.311,-3084.324;Inherit;False;Property;_BackshadingBias;Backshading Bias;50;0;Create;True;0;0;False;0;0;0.148;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2623.32,-2094.93;Float;False;True;-1;4;AppalachiaShaderGUI;400;0;Standard;appalachia/leaf_LOD0_backup;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;False;True;False;False;False;True;Off;0;False;925;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.2;True;True;0;False;TransparentCutout;;AlphaTest;ForwardOnly;12;d3d9;d3d11_9x;d3d11;glcore;gles3;metal;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;550;10;False;553;0;1;False;550;10;False;553;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;False;False;_BILLBOARD_ON;Relative;400;;-1;0;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;14;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;1544;-1920,0;Inherit;False;1678.076;100;Ambient Occlusion;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;751;-128,0;Inherit;False;709.9668;100;Metallic / Smoothness;0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;715;128,-1024;Inherit;False;638;100;Surface Texture (Metallic, AO, SubSurface, Smoothness);0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;760;-1792,-1024;Inherit;False;578.3026;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;2440;1024,-1024;Inherit;False;2559.85;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1936;640,0;Inherit;False;1235.26;100;Transmission;0;;0.7843137,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;708;-1024,-1024;Inherit;False;1027.031;100;Normal Texture;0;;0.5019608,0.5019608,1,1;0;0
WireConnection;2271;0;2230;1
WireConnection;2271;1;2230;3
WireConnection;2438;0;2230;2
WireConnection;2267;0;2244;0
WireConnection;2272;0;2271;0
WireConnection;2272;1;2438;0
WireConnection;2449;0;409;0
WireConnection;2446;0;2227;0
WireConnection;2450;0;2449;0
WireConnection;2265;1;2272;0
WireConnection;2265;2;2267;0
WireConnection;2452;0;2446;0
WireConnection;2264;0;2249;0
WireConnection;2264;1;2265;0
WireConnection;2447;0;2450;0
WireConnection;2448;0;409;0
WireConnection;2454;0;2227;0
WireConnection;2453;0;2452;0
WireConnection;2456;0;2447;0
WireConnection;2457;0;2453;0
WireConnection;2455;0;2454;0
WireConnection;2275;1;2264;1
WireConnection;2275;5;2276;0
WireConnection;2451;0;2448;0
WireConnection;2445;0;2451;0
WireConnection;2444;0;2455;0
WireConnection;2566;2;2456;0
WireConnection;2566;4;2457;0
WireConnection;2566;5;2275;0
WireConnection;2571;0;18;0
WireConnection;2461;0;1997;0
WireConnection;2459;0;2444;0
WireConnection;1306;0;18;4
WireConnection;2458;0;2445;0
WireConnection;2572;0;2571;0
WireConnection;486;0;2566;0
WireConnection;2442;0;2461;0
WireConnection;2278;15;2458;0
WireConnection;2278;16;2459;0
WireConnection;2574;2;36;0
WireConnection;2574;8;1076;0
WireConnection;2567;2;2278;14
WireConnection;2567;4;2442;0
WireConnection;2567;5;2437;0
WireConnection;1964;0;2574;0
WireConnection;1836;0;645;3
WireConnection;1998;0;2567;0
WireConnection;487;0;18;0
WireConnection;1968;0;1964;3
WireConnection;1968;1;1965;0
WireConnection;2251;0;1964;1
WireConnection;2362;0;2611;1021
WireConnection;1966;0;1964;2
WireConnection;1966;1;1967;0
WireConnection;2364;0;2358;0
WireConnection;2577;2;2261;0
WireConnection;2577;8;1999;0
WireConnection;1963;0;2251;0
WireConnection;1963;1;1966;0
WireConnection;1963;2;1968;0
WireConnection;2469;0;2001;0
WireConnection;2469;1;2470;0
WireConnection;2568;2;2577;0
WireConnection;2568;4;1963;0
WireConnection;2568;5;2469;0
WireConnection;2361;0;2363;0
WireConnection;2361;1;2364;0
WireConnection;2361;2;2360;0
WireConnection;2565;2;2568;0
WireConnection;2565;4;2357;0
WireConnection;2565;5;2361;0
WireConnection;2255;17;2464;549
WireConnection;2255;18;2256;0
WireConnection;2255;19;2565;0
WireConnection;2255;20;2258;0
WireConnection;1343;0;2255;0
WireConnection;2580;0;1343;0
WireConnection;2163;0;1932;0
WireConnection;2163;1;1974;0
WireConnection;2164;0;1974;0
WireConnection;2165;0;2163;0
WireConnection;2583;2;1933;0
WireConnection;2583;4;2543;0
WireConnection;2583;5;2582;0
WireConnection;1976;0;2165;0
WireConnection;1976;2;2164;0
WireConnection;2549;0;2583;0
WireConnection;2552;0;1976;0
WireConnection;2552;1;2549;0
WireConnection;1308;0;2419;0
WireConnection;1308;1;1814;3
WireConnection;1308;2;1309;0
WireConnection;2553;0;2583;0
WireConnection;2555;0;2552;0
WireConnection;2555;1;2553;0
WireConnection;1312;0;1308;0
WireConnection;1788;0;645;2
WireConnection;2166;0;2555;0
WireConnection;744;0;645;4
WireConnection;2397;0;2396;0
WireConnection;2397;1;2398;0
WireConnection;1972;0;1973;0
WireConnection;1972;1;1313;0
WireConnection;1972;2;1958;0
WireConnection;1793;0;2425;0
WireConnection;1793;1;1795;0
WireConnection;1793;2;1792;0
WireConnection;2399;0;2397;0
WireConnection;607;5;655;0
WireConnection;745;0;749;0
WireConnection;745;1;294;0
WireConnection;1938;0;1972;0
WireConnection;1938;1;2168;0
WireConnection;1794;0;1793;0
WireConnection;1977;13;607;0
WireConnection;2006;0;2611;0
WireConnection;2006;1;2428;370
WireConnection;660;0;745;0
WireConnection;2395;0;1938;0
WireConnection;2395;1;2399;0
WireConnection;2487;41;1783;0
WireConnection;2487;58;2006;0
WireConnection;2370;0;2428;369
WireConnection;2400;0;2395;0
WireConnection;2371;0;2428;371
WireConnection;620;0;1977;0
WireConnection;2573;25;1343;0
WireConnection;1898;0;1800;0
WireConnection;1898;1;1313;0
WireConnection;2612;0;2573;0
WireConnection;2386;0;2487;91
WireConnection;2557;0;1981;0
WireConnection;2557;1;2558;0
WireConnection;2615;0;2400;0
WireConnection;2614;0;1898;0
WireConnection;2613;0;654;0
WireConnection;2416;16;2465;550
WireConnection;1981;1;2487;0
WireConnection;1981;2;2416;0
WireConnection;0;0;2612;0
WireConnection;0;1;624;0
WireConnection;0;4;2613;0
WireConnection;0;5;2614;0
WireConnection;0;7;2615;0
WireConnection;0;11;2386;0
WireConnection;0;12;2373;0
WireConnection;0;13;2374;0
ASEEND*/
//CHKSM=088EDA9C26613EB1330096CC6C92335E00BBDEF9