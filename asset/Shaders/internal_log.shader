// Upgrade NOTE: upgraded instancing buffer 'internallog' to new syntax.

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "appalachia/log"
{
	Properties
	{
		[AppalachiaBanner(Internal, Log)]_BANNER("< BANNER >", Float) = 1
		[AppalachiaCategory(Bark)]_BARK("[ BARK ]", Float) = 0
		_Color("Bark Color", Color) = (1,1,1,1)
		[NoScaleOffset]_MainTex("Bark Albedo", 2D) = "white" {}
		[NoScaleOffset][Normal]_BumpMap("Bark Normal", 2D) = "bump" {}
		_NormalScale("Bark Normal Scale", Range( 0 , 5)) = 1.25
		[NoScaleOffset]_MetallicGlossMap("Bark Surface", 2D) = "white" {}
		_Smoothness("Bark Smoothness (A)", Range( 0 , 1)) = 0.1
		_Occlusion("Bark Occlusion (G)", Range( 0 , 1)) = 1
		[AppalachiaCategory(Wood)]_WOOD("[ WOOD ]", Float) = 0
		_Color9("Wood Ring Color", Color) = (0.3764706,0.3411765,0.3215686,1)
		[NoScaleOffset]_MainTex2("Wood Albedo", 2D) = "white" {}
		[NoScaleOffset][Normal]_BumpMap2("Wood Normal", 2D) = "bump" {}
		_NormalScale2("Wood Normal Scale", Range( 0 , 5)) = 1
		[AppalachiaCategory(Cover)]_COVER("[ COVER ]", Float) = 0
		_Color3("Cover 1 Color", Color) = (1,1,1,1)
		_MainTex3("Cover 1 Albedo", 2D) = "white" {}
		_Cover1UVScale("Cover 1 UV Scale", Vector) = (2,10,0,0)
		[NoScaleOffset][Normal]_BumpMap3("Cover 1 Normal", 2D) = "bump" {}
		_NormalScale3("Cover 1 Normal Scale", Range( 0 , 5)) = 1
		_Color4("Cover 2 Color", Color) = (1,1,1,1)
		_MainTex4("Cover 2 Albedo", 2D) = "white" {}
		_Cover2UVScale("Cover 2 UV Scale", Vector) = (2,10,0,0)
		[NoScaleOffset][Normal]_BumpMap4("Cover 2 Normal", 2D) = "bump" {}
		_NormalScale4("Cover 2 Normal Scale", Range( 0 , 5)) = 1
		[AppalachiaCategory(Cover Blend)]_COVERBLEND("[ COVER BLEND ]", Float) = 0
		_CoverBlendStrength("Cover Blend Strength", Range( 0.0001 , 1)) = 1
		_MaskBlendHeightContrast("Mask Blend Height Contrast", Range( 0 , 1)) = 1
		_BarkHeightRange("Bark Height Range", Range( 0 , 1)) = 1
		_BarkHeightOffset("Bark Height Offset", Range( -1 , 1)) = 0.2
		_MaskHeightRange("Mask Height Range", Range( 0 , 1)) = 0.9
		_MaskHeightOffset("Mask Height Offset", Range( -1 , 1)) = -0.1
		[AppalachiaCategory(Burn)]_BURN("[ BURN ]", Float) = 0
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
		[AppalachiaCategory(Environment)]_ENVIRONMENT("[ ENVIRONMENT ]", Float) = 0
		[PerRendererData]_Wetness("Wetness", Range( 0 , 1)) = 0
		[AppalachiaCategory(Wetness)]_WETNESS("[ WETNESS ]", Float) = 0
		_WetnessDarkening("Wetness Darkening", Range( 0 , 1)) = 0.65
		_WetnessSmoothness("Wetness Smoothness", Range( 0 , 1)) = 0.3
		_WetnessPorosity("Wetness Porosity", Range( 0 , 1)) = 0.1
		[AppalachiaCategory(Instanced)]_INSTANCED("[ INSTANCED ]", Float) = 0
		[PerRendererData]_Seasoned("Seasoned", Range( 0 , 1)) = 0
		[HideInInspector]_MainUVs("_MainUVs", Vector) = (1,1,0,0)
		[HideInInspector]_CullMode("_CullMode", Float) = 0
		[HideInInspector]_Glossiness("_Glossiness", Float) = 0
		[HideInInspector]_Mode("_Mode", Float) = 0
		[HideInInspector]_BumpScale("_BumpScale", Float) = 0
		[HideInInspector]_Internal_UnityToBoxophobic("_Internal_UnityToBoxophobic", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" "DisableBatching" = "True" "IsEmissive" = "true"  }
		LOD 300
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma exclude_renderers gles vulkan 
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform half _INSTANCED;
		uniform half _ENVIRONMENT;
		uniform half _COVERBLEND;
		uniform half _BURN;
		uniform half _BANNER;
		uniform half _COVER;
		uniform half _BARK;
		uniform half _WETNESS;
		uniform half4 _MainUVs;
		uniform float _Mode;
		uniform float _Glossiness;
		uniform half _CullMode;
		uniform float _BumpScale;
		uniform half _Internal_UnityToBoxophobic;
		uniform half _WOOD;
		uniform half _NormalScale;
		uniform sampler2D _BumpMap;
		uniform half _NormalScale2;
		uniform sampler2D _BumpMap2;
		uniform half _NormalScale3;
		uniform sampler2D _BumpMap3;
		uniform float2 _Cover1UVScale;
		uniform half _CoverBlendStrength;
		uniform float _MaskHeightRange;
		uniform float _MaskHeightOffset;
		uniform sampler2D _MetallicGlossMap;
		uniform float _BarkHeightRange;
		uniform float _BarkHeightOffset;
		uniform float _MaskBlendHeightContrast;
		uniform sampler2D _MainTex3;
		uniform half _NormalScale4;
		uniform sampler2D _BumpMap4;
		uniform float2 _Cover2UVScale;
		uniform sampler2D _MainTex4;
		uniform half _CharredNormalScale;
		uniform sampler2D _CharNormal;
		uniform sampler2D _MainTex;
		uniform half4 _Color;
		uniform sampler2D _MainTex2;
		uniform half4 _Color9;
		uniform half4 _Color3;
		uniform half4 _Color4;
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
		uniform half _Smoothness;
		uniform float _WetnessPorosity;
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
		uniform half _Occlusion;

		UNITY_INSTANCING_BUFFER_START(internallog)
			UNITY_DEFINE_INSTANCED_PROP(half, _Burned)
#define _Burned_arr internallog
			UNITY_DEFINE_INSTANCED_PROP(half, _Heat)
#define _Heat_arr internallog
			UNITY_DEFINE_INSTANCED_PROP(float, _Wetness)
#define _Wetness_arr internallog
			UNITY_DEFINE_INSTANCED_PROP(half, _Seasoned)
#define _Seasoned_arr internallog
			UNITY_DEFINE_INSTANCED_PROP(half, _WindProtection)
#define _WindProtection_arr internallog
		UNITY_INSTANCING_BUFFER_END(internallog)


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

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap607 = i.uv_texcoord;
			half3 NormalTex620 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap607 ), _NormalScale );
			float3 temp_output_4_0_g2672 = NormalTex620;
			float3 a13_g2672 = temp_output_4_0_g2672;
			float2 uv_BumpMap22291 = i.uv_texcoord;
			half3 NormalTex22292 = UnpackScaleNormal( tex2D( _BumpMap2, uv_BumpMap22291 ), _NormalScale2 );
			float3 temp_output_5_0_g2672 = NormalTex22292;
			float3 ab14_g2672 = BlendNormals( temp_output_4_0_g2672 , temp_output_5_0_g2672 );
			half Bark_Strength2367 = i.vertexColor.r;
			float blend_strength79_g2671 = saturate( ( 1.0 - Bark_Strength2367 ) );
			float temp_output_21_0_g2672 = saturate( blend_strength79_g2671 );
			float3 lerpResult8_g2672 = lerp( a13_g2672 , ab14_g2672 , temp_output_21_0_g2672);
			float3 b19_g2672 = temp_output_5_0_g2672;
			float3 lerpResult22_g2672 = lerp( lerpResult8_g2672 , b19_g2672 , saturate( ( ( temp_output_21_0_g2672 * 2.0 ) - 1.0 ) ));
			float3 normalizeResult11_g2672 = normalize( lerpResult22_g2672 );
			float3 temp_output_4_0_g2675 = normalizeResult11_g2672;
			float3 a13_g2675 = temp_output_4_0_g2675;
			float2 uv_TexCoord2783 = i.uv_texcoord * _Cover1UVScale;
			half3 NormalTex32304 = UnpackScaleNormal( tex2D( _BumpMap3, uv_TexCoord2783 ), _NormalScale3 );
			float3 temp_output_5_0_g2675 = NormalTex32304;
			float3 ab14_g2675 = BlendNormals( temp_output_4_0_g2675 , temp_output_5_0_g2675 );
			float height_230_g2500 = saturate( ( (0.0 + (0.5 - 0.0) * (_MaskHeightRange - 0.0) / (1.0 - 0.0)) + _MaskHeightOffset ) );
			float2 uv_MetallicGlossMap645 = i.uv_texcoord;
			float4 tex2DNode645 = tex2D( _MetallicGlossMap, uv_MetallicGlossMap645 );
			half SurfaceTex_B1929 = tex2DNode645.b;
			float height_129_g2500 = saturate( ( (0.0 + (SurfaceTex_B1929 - 0.0) * (_BarkHeightRange - 0.0) / (1.0 - 0.0)) + _BarkHeightOffset ) );
			float clampResult6_g2500 = clamp( ( 1.0 - saturate( _MaskBlendHeightContrast ) ) , 1E-07 , 0.999999 );
			float height_start26_g2500 = saturate( ( max( height_129_g2500 , height_230_g2500 ) - clampResult6_g2500 ) );
			float level_239_g2500 = max( ( height_230_g2500 - height_start26_g2500 ) , 0.0 );
			float level_138_g2500 = max( ( height_129_g2500 - height_start26_g2500 ) , 0.0 );
			float temp_output_60_0_g2500 = ( level_138_g2500 + level_239_g2500 + 1E-06 );
			half Cover_Strength1491 = saturate( ( _CoverBlendStrength * ( level_239_g2500 / temp_output_60_0_g2500 ) ) );
			float4 tex2DNode2301 = tex2D( _MainTex3, uv_TexCoord2783 );
			half Vertex_B2368 = i.vertexColor.b;
			half Cover_1_Strength2444 = ( Bark_Strength2367 * Cover_Strength1491 * tex2DNode2301.a * Vertex_B2368 );
			float blend_strength79_g2674 = saturate( Cover_1_Strength2444 );
			float temp_output_21_0_g2675 = saturate( blend_strength79_g2674 );
			float3 lerpResult8_g2675 = lerp( a13_g2675 , ab14_g2675 , temp_output_21_0_g2675);
			float3 b19_g2675 = temp_output_5_0_g2675;
			float3 lerpResult22_g2675 = lerp( lerpResult8_g2675 , b19_g2675 , saturate( ( ( temp_output_21_0_g2675 * 2.0 ) - 1.0 ) ));
			float3 normalizeResult11_g2675 = normalize( lerpResult22_g2675 );
			float3 temp_output_4_0_g2678 = normalizeResult11_g2675;
			float3 a13_g2678 = temp_output_4_0_g2678;
			float2 uv_TexCoord2784 = i.uv_texcoord * _Cover2UVScale;
			half3 NormalTex42311 = UnpackScaleNormal( tex2D( _BumpMap4, uv_TexCoord2784 ), _NormalScale4 );
			float3 temp_output_5_0_g2678 = NormalTex42311;
			float3 ab14_g2678 = BlendNormals( temp_output_4_0_g2678 , temp_output_5_0_g2678 );
			float4 tex2DNode2309 = tex2D( _MainTex4, uv_TexCoord2784 );
			half Vertex_A2369 = i.vertexColor.a;
			half Cover_2_Strength2449 = ( Bark_Strength2367 * Cover_Strength1491 * tex2DNode2309.a * Vertex_A2369 );
			float blend_strength79_g2677 = saturate( Cover_2_Strength2449 );
			float temp_output_21_0_g2678 = saturate( blend_strength79_g2677 );
			float3 lerpResult8_g2678 = lerp( a13_g2678 , ab14_g2678 , temp_output_21_0_g2678);
			float3 b19_g2678 = temp_output_5_0_g2678;
			float3 lerpResult22_g2678 = lerp( lerpResult8_g2678 , b19_g2678 , saturate( ( ( temp_output_21_0_g2678 * 2.0 ) - 1.0 ) ));
			float3 normalizeResult11_g2678 = normalize( lerpResult22_g2678 );
			float3 temp_output_4_0_g2763 = normalizeResult11_g2678;
			float3 a13_g2763 = temp_output_4_0_g2763;
			float2 uv_CharNormal81_g2745 = i.uv_texcoord;
			half3 CharNormal85_g2745 = UnpackScaleNormal( tex2D( _CharNormal, uv_CharNormal81_g2745 ), _CharredNormalScale );
			float3 temp_output_5_0_g2763 = CharNormal85_g2745;
			float3 ab14_g2763 = BlendNormals( temp_output_4_0_g2763 , temp_output_5_0_g2763 );
			half _Burned_Instance = UNITY_ACCESS_INSTANCED_PROP(_Burned_arr, _Burned);
			half Burn_Strength64_g2745 = _Burned_Instance;
			half _Heat_Instance = UNITY_ACCESS_INSTANCED_PROP(_Heat_arr, _Heat);
			half Heat_Strength56_g2745 = _Heat_Instance;
			float _Wetness_Instance = UNITY_ACCESS_INSTANCED_PROP(_Wetness_arr, _Wetness);
			float Wetness_Strength2770 = _Wetness_Instance;
			float temp_output_118_0_g2745 = Wetness_Strength2770;
			float blend_strength79_g2762 = saturate( ( max( Burn_Strength64_g2745 , Heat_Strength56_g2745 ) * ( 1.0 - temp_output_118_0_g2745 ) ) );
			float temp_output_21_0_g2763 = saturate( blend_strength79_g2762 );
			float3 lerpResult8_g2763 = lerp( a13_g2763 , ab14_g2763 , temp_output_21_0_g2763);
			float3 b19_g2763 = temp_output_5_0_g2763;
			float3 lerpResult22_g2763 = lerp( lerpResult8_g2763 , b19_g2763 , saturate( ( ( temp_output_21_0_g2763 * 2.0 ) - 1.0 ) ));
			float3 normalizeResult11_g2763 = normalize( lerpResult22_g2763 );
			o.Normal = normalizeResult11_g2763;
			float2 uv_MainTex18 = i.uv_texcoord;
			float4 tex2DNode18 = tex2D( _MainTex, uv_MainTex18 );
			half4 AlbedoTex487 = tex2DNode18;
			half4 Color486 = _Color;
			float2 uv_MainTex22289 = i.uv_texcoord;
			float3 hsvTorgb2488 = RGBToHSV( tex2D( _MainTex2, uv_MainTex22289 ).rgb );
			half _Seasoned_Instance = UNITY_ACCESS_INSTANCED_PROP(_Seasoned_arr, _Seasoned);
			float3 hsvTorgb2492 = HSVToRGB( float3(hsvTorgb2488.x,( hsvTorgb2488.y * (0.9 + (_Seasoned_Instance - 0.0) * (0.5 - 0.9) / (1.0 - 0.0)) ),hsvTorgb2488.z) );
			half3 AlbedoTex22294 = hsvTorgb2492;
			float4 color2535 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
			half Wood_Darkening2526 = i.vertexColor.g;
			float4 lerpResult2534 = lerp( color2535 , _Color9 , Wood_Darkening2526);
			half4 Color22537 = lerpResult2534;
			float4 lerpResult43_g2671 = lerp( ( float4( AlbedoTex487.rgb , 0.0 ) * Color486 ) , ( float4( AlbedoTex22294 , 0.0 ) * Color22537 ) , blend_strength79_g2671);
			float4 color73_g2674 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
			half4 AlbedoTex32306 = tex2DNode2301;
			half4 Color32307 = _Color3;
			float4 lerpResult43_g2674 = lerp( ( float4( lerpResult43_g2671.rgb , 0.0 ) * color73_g2674 ) , ( float4( AlbedoTex32306.rgb , 0.0 ) * Color32307 ) , blend_strength79_g2674);
			float4 color73_g2677 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
			half4 AlbedoTex42316 = tex2DNode2309;
			half4 Color42312 = _Color4;
			float4 lerpResult43_g2677 = lerp( ( float4( lerpResult43_g2674.rgb , 0.0 ) * color73_g2677 ) , ( float4( AlbedoTex42316.rgb , 0.0 ) * Color42312 ) , blend_strength79_g2677);
			float4 color73_g2762 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
			float2 appendResult22_g2745 = (float2(_BurnMapScaleX , _BurnMapScaleY));
			float2 uv_TexCoord24_g2745 = i.uv_texcoord * appendResult22_g2745;
			float4 tex2DNode34_g2745 = tex2D( _BurnMap, uv_TexCoord24_g2745 );
			half AlbedoTex5_Blue36_g2745 = tex2DNode34_g2745.b;
			float mulTime7_g2745 = _Time.y * _BurnSpeed;
			float2 appendResult3_g2745 = (float2(_BurnNoiseScaleX , _BurnNoiseScaleY));
			float2 uv_TexCoord5_g2745 = i.uv_texcoord * appendResult3_g2745;
			float4 tex2DNode11_g2745 = tex2D( _BurnNoise, uv_TexCoord5_g2745 );
			float clampResult8_g2758 = clamp( sin( ( mulTime7_g2745 + ( tex2DNode11_g2745.g * ( 2.0 * UNITY_PI ) ) + ( 0.5 * UNITY_PI ) ) ) , -1.0 , 1.0 );
			float temp_output_26_0_g2745 = ( ( clampResult8_g2758 * 0.5 ) + 0.5 );
			float4 temp_output_41_0_g2745 = ( _BurnColor2 * AlbedoTex5_Blue36_g2745 * temp_output_26_0_g2745 );
			half AlbedoTex5_Green44_g2745 = tex2DNode34_g2745.g;
			float clampResult8_g2753 = clamp( sin( ( mulTime7_g2745 + ( tex2DNode11_g2745.b * ( 2.0 * UNITY_PI ) ) + ( 1.0 * UNITY_PI ) ) ) , -1.0 , 1.0 );
			half AlbedoTex5_Red38_g2745 = tex2DNode34_g2745.r;
			float4 blendOpSrc58_g2745 = ( _BurnColor2 * AlbedoTex5_Green44_g2745 * ( ( ( ( clampResult8_g2753 * 0.5 ) + 0.5 ) * 0.5 ) + 0.5 ) );
			float4 blendOpDest58_g2745 = ( _BurnColor1 * AlbedoTex5_Red38_g2745 * ( ( temp_output_26_0_g2745 * 0.5 ) + 0.5 ) );
			float4 blendOpSrc63_g2745 = temp_output_41_0_g2745;
			float4 blendOpDest63_g2745 = ( saturate( ( 1.0 - ( 1.0 - blendOpSrc58_g2745 ) * ( 1.0 - blendOpDest58_g2745 ) ) ));
			float4 lerpResult69_g2745 = lerp( float4( 0,0,0,0 ) , ( saturate( 2.0f*blendOpDest63_g2745*blendOpSrc63_g2745 + blendOpDest63_g2745*blendOpDest63_g2745*(1.0f - 2.0f*blendOpSrc63_g2745) )) , Heat_Strength56_g2745);
			float4 blendOpSrc62_g2745 = ( _CharColor2 * AlbedoTex5_Green44_g2745 );
			float4 blendOpDest62_g2745 = ( _CharColor1 * AlbedoTex5_Red38_g2745 );
			float4 lerpResult74_g2745 = lerp( lerpResult69_g2745 , ( ( saturate( ( blendOpSrc62_g2745 + blendOpDest62_g2745 ) )) * ( ( AlbedoTex5_Blue36_g2745 * 0.5 ) + 0.5 ) ) , Burn_Strength64_g2745);
			float4 appendResult83_g2745 = (float4(lerpResult74_g2745.rgb , 1.0));
			float4 Burn_Tex88_g2745 = appendResult83_g2745;
			float4 lerpResult43_g2762 = lerp( ( float4( lerpResult43_g2677.rgb , 0.0 ) * color73_g2762 ) , ( float4( Burn_Tex88_g2745.xyz , 0.0 ) * color73_g2762 ) , blend_strength79_g2762);
			half SurfaceTex_A744 = tex2DNode645.a;
			half Smoothness660 = ( _Smoothness * SurfaceTex_A744 );
			float lerpResult31_g2671 = lerp( Smoothness660 , 0.0 , blend_strength79_g2671);
			float lerpResult31_g2674 = lerp( lerpResult31_g2671 , 0.0 , blend_strength79_g2674);
			float lerpResult31_g2677 = lerp( lerpResult31_g2674 , 0.0 , blend_strength79_g2677);
			float lerpResult31_g2762 = lerp( lerpResult31_g2677 , 0.35 , blend_strength79_g2762);
			float temp_output_10_0_g2766 = lerpResult31_g2762;
			float lerpResult18_g2766 = lerp( 1.0 , ( 1.0 - _WetnessDarkening ) , ( ( 1.0 - 0.0 ) * saturate( ( ( ( 1.0 - temp_output_10_0_g2766 ) - 0.5 ) / max( _WetnessPorosity , 0.001 ) ) ) ));
			float temp_output_14_0_g2765 = _Wetness_Instance;
			float lerpResult22_g2766 = lerp( 1.0 , lerpResult18_g2766 , temp_output_14_0_g2765);
			o.Albedo = ( lerpResult43_g2762 * lerpResult22_g2766 ).rgb;
			float4 color163_g2745 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV122_g2745 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode122_g2745 = ( _GlowBias + _GlowScale * pow( 1.0 - fresnelNdotV122_g2745, _GlowPower ) );
			float4 blendOpSrc84_g2745 = temp_output_41_0_g2745;
			float4 blendOpDest84_g2745 = float4( 0,0,0,0 );
			float4 appendResult87_g2745 = (float4(( saturate( (( blendOpSrc84_g2745 > 0.5 ) ? max( blendOpDest84_g2745, 2.0 * ( blendOpSrc84_g2745 - 0.5 ) ) : min( blendOpDest84_g2745, 2.0 * blendOpSrc84_g2745 ) ) )).rgb , 1.0));
			float4 Emission_Tex89_g2745 = appendResult87_g2745;
			float4 temp_cast_19 = (min( _Heat_Instance , ( 1.0 - _GLOBAL_SOLAR_TIME ) )).xxxx;
			float lerpResult632_g2747 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH , _WIND_AUDIO_INFLUENCE);
			float temp_output_15_0_g2748 = lerpResult632_g2747;
			float lerpResult638_g2747 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_VERYHIGH , _WIND_AUDIO_INFLUENCE);
			float temp_output_16_0_g2748 = lerpResult638_g2747;
			float lerpResult633_g2747 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_HIGH , _WIND_AUDIO_INFLUENCE);
			float temp_output_17_0_g2748 = lerpResult633_g2747;
			float4 temp_cast_20 = (( 1.0 - saturate( ( ( temp_output_15_0_g2748 + temp_output_16_0_g2748 + temp_output_17_0_g2748 ) / 3.0 ) ) )).xxxx;
			float4 temp_cast_21 = (1.0).xxxx;
			half _WindProtection_Instance = UNITY_ACCESS_INSTANCED_PROP(_WindProtection_arr, _WindProtection);
			float4 lerpResult80_g2745 = lerp( CalculateContrast(_EmissionContrast,temp_cast_20) , temp_cast_21 , _WindProtection_Instance);
			half4 Glow_Strength90_g2745 = min( temp_cast_19 , lerpResult80_g2745 );
			float4 lerpResult99_g2762 = lerp( color163_g2745 , saturate( ( fresnelNode122_g2745 * temp_output_118_0_g2745 * Emission_Tex89_g2745 * Glow_Strength90_g2745 ) ) , blend_strength79_g2762);
			o.Emission = lerpResult99_g2762.rgb;
			float lerpResult24_g2766 = lerp( temp_output_10_0_g2766 , saturate( _WetnessSmoothness ) , temp_output_14_0_g2765);
			o.Smoothness = saturate( lerpResult24_g2766 );
			float lerpResult1793 = lerp( 1.0 , tex2DNode645.g , _Occlusion);
			half Occlusion1794 = lerpResult1793;
			float lerpResult34_g2671 = lerp( Occlusion1794 , 1.0 , blend_strength79_g2671);
			float lerpResult34_g2674 = lerp( lerpResult34_g2671 , 1.0 , blend_strength79_g2674);
			float lerpResult34_g2677 = lerp( lerpResult34_g2674 , 1.0 , blend_strength79_g2677);
			float lerpResult34_g2762 = lerp( lerpResult34_g2677 , 1.0 , blend_strength79_g2762);
			o.Occlusion = lerpResult34_g2762;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AppalachiaShaderGUI"
}
/*ASEBEGIN
Version=17500
0;-864;1536;843;-387.5359;1591.9;1;True;False
Node;AmplifyShaderEditor.SamplerNode;645;-2561.937,293.4464;Inherit;True;Property;_MetallicGlossMap;Bark Surface;6;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;76d255aa3d2125742972e90108d84fb9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1929;-2177.937,469.4464;Half;False;SurfaceTex_B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2273;-2560.937,1653.446;Inherit;True;Constant;_Float0;Float 0;61;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2231;-2557.937,1450.446;Inherit;True;1929;SurfaceTex_B;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2226;-2555.937,2136.447;Float;False;Property;_MaskHeightRange;Mask Height Range;30;0;Create;True;0;0;False;0;0.9;0.9;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2227;-2555.937,2216.447;Float;False;Property;_MaskHeightOffset;Mask Height Offset;31;0;Create;True;0;0;False;0;-0.1;0.09;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2223;-2555.937,1880.446;Float;False;Property;_MaskBlendHeightContrast;Mask Blend Height Contrast;27;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2225;-2555.937,2056.447;Float;False;Property;_BarkHeightOffset;Bark Height Offset;29;0;Create;True;0;0;False;0;0.2;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2224;-2555.937,1976.446;Float;False;Property;_BarkHeightRange;Bark Height Range;28;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1426;-2001.938,1437.446;Half;False;Property;_CoverBlendStrength;Cover Blend Strength;26;0;Create;True;0;0;False;1;;1;1;0.0001;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2222;-2049.938,1573.446;Inherit;False;Height Blend;-1;;2500;f050d451a30c809489d59339735fb04d;0;7;3;FLOAT;0.5;False;1;FLOAT;0;False;19;FLOAT;1;False;13;FLOAT;0;False;21;FLOAT;0;False;24;FLOAT;1;False;22;FLOAT;0;False;2;FLOAT;61;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;2782;-817.0968,435.1938;Inherit;False;Property;_Cover1UVScale;Cover 1 UV Scale;17;0;Create;True;0;0;False;0;2,10;2,2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;2494;-128,-352;Inherit;False;Constant;_Float8;Float 8;51;0;Create;True;0;0;False;0;0.9;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2496;25.40613,-364.4963;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2289;-256,-640;Inherit;True;Property;_MainTex2;Wood Albedo;11;1;[NoScaleOffset];Create;False;0;0;False;0;-1;e617007078613a344859e2f3297489a7;e617007078613a344859e2f3297489a7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2495;48,-336;Inherit;False;Constant;_Float4;Float 4;51;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;2785;-928.1937,1540.913;Inherit;False;Property;_Cover2UVScale;Cover 2 UV Scale;22;0;Create;True;0;0;False;0;2,10;2,2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2232;-1665.938,1445.446;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2459;-256,-432;Half;False;InstancedProperty;_Seasoned;Seasoned;62;1;[PerRendererData];Create;False;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2783;-593.0968,419.1938;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;2366;-1923.938,937.4464;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;2493;304,-464;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2526;-1537.938,933.4464;Half;False;Wood_Darkening;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2414;-1505.938,1445.446;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2784;-704.1938,1524.913;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2301;-258.9049,256;Inherit;True;Property;_MainTex3;Cover 1 Albedo;16;0;Create;False;0;0;False;0;-1;7bd665909baf0724c890b7b1c247b411;7bd665909baf0724c890b7b1c247b411;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RGBToHSVNode;2488;128,-640;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;655;-2561.937,-90.55363;Half;False;Property;_NormalScale;Bark Normal Scale;5;0;Create;False;0;0;False;0;1.25;1.25;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2115;-1873.938,565.4464;Inherit;False;const;-1;;2519;5b64729fb717c5f49a1bc2dab81d5e1c;4,21,0,3,1,22,0,28,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;294;-1921.938,293.4464;Half;False;Property;_Smoothness;Bark Smoothness (A);7;0;Create;False;0;0;False;0;0.1;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2367;-1537.938,805.4464;Half;False;Bark_Strength;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2536;768,-192;Half;False;Property;_Color9;Wood Ring Color;10;0;Create;False;0;0;False;0;0.3764706,0.3411765,0.3215686,1;0.3764705,0.3411765,0.3215685,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;2535;768,-384;Inherit;False;Constant;_Color0;Color 0;53;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;744;-2177.937,549.4464;Half;False;SurfaceTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1792;-1905.938,683.4464;Half;False;Property;_Occlusion;Bark Occlusion (G);8;0;Create;False;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2415;-1869.04,452.157;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2368;-1537.938,1061.446;Half;False;Vertex_B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1491;-1346.131,1504.291;Half;False;Cover_Strength;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2490;560,-512;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2539;240,448;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2290;-256,-127;Half;False;Property;_NormalScale2;Wood Normal Scale;13;0;Create;False;0;0;False;0;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2786;-382.8916,692.0328;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;2530;757,5;Inherit;False;2526;Wood_Darkening;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2309;-256,1280;Inherit;True;Property;_MainTex4;Cover 2 Albedo;21;0;Create;False;0;0;False;0;-1;f41153bb8a3f8e8468b1b75a35908a55;f41153bb8a3f8e8468b1b75a35908a55;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;1793;-1489.938,565.4464;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.HSVToRGBNode;2492;768,-640;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WireNode;2450;112,1360;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2473;384,384;Inherit;False;1491;Cover_Strength;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2443;384,512;Inherit;False;2368;Vertex_B;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;607;-2241.937,-90.55363;Inherit;True;Property;_BumpMap;Bark Normal;4;2;[NoScaleOffset];[Normal];Create;False;0;0;False;0;-1;None;5fb550c5a1638ac44bc02d8d57d0f27a;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;745;-1617.938,293.4464;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;409;-1873.938,-474.5536;Half;False;Property;_Color;Bark Color;2;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;18;-2561.937,-474.5536;Inherit;True;Property;_MainTex;Bark Albedo;3;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;c84c356dbe41a9e4f8c037d02c074740;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;2369;-1537.938,1189.446;Half;False;Vertex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2554;576,480;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2787;-22.8916,768.0328;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;2474;352,1280;Inherit;False;1491;Cover_Strength;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2291;64,-128;Inherit;True;Property;_BumpMap2;Wood Normal;12;2;[NoScaleOffset];[Normal];Create;False;0;0;False;0;-1;83d94d0b078da624f9985b1e9a2f81e6;83d94d0b078da624f9985b1e9a2f81e6;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;2534;1152,-208;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2302;-256,832;Half;False;Property;_NormalScale3;Cover 1 Normal Scale;19;0;Create;False;0;0;False;0;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2547;640,256;Inherit;False;2367;Bark_Strength;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2370;-2586.744,-941.5001;Inherit;False;2367;Bark_Strength;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2553;640,1152;Inherit;False;2367;Bark_Strength;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2294;1088,-640;Half;False;AlbedoTex2;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2310;-256,1712;Half;False;Property;_NormalScale4;Cover 2 Normal Scale;24;0;Create;False;0;0;False;0;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2448;512,1408;Inherit;False;2369;Vertex_A;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2303;64,784;Inherit;True;Property;_BumpMap3;Cover 1 Normal;18;2;[NoScaleOffset];[Normal];Create;False;0;0;False;0;-1;b1387feb487df5f48b780bc8fd555905;b1387feb487df5f48b780bc8fd555905;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;2544;624,1344;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2788;-37.10382,1673.997;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;2451;624,1376;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2537;1406.949,-214.3049;Half;False;Color2;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;2308;640,768;Half;False;Property;_Color3;Cover 1 Color;15;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2442;1152,384;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1794;-1296.938,565.4464;Half;False;Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2292;384,-128;Half;False;NormalTex2;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;-2177.937,-474.5536;Half;False;AlbedoTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;620;-1921.938,-90.55363;Half;False;NormalTex;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;660;-1457.938,293.4464;Half;False;Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;-1649.938,-474.5536;Half;False;Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2314;64,1664;Inherit;True;Property;_BumpMap4;Cover 2 Normal;23;2;[NoScaleOffset];[Normal];Create;False;0;0;False;0;-1;aa8ba3b776465e043914b5d4dd03955d;aa8ba3b776465e043914b5d4dd03955d;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;2533;-2586.744,-1117.5;Inherit;False;2537;Color2;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2304;384,784;Half;False;NormalTex3;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2374;-2586.744,-1485.5;Inherit;False;620;NormalTex;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2375;-2586.744,-1197.5;Inherit;False;2294;AlbedoTex2;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2373;-2586.744,-1037.5;Inherit;False;2292;NormalTex2;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2418;-2586.744,-1405.5;Inherit;False;1794;Occlusion;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2376;-2586.744,-1645.5;Inherit;False;487;AlbedoTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2447;1152,1280;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2307;896,768;Half;False;Color3;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2417;-2586.744,-1325.5;Inherit;False;660;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2313;640,1664;Half;False;Property;_Color4;Cover 2 Color;20;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;2364;-2586.744,-1565.5;Inherit;False;486;Color;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;2806;-2378.744,-941.5001;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2444;1409.3,384;Half;False;Cover_1_Strength;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2306;128,256;Half;False;AlbedoTex3;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2821;-2074.744,-1581.5;Inherit;False;PBR Blend;-1;;2671;21e73cccd5c79a44d8d92e637197fe0d;0;17;59;FLOAT3;0,0,0;False;61;COLOR;0,0,0,0;False;63;FLOAT3;0,0,0;False;103;FLOAT;0;False;67;FLOAT;0;False;75;FLOAT;0;False;64;FLOAT;0;False;96;COLOR;0,0,0,0;False;60;FLOAT3;0,0,0;False;62;COLOR;0,0,0,0;False;66;FLOAT3;0,0,0;False;104;FLOAT;0;False;68;FLOAT;0;False;76;FLOAT;0;False;65;FLOAT;0;False;97;COLOR;0,0,0,0;False;69;FLOAT;0;False;7;COLOR;0;FLOAT3;92;FLOAT;108;FLOAT;93;FLOAT;94;FLOAT;95;COLOR;101
Node;AmplifyShaderEditor.GetLocalVarNode;2430;-1778.386,-1340.118;Inherit;False;2307;Color3;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2449;1408,1280;Half;False;Cover_2_Strength;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2311;384,1664;Half;False;NormalTex4;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2829;-186.8459,-1845.982;Inherit;False;InstancedProperty;_Wetness;Wetness;55;1;[PerRendererData];Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2429;-1777.386,-1249.118;Inherit;False;2304;NormalTex3;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2312;1023,1662;Half;False;Color4;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2437;-1770.922,-1167.06;Inherit;False;2444;Cover_1_Strength;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2316;128,1280;Half;False;AlbedoTex4;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2428;-1780.386,-1418.118;Inherit;False;2306;AlbedoTex3;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2433;-1109.958,-1315.268;Inherit;False;2312;Color4;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2822;-1433.021,-1583.559;Inherit;False;PBR Blend;-1;;2674;21e73cccd5c79a44d8d92e637197fe0d;0;17;59;FLOAT3;0,0,0;False;61;COLOR;0,0,0,0;False;63;FLOAT3;0,0,0;False;103;FLOAT;0;False;67;FLOAT;0;False;75;FLOAT;0;False;64;FLOAT;0;False;96;COLOR;0,0,0,0;False;60;FLOAT3;0,0,0;False;62;COLOR;0,0,0,0;False;66;FLOAT3;0,0,0;False;104;FLOAT;0;False;68;FLOAT;0;False;76;FLOAT;0;False;65;FLOAT;0;False;97;COLOR;0,0,0,0;False;69;FLOAT;0;False;7;COLOR;0;FLOAT3;92;FLOAT;108;FLOAT;93;FLOAT;94;FLOAT;95;COLOR;101
Node;AmplifyShaderEditor.RegisterLocalVarNode;2770;135.5343,-1947.809;Inherit;False;Wetness_Strength;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2431;-1109.957,-1393.968;Inherit;False;2316;AlbedoTex4;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2432;-1110.157,-1241.668;Inherit;False;2311;NormalTex4;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2439;-1101.775,-1162.652;Inherit;False;2449;Cover_2_Strength;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2823;-791.2982,-1585.618;Inherit;False;PBR Blend;-1;;2677;21e73cccd5c79a44d8d92e637197fe0d;0;17;59;FLOAT3;0,0,0;False;61;COLOR;0,0,0,0;False;63;FLOAT3;0,0,0;False;103;FLOAT;0;False;67;FLOAT;0;False;75;FLOAT;0;False;64;FLOAT;0;False;96;COLOR;0,0,0,0;False;60;FLOAT3;0,0,0;False;62;COLOR;0,0,0,0;False;66;FLOAT3;0,0,0;False;104;FLOAT;0;False;68;FLOAT;0;False;76;FLOAT;0;False;65;FLOAT;0;False;97;COLOR;0,0,0,0;False;69;FLOAT;0;False;7;COLOR;0;FLOAT3;92;FLOAT;108;FLOAT;93;FLOAT;94;FLOAT;95;COLOR;101
Node;AmplifyShaderEditor.GetLocalVarNode;2776;-462.196,-1391.126;Inherit;False;2770;Wetness_Strength;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2833;-214.1911,-1588.923;Inherit;False;Burnable;33;;2745;a0caf447e4aba704388d4974489e2842;0;8;138;FLOAT3;0,0,0;False;131;FLOAT3;0,0,0;False;168;FLOAT;0;False;132;FLOAT;0;False;145;FLOAT;0;False;134;FLOAT;0;False;162;COLOR;0,0,0,0;False;118;FLOAT;0;False;7;COLOR;151;FLOAT3;150;FLOAT;167;FLOAT;149;FLOAT;148;FLOAT;147;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;1465;1366.518,-1633.75;Inherit;False;473.9341;685.5376;Drawers;9;2689;2688;2413;1938;1469;2412;1513;1468;1472;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;2689;1398.518,-1025.75;Half;False;Property;_INSTANCED;[ INSTANCED ];61;0;Create;True;0;0;True;1;InternalCategory(Instanced);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1938;1604.589,-1563.338;Inherit;False;Internal Unity Props;63;;2767;b286e6ef621b64a4fb35da1e13fa143f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;646;-2177.937,293.4464;Half;False;SurfaceTex_R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2832;331.1015,-1809.345;Inherit;False;Wettable;56;;2765;ab843f2248a33694ab8e680c830bea7f;0;4;14;FLOAT;1;False;11;COLOR;1,1,1,1;False;13;FLOAT;0;False;12;FLOAT;0;False;2;COLOR;9;FLOAT;10
Node;AmplifyShaderEditor.RangedFloatNode;1468;1398.518,-1505.75;Half;False;Property;_BARK;[ BARK ];1;0;Create;True;0;0;True;1;InternalCategory(Bark);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1513;1398.518,-1425.75;Half;False;Property;_WOOD;[ WOOD ];9;0;Create;True;0;0;True;1;InternalCategory(Wood);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1472;1398.518,-1585.75;Half;False;Property;_BANNER;< BANNER >;0;0;Create;True;0;0;True;1;InternalBanner(Internal, Log);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2413;1398.518,-1185.75;Half;False;Property;_BURN;[ BURN ];32;0;Create;True;0;0;True;1;InternalCategory(Burn);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1469;1398.518,-1265.75;Half;False;Property;_COVERBLEND;[ COVER BLEND ];25;0;Create;True;0;0;True;1;InternalCategory(Cover Blend);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;616;-2177.937,-378.5536;Half;False;AlbedoTex_Alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2688;1398.518,-1105.75;Half;False;Property;_ENVIRONMENT;[ ENVIRONMENT ];54;0;Create;True;0;0;True;1;InternalCategory(Environment);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2412;1398.518,-1345.75;Half;False;Property;_COVER;[ COVER ];14;0;Create;True;0;0;True;1;InternalCategory(Cover);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;791.0519,-1596.922;Float;False;True;-1;2;AppalachiaShaderGUI;300;0;Standard;appalachia/log;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;False;True;False;False;False;True;Back;0;False;925;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0;True;True;0;False;Opaque;;Geometry;All;12;d3d9;d3d11_9x;d3d11;glcore;gles3;metal;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;550;10;False;553;0;1;False;550;10;False;553;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;False;False;_BILLBOARD_ON;Relative;300;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;14;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;2300;-256,1024;Inherit;False;1910.86;100;Cover 2 Main Texture;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;2287;-256,-256;Inherit;False;835.139;100;Normal Texture;0;;0.5019608,0.5019608,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;708;-2561.937,-218.5536;Inherit;False;835.139;100;Normal Texture;0;;0.5019608,0.5019608,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;2297;-256,640;Inherit;False;1343.139;100;Cover 1 Normal Texture;0;;0.5019608,0.5019608,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1546;-2561.937,1317.446;Inherit;False;1279.808;100;Blend Height Mask;0;;1,0.234,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;760;-2561.937,-602.5536;Inherit;False;1099.66;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;2298;-256,128;Inherit;False;1821.26;100;Cover 1 Main Texture;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;2288;-256,-768;Inherit;False;1345.36;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;715;-2561.937,165.4464;Inherit;False;1320.04;100;Smoothness Texture(Metallic, AO, Height, Smoothness);0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;2299;-256,1536;Inherit;False;1347.139;100;Cover 2 Normal Texture;0;;0.5019608,0.5019608,1,1;0;0
WireConnection;1929;0;645;3
WireConnection;2222;3;2223;0
WireConnection;2222;1;2231;0
WireConnection;2222;19;2224;0
WireConnection;2222;13;2225;0
WireConnection;2222;21;2273;0
WireConnection;2222;24;2226;0
WireConnection;2222;22;2227;0
WireConnection;2496;0;2494;0
WireConnection;2232;0;1426;0
WireConnection;2232;1;2222;0
WireConnection;2783;0;2782;0
WireConnection;2493;0;2459;0
WireConnection;2493;3;2496;0
WireConnection;2493;4;2495;0
WireConnection;2526;0;2366;2
WireConnection;2414;0;2232;0
WireConnection;2784;0;2785;0
WireConnection;2301;1;2783;0
WireConnection;2488;0;2289;0
WireConnection;2367;0;2366;1
WireConnection;744;0;645;4
WireConnection;2415;0;645;2
WireConnection;2368;0;2366;3
WireConnection;1491;0;2414;0
WireConnection;2490;0;2488;2
WireConnection;2490;1;2493;0
WireConnection;2539;0;2301;4
WireConnection;2786;0;2783;0
WireConnection;2309;1;2784;0
WireConnection;1793;0;2115;0
WireConnection;1793;1;2415;0
WireConnection;1793;2;1792;0
WireConnection;2492;0;2488;1
WireConnection;2492;1;2490;0
WireConnection;2492;2;2488;3
WireConnection;2450;0;2309;4
WireConnection;607;5;655;0
WireConnection;745;0;294;0
WireConnection;745;1;744;0
WireConnection;2369;0;2366;4
WireConnection;2554;0;2539;0
WireConnection;2787;0;2786;0
WireConnection;2291;5;2290;0
WireConnection;2534;0;2535;0
WireConnection;2534;1;2536;0
WireConnection;2534;2;2530;0
WireConnection;2294;0;2492;0
WireConnection;2303;1;2787;0
WireConnection;2303;5;2302;0
WireConnection;2544;0;2474;0
WireConnection;2788;0;2784;0
WireConnection;2451;0;2450;0
WireConnection;2537;0;2534;0
WireConnection;2442;0;2547;0
WireConnection;2442;1;2473;0
WireConnection;2442;2;2554;0
WireConnection;2442;3;2443;0
WireConnection;1794;0;1793;0
WireConnection;2292;0;2291;0
WireConnection;487;0;18;0
WireConnection;620;0;607;0
WireConnection;660;0;745;0
WireConnection;486;0;409;0
WireConnection;2314;1;2788;0
WireConnection;2314;5;2310;0
WireConnection;2304;0;2303;0
WireConnection;2447;0;2553;0
WireConnection;2447;1;2544;0
WireConnection;2447;2;2451;0
WireConnection;2447;3;2448;0
WireConnection;2307;0;2308;0
WireConnection;2806;0;2370;0
WireConnection;2444;0;2442;0
WireConnection;2306;0;2301;0
WireConnection;2821;59;2376;0
WireConnection;2821;61;2364;0
WireConnection;2821;63;2374;0
WireConnection;2821;67;2418;0
WireConnection;2821;64;2417;0
WireConnection;2821;60;2375;0
WireConnection;2821;62;2533;0
WireConnection;2821;66;2373;0
WireConnection;2821;69;2806;0
WireConnection;2449;0;2447;0
WireConnection;2311;0;2314;0
WireConnection;2312;0;2313;0
WireConnection;2316;0;2309;0
WireConnection;2822;59;2821;0
WireConnection;2822;63;2821;92
WireConnection;2822;67;2821;93
WireConnection;2822;75;2821;94
WireConnection;2822;64;2821;95
WireConnection;2822;60;2428;0
WireConnection;2822;62;2430;0
WireConnection;2822;66;2429;0
WireConnection;2822;69;2437;0
WireConnection;2770;0;2829;0
WireConnection;2823;59;2822;0
WireConnection;2823;63;2822;92
WireConnection;2823;67;2822;93
WireConnection;2823;75;2822;94
WireConnection;2823;64;2822;95
WireConnection;2823;60;2431;0
WireConnection;2823;62;2433;0
WireConnection;2823;66;2432;0
WireConnection;2823;69;2439;0
WireConnection;2833;138;2823;0
WireConnection;2833;131;2823;92
WireConnection;2833;132;2823;93
WireConnection;2833;145;2823;94
WireConnection;2833;134;2823;95
WireConnection;2833;118;2776;0
WireConnection;646;0;645;1
WireConnection;2832;14;2829;0
WireConnection;2832;11;2833;151
WireConnection;2832;12;2833;147
WireConnection;616;0;18;4
WireConnection;0;0;2832;9
WireConnection;0;1;2833;150
WireConnection;0;2;2833;0
WireConnection;0;4;2832;10
WireConnection;0;5;2833;149
ASEEND*/
//CHKSM=3BA7FA2AA2F7C0137D80B9013BA25202D392025B