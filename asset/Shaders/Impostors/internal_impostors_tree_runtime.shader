// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "internal/impostors/tree-runtime"
{
	Properties
	{
		[HideInInspector]_AI_Offset("Impostor Offset", Vector) = (0,0,0,0)
		[NoScaleOffset]_Albedo("Impostor Albedo & Alpha", 2D) = "white" {}
		[NoScaleOffset]_Normals("Impostor Normal & Depth", 2D) = "white" {}
		_WAOTS("WAOTS", 2D) = "white" {}
		_AI_TextureBias("Impostor Texture Bias", Float) = -1
		[HideInInspector]_AI_SizeOffset("Impostor Size Offset", Vector) = (0,0,0,0)
		_AI_Parallax("Impostor Parallax", Range( 0 , 1)) = 1
		[HideInInspector]_AI_ImpostorSize("Impostor Size", Float) = 0
		[HideInInspector]_AI_Frames("Impostor Frames", Float) = 0
		[HideInInspector]_AI_FramesX("Impostor Frames X", Float) = 0
		[HideInInspector]_AI_FramesY("Impostor Frames Y", Float) = 0
		[HideInInspector]_AI_DepthSize("Impostor Depth Size", Float) = 0
		_AI_ShadowBias("Impostor Shadow Bias", Range( 0 , 2)) = 0.25
		_AI_ShadowView("Impostor Shadow View", Range( 0 , 1)) = 1
		_AI_Clip("Impostor Clip", Range( 0 , 1)) = 0.5
		[Toggle( EFFECT_HUE_VARIATION )] _Hue("Use SpeedTree Hue", Float) = 0
		_AI_HueVariation("Impostor Hue Variation", Color) = (0,0,0,0)
		_FadeVariation("Fade Variation", Color) = (1,1,1,0.2784314)
		_HueVariation("Hue Variation", Color) = (0,0,0,0)
		_HueAdjustment("Hue Adjustment", Range( -1 , 1)) = 0
		_SaturationAdjustment("Saturation Adjustment", Range( -1 , 1)) = 0
		_BrightnessAdjustment("Brightness Adjustment", Range( -1 , 1)) = 0
		_ContrastCorrection("Contrast Correction", Range( 0 , 10)) = 1
		_ContrastAdjustment("Contrast Adjustment", Range( 0 , 10)) = 1
		_PrimaryBendStrength("Primary Bend Strength", Range( 0 , 2)) = 0.125
		_PrimaryRollStrength("Primary Roll Strength", Range( 0 , 2)) = 0.1
		[Toggle]_CorrectContrast("CorrectContrast", Float) = 0

	}

	SubShader
	{
		LOD 0

		
		CGINCLUDE
		#pragma target 4.0
		#define UNITY_SAMPLE_FULL_SH_PER_PIXEL 1
		ENDCG
		Tags { "RenderType"="TransparentCutout" "Queue"="AlphaTest" "DisableBatching"="True" "ImpostorType"="HemiOctahedron" }
		Cull Back
		AlphaToMask Off

		Pass
		{
			
			ZWrite On
			Name "ForwardBase"
			Tags { "LightMode"="ForwardBase" }

			CGPROGRAM
#include "UnityCG.cginc"
#include "Assets/Resources/CGIncludes/GPUInstancerInclude.cginc"
#pragma instancing_options procedural:setupGPUI
#pragma multi_compile_instancing
#include "UnityCG.cginc"
			
			#pragma vertex vert_surf
			#pragma fragment frag_surf
			#pragma multi_compile_fog
			#pragma multi_compile_fwdbase
			#pragma multi_compile __ LOD_FADE_CROSSFADE
			#include "HLSLSupport.cginc"
			#if !defined( UNITY_INSTANCED_LOD_FADE )
				#define UNITY_INSTANCED_LOD_FADE
			#endif
			#if !defined( UNITY_INSTANCED_SH )
				#define UNITY_INSTANCED_SH
			#endif
			#if !defined( UNITY_INSTANCED_LIGHTMAPSTS )
				#define UNITY_INSTANCED_LIGHTMAPSTS
			#endif
			#include "UnityShaderVariables.cginc"
			#include "UnityShaderUtilities.cginc"
			#ifndef UNITY_PASS_FORWARDBASE
			#define UNITY_PASS_FORWARDBASE
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			#include "AutoLight.cginc"
			#include "UnityStandardUtils.cginc"
			#define ai_ObjectToWorld unity_ObjectToWorld
			#define ai_WorldToObject unity_WorldToObject
			#define AI_INV_TWO_PI  UNITY_INV_TWO_PI
			#define AI_PI          UNITY_PI
			#define AI_INV_PI      UNITY_INV_PI
			#pragma shader_feature EFFECT_HUE_VARIATION
			 





		// INTERNAL_SHADER_FEATURE_START

		// FEATURE_GPU_INSTANCER
		#include "UnityCG.cginc"


		// FEATURE_LODFADE_SCALE
		#define INTERNAL_LODFADE_SCALE
		#pragma multi_compile __ LOD_FADE_CROSSFADE

		// INTERNAL_SHADER_FEATURE_END
			  

			uniform float4 _HueVariation;
			uniform half _WIND_BASE_TRUNK_STRENGTH;
			uniform half _WIND_BASE_TRUNK_FIELD_SIZE;
			uniform half _WIND_BASE_TRUNK_CYCLE_TIME;
			uniform half _WIND_BASE_AMPLITUDE;
			uniform half _WIND_BASE_TO_GUST_RATIO;
			uniform float _PrimaryRollStrength;
			uniform half _WIND_GUST_AMPLITUDE;
			uniform half _WIND_GUST_AUDIO_STRENGTH_LOW;
			uniform half _WIND_AUDIO_INFLUENCE;
			uniform sampler2D _WIND_GUST_TEXTURE;
			uniform half _WIND_GUST_TRUNK_FIELD_SIZE;
			uniform half _WIND_GUST_TRUNK_CYCLE_TIME;
			uniform half _WIND_GUST_CONTRAST;
			uniform float _PrimaryBendStrength;
			uniform half3 _WIND_DIRECTION;
			uniform half _WIND_LEAF_STRENGTH;
			uniform float _CorrectContrast;
			uniform float _ContrastAdjustment;
			uniform float _HueAdjustment;
			uniform float _AI_Frames;
			uniform float _AI_FramesX;
			uniform float _AI_FramesY;
			uniform float _AI_ImpostorSize;
			uniform float _AI_Parallax;
			uniform float3 _AI_Offset;
			uniform float4 _AI_SizeOffset;
			uniform float _AI_TextureBias;
			uniform sampler2D _Albedo;
			uniform sampler2D _Normals;
			uniform float _AI_DepthSize;
			uniform float _AI_ShadowBias;
			uniform float _AI_ShadowView;
			uniform float _AI_Clip;
			uniform float4 _AI_HueVariation;
			uniform sampler2D _WAOTS;
			uniform float _SaturationAdjustment;
			uniform float _BrightnessAdjustment;
			uniform float _ContrastCorrection;
			uniform float4 _FadeVariation;
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
			float2 VectortoHemiOctahedron( float3 N )
			{
				N.xy /= dot( 1.0, abs( N ) );
				return float2( N.x + N.y, N.x - N.y );
			}
			
			float3 HemiOctahedronToVector( float2 Oct )
			{
				Oct = float2( Oct.x + Oct.y, Oct.x - Oct.y ) * 0.5;
				float3 N = float3( Oct, 1 - dot( 1.0, abs( Oct ) ) );
				return normalize( N );
			}
			
			inline void RayPlaneIntersectionUV( float3 normal, float3 rayPosition, float3 rayDirection, inout float2 uvs, inout float3 localNormal )
			{
				float lDotN = dot( rayDirection, normal ); 
				float p0l0DotN = dot( -rayPosition, normal );
				float t = p0l0DotN / lDotN;
				float3 p = rayDirection * t + rayPosition;
				float3 upVector = float3( 0, 1, 0 );
				float3 tangent = normalize( cross( upVector, normal ) + float3( -0.001, 0, 0 ) );
				float3 bitangent = cross( tangent, normal );
				float frameX = dot( p, tangent );
				float frameZ = dot( p, bitangent );
				uvs = -float2( frameX, frameZ );
				if( t <= 0.0 )
				uvs = 0;
				float3x3 worldToLocal = float3x3( tangent, bitangent, normal );
				localNormal = normalize( mul( worldToLocal, rayDirection ) );
			}
			
			inline void OctaImpostorVertex( inout float4 vertex, inout float3 normal, inout float4 uvsFrame1, inout float4 uvsFrame2, inout float4 uvsFrame3, inout float4 octaFrame, inout float4 viewPos )
			{
				float2 uvOffset = _AI_SizeOffset.zw;
				float parallax = -_AI_Parallax; 
				float UVscale = _AI_ImpostorSize;
				float framesXY = _AI_Frames;
				float prevFrame = framesXY - 1;
				float3 fractions = 1.0 / float3( framesXY, prevFrame, UVscale );
				float fractionsFrame = fractions.x;
				float fractionsPrevFrame = fractions.y;
				float fractionsUVscale = fractions.z;
				float3 worldOrigin = 0;
				float4 perspective = float4( 0, 0, 0, 1 );
				if( UNITY_MATRIX_P[ 3 ][ 3 ] == 1 ) 
				{
				perspective = float4( 0, 0, 5000, 0 );
				worldOrigin = ai_ObjectToWorld._m03_m13_m23;
				}
				float3 worldCameraPos = worldOrigin + mul( UNITY_MATRIX_I_V, perspective ).xyz;
				float3 objectCameraPosition = mul( ai_WorldToObject, float4( worldCameraPos, 1 ) ).xyz - _AI_Offset.xyz; 
				float3 objectCameraDirection = normalize( objectCameraPosition );
				float3 upVector = float3( 0,1,0 );
				float3 objectHorizontalVector = normalize( cross( objectCameraDirection, upVector ) );
				float3 objectVerticalVector = cross( objectHorizontalVector, objectCameraDirection );
				float2 uvExpansion = vertex.xy;
				float3 billboard = objectHorizontalVector * uvExpansion.x + objectVerticalVector * uvExpansion.y;
				float3 localDir = billboard - objectCameraPosition; 
				objectCameraDirection.y = max(0.001, objectCameraDirection.y);
				float2 frameOcta = VectortoHemiOctahedron( objectCameraDirection.xzy ) * 0.5 + 0.5;
				float2 prevOctaFrame = frameOcta * prevFrame;
				float2 baseOctaFrame = floor( prevOctaFrame );
				float2 fractionOctaFrame = ( baseOctaFrame * fractionsFrame );
				float2 octaFrame1 = ( baseOctaFrame * fractionsPrevFrame ) * 2.0 - 1.0;
				float3 octa1WorldY = HemiOctahedronToVector( octaFrame1 ).xzy;
				float3 octa1LocalY;
				float2 uvFrame1;
				RayPlaneIntersectionUV( octa1WorldY, objectCameraPosition, localDir, /*inout*/ uvFrame1, /*inout*/ octa1LocalY );
				float2 uvParallax1 = octa1LocalY.xy * fractionsFrame * parallax;
				uvFrame1 = ( uvFrame1 * fractionsUVscale + 0.5 ) * fractionsFrame + fractionOctaFrame;
				uvsFrame1 = float4( uvParallax1, uvFrame1) - float4( 0, 0, uvOffset );
				float2 fractPrevOctaFrame = frac( prevOctaFrame );
				float2 cornerDifference = lerp( float2( 0,1 ) , float2( 1,0 ) , saturate( ceil( ( fractPrevOctaFrame.x - fractPrevOctaFrame.y ) ) ));
				float2 octaFrame2 = ( ( baseOctaFrame + cornerDifference ) * fractionsPrevFrame ) * 2.0 - 1.0;
				float3 octa2WorldY = HemiOctahedronToVector( octaFrame2 ).xzy;
				float3 octa2LocalY;
				float2 uvFrame2;
				RayPlaneIntersectionUV( octa2WorldY, objectCameraPosition, localDir, /*inout*/ uvFrame2, /*inout*/ octa2LocalY );
				float2 uvParallax2 = octa2LocalY.xy * fractionsFrame * parallax;
				uvFrame2 = ( uvFrame2 * fractionsUVscale + 0.5 ) * fractionsFrame + ( ( cornerDifference * fractionsFrame ) + fractionOctaFrame );
				uvsFrame2 = float4( uvParallax2, uvFrame2) - float4( 0, 0, uvOffset );
				float2 octaFrame3 = ( ( baseOctaFrame + 1 ) * fractionsPrevFrame  ) * 2.0 - 1.0;
				float3 octa3WorldY = HemiOctahedronToVector( octaFrame3 ).xzy;
				float3 octa3LocalY;
				float2 uvFrame3;
				RayPlaneIntersectionUV( octa3WorldY, objectCameraPosition, localDir, /*inout*/ uvFrame3, /*inout*/ octa3LocalY );
				float2 uvParallax3 = octa3LocalY.xy * fractionsFrame * parallax;
				uvFrame3 = ( uvFrame3 * fractionsUVscale + 0.5 ) * fractionsFrame + ( fractionOctaFrame + fractionsFrame );
				uvsFrame3 = float4( uvParallax3, uvFrame3) - float4( 0, 0, uvOffset );
				octaFrame = 0;
				octaFrame.xy = prevOctaFrame;
				octaFrame.zw = fractionOctaFrame;
				vertex.xyz = billboard + _AI_Offset.xyz;
				normal.xyz = objectCameraDirection;
				viewPos = 0;
				viewPos.xyz = UnityObjectToViewPos( vertex.xyz );
				#ifdef EFFECT_HUE_VARIATION
				float hueVariationAmount = frac( ai_ObjectToWorld[0].w + ai_ObjectToWorld[1].w + ai_ObjectToWorld[2].w);
				viewPos.w = saturate(hueVariationAmount * _AI_HueVariation.a);
				#endif
			}
			
			inline void OctaImpostorFragment( inout SurfaceOutputStandard o, out float4 clipPos, out float3 worldPos, float4 uvsFrame1, float4 uvsFrame2, float4 uvsFrame3, float4 octaFrame, float4 interpViewPos, out float4 output0 )
			{
				float depthBias = -1.0;
				float textureBias = _AI_TextureBias;
				float4 parallaxSample1 = tex2Dbias( _Normals, float4( uvsFrame1.zw, 0, depthBias) );
				float2 parallax1 = ( ( 0.5 - parallaxSample1.a ) * uvsFrame1.xy ) + uvsFrame1.zw;
				float4 albedo1 = tex2Dbias( _Albedo, float4( parallax1, 0, textureBias) );
				float4 normals1 = tex2Dbias( _Normals, float4( parallax1, 0, textureBias) );
				float4 parallaxSample2 = tex2Dbias( _Normals, float4( uvsFrame2.zw, 0, depthBias) );
				float2 parallax2 = ( ( 0.5 - parallaxSample2.a ) * uvsFrame2.xy ) + uvsFrame2.zw;
				float4 albedo2 = tex2Dbias( _Albedo, float4( parallax2, 0, textureBias) );
				float4 normals2 = tex2Dbias( _Normals, float4( parallax2, 0, textureBias) );
				float4 parallaxSample3 = tex2Dbias( _Normals, float4( uvsFrame3.zw, 0, depthBias) );
				float2 parallax3 = ( ( 0.5 - parallaxSample3.a ) * uvsFrame3.xy ) + uvsFrame3.zw;
				float4 albedo3 = tex2Dbias( _Albedo, float4( parallax3, 0, textureBias) );
				float4 normals3 = tex2Dbias( _Normals, float4( parallax3, 0, textureBias) );
				float2 fraction = frac( octaFrame.xy );
				float2 invFraction = 1 - fraction;
				float3 weights;
				weights.x = min( invFraction.x, invFraction.y );
				weights.y = abs( fraction.x - fraction.y );
				weights.z = min( fraction.x, fraction.y );
				float4 blendedAlbedo = albedo1 * weights.x + albedo2 * weights.y + albedo3 * weights.z;
				float4 blendedNormal = normals1 * weights.x  + normals2 * weights.y + normals3 * weights.z;
				float4 output0a = tex2Dbias( _WAOTS, float4( parallax1, 0, textureBias) ); 
				float4 output0b = tex2Dbias( _WAOTS, float4( parallax2, 0, textureBias) ); 
				float4 output0c = tex2Dbias( _WAOTS, float4( parallax3, 0, textureBias) ); 
				output0 = output0a * weights.x  + output0b * weights.y + output0c * weights.z; 
				float3 localNormal = blendedNormal.rgb * 2.0 - 1.0;
				float3 worldNormal = normalize( mul( (float3x3)ai_ObjectToWorld, localNormal ) );
				float3 viewPos = interpViewPos.xyz;
				float depthOffset = ( ( parallaxSample1.a * weights.x + parallaxSample2.a * weights.y + parallaxSample3.a * weights.z ) - 0.5 /** 2.0 - 1.0*/ ) /** 0.5*/ * _AI_DepthSize * length( ai_ObjectToWorld[ 2 ].xyz );
				#if defined(SHADOWS_DEPTH)
				if( unity_LightShadowBias.y == 1.0 ) 
				{
				viewPos.z += depthOffset * _AI_ShadowView;
				viewPos.z += -_AI_ShadowBias;
				}
				else 
				{
				viewPos.z += depthOffset;
				}
				#else 
				viewPos.z += depthOffset;
				#endif
				worldPos = mul( UNITY_MATRIX_I_V, float4( viewPos.xyz, 1 ) ).xyz;
				clipPos = mul( UNITY_MATRIX_P, float4( viewPos, 1 ) );
				#if defined(SHADOWS_DEPTH)
				clipPos = UnityApplyLinearShadowBias( clipPos );
				#endif
				clipPos.xyz /= clipPos.w;
				if( UNITY_NEAR_CLIP_VALUE < 0 )
				clipPos = clipPos * 0.5 + 0.5;
				#ifdef EFFECT_HUE_VARIATION
				half3 shiftedColor = lerp(blendedAlbedo.rgb, _HueVariation.rgb, interpViewPos.w);
				half maxBase = max(blendedAlbedo.r, max(blendedAlbedo.g, blendedAlbedo.b));
				half newMaxBase = max(shiftedColor.r, max(shiftedColor.g, shiftedColor.b));
				maxBase /= newMaxBase;
				maxBase = maxBase * 0.5f + 0.5f;
				shiftedColor.rgb *= maxBase;
				blendedAlbedo.rgb = saturate(shiftedColor);
				#endif
				float t = ceil( fraction.x - fraction.y );
				float4 cornerDifference = float4( t, 1 - t, 1, 1 );
				float2 step_1 = ( parallax1 - octaFrame.zw ) * _AI_Frames;
				float4 step23 = ( float4( parallax2, parallax3 ) -  octaFrame.zwzw ) * _AI_Frames - cornerDifference;
				step_1 = step_1 * (1-step_1);
				step23 = step23 * (1-step23);
				float3 steps;
				steps.x = step_1.x * step_1.y;
				steps.y = step23.x * step23.y;
				steps.z = step23.z * step23.w;
				steps = step(-steps, 0);
				float final = dot( steps, weights );
				clip( final - 0.5 );
				o.Albedo = blendedAlbedo.rgb;
				o.Normal = worldNormal;
				o.Alpha = ( blendedAlbedo.a - _AI_Clip );
				clip( o.Alpha );
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
			

			/*struct appdata_full {
				float4 vertex : POSITION;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				fixed4 color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID*/
			
			/*};*/

			struct v2f_surf {
				UNITY_POSITION(pos);
				#if defined(LIGHTMAP_ON) || (!defined(LIGHTMAP_ON) && SHADER_TARGET >= 30)
					float4 lmap : TEXCOORD0;
				#endif
				#if !defined(LIGHTMAP_ON) && UNITY_SHOULD_SAMPLE_SH
					half3 sh : TEXCOORD1;
				#endif
				#if UNITY_VERSION >= 201810
					UNITY_LIGHTING_COORDS(2,3)
				#else
					UNITY_SHADOW_COORDS(2)
				#endif
				UNITY_FOG_COORDS(4)
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 UVsFrame12401 : TEXCOORD5;
				float4 UVsFrame22401 : TEXCOORD6;
				float4 UVsFrame32401 : TEXCOORD7;
				float4 octaframe2401 : TEXCOORD8;
				float4 viewPos2401 : TEXCOORD9;
				float4 ase_color : COLOR;
				float4 ase_texcoord10 : TEXCOORD10;
			};

			v2f_surf vert_surf (appdata_full v ) {
				UNITY_SETUP_INSTANCE_ID(v);
				v2f_surf o;
				UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
				UNITY_TRANSFER_INSTANCE_ID(v,o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				half localunity_ObjectToWorld0w1_g8346 = ( unity_ObjectToWorld[0].w );
				half localunity_ObjectToWorld1w2_g8346 = ( unity_ObjectToWorld[1].w );
				half localunity_ObjectToWorld2w3_g8346 = ( unity_ObjectToWorld[2].w );
				float3 appendResult6_g8346 = (float3(localunity_ObjectToWorld0w1_g8346 , localunity_ObjectToWorld1w2_g8346 , localunity_ObjectToWorld2w3_g8346));
				float3 temp_output_1062_510_g8253 = appendResult6_g8346;
				float2 temp_output_1_0_g8295 = (temp_output_1062_510_g8253).xz;
				float temp_output_2_0_g8300 = _WIND_BASE_TRUNK_FIELD_SIZE;
				float2 temp_cast_0 = (( 1.0 / (( temp_output_2_0_g8300 == 0.0 ) ? 1.0 :  temp_output_2_0_g8300 ) )).xx;
				float2 temp_output_2_0_g8295 = temp_cast_0;
				float2 temp_output_704_0_g8289 = ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g8295 / temp_output_2_0_g8295 ) :  ( temp_output_1_0_g8295 * temp_output_2_0_g8295 ) ) + float2( 0,0 ) );
				float temp_output_2_0_g8259 = _WIND_BASE_TRUNK_CYCLE_TIME;
				float temp_output_618_0_g8289 = ( 1.0 / (( temp_output_2_0_g8259 == 0.0 ) ? 1.0 :  temp_output_2_0_g8259 ) );
				float2 break298_g8296 = ( temp_output_704_0_g8289 + ( temp_output_618_0_g8289 * ( _Time.y + 0.0 ) ) );
				float2 appendResult299_g8296 = (float2(sin( break298_g8296.x ) , cos( break298_g8296.y )));
				float4 temp_output_273_0_g8296 = (-1.0).xxxx;
				float4 temp_output_271_0_g8296 = (1.0).xxxx;
				float2 clampResult26_g8296 = clamp( appendResult299_g8296 , temp_output_273_0_g8296.xy , temp_output_271_0_g8296.xy );
				float temp_output_1062_495_g8253 = _WIND_BASE_AMPLITUDE;
				float temp_output_1062_501_g8253 = _WIND_BASE_TO_GUST_RATIO;
				float temp_output_524_0_g8289 = ( temp_output_1062_495_g8253 * temp_output_1062_501_g8253 );
				float2 TRUNK_PIVOT_ROCKING701_g8289 = ( clampResult26_g8296 * temp_output_524_0_g8289 );
				float temp_output_2424_495 = v.color.r;
				float temp_output_2431_0 = ( temp_output_2424_495 * _PrimaryRollStrength );
				float _WIND_PRIMARY_ROLL669_g8289 = temp_output_2431_0;
				float temp_output_54_0_g8304 = ( TRUNK_PIVOT_ROCKING701_g8289 * 0.05 * _WIND_PRIMARY_ROLL669_g8289 ).x;
				float temp_output_72_0_g8304 = cos( temp_output_54_0_g8304 );
				float one_minus_c52_g8304 = ( 1.0 - temp_output_72_0_g8304 );
				float3 break70_g8304 = float3(0,1,0);
				float axis_x25_g8304 = break70_g8304.x;
				float c66_g8304 = temp_output_72_0_g8304;
				float axis_y37_g8304 = break70_g8304.y;
				float axis_z29_g8304 = break70_g8304.z;
				float s67_g8304 = sin( temp_output_54_0_g8304 );
				float3 appendResult83_g8304 = (float3(( ( one_minus_c52_g8304 * axis_x25_g8304 * axis_x25_g8304 ) + c66_g8304 ) , ( ( one_minus_c52_g8304 * axis_x25_g8304 * axis_y37_g8304 ) - ( axis_z29_g8304 * s67_g8304 ) ) , ( ( one_minus_c52_g8304 * axis_z29_g8304 * axis_x25_g8304 ) + ( axis_y37_g8304 * s67_g8304 ) )));
				float3 appendResult81_g8304 = (float3(( ( one_minus_c52_g8304 * axis_x25_g8304 * axis_y37_g8304 ) + ( axis_z29_g8304 * s67_g8304 ) ) , ( ( one_minus_c52_g8304 * axis_y37_g8304 * axis_y37_g8304 ) + c66_g8304 ) , ( ( one_minus_c52_g8304 * axis_y37_g8304 * axis_z29_g8304 ) - ( axis_x25_g8304 * s67_g8304 ) )));
				float3 appendResult82_g8304 = (float3(( ( one_minus_c52_g8304 * axis_z29_g8304 * axis_x25_g8304 ) - ( axis_y37_g8304 * s67_g8304 ) ) , ( ( one_minus_c52_g8304 * axis_y37_g8304 * axis_z29_g8304 ) + ( axis_x25_g8304 * s67_g8304 ) ) , ( ( one_minus_c52_g8304 * axis_z29_g8304 * axis_z29_g8304 ) + c66_g8304 )));
				float3 _WIND_PRIMARY_PIVOT655_g8289 = float3(0,1,0);
				float3 temp_output_38_0_g8304 = ( v.vertex.xyz - (_WIND_PRIMARY_PIVOT655_g8289).xyz );
				float2 break298_g8290 = ( temp_output_704_0_g8289 + ( temp_output_618_0_g8289 * ( _Time.y + 0.0 ) ) );
				float2 appendResult299_g8290 = (float2(sin( break298_g8290.x ) , cos( break298_g8290.y )));
				float4 temp_output_273_0_g8290 = (-1.0).xxxx;
				float4 temp_output_271_0_g8290 = (1.0).xxxx;
				float2 clampResult26_g8290 = clamp( appendResult299_g8290 , temp_output_273_0_g8290.xy , temp_output_271_0_g8290.xy );
				float2 TRUNK_SWIRL700_g8289 = ( clampResult26_g8290 * temp_output_524_0_g8289 );
				float2 break699_g8289 = TRUNK_SWIRL700_g8289;
				float3 appendResult698_g8289 = (float3(break699_g8289.x , 0.0 , break699_g8289.y));
				float3 temp_output_694_0_g8289 = ( ( mul( float3x3(appendResult83_g8304, appendResult81_g8304, appendResult82_g8304), temp_output_38_0_g8304 ) - temp_output_38_0_g8304 ) + ( _WIND_PRIMARY_ROLL669_g8289 * appendResult698_g8289 * 0.5 ) );
				float lerpResult635_g8347 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_LOW , _WIND_AUDIO_INFLUENCE);
				float4 color658_g8306 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
				float2 temp_output_61_0_g8311 = float2( 0,0 );
				half localunity_ObjectToWorld0w1_g8324 = ( unity_ObjectToWorld[0].w );
				half localunity_ObjectToWorld1w2_g8324 = ( unity_ObjectToWorld[1].w );
				half localunity_ObjectToWorld2w3_g8324 = ( unity_ObjectToWorld[2].w );
				float3 appendResult6_g8324 = (float3(localunity_ObjectToWorld0w1_g8324 , localunity_ObjectToWorld1w2_g8324 , localunity_ObjectToWorld2w3_g8324));
				float2 temp_output_1_0_g8312 = (appendResult6_g8324).xz;
				float temp_output_2_0_g8318 = _WIND_GUST_TRUNK_FIELD_SIZE;
				float temp_output_40_0_g8311 = ( 1.0 / (( temp_output_2_0_g8318 == 0.0 ) ? 1.0 :  temp_output_2_0_g8318 ) );
				float2 temp_cast_6 = (temp_output_40_0_g8311).xx;
				float2 temp_output_2_0_g8312 = temp_cast_6;
				float temp_output_2_0_g8307 = _WIND_GUST_TRUNK_CYCLE_TIME;
				float mulTime37_g8311 = _Time.y * ( 1.0 / (( temp_output_2_0_g8307 == 0.0 ) ? 1.0 :  temp_output_2_0_g8307 ) );
				float temp_output_220_0_g8314 = -1.0;
				float4 temp_cast_7 = (temp_output_220_0_g8314).xxxx;
				float temp_output_219_0_g8314 = 1.0;
				float4 temp_cast_8 = (temp_output_219_0_g8314).xxxx;
				float4 clampResult26_g8314 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g8311 > float2( 0,0 ) ) ? ( temp_output_1_0_g8312 / temp_output_2_0_g8312 ) :  ( temp_output_1_0_g8312 * temp_output_2_0_g8312 ) ) + temp_output_61_0_g8311 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g8311 ) ) , temp_cast_7 , temp_cast_8 );
				float4 temp_cast_9 = (temp_output_220_0_g8314).xxxx;
				float4 temp_cast_10 = (temp_output_219_0_g8314).xxxx;
				float4 temp_cast_11 = (0.0).xxxx;
				float4 temp_cast_12 = (temp_output_219_0_g8314).xxxx;
				float temp_output_1072_526_g8253 = _WIND_GUST_CONTRAST;
				float4 temp_cast_13 = (temp_output_1072_526_g8253).xxxx;
				float4 temp_output_52_0_g8311 = saturate( pow( abs( (temp_cast_11 + (clampResult26_g8314 - temp_cast_9) * (temp_cast_12 - temp_cast_11) / (temp_cast_10 - temp_cast_9)) ) , temp_cast_13 ) );
				float temp_output_679_0_g8306 = 1.0;
				float4 lerpResult656_g8306 = lerp( color658_g8306 , temp_output_52_0_g8311 , temp_output_679_0_g8306);
				float _WIND_GUST_STRENGTH703_g8289 = ( (lerpResult635_g8347).xxxx * lerpResult656_g8306 ).x;
				float _WIND_PRIMARY_BEND662_g8289 = ( temp_output_2424_495 * _PrimaryBendStrength );
				float temp_output_54_0_g8294 = ( ( _WIND_GUST_STRENGTH703_g8289 * -1.0 ) * _WIND_PRIMARY_BEND662_g8289 );
				float temp_output_72_0_g8294 = cos( temp_output_54_0_g8294 );
				float one_minus_c52_g8294 = ( 1.0 - temp_output_72_0_g8294 );
				float3 temp_output_1062_494_g8253 = _WIND_DIRECTION;
				float3 _WIND_DIRECTION671_g8289 = temp_output_1062_494_g8253;
				float3 worldToObjDir719_g8289 = mul( unity_WorldToObject, float4( cross( _WIND_DIRECTION671_g8289 , float3(0,1,0) ), 0 ) ).xyz;
				float3 break70_g8294 = worldToObjDir719_g8289;
				float axis_x25_g8294 = break70_g8294.x;
				float c66_g8294 = temp_output_72_0_g8294;
				float axis_y37_g8294 = break70_g8294.y;
				float axis_z29_g8294 = break70_g8294.z;
				float s67_g8294 = sin( temp_output_54_0_g8294 );
				float3 appendResult83_g8294 = (float3(( ( one_minus_c52_g8294 * axis_x25_g8294 * axis_x25_g8294 ) + c66_g8294 ) , ( ( one_minus_c52_g8294 * axis_x25_g8294 * axis_y37_g8294 ) - ( axis_z29_g8294 * s67_g8294 ) ) , ( ( one_minus_c52_g8294 * axis_z29_g8294 * axis_x25_g8294 ) + ( axis_y37_g8294 * s67_g8294 ) )));
				float3 appendResult81_g8294 = (float3(( ( one_minus_c52_g8294 * axis_x25_g8294 * axis_y37_g8294 ) + ( axis_z29_g8294 * s67_g8294 ) ) , ( ( one_minus_c52_g8294 * axis_y37_g8294 * axis_y37_g8294 ) + c66_g8294 ) , ( ( one_minus_c52_g8294 * axis_y37_g8294 * axis_z29_g8294 ) - ( axis_x25_g8294 * s67_g8294 ) )));
				float3 appendResult82_g8294 = (float3(( ( one_minus_c52_g8294 * axis_z29_g8294 * axis_x25_g8294 ) - ( axis_y37_g8294 * s67_g8294 ) ) , ( ( one_minus_c52_g8294 * axis_y37_g8294 * axis_z29_g8294 ) + ( axis_x25_g8294 * s67_g8294 ) ) , ( ( one_minus_c52_g8294 * axis_z29_g8294 * axis_z29_g8294 ) + c66_g8294 )));
				float3 temp_output_38_0_g8294 = ( v.vertex.xyz - (_WIND_PRIMARY_PIVOT655_g8289).xyz );
				float temp_output_1062_498_g8253 = _WIND_GUST_AMPLITUDE;
				float3 lerpResult538_g8289 = lerp( temp_output_694_0_g8289 , ( temp_output_694_0_g8289 + ( mul( float3x3(appendResult83_g8294, appendResult81_g8294, appendResult82_g8294), temp_output_38_0_g8294 ) - temp_output_38_0_g8294 ) ) , temp_output_1062_498_g8253);
				float3 temp_output_41_0_g8355 = ( ( _WIND_BASE_TRUNK_STRENGTH * lerpResult538_g8289 ) + ( _WIND_LEAF_STRENGTH * float3(0,0,0) ) );
				float temp_output_63_0_g8356 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
				float3 lerpResult57_g8356 = lerp( temp_output_41_0_g8355 , -v.vertex.xyz , ( 1.0 - temp_output_63_0_g8356 ));
				#ifdef INTERNAL_LODFADE_SCALE
				float3 staticSwitch58_g8355 = lerpResult57_g8356;
				#else
				float3 staticSwitch58_g8355 = temp_output_41_0_g8355;
				#endif
				#ifdef LOD_FADE_CROSSFADE
				float3 staticSwitch62_g8355 = staticSwitch58_g8355;
				#else
				float3 staticSwitch62_g8355 = temp_output_41_0_g8355;
				#endif
				
				OctaImpostorVertex( v.vertex, v.normal, o.UVsFrame12401, o.UVsFrame22401, o.UVsFrame32401, o.octaframe2401, o.viewPos2401 );
				
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord10 = screenPos;
				
				o.ase_color = v.color;

				v.vertex.xyz += staticSwitch62_g8355;
				o.pos = UnityObjectToClipPos(v.vertex);

				float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
				#ifdef DYNAMICLIGHTMAP_ON
				o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif
				#ifdef LIGHTMAP_ON
				o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif

				#ifndef LIGHTMAP_ON
					#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
						o.sh = 0;
						#ifdef VERTEXLIGHT_ON
						o.sh += Shade4PointLights (
							unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
							unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
							unity_4LightAtten0, worldPos, worldNormal);
						#endif
						o.sh = ShadeSHPerVertex (worldNormal, o.sh);
					#endif
				#endif

				#if UNITY_VERSION >= 201810
					UNITY_TRANSFER_LIGHTING(o, v.texcoord1.xy);
				#else
					UNITY_TRANSFER_SHADOW(o, v.texcoord1.xy);
				#endif
				UNITY_TRANSFER_FOG(o,o.pos);
				return o;
			}

			fixed4 frag_surf (v2f_surf IN, out float outDepth : SV_Depth ) : SV_Target {
				UNITY_SETUP_INSTANCE_ID(IN);
				#if defined(_SPECULAR_SETUP)
					SurfaceOutputStandardSpecular o = (SurfaceOutputStandardSpecular)0;
				#else
					SurfaceOutputStandard o = (SurfaceOutputStandard)0;
				#endif

				float4 clipPos = 0;
				float3 worldPos = 0;
				float temp_output_88_0_g1926 = _ContrastAdjustment;
				float4 output0 = 0;
				OctaImpostorFragment( o, clipPos, worldPos, IN.UVsFrame12401, IN.UVsFrame22401, IN.UVsFrame32401, IN.octaframe2401, IN.viewPos2401, output0 );
				float4 temp_output_89_0_g1926 = float4( o.Albedo , 0.0 );
				float3 hsvTorgb92_g1926 = RGBToHSV( temp_output_89_0_g1926.rgb );
				float3 hsvTorgb83_g1926 = HSVToRGB( float3(( _HueAdjustment + hsvTorgb92_g1926.x ),( hsvTorgb92_g1926.y + _SaturationAdjustment ),( hsvTorgb92_g1926.z + _BrightnessAdjustment )) );
				float4 appendResult104_g1926 = (float4(CalculateContrast(temp_output_88_0_g1926,float4( hsvTorgb83_g1926 , 0.0 )).rgb , (temp_output_89_0_g1926).a));
				float temp_output_88_0_g1932 = _ContrastAdjustment;
				float4 temp_output_89_0_g1932 = float4( o.Albedo , 0.0 );
				float3 hsvTorgb92_g1932 = RGBToHSV( temp_output_89_0_g1932.rgb );
				float3 hsvTorgb83_g1932 = HSVToRGB( float3(( _HueAdjustment + hsvTorgb92_g1932.x ),( hsvTorgb92_g1932.y + _SaturationAdjustment ),( hsvTorgb92_g1932.z + _BrightnessAdjustment )) );
				float temp_output_2_0_g1934 = _ContrastCorrection;
				float4 appendResult104_g1932 = (float4(CalculateContrast(temp_output_88_0_g1932,( float4( hsvTorgb83_g1932 , 0.0 ) * ( 1.0 / (( temp_output_2_0_g1934 == 0.0 ) ? 1.0 :  temp_output_2_0_g1934 ) ) )).rgb , (temp_output_89_0_g1932).a));
				float temp_output_2424_495 = IN.ase_color.r;
				float temp_output_2431_0 = ( temp_output_2424_495 * _PrimaryRollStrength );
				float4 lerpResult2444 = lerp( saturate( (( _CorrectContrast )?( appendResult104_g1932 ):( appendResult104_g1926 )) ) , saturate( _FadeVariation ) , saturate( ( temp_output_2431_0 * _FadeVariation.a ) ));
				
				float4 break2402 = output0;
				
				float temp_output_41_0_g8349 = o.Alpha;
				float4 screenPos = IN.ase_texcoord10;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float2 clipScreen45_g8350 = ase_screenPosNorm.xy * _ScreenParams.xy;
				float dither45_g8350 = Dither8x8Bayer( fmod(clipScreen45_g8350.x, 8), fmod(clipScreen45_g8350.y, 8) );
				float temp_output_56_0_g8350 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
				dither45_g8350 = step( dither45_g8350, temp_output_56_0_g8350 );
				#ifdef INTERNAL_LODFADE_DITHER
				float staticSwitch50_g8349 = ( temp_output_41_0_g8349 * dither45_g8350 );
				#else
				float staticSwitch50_g8349 = temp_output_41_0_g8349;
				#endif
				#ifdef LOD_FADE_CROSSFADE
				float staticSwitch56_g8349 = staticSwitch50_g8349;
				#else
				float staticSwitch56_g8349 = temp_output_41_0_g8349;
				#endif
				
				fixed3 albedo = saturate( lerpResult2444 ).rgb;
				fixed3 normal = o.Normal;
				half3 emission = half3( 0, 0, 0 );
				fixed3 specular = fixed3( 0, 0, 0 );
				fixed metallic = 0;
				half smoothness = break2402.w;
				half occlusion = break2402.y;
				fixed alpha = staticSwitch56_g8349;
				float4 bakedGI = float4( 0, 0, 0, 0 );
				
				o.Albedo = albedo;
				o.Normal = normal;
				o.Emission = emission;
				#if defined(_SPECULAR_SETUP)
					o.Specular = specular;
				#else
					o.Metallic = metallic;
				#endif
				o.Smoothness = smoothness;
				o.Occlusion = occlusion;
				o.Alpha = alpha;
				clip(o.Alpha);

				IN.pos.zw = clipPos.zw;
				outDepth = IN.pos.z;

				#ifndef USING_DIRECTIONAL_LIGHT
					fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
				#else
					fixed3 lightDir = _WorldSpaceLightPos0.xyz;
				#endif

				fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));

				UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
				UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
				fixed4 c = 0;

				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
				gi.indirect.diffuse = 0;
				gi.indirect.specular = 0;
				gi.light.color = _LightColor0.rgb;
				gi.light.dir = lightDir;

				UnityGIInput giInput;
				UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
				giInput.light = gi.light;
				giInput.worldPos = worldPos;
				giInput.worldViewDir = worldViewDir;
				giInput.atten = atten;
				#if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
					giInput.lightmapUV = IN.lmap;
				#else
					giInput.lightmapUV = 0.0;
				#endif
				#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
					giInput.ambient = IN.sh;
				#else
					giInput.ambient.rgb = 0.0;
				#endif
				giInput.probeHDR[0] = unity_SpecCube0_HDR;
				giInput.probeHDR[1] = unity_SpecCube1_HDR;
				#if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
					giInput.boxMin[0] = unity_SpecCube0_BoxMin;
				#endif
				#if UNITY_SPECCUBE_BOX_PROJECTION
					giInput.boxMax[0] = unity_SpecCube0_BoxMax;
					giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
					giInput.boxMax[1] = unity_SpecCube1_BoxMax;
					giInput.boxMin[1] = unity_SpecCube1_BoxMin;
					giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
				#endif

				#if defined(_SPECULAR_SETUP)
					LightingStandardSpecular_GI(o, giInput, gi);
					#if defined(CUSTOM_BAKED_GI)
						gi.indirect.diffuse = DecodeLightmapRGBM( bakedGI, 1 ) * EMISSIVE_RGBM_SCALE;
					#endif
					c += LightingStandardSpecular (o, worldViewDir, gi);
				#else
					LightingStandard_GI( o, giInput, gi );
					#if defined(CUSTOM_BAKED_GI)
						gi.indirect.diffuse = DecodeLightmapRGBM( bakedGI, 1) * EMISSIVE_RGBM_SCALE;
					#endif
					c += LightingStandard( o, worldViewDir, gi );
				#endif
				c.rgb += o.Emission;
				UNITY_APPLY_FOG(IN.fogCoord, c);
				return c;
			}

			ENDCG
		}

		Pass
		{
			Name "ForwardAdd"
			Tags { "LightMode"="ForwardAdd" }
			ZWrite Off
			Blend One One

			CGPROGRAM
#include "UnityCG.cginc"
#include "Assets/Resources/CGIncludes/GPUInstancerInclude.cginc"
#pragma instancing_options procedural:setupGPUI
#pragma multi_compile_instancing
#include "UnityCG.cginc"
			
			#pragma vertex vert_surf
			#pragma fragment frag_surf
			#pragma multi_compile_fog
			#pragma multi_compile_fwdadd_fullshadows
			#pragma multi_compile __ LOD_FADE_CROSSFADE
			#pragma skip_variants INSTANCING_ON
			#include "HLSLSupport.cginc"
			#if !defined( UNITY_INSTANCED_LOD_FADE )
				#define UNITY_INSTANCED_LOD_FADE
			#endif
			#if !defined( UNITY_INSTANCED_SH )
				#define UNITY_INSTANCED_SH
			#endif
			#if !defined( UNITY_INSTANCED_LIGHTMAPSTS )
				#define UNITY_INSTANCED_LIGHTMAPSTS
			#endif
			#include "UnityShaderVariables.cginc"
			#include "UnityShaderUtilities.cginc"
			#ifndef UNITY_PASS_FORWARDADD
			#define UNITY_PASS_FORWARDADD
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			#include "AutoLight.cginc"
			#include "UnityStandardUtils.cginc"
			#define ai_ObjectToWorld unity_ObjectToWorld
			#define ai_WorldToObject unity_WorldToObject
			#define AI_INV_TWO_PI  UNITY_INV_TWO_PI
			#define AI_PI          UNITY_PI
			#define AI_INV_PI      UNITY_INV_PI
			#pragma shader_feature EFFECT_HUE_VARIATION
			 





		// INTERNAL_SHADER_FEATURE_START

		// FEATURE_GPU_INSTANCER
		#include "UnityCG.cginc"


		// FEATURE_LODFADE_SCALE
		#define INTERNAL_LODFADE_SCALE
		#pragma multi_compile __ LOD_FADE_CROSSFADE

		// INTERNAL_SHADER_FEATURE_END
			  

			uniform float4 _HueVariation;
			uniform half _WIND_BASE_TRUNK_STRENGTH;
			uniform half _WIND_BASE_TRUNK_FIELD_SIZE;
			uniform half _WIND_BASE_TRUNK_CYCLE_TIME;
			uniform half _WIND_BASE_AMPLITUDE;
			uniform half _WIND_BASE_TO_GUST_RATIO;
			uniform float _PrimaryRollStrength;
			uniform half _WIND_GUST_AMPLITUDE;
			uniform half _WIND_GUST_AUDIO_STRENGTH_LOW;
			uniform half _WIND_AUDIO_INFLUENCE;
			uniform sampler2D _WIND_GUST_TEXTURE;
			uniform half _WIND_GUST_TRUNK_FIELD_SIZE;
			uniform half _WIND_GUST_TRUNK_CYCLE_TIME;
			uniform half _WIND_GUST_CONTRAST;
			uniform float _PrimaryBendStrength;
			uniform half3 _WIND_DIRECTION;
			uniform half _WIND_LEAF_STRENGTH;
			uniform float _CorrectContrast;
			uniform float _ContrastAdjustment;
			uniform float _HueAdjustment;
			uniform float _AI_Frames;
			uniform float _AI_FramesX;
			uniform float _AI_FramesY;
			uniform float _AI_ImpostorSize;
			uniform float _AI_Parallax;
			uniform float3 _AI_Offset;
			uniform float4 _AI_SizeOffset;
			uniform float _AI_TextureBias;
			uniform sampler2D _Albedo;
			uniform sampler2D _Normals;
			uniform float _AI_DepthSize;
			uniform float _AI_ShadowBias;
			uniform float _AI_ShadowView;
			uniform float _AI_Clip;
			uniform float4 _AI_HueVariation;
			uniform sampler2D _WAOTS;
			uniform float _SaturationAdjustment;
			uniform float _BrightnessAdjustment;
			uniform float _ContrastCorrection;
			uniform float4 _FadeVariation;
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
			float2 VectortoHemiOctahedron( float3 N )
			{
				N.xy /= dot( 1.0, abs( N ) );
				return float2( N.x + N.y, N.x - N.y );
			}
			
			float3 HemiOctahedronToVector( float2 Oct )
			{
				Oct = float2( Oct.x + Oct.y, Oct.x - Oct.y ) * 0.5;
				float3 N = float3( Oct, 1 - dot( 1.0, abs( Oct ) ) );
				return normalize( N );
			}
			
			inline void RayPlaneIntersectionUV( float3 normal, float3 rayPosition, float3 rayDirection, inout float2 uvs, inout float3 localNormal )
			{
				float lDotN = dot( rayDirection, normal ); 
				float p0l0DotN = dot( -rayPosition, normal );
				float t = p0l0DotN / lDotN;
				float3 p = rayDirection * t + rayPosition;
				float3 upVector = float3( 0, 1, 0 );
				float3 tangent = normalize( cross( upVector, normal ) + float3( -0.001, 0, 0 ) );
				float3 bitangent = cross( tangent, normal );
				float frameX = dot( p, tangent );
				float frameZ = dot( p, bitangent );
				uvs = -float2( frameX, frameZ );
				if( t <= 0.0 )
				uvs = 0;
				float3x3 worldToLocal = float3x3( tangent, bitangent, normal );
				localNormal = normalize( mul( worldToLocal, rayDirection ) );
			}
			
			inline void OctaImpostorVertex( inout float4 vertex, inout float3 normal, inout float4 uvsFrame1, inout float4 uvsFrame2, inout float4 uvsFrame3, inout float4 octaFrame, inout float4 viewPos )
			{
				float2 uvOffset = _AI_SizeOffset.zw;
				float parallax = -_AI_Parallax; 
				float UVscale = _AI_ImpostorSize;
				float framesXY = _AI_Frames;
				float prevFrame = framesXY - 1;
				float3 fractions = 1.0 / float3( framesXY, prevFrame, UVscale );
				float fractionsFrame = fractions.x;
				float fractionsPrevFrame = fractions.y;
				float fractionsUVscale = fractions.z;
				float3 worldOrigin = 0;
				float4 perspective = float4( 0, 0, 0, 1 );
				if( UNITY_MATRIX_P[ 3 ][ 3 ] == 1 ) 
				{
				perspective = float4( 0, 0, 5000, 0 );
				worldOrigin = ai_ObjectToWorld._m03_m13_m23;
				}
				float3 worldCameraPos = worldOrigin + mul( UNITY_MATRIX_I_V, perspective ).xyz;
				float3 objectCameraPosition = mul( ai_WorldToObject, float4( worldCameraPos, 1 ) ).xyz - _AI_Offset.xyz; 
				float3 objectCameraDirection = normalize( objectCameraPosition );
				float3 upVector = float3( 0,1,0 );
				float3 objectHorizontalVector = normalize( cross( objectCameraDirection, upVector ) );
				float3 objectVerticalVector = cross( objectHorizontalVector, objectCameraDirection );
				float2 uvExpansion = vertex.xy;
				float3 billboard = objectHorizontalVector * uvExpansion.x + objectVerticalVector * uvExpansion.y;
				float3 localDir = billboard - objectCameraPosition; 
				objectCameraDirection.y = max(0.001, objectCameraDirection.y);
				float2 frameOcta = VectortoHemiOctahedron( objectCameraDirection.xzy ) * 0.5 + 0.5;
				float2 prevOctaFrame = frameOcta * prevFrame;
				float2 baseOctaFrame = floor( prevOctaFrame );
				float2 fractionOctaFrame = ( baseOctaFrame * fractionsFrame );
				float2 octaFrame1 = ( baseOctaFrame * fractionsPrevFrame ) * 2.0 - 1.0;
				float3 octa1WorldY = HemiOctahedronToVector( octaFrame1 ).xzy;
				float3 octa1LocalY;
				float2 uvFrame1;
				RayPlaneIntersectionUV( octa1WorldY, objectCameraPosition, localDir, /*inout*/ uvFrame1, /*inout*/ octa1LocalY );
				float2 uvParallax1 = octa1LocalY.xy * fractionsFrame * parallax;
				uvFrame1 = ( uvFrame1 * fractionsUVscale + 0.5 ) * fractionsFrame + fractionOctaFrame;
				uvsFrame1 = float4( uvParallax1, uvFrame1) - float4( 0, 0, uvOffset );
				float2 fractPrevOctaFrame = frac( prevOctaFrame );
				float2 cornerDifference = lerp( float2( 0,1 ) , float2( 1,0 ) , saturate( ceil( ( fractPrevOctaFrame.x - fractPrevOctaFrame.y ) ) ));
				float2 octaFrame2 = ( ( baseOctaFrame + cornerDifference ) * fractionsPrevFrame ) * 2.0 - 1.0;
				float3 octa2WorldY = HemiOctahedronToVector( octaFrame2 ).xzy;
				float3 octa2LocalY;
				float2 uvFrame2;
				RayPlaneIntersectionUV( octa2WorldY, objectCameraPosition, localDir, /*inout*/ uvFrame2, /*inout*/ octa2LocalY );
				float2 uvParallax2 = octa2LocalY.xy * fractionsFrame * parallax;
				uvFrame2 = ( uvFrame2 * fractionsUVscale + 0.5 ) * fractionsFrame + ( ( cornerDifference * fractionsFrame ) + fractionOctaFrame );
				uvsFrame2 = float4( uvParallax2, uvFrame2) - float4( 0, 0, uvOffset );
				float2 octaFrame3 = ( ( baseOctaFrame + 1 ) * fractionsPrevFrame  ) * 2.0 - 1.0;
				float3 octa3WorldY = HemiOctahedronToVector( octaFrame3 ).xzy;
				float3 octa3LocalY;
				float2 uvFrame3;
				RayPlaneIntersectionUV( octa3WorldY, objectCameraPosition, localDir, /*inout*/ uvFrame3, /*inout*/ octa3LocalY );
				float2 uvParallax3 = octa3LocalY.xy * fractionsFrame * parallax;
				uvFrame3 = ( uvFrame3 * fractionsUVscale + 0.5 ) * fractionsFrame + ( fractionOctaFrame + fractionsFrame );
				uvsFrame3 = float4( uvParallax3, uvFrame3) - float4( 0, 0, uvOffset );
				octaFrame = 0;
				octaFrame.xy = prevOctaFrame;
				octaFrame.zw = fractionOctaFrame;
				vertex.xyz = billboard + _AI_Offset.xyz;
				normal.xyz = objectCameraDirection;
				viewPos = 0;
				viewPos.xyz = UnityObjectToViewPos( vertex.xyz );
				#ifdef EFFECT_HUE_VARIATION
				float hueVariationAmount = frac( ai_ObjectToWorld[0].w + ai_ObjectToWorld[1].w + ai_ObjectToWorld[2].w);
				viewPos.w = saturate(hueVariationAmount * _AI_HueVariation.a);
				#endif
			}
			
			inline void OctaImpostorFragment( inout SurfaceOutputStandard o, out float4 clipPos, out float3 worldPos, float4 uvsFrame1, float4 uvsFrame2, float4 uvsFrame3, float4 octaFrame, float4 interpViewPos, out float4 output0 )
			{
				float depthBias = -1.0;
				float textureBias = _AI_TextureBias;
				float4 parallaxSample1 = tex2Dbias( _Normals, float4( uvsFrame1.zw, 0, depthBias) );
				float2 parallax1 = ( ( 0.5 - parallaxSample1.a ) * uvsFrame1.xy ) + uvsFrame1.zw;
				float4 albedo1 = tex2Dbias( _Albedo, float4( parallax1, 0, textureBias) );
				float4 normals1 = tex2Dbias( _Normals, float4( parallax1, 0, textureBias) );
				float4 parallaxSample2 = tex2Dbias( _Normals, float4( uvsFrame2.zw, 0, depthBias) );
				float2 parallax2 = ( ( 0.5 - parallaxSample2.a ) * uvsFrame2.xy ) + uvsFrame2.zw;
				float4 albedo2 = tex2Dbias( _Albedo, float4( parallax2, 0, textureBias) );
				float4 normals2 = tex2Dbias( _Normals, float4( parallax2, 0, textureBias) );
				float4 parallaxSample3 = tex2Dbias( _Normals, float4( uvsFrame3.zw, 0, depthBias) );
				float2 parallax3 = ( ( 0.5 - parallaxSample3.a ) * uvsFrame3.xy ) + uvsFrame3.zw;
				float4 albedo3 = tex2Dbias( _Albedo, float4( parallax3, 0, textureBias) );
				float4 normals3 = tex2Dbias( _Normals, float4( parallax3, 0, textureBias) );
				float2 fraction = frac( octaFrame.xy );
				float2 invFraction = 1 - fraction;
				float3 weights;
				weights.x = min( invFraction.x, invFraction.y );
				weights.y = abs( fraction.x - fraction.y );
				weights.z = min( fraction.x, fraction.y );
				float4 blendedAlbedo = albedo1 * weights.x + albedo2 * weights.y + albedo3 * weights.z;
				float4 blendedNormal = normals1 * weights.x  + normals2 * weights.y + normals3 * weights.z;
				float4 output0a = tex2Dbias( _WAOTS, float4( parallax1, 0, textureBias) ); 
				float4 output0b = tex2Dbias( _WAOTS, float4( parallax2, 0, textureBias) ); 
				float4 output0c = tex2Dbias( _WAOTS, float4( parallax3, 0, textureBias) ); 
				output0 = output0a * weights.x  + output0b * weights.y + output0c * weights.z; 
				float3 localNormal = blendedNormal.rgb * 2.0 - 1.0;
				float3 worldNormal = normalize( mul( (float3x3)ai_ObjectToWorld, localNormal ) );
				float3 viewPos = interpViewPos.xyz;
				float depthOffset = ( ( parallaxSample1.a * weights.x + parallaxSample2.a * weights.y + parallaxSample3.a * weights.z ) - 0.5 /** 2.0 - 1.0*/ ) /** 0.5*/ * _AI_DepthSize * length( ai_ObjectToWorld[ 2 ].xyz );
				#if defined(SHADOWS_DEPTH)
				if( unity_LightShadowBias.y == 1.0 ) 
				{
				viewPos.z += depthOffset * _AI_ShadowView;
				viewPos.z += -_AI_ShadowBias;
				}
				else 
				{
				viewPos.z += depthOffset;
				}
				#else 
				viewPos.z += depthOffset;
				#endif
				worldPos = mul( UNITY_MATRIX_I_V, float4( viewPos.xyz, 1 ) ).xyz;
				clipPos = mul( UNITY_MATRIX_P, float4( viewPos, 1 ) );
				#if defined(SHADOWS_DEPTH)
				clipPos = UnityApplyLinearShadowBias( clipPos );
				#endif
				clipPos.xyz /= clipPos.w;
				if( UNITY_NEAR_CLIP_VALUE < 0 )
				clipPos = clipPos * 0.5 + 0.5;
				#ifdef EFFECT_HUE_VARIATION
				half3 shiftedColor = lerp(blendedAlbedo.rgb, _HueVariation.rgb, interpViewPos.w);
				half maxBase = max(blendedAlbedo.r, max(blendedAlbedo.g, blendedAlbedo.b));
				half newMaxBase = max(shiftedColor.r, max(shiftedColor.g, shiftedColor.b));
				maxBase /= newMaxBase;
				maxBase = maxBase * 0.5f + 0.5f;
				shiftedColor.rgb *= maxBase;
				blendedAlbedo.rgb = saturate(shiftedColor);
				#endif
				float t = ceil( fraction.x - fraction.y );
				float4 cornerDifference = float4( t, 1 - t, 1, 1 );
				float2 step_1 = ( parallax1 - octaFrame.zw ) * _AI_Frames;
				float4 step23 = ( float4( parallax2, parallax3 ) -  octaFrame.zwzw ) * _AI_Frames - cornerDifference;
				step_1 = step_1 * (1-step_1);
				step23 = step23 * (1-step23);
				float3 steps;
				steps.x = step_1.x * step_1.y;
				steps.y = step23.x * step23.y;
				steps.z = step23.z * step23.w;
				steps = step(-steps, 0);
				float final = dot( steps, weights );
				clip( final - 0.5 );
				o.Albedo = blendedAlbedo.rgb;
				o.Normal = worldNormal;
				o.Alpha = ( blendedAlbedo.a - _AI_Clip );
				clip( o.Alpha );
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
			

			/*struct appdata_full {
				float4 vertex : POSITION;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				fixed4 color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID*/
			
			/*};*/

			struct v2f_surf {
				UNITY_POSITION(pos);
				#if UNITY_VERSION >= 201810
					UNITY_LIGHTING_COORDS(1,2)
				#else
					UNITY_SHADOW_COORDS(1)
				#endif
				UNITY_FOG_COORDS(3)
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 UVsFrame12401 : TEXCOORD5;
				float4 UVsFrame22401 : TEXCOORD6;
				float4 UVsFrame32401 : TEXCOORD7;
				float4 octaframe2401 : TEXCOORD8;
				float4 viewPos2401 : TEXCOORD9;
				float4 ase_color : COLOR;
				float4 ase_texcoord10 : TEXCOORD10;
			};

			v2f_surf vert_surf ( appdata_full v  ) {
				UNITY_SETUP_INSTANCE_ID(v);
				v2f_surf o;
				UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
				UNITY_TRANSFER_INSTANCE_ID(v,o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				half localunity_ObjectToWorld0w1_g8346 = ( unity_ObjectToWorld[0].w );
				half localunity_ObjectToWorld1w2_g8346 = ( unity_ObjectToWorld[1].w );
				half localunity_ObjectToWorld2w3_g8346 = ( unity_ObjectToWorld[2].w );
				float3 appendResult6_g8346 = (float3(localunity_ObjectToWorld0w1_g8346 , localunity_ObjectToWorld1w2_g8346 , localunity_ObjectToWorld2w3_g8346));
				float3 temp_output_1062_510_g8253 = appendResult6_g8346;
				float2 temp_output_1_0_g8295 = (temp_output_1062_510_g8253).xz;
				float temp_output_2_0_g8300 = _WIND_BASE_TRUNK_FIELD_SIZE;
				float2 temp_cast_0 = (( 1.0 / (( temp_output_2_0_g8300 == 0.0 ) ? 1.0 :  temp_output_2_0_g8300 ) )).xx;
				float2 temp_output_2_0_g8295 = temp_cast_0;
				float2 temp_output_704_0_g8289 = ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g8295 / temp_output_2_0_g8295 ) :  ( temp_output_1_0_g8295 * temp_output_2_0_g8295 ) ) + float2( 0,0 ) );
				float temp_output_2_0_g8259 = _WIND_BASE_TRUNK_CYCLE_TIME;
				float temp_output_618_0_g8289 = ( 1.0 / (( temp_output_2_0_g8259 == 0.0 ) ? 1.0 :  temp_output_2_0_g8259 ) );
				float2 break298_g8296 = ( temp_output_704_0_g8289 + ( temp_output_618_0_g8289 * ( _Time.y + 0.0 ) ) );
				float2 appendResult299_g8296 = (float2(sin( break298_g8296.x ) , cos( break298_g8296.y )));
				float4 temp_output_273_0_g8296 = (-1.0).xxxx;
				float4 temp_output_271_0_g8296 = (1.0).xxxx;
				float2 clampResult26_g8296 = clamp( appendResult299_g8296 , temp_output_273_0_g8296.xy , temp_output_271_0_g8296.xy );
				float temp_output_1062_495_g8253 = _WIND_BASE_AMPLITUDE;
				float temp_output_1062_501_g8253 = _WIND_BASE_TO_GUST_RATIO;
				float temp_output_524_0_g8289 = ( temp_output_1062_495_g8253 * temp_output_1062_501_g8253 );
				float2 TRUNK_PIVOT_ROCKING701_g8289 = ( clampResult26_g8296 * temp_output_524_0_g8289 );
				float temp_output_2424_495 = v.color.r;
				float temp_output_2431_0 = ( temp_output_2424_495 * _PrimaryRollStrength );
				float _WIND_PRIMARY_ROLL669_g8289 = temp_output_2431_0;
				float temp_output_54_0_g8304 = ( TRUNK_PIVOT_ROCKING701_g8289 * 0.05 * _WIND_PRIMARY_ROLL669_g8289 ).x;
				float temp_output_72_0_g8304 = cos( temp_output_54_0_g8304 );
				float one_minus_c52_g8304 = ( 1.0 - temp_output_72_0_g8304 );
				float3 break70_g8304 = float3(0,1,0);
				float axis_x25_g8304 = break70_g8304.x;
				float c66_g8304 = temp_output_72_0_g8304;
				float axis_y37_g8304 = break70_g8304.y;
				float axis_z29_g8304 = break70_g8304.z;
				float s67_g8304 = sin( temp_output_54_0_g8304 );
				float3 appendResult83_g8304 = (float3(( ( one_minus_c52_g8304 * axis_x25_g8304 * axis_x25_g8304 ) + c66_g8304 ) , ( ( one_minus_c52_g8304 * axis_x25_g8304 * axis_y37_g8304 ) - ( axis_z29_g8304 * s67_g8304 ) ) , ( ( one_minus_c52_g8304 * axis_z29_g8304 * axis_x25_g8304 ) + ( axis_y37_g8304 * s67_g8304 ) )));
				float3 appendResult81_g8304 = (float3(( ( one_minus_c52_g8304 * axis_x25_g8304 * axis_y37_g8304 ) + ( axis_z29_g8304 * s67_g8304 ) ) , ( ( one_minus_c52_g8304 * axis_y37_g8304 * axis_y37_g8304 ) + c66_g8304 ) , ( ( one_minus_c52_g8304 * axis_y37_g8304 * axis_z29_g8304 ) - ( axis_x25_g8304 * s67_g8304 ) )));
				float3 appendResult82_g8304 = (float3(( ( one_minus_c52_g8304 * axis_z29_g8304 * axis_x25_g8304 ) - ( axis_y37_g8304 * s67_g8304 ) ) , ( ( one_minus_c52_g8304 * axis_y37_g8304 * axis_z29_g8304 ) + ( axis_x25_g8304 * s67_g8304 ) ) , ( ( one_minus_c52_g8304 * axis_z29_g8304 * axis_z29_g8304 ) + c66_g8304 )));
				float3 _WIND_PRIMARY_PIVOT655_g8289 = float3(0,1,0);
				float3 temp_output_38_0_g8304 = ( v.vertex.xyz - (_WIND_PRIMARY_PIVOT655_g8289).xyz );
				float2 break298_g8290 = ( temp_output_704_0_g8289 + ( temp_output_618_0_g8289 * ( _Time.y + 0.0 ) ) );
				float2 appendResult299_g8290 = (float2(sin( break298_g8290.x ) , cos( break298_g8290.y )));
				float4 temp_output_273_0_g8290 = (-1.0).xxxx;
				float4 temp_output_271_0_g8290 = (1.0).xxxx;
				float2 clampResult26_g8290 = clamp( appendResult299_g8290 , temp_output_273_0_g8290.xy , temp_output_271_0_g8290.xy );
				float2 TRUNK_SWIRL700_g8289 = ( clampResult26_g8290 * temp_output_524_0_g8289 );
				float2 break699_g8289 = TRUNK_SWIRL700_g8289;
				float3 appendResult698_g8289 = (float3(break699_g8289.x , 0.0 , break699_g8289.y));
				float3 temp_output_694_0_g8289 = ( ( mul( float3x3(appendResult83_g8304, appendResult81_g8304, appendResult82_g8304), temp_output_38_0_g8304 ) - temp_output_38_0_g8304 ) + ( _WIND_PRIMARY_ROLL669_g8289 * appendResult698_g8289 * 0.5 ) );
				float lerpResult635_g8347 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_LOW , _WIND_AUDIO_INFLUENCE);
				float4 color658_g8306 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
				float2 temp_output_61_0_g8311 = float2( 0,0 );
				half localunity_ObjectToWorld0w1_g8324 = ( unity_ObjectToWorld[0].w );
				half localunity_ObjectToWorld1w2_g8324 = ( unity_ObjectToWorld[1].w );
				half localunity_ObjectToWorld2w3_g8324 = ( unity_ObjectToWorld[2].w );
				float3 appendResult6_g8324 = (float3(localunity_ObjectToWorld0w1_g8324 , localunity_ObjectToWorld1w2_g8324 , localunity_ObjectToWorld2w3_g8324));
				float2 temp_output_1_0_g8312 = (appendResult6_g8324).xz;
				float temp_output_2_0_g8318 = _WIND_GUST_TRUNK_FIELD_SIZE;
				float temp_output_40_0_g8311 = ( 1.0 / (( temp_output_2_0_g8318 == 0.0 ) ? 1.0 :  temp_output_2_0_g8318 ) );
				float2 temp_cast_6 = (temp_output_40_0_g8311).xx;
				float2 temp_output_2_0_g8312 = temp_cast_6;
				float temp_output_2_0_g8307 = _WIND_GUST_TRUNK_CYCLE_TIME;
				float mulTime37_g8311 = _Time.y * ( 1.0 / (( temp_output_2_0_g8307 == 0.0 ) ? 1.0 :  temp_output_2_0_g8307 ) );
				float temp_output_220_0_g8314 = -1.0;
				float4 temp_cast_7 = (temp_output_220_0_g8314).xxxx;
				float temp_output_219_0_g8314 = 1.0;
				float4 temp_cast_8 = (temp_output_219_0_g8314).xxxx;
				float4 clampResult26_g8314 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g8311 > float2( 0,0 ) ) ? ( temp_output_1_0_g8312 / temp_output_2_0_g8312 ) :  ( temp_output_1_0_g8312 * temp_output_2_0_g8312 ) ) + temp_output_61_0_g8311 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g8311 ) ) , temp_cast_7 , temp_cast_8 );
				float4 temp_cast_9 = (temp_output_220_0_g8314).xxxx;
				float4 temp_cast_10 = (temp_output_219_0_g8314).xxxx;
				float4 temp_cast_11 = (0.0).xxxx;
				float4 temp_cast_12 = (temp_output_219_0_g8314).xxxx;
				float temp_output_1072_526_g8253 = _WIND_GUST_CONTRAST;
				float4 temp_cast_13 = (temp_output_1072_526_g8253).xxxx;
				float4 temp_output_52_0_g8311 = saturate( pow( abs( (temp_cast_11 + (clampResult26_g8314 - temp_cast_9) * (temp_cast_12 - temp_cast_11) / (temp_cast_10 - temp_cast_9)) ) , temp_cast_13 ) );
				float temp_output_679_0_g8306 = 1.0;
				float4 lerpResult656_g8306 = lerp( color658_g8306 , temp_output_52_0_g8311 , temp_output_679_0_g8306);
				float _WIND_GUST_STRENGTH703_g8289 = ( (lerpResult635_g8347).xxxx * lerpResult656_g8306 ).x;
				float _WIND_PRIMARY_BEND662_g8289 = ( temp_output_2424_495 * _PrimaryBendStrength );
				float temp_output_54_0_g8294 = ( ( _WIND_GUST_STRENGTH703_g8289 * -1.0 ) * _WIND_PRIMARY_BEND662_g8289 );
				float temp_output_72_0_g8294 = cos( temp_output_54_0_g8294 );
				float one_minus_c52_g8294 = ( 1.0 - temp_output_72_0_g8294 );
				float3 temp_output_1062_494_g8253 = _WIND_DIRECTION;
				float3 _WIND_DIRECTION671_g8289 = temp_output_1062_494_g8253;
				float3 worldToObjDir719_g8289 = mul( unity_WorldToObject, float4( cross( _WIND_DIRECTION671_g8289 , float3(0,1,0) ), 0 ) ).xyz;
				float3 break70_g8294 = worldToObjDir719_g8289;
				float axis_x25_g8294 = break70_g8294.x;
				float c66_g8294 = temp_output_72_0_g8294;
				float axis_y37_g8294 = break70_g8294.y;
				float axis_z29_g8294 = break70_g8294.z;
				float s67_g8294 = sin( temp_output_54_0_g8294 );
				float3 appendResult83_g8294 = (float3(( ( one_minus_c52_g8294 * axis_x25_g8294 * axis_x25_g8294 ) + c66_g8294 ) , ( ( one_minus_c52_g8294 * axis_x25_g8294 * axis_y37_g8294 ) - ( axis_z29_g8294 * s67_g8294 ) ) , ( ( one_minus_c52_g8294 * axis_z29_g8294 * axis_x25_g8294 ) + ( axis_y37_g8294 * s67_g8294 ) )));
				float3 appendResult81_g8294 = (float3(( ( one_minus_c52_g8294 * axis_x25_g8294 * axis_y37_g8294 ) + ( axis_z29_g8294 * s67_g8294 ) ) , ( ( one_minus_c52_g8294 * axis_y37_g8294 * axis_y37_g8294 ) + c66_g8294 ) , ( ( one_minus_c52_g8294 * axis_y37_g8294 * axis_z29_g8294 ) - ( axis_x25_g8294 * s67_g8294 ) )));
				float3 appendResult82_g8294 = (float3(( ( one_minus_c52_g8294 * axis_z29_g8294 * axis_x25_g8294 ) - ( axis_y37_g8294 * s67_g8294 ) ) , ( ( one_minus_c52_g8294 * axis_y37_g8294 * axis_z29_g8294 ) + ( axis_x25_g8294 * s67_g8294 ) ) , ( ( one_minus_c52_g8294 * axis_z29_g8294 * axis_z29_g8294 ) + c66_g8294 )));
				float3 temp_output_38_0_g8294 = ( v.vertex.xyz - (_WIND_PRIMARY_PIVOT655_g8289).xyz );
				float temp_output_1062_498_g8253 = _WIND_GUST_AMPLITUDE;
				float3 lerpResult538_g8289 = lerp( temp_output_694_0_g8289 , ( temp_output_694_0_g8289 + ( mul( float3x3(appendResult83_g8294, appendResult81_g8294, appendResult82_g8294), temp_output_38_0_g8294 ) - temp_output_38_0_g8294 ) ) , temp_output_1062_498_g8253);
				float3 temp_output_41_0_g8355 = ( ( _WIND_BASE_TRUNK_STRENGTH * lerpResult538_g8289 ) + ( _WIND_LEAF_STRENGTH * float3(0,0,0) ) );
				float temp_output_63_0_g8356 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
				float3 lerpResult57_g8356 = lerp( temp_output_41_0_g8355 , -v.vertex.xyz , ( 1.0 - temp_output_63_0_g8356 ));
				#ifdef INTERNAL_LODFADE_SCALE
				float3 staticSwitch58_g8355 = lerpResult57_g8356;
				#else
				float3 staticSwitch58_g8355 = temp_output_41_0_g8355;
				#endif
				#ifdef LOD_FADE_CROSSFADE
				float3 staticSwitch62_g8355 = staticSwitch58_g8355;
				#else
				float3 staticSwitch62_g8355 = temp_output_41_0_g8355;
				#endif
				
				OctaImpostorVertex( v.vertex, v.normal, o.UVsFrame12401, o.UVsFrame22401, o.UVsFrame32401, o.octaframe2401, o.viewPos2401 );
				
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord10 = screenPos;
				
				o.ase_color = v.color;

				v.vertex.xyz += staticSwitch62_g8355;
				o.pos = UnityObjectToClipPos(v.vertex);

				#if UNITY_VERSION >= 201810
					UNITY_TRANSFER_LIGHTING(o, v.texcoord1.xy);
				#else
					UNITY_TRANSFER_SHADOW(o, v.texcoord1.xy);
				#endif
				UNITY_TRANSFER_FOG(o,o.pos);
				return o;
			}

			fixed4 frag_surf ( v2f_surf IN, out float outDepth : SV_Depth  ) : SV_Target {
				UNITY_SETUP_INSTANCE_ID(IN);
				#if defined(_SPECULAR_SETUP)
					SurfaceOutputStandardSpecular o = (SurfaceOutputStandardSpecular)0;
				#else
					SurfaceOutputStandard o = (SurfaceOutputStandard)0;
				#endif
				float4 clipPos = 0;
				float3 worldPos = 0;
				float temp_output_88_0_g1926 = _ContrastAdjustment;
				float4 output0 = 0;
				OctaImpostorFragment( o, clipPos, worldPos, IN.UVsFrame12401, IN.UVsFrame22401, IN.UVsFrame32401, IN.octaframe2401, IN.viewPos2401, output0 );
				float4 temp_output_89_0_g1926 = float4( o.Albedo , 0.0 );
				float3 hsvTorgb92_g1926 = RGBToHSV( temp_output_89_0_g1926.rgb );
				float3 hsvTorgb83_g1926 = HSVToRGB( float3(( _HueAdjustment + hsvTorgb92_g1926.x ),( hsvTorgb92_g1926.y + _SaturationAdjustment ),( hsvTorgb92_g1926.z + _BrightnessAdjustment )) );
				float4 appendResult104_g1926 = (float4(CalculateContrast(temp_output_88_0_g1926,float4( hsvTorgb83_g1926 , 0.0 )).rgb , (temp_output_89_0_g1926).a));
				float temp_output_88_0_g1932 = _ContrastAdjustment;
				float4 temp_output_89_0_g1932 = float4( o.Albedo , 0.0 );
				float3 hsvTorgb92_g1932 = RGBToHSV( temp_output_89_0_g1932.rgb );
				float3 hsvTorgb83_g1932 = HSVToRGB( float3(( _HueAdjustment + hsvTorgb92_g1932.x ),( hsvTorgb92_g1932.y + _SaturationAdjustment ),( hsvTorgb92_g1932.z + _BrightnessAdjustment )) );
				float temp_output_2_0_g1934 = _ContrastCorrection;
				float4 appendResult104_g1932 = (float4(CalculateContrast(temp_output_88_0_g1932,( float4( hsvTorgb83_g1932 , 0.0 ) * ( 1.0 / (( temp_output_2_0_g1934 == 0.0 ) ? 1.0 :  temp_output_2_0_g1934 ) ) )).rgb , (temp_output_89_0_g1932).a));
				float temp_output_2424_495 = IN.ase_color.r;
				float temp_output_2431_0 = ( temp_output_2424_495 * _PrimaryRollStrength );
				float4 lerpResult2444 = lerp( saturate( (( _CorrectContrast )?( appendResult104_g1932 ):( appendResult104_g1926 )) ) , saturate( _FadeVariation ) , saturate( ( temp_output_2431_0 * _FadeVariation.a ) ));
				
				float4 break2402 = output0;
				
				float temp_output_41_0_g8349 = o.Alpha;
				float4 screenPos = IN.ase_texcoord10;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float2 clipScreen45_g8350 = ase_screenPosNorm.xy * _ScreenParams.xy;
				float dither45_g8350 = Dither8x8Bayer( fmod(clipScreen45_g8350.x, 8), fmod(clipScreen45_g8350.y, 8) );
				float temp_output_56_0_g8350 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
				dither45_g8350 = step( dither45_g8350, temp_output_56_0_g8350 );
				#ifdef INTERNAL_LODFADE_DITHER
				float staticSwitch50_g8349 = ( temp_output_41_0_g8349 * dither45_g8350 );
				#else
				float staticSwitch50_g8349 = temp_output_41_0_g8349;
				#endif
				#ifdef LOD_FADE_CROSSFADE
				float staticSwitch56_g8349 = staticSwitch50_g8349;
				#else
				float staticSwitch56_g8349 = temp_output_41_0_g8349;
				#endif
				
				fixed3 albedo = saturate( lerpResult2444 ).rgb;
				fixed3 normal = o.Normal;
				half3 emission = half3( 0, 0, 0 );
				fixed3 specular = fixed3( 0, 0, 0 );
				fixed metallic = 0;
				half smoothness = break2402.w;
				half occlusion = break2402.y;
				fixed alpha = staticSwitch56_g8349;

				o.Albedo = albedo;
				o.Normal = normal;
				o.Emission = emission;
				#if defined(_SPECULAR_SETUP)
					o.Specular = specular;
				#else
					o.Metallic = metallic;
				#endif
				o.Smoothness = smoothness;
				o.Occlusion = occlusion;
				o.Alpha = alpha;
				clip(o.Alpha);

				IN.pos.zw = clipPos.zw;
				outDepth = IN.pos.z;

				#ifndef USING_DIRECTIONAL_LIGHT
					fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
				#else
					fixed3 lightDir = _WorldSpaceLightPos0.xyz;
				#endif

				fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));

				UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
				UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
				fixed4 c = 0;

				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
				gi.indirect.diffuse = 0;
				gi.indirect.specular = 0;
				gi.light.color = _LightColor0.rgb;
				gi.light.dir = lightDir;
				gi.light.color *= atten;
				#if defined(_SPECULAR_SETUP)
					c += LightingStandardSpecular( o, worldViewDir, gi );
				#else
					c += LightingStandard( o, worldViewDir, gi );
				#endif
				UNITY_APPLY_FOG(IN.fogCoord, c);
				return c;
			}
			ENDCG
		}

		Pass
		{
			

			Name "Deferred"
			Tags { "LightMode"="Deferred" }

			CGPROGRAM
#include "UnityCG.cginc"
#include "Assets/Resources/CGIncludes/GPUInstancerInclude.cginc"
#pragma instancing_options procedural:setupGPUI
#pragma multi_compile_instancing
#include "UnityCG.cginc"
			
			#pragma vertex vert_surf
			#pragma fragment frag_surf
			#pragma multi_compile __ LOD_FADE_CROSSFADE
			#pragma exclude_renderers nomrt
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#pragma multi_compile_prepassfinal
			#include "HLSLSupport.cginc"
			#if !defined( UNITY_INSTANCED_LOD_FADE )
				#define UNITY_INSTANCED_LOD_FADE
			#endif
			#if !defined( UNITY_INSTANCED_SH )
				#define UNITY_INSTANCED_SH
			#endif
			#if !defined( UNITY_INSTANCED_LIGHTMAPSTS )
				#define UNITY_INSTANCED_LIGHTMAPSTS
			#endif
			#include "UnityShaderVariables.cginc"
			#include "UnityShaderUtilities.cginc"
			#ifndef UNITY_PASS_DEFERRED
			#define UNITY_PASS_DEFERRED
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			#include "UnityStandardUtils.cginc"

			#ifdef LIGHTMAP_ON
			float4 unity_LightmapFade;
			#endif
			fixed4 unity_Ambient;
			#define ai_ObjectToWorld unity_ObjectToWorld
			#define ai_WorldToObject unity_WorldToObject
			#define AI_INV_TWO_PI  UNITY_INV_TWO_PI
			#define AI_PI          UNITY_PI
			#define AI_INV_PI      UNITY_INV_PI
			#pragma shader_feature EFFECT_HUE_VARIATION
			 





		// INTERNAL_SHADER_FEATURE_START

		// FEATURE_GPU_INSTANCER
		#include "UnityCG.cginc"


		// FEATURE_LODFADE_SCALE
		#define INTERNAL_LODFADE_SCALE
		#pragma multi_compile __ LOD_FADE_CROSSFADE

		// INTERNAL_SHADER_FEATURE_END
			  

			uniform float4 _HueVariation;
			uniform half _WIND_BASE_TRUNK_STRENGTH;
			uniform half _WIND_BASE_TRUNK_FIELD_SIZE;
			uniform half _WIND_BASE_TRUNK_CYCLE_TIME;
			uniform half _WIND_BASE_AMPLITUDE;
			uniform half _WIND_BASE_TO_GUST_RATIO;
			uniform float _PrimaryRollStrength;
			uniform half _WIND_GUST_AMPLITUDE;
			uniform half _WIND_GUST_AUDIO_STRENGTH_LOW;
			uniform half _WIND_AUDIO_INFLUENCE;
			uniform sampler2D _WIND_GUST_TEXTURE;
			uniform half _WIND_GUST_TRUNK_FIELD_SIZE;
			uniform half _WIND_GUST_TRUNK_CYCLE_TIME;
			uniform half _WIND_GUST_CONTRAST;
			uniform float _PrimaryBendStrength;
			uniform half3 _WIND_DIRECTION;
			uniform half _WIND_LEAF_STRENGTH;
			uniform float _CorrectContrast;
			uniform float _ContrastAdjustment;
			uniform float _HueAdjustment;
			uniform float _AI_Frames;
			uniform float _AI_FramesX;
			uniform float _AI_FramesY;
			uniform float _AI_ImpostorSize;
			uniform float _AI_Parallax;
			uniform float3 _AI_Offset;
			uniform float4 _AI_SizeOffset;
			uniform float _AI_TextureBias;
			uniform sampler2D _Albedo;
			uniform sampler2D _Normals;
			uniform float _AI_DepthSize;
			uniform float _AI_ShadowBias;
			uniform float _AI_ShadowView;
			uniform float _AI_Clip;
			uniform float4 _AI_HueVariation;
			uniform sampler2D _WAOTS;
			uniform float _SaturationAdjustment;
			uniform float _BrightnessAdjustment;
			uniform float _ContrastCorrection;
			uniform float4 _FadeVariation;
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
			float2 VectortoHemiOctahedron( float3 N )
			{
				N.xy /= dot( 1.0, abs( N ) );
				return float2( N.x + N.y, N.x - N.y );
			}
			
			float3 HemiOctahedronToVector( float2 Oct )
			{
				Oct = float2( Oct.x + Oct.y, Oct.x - Oct.y ) * 0.5;
				float3 N = float3( Oct, 1 - dot( 1.0, abs( Oct ) ) );
				return normalize( N );
			}
			
			inline void RayPlaneIntersectionUV( float3 normal, float3 rayPosition, float3 rayDirection, inout float2 uvs, inout float3 localNormal )
			{
				float lDotN = dot( rayDirection, normal ); 
				float p0l0DotN = dot( -rayPosition, normal );
				float t = p0l0DotN / lDotN;
				float3 p = rayDirection * t + rayPosition;
				float3 upVector = float3( 0, 1, 0 );
				float3 tangent = normalize( cross( upVector, normal ) + float3( -0.001, 0, 0 ) );
				float3 bitangent = cross( tangent, normal );
				float frameX = dot( p, tangent );
				float frameZ = dot( p, bitangent );
				uvs = -float2( frameX, frameZ );
				if( t <= 0.0 )
				uvs = 0;
				float3x3 worldToLocal = float3x3( tangent, bitangent, normal );
				localNormal = normalize( mul( worldToLocal, rayDirection ) );
			}
			
			inline void OctaImpostorVertex( inout float4 vertex, inout float3 normal, inout float4 uvsFrame1, inout float4 uvsFrame2, inout float4 uvsFrame3, inout float4 octaFrame, inout float4 viewPos )
			{
				float2 uvOffset = _AI_SizeOffset.zw;
				float parallax = -_AI_Parallax; 
				float UVscale = _AI_ImpostorSize;
				float framesXY = _AI_Frames;
				float prevFrame = framesXY - 1;
				float3 fractions = 1.0 / float3( framesXY, prevFrame, UVscale );
				float fractionsFrame = fractions.x;
				float fractionsPrevFrame = fractions.y;
				float fractionsUVscale = fractions.z;
				float3 worldOrigin = 0;
				float4 perspective = float4( 0, 0, 0, 1 );
				if( UNITY_MATRIX_P[ 3 ][ 3 ] == 1 ) 
				{
				perspective = float4( 0, 0, 5000, 0 );
				worldOrigin = ai_ObjectToWorld._m03_m13_m23;
				}
				float3 worldCameraPos = worldOrigin + mul( UNITY_MATRIX_I_V, perspective ).xyz;
				float3 objectCameraPosition = mul( ai_WorldToObject, float4( worldCameraPos, 1 ) ).xyz - _AI_Offset.xyz; 
				float3 objectCameraDirection = normalize( objectCameraPosition );
				float3 upVector = float3( 0,1,0 );
				float3 objectHorizontalVector = normalize( cross( objectCameraDirection, upVector ) );
				float3 objectVerticalVector = cross( objectHorizontalVector, objectCameraDirection );
				float2 uvExpansion = vertex.xy;
				float3 billboard = objectHorizontalVector * uvExpansion.x + objectVerticalVector * uvExpansion.y;
				float3 localDir = billboard - objectCameraPosition; 
				objectCameraDirection.y = max(0.001, objectCameraDirection.y);
				float2 frameOcta = VectortoHemiOctahedron( objectCameraDirection.xzy ) * 0.5 + 0.5;
				float2 prevOctaFrame = frameOcta * prevFrame;
				float2 baseOctaFrame = floor( prevOctaFrame );
				float2 fractionOctaFrame = ( baseOctaFrame * fractionsFrame );
				float2 octaFrame1 = ( baseOctaFrame * fractionsPrevFrame ) * 2.0 - 1.0;
				float3 octa1WorldY = HemiOctahedronToVector( octaFrame1 ).xzy;
				float3 octa1LocalY;
				float2 uvFrame1;
				RayPlaneIntersectionUV( octa1WorldY, objectCameraPosition, localDir, /*inout*/ uvFrame1, /*inout*/ octa1LocalY );
				float2 uvParallax1 = octa1LocalY.xy * fractionsFrame * parallax;
				uvFrame1 = ( uvFrame1 * fractionsUVscale + 0.5 ) * fractionsFrame + fractionOctaFrame;
				uvsFrame1 = float4( uvParallax1, uvFrame1) - float4( 0, 0, uvOffset );
				float2 fractPrevOctaFrame = frac( prevOctaFrame );
				float2 cornerDifference = lerp( float2( 0,1 ) , float2( 1,0 ) , saturate( ceil( ( fractPrevOctaFrame.x - fractPrevOctaFrame.y ) ) ));
				float2 octaFrame2 = ( ( baseOctaFrame + cornerDifference ) * fractionsPrevFrame ) * 2.0 - 1.0;
				float3 octa2WorldY = HemiOctahedronToVector( octaFrame2 ).xzy;
				float3 octa2LocalY;
				float2 uvFrame2;
				RayPlaneIntersectionUV( octa2WorldY, objectCameraPosition, localDir, /*inout*/ uvFrame2, /*inout*/ octa2LocalY );
				float2 uvParallax2 = octa2LocalY.xy * fractionsFrame * parallax;
				uvFrame2 = ( uvFrame2 * fractionsUVscale + 0.5 ) * fractionsFrame + ( ( cornerDifference * fractionsFrame ) + fractionOctaFrame );
				uvsFrame2 = float4( uvParallax2, uvFrame2) - float4( 0, 0, uvOffset );
				float2 octaFrame3 = ( ( baseOctaFrame + 1 ) * fractionsPrevFrame  ) * 2.0 - 1.0;
				float3 octa3WorldY = HemiOctahedronToVector( octaFrame3 ).xzy;
				float3 octa3LocalY;
				float2 uvFrame3;
				RayPlaneIntersectionUV( octa3WorldY, objectCameraPosition, localDir, /*inout*/ uvFrame3, /*inout*/ octa3LocalY );
				float2 uvParallax3 = octa3LocalY.xy * fractionsFrame * parallax;
				uvFrame3 = ( uvFrame3 * fractionsUVscale + 0.5 ) * fractionsFrame + ( fractionOctaFrame + fractionsFrame );
				uvsFrame3 = float4( uvParallax3, uvFrame3) - float4( 0, 0, uvOffset );
				octaFrame = 0;
				octaFrame.xy = prevOctaFrame;
				octaFrame.zw = fractionOctaFrame;
				vertex.xyz = billboard + _AI_Offset.xyz;
				normal.xyz = objectCameraDirection;
				viewPos = 0;
				viewPos.xyz = UnityObjectToViewPos( vertex.xyz );
				#ifdef EFFECT_HUE_VARIATION
				float hueVariationAmount = frac( ai_ObjectToWorld[0].w + ai_ObjectToWorld[1].w + ai_ObjectToWorld[2].w);
				viewPos.w = saturate(hueVariationAmount * _AI_HueVariation.a);
				#endif
			}
			
			inline void OctaImpostorFragment( inout SurfaceOutputStandard o, out float4 clipPos, out float3 worldPos, float4 uvsFrame1, float4 uvsFrame2, float4 uvsFrame3, float4 octaFrame, float4 interpViewPos, out float4 output0 )
			{
				float depthBias = -1.0;
				float textureBias = _AI_TextureBias;
				float4 parallaxSample1 = tex2Dbias( _Normals, float4( uvsFrame1.zw, 0, depthBias) );
				float2 parallax1 = ( ( 0.5 - parallaxSample1.a ) * uvsFrame1.xy ) + uvsFrame1.zw;
				float4 albedo1 = tex2Dbias( _Albedo, float4( parallax1, 0, textureBias) );
				float4 normals1 = tex2Dbias( _Normals, float4( parallax1, 0, textureBias) );
				float4 parallaxSample2 = tex2Dbias( _Normals, float4( uvsFrame2.zw, 0, depthBias) );
				float2 parallax2 = ( ( 0.5 - parallaxSample2.a ) * uvsFrame2.xy ) + uvsFrame2.zw;
				float4 albedo2 = tex2Dbias( _Albedo, float4( parallax2, 0, textureBias) );
				float4 normals2 = tex2Dbias( _Normals, float4( parallax2, 0, textureBias) );
				float4 parallaxSample3 = tex2Dbias( _Normals, float4( uvsFrame3.zw, 0, depthBias) );
				float2 parallax3 = ( ( 0.5 - parallaxSample3.a ) * uvsFrame3.xy ) + uvsFrame3.zw;
				float4 albedo3 = tex2Dbias( _Albedo, float4( parallax3, 0, textureBias) );
				float4 normals3 = tex2Dbias( _Normals, float4( parallax3, 0, textureBias) );
				float2 fraction = frac( octaFrame.xy );
				float2 invFraction = 1 - fraction;
				float3 weights;
				weights.x = min( invFraction.x, invFraction.y );
				weights.y = abs( fraction.x - fraction.y );
				weights.z = min( fraction.x, fraction.y );
				float4 blendedAlbedo = albedo1 * weights.x + albedo2 * weights.y + albedo3 * weights.z;
				float4 blendedNormal = normals1 * weights.x  + normals2 * weights.y + normals3 * weights.z;
				float4 output0a = tex2Dbias( _WAOTS, float4( parallax1, 0, textureBias) ); 
				float4 output0b = tex2Dbias( _WAOTS, float4( parallax2, 0, textureBias) ); 
				float4 output0c = tex2Dbias( _WAOTS, float4( parallax3, 0, textureBias) ); 
				output0 = output0a * weights.x  + output0b * weights.y + output0c * weights.z; 
				float3 localNormal = blendedNormal.rgb * 2.0 - 1.0;
				float3 worldNormal = normalize( mul( (float3x3)ai_ObjectToWorld, localNormal ) );
				float3 viewPos = interpViewPos.xyz;
				float depthOffset = ( ( parallaxSample1.a * weights.x + parallaxSample2.a * weights.y + parallaxSample3.a * weights.z ) - 0.5 /** 2.0 - 1.0*/ ) /** 0.5*/ * _AI_DepthSize * length( ai_ObjectToWorld[ 2 ].xyz );
				#if defined(SHADOWS_DEPTH)
				if( unity_LightShadowBias.y == 1.0 ) 
				{
				viewPos.z += depthOffset * _AI_ShadowView;
				viewPos.z += -_AI_ShadowBias;
				}
				else 
				{
				viewPos.z += depthOffset;
				}
				#else 
				viewPos.z += depthOffset;
				#endif
				worldPos = mul( UNITY_MATRIX_I_V, float4( viewPos.xyz, 1 ) ).xyz;
				clipPos = mul( UNITY_MATRIX_P, float4( viewPos, 1 ) );
				#if defined(SHADOWS_DEPTH)
				clipPos = UnityApplyLinearShadowBias( clipPos );
				#endif
				clipPos.xyz /= clipPos.w;
				if( UNITY_NEAR_CLIP_VALUE < 0 )
				clipPos = clipPos * 0.5 + 0.5;
				#ifdef EFFECT_HUE_VARIATION
				half3 shiftedColor = lerp(blendedAlbedo.rgb, _HueVariation.rgb, interpViewPos.w);
				half maxBase = max(blendedAlbedo.r, max(blendedAlbedo.g, blendedAlbedo.b));
				half newMaxBase = max(shiftedColor.r, max(shiftedColor.g, shiftedColor.b));
				maxBase /= newMaxBase;
				maxBase = maxBase * 0.5f + 0.5f;
				shiftedColor.rgb *= maxBase;
				blendedAlbedo.rgb = saturate(shiftedColor);
				#endif
				float t = ceil( fraction.x - fraction.y );
				float4 cornerDifference = float4( t, 1 - t, 1, 1 );
				float2 step_1 = ( parallax1 - octaFrame.zw ) * _AI_Frames;
				float4 step23 = ( float4( parallax2, parallax3 ) -  octaFrame.zwzw ) * _AI_Frames - cornerDifference;
				step_1 = step_1 * (1-step_1);
				step23 = step23 * (1-step23);
				float3 steps;
				steps.x = step_1.x * step_1.y;
				steps.y = step23.x * step23.y;
				steps.z = step23.z * step23.w;
				steps = step(-steps, 0);
				float final = dot( steps, weights );
				clip( final - 0.5 );
				o.Albedo = blendedAlbedo.rgb;
				o.Normal = worldNormal;
				o.Alpha = ( blendedAlbedo.a - _AI_Clip );
				clip( o.Alpha );
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
			

			/*struct appdata_full {
				float4 vertex : POSITION;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				fixed4 color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID*/
			
			/*};*/

			struct v2f_surf {
				UNITY_POSITION(pos);
				#ifndef DIRLIGHTMAP_OFF
					half3 viewDir : TEXCOORD1;
				#endif
				float4 lmap : TEXCOORD2;
				#ifndef LIGHTMAP_ON
					#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
						half3 sh : TEXCOORD3;
					#endif
				#else
					#ifdef DIRLIGHTMAP_OFF
						float4 lmapFadePos : TEXCOORD4;
					#endif
				#endif
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 UVsFrame12401 : TEXCOORD5;
				float4 UVsFrame22401 : TEXCOORD6;
				float4 UVsFrame32401 : TEXCOORD7;
				float4 octaframe2401 : TEXCOORD8;
				float4 viewPos2401 : TEXCOORD9;
				float4 ase_color : COLOR;
				float4 ase_texcoord10 : TEXCOORD10;
			};

			v2f_surf vert_surf (appdata_full v ) {
				UNITY_SETUP_INSTANCE_ID(v);
				v2f_surf o;
				UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
				UNITY_TRANSFER_INSTANCE_ID(v,o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				half localunity_ObjectToWorld0w1_g8346 = ( unity_ObjectToWorld[0].w );
				half localunity_ObjectToWorld1w2_g8346 = ( unity_ObjectToWorld[1].w );
				half localunity_ObjectToWorld2w3_g8346 = ( unity_ObjectToWorld[2].w );
				float3 appendResult6_g8346 = (float3(localunity_ObjectToWorld0w1_g8346 , localunity_ObjectToWorld1w2_g8346 , localunity_ObjectToWorld2w3_g8346));
				float3 temp_output_1062_510_g8253 = appendResult6_g8346;
				float2 temp_output_1_0_g8295 = (temp_output_1062_510_g8253).xz;
				float temp_output_2_0_g8300 = _WIND_BASE_TRUNK_FIELD_SIZE;
				float2 temp_cast_0 = (( 1.0 / (( temp_output_2_0_g8300 == 0.0 ) ? 1.0 :  temp_output_2_0_g8300 ) )).xx;
				float2 temp_output_2_0_g8295 = temp_cast_0;
				float2 temp_output_704_0_g8289 = ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g8295 / temp_output_2_0_g8295 ) :  ( temp_output_1_0_g8295 * temp_output_2_0_g8295 ) ) + float2( 0,0 ) );
				float temp_output_2_0_g8259 = _WIND_BASE_TRUNK_CYCLE_TIME;
				float temp_output_618_0_g8289 = ( 1.0 / (( temp_output_2_0_g8259 == 0.0 ) ? 1.0 :  temp_output_2_0_g8259 ) );
				float2 break298_g8296 = ( temp_output_704_0_g8289 + ( temp_output_618_0_g8289 * ( _Time.y + 0.0 ) ) );
				float2 appendResult299_g8296 = (float2(sin( break298_g8296.x ) , cos( break298_g8296.y )));
				float4 temp_output_273_0_g8296 = (-1.0).xxxx;
				float4 temp_output_271_0_g8296 = (1.0).xxxx;
				float2 clampResult26_g8296 = clamp( appendResult299_g8296 , temp_output_273_0_g8296.xy , temp_output_271_0_g8296.xy );
				float temp_output_1062_495_g8253 = _WIND_BASE_AMPLITUDE;
				float temp_output_1062_501_g8253 = _WIND_BASE_TO_GUST_RATIO;
				float temp_output_524_0_g8289 = ( temp_output_1062_495_g8253 * temp_output_1062_501_g8253 );
				float2 TRUNK_PIVOT_ROCKING701_g8289 = ( clampResult26_g8296 * temp_output_524_0_g8289 );
				float temp_output_2424_495 = v.color.r;
				float temp_output_2431_0 = ( temp_output_2424_495 * _PrimaryRollStrength );
				float _WIND_PRIMARY_ROLL669_g8289 = temp_output_2431_0;
				float temp_output_54_0_g8304 = ( TRUNK_PIVOT_ROCKING701_g8289 * 0.05 * _WIND_PRIMARY_ROLL669_g8289 ).x;
				float temp_output_72_0_g8304 = cos( temp_output_54_0_g8304 );
				float one_minus_c52_g8304 = ( 1.0 - temp_output_72_0_g8304 );
				float3 break70_g8304 = float3(0,1,0);
				float axis_x25_g8304 = break70_g8304.x;
				float c66_g8304 = temp_output_72_0_g8304;
				float axis_y37_g8304 = break70_g8304.y;
				float axis_z29_g8304 = break70_g8304.z;
				float s67_g8304 = sin( temp_output_54_0_g8304 );
				float3 appendResult83_g8304 = (float3(( ( one_minus_c52_g8304 * axis_x25_g8304 * axis_x25_g8304 ) + c66_g8304 ) , ( ( one_minus_c52_g8304 * axis_x25_g8304 * axis_y37_g8304 ) - ( axis_z29_g8304 * s67_g8304 ) ) , ( ( one_minus_c52_g8304 * axis_z29_g8304 * axis_x25_g8304 ) + ( axis_y37_g8304 * s67_g8304 ) )));
				float3 appendResult81_g8304 = (float3(( ( one_minus_c52_g8304 * axis_x25_g8304 * axis_y37_g8304 ) + ( axis_z29_g8304 * s67_g8304 ) ) , ( ( one_minus_c52_g8304 * axis_y37_g8304 * axis_y37_g8304 ) + c66_g8304 ) , ( ( one_minus_c52_g8304 * axis_y37_g8304 * axis_z29_g8304 ) - ( axis_x25_g8304 * s67_g8304 ) )));
				float3 appendResult82_g8304 = (float3(( ( one_minus_c52_g8304 * axis_z29_g8304 * axis_x25_g8304 ) - ( axis_y37_g8304 * s67_g8304 ) ) , ( ( one_minus_c52_g8304 * axis_y37_g8304 * axis_z29_g8304 ) + ( axis_x25_g8304 * s67_g8304 ) ) , ( ( one_minus_c52_g8304 * axis_z29_g8304 * axis_z29_g8304 ) + c66_g8304 )));
				float3 _WIND_PRIMARY_PIVOT655_g8289 = float3(0,1,0);
				float3 temp_output_38_0_g8304 = ( v.vertex.xyz - (_WIND_PRIMARY_PIVOT655_g8289).xyz );
				float2 break298_g8290 = ( temp_output_704_0_g8289 + ( temp_output_618_0_g8289 * ( _Time.y + 0.0 ) ) );
				float2 appendResult299_g8290 = (float2(sin( break298_g8290.x ) , cos( break298_g8290.y )));
				float4 temp_output_273_0_g8290 = (-1.0).xxxx;
				float4 temp_output_271_0_g8290 = (1.0).xxxx;
				float2 clampResult26_g8290 = clamp( appendResult299_g8290 , temp_output_273_0_g8290.xy , temp_output_271_0_g8290.xy );
				float2 TRUNK_SWIRL700_g8289 = ( clampResult26_g8290 * temp_output_524_0_g8289 );
				float2 break699_g8289 = TRUNK_SWIRL700_g8289;
				float3 appendResult698_g8289 = (float3(break699_g8289.x , 0.0 , break699_g8289.y));
				float3 temp_output_694_0_g8289 = ( ( mul( float3x3(appendResult83_g8304, appendResult81_g8304, appendResult82_g8304), temp_output_38_0_g8304 ) - temp_output_38_0_g8304 ) + ( _WIND_PRIMARY_ROLL669_g8289 * appendResult698_g8289 * 0.5 ) );
				float lerpResult635_g8347 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_LOW , _WIND_AUDIO_INFLUENCE);
				float4 color658_g8306 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
				float2 temp_output_61_0_g8311 = float2( 0,0 );
				half localunity_ObjectToWorld0w1_g8324 = ( unity_ObjectToWorld[0].w );
				half localunity_ObjectToWorld1w2_g8324 = ( unity_ObjectToWorld[1].w );
				half localunity_ObjectToWorld2w3_g8324 = ( unity_ObjectToWorld[2].w );
				float3 appendResult6_g8324 = (float3(localunity_ObjectToWorld0w1_g8324 , localunity_ObjectToWorld1w2_g8324 , localunity_ObjectToWorld2w3_g8324));
				float2 temp_output_1_0_g8312 = (appendResult6_g8324).xz;
				float temp_output_2_0_g8318 = _WIND_GUST_TRUNK_FIELD_SIZE;
				float temp_output_40_0_g8311 = ( 1.0 / (( temp_output_2_0_g8318 == 0.0 ) ? 1.0 :  temp_output_2_0_g8318 ) );
				float2 temp_cast_6 = (temp_output_40_0_g8311).xx;
				float2 temp_output_2_0_g8312 = temp_cast_6;
				float temp_output_2_0_g8307 = _WIND_GUST_TRUNK_CYCLE_TIME;
				float mulTime37_g8311 = _Time.y * ( 1.0 / (( temp_output_2_0_g8307 == 0.0 ) ? 1.0 :  temp_output_2_0_g8307 ) );
				float temp_output_220_0_g8314 = -1.0;
				float4 temp_cast_7 = (temp_output_220_0_g8314).xxxx;
				float temp_output_219_0_g8314 = 1.0;
				float4 temp_cast_8 = (temp_output_219_0_g8314).xxxx;
				float4 clampResult26_g8314 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g8311 > float2( 0,0 ) ) ? ( temp_output_1_0_g8312 / temp_output_2_0_g8312 ) :  ( temp_output_1_0_g8312 * temp_output_2_0_g8312 ) ) + temp_output_61_0_g8311 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g8311 ) ) , temp_cast_7 , temp_cast_8 );
				float4 temp_cast_9 = (temp_output_220_0_g8314).xxxx;
				float4 temp_cast_10 = (temp_output_219_0_g8314).xxxx;
				float4 temp_cast_11 = (0.0).xxxx;
				float4 temp_cast_12 = (temp_output_219_0_g8314).xxxx;
				float temp_output_1072_526_g8253 = _WIND_GUST_CONTRAST;
				float4 temp_cast_13 = (temp_output_1072_526_g8253).xxxx;
				float4 temp_output_52_0_g8311 = saturate( pow( abs( (temp_cast_11 + (clampResult26_g8314 - temp_cast_9) * (temp_cast_12 - temp_cast_11) / (temp_cast_10 - temp_cast_9)) ) , temp_cast_13 ) );
				float temp_output_679_0_g8306 = 1.0;
				float4 lerpResult656_g8306 = lerp( color658_g8306 , temp_output_52_0_g8311 , temp_output_679_0_g8306);
				float _WIND_GUST_STRENGTH703_g8289 = ( (lerpResult635_g8347).xxxx * lerpResult656_g8306 ).x;
				float _WIND_PRIMARY_BEND662_g8289 = ( temp_output_2424_495 * _PrimaryBendStrength );
				float temp_output_54_0_g8294 = ( ( _WIND_GUST_STRENGTH703_g8289 * -1.0 ) * _WIND_PRIMARY_BEND662_g8289 );
				float temp_output_72_0_g8294 = cos( temp_output_54_0_g8294 );
				float one_minus_c52_g8294 = ( 1.0 - temp_output_72_0_g8294 );
				float3 temp_output_1062_494_g8253 = _WIND_DIRECTION;
				float3 _WIND_DIRECTION671_g8289 = temp_output_1062_494_g8253;
				float3 worldToObjDir719_g8289 = mul( unity_WorldToObject, float4( cross( _WIND_DIRECTION671_g8289 , float3(0,1,0) ), 0 ) ).xyz;
				float3 break70_g8294 = worldToObjDir719_g8289;
				float axis_x25_g8294 = break70_g8294.x;
				float c66_g8294 = temp_output_72_0_g8294;
				float axis_y37_g8294 = break70_g8294.y;
				float axis_z29_g8294 = break70_g8294.z;
				float s67_g8294 = sin( temp_output_54_0_g8294 );
				float3 appendResult83_g8294 = (float3(( ( one_minus_c52_g8294 * axis_x25_g8294 * axis_x25_g8294 ) + c66_g8294 ) , ( ( one_minus_c52_g8294 * axis_x25_g8294 * axis_y37_g8294 ) - ( axis_z29_g8294 * s67_g8294 ) ) , ( ( one_minus_c52_g8294 * axis_z29_g8294 * axis_x25_g8294 ) + ( axis_y37_g8294 * s67_g8294 ) )));
				float3 appendResult81_g8294 = (float3(( ( one_minus_c52_g8294 * axis_x25_g8294 * axis_y37_g8294 ) + ( axis_z29_g8294 * s67_g8294 ) ) , ( ( one_minus_c52_g8294 * axis_y37_g8294 * axis_y37_g8294 ) + c66_g8294 ) , ( ( one_minus_c52_g8294 * axis_y37_g8294 * axis_z29_g8294 ) - ( axis_x25_g8294 * s67_g8294 ) )));
				float3 appendResult82_g8294 = (float3(( ( one_minus_c52_g8294 * axis_z29_g8294 * axis_x25_g8294 ) - ( axis_y37_g8294 * s67_g8294 ) ) , ( ( one_minus_c52_g8294 * axis_y37_g8294 * axis_z29_g8294 ) + ( axis_x25_g8294 * s67_g8294 ) ) , ( ( one_minus_c52_g8294 * axis_z29_g8294 * axis_z29_g8294 ) + c66_g8294 )));
				float3 temp_output_38_0_g8294 = ( v.vertex.xyz - (_WIND_PRIMARY_PIVOT655_g8289).xyz );
				float temp_output_1062_498_g8253 = _WIND_GUST_AMPLITUDE;
				float3 lerpResult538_g8289 = lerp( temp_output_694_0_g8289 , ( temp_output_694_0_g8289 + ( mul( float3x3(appendResult83_g8294, appendResult81_g8294, appendResult82_g8294), temp_output_38_0_g8294 ) - temp_output_38_0_g8294 ) ) , temp_output_1062_498_g8253);
				float3 temp_output_41_0_g8355 = ( ( _WIND_BASE_TRUNK_STRENGTH * lerpResult538_g8289 ) + ( _WIND_LEAF_STRENGTH * float3(0,0,0) ) );
				float temp_output_63_0_g8356 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
				float3 lerpResult57_g8356 = lerp( temp_output_41_0_g8355 , -v.vertex.xyz , ( 1.0 - temp_output_63_0_g8356 ));
				#ifdef INTERNAL_LODFADE_SCALE
				float3 staticSwitch58_g8355 = lerpResult57_g8356;
				#else
				float3 staticSwitch58_g8355 = temp_output_41_0_g8355;
				#endif
				#ifdef LOD_FADE_CROSSFADE
				float3 staticSwitch62_g8355 = staticSwitch58_g8355;
				#else
				float3 staticSwitch62_g8355 = temp_output_41_0_g8355;
				#endif
				
				OctaImpostorVertex( v.vertex, v.normal, o.UVsFrame12401, o.UVsFrame22401, o.UVsFrame32401, o.octaframe2401, o.viewPos2401 );
				
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord10 = screenPos;
				
				o.ase_color = v.color;

				v.vertex.xyz += staticSwitch62_g8355;
				o.pos = UnityObjectToClipPos(v.vertex);

				float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
				float3 viewDirForLight = UnityWorldSpaceViewDir(worldPos);
				#ifndef DIRLIGHTMAP_OFF
					o.viewDir = viewDirForLight;
				#endif
				#ifdef DYNAMICLIGHTMAP_ON
					o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#else
					o.lmap.zw = 0;
				#endif
				#ifdef LIGHTMAP_ON
					o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					#ifdef DIRLIGHTMAP_OFF
						o.lmapFadePos.xyz = (mul(unity_ObjectToWorld, v.vertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w;
						o.lmapFadePos.w = (-UnityObjectToViewPos(v.vertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w);
					#endif
				#else
					o.lmap.xy = 0;
					#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
						o.sh = 0;
						o.sh = ShadeSHPerVertex (worldNormal, o.sh);
					#endif
				#endif
				return o;
			}

			void frag_surf (v2f_surf IN , out half4 outGBuffer0 : SV_Target0, out half4 outGBuffer1 : SV_Target1, out half4 outGBuffer2 : SV_Target2, out half4 outEmission : SV_Target3
			#if defined(SHADOWS_SHADOWMASK) && (UNITY_ALLOWED_MRT_COUNT > 4)
				, out half4 outShadowMask : SV_Target4
			#endif
			, out float outDepth : SV_Depth
			) {
				UNITY_SETUP_INSTANCE_ID(IN);
				#if defined(_SPECULAR_SETUP)
					SurfaceOutputStandardSpecular o = (SurfaceOutputStandardSpecular)0;
				#else
					SurfaceOutputStandard o = (SurfaceOutputStandard)0;
				#endif

				float4 clipPos = 0;
				float3 worldPos = 0;
				float temp_output_88_0_g1926 = _ContrastAdjustment;
				float4 output0 = 0;
				OctaImpostorFragment( o, clipPos, worldPos, IN.UVsFrame12401, IN.UVsFrame22401, IN.UVsFrame32401, IN.octaframe2401, IN.viewPos2401, output0 );
				float4 temp_output_89_0_g1926 = float4( o.Albedo , 0.0 );
				float3 hsvTorgb92_g1926 = RGBToHSV( temp_output_89_0_g1926.rgb );
				float3 hsvTorgb83_g1926 = HSVToRGB( float3(( _HueAdjustment + hsvTorgb92_g1926.x ),( hsvTorgb92_g1926.y + _SaturationAdjustment ),( hsvTorgb92_g1926.z + _BrightnessAdjustment )) );
				float4 appendResult104_g1926 = (float4(CalculateContrast(temp_output_88_0_g1926,float4( hsvTorgb83_g1926 , 0.0 )).rgb , (temp_output_89_0_g1926).a));
				float temp_output_88_0_g1932 = _ContrastAdjustment;
				float4 temp_output_89_0_g1932 = float4( o.Albedo , 0.0 );
				float3 hsvTorgb92_g1932 = RGBToHSV( temp_output_89_0_g1932.rgb );
				float3 hsvTorgb83_g1932 = HSVToRGB( float3(( _HueAdjustment + hsvTorgb92_g1932.x ),( hsvTorgb92_g1932.y + _SaturationAdjustment ),( hsvTorgb92_g1932.z + _BrightnessAdjustment )) );
				float temp_output_2_0_g1934 = _ContrastCorrection;
				float4 appendResult104_g1932 = (float4(CalculateContrast(temp_output_88_0_g1932,( float4( hsvTorgb83_g1932 , 0.0 ) * ( 1.0 / (( temp_output_2_0_g1934 == 0.0 ) ? 1.0 :  temp_output_2_0_g1934 ) ) )).rgb , (temp_output_89_0_g1932).a));
				float temp_output_2424_495 = IN.ase_color.r;
				float temp_output_2431_0 = ( temp_output_2424_495 * _PrimaryRollStrength );
				float4 lerpResult2444 = lerp( saturate( (( _CorrectContrast )?( appendResult104_g1932 ):( appendResult104_g1926 )) ) , saturate( _FadeVariation ) , saturate( ( temp_output_2431_0 * _FadeVariation.a ) ));
				
				float4 break2402 = output0;
				
				float temp_output_41_0_g8349 = o.Alpha;
				float4 screenPos = IN.ase_texcoord10;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float2 clipScreen45_g8350 = ase_screenPosNorm.xy * _ScreenParams.xy;
				float dither45_g8350 = Dither8x8Bayer( fmod(clipScreen45_g8350.x, 8), fmod(clipScreen45_g8350.y, 8) );
				float temp_output_56_0_g8350 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
				dither45_g8350 = step( dither45_g8350, temp_output_56_0_g8350 );
				#ifdef INTERNAL_LODFADE_DITHER
				float staticSwitch50_g8349 = ( temp_output_41_0_g8349 * dither45_g8350 );
				#else
				float staticSwitch50_g8349 = temp_output_41_0_g8349;
				#endif
				#ifdef LOD_FADE_CROSSFADE
				float staticSwitch56_g8349 = staticSwitch50_g8349;
				#else
				float staticSwitch56_g8349 = temp_output_41_0_g8349;
				#endif
				
				fixed3 albedo = saturate( lerpResult2444 ).rgb;
				fixed3 normal = o.Normal;
				half3 emission = half3( 0, 0, 0 );
				fixed3 specular = fixed3( 0, 0, 0 );
				fixed metallic = 0;
				half smoothness = break2402.w;
				half occlusion = break2402.y;
				fixed alpha = staticSwitch56_g8349;
				float4 bakedGI = float4( 0, 0, 0, 0 );
				
				o.Albedo = albedo;
				o.Normal = normal;
				o.Emission = emission;
				#if defined(_SPECULAR_SETUP)
					o.Specular = specular;
				#else
					o.Metallic = metallic;
				#endif
				o.Smoothness = smoothness;
				o.Occlusion = occlusion;
				o.Alpha = alpha;
				clip( o.Alpha );

				IN.pos.zw = clipPos.zw;
				outDepth = IN.pos.z;

				#ifndef USING_DIRECTIONAL_LIGHT
					fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
				#else
					fixed3 lightDir = _WorldSpaceLightPos0.xyz;
				#endif

				fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));

				UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
				half atten = 1;

				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
				gi.indirect.diffuse = 0;
				gi.indirect.specular = 0;
				gi.light.color = 0;
				gi.light.dir = half3(0,1,0);

				UnityGIInput giInput;
				UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
				giInput.light = gi.light;
				giInput.worldPos = worldPos;
				giInput.worldViewDir = worldViewDir;
				giInput.atten = atten;
				#if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
					giInput.lightmapUV = IN.lmap;
				#else
					giInput.lightmapUV = 0.0;
				#endif
				#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
					giInput.ambient = IN.sh;
				#else
					giInput.ambient.rgb = 0.0;
				#endif
				giInput.probeHDR[0] = unity_SpecCube0_HDR;
				giInput.probeHDR[1] = unity_SpecCube1_HDR;
				#if defined(UNITY_SPECCUBE_BLENDING) || defined(UNITY_SPECCUBE_BOX_PROJECTION)
					giInput.boxMin[0] = unity_SpecCube0_BoxMin;
				#endif
				#ifdef UNITY_SPECCUBE_BOX_PROJECTION
					giInput.boxMax[0] = unity_SpecCube0_BoxMax;
					giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
					giInput.boxMax[1] = unity_SpecCube1_BoxMax;
					giInput.boxMin[1] = unity_SpecCube1_BoxMin;
					giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
				#endif

				#if defined(_SPECULAR_SETUP)
					LightingStandardSpecular_GI( o, giInput, gi );
					#if defined(CUSTOM_BAKED_GI)
						gi.indirect.diffuse = DecodeLightmapRGBM( bakedGI, 1 ) * EMISSIVE_RGBM_SCALE;
					#endif
					outEmission = LightingStandardSpecular_Deferred( o, worldViewDir, gi, outGBuffer0, outGBuffer1, outGBuffer2 );
				#else
					LightingStandard_GI( o, giInput, gi );
					#if defined(CUSTOM_BAKED_GI)
						gi.indirect.diffuse = DecodeLightmapRGBM( bakedGI, 1 ) * EMISSIVE_RGBM_SCALE;
					#endif
					outEmission = LightingStandard_Deferred( o, worldViewDir, gi, outGBuffer0, outGBuffer1, outGBuffer2 );
				#endif

				#if defined(SHADOWS_SHADOWMASK) && (UNITY_ALLOWED_MRT_COUNT > 4)
					outShadowMask = UnityGetRawBakedOcclusions (IN.lmap.xy, float3(0, 0, 0));
				#endif
				#ifndef UNITY_HDR_ON
					outEmission.rgb = exp2(-outEmission.rgb);
				#endif
			}
			ENDCG
		}

		Pass
		{
			Name "Meta"
			Tags { "LightMode"="Meta" }
			Cull Off

			CGPROGRAM
#include "UnityCG.cginc"
#include "Assets/Resources/CGIncludes/GPUInstancerInclude.cginc"
#pragma instancing_options procedural:setupGPUI
#pragma multi_compile_instancing
#include "UnityCG.cginc"
			
			#pragma vertex vert_surf
			#pragma fragment frag_surf
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#pragma skip_variants INSTANCING_ON
			#pragma shader_feature EDITOR_VISUALIZATION
			#include "HLSLSupport.cginc"
			#if !defined( UNITY_INSTANCED_LOD_FADE )
				#define UNITY_INSTANCED_LOD_FADE
			#endif
			#if !defined( UNITY_INSTANCED_SH )
				#define UNITY_INSTANCED_SH
			#endif
			#if !defined( UNITY_INSTANCED_LIGHTMAPSTS )
				#define UNITY_INSTANCED_LIGHTMAPSTS
			#endif
			#include "UnityShaderVariables.cginc"
			#include "UnityShaderUtilities.cginc"
			#ifndef UNITY_PASS_META
			#define UNITY_PASS_META
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			#include "UnityStandardUtils.cginc"
			#include "UnityMetaPass.cginc"
			#define ai_ObjectToWorld unity_ObjectToWorld
			#define ai_WorldToObject unity_WorldToObject
			#define AI_INV_TWO_PI  UNITY_INV_TWO_PI
			#define AI_PI          UNITY_PI
			#define AI_INV_PI      UNITY_INV_PI
			#pragma shader_feature EFFECT_HUE_VARIATION
			 





		// INTERNAL_SHADER_FEATURE_START

		// FEATURE_GPU_INSTANCER
		#include "UnityCG.cginc"


		// FEATURE_LODFADE_SCALE
		#define INTERNAL_LODFADE_SCALE
		#pragma multi_compile __ LOD_FADE_CROSSFADE

		// INTERNAL_SHADER_FEATURE_END
			  

			uniform float4 _HueVariation;
			uniform half _WIND_BASE_TRUNK_STRENGTH;
			uniform half _WIND_BASE_TRUNK_FIELD_SIZE;
			uniform half _WIND_BASE_TRUNK_CYCLE_TIME;
			uniform half _WIND_BASE_AMPLITUDE;
			uniform half _WIND_BASE_TO_GUST_RATIO;
			uniform float _PrimaryRollStrength;
			uniform half _WIND_GUST_AMPLITUDE;
			uniform half _WIND_GUST_AUDIO_STRENGTH_LOW;
			uniform half _WIND_AUDIO_INFLUENCE;
			uniform sampler2D _WIND_GUST_TEXTURE;
			uniform half _WIND_GUST_TRUNK_FIELD_SIZE;
			uniform half _WIND_GUST_TRUNK_CYCLE_TIME;
			uniform half _WIND_GUST_CONTRAST;
			uniform float _PrimaryBendStrength;
			uniform half3 _WIND_DIRECTION;
			uniform half _WIND_LEAF_STRENGTH;
			uniform float _CorrectContrast;
			uniform float _ContrastAdjustment;
			uniform float _HueAdjustment;
			uniform float _AI_Frames;
			uniform float _AI_FramesX;
			uniform float _AI_FramesY;
			uniform float _AI_ImpostorSize;
			uniform float _AI_Parallax;
			uniform float3 _AI_Offset;
			uniform float4 _AI_SizeOffset;
			uniform float _AI_TextureBias;
			uniform sampler2D _Albedo;
			uniform sampler2D _Normals;
			uniform float _AI_DepthSize;
			uniform float _AI_ShadowBias;
			uniform float _AI_ShadowView;
			uniform float _AI_Clip;
			uniform float4 _AI_HueVariation;
			uniform sampler2D _WAOTS;
			uniform float _SaturationAdjustment;
			uniform float _BrightnessAdjustment;
			uniform float _ContrastCorrection;
			uniform float4 _FadeVariation;
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
			float2 VectortoHemiOctahedron( float3 N )
			{
				N.xy /= dot( 1.0, abs( N ) );
				return float2( N.x + N.y, N.x - N.y );
			}
			
			float3 HemiOctahedronToVector( float2 Oct )
			{
				Oct = float2( Oct.x + Oct.y, Oct.x - Oct.y ) * 0.5;
				float3 N = float3( Oct, 1 - dot( 1.0, abs( Oct ) ) );
				return normalize( N );
			}
			
			inline void RayPlaneIntersectionUV( float3 normal, float3 rayPosition, float3 rayDirection, inout float2 uvs, inout float3 localNormal )
			{
				float lDotN = dot( rayDirection, normal ); 
				float p0l0DotN = dot( -rayPosition, normal );
				float t = p0l0DotN / lDotN;
				float3 p = rayDirection * t + rayPosition;
				float3 upVector = float3( 0, 1, 0 );
				float3 tangent = normalize( cross( upVector, normal ) + float3( -0.001, 0, 0 ) );
				float3 bitangent = cross( tangent, normal );
				float frameX = dot( p, tangent );
				float frameZ = dot( p, bitangent );
				uvs = -float2( frameX, frameZ );
				if( t <= 0.0 )
				uvs = 0;
				float3x3 worldToLocal = float3x3( tangent, bitangent, normal );
				localNormal = normalize( mul( worldToLocal, rayDirection ) );
			}
			
			inline void OctaImpostorVertex( inout float4 vertex, inout float3 normal, inout float4 uvsFrame1, inout float4 uvsFrame2, inout float4 uvsFrame3, inout float4 octaFrame, inout float4 viewPos )
			{
				float2 uvOffset = _AI_SizeOffset.zw;
				float parallax = -_AI_Parallax; 
				float UVscale = _AI_ImpostorSize;
				float framesXY = _AI_Frames;
				float prevFrame = framesXY - 1;
				float3 fractions = 1.0 / float3( framesXY, prevFrame, UVscale );
				float fractionsFrame = fractions.x;
				float fractionsPrevFrame = fractions.y;
				float fractionsUVscale = fractions.z;
				float3 worldOrigin = 0;
				float4 perspective = float4( 0, 0, 0, 1 );
				if( UNITY_MATRIX_P[ 3 ][ 3 ] == 1 ) 
				{
				perspective = float4( 0, 0, 5000, 0 );
				worldOrigin = ai_ObjectToWorld._m03_m13_m23;
				}
				float3 worldCameraPos = worldOrigin + mul( UNITY_MATRIX_I_V, perspective ).xyz;
				float3 objectCameraPosition = mul( ai_WorldToObject, float4( worldCameraPos, 1 ) ).xyz - _AI_Offset.xyz; 
				float3 objectCameraDirection = normalize( objectCameraPosition );
				float3 upVector = float3( 0,1,0 );
				float3 objectHorizontalVector = normalize( cross( objectCameraDirection, upVector ) );
				float3 objectVerticalVector = cross( objectHorizontalVector, objectCameraDirection );
				float2 uvExpansion = vertex.xy;
				float3 billboard = objectHorizontalVector * uvExpansion.x + objectVerticalVector * uvExpansion.y;
				float3 localDir = billboard - objectCameraPosition; 
				objectCameraDirection.y = max(0.001, objectCameraDirection.y);
				float2 frameOcta = VectortoHemiOctahedron( objectCameraDirection.xzy ) * 0.5 + 0.5;
				float2 prevOctaFrame = frameOcta * prevFrame;
				float2 baseOctaFrame = floor( prevOctaFrame );
				float2 fractionOctaFrame = ( baseOctaFrame * fractionsFrame );
				float2 octaFrame1 = ( baseOctaFrame * fractionsPrevFrame ) * 2.0 - 1.0;
				float3 octa1WorldY = HemiOctahedronToVector( octaFrame1 ).xzy;
				float3 octa1LocalY;
				float2 uvFrame1;
				RayPlaneIntersectionUV( octa1WorldY, objectCameraPosition, localDir, /*inout*/ uvFrame1, /*inout*/ octa1LocalY );
				float2 uvParallax1 = octa1LocalY.xy * fractionsFrame * parallax;
				uvFrame1 = ( uvFrame1 * fractionsUVscale + 0.5 ) * fractionsFrame + fractionOctaFrame;
				uvsFrame1 = float4( uvParallax1, uvFrame1) - float4( 0, 0, uvOffset );
				float2 fractPrevOctaFrame = frac( prevOctaFrame );
				float2 cornerDifference = lerp( float2( 0,1 ) , float2( 1,0 ) , saturate( ceil( ( fractPrevOctaFrame.x - fractPrevOctaFrame.y ) ) ));
				float2 octaFrame2 = ( ( baseOctaFrame + cornerDifference ) * fractionsPrevFrame ) * 2.0 - 1.0;
				float3 octa2WorldY = HemiOctahedronToVector( octaFrame2 ).xzy;
				float3 octa2LocalY;
				float2 uvFrame2;
				RayPlaneIntersectionUV( octa2WorldY, objectCameraPosition, localDir, /*inout*/ uvFrame2, /*inout*/ octa2LocalY );
				float2 uvParallax2 = octa2LocalY.xy * fractionsFrame * parallax;
				uvFrame2 = ( uvFrame2 * fractionsUVscale + 0.5 ) * fractionsFrame + ( ( cornerDifference * fractionsFrame ) + fractionOctaFrame );
				uvsFrame2 = float4( uvParallax2, uvFrame2) - float4( 0, 0, uvOffset );
				float2 octaFrame3 = ( ( baseOctaFrame + 1 ) * fractionsPrevFrame  ) * 2.0 - 1.0;
				float3 octa3WorldY = HemiOctahedronToVector( octaFrame3 ).xzy;
				float3 octa3LocalY;
				float2 uvFrame3;
				RayPlaneIntersectionUV( octa3WorldY, objectCameraPosition, localDir, /*inout*/ uvFrame3, /*inout*/ octa3LocalY );
				float2 uvParallax3 = octa3LocalY.xy * fractionsFrame * parallax;
				uvFrame3 = ( uvFrame3 * fractionsUVscale + 0.5 ) * fractionsFrame + ( fractionOctaFrame + fractionsFrame );
				uvsFrame3 = float4( uvParallax3, uvFrame3) - float4( 0, 0, uvOffset );
				octaFrame = 0;
				octaFrame.xy = prevOctaFrame;
				octaFrame.zw = fractionOctaFrame;
				vertex.xyz = billboard + _AI_Offset.xyz;
				normal.xyz = objectCameraDirection;
				viewPos = 0;
				viewPos.xyz = UnityObjectToViewPos( vertex.xyz );
				#ifdef EFFECT_HUE_VARIATION
				float hueVariationAmount = frac( ai_ObjectToWorld[0].w + ai_ObjectToWorld[1].w + ai_ObjectToWorld[2].w);
				viewPos.w = saturate(hueVariationAmount * _AI_HueVariation.a);
				#endif
			}
			
			inline void OctaImpostorFragment( inout SurfaceOutputStandard o, out float4 clipPos, out float3 worldPos, float4 uvsFrame1, float4 uvsFrame2, float4 uvsFrame3, float4 octaFrame, float4 interpViewPos, out float4 output0 )
			{
				float depthBias = -1.0;
				float textureBias = _AI_TextureBias;
				float4 parallaxSample1 = tex2Dbias( _Normals, float4( uvsFrame1.zw, 0, depthBias) );
				float2 parallax1 = ( ( 0.5 - parallaxSample1.a ) * uvsFrame1.xy ) + uvsFrame1.zw;
				float4 albedo1 = tex2Dbias( _Albedo, float4( parallax1, 0, textureBias) );
				float4 normals1 = tex2Dbias( _Normals, float4( parallax1, 0, textureBias) );
				float4 parallaxSample2 = tex2Dbias( _Normals, float4( uvsFrame2.zw, 0, depthBias) );
				float2 parallax2 = ( ( 0.5 - parallaxSample2.a ) * uvsFrame2.xy ) + uvsFrame2.zw;
				float4 albedo2 = tex2Dbias( _Albedo, float4( parallax2, 0, textureBias) );
				float4 normals2 = tex2Dbias( _Normals, float4( parallax2, 0, textureBias) );
				float4 parallaxSample3 = tex2Dbias( _Normals, float4( uvsFrame3.zw, 0, depthBias) );
				float2 parallax3 = ( ( 0.5 - parallaxSample3.a ) * uvsFrame3.xy ) + uvsFrame3.zw;
				float4 albedo3 = tex2Dbias( _Albedo, float4( parallax3, 0, textureBias) );
				float4 normals3 = tex2Dbias( _Normals, float4( parallax3, 0, textureBias) );
				float2 fraction = frac( octaFrame.xy );
				float2 invFraction = 1 - fraction;
				float3 weights;
				weights.x = min( invFraction.x, invFraction.y );
				weights.y = abs( fraction.x - fraction.y );
				weights.z = min( fraction.x, fraction.y );
				float4 blendedAlbedo = albedo1 * weights.x + albedo2 * weights.y + albedo3 * weights.z;
				float4 blendedNormal = normals1 * weights.x  + normals2 * weights.y + normals3 * weights.z;
				float4 output0a = tex2Dbias( _WAOTS, float4( parallax1, 0, textureBias) ); 
				float4 output0b = tex2Dbias( _WAOTS, float4( parallax2, 0, textureBias) ); 
				float4 output0c = tex2Dbias( _WAOTS, float4( parallax3, 0, textureBias) ); 
				output0 = output0a * weights.x  + output0b * weights.y + output0c * weights.z; 
				float3 localNormal = blendedNormal.rgb * 2.0 - 1.0;
				float3 worldNormal = normalize( mul( (float3x3)ai_ObjectToWorld, localNormal ) );
				float3 viewPos = interpViewPos.xyz;
				float depthOffset = ( ( parallaxSample1.a * weights.x + parallaxSample2.a * weights.y + parallaxSample3.a * weights.z ) - 0.5 /** 2.0 - 1.0*/ ) /** 0.5*/ * _AI_DepthSize * length( ai_ObjectToWorld[ 2 ].xyz );
				#if defined(SHADOWS_DEPTH)
				if( unity_LightShadowBias.y == 1.0 ) 
				{
				viewPos.z += depthOffset * _AI_ShadowView;
				viewPos.z += -_AI_ShadowBias;
				}
				else 
				{
				viewPos.z += depthOffset;
				}
				#else 
				viewPos.z += depthOffset;
				#endif
				worldPos = mul( UNITY_MATRIX_I_V, float4( viewPos.xyz, 1 ) ).xyz;
				clipPos = mul( UNITY_MATRIX_P, float4( viewPos, 1 ) );
				#if defined(SHADOWS_DEPTH)
				clipPos = UnityApplyLinearShadowBias( clipPos );
				#endif
				clipPos.xyz /= clipPos.w;
				if( UNITY_NEAR_CLIP_VALUE < 0 )
				clipPos = clipPos * 0.5 + 0.5;
				#ifdef EFFECT_HUE_VARIATION
				half3 shiftedColor = lerp(blendedAlbedo.rgb, _HueVariation.rgb, interpViewPos.w);
				half maxBase = max(blendedAlbedo.r, max(blendedAlbedo.g, blendedAlbedo.b));
				half newMaxBase = max(shiftedColor.r, max(shiftedColor.g, shiftedColor.b));
				maxBase /= newMaxBase;
				maxBase = maxBase * 0.5f + 0.5f;
				shiftedColor.rgb *= maxBase;
				blendedAlbedo.rgb = saturate(shiftedColor);
				#endif
				float t = ceil( fraction.x - fraction.y );
				float4 cornerDifference = float4( t, 1 - t, 1, 1 );
				float2 step_1 = ( parallax1 - octaFrame.zw ) * _AI_Frames;
				float4 step23 = ( float4( parallax2, parallax3 ) -  octaFrame.zwzw ) * _AI_Frames - cornerDifference;
				step_1 = step_1 * (1-step_1);
				step23 = step23 * (1-step23);
				float3 steps;
				steps.x = step_1.x * step_1.y;
				steps.y = step23.x * step23.y;
				steps.z = step23.z * step23.w;
				steps = step(-steps, 0);
				float final = dot( steps, weights );
				clip( final - 0.5 );
				o.Albedo = blendedAlbedo.rgb;
				o.Normal = worldNormal;
				o.Alpha = ( blendedAlbedo.a - _AI_Clip );
				clip( o.Alpha );
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
			

			/*struct appdata_full {
				float4 vertex : POSITION;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				fixed4 color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID*/
			
			/*};*/

			struct v2f_surf {
				UNITY_POSITION(pos);
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 UVsFrame12401 : TEXCOORD5;
				float4 UVsFrame22401 : TEXCOORD6;
				float4 UVsFrame32401 : TEXCOORD7;
				float4 octaframe2401 : TEXCOORD8;
				float4 viewPos2401 : TEXCOORD9;
				float4 ase_color : COLOR;
				float4 ase_texcoord10 : TEXCOORD10;
			};

			v2f_surf vert_surf (appdata_full v ) {
				UNITY_SETUP_INSTANCE_ID(v);
				v2f_surf o;
				UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
				UNITY_TRANSFER_INSTANCE_ID(v,o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				half localunity_ObjectToWorld0w1_g8346 = ( unity_ObjectToWorld[0].w );
				half localunity_ObjectToWorld1w2_g8346 = ( unity_ObjectToWorld[1].w );
				half localunity_ObjectToWorld2w3_g8346 = ( unity_ObjectToWorld[2].w );
				float3 appendResult6_g8346 = (float3(localunity_ObjectToWorld0w1_g8346 , localunity_ObjectToWorld1w2_g8346 , localunity_ObjectToWorld2w3_g8346));
				float3 temp_output_1062_510_g8253 = appendResult6_g8346;
				float2 temp_output_1_0_g8295 = (temp_output_1062_510_g8253).xz;
				float temp_output_2_0_g8300 = _WIND_BASE_TRUNK_FIELD_SIZE;
				float2 temp_cast_0 = (( 1.0 / (( temp_output_2_0_g8300 == 0.0 ) ? 1.0 :  temp_output_2_0_g8300 ) )).xx;
				float2 temp_output_2_0_g8295 = temp_cast_0;
				float2 temp_output_704_0_g8289 = ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g8295 / temp_output_2_0_g8295 ) :  ( temp_output_1_0_g8295 * temp_output_2_0_g8295 ) ) + float2( 0,0 ) );
				float temp_output_2_0_g8259 = _WIND_BASE_TRUNK_CYCLE_TIME;
				float temp_output_618_0_g8289 = ( 1.0 / (( temp_output_2_0_g8259 == 0.0 ) ? 1.0 :  temp_output_2_0_g8259 ) );
				float2 break298_g8296 = ( temp_output_704_0_g8289 + ( temp_output_618_0_g8289 * ( _Time.y + 0.0 ) ) );
				float2 appendResult299_g8296 = (float2(sin( break298_g8296.x ) , cos( break298_g8296.y )));
				float4 temp_output_273_0_g8296 = (-1.0).xxxx;
				float4 temp_output_271_0_g8296 = (1.0).xxxx;
				float2 clampResult26_g8296 = clamp( appendResult299_g8296 , temp_output_273_0_g8296.xy , temp_output_271_0_g8296.xy );
				float temp_output_1062_495_g8253 = _WIND_BASE_AMPLITUDE;
				float temp_output_1062_501_g8253 = _WIND_BASE_TO_GUST_RATIO;
				float temp_output_524_0_g8289 = ( temp_output_1062_495_g8253 * temp_output_1062_501_g8253 );
				float2 TRUNK_PIVOT_ROCKING701_g8289 = ( clampResult26_g8296 * temp_output_524_0_g8289 );
				float temp_output_2424_495 = v.color.r;
				float temp_output_2431_0 = ( temp_output_2424_495 * _PrimaryRollStrength );
				float _WIND_PRIMARY_ROLL669_g8289 = temp_output_2431_0;
				float temp_output_54_0_g8304 = ( TRUNK_PIVOT_ROCKING701_g8289 * 0.05 * _WIND_PRIMARY_ROLL669_g8289 ).x;
				float temp_output_72_0_g8304 = cos( temp_output_54_0_g8304 );
				float one_minus_c52_g8304 = ( 1.0 - temp_output_72_0_g8304 );
				float3 break70_g8304 = float3(0,1,0);
				float axis_x25_g8304 = break70_g8304.x;
				float c66_g8304 = temp_output_72_0_g8304;
				float axis_y37_g8304 = break70_g8304.y;
				float axis_z29_g8304 = break70_g8304.z;
				float s67_g8304 = sin( temp_output_54_0_g8304 );
				float3 appendResult83_g8304 = (float3(( ( one_minus_c52_g8304 * axis_x25_g8304 * axis_x25_g8304 ) + c66_g8304 ) , ( ( one_minus_c52_g8304 * axis_x25_g8304 * axis_y37_g8304 ) - ( axis_z29_g8304 * s67_g8304 ) ) , ( ( one_minus_c52_g8304 * axis_z29_g8304 * axis_x25_g8304 ) + ( axis_y37_g8304 * s67_g8304 ) )));
				float3 appendResult81_g8304 = (float3(( ( one_minus_c52_g8304 * axis_x25_g8304 * axis_y37_g8304 ) + ( axis_z29_g8304 * s67_g8304 ) ) , ( ( one_minus_c52_g8304 * axis_y37_g8304 * axis_y37_g8304 ) + c66_g8304 ) , ( ( one_minus_c52_g8304 * axis_y37_g8304 * axis_z29_g8304 ) - ( axis_x25_g8304 * s67_g8304 ) )));
				float3 appendResult82_g8304 = (float3(( ( one_minus_c52_g8304 * axis_z29_g8304 * axis_x25_g8304 ) - ( axis_y37_g8304 * s67_g8304 ) ) , ( ( one_minus_c52_g8304 * axis_y37_g8304 * axis_z29_g8304 ) + ( axis_x25_g8304 * s67_g8304 ) ) , ( ( one_minus_c52_g8304 * axis_z29_g8304 * axis_z29_g8304 ) + c66_g8304 )));
				float3 _WIND_PRIMARY_PIVOT655_g8289 = float3(0,1,0);
				float3 temp_output_38_0_g8304 = ( v.vertex.xyz - (_WIND_PRIMARY_PIVOT655_g8289).xyz );
				float2 break298_g8290 = ( temp_output_704_0_g8289 + ( temp_output_618_0_g8289 * ( _Time.y + 0.0 ) ) );
				float2 appendResult299_g8290 = (float2(sin( break298_g8290.x ) , cos( break298_g8290.y )));
				float4 temp_output_273_0_g8290 = (-1.0).xxxx;
				float4 temp_output_271_0_g8290 = (1.0).xxxx;
				float2 clampResult26_g8290 = clamp( appendResult299_g8290 , temp_output_273_0_g8290.xy , temp_output_271_0_g8290.xy );
				float2 TRUNK_SWIRL700_g8289 = ( clampResult26_g8290 * temp_output_524_0_g8289 );
				float2 break699_g8289 = TRUNK_SWIRL700_g8289;
				float3 appendResult698_g8289 = (float3(break699_g8289.x , 0.0 , break699_g8289.y));
				float3 temp_output_694_0_g8289 = ( ( mul( float3x3(appendResult83_g8304, appendResult81_g8304, appendResult82_g8304), temp_output_38_0_g8304 ) - temp_output_38_0_g8304 ) + ( _WIND_PRIMARY_ROLL669_g8289 * appendResult698_g8289 * 0.5 ) );
				float lerpResult635_g8347 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_LOW , _WIND_AUDIO_INFLUENCE);
				float4 color658_g8306 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
				float2 temp_output_61_0_g8311 = float2( 0,0 );
				half localunity_ObjectToWorld0w1_g8324 = ( unity_ObjectToWorld[0].w );
				half localunity_ObjectToWorld1w2_g8324 = ( unity_ObjectToWorld[1].w );
				half localunity_ObjectToWorld2w3_g8324 = ( unity_ObjectToWorld[2].w );
				float3 appendResult6_g8324 = (float3(localunity_ObjectToWorld0w1_g8324 , localunity_ObjectToWorld1w2_g8324 , localunity_ObjectToWorld2w3_g8324));
				float2 temp_output_1_0_g8312 = (appendResult6_g8324).xz;
				float temp_output_2_0_g8318 = _WIND_GUST_TRUNK_FIELD_SIZE;
				float temp_output_40_0_g8311 = ( 1.0 / (( temp_output_2_0_g8318 == 0.0 ) ? 1.0 :  temp_output_2_0_g8318 ) );
				float2 temp_cast_6 = (temp_output_40_0_g8311).xx;
				float2 temp_output_2_0_g8312 = temp_cast_6;
				float temp_output_2_0_g8307 = _WIND_GUST_TRUNK_CYCLE_TIME;
				float mulTime37_g8311 = _Time.y * ( 1.0 / (( temp_output_2_0_g8307 == 0.0 ) ? 1.0 :  temp_output_2_0_g8307 ) );
				float temp_output_220_0_g8314 = -1.0;
				float4 temp_cast_7 = (temp_output_220_0_g8314).xxxx;
				float temp_output_219_0_g8314 = 1.0;
				float4 temp_cast_8 = (temp_output_219_0_g8314).xxxx;
				float4 clampResult26_g8314 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g8311 > float2( 0,0 ) ) ? ( temp_output_1_0_g8312 / temp_output_2_0_g8312 ) :  ( temp_output_1_0_g8312 * temp_output_2_0_g8312 ) ) + temp_output_61_0_g8311 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g8311 ) ) , temp_cast_7 , temp_cast_8 );
				float4 temp_cast_9 = (temp_output_220_0_g8314).xxxx;
				float4 temp_cast_10 = (temp_output_219_0_g8314).xxxx;
				float4 temp_cast_11 = (0.0).xxxx;
				float4 temp_cast_12 = (temp_output_219_0_g8314).xxxx;
				float temp_output_1072_526_g8253 = _WIND_GUST_CONTRAST;
				float4 temp_cast_13 = (temp_output_1072_526_g8253).xxxx;
				float4 temp_output_52_0_g8311 = saturate( pow( abs( (temp_cast_11 + (clampResult26_g8314 - temp_cast_9) * (temp_cast_12 - temp_cast_11) / (temp_cast_10 - temp_cast_9)) ) , temp_cast_13 ) );
				float temp_output_679_0_g8306 = 1.0;
				float4 lerpResult656_g8306 = lerp( color658_g8306 , temp_output_52_0_g8311 , temp_output_679_0_g8306);
				float _WIND_GUST_STRENGTH703_g8289 = ( (lerpResult635_g8347).xxxx * lerpResult656_g8306 ).x;
				float _WIND_PRIMARY_BEND662_g8289 = ( temp_output_2424_495 * _PrimaryBendStrength );
				float temp_output_54_0_g8294 = ( ( _WIND_GUST_STRENGTH703_g8289 * -1.0 ) * _WIND_PRIMARY_BEND662_g8289 );
				float temp_output_72_0_g8294 = cos( temp_output_54_0_g8294 );
				float one_minus_c52_g8294 = ( 1.0 - temp_output_72_0_g8294 );
				float3 temp_output_1062_494_g8253 = _WIND_DIRECTION;
				float3 _WIND_DIRECTION671_g8289 = temp_output_1062_494_g8253;
				float3 worldToObjDir719_g8289 = mul( unity_WorldToObject, float4( cross( _WIND_DIRECTION671_g8289 , float3(0,1,0) ), 0 ) ).xyz;
				float3 break70_g8294 = worldToObjDir719_g8289;
				float axis_x25_g8294 = break70_g8294.x;
				float c66_g8294 = temp_output_72_0_g8294;
				float axis_y37_g8294 = break70_g8294.y;
				float axis_z29_g8294 = break70_g8294.z;
				float s67_g8294 = sin( temp_output_54_0_g8294 );
				float3 appendResult83_g8294 = (float3(( ( one_minus_c52_g8294 * axis_x25_g8294 * axis_x25_g8294 ) + c66_g8294 ) , ( ( one_minus_c52_g8294 * axis_x25_g8294 * axis_y37_g8294 ) - ( axis_z29_g8294 * s67_g8294 ) ) , ( ( one_minus_c52_g8294 * axis_z29_g8294 * axis_x25_g8294 ) + ( axis_y37_g8294 * s67_g8294 ) )));
				float3 appendResult81_g8294 = (float3(( ( one_minus_c52_g8294 * axis_x25_g8294 * axis_y37_g8294 ) + ( axis_z29_g8294 * s67_g8294 ) ) , ( ( one_minus_c52_g8294 * axis_y37_g8294 * axis_y37_g8294 ) + c66_g8294 ) , ( ( one_minus_c52_g8294 * axis_y37_g8294 * axis_z29_g8294 ) - ( axis_x25_g8294 * s67_g8294 ) )));
				float3 appendResult82_g8294 = (float3(( ( one_minus_c52_g8294 * axis_z29_g8294 * axis_x25_g8294 ) - ( axis_y37_g8294 * s67_g8294 ) ) , ( ( one_minus_c52_g8294 * axis_y37_g8294 * axis_z29_g8294 ) + ( axis_x25_g8294 * s67_g8294 ) ) , ( ( one_minus_c52_g8294 * axis_z29_g8294 * axis_z29_g8294 ) + c66_g8294 )));
				float3 temp_output_38_0_g8294 = ( v.vertex.xyz - (_WIND_PRIMARY_PIVOT655_g8289).xyz );
				float temp_output_1062_498_g8253 = _WIND_GUST_AMPLITUDE;
				float3 lerpResult538_g8289 = lerp( temp_output_694_0_g8289 , ( temp_output_694_0_g8289 + ( mul( float3x3(appendResult83_g8294, appendResult81_g8294, appendResult82_g8294), temp_output_38_0_g8294 ) - temp_output_38_0_g8294 ) ) , temp_output_1062_498_g8253);
				float3 temp_output_41_0_g8355 = ( ( _WIND_BASE_TRUNK_STRENGTH * lerpResult538_g8289 ) + ( _WIND_LEAF_STRENGTH * float3(0,0,0) ) );
				float temp_output_63_0_g8356 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
				float3 lerpResult57_g8356 = lerp( temp_output_41_0_g8355 , -v.vertex.xyz , ( 1.0 - temp_output_63_0_g8356 ));
				#ifdef INTERNAL_LODFADE_SCALE
				float3 staticSwitch58_g8355 = lerpResult57_g8356;
				#else
				float3 staticSwitch58_g8355 = temp_output_41_0_g8355;
				#endif
				#ifdef LOD_FADE_CROSSFADE
				float3 staticSwitch62_g8355 = staticSwitch58_g8355;
				#else
				float3 staticSwitch62_g8355 = temp_output_41_0_g8355;
				#endif
				
				OctaImpostorVertex( v.vertex, v.normal, o.UVsFrame12401, o.UVsFrame22401, o.UVsFrame32401, o.octaframe2401, o.viewPos2401 );
				
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord10 = screenPos;
				
				o.ase_color = v.color;

				v.vertex.xyz += staticSwitch62_g8355;
				o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST);

				return o;
			}

			fixed4 frag_surf (v2f_surf IN, out float outDepth : SV_Depth  ) : SV_Target {
				UNITY_SETUP_INSTANCE_ID(IN);
				#if defined(_SPECULAR_SETUP)
					SurfaceOutputStandardSpecular o = (SurfaceOutputStandardSpecular)0;
				#else
					SurfaceOutputStandard o = (SurfaceOutputStandard)0;
				#endif

				float4 clipPos = 0;
				float3 worldPos = 0;
				float temp_output_88_0_g1926 = _ContrastAdjustment;
				float4 output0 = 0;
				OctaImpostorFragment( o, clipPos, worldPos, IN.UVsFrame12401, IN.UVsFrame22401, IN.UVsFrame32401, IN.octaframe2401, IN.viewPos2401, output0 );
				float4 temp_output_89_0_g1926 = float4( o.Albedo , 0.0 );
				float3 hsvTorgb92_g1926 = RGBToHSV( temp_output_89_0_g1926.rgb );
				float3 hsvTorgb83_g1926 = HSVToRGB( float3(( _HueAdjustment + hsvTorgb92_g1926.x ),( hsvTorgb92_g1926.y + _SaturationAdjustment ),( hsvTorgb92_g1926.z + _BrightnessAdjustment )) );
				float4 appendResult104_g1926 = (float4(CalculateContrast(temp_output_88_0_g1926,float4( hsvTorgb83_g1926 , 0.0 )).rgb , (temp_output_89_0_g1926).a));
				float temp_output_88_0_g1932 = _ContrastAdjustment;
				float4 temp_output_89_0_g1932 = float4( o.Albedo , 0.0 );
				float3 hsvTorgb92_g1932 = RGBToHSV( temp_output_89_0_g1932.rgb );
				float3 hsvTorgb83_g1932 = HSVToRGB( float3(( _HueAdjustment + hsvTorgb92_g1932.x ),( hsvTorgb92_g1932.y + _SaturationAdjustment ),( hsvTorgb92_g1932.z + _BrightnessAdjustment )) );
				float temp_output_2_0_g1934 = _ContrastCorrection;
				float4 appendResult104_g1932 = (float4(CalculateContrast(temp_output_88_0_g1932,( float4( hsvTorgb83_g1932 , 0.0 ) * ( 1.0 / (( temp_output_2_0_g1934 == 0.0 ) ? 1.0 :  temp_output_2_0_g1934 ) ) )).rgb , (temp_output_89_0_g1932).a));
				float temp_output_2424_495 = IN.ase_color.r;
				float temp_output_2431_0 = ( temp_output_2424_495 * _PrimaryRollStrength );
				float4 lerpResult2444 = lerp( saturate( (( _CorrectContrast )?( appendResult104_g1932 ):( appendResult104_g1926 )) ) , saturate( _FadeVariation ) , saturate( ( temp_output_2431_0 * _FadeVariation.a ) ));
				
				float4 break2402 = output0;
				
				float temp_output_41_0_g8349 = o.Alpha;
				float4 screenPos = IN.ase_texcoord10;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float2 clipScreen45_g8350 = ase_screenPosNorm.xy * _ScreenParams.xy;
				float dither45_g8350 = Dither8x8Bayer( fmod(clipScreen45_g8350.x, 8), fmod(clipScreen45_g8350.y, 8) );
				float temp_output_56_0_g8350 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
				dither45_g8350 = step( dither45_g8350, temp_output_56_0_g8350 );
				#ifdef INTERNAL_LODFADE_DITHER
				float staticSwitch50_g8349 = ( temp_output_41_0_g8349 * dither45_g8350 );
				#else
				float staticSwitch50_g8349 = temp_output_41_0_g8349;
				#endif
				#ifdef LOD_FADE_CROSSFADE
				float staticSwitch56_g8349 = staticSwitch50_g8349;
				#else
				float staticSwitch56_g8349 = temp_output_41_0_g8349;
				#endif
				
				fixed3 albedo = saturate( lerpResult2444 ).rgb;
				fixed3 normal = o.Normal;
				half3 emission = half3( 0, 0, 0 );
				fixed3 specular = fixed3( 0, 0, 0 );
				fixed metallic = 0;
				half smoothness = break2402.w;
				half occlusion = break2402.y;
				fixed alpha = staticSwitch56_g8349;

				o.Albedo = albedo;
				o.Normal = normal;
				o.Emission = emission;
				#if defined(_SPECULAR_SETUP)
					o.Specular = specular;
				#else
					o.Metallic = metallic;
				#endif
				o.Smoothness = smoothness;
				o.Occlusion = occlusion;
				o.Alpha = alpha;
				clip(o.Alpha);

				IN.pos.zw = clipPos.zw;
				outDepth = IN.pos.z;

				#ifndef USING_DIRECTIONAL_LIGHT
					fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
				#else
					fixed3 lightDir = _WorldSpaceLightPos0.xyz;
				#endif

				fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));

				UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
				UnityMetaInput metaIN;
				UNITY_INITIALIZE_OUTPUT(UnityMetaInput, metaIN);
				metaIN.Albedo = o.Albedo;
				metaIN.Emission = o.Emission;
				return UnityMetaFragment(metaIN);
			}
			ENDCG
		}

		Pass
		{
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }
			ZWrite On

			CGPROGRAM
#include "UnityCG.cginc"
#include "Assets/Resources/CGIncludes/GPUInstancerInclude.cginc"
#pragma instancing_options procedural:setupGPUI
#pragma multi_compile_instancing
#include "UnityCG.cginc"
			
			#pragma vertex vert_surf
			#pragma fragment frag_surf
			#pragma multi_compile_shadowcaster
			#pragma multi_compile __ LOD_FADE_CROSSFADE
			#ifndef UNITY_PASS_SHADOWCASTER
			#define UNITY_PASS_SHADOWCASTER
			#endif
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if !defined( UNITY_INSTANCED_LOD_FADE )
				#define UNITY_INSTANCED_LOD_FADE
			#endif
			#include "UnityShaderVariables.cginc"
			#include "UnityShaderUtilities.cginc"
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			#include "UnityStandardUtils.cginc"
			#define ai_ObjectToWorld unity_ObjectToWorld
			#define ai_WorldToObject unity_WorldToObject
			#define AI_INV_TWO_PI  UNITY_INV_TWO_PI
			#define AI_PI          UNITY_PI
			#define AI_INV_PI      UNITY_INV_PI
			#pragma shader_feature EFFECT_HUE_VARIATION
			 





		// INTERNAL_SHADER_FEATURE_START

		// FEATURE_GPU_INSTANCER
		#include "UnityCG.cginc"


		// FEATURE_LODFADE_SCALE
		#define INTERNAL_LODFADE_SCALE
		#pragma multi_compile __ LOD_FADE_CROSSFADE

		// INTERNAL_SHADER_FEATURE_END
			  

			uniform float4 _HueVariation;
			uniform half _WIND_BASE_TRUNK_STRENGTH;
			uniform half _WIND_BASE_TRUNK_FIELD_SIZE;
			uniform half _WIND_BASE_TRUNK_CYCLE_TIME;
			uniform half _WIND_BASE_AMPLITUDE;
			uniform half _WIND_BASE_TO_GUST_RATIO;
			uniform float _PrimaryRollStrength;
			uniform half _WIND_GUST_AMPLITUDE;
			uniform half _WIND_GUST_AUDIO_STRENGTH_LOW;
			uniform half _WIND_AUDIO_INFLUENCE;
			uniform sampler2D _WIND_GUST_TEXTURE;
			uniform half _WIND_GUST_TRUNK_FIELD_SIZE;
			uniform half _WIND_GUST_TRUNK_CYCLE_TIME;
			uniform half _WIND_GUST_CONTRAST;
			uniform float _PrimaryBendStrength;
			uniform half3 _WIND_DIRECTION;
			uniform half _WIND_LEAF_STRENGTH;
			uniform float _CorrectContrast;
			uniform float _ContrastAdjustment;
			uniform float _HueAdjustment;
			uniform float _AI_Frames;
			uniform float _AI_FramesX;
			uniform float _AI_FramesY;
			uniform float _AI_ImpostorSize;
			uniform float _AI_Parallax;
			uniform float3 _AI_Offset;
			uniform float4 _AI_SizeOffset;
			uniform float _AI_TextureBias;
			uniform sampler2D _Albedo;
			uniform sampler2D _Normals;
			uniform float _AI_DepthSize;
			uniform float _AI_ShadowBias;
			uniform float _AI_ShadowView;
			uniform float _AI_Clip;
			uniform float4 _AI_HueVariation;
			uniform sampler2D _WAOTS;
			uniform float _SaturationAdjustment;
			uniform float _BrightnessAdjustment;
			uniform float _ContrastCorrection;
			uniform float4 _FadeVariation;
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
			float2 VectortoHemiOctahedron( float3 N )
			{
				N.xy /= dot( 1.0, abs( N ) );
				return float2( N.x + N.y, N.x - N.y );
			}
			
			float3 HemiOctahedronToVector( float2 Oct )
			{
				Oct = float2( Oct.x + Oct.y, Oct.x - Oct.y ) * 0.5;
				float3 N = float3( Oct, 1 - dot( 1.0, abs( Oct ) ) );
				return normalize( N );
			}
			
			inline void RayPlaneIntersectionUV( float3 normal, float3 rayPosition, float3 rayDirection, inout float2 uvs, inout float3 localNormal )
			{
				float lDotN = dot( rayDirection, normal ); 
				float p0l0DotN = dot( -rayPosition, normal );
				float t = p0l0DotN / lDotN;
				float3 p = rayDirection * t + rayPosition;
				float3 upVector = float3( 0, 1, 0 );
				float3 tangent = normalize( cross( upVector, normal ) + float3( -0.001, 0, 0 ) );
				float3 bitangent = cross( tangent, normal );
				float frameX = dot( p, tangent );
				float frameZ = dot( p, bitangent );
				uvs = -float2( frameX, frameZ );
				if( t <= 0.0 )
				uvs = 0;
				float3x3 worldToLocal = float3x3( tangent, bitangent, normal );
				localNormal = normalize( mul( worldToLocal, rayDirection ) );
			}
			
			inline void OctaImpostorVertex( inout float4 vertex, inout float3 normal, inout float4 uvsFrame1, inout float4 uvsFrame2, inout float4 uvsFrame3, inout float4 octaFrame, inout float4 viewPos )
			{
				float2 uvOffset = _AI_SizeOffset.zw;
				float parallax = -_AI_Parallax; 
				float UVscale = _AI_ImpostorSize;
				float framesXY = _AI_Frames;
				float prevFrame = framesXY - 1;
				float3 fractions = 1.0 / float3( framesXY, prevFrame, UVscale );
				float fractionsFrame = fractions.x;
				float fractionsPrevFrame = fractions.y;
				float fractionsUVscale = fractions.z;
				float3 worldOrigin = 0;
				float4 perspective = float4( 0, 0, 0, 1 );
				if( UNITY_MATRIX_P[ 3 ][ 3 ] == 1 ) 
				{
				perspective = float4( 0, 0, 5000, 0 );
				worldOrigin = ai_ObjectToWorld._m03_m13_m23;
				}
				float3 worldCameraPos = worldOrigin + mul( UNITY_MATRIX_I_V, perspective ).xyz;
				float3 objectCameraPosition = mul( ai_WorldToObject, float4( worldCameraPos, 1 ) ).xyz - _AI_Offset.xyz; 
				float3 objectCameraDirection = normalize( objectCameraPosition );
				float3 upVector = float3( 0,1,0 );
				float3 objectHorizontalVector = normalize( cross( objectCameraDirection, upVector ) );
				float3 objectVerticalVector = cross( objectHorizontalVector, objectCameraDirection );
				float2 uvExpansion = vertex.xy;
				float3 billboard = objectHorizontalVector * uvExpansion.x + objectVerticalVector * uvExpansion.y;
				float3 localDir = billboard - objectCameraPosition; 
				objectCameraDirection.y = max(0.001, objectCameraDirection.y);
				float2 frameOcta = VectortoHemiOctahedron( objectCameraDirection.xzy ) * 0.5 + 0.5;
				float2 prevOctaFrame = frameOcta * prevFrame;
				float2 baseOctaFrame = floor( prevOctaFrame );
				float2 fractionOctaFrame = ( baseOctaFrame * fractionsFrame );
				float2 octaFrame1 = ( baseOctaFrame * fractionsPrevFrame ) * 2.0 - 1.0;
				float3 octa1WorldY = HemiOctahedronToVector( octaFrame1 ).xzy;
				float3 octa1LocalY;
				float2 uvFrame1;
				RayPlaneIntersectionUV( octa1WorldY, objectCameraPosition, localDir, /*inout*/ uvFrame1, /*inout*/ octa1LocalY );
				float2 uvParallax1 = octa1LocalY.xy * fractionsFrame * parallax;
				uvFrame1 = ( uvFrame1 * fractionsUVscale + 0.5 ) * fractionsFrame + fractionOctaFrame;
				uvsFrame1 = float4( uvParallax1, uvFrame1) - float4( 0, 0, uvOffset );
				float2 fractPrevOctaFrame = frac( prevOctaFrame );
				float2 cornerDifference = lerp( float2( 0,1 ) , float2( 1,0 ) , saturate( ceil( ( fractPrevOctaFrame.x - fractPrevOctaFrame.y ) ) ));
				float2 octaFrame2 = ( ( baseOctaFrame + cornerDifference ) * fractionsPrevFrame ) * 2.0 - 1.0;
				float3 octa2WorldY = HemiOctahedronToVector( octaFrame2 ).xzy;
				float3 octa2LocalY;
				float2 uvFrame2;
				RayPlaneIntersectionUV( octa2WorldY, objectCameraPosition, localDir, /*inout*/ uvFrame2, /*inout*/ octa2LocalY );
				float2 uvParallax2 = octa2LocalY.xy * fractionsFrame * parallax;
				uvFrame2 = ( uvFrame2 * fractionsUVscale + 0.5 ) * fractionsFrame + ( ( cornerDifference * fractionsFrame ) + fractionOctaFrame );
				uvsFrame2 = float4( uvParallax2, uvFrame2) - float4( 0, 0, uvOffset );
				float2 octaFrame3 = ( ( baseOctaFrame + 1 ) * fractionsPrevFrame  ) * 2.0 - 1.0;
				float3 octa3WorldY = HemiOctahedronToVector( octaFrame3 ).xzy;
				float3 octa3LocalY;
				float2 uvFrame3;
				RayPlaneIntersectionUV( octa3WorldY, objectCameraPosition, localDir, /*inout*/ uvFrame3, /*inout*/ octa3LocalY );
				float2 uvParallax3 = octa3LocalY.xy * fractionsFrame * parallax;
				uvFrame3 = ( uvFrame3 * fractionsUVscale + 0.5 ) * fractionsFrame + ( fractionOctaFrame + fractionsFrame );
				uvsFrame3 = float4( uvParallax3, uvFrame3) - float4( 0, 0, uvOffset );
				octaFrame = 0;
				octaFrame.xy = prevOctaFrame;
				octaFrame.zw = fractionOctaFrame;
				vertex.xyz = billboard + _AI_Offset.xyz;
				normal.xyz = objectCameraDirection;
				viewPos = 0;
				viewPos.xyz = UnityObjectToViewPos( vertex.xyz );
				#ifdef EFFECT_HUE_VARIATION
				float hueVariationAmount = frac( ai_ObjectToWorld[0].w + ai_ObjectToWorld[1].w + ai_ObjectToWorld[2].w);
				viewPos.w = saturate(hueVariationAmount * _AI_HueVariation.a);
				#endif
			}
			
			inline void OctaImpostorFragment( inout SurfaceOutputStandard o, out float4 clipPos, out float3 worldPos, float4 uvsFrame1, float4 uvsFrame2, float4 uvsFrame3, float4 octaFrame, float4 interpViewPos, out float4 output0 )
			{
				float depthBias = -1.0;
				float textureBias = _AI_TextureBias;
				float4 parallaxSample1 = tex2Dbias( _Normals, float4( uvsFrame1.zw, 0, depthBias) );
				float2 parallax1 = ( ( 0.5 - parallaxSample1.a ) * uvsFrame1.xy ) + uvsFrame1.zw;
				float4 albedo1 = tex2Dbias( _Albedo, float4( parallax1, 0, textureBias) );
				float4 normals1 = tex2Dbias( _Normals, float4( parallax1, 0, textureBias) );
				float4 parallaxSample2 = tex2Dbias( _Normals, float4( uvsFrame2.zw, 0, depthBias) );
				float2 parallax2 = ( ( 0.5 - parallaxSample2.a ) * uvsFrame2.xy ) + uvsFrame2.zw;
				float4 albedo2 = tex2Dbias( _Albedo, float4( parallax2, 0, textureBias) );
				float4 normals2 = tex2Dbias( _Normals, float4( parallax2, 0, textureBias) );
				float4 parallaxSample3 = tex2Dbias( _Normals, float4( uvsFrame3.zw, 0, depthBias) );
				float2 parallax3 = ( ( 0.5 - parallaxSample3.a ) * uvsFrame3.xy ) + uvsFrame3.zw;
				float4 albedo3 = tex2Dbias( _Albedo, float4( parallax3, 0, textureBias) );
				float4 normals3 = tex2Dbias( _Normals, float4( parallax3, 0, textureBias) );
				float2 fraction = frac( octaFrame.xy );
				float2 invFraction = 1 - fraction;
				float3 weights;
				weights.x = min( invFraction.x, invFraction.y );
				weights.y = abs( fraction.x - fraction.y );
				weights.z = min( fraction.x, fraction.y );
				float4 blendedAlbedo = albedo1 * weights.x + albedo2 * weights.y + albedo3 * weights.z;
				float4 blendedNormal = normals1 * weights.x  + normals2 * weights.y + normals3 * weights.z;
				float4 output0a = tex2Dbias( _WAOTS, float4( parallax1, 0, textureBias) ); 
				float4 output0b = tex2Dbias( _WAOTS, float4( parallax2, 0, textureBias) ); 
				float4 output0c = tex2Dbias( _WAOTS, float4( parallax3, 0, textureBias) ); 
				output0 = output0a * weights.x  + output0b * weights.y + output0c * weights.z; 
				float3 localNormal = blendedNormal.rgb * 2.0 - 1.0;
				float3 worldNormal = normalize( mul( (float3x3)ai_ObjectToWorld, localNormal ) );
				float3 viewPos = interpViewPos.xyz;
				float depthOffset = ( ( parallaxSample1.a * weights.x + parallaxSample2.a * weights.y + parallaxSample3.a * weights.z ) - 0.5 /** 2.0 - 1.0*/ ) /** 0.5*/ * _AI_DepthSize * length( ai_ObjectToWorld[ 2 ].xyz );
				#if defined(SHADOWS_DEPTH)
				if( unity_LightShadowBias.y == 1.0 ) 
				{
				viewPos.z += depthOffset * _AI_ShadowView;
				viewPos.z += -_AI_ShadowBias;
				}
				else 
				{
				viewPos.z += depthOffset;
				}
				#else 
				viewPos.z += depthOffset;
				#endif
				worldPos = mul( UNITY_MATRIX_I_V, float4( viewPos.xyz, 1 ) ).xyz;
				clipPos = mul( UNITY_MATRIX_P, float4( viewPos, 1 ) );
				#if defined(SHADOWS_DEPTH)
				clipPos = UnityApplyLinearShadowBias( clipPos );
				#endif
				clipPos.xyz /= clipPos.w;
				if( UNITY_NEAR_CLIP_VALUE < 0 )
				clipPos = clipPos * 0.5 + 0.5;
				#ifdef EFFECT_HUE_VARIATION
				half3 shiftedColor = lerp(blendedAlbedo.rgb, _HueVariation.rgb, interpViewPos.w);
				half maxBase = max(blendedAlbedo.r, max(blendedAlbedo.g, blendedAlbedo.b));
				half newMaxBase = max(shiftedColor.r, max(shiftedColor.g, shiftedColor.b));
				maxBase /= newMaxBase;
				maxBase = maxBase * 0.5f + 0.5f;
				shiftedColor.rgb *= maxBase;
				blendedAlbedo.rgb = saturate(shiftedColor);
				#endif
				float t = ceil( fraction.x - fraction.y );
				float4 cornerDifference = float4( t, 1 - t, 1, 1 );
				float2 step_1 = ( parallax1 - octaFrame.zw ) * _AI_Frames;
				float4 step23 = ( float4( parallax2, parallax3 ) -  octaFrame.zwzw ) * _AI_Frames - cornerDifference;
				step_1 = step_1 * (1-step_1);
				step23 = step23 * (1-step23);
				float3 steps;
				steps.x = step_1.x * step_1.y;
				steps.y = step23.x * step23.y;
				steps.z = step23.z * step23.w;
				steps = step(-steps, 0);
				float final = dot( steps, weights );
				clip( final - 0.5 );
				o.Albedo = blendedAlbedo.rgb;
				o.Normal = worldNormal;
				o.Alpha = ( blendedAlbedo.a - _AI_Clip );
				clip( o.Alpha );
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
			

			/*struct appdata_full {
				float4 vertex : POSITION;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 texcoord3 : TEXCOORD3;
				fixed4 color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID*/
			
			/*};*/

			struct v2f_surf {
				V2F_SHADOW_CASTER;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 UVsFrame12401 : TEXCOORD5;
				float4 UVsFrame22401 : TEXCOORD6;
				float4 UVsFrame32401 : TEXCOORD7;
				float4 octaframe2401 : TEXCOORD8;
				float4 viewPos2401 : TEXCOORD9;
				float4 ase_color : COLOR;
				float4 ase_texcoord10 : TEXCOORD10;
			};

			v2f_surf vert_surf (appdata_full v ) {
				UNITY_SETUP_INSTANCE_ID(v);
				v2f_surf o;
				UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
				UNITY_TRANSFER_INSTANCE_ID(v,o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				half localunity_ObjectToWorld0w1_g8346 = ( unity_ObjectToWorld[0].w );
				half localunity_ObjectToWorld1w2_g8346 = ( unity_ObjectToWorld[1].w );
				half localunity_ObjectToWorld2w3_g8346 = ( unity_ObjectToWorld[2].w );
				float3 appendResult6_g8346 = (float3(localunity_ObjectToWorld0w1_g8346 , localunity_ObjectToWorld1w2_g8346 , localunity_ObjectToWorld2w3_g8346));
				float3 temp_output_1062_510_g8253 = appendResult6_g8346;
				float2 temp_output_1_0_g8295 = (temp_output_1062_510_g8253).xz;
				float temp_output_2_0_g8300 = _WIND_BASE_TRUNK_FIELD_SIZE;
				float2 temp_cast_0 = (( 1.0 / (( temp_output_2_0_g8300 == 0.0 ) ? 1.0 :  temp_output_2_0_g8300 ) )).xx;
				float2 temp_output_2_0_g8295 = temp_cast_0;
				float2 temp_output_704_0_g8289 = ( (( 1.0 > 0.0 ) ? ( temp_output_1_0_g8295 / temp_output_2_0_g8295 ) :  ( temp_output_1_0_g8295 * temp_output_2_0_g8295 ) ) + float2( 0,0 ) );
				float temp_output_2_0_g8259 = _WIND_BASE_TRUNK_CYCLE_TIME;
				float temp_output_618_0_g8289 = ( 1.0 / (( temp_output_2_0_g8259 == 0.0 ) ? 1.0 :  temp_output_2_0_g8259 ) );
				float2 break298_g8296 = ( temp_output_704_0_g8289 + ( temp_output_618_0_g8289 * ( _Time.y + 0.0 ) ) );
				float2 appendResult299_g8296 = (float2(sin( break298_g8296.x ) , cos( break298_g8296.y )));
				float4 temp_output_273_0_g8296 = (-1.0).xxxx;
				float4 temp_output_271_0_g8296 = (1.0).xxxx;
				float2 clampResult26_g8296 = clamp( appendResult299_g8296 , temp_output_273_0_g8296.xy , temp_output_271_0_g8296.xy );
				float temp_output_1062_495_g8253 = _WIND_BASE_AMPLITUDE;
				float temp_output_1062_501_g8253 = _WIND_BASE_TO_GUST_RATIO;
				float temp_output_524_0_g8289 = ( temp_output_1062_495_g8253 * temp_output_1062_501_g8253 );
				float2 TRUNK_PIVOT_ROCKING701_g8289 = ( clampResult26_g8296 * temp_output_524_0_g8289 );
				float temp_output_2424_495 = v.color.r;
				float temp_output_2431_0 = ( temp_output_2424_495 * _PrimaryRollStrength );
				float _WIND_PRIMARY_ROLL669_g8289 = temp_output_2431_0;
				float temp_output_54_0_g8304 = ( TRUNK_PIVOT_ROCKING701_g8289 * 0.05 * _WIND_PRIMARY_ROLL669_g8289 ).x;
				float temp_output_72_0_g8304 = cos( temp_output_54_0_g8304 );
				float one_minus_c52_g8304 = ( 1.0 - temp_output_72_0_g8304 );
				float3 break70_g8304 = float3(0,1,0);
				float axis_x25_g8304 = break70_g8304.x;
				float c66_g8304 = temp_output_72_0_g8304;
				float axis_y37_g8304 = break70_g8304.y;
				float axis_z29_g8304 = break70_g8304.z;
				float s67_g8304 = sin( temp_output_54_0_g8304 );
				float3 appendResult83_g8304 = (float3(( ( one_minus_c52_g8304 * axis_x25_g8304 * axis_x25_g8304 ) + c66_g8304 ) , ( ( one_minus_c52_g8304 * axis_x25_g8304 * axis_y37_g8304 ) - ( axis_z29_g8304 * s67_g8304 ) ) , ( ( one_minus_c52_g8304 * axis_z29_g8304 * axis_x25_g8304 ) + ( axis_y37_g8304 * s67_g8304 ) )));
				float3 appendResult81_g8304 = (float3(( ( one_minus_c52_g8304 * axis_x25_g8304 * axis_y37_g8304 ) + ( axis_z29_g8304 * s67_g8304 ) ) , ( ( one_minus_c52_g8304 * axis_y37_g8304 * axis_y37_g8304 ) + c66_g8304 ) , ( ( one_minus_c52_g8304 * axis_y37_g8304 * axis_z29_g8304 ) - ( axis_x25_g8304 * s67_g8304 ) )));
				float3 appendResult82_g8304 = (float3(( ( one_minus_c52_g8304 * axis_z29_g8304 * axis_x25_g8304 ) - ( axis_y37_g8304 * s67_g8304 ) ) , ( ( one_minus_c52_g8304 * axis_y37_g8304 * axis_z29_g8304 ) + ( axis_x25_g8304 * s67_g8304 ) ) , ( ( one_minus_c52_g8304 * axis_z29_g8304 * axis_z29_g8304 ) + c66_g8304 )));
				float3 _WIND_PRIMARY_PIVOT655_g8289 = float3(0,1,0);
				float3 temp_output_38_0_g8304 = ( v.vertex.xyz - (_WIND_PRIMARY_PIVOT655_g8289).xyz );
				float2 break298_g8290 = ( temp_output_704_0_g8289 + ( temp_output_618_0_g8289 * ( _Time.y + 0.0 ) ) );
				float2 appendResult299_g8290 = (float2(sin( break298_g8290.x ) , cos( break298_g8290.y )));
				float4 temp_output_273_0_g8290 = (-1.0).xxxx;
				float4 temp_output_271_0_g8290 = (1.0).xxxx;
				float2 clampResult26_g8290 = clamp( appendResult299_g8290 , temp_output_273_0_g8290.xy , temp_output_271_0_g8290.xy );
				float2 TRUNK_SWIRL700_g8289 = ( clampResult26_g8290 * temp_output_524_0_g8289 );
				float2 break699_g8289 = TRUNK_SWIRL700_g8289;
				float3 appendResult698_g8289 = (float3(break699_g8289.x , 0.0 , break699_g8289.y));
				float3 temp_output_694_0_g8289 = ( ( mul( float3x3(appendResult83_g8304, appendResult81_g8304, appendResult82_g8304), temp_output_38_0_g8304 ) - temp_output_38_0_g8304 ) + ( _WIND_PRIMARY_ROLL669_g8289 * appendResult698_g8289 * 0.5 ) );
				float lerpResult635_g8347 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_LOW , _WIND_AUDIO_INFLUENCE);
				float4 color658_g8306 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
				float2 temp_output_61_0_g8311 = float2( 0,0 );
				half localunity_ObjectToWorld0w1_g8324 = ( unity_ObjectToWorld[0].w );
				half localunity_ObjectToWorld1w2_g8324 = ( unity_ObjectToWorld[1].w );
				half localunity_ObjectToWorld2w3_g8324 = ( unity_ObjectToWorld[2].w );
				float3 appendResult6_g8324 = (float3(localunity_ObjectToWorld0w1_g8324 , localunity_ObjectToWorld1w2_g8324 , localunity_ObjectToWorld2w3_g8324));
				float2 temp_output_1_0_g8312 = (appendResult6_g8324).xz;
				float temp_output_2_0_g8318 = _WIND_GUST_TRUNK_FIELD_SIZE;
				float temp_output_40_0_g8311 = ( 1.0 / (( temp_output_2_0_g8318 == 0.0 ) ? 1.0 :  temp_output_2_0_g8318 ) );
				float2 temp_cast_6 = (temp_output_40_0_g8311).xx;
				float2 temp_output_2_0_g8312 = temp_cast_6;
				float temp_output_2_0_g8307 = _WIND_GUST_TRUNK_CYCLE_TIME;
				float mulTime37_g8311 = _Time.y * ( 1.0 / (( temp_output_2_0_g8307 == 0.0 ) ? 1.0 :  temp_output_2_0_g8307 ) );
				float temp_output_220_0_g8314 = -1.0;
				float4 temp_cast_7 = (temp_output_220_0_g8314).xxxx;
				float temp_output_219_0_g8314 = 1.0;
				float4 temp_cast_8 = (temp_output_219_0_g8314).xxxx;
				float4 clampResult26_g8314 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g8311 > float2( 0,0 ) ) ? ( temp_output_1_0_g8312 / temp_output_2_0_g8312 ) :  ( temp_output_1_0_g8312 * temp_output_2_0_g8312 ) ) + temp_output_61_0_g8311 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g8311 ) ) , temp_cast_7 , temp_cast_8 );
				float4 temp_cast_9 = (temp_output_220_0_g8314).xxxx;
				float4 temp_cast_10 = (temp_output_219_0_g8314).xxxx;
				float4 temp_cast_11 = (0.0).xxxx;
				float4 temp_cast_12 = (temp_output_219_0_g8314).xxxx;
				float temp_output_1072_526_g8253 = _WIND_GUST_CONTRAST;
				float4 temp_cast_13 = (temp_output_1072_526_g8253).xxxx;
				float4 temp_output_52_0_g8311 = saturate( pow( abs( (temp_cast_11 + (clampResult26_g8314 - temp_cast_9) * (temp_cast_12 - temp_cast_11) / (temp_cast_10 - temp_cast_9)) ) , temp_cast_13 ) );
				float temp_output_679_0_g8306 = 1.0;
				float4 lerpResult656_g8306 = lerp( color658_g8306 , temp_output_52_0_g8311 , temp_output_679_0_g8306);
				float _WIND_GUST_STRENGTH703_g8289 = ( (lerpResult635_g8347).xxxx * lerpResult656_g8306 ).x;
				float _WIND_PRIMARY_BEND662_g8289 = ( temp_output_2424_495 * _PrimaryBendStrength );
				float temp_output_54_0_g8294 = ( ( _WIND_GUST_STRENGTH703_g8289 * -1.0 ) * _WIND_PRIMARY_BEND662_g8289 );
				float temp_output_72_0_g8294 = cos( temp_output_54_0_g8294 );
				float one_minus_c52_g8294 = ( 1.0 - temp_output_72_0_g8294 );
				float3 temp_output_1062_494_g8253 = _WIND_DIRECTION;
				float3 _WIND_DIRECTION671_g8289 = temp_output_1062_494_g8253;
				float3 worldToObjDir719_g8289 = mul( unity_WorldToObject, float4( cross( _WIND_DIRECTION671_g8289 , float3(0,1,0) ), 0 ) ).xyz;
				float3 break70_g8294 = worldToObjDir719_g8289;
				float axis_x25_g8294 = break70_g8294.x;
				float c66_g8294 = temp_output_72_0_g8294;
				float axis_y37_g8294 = break70_g8294.y;
				float axis_z29_g8294 = break70_g8294.z;
				float s67_g8294 = sin( temp_output_54_0_g8294 );
				float3 appendResult83_g8294 = (float3(( ( one_minus_c52_g8294 * axis_x25_g8294 * axis_x25_g8294 ) + c66_g8294 ) , ( ( one_minus_c52_g8294 * axis_x25_g8294 * axis_y37_g8294 ) - ( axis_z29_g8294 * s67_g8294 ) ) , ( ( one_minus_c52_g8294 * axis_z29_g8294 * axis_x25_g8294 ) + ( axis_y37_g8294 * s67_g8294 ) )));
				float3 appendResult81_g8294 = (float3(( ( one_minus_c52_g8294 * axis_x25_g8294 * axis_y37_g8294 ) + ( axis_z29_g8294 * s67_g8294 ) ) , ( ( one_minus_c52_g8294 * axis_y37_g8294 * axis_y37_g8294 ) + c66_g8294 ) , ( ( one_minus_c52_g8294 * axis_y37_g8294 * axis_z29_g8294 ) - ( axis_x25_g8294 * s67_g8294 ) )));
				float3 appendResult82_g8294 = (float3(( ( one_minus_c52_g8294 * axis_z29_g8294 * axis_x25_g8294 ) - ( axis_y37_g8294 * s67_g8294 ) ) , ( ( one_minus_c52_g8294 * axis_y37_g8294 * axis_z29_g8294 ) + ( axis_x25_g8294 * s67_g8294 ) ) , ( ( one_minus_c52_g8294 * axis_z29_g8294 * axis_z29_g8294 ) + c66_g8294 )));
				float3 temp_output_38_0_g8294 = ( v.vertex.xyz - (_WIND_PRIMARY_PIVOT655_g8289).xyz );
				float temp_output_1062_498_g8253 = _WIND_GUST_AMPLITUDE;
				float3 lerpResult538_g8289 = lerp( temp_output_694_0_g8289 , ( temp_output_694_0_g8289 + ( mul( float3x3(appendResult83_g8294, appendResult81_g8294, appendResult82_g8294), temp_output_38_0_g8294 ) - temp_output_38_0_g8294 ) ) , temp_output_1062_498_g8253);
				float3 temp_output_41_0_g8355 = ( ( _WIND_BASE_TRUNK_STRENGTH * lerpResult538_g8289 ) + ( _WIND_LEAF_STRENGTH * float3(0,0,0) ) );
				float temp_output_63_0_g8356 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
				float3 lerpResult57_g8356 = lerp( temp_output_41_0_g8355 , -v.vertex.xyz , ( 1.0 - temp_output_63_0_g8356 ));
				#ifdef INTERNAL_LODFADE_SCALE
				float3 staticSwitch58_g8355 = lerpResult57_g8356;
				#else
				float3 staticSwitch58_g8355 = temp_output_41_0_g8355;
				#endif
				#ifdef LOD_FADE_CROSSFADE
				float3 staticSwitch62_g8355 = staticSwitch58_g8355;
				#else
				float3 staticSwitch62_g8355 = temp_output_41_0_g8355;
				#endif
				
				OctaImpostorVertex( v.vertex, v.normal, o.UVsFrame12401, o.UVsFrame22401, o.UVsFrame32401, o.octaframe2401, o.viewPos2401 );
				
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord10 = screenPos;
				
				o.ase_color = v.color;

				v.vertex.xyz += staticSwitch62_g8355;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
				return o;
			}

			fixed4 frag_surf (v2f_surf IN, out float outDepth : SV_Depth ) : SV_Target {
				UNITY_SETUP_INSTANCE_ID(IN);
				#if defined(_SPECULAR_SETUP)
					SurfaceOutputStandardSpecular o = (SurfaceOutputStandardSpecular)0;
				#else
					SurfaceOutputStandard o = (SurfaceOutputStandard)0;
				#endif

				float4 clipPos = 0;
				float3 worldPos = 0;
				float temp_output_88_0_g1926 = _ContrastAdjustment;
				float4 output0 = 0;
				OctaImpostorFragment( o, clipPos, worldPos, IN.UVsFrame12401, IN.UVsFrame22401, IN.UVsFrame32401, IN.octaframe2401, IN.viewPos2401, output0 );
				float4 temp_output_89_0_g1926 = float4( o.Albedo , 0.0 );
				float3 hsvTorgb92_g1926 = RGBToHSV( temp_output_89_0_g1926.rgb );
				float3 hsvTorgb83_g1926 = HSVToRGB( float3(( _HueAdjustment + hsvTorgb92_g1926.x ),( hsvTorgb92_g1926.y + _SaturationAdjustment ),( hsvTorgb92_g1926.z + _BrightnessAdjustment )) );
				float4 appendResult104_g1926 = (float4(CalculateContrast(temp_output_88_0_g1926,float4( hsvTorgb83_g1926 , 0.0 )).rgb , (temp_output_89_0_g1926).a));
				float temp_output_88_0_g1932 = _ContrastAdjustment;
				float4 temp_output_89_0_g1932 = float4( o.Albedo , 0.0 );
				float3 hsvTorgb92_g1932 = RGBToHSV( temp_output_89_0_g1932.rgb );
				float3 hsvTorgb83_g1932 = HSVToRGB( float3(( _HueAdjustment + hsvTorgb92_g1932.x ),( hsvTorgb92_g1932.y + _SaturationAdjustment ),( hsvTorgb92_g1932.z + _BrightnessAdjustment )) );
				float temp_output_2_0_g1934 = _ContrastCorrection;
				float4 appendResult104_g1932 = (float4(CalculateContrast(temp_output_88_0_g1932,( float4( hsvTorgb83_g1932 , 0.0 ) * ( 1.0 / (( temp_output_2_0_g1934 == 0.0 ) ? 1.0 :  temp_output_2_0_g1934 ) ) )).rgb , (temp_output_89_0_g1932).a));
				float temp_output_2424_495 = IN.ase_color.r;
				float temp_output_2431_0 = ( temp_output_2424_495 * _PrimaryRollStrength );
				float4 lerpResult2444 = lerp( saturate( (( _CorrectContrast )?( appendResult104_g1932 ):( appendResult104_g1926 )) ) , saturate( _FadeVariation ) , saturate( ( temp_output_2431_0 * _FadeVariation.a ) ));
				
				float4 break2402 = output0;
				
				float temp_output_41_0_g8349 = o.Alpha;
				float4 screenPos = IN.ase_texcoord10;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float2 clipScreen45_g8350 = ase_screenPosNorm.xy * _ScreenParams.xy;
				float dither45_g8350 = Dither8x8Bayer( fmod(clipScreen45_g8350.x, 8), fmod(clipScreen45_g8350.y, 8) );
				float temp_output_56_0_g8350 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
				dither45_g8350 = step( dither45_g8350, temp_output_56_0_g8350 );
				#ifdef INTERNAL_LODFADE_DITHER
				float staticSwitch50_g8349 = ( temp_output_41_0_g8349 * dither45_g8350 );
				#else
				float staticSwitch50_g8349 = temp_output_41_0_g8349;
				#endif
				#ifdef LOD_FADE_CROSSFADE
				float staticSwitch56_g8349 = staticSwitch50_g8349;
				#else
				float staticSwitch56_g8349 = temp_output_41_0_g8349;
				#endif
				
				fixed3 albedo = saturate( lerpResult2444 ).rgb;
				fixed3 normal = o.Normal;
				half3 emission = half3( 0, 0, 0 );
				fixed3 specular = fixed3( 0, 0, 0 );
				fixed metallic = 0;
				half smoothness = break2402.w;
				half occlusion = break2402.y;
				fixed alpha = staticSwitch56_g8349;

				o.Albedo = albedo;
				o.Normal = normal;
				o.Emission = emission;
				#if defined(_SPECULAR_SETUP)
					o.Specular = specular;
				#else
					o.Metallic = metallic;
				#endif
				o.Smoothness = smoothness;
				o.Occlusion = occlusion;
				o.Alpha = alpha;
				clip(o.Alpha);

				IN.pos.zw = clipPos.zw;
				outDepth = IN.pos.z;

				UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
				SHADOW_CASTER_FRAGMENT(IN)
			}
			ENDCG
		}
		
	}
	

	CustomEditor "ASEMaterialInspector"
	
}
/*ASEBEGIN
Version=17500
74.4;-766.4;988;746;-3041.16;2100.436;1.3;True;False
Node;AmplifyShaderEditor.FunctionNode;2424;1024,-1664;Inherit;False;Mesh Values (Tree) (Complex) (Vertex Colors);-1;;1919;9cacaefc2ecfddf4c8e070f9be99b854;0;0;4;FLOAT;495;FLOAT;501;FLOAT;550;FLOAT;552
Node;AmplifyShaderEditor.RangedFloatNode;2430;1280,-1440;Inherit;False;Property;_PrimaryRollStrength;Primary Roll Strength;36;0;Create;True;0;0;False;0;0.1;4;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2431;1664,-1696;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;2408;1087,-2195;Inherit;True;Property;_WAOTS;WAOTS;15;0;Create;True;0;0;False;0;None;266aa5801f6a9bc41ab3130d73dcff34;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;2437;1631.032,-2716.198;Inherit;False;Property;_SaturationAdjustment;Saturation Adjustment;31;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2469;1632,-2432;Inherit;False;Property;_ContrastCorrection;Contrast Correction;33;0;Create;True;0;0;False;0;1;5;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2436;1631.032,-2812.198;Inherit;False;Property;_HueAdjustment;Hue Adjustment;30;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2439;1631.032,-2524.198;Inherit;False;Property;_ContrastAdjustment;Contrast Adjustment;34;0;Create;True;0;0;False;0;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2470;1880.989,-1761.34;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AmplifyImpostorNode;2401;1546.638,-2185.041;Inherit;False;9603;HemiOctahedron;True;False;True;20;21;22;19;18;10;17;16;11;12;14;13;23;24;25;26;27;1;Metallic;8;0;SAMPLER2D;;False;1;SAMPLER2D;;False;2;SAMPLER2D;;False;3;SAMPLER2D;;False;4;SAMPLER2D;;False;5;SAMPLER2D;;False;6;SAMPLER2D;;False;7;SAMPLER2D;;False;17;FLOAT4;8;FLOAT4;9;FLOAT4;10;FLOAT4;11;FLOAT4;12;FLOAT4;13;FLOAT4;14;FLOAT4;15;FLOAT3;0;FLOAT3;1;FLOAT3;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT3;7;FLOAT3;16
Node;AmplifyShaderEditor.RangedFloatNode;2438;1631.032,-2620.198;Inherit;False;Property;_BrightnessAdjustment;Brightness Adjustment;32;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2443;2377.365,-2332.365;Inherit;False;Property;_FadeVariation;Fade Variation;28;0;Create;True;0;0;True;0;1,1,1,0.2784314;0.8037751,0.8509804,0.6007922,0.1490196;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;2467;2087.148,-2649.582;Inherit;False;Color Adjustment;-1;;1926;f9571dc7cf91d954d87b44c4dd2d35aa;5,90,1,81,1,91,1,85,1,111,0;6;89;COLOR;0,0,0,0;False;82;FLOAT;0;False;86;FLOAT;0;False;87;FLOAT;0;False;88;FLOAT;0;False;115;FLOAT;0;False;1;FLOAT4;37
Node;AmplifyShaderEditor.WireNode;2471;2221.953,-1775.968;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2468;2086.362,-2455.114;Inherit;False;Color Adjustment;-1;;1932;f9571dc7cf91d954d87b44c4dd2d35aa;5,90,1,81,1,91,1,85,1,111,1;6;89;COLOR;0,0,0,0;False;82;FLOAT;0;False;86;FLOAT;0;False;87;FLOAT;0;False;88;FLOAT;0;False;115;FLOAT;0;False;1;FLOAT4;37
Node;AmplifyShaderEditor.ToggleSwitchNode;2463;2376.872,-2543.627;Inherit;False;Property;_CorrectContrast;CorrectContrast;37;0;Create;True;0;0;False;0;0;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2445;2636.349,-2256.296;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2429;1280,-1344;Inherit;False;Property;_PrimaryBendStrength;Primary Bend Strength;35;0;Create;True;0;0;False;0;0.125;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2474;2774.39,-2291.78;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2472;2721.09,-2468.58;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SaturateNode;2473;2714.59,-2377.58;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2432;1664,-1600;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2444;2933.737,-2453.1;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;2427;2206.75,-1966.81;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2482;1990.366,-1599.834;Inherit;False;Wind (Tree Simple);0;;8253;b774245950aaa3f4bb8a70d8f34803e7;1,983,0;4;1088;FLOAT;0;False;1089;FLOAT;0;False;1093;FLOAT;0;False;1096;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TemplateMultiPassSwitchNode;2480;3889.281,-1673.219;Inherit;False;0;0;5;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2441;1188.835,-2483.177;Inherit;False;Property;_HueVariation;Hue Variation;29;0;Create;True;0;0;True;0;0,0,0,0;0.3207546,0.3207546,0.3207546,0.1764706;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;2402;1916.964,-1925.012;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.WireNode;2421;2038.619,-2068.034;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;2388;2551.29,-1788.038;Inherit;False;Execute LOD Fade;-1;;8348;18ea34bd83a0d6c4db425672111543e6;0;2;41;FLOAT;0;False;58;FLOAT3;0,0,0;False;3;FLOAT;0;FLOAT3;91;FLOAT;96
Node;AmplifyShaderEditor.SaturateNode;2453;3110.266,-2432.113;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2366;3516.442,-1485.644;Inherit;False;Internal Features Support;-1;;8361;3c493d142aeebd840af72d626f6915c6;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2397;3601.808,-1742.733;Float;False;False;-1;2;ASEMaterialInspector;0;10;New Amplify Shader;30a8e337ed84177439ca24b6a5c97cd1;True;ForwardAdd;0;1;ForwardAdd;0;False;False;True;False;True;0;False;-1;False;False;False;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=True;True;2;0;True;4;1;False;-1;1;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;True;2;False;-1;False;False;True;1;LightMode=ForwardAdd;False;0;;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2398;3601.808,-1709.733;Float;False;False;-1;2;ASEMaterialInspector;0;10;New Amplify Shader;30a8e337ed84177439ca24b6a5c97cd1;True;Deferred;0;2;Deferred;0;False;False;True;False;True;0;False;-1;False;False;False;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=True;True;2;0;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;0;;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2396;3601.808,-1984.133;Float;False;True;-1;2;ASEMaterialInspector;0;10;internal/impostors/tree-runtime;30a8e337ed84177439ca24b6a5c97cd1;True;ForwardBase;0;0;ForwardBase;10;False;False;True;False;True;0;False;-1;False;False;False;False;False;True;4;RenderType=TransparentCutout=RenderType;Queue=AlphaTest=Queue=0;DisableBatching=True;ImpostorType=HemiOctahedron;True;4;0;False;False;False;False;False;False;True;0;False;-1;False;False;True;1;LightMode=ForwardBase;False;0;;1;=;0;Standard;1;Material Type,InvertActionOnDeselection;0;0;5;True;True;True;True;True;False;;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2399;3601.808,-1676.733;Float;False;False;-1;2;ASEMaterialInspector;0;10;New Amplify Shader;30a8e337ed84177439ca24b6a5c97cd1;True;Meta;0;3;Meta;0;False;False;True;False;True;0;False;-1;False;False;False;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=True;True;2;0;False;False;False;True;2;False;-1;False;False;False;False;False;True;1;LightMode=Meta;False;0;;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2400;3601.808,-1643.733;Float;False;False;-1;2;ASEMaterialInspector;0;10;New Amplify Shader;30a8e337ed84177439ca24b6a5c97cd1;True;ShadowCaster;0;4;ShadowCaster;0;False;False;True;False;True;0;False;-1;False;False;False;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=True;True;2;0;False;False;False;False;False;False;True;1;False;-1;False;False;True;1;LightMode=ShadowCaster;False;0;;0;0;Standard;0;0
WireConnection;2431;0;2424;495
WireConnection;2431;1;2430;0
WireConnection;2470;0;2431;0
WireConnection;2401;0;2408;0
WireConnection;2467;89;2401;0
WireConnection;2467;82;2436;0
WireConnection;2467;86;2437;0
WireConnection;2467;87;2438;0
WireConnection;2467;88;2439;0
WireConnection;2471;0;2470;0
WireConnection;2468;89;2401;0
WireConnection;2468;82;2436;0
WireConnection;2468;86;2437;0
WireConnection;2468;87;2438;0
WireConnection;2468;88;2439;0
WireConnection;2468;115;2469;0
WireConnection;2463;0;2467;37
WireConnection;2463;1;2468;37
WireConnection;2445;0;2471;0
WireConnection;2445;1;2443;4
WireConnection;2474;0;2445;0
WireConnection;2472;0;2463;0
WireConnection;2473;0;2443;0
WireConnection;2432;0;2424;495
WireConnection;2432;1;2429;0
WireConnection;2444;0;2472;0
WireConnection;2444;1;2473;0
WireConnection;2444;2;2474;0
WireConnection;2427;0;2401;6
WireConnection;2482;1088;2431;0
WireConnection;2482;1089;2432;0
WireConnection;2480;0;2366;0
WireConnection;2480;1;2366;0
WireConnection;2480;2;2366;0
WireConnection;2480;3;2366;0
WireConnection;2480;4;2366;0
WireConnection;2402;0;2401;8
WireConnection;2421;0;2401;1
WireConnection;2388;41;2427;0
WireConnection;2388;58;2482;0
WireConnection;2453;0;2444;0
WireConnection;2396;0;2453;0
WireConnection;2396;1;2421;0
WireConnection;2396;4;2402;3
WireConnection;2396;5;2402;1
WireConnection;2396;6;2388;0
WireConnection;2396;9;2388;91
ASEEND*/
//CHKSM=139E1D0E0916D4B3B2E8395B2BD7F583F390227B
