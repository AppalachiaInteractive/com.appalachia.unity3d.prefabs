// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "appalachia/impostors/grass-runtime"
{
	Properties
	{
		[HideInInspector]_AI_Frames("Impostor Frames", Float) = 0
		_AI_ShadowView("Impostor Shadow View", Range( 0 , 1)) = 1
		_AI_ShadowBias("Impostor Shadow Bias", Range( 0 , 2)) = 0.25
		_AI_TextureBias("Impostor Texture Bias", Float) = -1
		_AI_Parallax("Impostor Parallax", Range( 0 , 1)) = 1
		[HideInInspector]_AI_DepthSize("Impostor Depth Size", Float) = 0
		[HideInInspector]_AI_SizeOffset("Impostor Size Offset", Vector) = (0,0,0,0)
		[HideInInspector]_AI_Offset("Impostor Offset", Vector) = (0,0,0,0)
		[HideInInspector]_AI_ImpostorSize("Impostor Size", Float) = 0
		[HideInInspector]_AI_FramesY("Impostor Frames Y", Float) = 0
		[HideInInspector]_AI_FramesX("Impostor Frames X", Float) = 0
		_AI_Clip("Impostor Clip", Range( 0 , 1)) = 0.5
		[NoScaleOffset]_Albedo("Impostor Albedo & Alpha", 2D) = "white" {}
		[NoScaleOffset]_Normals("Impostor Normal & Depth", 2D) = "white" {}
		[NoScaleOffset]_MAOTS("MAOTS", 2D) = "white" {}
		_Color("Grass Color", Color) = (1,1,1,0)
		_Saturation("Saturation", Range( 0 , 3)) = 1
		_Brightness("Brightness", Range( 0 , 3)) = 1
		[Toggle( EFFECT_HUE_VARIATION )] _Hue("Use SpeedTree Hue", Float) = 0
		_AI_HueVariation("Impostor Hue Variation", Color) = (0,0,0,0)
		_HueVariation("Hue Variation", Color) = (1,0.9661968,0.636,0.2)
		_Smoothness("Grass Smoothness", Range( 0 , 1)) = 0.15
		_Occlusion("Grass Occlusion", Range( 0 , 1)) = 0.5
		_OcclusionRoots("Grass Root Darkening", Range( 0 , 1)) = 1
		_RootDarkeningHeight("Root Darkening Height", Range( 0.0001 , 2)) = 0.5
		_OcclusionRoots1("Grass Root Darkening Fade In Start", Range( 0 , 64)) = 32
		_OcclusionRoots2("Grass Root Darkening Fade In Range", Range( 0 , 64)) = 16
		_Cutoff("_Cutoff", Range( 0 , 1)) = 0.6
		_PrimaryRollStrength("Primary Roll Strength", Range( 0 , 2)) = 0.1

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
		AlphaToMask On

		Pass
		{
			
			ZWrite On
			Name "ForwardBase"
			Tags { "LightMode"="ForwardBase" }

			CGPROGRAM
#include "UnityCG.cginc"
#include "Assets/Resources/CGIncludes/appalachia/GPUInstancerInclude.cginc"
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
			uniform half _WIND_GRASS_STRENGTH;
			uniform float _PrimaryRollStrength;
			uniform half _WIND_BASE_GRASS_FIELD_SIZE;
			uniform half _WIND_BASE_GRASS_CYCLE_TIME;
			uniform half _WIND_BASE_GRASS_STRENGTH;
			uniform half _WIND_BASE_AMPLITUDE;
			uniform half3 _WIND_DIRECTION;
			uniform half _WIND_GUST_GRASS_STRENGTH;
			uniform half _WIND_GUST_AMPLITUDE;
			uniform half _WIND_GUST_AUDIO_STRENGTH_HIGH;
			uniform half _WIND_AUDIO_INFLUENCE;
			uniform sampler2D _WIND_GUST_TEXTURE;
			uniform half _WIND_GUST_GRASS_FIELD_SIZE;
			uniform half _WIND_GUST_GRASS_CYCLE_TIME;
			uniform half _WIND_GUST_AUDIO_STRENGTH;
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
			uniform sampler2D _MAOTS;
			uniform half4 _Color;
			uniform float _Saturation;
			uniform float _Brightness;
			uniform float _Cutoff;
			uniform half _Smoothness;
			uniform float _RootDarkeningHeight;
			uniform half _OcclusionRoots;
			uniform half _OcclusionRoots1;
			uniform half _OcclusionRoots2;
			uniform half _Occlusion;
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
				float4 output0a = tex2Dbias( _MAOTS, float4( parallax1, 0, textureBias) ); 
				float4 output0b = tex2Dbias( _MAOTS, float4( parallax2, 0, textureBias) ); 
				float4 output0c = tex2Dbias( _MAOTS, float4( parallax3, 0, textureBias) ); 
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
				float4 UVsFrame11428 : TEXCOORD5;
				float4 UVsFrame21428 : TEXCOORD6;
				float4 UVsFrame31428 : TEXCOORD7;
				float4 octaframe1428 : TEXCOORD8;
				float4 viewPos1428 : TEXCOORD9;
				float4 ase_texcoord10 : TEXCOORD10;
				float4 ase_texcoord11 : TEXCOORD11;
			};

			v2f_surf vert_surf (appdata_full v ) {
				UNITY_SETUP_INSTANCE_ID(v);
				v2f_surf o;
				UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
				UNITY_TRANSFER_INSTANCE_ID(v,o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float GRASS_STRENGTH1499_g8248 = _WIND_GRASS_STRENGTH;
				float _WIND_PRIMARY_ROLL669_g8284 = ( saturate( v.color.r ) * _PrimaryRollStrength );
				half localunity_ObjectToWorld0w1_g8251 = ( unity_ObjectToWorld[0].w );
				half localunity_ObjectToWorld1w2_g8251 = ( unity_ObjectToWorld[1].w );
				half localunity_ObjectToWorld2w3_g8251 = ( unity_ObjectToWorld[2].w );
				float3 appendResult6_g8251 = (float3(localunity_ObjectToWorld0w1_g8251 , localunity_ObjectToWorld1w2_g8251 , localunity_ObjectToWorld2w3_g8251));
				float2 UV_POSITION_OBJECT1504_g8248 = (appendResult6_g8251).xz;
				float BASE_FIELD_SIZE1503_g8248 = _WIND_BASE_GRASS_FIELD_SIZE;
				float temp_output_2_0_g8272 = _WIND_BASE_GRASS_CYCLE_TIME;
				float BASE_FREQUENCY1498_g8248 = ( 1.0 / (( temp_output_2_0_g8272 == 0.0 ) ? 1.0 :  temp_output_2_0_g8272 ) );
				float2 break298_g8285 = ( ( UV_POSITION_OBJECT1504_g8248 * BASE_FIELD_SIZE1503_g8248 ) + ( BASE_FREQUENCY1498_g8248 * ( _Time.y + 0.0 ) ) );
				float2 appendResult299_g8285 = (float2(sin( break298_g8285.x ) , cos( break298_g8285.y )));
				float4 temp_output_273_0_g8285 = (-1.0).xxxx;
				float4 temp_output_271_0_g8285 = (1.0).xxxx;
				float2 clampResult26_g8285 = clamp( appendResult299_g8285 , temp_output_273_0_g8285.xy , temp_output_271_0_g8285.xy );
				float BASE_GRASS_STRENGTH1628_g8248 = _WIND_BASE_GRASS_STRENGTH;
				float BASE_AMPLITUDE1549_g8248 = _WIND_BASE_AMPLITUDE;
				float2 break699_g8284 = ( clampResult26_g8285 * ( BASE_GRASS_STRENGTH1628_g8248 * BASE_AMPLITUDE1549_g8248 ) );
				float3 appendResult698_g8284 = (float3(break699_g8284.x , 0.0 , break699_g8284.y));
				float3 temp_output_684_0_g8284 = ( _WIND_PRIMARY_ROLL669_g8284 * (appendResult698_g8284).xyz );
				float3 _VERTEX_NORMAL918_g8284 = v.normal;
				float GUST_MICRO1651_g8248 = 0.0;
				float _GUST_STRENGTH_MICRO769_g8284 = GUST_MICRO1651_g8248;
				float3 GUST_MICRO816_g8284 = ( _VERTEX_NORMAL918_g8284 * _WIND_PRIMARY_ROLL669_g8284 * _GUST_STRENGTH_MICRO769_g8284 );
				float3 WIND_DIRECTION1507_g8248 = _WIND_DIRECTION;
				float3 _WIND_DIRECTION671_g8284 = WIND_DIRECTION1507_g8248;
				float3 worldToObjDir891_g8284 = mul( unity_WorldToObject, float4( _WIND_DIRECTION671_g8284, 0 ) ).xyz;
				float GUST_STRENGTH1624_g8248 = _WIND_GUST_GRASS_STRENGTH;
				float lerpResult633_g8290 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_HIGH , _WIND_AUDIO_INFLUENCE);
				float AUDIO_HIGH1640_g8248 = lerpResult633_g8290;
				float4 color658_g8306 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
				float2 temp_output_61_0_g8311 = float2( 0,0 );
				float2 uv11491_g8248 = v.texcoord1.xyzw.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult1567_g8248 = (float2(-uv11491_g8248.x , uv11491_g8248.x));
				float2 UV_PLANE1566_g8248 = appendResult1567_g8248;
				half localunity_ObjectToWorld0w1_g8249 = ( unity_ObjectToWorld[0].w );
				half localunity_ObjectToWorld2w3_g8249 = ( unity_ObjectToWorld[2].w );
				float2 appendResult1608_g8248 = (float2(localunity_ObjectToWorld0w1_g8249 , localunity_ObjectToWorld2w3_g8249));
				float2 temp_output_1_0_g8312 = ( ( 10.0 * UV_PLANE1566_g8248 ) + appendResult1608_g8248 );
				float GUST_FIELD_SIZE1512_g8248 = _WIND_GUST_GRASS_FIELD_SIZE;
				float temp_output_2_0_g8318 = GUST_FIELD_SIZE1512_g8248;
				float temp_output_40_0_g8311 = ( 1.0 / (( temp_output_2_0_g8318 == 0.0 ) ? 1.0 :  temp_output_2_0_g8318 ) );
				float2 temp_cast_2 = (temp_output_40_0_g8311).xx;
				float2 temp_output_2_0_g8312 = temp_cast_2;
				float clampResult3_g8265 = clamp( (UV_PLANE1566_g8248).x , 0.0 , 1.0 );
				float GUST_CYCLE_TIME1511_g8248 = _WIND_GUST_GRASS_CYCLE_TIME;
				float temp_output_2_0_g8307 = ( ( ( ( clampResult3_g8265 * 2.0 ) - 1.0 ) * 0.15 * GUST_CYCLE_TIME1511_g8248 ) + GUST_CYCLE_TIME1511_g8248 );
				float mulTime37_g8311 = _Time.y * ( 1.0 / (( temp_output_2_0_g8307 == 0.0 ) ? 1.0 :  temp_output_2_0_g8307 ) );
				float temp_output_220_0_g8314 = -1.0;
				float4 temp_cast_3 = (temp_output_220_0_g8314).xxxx;
				float temp_output_219_0_g8314 = 1.0;
				float4 temp_cast_4 = (temp_output_219_0_g8314).xxxx;
				float4 clampResult26_g8314 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g8311 > float2( 0,0 ) ) ? ( temp_output_1_0_g8312 / temp_output_2_0_g8312 ) :  ( temp_output_1_0_g8312 * temp_output_2_0_g8312 ) ) + temp_output_61_0_g8311 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g8311 ) ) , temp_cast_3 , temp_cast_4 );
				float4 temp_cast_5 = (temp_output_220_0_g8314).xxxx;
				float4 temp_cast_6 = (temp_output_219_0_g8314).xxxx;
				float4 temp_cast_7 = (0.0).xxxx;
				float4 temp_cast_8 = (temp_output_219_0_g8314).xxxx;
				float temp_output_679_0_g8306 = 1.0;
				float4 temp_cast_9 = (temp_output_679_0_g8306).xxxx;
				float4 temp_output_52_0_g8311 = saturate( pow( abs( (temp_cast_7 + (clampResult26_g8314 - temp_cast_5) * (temp_cast_8 - temp_cast_7) / (temp_cast_6 - temp_cast_5)) ) , temp_cast_9 ) );
				float4 lerpResult656_g8306 = lerp( color658_g8306 , temp_output_52_0_g8311 , temp_output_679_0_g8306);
				float4 break655_g8306 = lerpResult656_g8306;
				float GUST1666_g8248 = ( GUST_STRENGTH1624_g8248 * AUDIO_HIGH1640_g8248 * break655_g8306.b );
				float _GUST_STRENGTH845_g8284 = GUST1666_g8248;
				float3 GUST798_g8284 = ( _WIND_PRIMARY_ROLL669_g8284 * ( worldToObjDir891_g8284 * _GUST_STRENGTH845_g8284 ) );
				float3 worldToObjDir921_g8284 = mul( unity_WorldToObject, float4( _WIND_DIRECTION671_g8284, 0 ) ).xyz;
				float GUST_MID1664_g8248 = 0.0;
				float _GUST_STRENGTH_MID842_g8284 = GUST_MID1664_g8248;
				float3 GUST_MID926_g8284 = ( _WIND_PRIMARY_ROLL669_g8284 * ( worldToObjDir921_g8284 * _GUST_STRENGTH_MID842_g8284 ) );
				float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
				float3 _vec_min_old = float3(1,1,1);
				float3 _vec_max_old = float3(7,7,7);
				float3 clampResult934_g8284 = clamp( ase_objectScale , _vec_min_old , _vec_max_old );
				float lerpResult632_g8290 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH , _WIND_AUDIO_INFLUENCE);
				float AUDIO_BLEND1671_g8248 = lerpResult632_g8290;
				float3 lerpResult538_g8284 = lerp( temp_output_684_0_g8284 , ( temp_output_684_0_g8284 + ( GUST_MICRO816_g8284 + ( ( GUST798_g8284 + GUST_MID926_g8284 ) * (float3(1,1,1) + (clampResult934_g8284 - _vec_min_old) * (float3(3,3,3) - float3(1,1,1)) / (_vec_max_old - _vec_min_old)) ) ) ) , AUDIO_BLEND1671_g8248);
				float3 temp_output_41_0_g8366 = ( GRASS_STRENGTH1499_g8248 * lerpResult538_g8284 );
				float temp_output_63_0_g8367 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
				float3 lerpResult57_g8367 = lerp( temp_output_41_0_g8366 , -v.vertex.xyz , ( 1.0 - temp_output_63_0_g8367 ));
				#ifdef INTERNAL_LODFADE_SCALE
				float3 staticSwitch58_g8366 = lerpResult57_g8367;
				#else
				float3 staticSwitch58_g8366 = temp_output_41_0_g8366;
				#endif
				#ifdef LOD_FADE_CROSSFADE
				float3 staticSwitch62_g8366 = staticSwitch58_g8366;
				#else
				float3 staticSwitch62_g8366 = temp_output_41_0_g8366;
				#endif
				
				OctaImpostorVertex( v.vertex, v.normal, o.UVsFrame11428, o.UVsFrame21428, o.UVsFrame31428, o.octaframe1428, o.viewPos1428 );
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord10 = screenPos;
				
				float3 ase_worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				o.ase_texcoord11.xyz = ase_worldPos;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord11.w = 0;

				v.vertex.xyz += staticSwitch62_g8366;
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
				float4 output0 = 0;
				OctaImpostorFragment( o, clipPos, worldPos, IN.UVsFrame11428, IN.UVsFrame21428, IN.UVsFrame31428, IN.octaframe1428, IN.viewPos1428, output0 );
				float3 input_albedo1454 = o.Albedo;
				float3 lerpResult1322 = lerp( input_albedo1454 , ( (_Color).rgb * input_albedo1454 ) , (_Color).a);
				float3 hsvTorgb1497 = RGBToHSV( lerpResult1322 );
				float3 hsvTorgb1498 = HSVToRGB( float3(hsvTorgb1497.x,( hsvTorgb1497.y * _Saturation ),( hsvTorgb1497.z * _Brightness )) );
				float3 albedo1446 = hsvTorgb1498;
				float temp_output_41_0_g8360 = o.Alpha;
				float4 screenPos = IN.ase_texcoord10;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float2 clipScreen45_g8361 = ase_screenPosNorm.xy * _ScreenParams.xy;
				float dither45_g8361 = Dither8x8Bayer( fmod(clipScreen45_g8361.x, 8), fmod(clipScreen45_g8361.y, 8) );
				float temp_output_56_0_g8361 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
				dither45_g8361 = step( dither45_g8361, temp_output_56_0_g8361 );
				#ifdef INTERNAL_LODFADE_DITHER
				float staticSwitch50_g8360 = ( temp_output_41_0_g8360 * dither45_g8361 );
				#else
				float staticSwitch50_g8360 = temp_output_41_0_g8360;
				#endif
				#ifdef LOD_FADE_CROSSFADE
				float staticSwitch56_g8360 = staticSwitch50_g8360;
				#else
				float staticSwitch56_g8360 = temp_output_41_0_g8360;
				#endif
				float temp_output_1364_0 = staticSwitch56_g8360;
				clip( temp_output_1364_0 - _Cutoff);
				
				float3 normal_world1443 = o.Normal;
				
				float4 break1381 = output0;
				half Main_MetallicGlossMap_A744 = break1381.w;
				half OUT_SMOOTHNESS660 = ( Main_MetallicGlossMap_A744 * _Smoothness );
				
				half Main_MetallicGlossMap_G1287 = break1381.y;
				float3 ase_worldPos = IN.ase_texcoord11.xyz;
				half localunity_ObjectToWorld0w1_g8152 = ( unity_ObjectToWorld[0].w );
				half localunity_ObjectToWorld1w2_g8152 = ( unity_ObjectToWorld[1].w );
				half localunity_ObjectToWorld2w3_g8152 = ( unity_ObjectToWorld[2].w );
				float3 appendResult6_g8152 = (float3(localunity_ObjectToWorld0w1_g8152 , localunity_ObjectToWorld1w2_g8152 , localunity_ObjectToWorld2w3_g8152));
				float3 temp_output_22_0_g8151 = ( ase_worldPos - appendResult6_g8152 );
				float3 break23_g8151 = temp_output_22_0_g8151;
				float distance22_g8156 = distance( ase_worldPos , _WorldSpaceCameraPos );
				float temp_output_14_0_g8156 = _OcclusionRoots1;
				float temp_output_11_0_g8156 = _OcclusionRoots2;
				float fadeEnd20_g8156 = ( temp_output_14_0_g8156 + temp_output_11_0_g8156 );
				float fadeStart19_g8156 = temp_output_14_0_g8156;
				float fadeLength23_g8156 = temp_output_11_0_g8156;
				float lerpResult1365 = lerp( _OcclusionRoots , 0.0 , saturate( (( distance22_g8156 > fadeEnd20_g8156 ) ? 0.0 :  (( distance22_g8156 < fadeStart19_g8156 ) ? 1.0 :  ( 1.0 - ( ( distance22_g8156 - fadeStart19_g8156 ) / fadeLength23_g8156 ) ) ) ) ));
				float lerpResult1350 = lerp( Main_MetallicGlossMap_G1287 , ( Main_MetallicGlossMap_G1287 * saturate( ( break23_g8151.y / _RootDarkeningHeight ) ) ) , lerpResult1365);
				float lerpResult1342 = lerp( 1.0 , lerpResult1350 , _Occlusion);
				float occlusion1449 = lerpResult1342;
				
				fixed3 albedo = albedo1446;
				fixed3 normal = normal_world1443;
				half3 emission = half3( 0, 0, 0 );
				fixed3 specular = fixed3( 0, 0, 0 );
				fixed metallic = 0;
				half smoothness = OUT_SMOOTHNESS660;
				half occlusion = occlusion1449;
				fixed alpha = temp_output_1364_0;
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
#include "Assets/Resources/CGIncludes/appalachia/GPUInstancerInclude.cginc"
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
			uniform half _WIND_GRASS_STRENGTH;
			uniform float _PrimaryRollStrength;
			uniform half _WIND_BASE_GRASS_FIELD_SIZE;
			uniform half _WIND_BASE_GRASS_CYCLE_TIME;
			uniform half _WIND_BASE_GRASS_STRENGTH;
			uniform half _WIND_BASE_AMPLITUDE;
			uniform half3 _WIND_DIRECTION;
			uniform half _WIND_GUST_GRASS_STRENGTH;
			uniform half _WIND_GUST_AMPLITUDE;
			uniform half _WIND_GUST_AUDIO_STRENGTH_HIGH;
			uniform half _WIND_AUDIO_INFLUENCE;
			uniform sampler2D _WIND_GUST_TEXTURE;
			uniform half _WIND_GUST_GRASS_FIELD_SIZE;
			uniform half _WIND_GUST_GRASS_CYCLE_TIME;
			uniform half _WIND_GUST_AUDIO_STRENGTH;
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
			uniform sampler2D _MAOTS;
			uniform half4 _Color;
			uniform float _Saturation;
			uniform float _Brightness;
			uniform float _Cutoff;
			uniform half _Smoothness;
			uniform float _RootDarkeningHeight;
			uniform half _OcclusionRoots;
			uniform half _OcclusionRoots1;
			uniform half _OcclusionRoots2;
			uniform half _Occlusion;
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
				float4 output0a = tex2Dbias( _MAOTS, float4( parallax1, 0, textureBias) ); 
				float4 output0b = tex2Dbias( _MAOTS, float4( parallax2, 0, textureBias) ); 
				float4 output0c = tex2Dbias( _MAOTS, float4( parallax3, 0, textureBias) ); 
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
				float4 UVsFrame11428 : TEXCOORD5;
				float4 UVsFrame21428 : TEXCOORD6;
				float4 UVsFrame31428 : TEXCOORD7;
				float4 octaframe1428 : TEXCOORD8;
				float4 viewPos1428 : TEXCOORD9;
				float4 ase_texcoord10 : TEXCOORD10;
				float4 ase_texcoord11 : TEXCOORD11;
			};

			v2f_surf vert_surf ( appdata_full v  ) {
				UNITY_SETUP_INSTANCE_ID(v);
				v2f_surf o;
				UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
				UNITY_TRANSFER_INSTANCE_ID(v,o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float GRASS_STRENGTH1499_g8248 = _WIND_GRASS_STRENGTH;
				float _WIND_PRIMARY_ROLL669_g8284 = ( saturate( v.color.r ) * _PrimaryRollStrength );
				half localunity_ObjectToWorld0w1_g8251 = ( unity_ObjectToWorld[0].w );
				half localunity_ObjectToWorld1w2_g8251 = ( unity_ObjectToWorld[1].w );
				half localunity_ObjectToWorld2w3_g8251 = ( unity_ObjectToWorld[2].w );
				float3 appendResult6_g8251 = (float3(localunity_ObjectToWorld0w1_g8251 , localunity_ObjectToWorld1w2_g8251 , localunity_ObjectToWorld2w3_g8251));
				float2 UV_POSITION_OBJECT1504_g8248 = (appendResult6_g8251).xz;
				float BASE_FIELD_SIZE1503_g8248 = _WIND_BASE_GRASS_FIELD_SIZE;
				float temp_output_2_0_g8272 = _WIND_BASE_GRASS_CYCLE_TIME;
				float BASE_FREQUENCY1498_g8248 = ( 1.0 / (( temp_output_2_0_g8272 == 0.0 ) ? 1.0 :  temp_output_2_0_g8272 ) );
				float2 break298_g8285 = ( ( UV_POSITION_OBJECT1504_g8248 * BASE_FIELD_SIZE1503_g8248 ) + ( BASE_FREQUENCY1498_g8248 * ( _Time.y + 0.0 ) ) );
				float2 appendResult299_g8285 = (float2(sin( break298_g8285.x ) , cos( break298_g8285.y )));
				float4 temp_output_273_0_g8285 = (-1.0).xxxx;
				float4 temp_output_271_0_g8285 = (1.0).xxxx;
				float2 clampResult26_g8285 = clamp( appendResult299_g8285 , temp_output_273_0_g8285.xy , temp_output_271_0_g8285.xy );
				float BASE_GRASS_STRENGTH1628_g8248 = _WIND_BASE_GRASS_STRENGTH;
				float BASE_AMPLITUDE1549_g8248 = _WIND_BASE_AMPLITUDE;
				float2 break699_g8284 = ( clampResult26_g8285 * ( BASE_GRASS_STRENGTH1628_g8248 * BASE_AMPLITUDE1549_g8248 ) );
				float3 appendResult698_g8284 = (float3(break699_g8284.x , 0.0 , break699_g8284.y));
				float3 temp_output_684_0_g8284 = ( _WIND_PRIMARY_ROLL669_g8284 * (appendResult698_g8284).xyz );
				float3 _VERTEX_NORMAL918_g8284 = v.normal;
				float GUST_MICRO1651_g8248 = 0.0;
				float _GUST_STRENGTH_MICRO769_g8284 = GUST_MICRO1651_g8248;
				float3 GUST_MICRO816_g8284 = ( _VERTEX_NORMAL918_g8284 * _WIND_PRIMARY_ROLL669_g8284 * _GUST_STRENGTH_MICRO769_g8284 );
				float3 WIND_DIRECTION1507_g8248 = _WIND_DIRECTION;
				float3 _WIND_DIRECTION671_g8284 = WIND_DIRECTION1507_g8248;
				float3 worldToObjDir891_g8284 = mul( unity_WorldToObject, float4( _WIND_DIRECTION671_g8284, 0 ) ).xyz;
				float GUST_STRENGTH1624_g8248 = _WIND_GUST_GRASS_STRENGTH;
				float lerpResult633_g8290 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH_HIGH , _WIND_AUDIO_INFLUENCE);
				float AUDIO_HIGH1640_g8248 = lerpResult633_g8290;
				float4 color658_g8306 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
				float2 temp_output_61_0_g8311 = float2( 0,0 );
				float2 uv11491_g8248 = v.texcoord1.xyzw.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult1567_g8248 = (float2(-uv11491_g8248.x , uv11491_g8248.x));
				float2 UV_PLANE1566_g8248 = appendResult1567_g8248;
				half localunity_ObjectToWorld0w1_g8249 = ( unity_ObjectToWorld[0].w );
				half localunity_ObjectToWorld2w3_g8249 = ( unity_ObjectToWorld[2].w );
				float2 appendResult1608_g8248 = (float2(localunity_ObjectToWorld0w1_g8249 , localunity_ObjectToWorld2w3_g8249));
				float2 temp_output_1_0_g8312 = ( ( 10.0 * UV_PLANE1566_g8248 ) + appendResult1608_g8248 );
				float GUST_FIELD_SIZE1512_g8248 = _WIND_GUST_GRASS_FIELD_SIZE;
				float temp_output_2_0_g8318 = GUST_FIELD_SIZE1512_g8248;
				float temp_output_40_0_g8311 = ( 1.0 / (( temp_output_2_0_g8318 == 0.0 ) ? 1.0 :  temp_output_2_0_g8318 ) );
				float2 temp_cast_2 = (temp_output_40_0_g8311).xx;
				float2 temp_output_2_0_g8312 = temp_cast_2;
				float clampResult3_g8265 = clamp( (UV_PLANE1566_g8248).x , 0.0 , 1.0 );
				float GUST_CYCLE_TIME1511_g8248 = _WIND_GUST_GRASS_CYCLE_TIME;
				float temp_output_2_0_g8307 = ( ( ( ( clampResult3_g8265 * 2.0 ) - 1.0 ) * 0.15 * GUST_CYCLE_TIME1511_g8248 ) + GUST_CYCLE_TIME1511_g8248 );
				float mulTime37_g8311 = _Time.y * ( 1.0 / (( temp_output_2_0_g8307 == 0.0 ) ? 1.0 :  temp_output_2_0_g8307 ) );
				float temp_output_220_0_g8314 = -1.0;
				float4 temp_cast_3 = (temp_output_220_0_g8314).xxxx;
				float temp_output_219_0_g8314 = 1.0;
				float4 temp_cast_4 = (temp_output_219_0_g8314).xxxx;
				float4 clampResult26_g8314 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g8311 > float2( 0,0 ) ) ? ( temp_output_1_0_g8312 / temp_output_2_0_g8312 ) :  ( temp_output_1_0_g8312 * temp_output_2_0_g8312 ) ) + temp_output_61_0_g8311 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g8311 ) ) , temp_cast_3 , temp_cast_4 );
				float4 temp_cast_5 = (temp_output_220_0_g8314).xxxx;
				float4 temp_cast_6 = (temp_output_219_0_g8314).xxxx;
				float4 temp_cast_7 = (0.0).xxxx;
				float4 temp_cast_8 = (temp_output_219_0_g8314).xxxx;
				float temp_output_679_0_g8306 = 1.0;
				float4 temp_cast_9 = (temp_output_679_0_g8306).xxxx;
				float4 temp_output_52_0_g8311 = saturate( pow( abs( (temp_cast_7 + (clampResult26_g8314 - temp_cast_5) * (temp_cast_8 - temp_cast_7) / (temp_cast_6 - temp_cast_5)) ) , temp_cast_9 ) );
				float4 lerpResult656_g8306 = lerp( color658_g8306 , temp_output_52_0_g8311 , temp_output_679_0_g8306);
				float4 break655_g8306 = lerpResult656_g8306;
				float GUST1666_g8248 = ( GUST_STRENGTH1624_g8248 * AUDIO_HIGH1640_g8248 * break655_g8306.b );
				float _GUST_STRENGTH845_g8284 = GUST1666_g8248;
				float3 GUST798_g8284 = ( _WIND_PRIMARY_ROLL669_g8284 * ( worldToObjDir891_g8284 * _GUST_STRENGTH845_g8284 ) );
				float3 worldToObjDir921_g8284 = mul( unity_WorldToObject, float4( _WIND_DIRECTION671_g8284, 0 ) ).xyz;
				float GUST_MID1664_g8248 = 0.0;
				float _GUST_STRENGTH_MID842_g8284 = GUST_MID1664_g8248;
				float3 GUST_MID926_g8284 = ( _WIND_PRIMARY_ROLL669_g8284 * ( worldToObjDir921_g8284 * _GUST_STRENGTH_MID842_g8284 ) );
				float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
				float3 _vec_min_old = float3(1,1,1);
				float3 _vec_max_old = float3(7,7,7);
				float3 clampResult934_g8284 = clamp( ase_objectScale , _vec_min_old , _vec_max_old );
				float lerpResult632_g8290 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH , _WIND_AUDIO_INFLUENCE);
				float AUDIO_BLEND1671_g8248 = lerpResult632_g8290;
				float3 lerpResult538_g8284 = lerp( temp_output_684_0_g8284 , ( temp_output_684_0_g8284 + ( GUST_MICRO816_g8284 + ( ( GUST798_g8284 + GUST_MID926_g8284 ) * (float3(1,1,1) + (clampResult934_g8284 - _vec_min_old) * (float3(3,3,3) - float3(1,1,1)) / (_vec_max_old - _vec_min_old)) ) ) ) , AUDIO_BLEND1671_g8248);
				float3 temp_output_41_0_g8366 = ( GRASS_STRENGTH1499_g8248 * lerpResult538_g8284 );
				float temp_output_63_0_g8367 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
				float3 lerpResult57_g8367 = lerp( temp_output_41_0_g8366 , -v.vertex.xyz , ( 1.0 - temp_output_63_0_g8367 ));
				#ifdef INTERNAL_LODFADE_SCALE
				float3 staticSwitch58_g8366 = lerpResult57_g8367;
				#else
				float3 staticSwitch58_g8366 = temp_output_41_0_g8366;
				#endif
				#ifdef LOD_FADE_CROSSFADE
				float3 staticSwitch62_g8366 = staticSwitch58_g8366;
				#else
				float3 staticSwitch62_g8366 = temp_output_41_0_g8366;
				#endif
				
				OctaImpostorVertex( v.vertex, v.normal, o.UVsFrame11428, o.UVsFrame21428, o.UVsFrame31428, o.octaframe1428, o.viewPos1428 );
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord10 = screenPos;
				
				float3 ase_worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				o.ase_texcoord11.xyz = ase_worldPos;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord11.w = 0;

				v.vertex.xyz += staticSwitch62_g8366;
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
				float4 output0 = 0;
				OctaImpostorFragment( o, clipPos, worldPos, IN.UVsFrame11428, IN.UVsFrame21428, IN.UVsFrame31428, IN.octaframe1428, IN.viewPos1428, output0 );
				float3 input_albedo1454 = o.Albedo;
				float3 lerpResult1322 = lerp( input_albedo1454 , ( (_Color).rgb * input_albedo1454 ) , (_Color).a);
				float3 hsvTorgb1497 = RGBToHSV( lerpResult1322 );
				float3 hsvTorgb1498 = HSVToRGB( float3(hsvTorgb1497.x,( hsvTorgb1497.y * _Saturation ),( hsvTorgb1497.z * _Brightness )) );
				float3 albedo1446 = hsvTorgb1498;
				float temp_output_41_0_g8360 = o.Alpha;
				float4 screenPos = IN.ase_texcoord10;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float2 clipScreen45_g8361 = ase_screenPosNorm.xy * _ScreenParams.xy;
				float dither45_g8361 = Dither8x8Bayer( fmod(clipScreen45_g8361.x, 8), fmod(clipScreen45_g8361.y, 8) );
				float temp_output_56_0_g8361 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
				dither45_g8361 = step( dither45_g8361, temp_output_56_0_g8361 );
				#ifdef INTERNAL_LODFADE_DITHER
				float staticSwitch50_g8360 = ( temp_output_41_0_g8360 * dither45_g8361 );
				#else
				float staticSwitch50_g8360 = temp_output_41_0_g8360;
				#endif
				#ifdef LOD_FADE_CROSSFADE
				float staticSwitch56_g8360 = staticSwitch50_g8360;
				#else
				float staticSwitch56_g8360 = temp_output_41_0_g8360;
				#endif
				float temp_output_1364_0 = staticSwitch56_g8360;
				clip( temp_output_1364_0 - _Cutoff);
				
				float3 normal_world1443 = o.Normal;
				
				float4 break1381 = output0;
				half Main_MetallicGlossMap_A744 = break1381.w;
				half OUT_SMOOTHNESS660 = ( Main_MetallicGlossMap_A744 * _Smoothness );
				
				half Main_MetallicGlossMap_G1287 = break1381.y;
				float3 ase_worldPos = IN.ase_texcoord11.xyz;
				half localunity_ObjectToWorld0w1_g8152 = ( unity_ObjectToWorld[0].w );
				half localunity_ObjectToWorld1w2_g8152 = ( unity_ObjectToWorld[1].w );
				half localunity_ObjectToWorld2w3_g8152 = ( unity_ObjectToWorld[2].w );
				float3 appendResult6_g8152 = (float3(localunity_ObjectToWorld0w1_g8152 , localunity_ObjectToWorld1w2_g8152 , localunity_ObjectToWorld2w3_g8152));
				float3 temp_output_22_0_g8151 = ( ase_worldPos - appendResult6_g8152 );
				float3 break23_g8151 = temp_output_22_0_g8151;
				float distance22_g8156 = distance( ase_worldPos , _WorldSpaceCameraPos );
				float temp_output_14_0_g8156 = _OcclusionRoots1;
				float temp_output_11_0_g8156 = _OcclusionRoots2;
				float fadeEnd20_g8156 = ( temp_output_14_0_g8156 + temp_output_11_0_g8156 );
				float fadeStart19_g8156 = temp_output_14_0_g8156;
				float fadeLength23_g8156 = temp_output_11_0_g8156;
				float lerpResult1365 = lerp( _OcclusionRoots , 0.0 , saturate( (( distance22_g8156 > fadeEnd20_g8156 ) ? 0.0 :  (( distance22_g8156 < fadeStart19_g8156 ) ? 1.0 :  ( 1.0 - ( ( distance22_g8156 - fadeStart19_g8156 ) / fadeLength23_g8156 ) ) ) ) ));
				float lerpResult1350 = lerp( Main_MetallicGlossMap_G1287 , ( Main_MetallicGlossMap_G1287 * saturate( ( break23_g8151.y / _RootDarkeningHeight ) ) ) , lerpResult1365);
				float lerpResult1342 = lerp( 1.0 , lerpResult1350 , _Occlusion);
				float occlusion1449 = lerpResult1342;
				
				fixed3 albedo = albedo1446;
				fixed3 normal = normal_world1443;
				half3 emission = half3( 0, 0, 0 );
				fixed3 specular = fixed3( 0, 0, 0 );
				fixed metallic = 0;
				half smoothness = OUT_SMOOTHNESS660;
				half occlusion = occlusion1449;
				fixed alpha = temp_output_1364_0;

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

		
	}
	
	CustomEditor "ASEMaterialInspector"
	
}
/*ASEBEGIN
Version=17500
92;-710.4;571;543;727.7714;2607.234;1.3;True;False
Node;AmplifyShaderEditor.TexturePropertyNode;1376;-3243.632,-3390.553;Inherit;True;Property;_MAOTS;MAOTS;16;1;[NoScaleOffset];Create;True;0;0;False;0;None;327d8c020f2ce694da18654b6e1720b4;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.AmplifyImpostorNode;1428;-2825.169,-3385.365;Inherit;False;9603;HemiOctahedron;True;True;True;0;10;9;8;4;7;6;3;12;13;14;15;5;2;1;11;20;1;Metallic;8;0;SAMPLER2D;;False;1;SAMPLER2D;;False;2;SAMPLER2D;;False;3;SAMPLER2D;;False;4;SAMPLER2D;;False;5;SAMPLER2D;;False;6;SAMPLER2D;;False;7;SAMPLER2D;;False;17;FLOAT4;8;FLOAT4;9;FLOAT4;10;FLOAT4;11;FLOAT4;12;FLOAT4;13;FLOAT4;14;FLOAT4;15;FLOAT3;0;FLOAT3;1;FLOAT3;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT3;7;FLOAT3;16
Node;AmplifyShaderEditor.ColorNode;409;-4096,-2944;Half;False;Property;_Color;Grass Color;17;0;Create;False;0;0;False;0;1,1,1,0;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1454;-2357.305,-3221.109;Inherit;False;input_albedo;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1453;-3712,-2688;Inherit;False;1454;input_albedo;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;1320;-3712,-2944;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1427;-3967.958,-1903.023;Inherit;False;Vertex Position (Scaled);-1;;8151;7ac726feb9fc8e94f9ff8184fc5edc35;0;0;4;FLOAT3;0;FLOAT;3;FLOAT;5;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1391;-3943.288,-1749.801;Inherit;False;Property;_RootDarkeningHeight;Root Darkening Height;25;0;Create;False;0;0;False;0;0.5;2;0.0001;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1074;-3392,-2704;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1381;-2253.813,-3523.429;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ComponentMaskNode;1321;-3712,-2816;Inherit;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1356;-3988.575,-1432.909;Half;False;Property;_OcclusionRoots1;Grass Root Darkening Fade In Start;26;0;Create;False;0;0;False;0;32;16;0;64;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;1394;-3411.843,-1778.392;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1300;-1730.816,-1712.445;Inherit;False;Mesh Values (Tree) (Complex) (Vertex Colors);-1;;8157;9cacaefc2ecfddf4c8e070f9be99b854;0;0;4;FLOAT;495;FLOAT;501;FLOAT;550;FLOAT;552
Node;AmplifyShaderEditor.RangedFloatNode;1357;-3994.44,-1334.278;Half;False;Property;_OcclusionRoots2;Grass Root Darkening Fade In Range;27;0;Create;False;0;0;False;0;16;16;0;64;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1287;-1858.238,-3636.831;Half;False;Main_MetallicGlossMap_G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1322;-3200,-2944;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;1307;-1282.816,-1712.445;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;1497;-2944,-2944;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;1500;-3072,-2752;Inherit;False;Property;_Saturation;Saturation;18;0;Create;True;0;0;False;0;1;1;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1340;-3149.22,-1757.718;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1366;-3454.948,-1512.893;Inherit;False;Constant;_Float11;Float 11;26;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1359;-3658.175,-1414.509;Inherit;False;Camera Distance Fade;-1;;8156;2b5f56921ab3ab94bbfa00609d7425b4;0;2;14;FLOAT;10;False;11;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1348;-3579.114,-1594.174;Half;False;Property;_OcclusionRoots;Grass Root Darkening;24;0;Create;False;0;0;False;0;1;0.016;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1292;-3643.259,-1942.871;Inherit;False;1287;Main_MetallicGlossMap_G;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1501;-3072,-2656;Inherit;False;Property;_Brightness;Brightness;19;0;Create;True;0;0;False;0;1;1;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1419;-1472.911,-1560.086;Inherit;False;Property;_PrimaryRollStrength;Primary Roll Strength;47;0;Create;True;0;0;False;0;0.1;2;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1365;-3074.829,-1494.366;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;744;-1858.238,-3444.831;Half;False;Main_MetallicGlossMap_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1502;-2624,-2688;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1328;-994.816,-1728.445;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1499;-2624,-2816;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1290;-2846.866,-1794.695;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1344;-2423.262,-1927.872;Inherit;False;Constant;_Float2;Float 2;22;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1350;-2650.676,-1838.922;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;749;-3860.397,-2228.546;Inherit;False;744;Main_MetallicGlossMap_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;294;-3860.397,-2148.546;Half;False;Property;_Smoothness;Grass Smoothness;22;0;Create;False;0;0;False;0;0.15;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1313;-2523.262,-1685.452;Half;False;Property;_Occlusion;Grass Occlusion;23;0;Create;False;0;0;False;0;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1424;-859.0429,-1735.795;Inherit;False;Wind (Grass);30;;8248;d7f6e9209bef88c48a309bf8b38bad07;0;2;1469;FLOAT3;0,0,0;False;1152;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.HSVToRGBNode;1498;-2432,-2944;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;1342;-2216.262,-1855.872;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;745;-3540.397,-2228.546;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1446;-2176,-2944;Inherit;False;albedo;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1364;-456.4611,-1757.306;Inherit;False;Execute LOD Fade;-1;;8359;18ea34bd83a0d6c4db425672111543e6;0;2;41;FLOAT;0;False;58;FLOAT3;0,0,0;False;3;FLOAT;0;FLOAT3;91;FLOAT;96
Node;AmplifyShaderEditor.GetLocalVarNode;1448;-480.0272,-2517.238;Inherit;False;1446;albedo;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;1451;-207.9165,-2039.169;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1505;-500.6407,-2364.812;Inherit;False;Property;_Cutoff;_Cutoff;46;0;Create;True;0;0;False;0;0.6;0.6;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1443;-2379.59,-3109.592;Inherit;False;normal_world;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1449;-2012.894,-1831.317;Inherit;False;occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;660;-3387.363,-2218.293;Half;False;OUT_SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1315;-1175.432,-2931.854;Half;False;Property;_Occlusion1;Grass Subsurface Low;29;0;Create;False;0;0;False;0;0.1;0;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1506;-128.9482,-2075.549;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1389;-3968,-2560;Inherit;False;Property;_HueVariation;Hue Variation;21;0;Create;False;0;0;True;0;1,0.9661968,0.636,0.2;1,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1426;446.3984,-1793.039;Inherit;False;Internal Features Support;-1;;8372;3c493d142aeebd840af72d626f6915c6;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1404;-1182.348,-3017.912;Half;False;Property;_GrassSubsurfaceStrength;Grass Subsurface Strength;28;0;Create;False;0;0;False;0;0.5;0.01;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1271;-1858.238,-3540.831;Half;False;Main_MetallicGlossMap_B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;1411;-742.9777,-3024.289;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1444;-162.5312,-2843.967;Inherit;False;1443;normal_world;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1410;-1158.462,-3130.78;Inherit;False;1271;Main_MetallicGlossMap_B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1414;-426.2837,-3099.465;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClipNode;1504;-169.6431,-2391.144;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;1452;-117.4165,-1945.669;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TemplateMultiPassSwitchNode;1425;760.238,-1894.934;Inherit;False;0;0;5;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1437;-243.9811,-3104.821;Inherit;False;transmission_strength;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1450;-576.464,-2114.091;Inherit;False;1449;occlusion;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;1503;-2345.704,-3319.305;Inherit;False;True;True;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;654;-545.1434,-2190.65;Inherit;False;660;OUT_SMOOTHNESS;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1492;-747.1294,-2911.468;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1374;432.008,-2101.11;Float;False;False;-1;2;ASEMaterialInspector;0;10;New Amplify Shader;30a8e337ed84177439ca24b6a5c97cd1;True;ShadowCaster;0;4;ShadowCaster;0;False;False;True;False;True;0;False;-1;False;False;False;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=True;True;2;0;False;False;False;False;False;False;True;1;False;-1;False;False;True;1;LightMode=ShadowCaster;False;0;;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1371;432.008,-2134.11;Float;False;False;-1;2;ASEMaterialInspector;0;10;New Amplify Shader;30a8e337ed84177439ca24b6a5c97cd1;True;ForwardAdd;0;1;ForwardAdd;0;False;False;True;False;True;0;False;-1;False;False;False;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=True;True;2;0;True;4;1;False;-1;1;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;True;2;False;-1;False;False;True;1;LightMode=ForwardAdd;False;0;;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1370;432.008,-2382.71;Float;False;True;-1;2;ASEMaterialInspector;0;10;appalachia/impostors/grass-runtime;30a8e337ed84177439ca24b6a5c97cd1;True;ForwardBase;0;0;ForwardBase;10;False;False;True;True;True;0;False;-1;False;False;False;False;False;True;4;RenderType=TransparentCutout=RenderType;Queue=AlphaTest=Queue=0;DisableBatching=True;ImpostorType=HemiOctahedron;True;4;0;False;False;False;False;False;False;True;1;False;-1;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Material Type,InvertActionOnDeselection;0;0;5;True;True;False;False;False;False;;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1372;83.608,-2136.21;Float;False;False;-1;2;ASEMaterialInspector;0;10;New Amplify Shader;30a8e337ed84177439ca24b6a5c97cd1;True;Deferred;0;2;Deferred;0;False;False;True;False;True;0;False;-1;False;False;False;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=True;True;2;0;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;0;;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1373;83.608,-2103.21;Float;False;False;-1;2;ASEMaterialInspector;0;10;New Amplify Shader;30a8e337ed84177439ca24b6a5c97cd1;True;Meta;0;3;Meta;0;False;False;True;False;True;0;False;-1;False;False;False;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=True;True;2;0;False;False;False;True;2;False;-1;False;False;False;False;False;True;1;LightMode=Meta;False;0;;0;0;Standard;0;0
WireConnection;1428;0;1376;0
WireConnection;1454;0;1428;0
WireConnection;1320;0;409;0
WireConnection;1074;0;1320;0
WireConnection;1074;1;1453;0
WireConnection;1381;0;1428;8
WireConnection;1321;0;409;0
WireConnection;1394;0;1427;5
WireConnection;1394;1;1391;0
WireConnection;1287;0;1381;1
WireConnection;1322;0;1453;0
WireConnection;1322;1;1074;0
WireConnection;1322;2;1321;0
WireConnection;1307;0;1300;495
WireConnection;1497;0;1322;0
WireConnection;1340;0;1394;0
WireConnection;1359;14;1356;0
WireConnection;1359;11;1357;0
WireConnection;1365;0;1348;0
WireConnection;1365;1;1366;0
WireConnection;1365;2;1359;0
WireConnection;744;0;1381;3
WireConnection;1502;0;1497;3
WireConnection;1502;1;1501;0
WireConnection;1328;0;1307;0
WireConnection;1328;1;1419;0
WireConnection;1499;0;1497;2
WireConnection;1499;1;1500;0
WireConnection;1290;0;1292;0
WireConnection;1290;1;1340;0
WireConnection;1350;0;1292;0
WireConnection;1350;1;1290;0
WireConnection;1350;2;1365;0
WireConnection;1424;1152;1328;0
WireConnection;1498;0;1497;1
WireConnection;1498;1;1499;0
WireConnection;1498;2;1502;0
WireConnection;1342;0;1344;0
WireConnection;1342;1;1350;0
WireConnection;1342;2;1313;0
WireConnection;745;0;749;0
WireConnection;745;1;294;0
WireConnection;1446;0;1498;0
WireConnection;1364;41;1428;6
WireConnection;1364;58;1424;0
WireConnection;1451;0;1364;0
WireConnection;1443;0;1428;1
WireConnection;1449;0;1342;0
WireConnection;660;0;745;0
WireConnection;1506;0;1364;0
WireConnection;1271;0;1381;2
WireConnection;1411;0;1404;0
WireConnection;1411;1;1315;0
WireConnection;1414;0;1410;0
WireConnection;1414;1;1411;0
WireConnection;1414;2;1492;0
WireConnection;1504;0;1448;0
WireConnection;1504;1;1451;0
WireConnection;1504;2;1505;0
WireConnection;1452;0;1364;91
WireConnection;1425;0;1426;0
WireConnection;1425;1;1426;0
WireConnection;1425;2;1426;0
WireConnection;1425;3;1426;0
WireConnection;1425;4;1426;0
WireConnection;1437;0;1414;0
WireConnection;1503;0;1428;0
WireConnection;1492;0;1404;0
WireConnection;1370;0;1504;0
WireConnection;1370;1;1444;0
WireConnection;1370;4;654;0
WireConnection;1370;5;1450;0
WireConnection;1370;6;1506;0
WireConnection;1370;9;1452;0
ASEEND*/
//CHKSM=59170582B07602DC41DAF9F7B8977AA43822A9B4
