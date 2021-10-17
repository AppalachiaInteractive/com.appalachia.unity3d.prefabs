// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "GPUInstancer/appalachia/impostors/grass-runtime"
{
	Properties
	{
		_AI_ShadowView("Impostor Shadow View", Range( 0 , 1)) = 1
		_AI_ShadowBias("Impostor Shadow Bias", Range( 0 , 2)) = 0.25
		[HideInInspector]_AI_Frames("Impostor Frames", Float) = 0
		[HideInInspector]_AI_FramesX("Impostor Frames X", Float) = 0
		[HideInInspector]_AI_FramesY("Impostor Frames Y", Float) = 0
		[HideInInspector]_AI_ImpostorSize("Impostor Size", Float) = 0
		_AI_Clip("Impostor Clip", Range( 0 , 1)) = 0.5
		[HideInInspector]_AI_Offset("Impostor Offset", Vector) = (0,0,0,0)
		_AI_Parallax("Impostor Parallax", Range( 0 , 1)) = 1
		_AI_TextureBias("Impostor Texture Bias", Float) = -1
		_Color("Grass Color", Color) = (1,1,1,0)
		_AI_HueVariation("Impostor Hue Variation", Color) = (0,0,0,0)
		[Toggle( EFFECT_HUE_VARIATION )] _Hue("Use SpeedTree Hue", Float) = 0
		_HueVariation("Hue Variation", Color) = (1,0.9661968,0.636,0.2)
		[NoScaleOffset]_Albedo("Impostor Albedo & Alpha", 2D) = "white" {}
		[NoScaleOffset]_Normals("Impostor Normal & Depth", 2D) = "white" {}
		[NoScaleOffset]_MAOTS("MAOTS", 2D) = "white" {}
		_Smoothness("Grass Smoothness", Range( 0 , 1)) = 0.15
		_Occlusion("Grass Occlusion", Range( 0 , 1)) = 0.5
		_OcclusionRoots("Grass Root Darkening", Range( 0 , 1)) = 1
		_RootDarkeningHeight("Root Darkening Height", Range( 0.0001 , 2)) = 0.5
		_OcclusionRoots1("Grass Root Darkening Fade In Start", Range( 0 , 64)) = 32
		_OcclusionRoots2("Grass Root Darkening Fade In Range", Range( 0 , 64)) = 16
		_PrimaryRollStrength1("Primary Roll Strength", Range( 0 , 2)) = 0.1
		[HideInInspector]_AI_SizeOffset("Impostor Size Offset", Vector) = (0,0,0,0)
		[HideInInspector]_AI_DepthSize("Impostor Depth Size", Float) = 0

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
#include "UnityCG.cginc"
#include "UnityCG.cginc"
#include "UnityCG.cginc"
			#define _SPECULAR_SETUP 1

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
			// INTERNAL_SHADER_FEATURE_END
			  

			uniform float4 _HueVariation;
			uniform half _WIND_GRASS_STRENGTH;
			uniform float _PrimaryRollStrength1;
			uniform sampler2D _WIND_GUST_TEXTURE;
			uniform half _WIND_BASE_GRASS_FIELD_SIZE;
			uniform half _WIND_BASE_GRASS_CYCLE_TIME;
			uniform half _WIND_BASE_AMPLITUDE;
			uniform half _WIND_BASE_TO_GUST_RATIO;
			uniform half3 _WIND_DIRECTION;
			uniform half _WIND_GUST_GRASS_FIELD_SIZE;
			uniform half _WIND_GUST_GRASS_CYCLE_TIME;
			uniform half _WIND_GUST_AUDIO_STRENGTH_VERYHIGH;
			uniform half _WIND_AUDIO_INFLUENCE;
			uniform half _WIND_GUST_AUDIO_STRENGTH_HIGH;
			uniform half _WIND_GRASS_MICRO_STRENGTH;
			uniform half _WIND_GUST_GRASS_MICRO_FIELD_SIZE;
			uniform half _WIND_GUST_GRASS_MICRO_CYCLE_TIME;
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
			uniform half _Smoothness;
			uniform float _RootDarkeningHeight;
			uniform half _OcclusionRoots;
			uniform half _OcclusionRoots1;
			uniform half _OcclusionRoots2;
			uniform half _Occlusion;
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
			
			inline void OctaImpostorFragment( inout SurfaceOutputStandardSpecular o, out float4 clipPos, out float3 worldPos, float4 uvsFrame1, float4 uvsFrame2, float4 uvsFrame3, float4 octaFrame, float4 interpViewPos, out float4 output0 )
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
				float4 UVsFrame11375 : TEXCOORD5;
				float4 UVsFrame21375 : TEXCOORD6;
				float4 UVsFrame31375 : TEXCOORD7;
				float4 octaframe1375 : TEXCOORD8;
				float4 viewPos1375 : TEXCOORD9;
				float4 ase_texcoord10 : TEXCOORD10;
				float4 ase_texcoord11 : TEXCOORD11;
			};

			v2f_surf vert_surf (appdata_full v ) {
				UNITY_SETUP_INSTANCE_ID(v);
				v2f_surf o;
				UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
				UNITY_TRANSFER_INSTANCE_ID(v,o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float _WIND_PRIMARY_ROLL669_g7365 = ( saturate( v.color.r ) * _PrimaryRollStrength1 );
				float4 color658_g7345 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
				float2 temp_output_61_0_g7351 = float2( 0,0 );
				float3 ase_worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				float2 temp_output_1399_0_g7294 = (ase_worldPos).xz;
				float2 temp_output_1396_0_g7294 = ( temp_output_1399_0_g7294 + ( ( temp_output_1399_0_g7294 % (1.0).xx ) * 0.1 ) );
				float2 temp_output_1_0_g7357 = temp_output_1396_0_g7294;
				float temp_output_2_0_g7358 = _WIND_BASE_GRASS_FIELD_SIZE;
				float temp_output_40_0_g7351 = ( 1.0 / (( temp_output_2_0_g7358 == 0.0 ) ? 1.0 :  temp_output_2_0_g7358 ) );
				float2 temp_cast_0 = (temp_output_40_0_g7351).xx;
				float2 temp_output_2_0_g7357 = temp_cast_0;
				float temp_output_2_0_g7347 = _WIND_BASE_GRASS_CYCLE_TIME;
				float mulTime37_g7351 = _Time.y * ( 1.0 / (( temp_output_2_0_g7347 == 0.0 ) ? 1.0 :  temp_output_2_0_g7347 ) );
				float temp_output_220_0_g7352 = -1.0;
				float4 temp_cast_1 = (temp_output_220_0_g7352).xxxx;
				float temp_output_219_0_g7352 = 1.0;
				float4 temp_cast_2 = (temp_output_219_0_g7352).xxxx;
				float4 clampResult26_g7352 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g7351 > float2( 0,0 ) ) ? ( temp_output_1_0_g7357 / temp_output_2_0_g7357 ) :  ( temp_output_1_0_g7357 * temp_output_2_0_g7357 ) ) + temp_output_61_0_g7351 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g7351 ) ) , temp_cast_1 , temp_cast_2 );
				float4 temp_cast_3 = (temp_output_220_0_g7352).xxxx;
				float4 temp_cast_4 = (temp_output_219_0_g7352).xxxx;
				float4 temp_cast_5 = (0.0).xxxx;
				float4 temp_cast_6 = (temp_output_219_0_g7352).xxxx;
				float temp_output_679_0_g7345 = 1.0;
				float4 temp_cast_7 = (temp_output_679_0_g7345).xxxx;
				float4 temp_output_52_0_g7351 = saturate( pow( abs( (temp_cast_5 + (clampResult26_g7352 - temp_cast_3) * (temp_cast_6 - temp_cast_5) / (temp_cast_4 - temp_cast_3)) ) , temp_cast_7 ) );
				float4 lerpResult656_g7345 = lerp( color658_g7345 , temp_output_52_0_g7351 , temp_output_679_0_g7345);
				float2 break298_g7366 = ( ( (lerpResult656_g7345).rb * 0.33 ) + 0.0 );
				float2 appendResult299_g7366 = (float2(sin( break298_g7366.x ) , cos( break298_g7366.y )));
				float4 temp_output_273_0_g7366 = (-1.0).xxxx;
				float4 temp_output_271_0_g7366 = (1.0).xxxx;
				float2 clampResult26_g7366 = clamp( appendResult299_g7366 , temp_output_273_0_g7366.xy , temp_output_271_0_g7366.xy );
				float2 TRUNK_SWIRL700_g7365 = ( clampResult26_g7366 * (( _WIND_BASE_AMPLITUDE * _WIND_BASE_TO_GUST_RATIO )).xx );
				float2 break699_g7365 = TRUNK_SWIRL700_g7365;
				float3 appendResult698_g7365 = (float3(break699_g7365.x , 0.0 , break699_g7365.y));
				float3 temp_output_684_0_g7365 = ( _WIND_PRIMARY_ROLL669_g7365 * (appendResult698_g7365).xyz );
				float3 _WIND_DIRECTION671_g7365 = _WIND_DIRECTION;
				float4 color658_g7328 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
				float2 temp_output_61_0_g7334 = float2( 0,0 );
				float2 temp_output_1_0_g7340 = temp_output_1396_0_g7294;
				float temp_output_2_0_g7341 = _WIND_GUST_GRASS_FIELD_SIZE;
				float temp_output_40_0_g7334 = ( 1.0 / (( temp_output_2_0_g7341 == 0.0 ) ? 1.0 :  temp_output_2_0_g7341 ) );
				float2 temp_cast_10 = (temp_output_40_0_g7334).xx;
				float2 temp_output_2_0_g7340 = temp_cast_10;
				float temp_output_2_0_g7330 = _WIND_GUST_GRASS_CYCLE_TIME;
				float mulTime37_g7334 = _Time.y * ( 1.0 / (( temp_output_2_0_g7330 == 0.0 ) ? 1.0 :  temp_output_2_0_g7330 ) );
				float temp_output_220_0_g7335 = -1.0;
				float4 temp_cast_11 = (temp_output_220_0_g7335).xxxx;
				float temp_output_219_0_g7335 = 1.0;
				float4 temp_cast_12 = (temp_output_219_0_g7335).xxxx;
				float4 clampResult26_g7335 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g7334 > float2( 0,0 ) ) ? ( temp_output_1_0_g7340 / temp_output_2_0_g7340 ) :  ( temp_output_1_0_g7340 * temp_output_2_0_g7340 ) ) + temp_output_61_0_g7334 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g7334 ) ) , temp_cast_11 , temp_cast_12 );
				float4 temp_cast_13 = (temp_output_220_0_g7335).xxxx;
				float4 temp_cast_14 = (temp_output_219_0_g7335).xxxx;
				float4 temp_cast_15 = (0.0).xxxx;
				float4 temp_cast_16 = (temp_output_219_0_g7335).xxxx;
				float temp_output_679_0_g7328 = 1.0;
				float4 temp_cast_17 = (temp_output_679_0_g7328).xxxx;
				float4 temp_output_52_0_g7334 = saturate( pow( abs( (temp_cast_15 + (clampResult26_g7335 - temp_cast_13) * (temp_cast_16 - temp_cast_15) / (temp_cast_14 - temp_cast_13)) ) , temp_cast_17 ) );
				float4 lerpResult656_g7328 = lerp( color658_g7328 , temp_output_52_0_g7334 , temp_output_679_0_g7328);
				float4 break655_g7328 = lerpResult656_g7328;
				float temp_output_15_0_g7363 = break655_g7328.r;
				float lerpResult638_g7310 = lerp( 1.0 , _WIND_GUST_AUDIO_STRENGTH_VERYHIGH , _WIND_AUDIO_INFLUENCE);
				float temp_output_1344_639_g7294 = lerpResult638_g7310;
				float temp_output_15_0_g7364 = temp_output_1344_639_g7294;
				float lerpResult633_g7310 = lerp( 1.0 , _WIND_GUST_AUDIO_STRENGTH_HIGH , _WIND_AUDIO_INFLUENCE);
				float temp_output_1344_627_g7294 = lerpResult633_g7310;
				float temp_output_16_0_g7364 = temp_output_1344_627_g7294;
				float temp_output_1401_14_g7294 = ( ( temp_output_15_0_g7364 + temp_output_16_0_g7364 ) / 2.0 );
				float temp_output_16_0_g7363 = temp_output_1401_14_g7294;
				float _WIND_GUST_STRENGTH_1845_g7365 = ( ( temp_output_15_0_g7363 + temp_output_16_0_g7363 ) / 2.0 );
				float3 GUST_WAVE798_g7365 = ( ( _WIND_DIRECTION671_g7365 * _WIND_GUST_STRENGTH_1845_g7365 * _WIND_PRIMARY_ROLL669_g7365 ) + ( _WIND_GUST_STRENGTH_1845_g7365 * float3(0,-0.25,0) * _WIND_PRIMARY_ROLL669_g7365 ) );
				float temp_output_1415_0_g7294 = max( temp_output_1344_639_g7294 , temp_output_1344_627_g7294 );
				float4 color658_g7311 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
				float2 temp_output_61_0_g7317 = float2( 0,0 );
				float2 uv01387_g7294 = v.texcoord.xyzw.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g7323 = (uv01387_g7294).xx;
				float temp_output_2_0_g7324 = _WIND_GUST_GRASS_MICRO_FIELD_SIZE;
				float temp_output_40_0_g7317 = ( 1.0 / (( temp_output_2_0_g7324 == 0.0 ) ? 1.0 :  temp_output_2_0_g7324 ) );
				float2 temp_cast_18 = (temp_output_40_0_g7317).xx;
				float2 temp_output_2_0_g7323 = temp_cast_18;
				float temp_output_2_0_g7313 = _WIND_GUST_GRASS_MICRO_CYCLE_TIME;
				float mulTime37_g7317 = _Time.y * ( 1.0 / (( temp_output_2_0_g7313 == 0.0 ) ? 1.0 :  temp_output_2_0_g7313 ) );
				float temp_output_220_0_g7318 = -1.0;
				float4 temp_cast_19 = (temp_output_220_0_g7318).xxxx;
				float temp_output_219_0_g7318 = 1.0;
				float4 temp_cast_20 = (temp_output_219_0_g7318).xxxx;
				float4 clampResult26_g7318 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g7317 > float2( 0,0 ) ) ? ( temp_output_1_0_g7323 / temp_output_2_0_g7323 ) :  ( temp_output_1_0_g7323 * temp_output_2_0_g7323 ) ) + temp_output_61_0_g7317 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g7317 ) ) , temp_cast_19 , temp_cast_20 );
				float4 temp_cast_21 = (temp_output_220_0_g7318).xxxx;
				float4 temp_cast_22 = (temp_output_219_0_g7318).xxxx;
				float4 temp_cast_23 = (0.0).xxxx;
				float4 temp_cast_24 = (temp_output_219_0_g7318).xxxx;
				float temp_output_679_0_g7311 = 1.0;
				float4 temp_cast_25 = (temp_output_679_0_g7311).xxxx;
				float4 temp_output_52_0_g7317 = saturate( pow( abs( (temp_cast_23 + (clampResult26_g7318 - temp_cast_21) * (temp_cast_24 - temp_cast_23) / (temp_cast_22 - temp_cast_21)) ) , temp_cast_25 ) );
				float4 lerpResult656_g7311 = lerp( color658_g7311 , temp_output_52_0_g7317 , temp_output_679_0_g7311);
				float4 break655_g7311 = lerpResult656_g7311;
				float _WIND_GUST_STRENGTH_MICRO769_g7365 = ( _WIND_GRASS_MICRO_STRENGTH * temp_output_1415_0_g7294 * break655_g7311.g );
				float3 GUST_SHIMMY783_g7365 = ( _WIND_DIRECTION671_g7365 * ( _WIND_PRIMARY_ROLL669_g7365 * _WIND_GUST_STRENGTH_MICRO769_g7365 ) );
				float3 GUST_ROLL816_g7365 = float3( 0,0,0 );
				float4 transform813_g7365 = mul(unity_WorldToObject,float4( ( GUST_WAVE798_g7365 + GUST_SHIMMY783_g7365 + GUST_ROLL816_g7365 ) , 0.0 ));
				float3 lerpResult538_g7365 = lerp( temp_output_684_0_g7365 , ( temp_output_684_0_g7365 + (transform813_g7365).xyz ) , temp_output_1415_0_g7294);
				float3 temp_output_41_0_g7432 = ( _WIND_GRASS_STRENGTH * lerpResult538_g7365 );
				float temp_output_63_0_g7433 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
				float3 lerpResult57_g7433 = lerp( temp_output_41_0_g7432 , -v.vertex.xyz , ( 1.0 - temp_output_63_0_g7433 ));
				#ifdef INTERNAL_LODFADE_SCALE
				float3 staticSwitch58_g7432 = lerpResult57_g7433;
				#else
				float3 staticSwitch58_g7432 = temp_output_41_0_g7432;
				#endif
				#ifdef LOD_FADE_CROSSFADE
				float3 staticSwitch62_g7432 = staticSwitch58_g7432;
				#else
				float3 staticSwitch62_g7432 = temp_output_41_0_g7432;
				#endif
				
				OctaImpostorVertex( v.vertex, v.normal, o.UVsFrame11375, o.UVsFrame21375, o.UVsFrame31375, o.octaframe1375, o.viewPos1375 );
				
				o.ase_texcoord10.xyz = ase_worldPos;
				
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord11 = screenPos;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord10.w = 0;

				v.vertex.xyz += staticSwitch62_g7432;
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
				OctaImpostorFragment( o, clipPos, worldPos, IN.UVsFrame11375, IN.UVsFrame21375, IN.UVsFrame31375, IN.octaframe1375, IN.viewPos1375, output0 );
				float3 lerpResult1322 = lerp( o.Albedo , ( (_Color).rgb * o.Albedo ) , (_Color).a);
				float3 temp_output_1109_0 = saturate( lerpResult1322 );
				
				float4 break1381 = output0;
				half Main_MetallicGlossMap_A744 = break1381.w;
				half OUT_SMOOTHNESS660 = ( Main_MetallicGlossMap_A744 * _Smoothness );
				
				half Main_MetallicGlossMap_G1287 = break1381.y;
				float3 ase_worldPos = IN.ase_texcoord10.xyz;
				half localunity_ObjectToWorld0w1_g7290 = ( unity_ObjectToWorld[0].w );
				half localunity_ObjectToWorld1w2_g7290 = ( unity_ObjectToWorld[1].w );
				half localunity_ObjectToWorld2w3_g7290 = ( unity_ObjectToWorld[2].w );
				float3 appendResult6_g7290 = (float3(localunity_ObjectToWorld0w1_g7290 , localunity_ObjectToWorld1w2_g7290 , localunity_ObjectToWorld2w3_g7290));
				float3 temp_output_14_0_g7289 = ( ase_worldPos - appendResult6_g7290 );
				float3 break10_g7289 = temp_output_14_0_g7289;
				float distance22_g7292 = distance( ase_worldPos , _WorldSpaceCameraPos );
				float temp_output_14_0_g7292 = _OcclusionRoots1;
				float temp_output_11_0_g7292 = _OcclusionRoots2;
				float fadeEnd20_g7292 = ( temp_output_14_0_g7292 + temp_output_11_0_g7292 );
				float fadeStart19_g7292 = temp_output_14_0_g7292;
				float fadeLength23_g7292 = temp_output_11_0_g7292;
				float lerpResult1365 = lerp( _OcclusionRoots , 0.0 , saturate( (( distance22_g7292 > fadeEnd20_g7292 ) ? 0.0 :  (( distance22_g7292 < fadeStart19_g7292 ) ? 1.0 :  ( 1.0 - ( ( distance22_g7292 - fadeStart19_g7292 ) / fadeLength23_g7292 ) ) ) ) ));
				float lerpResult1350 = lerp( Main_MetallicGlossMap_G1287 , ( Main_MetallicGlossMap_G1287 * saturate( ( break10_g7289.y / _RootDarkeningHeight ) ) ) , lerpResult1365);
				float lerpResult1342 = lerp( 1.0 , lerpResult1350 , _Occlusion);
				
				float temp_output_41_0_g7426 = o.Alpha;
				float4 screenPos = IN.ase_texcoord11;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float2 clipScreen45_g7427 = ase_screenPosNorm.xy * _ScreenParams.xy;
				float dither45_g7427 = Dither8x8Bayer( fmod(clipScreen45_g7427.x, 8), fmod(clipScreen45_g7427.y, 8) );
				float temp_output_56_0_g7427 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
				dither45_g7427 = step( dither45_g7427, temp_output_56_0_g7427 );
				#ifdef INTERNAL_LODFADE_DITHER
				float staticSwitch50_g7426 = ( temp_output_41_0_g7426 * dither45_g7427 );
				#else
				float staticSwitch50_g7426 = temp_output_41_0_g7426;
				#endif
				#ifdef LOD_FADE_CROSSFADE
				float staticSwitch56_g7426 = staticSwitch50_g7426;
				#else
				float staticSwitch56_g7426 = temp_output_41_0_g7426;
				#endif
				
				fixed3 albedo = temp_output_1109_0;
				fixed3 normal = o.Normal;
				half3 emission = half3( 0, 0, 0 );
				fixed3 specular = temp_output_1109_0;
				fixed metallic = 0;
				half smoothness = OUT_SMOOTHNESS660;
				half occlusion = lerpResult1342;
				fixed alpha = staticSwitch56_g7426;
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
#include "UnityCG.cginc"
#include "UnityCG.cginc"
#include "UnityCG.cginc"
			#define _SPECULAR_SETUP 1

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
			// INTERNAL_SHADER_FEATURE_END
			  

			uniform float4 _HueVariation;
			uniform half _WIND_GRASS_STRENGTH;
			uniform float _PrimaryRollStrength1;
			uniform sampler2D _WIND_GUST_TEXTURE;
			uniform half _WIND_BASE_GRASS_FIELD_SIZE;
			uniform half _WIND_BASE_GRASS_CYCLE_TIME;
			uniform half _WIND_BASE_AMPLITUDE;
			uniform half _WIND_BASE_TO_GUST_RATIO;
			uniform half3 _WIND_DIRECTION;
			uniform half _WIND_GUST_GRASS_FIELD_SIZE;
			uniform half _WIND_GUST_GRASS_CYCLE_TIME;
			uniform half _WIND_GUST_AUDIO_STRENGTH_VERYHIGH;
			uniform half _WIND_AUDIO_INFLUENCE;
			uniform half _WIND_GUST_AUDIO_STRENGTH_HIGH;
			uniform half _WIND_GRASS_MICRO_STRENGTH;
			uniform half _WIND_GUST_GRASS_MICRO_FIELD_SIZE;
			uniform half _WIND_GUST_GRASS_MICRO_CYCLE_TIME;
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
			uniform half _Smoothness;
			uniform float _RootDarkeningHeight;
			uniform half _OcclusionRoots;
			uniform half _OcclusionRoots1;
			uniform half _OcclusionRoots2;
			uniform half _Occlusion;
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
			
			inline void OctaImpostorFragment( inout SurfaceOutputStandardSpecular o, out float4 clipPos, out float3 worldPos, float4 uvsFrame1, float4 uvsFrame2, float4 uvsFrame3, float4 octaFrame, float4 interpViewPos, out float4 output0 )
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
				float4 UVsFrame11375 : TEXCOORD5;
				float4 UVsFrame21375 : TEXCOORD6;
				float4 UVsFrame31375 : TEXCOORD7;
				float4 octaframe1375 : TEXCOORD8;
				float4 viewPos1375 : TEXCOORD9;
				float4 ase_texcoord10 : TEXCOORD10;
				float4 ase_texcoord11 : TEXCOORD11;
			};

			v2f_surf vert_surf ( appdata_full v  ) {
				UNITY_SETUP_INSTANCE_ID(v);
				v2f_surf o;
				UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
				UNITY_TRANSFER_INSTANCE_ID(v,o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float _WIND_PRIMARY_ROLL669_g7365 = ( saturate( v.color.r ) * _PrimaryRollStrength1 );
				float4 color658_g7345 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
				float2 temp_output_61_0_g7351 = float2( 0,0 );
				float3 ase_worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				float2 temp_output_1399_0_g7294 = (ase_worldPos).xz;
				float2 temp_output_1396_0_g7294 = ( temp_output_1399_0_g7294 + ( ( temp_output_1399_0_g7294 % (1.0).xx ) * 0.1 ) );
				float2 temp_output_1_0_g7357 = temp_output_1396_0_g7294;
				float temp_output_2_0_g7358 = _WIND_BASE_GRASS_FIELD_SIZE;
				float temp_output_40_0_g7351 = ( 1.0 / (( temp_output_2_0_g7358 == 0.0 ) ? 1.0 :  temp_output_2_0_g7358 ) );
				float2 temp_cast_0 = (temp_output_40_0_g7351).xx;
				float2 temp_output_2_0_g7357 = temp_cast_0;
				float temp_output_2_0_g7347 = _WIND_BASE_GRASS_CYCLE_TIME;
				float mulTime37_g7351 = _Time.y * ( 1.0 / (( temp_output_2_0_g7347 == 0.0 ) ? 1.0 :  temp_output_2_0_g7347 ) );
				float temp_output_220_0_g7352 = -1.0;
				float4 temp_cast_1 = (temp_output_220_0_g7352).xxxx;
				float temp_output_219_0_g7352 = 1.0;
				float4 temp_cast_2 = (temp_output_219_0_g7352).xxxx;
				float4 clampResult26_g7352 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g7351 > float2( 0,0 ) ) ? ( temp_output_1_0_g7357 / temp_output_2_0_g7357 ) :  ( temp_output_1_0_g7357 * temp_output_2_0_g7357 ) ) + temp_output_61_0_g7351 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g7351 ) ) , temp_cast_1 , temp_cast_2 );
				float4 temp_cast_3 = (temp_output_220_0_g7352).xxxx;
				float4 temp_cast_4 = (temp_output_219_0_g7352).xxxx;
				float4 temp_cast_5 = (0.0).xxxx;
				float4 temp_cast_6 = (temp_output_219_0_g7352).xxxx;
				float temp_output_679_0_g7345 = 1.0;
				float4 temp_cast_7 = (temp_output_679_0_g7345).xxxx;
				float4 temp_output_52_0_g7351 = saturate( pow( abs( (temp_cast_5 + (clampResult26_g7352 - temp_cast_3) * (temp_cast_6 - temp_cast_5) / (temp_cast_4 - temp_cast_3)) ) , temp_cast_7 ) );
				float4 lerpResult656_g7345 = lerp( color658_g7345 , temp_output_52_0_g7351 , temp_output_679_0_g7345);
				float2 break298_g7366 = ( ( (lerpResult656_g7345).rb * 0.33 ) + 0.0 );
				float2 appendResult299_g7366 = (float2(sin( break298_g7366.x ) , cos( break298_g7366.y )));
				float4 temp_output_273_0_g7366 = (-1.0).xxxx;
				float4 temp_output_271_0_g7366 = (1.0).xxxx;
				float2 clampResult26_g7366 = clamp( appendResult299_g7366 , temp_output_273_0_g7366.xy , temp_output_271_0_g7366.xy );
				float2 TRUNK_SWIRL700_g7365 = ( clampResult26_g7366 * (( _WIND_BASE_AMPLITUDE * _WIND_BASE_TO_GUST_RATIO )).xx );
				float2 break699_g7365 = TRUNK_SWIRL700_g7365;
				float3 appendResult698_g7365 = (float3(break699_g7365.x , 0.0 , break699_g7365.y));
				float3 temp_output_684_0_g7365 = ( _WIND_PRIMARY_ROLL669_g7365 * (appendResult698_g7365).xyz );
				float3 _WIND_DIRECTION671_g7365 = _WIND_DIRECTION;
				float4 color658_g7328 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
				float2 temp_output_61_0_g7334 = float2( 0,0 );
				float2 temp_output_1_0_g7340 = temp_output_1396_0_g7294;
				float temp_output_2_0_g7341 = _WIND_GUST_GRASS_FIELD_SIZE;
				float temp_output_40_0_g7334 = ( 1.0 / (( temp_output_2_0_g7341 == 0.0 ) ? 1.0 :  temp_output_2_0_g7341 ) );
				float2 temp_cast_10 = (temp_output_40_0_g7334).xx;
				float2 temp_output_2_0_g7340 = temp_cast_10;
				float temp_output_2_0_g7330 = _WIND_GUST_GRASS_CYCLE_TIME;
				float mulTime37_g7334 = _Time.y * ( 1.0 / (( temp_output_2_0_g7330 == 0.0 ) ? 1.0 :  temp_output_2_0_g7330 ) );
				float temp_output_220_0_g7335 = -1.0;
				float4 temp_cast_11 = (temp_output_220_0_g7335).xxxx;
				float temp_output_219_0_g7335 = 1.0;
				float4 temp_cast_12 = (temp_output_219_0_g7335).xxxx;
				float4 clampResult26_g7335 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g7334 > float2( 0,0 ) ) ? ( temp_output_1_0_g7340 / temp_output_2_0_g7340 ) :  ( temp_output_1_0_g7340 * temp_output_2_0_g7340 ) ) + temp_output_61_0_g7334 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g7334 ) ) , temp_cast_11 , temp_cast_12 );
				float4 temp_cast_13 = (temp_output_220_0_g7335).xxxx;
				float4 temp_cast_14 = (temp_output_219_0_g7335).xxxx;
				float4 temp_cast_15 = (0.0).xxxx;
				float4 temp_cast_16 = (temp_output_219_0_g7335).xxxx;
				float temp_output_679_0_g7328 = 1.0;
				float4 temp_cast_17 = (temp_output_679_0_g7328).xxxx;
				float4 temp_output_52_0_g7334 = saturate( pow( abs( (temp_cast_15 + (clampResult26_g7335 - temp_cast_13) * (temp_cast_16 - temp_cast_15) / (temp_cast_14 - temp_cast_13)) ) , temp_cast_17 ) );
				float4 lerpResult656_g7328 = lerp( color658_g7328 , temp_output_52_0_g7334 , temp_output_679_0_g7328);
				float4 break655_g7328 = lerpResult656_g7328;
				float temp_output_15_0_g7363 = break655_g7328.r;
				float lerpResult638_g7310 = lerp( 1.0 , _WIND_GUST_AUDIO_STRENGTH_VERYHIGH , _WIND_AUDIO_INFLUENCE);
				float temp_output_1344_639_g7294 = lerpResult638_g7310;
				float temp_output_15_0_g7364 = temp_output_1344_639_g7294;
				float lerpResult633_g7310 = lerp( 1.0 , _WIND_GUST_AUDIO_STRENGTH_HIGH , _WIND_AUDIO_INFLUENCE);
				float temp_output_1344_627_g7294 = lerpResult633_g7310;
				float temp_output_16_0_g7364 = temp_output_1344_627_g7294;
				float temp_output_1401_14_g7294 = ( ( temp_output_15_0_g7364 + temp_output_16_0_g7364 ) / 2.0 );
				float temp_output_16_0_g7363 = temp_output_1401_14_g7294;
				float _WIND_GUST_STRENGTH_1845_g7365 = ( ( temp_output_15_0_g7363 + temp_output_16_0_g7363 ) / 2.0 );
				float3 GUST_WAVE798_g7365 = ( ( _WIND_DIRECTION671_g7365 * _WIND_GUST_STRENGTH_1845_g7365 * _WIND_PRIMARY_ROLL669_g7365 ) + ( _WIND_GUST_STRENGTH_1845_g7365 * float3(0,-0.25,0) * _WIND_PRIMARY_ROLL669_g7365 ) );
				float temp_output_1415_0_g7294 = max( temp_output_1344_639_g7294 , temp_output_1344_627_g7294 );
				float4 color658_g7311 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
				float2 temp_output_61_0_g7317 = float2( 0,0 );
				float2 uv01387_g7294 = v.texcoord.xyzw.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g7323 = (uv01387_g7294).xx;
				float temp_output_2_0_g7324 = _WIND_GUST_GRASS_MICRO_FIELD_SIZE;
				float temp_output_40_0_g7317 = ( 1.0 / (( temp_output_2_0_g7324 == 0.0 ) ? 1.0 :  temp_output_2_0_g7324 ) );
				float2 temp_cast_18 = (temp_output_40_0_g7317).xx;
				float2 temp_output_2_0_g7323 = temp_cast_18;
				float temp_output_2_0_g7313 = _WIND_GUST_GRASS_MICRO_CYCLE_TIME;
				float mulTime37_g7317 = _Time.y * ( 1.0 / (( temp_output_2_0_g7313 == 0.0 ) ? 1.0 :  temp_output_2_0_g7313 ) );
				float temp_output_220_0_g7318 = -1.0;
				float4 temp_cast_19 = (temp_output_220_0_g7318).xxxx;
				float temp_output_219_0_g7318 = 1.0;
				float4 temp_cast_20 = (temp_output_219_0_g7318).xxxx;
				float4 clampResult26_g7318 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g7317 > float2( 0,0 ) ) ? ( temp_output_1_0_g7323 / temp_output_2_0_g7323 ) :  ( temp_output_1_0_g7323 * temp_output_2_0_g7323 ) ) + temp_output_61_0_g7317 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g7317 ) ) , temp_cast_19 , temp_cast_20 );
				float4 temp_cast_21 = (temp_output_220_0_g7318).xxxx;
				float4 temp_cast_22 = (temp_output_219_0_g7318).xxxx;
				float4 temp_cast_23 = (0.0).xxxx;
				float4 temp_cast_24 = (temp_output_219_0_g7318).xxxx;
				float temp_output_679_0_g7311 = 1.0;
				float4 temp_cast_25 = (temp_output_679_0_g7311).xxxx;
				float4 temp_output_52_0_g7317 = saturate( pow( abs( (temp_cast_23 + (clampResult26_g7318 - temp_cast_21) * (temp_cast_24 - temp_cast_23) / (temp_cast_22 - temp_cast_21)) ) , temp_cast_25 ) );
				float4 lerpResult656_g7311 = lerp( color658_g7311 , temp_output_52_0_g7317 , temp_output_679_0_g7311);
				float4 break655_g7311 = lerpResult656_g7311;
				float _WIND_GUST_STRENGTH_MICRO769_g7365 = ( _WIND_GRASS_MICRO_STRENGTH * temp_output_1415_0_g7294 * break655_g7311.g );
				float3 GUST_SHIMMY783_g7365 = ( _WIND_DIRECTION671_g7365 * ( _WIND_PRIMARY_ROLL669_g7365 * _WIND_GUST_STRENGTH_MICRO769_g7365 ) );
				float3 GUST_ROLL816_g7365 = float3( 0,0,0 );
				float4 transform813_g7365 = mul(unity_WorldToObject,float4( ( GUST_WAVE798_g7365 + GUST_SHIMMY783_g7365 + GUST_ROLL816_g7365 ) , 0.0 ));
				float3 lerpResult538_g7365 = lerp( temp_output_684_0_g7365 , ( temp_output_684_0_g7365 + (transform813_g7365).xyz ) , temp_output_1415_0_g7294);
				float3 temp_output_41_0_g7432 = ( _WIND_GRASS_STRENGTH * lerpResult538_g7365 );
				float temp_output_63_0_g7433 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
				float3 lerpResult57_g7433 = lerp( temp_output_41_0_g7432 , -v.vertex.xyz , ( 1.0 - temp_output_63_0_g7433 ));
				#ifdef INTERNAL_LODFADE_SCALE
				float3 staticSwitch58_g7432 = lerpResult57_g7433;
				#else
				float3 staticSwitch58_g7432 = temp_output_41_0_g7432;
				#endif
				#ifdef LOD_FADE_CROSSFADE
				float3 staticSwitch62_g7432 = staticSwitch58_g7432;
				#else
				float3 staticSwitch62_g7432 = temp_output_41_0_g7432;
				#endif
				
				OctaImpostorVertex( v.vertex, v.normal, o.UVsFrame11375, o.UVsFrame21375, o.UVsFrame31375, o.octaframe1375, o.viewPos1375 );
				
				o.ase_texcoord10.xyz = ase_worldPos;
				
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord11 = screenPos;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord10.w = 0;

				v.vertex.xyz += staticSwitch62_g7432;
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
				OctaImpostorFragment( o, clipPos, worldPos, IN.UVsFrame11375, IN.UVsFrame21375, IN.UVsFrame31375, IN.octaframe1375, IN.viewPos1375, output0 );
				float3 lerpResult1322 = lerp( o.Albedo , ( (_Color).rgb * o.Albedo ) , (_Color).a);
				float3 temp_output_1109_0 = saturate( lerpResult1322 );
				
				float4 break1381 = output0;
				half Main_MetallicGlossMap_A744 = break1381.w;
				half OUT_SMOOTHNESS660 = ( Main_MetallicGlossMap_A744 * _Smoothness );
				
				half Main_MetallicGlossMap_G1287 = break1381.y;
				float3 ase_worldPos = IN.ase_texcoord10.xyz;
				half localunity_ObjectToWorld0w1_g7290 = ( unity_ObjectToWorld[0].w );
				half localunity_ObjectToWorld1w2_g7290 = ( unity_ObjectToWorld[1].w );
				half localunity_ObjectToWorld2w3_g7290 = ( unity_ObjectToWorld[2].w );
				float3 appendResult6_g7290 = (float3(localunity_ObjectToWorld0w1_g7290 , localunity_ObjectToWorld1w2_g7290 , localunity_ObjectToWorld2w3_g7290));
				float3 temp_output_14_0_g7289 = ( ase_worldPos - appendResult6_g7290 );
				float3 break10_g7289 = temp_output_14_0_g7289;
				float distance22_g7292 = distance( ase_worldPos , _WorldSpaceCameraPos );
				float temp_output_14_0_g7292 = _OcclusionRoots1;
				float temp_output_11_0_g7292 = _OcclusionRoots2;
				float fadeEnd20_g7292 = ( temp_output_14_0_g7292 + temp_output_11_0_g7292 );
				float fadeStart19_g7292 = temp_output_14_0_g7292;
				float fadeLength23_g7292 = temp_output_11_0_g7292;
				float lerpResult1365 = lerp( _OcclusionRoots , 0.0 , saturate( (( distance22_g7292 > fadeEnd20_g7292 ) ? 0.0 :  (( distance22_g7292 < fadeStart19_g7292 ) ? 1.0 :  ( 1.0 - ( ( distance22_g7292 - fadeStart19_g7292 ) / fadeLength23_g7292 ) ) ) ) ));
				float lerpResult1350 = lerp( Main_MetallicGlossMap_G1287 , ( Main_MetallicGlossMap_G1287 * saturate( ( break10_g7289.y / _RootDarkeningHeight ) ) ) , lerpResult1365);
				float lerpResult1342 = lerp( 1.0 , lerpResult1350 , _Occlusion);
				
				float temp_output_41_0_g7426 = o.Alpha;
				float4 screenPos = IN.ase_texcoord11;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float2 clipScreen45_g7427 = ase_screenPosNorm.xy * _ScreenParams.xy;
				float dither45_g7427 = Dither8x8Bayer( fmod(clipScreen45_g7427.x, 8), fmod(clipScreen45_g7427.y, 8) );
				float temp_output_56_0_g7427 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
				dither45_g7427 = step( dither45_g7427, temp_output_56_0_g7427 );
				#ifdef INTERNAL_LODFADE_DITHER
				float staticSwitch50_g7426 = ( temp_output_41_0_g7426 * dither45_g7427 );
				#else
				float staticSwitch50_g7426 = temp_output_41_0_g7426;
				#endif
				#ifdef LOD_FADE_CROSSFADE
				float staticSwitch56_g7426 = staticSwitch50_g7426;
				#else
				float staticSwitch56_g7426 = temp_output_41_0_g7426;
				#endif
				
				fixed3 albedo = temp_output_1109_0;
				fixed3 normal = o.Normal;
				half3 emission = half3( 0, 0, 0 );
				fixed3 specular = temp_output_1109_0;
				fixed metallic = 0;
				half smoothness = OUT_SMOOTHNESS660;
				half occlusion = lerpResult1342;
				fixed alpha = staticSwitch56_g7426;

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
#include "UnityCG.cginc"
#include "UnityCG.cginc"
#include "UnityCG.cginc"
			#define _SPECULAR_SETUP 1

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
			// INTERNAL_SHADER_FEATURE_END
			  

			uniform float4 _HueVariation;
			uniform half _WIND_GRASS_STRENGTH;
			uniform float _PrimaryRollStrength1;
			uniform sampler2D _WIND_GUST_TEXTURE;
			uniform half _WIND_BASE_GRASS_FIELD_SIZE;
			uniform half _WIND_BASE_GRASS_CYCLE_TIME;
			uniform half _WIND_BASE_AMPLITUDE;
			uniform half _WIND_BASE_TO_GUST_RATIO;
			uniform half3 _WIND_DIRECTION;
			uniform half _WIND_GUST_GRASS_FIELD_SIZE;
			uniform half _WIND_GUST_GRASS_CYCLE_TIME;
			uniform half _WIND_GUST_AUDIO_STRENGTH_VERYHIGH;
			uniform half _WIND_AUDIO_INFLUENCE;
			uniform half _WIND_GUST_AUDIO_STRENGTH_HIGH;
			uniform half _WIND_GRASS_MICRO_STRENGTH;
			uniform half _WIND_GUST_GRASS_MICRO_FIELD_SIZE;
			uniform half _WIND_GUST_GRASS_MICRO_CYCLE_TIME;
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
			uniform half _Smoothness;
			uniform float _RootDarkeningHeight;
			uniform half _OcclusionRoots;
			uniform half _OcclusionRoots1;
			uniform half _OcclusionRoots2;
			uniform half _Occlusion;
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
			
			inline void OctaImpostorFragment( inout SurfaceOutputStandardSpecular o, out float4 clipPos, out float3 worldPos, float4 uvsFrame1, float4 uvsFrame2, float4 uvsFrame3, float4 octaFrame, float4 interpViewPos, out float4 output0 )
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
				float4 UVsFrame11375 : TEXCOORD5;
				float4 UVsFrame21375 : TEXCOORD6;
				float4 UVsFrame31375 : TEXCOORD7;
				float4 octaframe1375 : TEXCOORD8;
				float4 viewPos1375 : TEXCOORD9;
				float4 ase_texcoord10 : TEXCOORD10;
				float4 ase_texcoord11 : TEXCOORD11;
			};

			v2f_surf vert_surf (appdata_full v ) {
				UNITY_SETUP_INSTANCE_ID(v);
				v2f_surf o;
				UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
				UNITY_TRANSFER_INSTANCE_ID(v,o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float _WIND_PRIMARY_ROLL669_g7365 = ( saturate( v.color.r ) * _PrimaryRollStrength1 );
				float4 color658_g7345 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
				float2 temp_output_61_0_g7351 = float2( 0,0 );
				float3 ase_worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				float2 temp_output_1399_0_g7294 = (ase_worldPos).xz;
				float2 temp_output_1396_0_g7294 = ( temp_output_1399_0_g7294 + ( ( temp_output_1399_0_g7294 % (1.0).xx ) * 0.1 ) );
				float2 temp_output_1_0_g7357 = temp_output_1396_0_g7294;
				float temp_output_2_0_g7358 = _WIND_BASE_GRASS_FIELD_SIZE;
				float temp_output_40_0_g7351 = ( 1.0 / (( temp_output_2_0_g7358 == 0.0 ) ? 1.0 :  temp_output_2_0_g7358 ) );
				float2 temp_cast_0 = (temp_output_40_0_g7351).xx;
				float2 temp_output_2_0_g7357 = temp_cast_0;
				float temp_output_2_0_g7347 = _WIND_BASE_GRASS_CYCLE_TIME;
				float mulTime37_g7351 = _Time.y * ( 1.0 / (( temp_output_2_0_g7347 == 0.0 ) ? 1.0 :  temp_output_2_0_g7347 ) );
				float temp_output_220_0_g7352 = -1.0;
				float4 temp_cast_1 = (temp_output_220_0_g7352).xxxx;
				float temp_output_219_0_g7352 = 1.0;
				float4 temp_cast_2 = (temp_output_219_0_g7352).xxxx;
				float4 clampResult26_g7352 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g7351 > float2( 0,0 ) ) ? ( temp_output_1_0_g7357 / temp_output_2_0_g7357 ) :  ( temp_output_1_0_g7357 * temp_output_2_0_g7357 ) ) + temp_output_61_0_g7351 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g7351 ) ) , temp_cast_1 , temp_cast_2 );
				float4 temp_cast_3 = (temp_output_220_0_g7352).xxxx;
				float4 temp_cast_4 = (temp_output_219_0_g7352).xxxx;
				float4 temp_cast_5 = (0.0).xxxx;
				float4 temp_cast_6 = (temp_output_219_0_g7352).xxxx;
				float temp_output_679_0_g7345 = 1.0;
				float4 temp_cast_7 = (temp_output_679_0_g7345).xxxx;
				float4 temp_output_52_0_g7351 = saturate( pow( abs( (temp_cast_5 + (clampResult26_g7352 - temp_cast_3) * (temp_cast_6 - temp_cast_5) / (temp_cast_4 - temp_cast_3)) ) , temp_cast_7 ) );
				float4 lerpResult656_g7345 = lerp( color658_g7345 , temp_output_52_0_g7351 , temp_output_679_0_g7345);
				float2 break298_g7366 = ( ( (lerpResult656_g7345).rb * 0.33 ) + 0.0 );
				float2 appendResult299_g7366 = (float2(sin( break298_g7366.x ) , cos( break298_g7366.y )));
				float4 temp_output_273_0_g7366 = (-1.0).xxxx;
				float4 temp_output_271_0_g7366 = (1.0).xxxx;
				float2 clampResult26_g7366 = clamp( appendResult299_g7366 , temp_output_273_0_g7366.xy , temp_output_271_0_g7366.xy );
				float2 TRUNK_SWIRL700_g7365 = ( clampResult26_g7366 * (( _WIND_BASE_AMPLITUDE * _WIND_BASE_TO_GUST_RATIO )).xx );
				float2 break699_g7365 = TRUNK_SWIRL700_g7365;
				float3 appendResult698_g7365 = (float3(break699_g7365.x , 0.0 , break699_g7365.y));
				float3 temp_output_684_0_g7365 = ( _WIND_PRIMARY_ROLL669_g7365 * (appendResult698_g7365).xyz );
				float3 _WIND_DIRECTION671_g7365 = _WIND_DIRECTION;
				float4 color658_g7328 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
				float2 temp_output_61_0_g7334 = float2( 0,0 );
				float2 temp_output_1_0_g7340 = temp_output_1396_0_g7294;
				float temp_output_2_0_g7341 = _WIND_GUST_GRASS_FIELD_SIZE;
				float temp_output_40_0_g7334 = ( 1.0 / (( temp_output_2_0_g7341 == 0.0 ) ? 1.0 :  temp_output_2_0_g7341 ) );
				float2 temp_cast_10 = (temp_output_40_0_g7334).xx;
				float2 temp_output_2_0_g7340 = temp_cast_10;
				float temp_output_2_0_g7330 = _WIND_GUST_GRASS_CYCLE_TIME;
				float mulTime37_g7334 = _Time.y * ( 1.0 / (( temp_output_2_0_g7330 == 0.0 ) ? 1.0 :  temp_output_2_0_g7330 ) );
				float temp_output_220_0_g7335 = -1.0;
				float4 temp_cast_11 = (temp_output_220_0_g7335).xxxx;
				float temp_output_219_0_g7335 = 1.0;
				float4 temp_cast_12 = (temp_output_219_0_g7335).xxxx;
				float4 clampResult26_g7335 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g7334 > float2( 0,0 ) ) ? ( temp_output_1_0_g7340 / temp_output_2_0_g7340 ) :  ( temp_output_1_0_g7340 * temp_output_2_0_g7340 ) ) + temp_output_61_0_g7334 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g7334 ) ) , temp_cast_11 , temp_cast_12 );
				float4 temp_cast_13 = (temp_output_220_0_g7335).xxxx;
				float4 temp_cast_14 = (temp_output_219_0_g7335).xxxx;
				float4 temp_cast_15 = (0.0).xxxx;
				float4 temp_cast_16 = (temp_output_219_0_g7335).xxxx;
				float temp_output_679_0_g7328 = 1.0;
				float4 temp_cast_17 = (temp_output_679_0_g7328).xxxx;
				float4 temp_output_52_0_g7334 = saturate( pow( abs( (temp_cast_15 + (clampResult26_g7335 - temp_cast_13) * (temp_cast_16 - temp_cast_15) / (temp_cast_14 - temp_cast_13)) ) , temp_cast_17 ) );
				float4 lerpResult656_g7328 = lerp( color658_g7328 , temp_output_52_0_g7334 , temp_output_679_0_g7328);
				float4 break655_g7328 = lerpResult656_g7328;
				float temp_output_15_0_g7363 = break655_g7328.r;
				float lerpResult638_g7310 = lerp( 1.0 , _WIND_GUST_AUDIO_STRENGTH_VERYHIGH , _WIND_AUDIO_INFLUENCE);
				float temp_output_1344_639_g7294 = lerpResult638_g7310;
				float temp_output_15_0_g7364 = temp_output_1344_639_g7294;
				float lerpResult633_g7310 = lerp( 1.0 , _WIND_GUST_AUDIO_STRENGTH_HIGH , _WIND_AUDIO_INFLUENCE);
				float temp_output_1344_627_g7294 = lerpResult633_g7310;
				float temp_output_16_0_g7364 = temp_output_1344_627_g7294;
				float temp_output_1401_14_g7294 = ( ( temp_output_15_0_g7364 + temp_output_16_0_g7364 ) / 2.0 );
				float temp_output_16_0_g7363 = temp_output_1401_14_g7294;
				float _WIND_GUST_STRENGTH_1845_g7365 = ( ( temp_output_15_0_g7363 + temp_output_16_0_g7363 ) / 2.0 );
				float3 GUST_WAVE798_g7365 = ( ( _WIND_DIRECTION671_g7365 * _WIND_GUST_STRENGTH_1845_g7365 * _WIND_PRIMARY_ROLL669_g7365 ) + ( _WIND_GUST_STRENGTH_1845_g7365 * float3(0,-0.25,0) * _WIND_PRIMARY_ROLL669_g7365 ) );
				float temp_output_1415_0_g7294 = max( temp_output_1344_639_g7294 , temp_output_1344_627_g7294 );
				float4 color658_g7311 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
				float2 temp_output_61_0_g7317 = float2( 0,0 );
				float2 uv01387_g7294 = v.texcoord.xyzw.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g7323 = (uv01387_g7294).xx;
				float temp_output_2_0_g7324 = _WIND_GUST_GRASS_MICRO_FIELD_SIZE;
				float temp_output_40_0_g7317 = ( 1.0 / (( temp_output_2_0_g7324 == 0.0 ) ? 1.0 :  temp_output_2_0_g7324 ) );
				float2 temp_cast_18 = (temp_output_40_0_g7317).xx;
				float2 temp_output_2_0_g7323 = temp_cast_18;
				float temp_output_2_0_g7313 = _WIND_GUST_GRASS_MICRO_CYCLE_TIME;
				float mulTime37_g7317 = _Time.y * ( 1.0 / (( temp_output_2_0_g7313 == 0.0 ) ? 1.0 :  temp_output_2_0_g7313 ) );
				float temp_output_220_0_g7318 = -1.0;
				float4 temp_cast_19 = (temp_output_220_0_g7318).xxxx;
				float temp_output_219_0_g7318 = 1.0;
				float4 temp_cast_20 = (temp_output_219_0_g7318).xxxx;
				float4 clampResult26_g7318 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g7317 > float2( 0,0 ) ) ? ( temp_output_1_0_g7323 / temp_output_2_0_g7323 ) :  ( temp_output_1_0_g7323 * temp_output_2_0_g7323 ) ) + temp_output_61_0_g7317 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g7317 ) ) , temp_cast_19 , temp_cast_20 );
				float4 temp_cast_21 = (temp_output_220_0_g7318).xxxx;
				float4 temp_cast_22 = (temp_output_219_0_g7318).xxxx;
				float4 temp_cast_23 = (0.0).xxxx;
				float4 temp_cast_24 = (temp_output_219_0_g7318).xxxx;
				float temp_output_679_0_g7311 = 1.0;
				float4 temp_cast_25 = (temp_output_679_0_g7311).xxxx;
				float4 temp_output_52_0_g7317 = saturate( pow( abs( (temp_cast_23 + (clampResult26_g7318 - temp_cast_21) * (temp_cast_24 - temp_cast_23) / (temp_cast_22 - temp_cast_21)) ) , temp_cast_25 ) );
				float4 lerpResult656_g7311 = lerp( color658_g7311 , temp_output_52_0_g7317 , temp_output_679_0_g7311);
				float4 break655_g7311 = lerpResult656_g7311;
				float _WIND_GUST_STRENGTH_MICRO769_g7365 = ( _WIND_GRASS_MICRO_STRENGTH * temp_output_1415_0_g7294 * break655_g7311.g );
				float3 GUST_SHIMMY783_g7365 = ( _WIND_DIRECTION671_g7365 * ( _WIND_PRIMARY_ROLL669_g7365 * _WIND_GUST_STRENGTH_MICRO769_g7365 ) );
				float3 GUST_ROLL816_g7365 = float3( 0,0,0 );
				float4 transform813_g7365 = mul(unity_WorldToObject,float4( ( GUST_WAVE798_g7365 + GUST_SHIMMY783_g7365 + GUST_ROLL816_g7365 ) , 0.0 ));
				float3 lerpResult538_g7365 = lerp( temp_output_684_0_g7365 , ( temp_output_684_0_g7365 + (transform813_g7365).xyz ) , temp_output_1415_0_g7294);
				float3 temp_output_41_0_g7432 = ( _WIND_GRASS_STRENGTH * lerpResult538_g7365 );
				float temp_output_63_0_g7433 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
				float3 lerpResult57_g7433 = lerp( temp_output_41_0_g7432 , -v.vertex.xyz , ( 1.0 - temp_output_63_0_g7433 ));
				#ifdef INTERNAL_LODFADE_SCALE
				float3 staticSwitch58_g7432 = lerpResult57_g7433;
				#else
				float3 staticSwitch58_g7432 = temp_output_41_0_g7432;
				#endif
				#ifdef LOD_FADE_CROSSFADE
				float3 staticSwitch62_g7432 = staticSwitch58_g7432;
				#else
				float3 staticSwitch62_g7432 = temp_output_41_0_g7432;
				#endif
				
				OctaImpostorVertex( v.vertex, v.normal, o.UVsFrame11375, o.UVsFrame21375, o.UVsFrame31375, o.octaframe1375, o.viewPos1375 );
				
				o.ase_texcoord10.xyz = ase_worldPos;
				
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord11 = screenPos;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord10.w = 0;

				v.vertex.xyz += staticSwitch62_g7432;
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
				float4 output0 = 0;
				OctaImpostorFragment( o, clipPos, worldPos, IN.UVsFrame11375, IN.UVsFrame21375, IN.UVsFrame31375, IN.octaframe1375, IN.viewPos1375, output0 );
				float3 lerpResult1322 = lerp( o.Albedo , ( (_Color).rgb * o.Albedo ) , (_Color).a);
				float3 temp_output_1109_0 = saturate( lerpResult1322 );
				
				float4 break1381 = output0;
				half Main_MetallicGlossMap_A744 = break1381.w;
				half OUT_SMOOTHNESS660 = ( Main_MetallicGlossMap_A744 * _Smoothness );
				
				half Main_MetallicGlossMap_G1287 = break1381.y;
				float3 ase_worldPos = IN.ase_texcoord10.xyz;
				half localunity_ObjectToWorld0w1_g7290 = ( unity_ObjectToWorld[0].w );
				half localunity_ObjectToWorld1w2_g7290 = ( unity_ObjectToWorld[1].w );
				half localunity_ObjectToWorld2w3_g7290 = ( unity_ObjectToWorld[2].w );
				float3 appendResult6_g7290 = (float3(localunity_ObjectToWorld0w1_g7290 , localunity_ObjectToWorld1w2_g7290 , localunity_ObjectToWorld2w3_g7290));
				float3 temp_output_14_0_g7289 = ( ase_worldPos - appendResult6_g7290 );
				float3 break10_g7289 = temp_output_14_0_g7289;
				float distance22_g7292 = distance( ase_worldPos , _WorldSpaceCameraPos );
				float temp_output_14_0_g7292 = _OcclusionRoots1;
				float temp_output_11_0_g7292 = _OcclusionRoots2;
				float fadeEnd20_g7292 = ( temp_output_14_0_g7292 + temp_output_11_0_g7292 );
				float fadeStart19_g7292 = temp_output_14_0_g7292;
				float fadeLength23_g7292 = temp_output_11_0_g7292;
				float lerpResult1365 = lerp( _OcclusionRoots , 0.0 , saturate( (( distance22_g7292 > fadeEnd20_g7292 ) ? 0.0 :  (( distance22_g7292 < fadeStart19_g7292 ) ? 1.0 :  ( 1.0 - ( ( distance22_g7292 - fadeStart19_g7292 ) / fadeLength23_g7292 ) ) ) ) ));
				float lerpResult1350 = lerp( Main_MetallicGlossMap_G1287 , ( Main_MetallicGlossMap_G1287 * saturate( ( break10_g7289.y / _RootDarkeningHeight ) ) ) , lerpResult1365);
				float lerpResult1342 = lerp( 1.0 , lerpResult1350 , _Occlusion);
				
				float temp_output_41_0_g7426 = o.Alpha;
				float4 screenPos = IN.ase_texcoord11;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float2 clipScreen45_g7427 = ase_screenPosNorm.xy * _ScreenParams.xy;
				float dither45_g7427 = Dither8x8Bayer( fmod(clipScreen45_g7427.x, 8), fmod(clipScreen45_g7427.y, 8) );
				float temp_output_56_0_g7427 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
				dither45_g7427 = step( dither45_g7427, temp_output_56_0_g7427 );
				#ifdef INTERNAL_LODFADE_DITHER
				float staticSwitch50_g7426 = ( temp_output_41_0_g7426 * dither45_g7427 );
				#else
				float staticSwitch50_g7426 = temp_output_41_0_g7426;
				#endif
				#ifdef LOD_FADE_CROSSFADE
				float staticSwitch56_g7426 = staticSwitch50_g7426;
				#else
				float staticSwitch56_g7426 = temp_output_41_0_g7426;
				#endif
				
				fixed3 albedo = temp_output_1109_0;
				fixed3 normal = o.Normal;
				half3 emission = half3( 0, 0, 0 );
				fixed3 specular = temp_output_1109_0;
				fixed metallic = 0;
				half smoothness = OUT_SMOOTHNESS660;
				half occlusion = lerpResult1342;
				fixed alpha = staticSwitch56_g7426;
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
#include "UnityCG.cginc"
#include "UnityCG.cginc"
#include "UnityCG.cginc"
			#define _SPECULAR_SETUP 1

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
			// INTERNAL_SHADER_FEATURE_END
			  

			uniform float4 _HueVariation;
			uniform half _WIND_GRASS_STRENGTH;
			uniform float _PrimaryRollStrength1;
			uniform sampler2D _WIND_GUST_TEXTURE;
			uniform half _WIND_BASE_GRASS_FIELD_SIZE;
			uniform half _WIND_BASE_GRASS_CYCLE_TIME;
			uniform half _WIND_BASE_AMPLITUDE;
			uniform half _WIND_BASE_TO_GUST_RATIO;
			uniform half3 _WIND_DIRECTION;
			uniform half _WIND_GUST_GRASS_FIELD_SIZE;
			uniform half _WIND_GUST_GRASS_CYCLE_TIME;
			uniform half _WIND_GUST_AUDIO_STRENGTH_VERYHIGH;
			uniform half _WIND_AUDIO_INFLUENCE;
			uniform half _WIND_GUST_AUDIO_STRENGTH_HIGH;
			uniform half _WIND_GRASS_MICRO_STRENGTH;
			uniform half _WIND_GUST_GRASS_MICRO_FIELD_SIZE;
			uniform half _WIND_GUST_GRASS_MICRO_CYCLE_TIME;
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
			uniform half _Smoothness;
			uniform float _RootDarkeningHeight;
			uniform half _OcclusionRoots;
			uniform half _OcclusionRoots1;
			uniform half _OcclusionRoots2;
			uniform half _Occlusion;
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
			
			inline void OctaImpostorFragment( inout SurfaceOutputStandardSpecular o, out float4 clipPos, out float3 worldPos, float4 uvsFrame1, float4 uvsFrame2, float4 uvsFrame3, float4 octaFrame, float4 interpViewPos, out float4 output0 )
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
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 UVsFrame11375 : TEXCOORD5;
				float4 UVsFrame21375 : TEXCOORD6;
				float4 UVsFrame31375 : TEXCOORD7;
				float4 octaframe1375 : TEXCOORD8;
				float4 viewPos1375 : TEXCOORD9;
				float4 ase_texcoord10 : TEXCOORD10;
				float4 ase_texcoord11 : TEXCOORD11;
			};

			v2f_surf vert_surf (appdata_full v ) {
				UNITY_SETUP_INSTANCE_ID(v);
				v2f_surf o;
				UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
				UNITY_TRANSFER_INSTANCE_ID(v,o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float _WIND_PRIMARY_ROLL669_g7365 = ( saturate( v.color.r ) * _PrimaryRollStrength1 );
				float4 color658_g7345 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
				float2 temp_output_61_0_g7351 = float2( 0,0 );
				float3 ase_worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				float2 temp_output_1399_0_g7294 = (ase_worldPos).xz;
				float2 temp_output_1396_0_g7294 = ( temp_output_1399_0_g7294 + ( ( temp_output_1399_0_g7294 % (1.0).xx ) * 0.1 ) );
				float2 temp_output_1_0_g7357 = temp_output_1396_0_g7294;
				float temp_output_2_0_g7358 = _WIND_BASE_GRASS_FIELD_SIZE;
				float temp_output_40_0_g7351 = ( 1.0 / (( temp_output_2_0_g7358 == 0.0 ) ? 1.0 :  temp_output_2_0_g7358 ) );
				float2 temp_cast_0 = (temp_output_40_0_g7351).xx;
				float2 temp_output_2_0_g7357 = temp_cast_0;
				float temp_output_2_0_g7347 = _WIND_BASE_GRASS_CYCLE_TIME;
				float mulTime37_g7351 = _Time.y * ( 1.0 / (( temp_output_2_0_g7347 == 0.0 ) ? 1.0 :  temp_output_2_0_g7347 ) );
				float temp_output_220_0_g7352 = -1.0;
				float4 temp_cast_1 = (temp_output_220_0_g7352).xxxx;
				float temp_output_219_0_g7352 = 1.0;
				float4 temp_cast_2 = (temp_output_219_0_g7352).xxxx;
				float4 clampResult26_g7352 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g7351 > float2( 0,0 ) ) ? ( temp_output_1_0_g7357 / temp_output_2_0_g7357 ) :  ( temp_output_1_0_g7357 * temp_output_2_0_g7357 ) ) + temp_output_61_0_g7351 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g7351 ) ) , temp_cast_1 , temp_cast_2 );
				float4 temp_cast_3 = (temp_output_220_0_g7352).xxxx;
				float4 temp_cast_4 = (temp_output_219_0_g7352).xxxx;
				float4 temp_cast_5 = (0.0).xxxx;
				float4 temp_cast_6 = (temp_output_219_0_g7352).xxxx;
				float temp_output_679_0_g7345 = 1.0;
				float4 temp_cast_7 = (temp_output_679_0_g7345).xxxx;
				float4 temp_output_52_0_g7351 = saturate( pow( abs( (temp_cast_5 + (clampResult26_g7352 - temp_cast_3) * (temp_cast_6 - temp_cast_5) / (temp_cast_4 - temp_cast_3)) ) , temp_cast_7 ) );
				float4 lerpResult656_g7345 = lerp( color658_g7345 , temp_output_52_0_g7351 , temp_output_679_0_g7345);
				float2 break298_g7366 = ( ( (lerpResult656_g7345).rb * 0.33 ) + 0.0 );
				float2 appendResult299_g7366 = (float2(sin( break298_g7366.x ) , cos( break298_g7366.y )));
				float4 temp_output_273_0_g7366 = (-1.0).xxxx;
				float4 temp_output_271_0_g7366 = (1.0).xxxx;
				float2 clampResult26_g7366 = clamp( appendResult299_g7366 , temp_output_273_0_g7366.xy , temp_output_271_0_g7366.xy );
				float2 TRUNK_SWIRL700_g7365 = ( clampResult26_g7366 * (( _WIND_BASE_AMPLITUDE * _WIND_BASE_TO_GUST_RATIO )).xx );
				float2 break699_g7365 = TRUNK_SWIRL700_g7365;
				float3 appendResult698_g7365 = (float3(break699_g7365.x , 0.0 , break699_g7365.y));
				float3 temp_output_684_0_g7365 = ( _WIND_PRIMARY_ROLL669_g7365 * (appendResult698_g7365).xyz );
				float3 _WIND_DIRECTION671_g7365 = _WIND_DIRECTION;
				float4 color658_g7328 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
				float2 temp_output_61_0_g7334 = float2( 0,0 );
				float2 temp_output_1_0_g7340 = temp_output_1396_0_g7294;
				float temp_output_2_0_g7341 = _WIND_GUST_GRASS_FIELD_SIZE;
				float temp_output_40_0_g7334 = ( 1.0 / (( temp_output_2_0_g7341 == 0.0 ) ? 1.0 :  temp_output_2_0_g7341 ) );
				float2 temp_cast_10 = (temp_output_40_0_g7334).xx;
				float2 temp_output_2_0_g7340 = temp_cast_10;
				float temp_output_2_0_g7330 = _WIND_GUST_GRASS_CYCLE_TIME;
				float mulTime37_g7334 = _Time.y * ( 1.0 / (( temp_output_2_0_g7330 == 0.0 ) ? 1.0 :  temp_output_2_0_g7330 ) );
				float temp_output_220_0_g7335 = -1.0;
				float4 temp_cast_11 = (temp_output_220_0_g7335).xxxx;
				float temp_output_219_0_g7335 = 1.0;
				float4 temp_cast_12 = (temp_output_219_0_g7335).xxxx;
				float4 clampResult26_g7335 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g7334 > float2( 0,0 ) ) ? ( temp_output_1_0_g7340 / temp_output_2_0_g7340 ) :  ( temp_output_1_0_g7340 * temp_output_2_0_g7340 ) ) + temp_output_61_0_g7334 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g7334 ) ) , temp_cast_11 , temp_cast_12 );
				float4 temp_cast_13 = (temp_output_220_0_g7335).xxxx;
				float4 temp_cast_14 = (temp_output_219_0_g7335).xxxx;
				float4 temp_cast_15 = (0.0).xxxx;
				float4 temp_cast_16 = (temp_output_219_0_g7335).xxxx;
				float temp_output_679_0_g7328 = 1.0;
				float4 temp_cast_17 = (temp_output_679_0_g7328).xxxx;
				float4 temp_output_52_0_g7334 = saturate( pow( abs( (temp_cast_15 + (clampResult26_g7335 - temp_cast_13) * (temp_cast_16 - temp_cast_15) / (temp_cast_14 - temp_cast_13)) ) , temp_cast_17 ) );
				float4 lerpResult656_g7328 = lerp( color658_g7328 , temp_output_52_0_g7334 , temp_output_679_0_g7328);
				float4 break655_g7328 = lerpResult656_g7328;
				float temp_output_15_0_g7363 = break655_g7328.r;
				float lerpResult638_g7310 = lerp( 1.0 , _WIND_GUST_AUDIO_STRENGTH_VERYHIGH , _WIND_AUDIO_INFLUENCE);
				float temp_output_1344_639_g7294 = lerpResult638_g7310;
				float temp_output_15_0_g7364 = temp_output_1344_639_g7294;
				float lerpResult633_g7310 = lerp( 1.0 , _WIND_GUST_AUDIO_STRENGTH_HIGH , _WIND_AUDIO_INFLUENCE);
				float temp_output_1344_627_g7294 = lerpResult633_g7310;
				float temp_output_16_0_g7364 = temp_output_1344_627_g7294;
				float temp_output_1401_14_g7294 = ( ( temp_output_15_0_g7364 + temp_output_16_0_g7364 ) / 2.0 );
				float temp_output_16_0_g7363 = temp_output_1401_14_g7294;
				float _WIND_GUST_STRENGTH_1845_g7365 = ( ( temp_output_15_0_g7363 + temp_output_16_0_g7363 ) / 2.0 );
				float3 GUST_WAVE798_g7365 = ( ( _WIND_DIRECTION671_g7365 * _WIND_GUST_STRENGTH_1845_g7365 * _WIND_PRIMARY_ROLL669_g7365 ) + ( _WIND_GUST_STRENGTH_1845_g7365 * float3(0,-0.25,0) * _WIND_PRIMARY_ROLL669_g7365 ) );
				float temp_output_1415_0_g7294 = max( temp_output_1344_639_g7294 , temp_output_1344_627_g7294 );
				float4 color658_g7311 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
				float2 temp_output_61_0_g7317 = float2( 0,0 );
				float2 uv01387_g7294 = v.texcoord.xyzw.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g7323 = (uv01387_g7294).xx;
				float temp_output_2_0_g7324 = _WIND_GUST_GRASS_MICRO_FIELD_SIZE;
				float temp_output_40_0_g7317 = ( 1.0 / (( temp_output_2_0_g7324 == 0.0 ) ? 1.0 :  temp_output_2_0_g7324 ) );
				float2 temp_cast_18 = (temp_output_40_0_g7317).xx;
				float2 temp_output_2_0_g7323 = temp_cast_18;
				float temp_output_2_0_g7313 = _WIND_GUST_GRASS_MICRO_CYCLE_TIME;
				float mulTime37_g7317 = _Time.y * ( 1.0 / (( temp_output_2_0_g7313 == 0.0 ) ? 1.0 :  temp_output_2_0_g7313 ) );
				float temp_output_220_0_g7318 = -1.0;
				float4 temp_cast_19 = (temp_output_220_0_g7318).xxxx;
				float temp_output_219_0_g7318 = 1.0;
				float4 temp_cast_20 = (temp_output_219_0_g7318).xxxx;
				float4 clampResult26_g7318 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g7317 > float2( 0,0 ) ) ? ( temp_output_1_0_g7323 / temp_output_2_0_g7323 ) :  ( temp_output_1_0_g7323 * temp_output_2_0_g7323 ) ) + temp_output_61_0_g7317 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g7317 ) ) , temp_cast_19 , temp_cast_20 );
				float4 temp_cast_21 = (temp_output_220_0_g7318).xxxx;
				float4 temp_cast_22 = (temp_output_219_0_g7318).xxxx;
				float4 temp_cast_23 = (0.0).xxxx;
				float4 temp_cast_24 = (temp_output_219_0_g7318).xxxx;
				float temp_output_679_0_g7311 = 1.0;
				float4 temp_cast_25 = (temp_output_679_0_g7311).xxxx;
				float4 temp_output_52_0_g7317 = saturate( pow( abs( (temp_cast_23 + (clampResult26_g7318 - temp_cast_21) * (temp_cast_24 - temp_cast_23) / (temp_cast_22 - temp_cast_21)) ) , temp_cast_25 ) );
				float4 lerpResult656_g7311 = lerp( color658_g7311 , temp_output_52_0_g7317 , temp_output_679_0_g7311);
				float4 break655_g7311 = lerpResult656_g7311;
				float _WIND_GUST_STRENGTH_MICRO769_g7365 = ( _WIND_GRASS_MICRO_STRENGTH * temp_output_1415_0_g7294 * break655_g7311.g );
				float3 GUST_SHIMMY783_g7365 = ( _WIND_DIRECTION671_g7365 * ( _WIND_PRIMARY_ROLL669_g7365 * _WIND_GUST_STRENGTH_MICRO769_g7365 ) );
				float3 GUST_ROLL816_g7365 = float3( 0,0,0 );
				float4 transform813_g7365 = mul(unity_WorldToObject,float4( ( GUST_WAVE798_g7365 + GUST_SHIMMY783_g7365 + GUST_ROLL816_g7365 ) , 0.0 ));
				float3 lerpResult538_g7365 = lerp( temp_output_684_0_g7365 , ( temp_output_684_0_g7365 + (transform813_g7365).xyz ) , temp_output_1415_0_g7294);
				float3 temp_output_41_0_g7432 = ( _WIND_GRASS_STRENGTH * lerpResult538_g7365 );
				float temp_output_63_0_g7433 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
				float3 lerpResult57_g7433 = lerp( temp_output_41_0_g7432 , -v.vertex.xyz , ( 1.0 - temp_output_63_0_g7433 ));
				#ifdef INTERNAL_LODFADE_SCALE
				float3 staticSwitch58_g7432 = lerpResult57_g7433;
				#else
				float3 staticSwitch58_g7432 = temp_output_41_0_g7432;
				#endif
				#ifdef LOD_FADE_CROSSFADE
				float3 staticSwitch62_g7432 = staticSwitch58_g7432;
				#else
				float3 staticSwitch62_g7432 = temp_output_41_0_g7432;
				#endif
				
				OctaImpostorVertex( v.vertex, v.normal, o.UVsFrame11375, o.UVsFrame21375, o.UVsFrame31375, o.octaframe1375, o.viewPos1375 );
				
				o.ase_texcoord10.xyz = ase_worldPos;
				
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord11 = screenPos;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord10.w = 0;

				v.vertex.xyz += staticSwitch62_g7432;
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
				float4 output0 = 0;
				OctaImpostorFragment( o, clipPos, worldPos, IN.UVsFrame11375, IN.UVsFrame21375, IN.UVsFrame31375, IN.octaframe1375, IN.viewPos1375, output0 );
				float3 lerpResult1322 = lerp( o.Albedo , ( (_Color).rgb * o.Albedo ) , (_Color).a);
				float3 temp_output_1109_0 = saturate( lerpResult1322 );
				
				float4 break1381 = output0;
				half Main_MetallicGlossMap_A744 = break1381.w;
				half OUT_SMOOTHNESS660 = ( Main_MetallicGlossMap_A744 * _Smoothness );
				
				half Main_MetallicGlossMap_G1287 = break1381.y;
				float3 ase_worldPos = IN.ase_texcoord10.xyz;
				half localunity_ObjectToWorld0w1_g7290 = ( unity_ObjectToWorld[0].w );
				half localunity_ObjectToWorld1w2_g7290 = ( unity_ObjectToWorld[1].w );
				half localunity_ObjectToWorld2w3_g7290 = ( unity_ObjectToWorld[2].w );
				float3 appendResult6_g7290 = (float3(localunity_ObjectToWorld0w1_g7290 , localunity_ObjectToWorld1w2_g7290 , localunity_ObjectToWorld2w3_g7290));
				float3 temp_output_14_0_g7289 = ( ase_worldPos - appendResult6_g7290 );
				float3 break10_g7289 = temp_output_14_0_g7289;
				float distance22_g7292 = distance( ase_worldPos , _WorldSpaceCameraPos );
				float temp_output_14_0_g7292 = _OcclusionRoots1;
				float temp_output_11_0_g7292 = _OcclusionRoots2;
				float fadeEnd20_g7292 = ( temp_output_14_0_g7292 + temp_output_11_0_g7292 );
				float fadeStart19_g7292 = temp_output_14_0_g7292;
				float fadeLength23_g7292 = temp_output_11_0_g7292;
				float lerpResult1365 = lerp( _OcclusionRoots , 0.0 , saturate( (( distance22_g7292 > fadeEnd20_g7292 ) ? 0.0 :  (( distance22_g7292 < fadeStart19_g7292 ) ? 1.0 :  ( 1.0 - ( ( distance22_g7292 - fadeStart19_g7292 ) / fadeLength23_g7292 ) ) ) ) ));
				float lerpResult1350 = lerp( Main_MetallicGlossMap_G1287 , ( Main_MetallicGlossMap_G1287 * saturate( ( break10_g7289.y / _RootDarkeningHeight ) ) ) , lerpResult1365);
				float lerpResult1342 = lerp( 1.0 , lerpResult1350 , _Occlusion);
				
				float temp_output_41_0_g7426 = o.Alpha;
				float4 screenPos = IN.ase_texcoord11;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float2 clipScreen45_g7427 = ase_screenPosNorm.xy * _ScreenParams.xy;
				float dither45_g7427 = Dither8x8Bayer( fmod(clipScreen45_g7427.x, 8), fmod(clipScreen45_g7427.y, 8) );
				float temp_output_56_0_g7427 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
				dither45_g7427 = step( dither45_g7427, temp_output_56_0_g7427 );
				#ifdef INTERNAL_LODFADE_DITHER
				float staticSwitch50_g7426 = ( temp_output_41_0_g7426 * dither45_g7427 );
				#else
				float staticSwitch50_g7426 = temp_output_41_0_g7426;
				#endif
				#ifdef LOD_FADE_CROSSFADE
				float staticSwitch56_g7426 = staticSwitch50_g7426;
				#else
				float staticSwitch56_g7426 = temp_output_41_0_g7426;
				#endif
				
				fixed3 albedo = temp_output_1109_0;
				fixed3 normal = o.Normal;
				half3 emission = half3( 0, 0, 0 );
				fixed3 specular = temp_output_1109_0;
				fixed metallic = 0;
				half smoothness = OUT_SMOOTHNESS660;
				half occlusion = lerpResult1342;
				fixed alpha = staticSwitch56_g7426;

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
#include "UnityCG.cginc"
#include "UnityCG.cginc"
#include "UnityCG.cginc"
			#define _SPECULAR_SETUP 1

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
			// INTERNAL_SHADER_FEATURE_END
			  

			uniform float4 _HueVariation;
			uniform half _WIND_GRASS_STRENGTH;
			uniform float _PrimaryRollStrength1;
			uniform sampler2D _WIND_GUST_TEXTURE;
			uniform half _WIND_BASE_GRASS_FIELD_SIZE;
			uniform half _WIND_BASE_GRASS_CYCLE_TIME;
			uniform half _WIND_BASE_AMPLITUDE;
			uniform half _WIND_BASE_TO_GUST_RATIO;
			uniform half3 _WIND_DIRECTION;
			uniform half _WIND_GUST_GRASS_FIELD_SIZE;
			uniform half _WIND_GUST_GRASS_CYCLE_TIME;
			uniform half _WIND_GUST_AUDIO_STRENGTH_VERYHIGH;
			uniform half _WIND_AUDIO_INFLUENCE;
			uniform half _WIND_GUST_AUDIO_STRENGTH_HIGH;
			uniform half _WIND_GRASS_MICRO_STRENGTH;
			uniform half _WIND_GUST_GRASS_MICRO_FIELD_SIZE;
			uniform half _WIND_GUST_GRASS_MICRO_CYCLE_TIME;
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
			uniform half _Smoothness;
			uniform float _RootDarkeningHeight;
			uniform half _OcclusionRoots;
			uniform half _OcclusionRoots1;
			uniform half _OcclusionRoots2;
			uniform half _Occlusion;
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
			
			inline void OctaImpostorFragment( inout SurfaceOutputStandardSpecular o, out float4 clipPos, out float3 worldPos, float4 uvsFrame1, float4 uvsFrame2, float4 uvsFrame3, float4 octaFrame, float4 interpViewPos, out float4 output0 )
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
				V2F_SHADOW_CASTER;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 UVsFrame11375 : TEXCOORD5;
				float4 UVsFrame21375 : TEXCOORD6;
				float4 UVsFrame31375 : TEXCOORD7;
				float4 octaframe1375 : TEXCOORD8;
				float4 viewPos1375 : TEXCOORD9;
				float4 ase_texcoord10 : TEXCOORD10;
				float4 ase_texcoord11 : TEXCOORD11;
			};

			v2f_surf vert_surf (appdata_full v ) {
				UNITY_SETUP_INSTANCE_ID(v);
				v2f_surf o;
				UNITY_INITIALIZE_OUTPUT(v2f_surf,o);
				UNITY_TRANSFER_INSTANCE_ID(v,o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float _WIND_PRIMARY_ROLL669_g7365 = ( saturate( v.color.r ) * _PrimaryRollStrength1 );
				float4 color658_g7345 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
				float2 temp_output_61_0_g7351 = float2( 0,0 );
				float3 ase_worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				float2 temp_output_1399_0_g7294 = (ase_worldPos).xz;
				float2 temp_output_1396_0_g7294 = ( temp_output_1399_0_g7294 + ( ( temp_output_1399_0_g7294 % (1.0).xx ) * 0.1 ) );
				float2 temp_output_1_0_g7357 = temp_output_1396_0_g7294;
				float temp_output_2_0_g7358 = _WIND_BASE_GRASS_FIELD_SIZE;
				float temp_output_40_0_g7351 = ( 1.0 / (( temp_output_2_0_g7358 == 0.0 ) ? 1.0 :  temp_output_2_0_g7358 ) );
				float2 temp_cast_0 = (temp_output_40_0_g7351).xx;
				float2 temp_output_2_0_g7357 = temp_cast_0;
				float temp_output_2_0_g7347 = _WIND_BASE_GRASS_CYCLE_TIME;
				float mulTime37_g7351 = _Time.y * ( 1.0 / (( temp_output_2_0_g7347 == 0.0 ) ? 1.0 :  temp_output_2_0_g7347 ) );
				float temp_output_220_0_g7352 = -1.0;
				float4 temp_cast_1 = (temp_output_220_0_g7352).xxxx;
				float temp_output_219_0_g7352 = 1.0;
				float4 temp_cast_2 = (temp_output_219_0_g7352).xxxx;
				float4 clampResult26_g7352 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g7351 > float2( 0,0 ) ) ? ( temp_output_1_0_g7357 / temp_output_2_0_g7357 ) :  ( temp_output_1_0_g7357 * temp_output_2_0_g7357 ) ) + temp_output_61_0_g7351 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g7351 ) ) , temp_cast_1 , temp_cast_2 );
				float4 temp_cast_3 = (temp_output_220_0_g7352).xxxx;
				float4 temp_cast_4 = (temp_output_219_0_g7352).xxxx;
				float4 temp_cast_5 = (0.0).xxxx;
				float4 temp_cast_6 = (temp_output_219_0_g7352).xxxx;
				float temp_output_679_0_g7345 = 1.0;
				float4 temp_cast_7 = (temp_output_679_0_g7345).xxxx;
				float4 temp_output_52_0_g7351 = saturate( pow( abs( (temp_cast_5 + (clampResult26_g7352 - temp_cast_3) * (temp_cast_6 - temp_cast_5) / (temp_cast_4 - temp_cast_3)) ) , temp_cast_7 ) );
				float4 lerpResult656_g7345 = lerp( color658_g7345 , temp_output_52_0_g7351 , temp_output_679_0_g7345);
				float2 break298_g7366 = ( ( (lerpResult656_g7345).rb * 0.33 ) + 0.0 );
				float2 appendResult299_g7366 = (float2(sin( break298_g7366.x ) , cos( break298_g7366.y )));
				float4 temp_output_273_0_g7366 = (-1.0).xxxx;
				float4 temp_output_271_0_g7366 = (1.0).xxxx;
				float2 clampResult26_g7366 = clamp( appendResult299_g7366 , temp_output_273_0_g7366.xy , temp_output_271_0_g7366.xy );
				float2 TRUNK_SWIRL700_g7365 = ( clampResult26_g7366 * (( _WIND_BASE_AMPLITUDE * _WIND_BASE_TO_GUST_RATIO )).xx );
				float2 break699_g7365 = TRUNK_SWIRL700_g7365;
				float3 appendResult698_g7365 = (float3(break699_g7365.x , 0.0 , break699_g7365.y));
				float3 temp_output_684_0_g7365 = ( _WIND_PRIMARY_ROLL669_g7365 * (appendResult698_g7365).xyz );
				float3 _WIND_DIRECTION671_g7365 = _WIND_DIRECTION;
				float4 color658_g7328 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
				float2 temp_output_61_0_g7334 = float2( 0,0 );
				float2 temp_output_1_0_g7340 = temp_output_1396_0_g7294;
				float temp_output_2_0_g7341 = _WIND_GUST_GRASS_FIELD_SIZE;
				float temp_output_40_0_g7334 = ( 1.0 / (( temp_output_2_0_g7341 == 0.0 ) ? 1.0 :  temp_output_2_0_g7341 ) );
				float2 temp_cast_10 = (temp_output_40_0_g7334).xx;
				float2 temp_output_2_0_g7340 = temp_cast_10;
				float temp_output_2_0_g7330 = _WIND_GUST_GRASS_CYCLE_TIME;
				float mulTime37_g7334 = _Time.y * ( 1.0 / (( temp_output_2_0_g7330 == 0.0 ) ? 1.0 :  temp_output_2_0_g7330 ) );
				float temp_output_220_0_g7335 = -1.0;
				float4 temp_cast_11 = (temp_output_220_0_g7335).xxxx;
				float temp_output_219_0_g7335 = 1.0;
				float4 temp_cast_12 = (temp_output_219_0_g7335).xxxx;
				float4 clampResult26_g7335 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g7334 > float2( 0,0 ) ) ? ( temp_output_1_0_g7340 / temp_output_2_0_g7340 ) :  ( temp_output_1_0_g7340 * temp_output_2_0_g7340 ) ) + temp_output_61_0_g7334 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g7334 ) ) , temp_cast_11 , temp_cast_12 );
				float4 temp_cast_13 = (temp_output_220_0_g7335).xxxx;
				float4 temp_cast_14 = (temp_output_219_0_g7335).xxxx;
				float4 temp_cast_15 = (0.0).xxxx;
				float4 temp_cast_16 = (temp_output_219_0_g7335).xxxx;
				float temp_output_679_0_g7328 = 1.0;
				float4 temp_cast_17 = (temp_output_679_0_g7328).xxxx;
				float4 temp_output_52_0_g7334 = saturate( pow( abs( (temp_cast_15 + (clampResult26_g7335 - temp_cast_13) * (temp_cast_16 - temp_cast_15) / (temp_cast_14 - temp_cast_13)) ) , temp_cast_17 ) );
				float4 lerpResult656_g7328 = lerp( color658_g7328 , temp_output_52_0_g7334 , temp_output_679_0_g7328);
				float4 break655_g7328 = lerpResult656_g7328;
				float temp_output_15_0_g7363 = break655_g7328.r;
				float lerpResult638_g7310 = lerp( 1.0 , _WIND_GUST_AUDIO_STRENGTH_VERYHIGH , _WIND_AUDIO_INFLUENCE);
				float temp_output_1344_639_g7294 = lerpResult638_g7310;
				float temp_output_15_0_g7364 = temp_output_1344_639_g7294;
				float lerpResult633_g7310 = lerp( 1.0 , _WIND_GUST_AUDIO_STRENGTH_HIGH , _WIND_AUDIO_INFLUENCE);
				float temp_output_1344_627_g7294 = lerpResult633_g7310;
				float temp_output_16_0_g7364 = temp_output_1344_627_g7294;
				float temp_output_1401_14_g7294 = ( ( temp_output_15_0_g7364 + temp_output_16_0_g7364 ) / 2.0 );
				float temp_output_16_0_g7363 = temp_output_1401_14_g7294;
				float _WIND_GUST_STRENGTH_1845_g7365 = ( ( temp_output_15_0_g7363 + temp_output_16_0_g7363 ) / 2.0 );
				float3 GUST_WAVE798_g7365 = ( ( _WIND_DIRECTION671_g7365 * _WIND_GUST_STRENGTH_1845_g7365 * _WIND_PRIMARY_ROLL669_g7365 ) + ( _WIND_GUST_STRENGTH_1845_g7365 * float3(0,-0.25,0) * _WIND_PRIMARY_ROLL669_g7365 ) );
				float temp_output_1415_0_g7294 = max( temp_output_1344_639_g7294 , temp_output_1344_627_g7294 );
				float4 color658_g7311 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
				float2 temp_output_61_0_g7317 = float2( 0,0 );
				float2 uv01387_g7294 = v.texcoord.xyzw.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_output_1_0_g7323 = (uv01387_g7294).xx;
				float temp_output_2_0_g7324 = _WIND_GUST_GRASS_MICRO_FIELD_SIZE;
				float temp_output_40_0_g7317 = ( 1.0 / (( temp_output_2_0_g7324 == 0.0 ) ? 1.0 :  temp_output_2_0_g7324 ) );
				float2 temp_cast_18 = (temp_output_40_0_g7317).xx;
				float2 temp_output_2_0_g7323 = temp_cast_18;
				float temp_output_2_0_g7313 = _WIND_GUST_GRASS_MICRO_CYCLE_TIME;
				float mulTime37_g7317 = _Time.y * ( 1.0 / (( temp_output_2_0_g7313 == 0.0 ) ? 1.0 :  temp_output_2_0_g7313 ) );
				float temp_output_220_0_g7318 = -1.0;
				float4 temp_cast_19 = (temp_output_220_0_g7318).xxxx;
				float temp_output_219_0_g7318 = 1.0;
				float4 temp_cast_20 = (temp_output_219_0_g7318).xxxx;
				float4 clampResult26_g7318 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g7317 > float2( 0,0 ) ) ? ( temp_output_1_0_g7323 / temp_output_2_0_g7323 ) :  ( temp_output_1_0_g7323 * temp_output_2_0_g7323 ) ) + temp_output_61_0_g7317 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g7317 ) ) , temp_cast_19 , temp_cast_20 );
				float4 temp_cast_21 = (temp_output_220_0_g7318).xxxx;
				float4 temp_cast_22 = (temp_output_219_0_g7318).xxxx;
				float4 temp_cast_23 = (0.0).xxxx;
				float4 temp_cast_24 = (temp_output_219_0_g7318).xxxx;
				float temp_output_679_0_g7311 = 1.0;
				float4 temp_cast_25 = (temp_output_679_0_g7311).xxxx;
				float4 temp_output_52_0_g7317 = saturate( pow( abs( (temp_cast_23 + (clampResult26_g7318 - temp_cast_21) * (temp_cast_24 - temp_cast_23) / (temp_cast_22 - temp_cast_21)) ) , temp_cast_25 ) );
				float4 lerpResult656_g7311 = lerp( color658_g7311 , temp_output_52_0_g7317 , temp_output_679_0_g7311);
				float4 break655_g7311 = lerpResult656_g7311;
				float _WIND_GUST_STRENGTH_MICRO769_g7365 = ( _WIND_GRASS_MICRO_STRENGTH * temp_output_1415_0_g7294 * break655_g7311.g );
				float3 GUST_SHIMMY783_g7365 = ( _WIND_DIRECTION671_g7365 * ( _WIND_PRIMARY_ROLL669_g7365 * _WIND_GUST_STRENGTH_MICRO769_g7365 ) );
				float3 GUST_ROLL816_g7365 = float3( 0,0,0 );
				float4 transform813_g7365 = mul(unity_WorldToObject,float4( ( GUST_WAVE798_g7365 + GUST_SHIMMY783_g7365 + GUST_ROLL816_g7365 ) , 0.0 ));
				float3 lerpResult538_g7365 = lerp( temp_output_684_0_g7365 , ( temp_output_684_0_g7365 + (transform813_g7365).xyz ) , temp_output_1415_0_g7294);
				float3 temp_output_41_0_g7432 = ( _WIND_GRASS_STRENGTH * lerpResult538_g7365 );
				float temp_output_63_0_g7433 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
				float3 lerpResult57_g7433 = lerp( temp_output_41_0_g7432 , -v.vertex.xyz , ( 1.0 - temp_output_63_0_g7433 ));
				#ifdef INTERNAL_LODFADE_SCALE
				float3 staticSwitch58_g7432 = lerpResult57_g7433;
				#else
				float3 staticSwitch58_g7432 = temp_output_41_0_g7432;
				#endif
				#ifdef LOD_FADE_CROSSFADE
				float3 staticSwitch62_g7432 = staticSwitch58_g7432;
				#else
				float3 staticSwitch62_g7432 = temp_output_41_0_g7432;
				#endif
				
				OctaImpostorVertex( v.vertex, v.normal, o.UVsFrame11375, o.UVsFrame21375, o.UVsFrame31375, o.octaframe1375, o.viewPos1375 );
				
				o.ase_texcoord10.xyz = ase_worldPos;
				
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord11 = screenPos;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord10.w = 0;

				v.vertex.xyz += staticSwitch62_g7432;
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
				float4 output0 = 0;
				OctaImpostorFragment( o, clipPos, worldPos, IN.UVsFrame11375, IN.UVsFrame21375, IN.UVsFrame31375, IN.octaframe1375, IN.viewPos1375, output0 );
				float3 lerpResult1322 = lerp( o.Albedo , ( (_Color).rgb * o.Albedo ) , (_Color).a);
				float3 temp_output_1109_0 = saturate( lerpResult1322 );
				
				float4 break1381 = output0;
				half Main_MetallicGlossMap_A744 = break1381.w;
				half OUT_SMOOTHNESS660 = ( Main_MetallicGlossMap_A744 * _Smoothness );
				
				half Main_MetallicGlossMap_G1287 = break1381.y;
				float3 ase_worldPos = IN.ase_texcoord10.xyz;
				half localunity_ObjectToWorld0w1_g7290 = ( unity_ObjectToWorld[0].w );
				half localunity_ObjectToWorld1w2_g7290 = ( unity_ObjectToWorld[1].w );
				half localunity_ObjectToWorld2w3_g7290 = ( unity_ObjectToWorld[2].w );
				float3 appendResult6_g7290 = (float3(localunity_ObjectToWorld0w1_g7290 , localunity_ObjectToWorld1w2_g7290 , localunity_ObjectToWorld2w3_g7290));
				float3 temp_output_14_0_g7289 = ( ase_worldPos - appendResult6_g7290 );
				float3 break10_g7289 = temp_output_14_0_g7289;
				float distance22_g7292 = distance( ase_worldPos , _WorldSpaceCameraPos );
				float temp_output_14_0_g7292 = _OcclusionRoots1;
				float temp_output_11_0_g7292 = _OcclusionRoots2;
				float fadeEnd20_g7292 = ( temp_output_14_0_g7292 + temp_output_11_0_g7292 );
				float fadeStart19_g7292 = temp_output_14_0_g7292;
				float fadeLength23_g7292 = temp_output_11_0_g7292;
				float lerpResult1365 = lerp( _OcclusionRoots , 0.0 , saturate( (( distance22_g7292 > fadeEnd20_g7292 ) ? 0.0 :  (( distance22_g7292 < fadeStart19_g7292 ) ? 1.0 :  ( 1.0 - ( ( distance22_g7292 - fadeStart19_g7292 ) / fadeLength23_g7292 ) ) ) ) ));
				float lerpResult1350 = lerp( Main_MetallicGlossMap_G1287 , ( Main_MetallicGlossMap_G1287 * saturate( ( break10_g7289.y / _RootDarkeningHeight ) ) ) , lerpResult1365);
				float lerpResult1342 = lerp( 1.0 , lerpResult1350 , _Occlusion);
				
				float temp_output_41_0_g7426 = o.Alpha;
				float4 screenPos = IN.ase_texcoord11;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float2 clipScreen45_g7427 = ase_screenPosNorm.xy * _ScreenParams.xy;
				float dither45_g7427 = Dither8x8Bayer( fmod(clipScreen45_g7427.x, 8), fmod(clipScreen45_g7427.y, 8) );
				float temp_output_56_0_g7427 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
				dither45_g7427 = step( dither45_g7427, temp_output_56_0_g7427 );
				#ifdef INTERNAL_LODFADE_DITHER
				float staticSwitch50_g7426 = ( temp_output_41_0_g7426 * dither45_g7427 );
				#else
				float staticSwitch50_g7426 = temp_output_41_0_g7426;
				#endif
				#ifdef LOD_FADE_CROSSFADE
				float staticSwitch56_g7426 = staticSwitch50_g7426;
				#else
				float staticSwitch56_g7426 = temp_output_41_0_g7426;
				#endif
				
				fixed3 albedo = temp_output_1109_0;
				fixed3 normal = o.Normal;
				half3 emission = half3( 0, 0, 0 );
				fixed3 specular = temp_output_1109_0;
				fixed metallic = 0;
				half smoothness = OUT_SMOOTHNESS660;
				half occlusion = lerpResult1342;
				fixed alpha = staticSwitch56_g7426;

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
0;0;1280;659;2179.095;1731.641;1;True;False
Node;AmplifyShaderEditor.TexturePropertyNode;1376;-2477.589,-2926.862;Inherit;True;Property;_MAOTS;MAOTS;17;1;[NoScaleOffset];Create;True;0;0;False;0;None;327d8c020f2ce694da18654b6e1720b4;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.AmplifyImpostorNode;1375;-2176.209,-2910.572;Inherit;False;9603;HemiOctahedron;True;False;True;2;3;4;5;8;7;44;9;13;14;15;16;45;1;0;6;11;1;Specular;8;0;SAMPLER2D;;False;1;SAMPLER2D;;False;2;SAMPLER2D;;False;3;SAMPLER2D;;False;4;SAMPLER2D;;False;5;SAMPLER2D;;False;6;SAMPLER2D;;False;7;SAMPLER2D;;False;17;FLOAT4;8;FLOAT4;9;FLOAT4;10;FLOAT4;11;FLOAT4;12;FLOAT4;13;FLOAT4;14;FLOAT4;15;FLOAT3;0;FLOAT3;1;FLOAT3;2;FLOAT3;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT3;7;FLOAT3;16
Node;AmplifyShaderEditor.BreakToComponentsNode;1381;-1899.175,-3393.298;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;1391;-3943.288,-1749.801;Inherit;False;Property;_RootDarkeningHeight;Root Darkening Height;21;0;Create;False;0;0;False;0;0.5;0.5;0.0001;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1390;-4016.288,-1908.801;Inherit;False;Vertex Position (World Scaled);-1;;7289;d235782138fed9b498e9d559f94f5d3a;0;0;4;FLOAT3;0;FLOAT;3;FLOAT;5;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1287;-1280,-3456;Half;False;Main_MetallicGlossMap_G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;1394;-3411.843,-1778.392;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1356;-3988.575,-1432.909;Half;False;Property;_OcclusionRoots1;Grass Root Darkening Fade In Start;22;0;Create;False;0;0;False;0;32;32;0;64;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1357;-4055.44,-1332.278;Half;False;Property;_OcclusionRoots2;Grass Root Darkening Fade In Range;23;0;Create;False;0;0;False;0;16;16;0;64;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;744;-1280,-3264;Half;False;Main_MetallicGlossMap_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1300;-2176,-1536;Inherit;False;Mesh Values (Tree) (Complex) (Vertex Colors);-1;;7291;9cacaefc2ecfddf4c8e070f9be99b854;0;0;4;FLOAT;495;FLOAT;501;FLOAT;550;FLOAT;552
Node;AmplifyShaderEditor.GetLocalVarNode;1292;-3643.259,-1942.871;Inherit;False;1287;Main_MetallicGlossMap_G;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1340;-3149.22,-1757.718;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1366;-3454.948,-1512.893;Inherit;False;Constant;_Float11;Float 11;26;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1359;-3658.175,-1414.509;Inherit;False;Camera Distance Fade;-1;;7292;2b5f56921ab3ab94bbfa00609d7425b4;0;2;14;FLOAT;10;False;11;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1348;-3579.114,-1594.174;Half;False;Property;_OcclusionRoots;Grass Root Darkening;20;0;Create;False;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;409;-1626.919,-3000.156;Half;False;Property;_Color;Grass Color;10;0;Create;False;0;0;False;0;1,1,1,0;1,1,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;749;-665.0339,-3610.253;Inherit;False;744;Main_MetallicGlossMap_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1290;-2846.866,-1794.695;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1307;-1728,-1536;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;294;-665.0339,-3530.253;Half;False;Property;_Smoothness;Grass Smoothness;18;0;Create;False;0;0;False;0;0.15;0.15;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1419;-1918.095,-1383.641;Inherit;False;Property;_PrimaryRollStrength1;Primary Roll Strength;43;0;Create;True;0;0;False;0;0.1;2;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1365;-3074.829,-1494.366;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;1320;-1306.392,-2976.51;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;1382;-1531.125,-2780.239;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;1321;-1306.392,-2896.51;Inherit;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1380;-1022.378,-2697.836;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1350;-2650.676,-1838.922;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1344;-2423.262,-1927.872;Inherit;False;Constant;_Float2;Float 2;22;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1328;-1440,-1552;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1074;-996.392,-2822.71;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;1383;-1399.125,-2721.239;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;745;-345.0339,-3610.253;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1313;-2493.262,-1677.452;Half;False;Property;_Occlusion;Grass Occlusion;19;0;Create;False;0;0;False;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;660;-192,-3600;Half;False;OUT_SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1378;-1680.306,-2714.779;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;1342;-2216.262,-1855.872;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1388;-1248.744,-2225.857;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1322;-801.1119,-2753.196;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1418;-1258.827,-1552.95;Inherit;False;Wind (Grass);29;;7294;d7f6e9209bef88c48a309bf8b38bad07;0;1;1152;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1364;-632.0183,-2020.382;Inherit;False;Execute LOD Fade;-1;;7425;18ea34bd83a0d6c4db425672111543e6;0;2;41;FLOAT;0;False;58;FLOAT3;0,0,0;False;3;FLOAT;0;FLOAT3;91;FLOAT;96
Node;AmplifyShaderEditor.GetLocalVarNode;1410;-1071.234,-4716.244;Inherit;False;1271;Main_MetallicGlossMap_B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1404;-1967.234,-4316.244;Half;False;Property;_GrassSubsurfaceStrength;Grass Subsurface Strength;25;0;Create;False;0;0;False;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1389;-2612.001,-2593.05;Inherit;False;Property;_HueVariation;Hue Variation;12;0;Create;False;0;0;True;0;1,0.9661968,0.636,0.2;1,1,1,0.2;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;1409;-1071.234,-4492.244;Inherit;False;False;False;False;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;1411;-628.6245,-4320.537;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1415;-239.2336,-4620.244;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;654;-939.4363,-2248.679;Inherit;False;660;OUT_SMOOTHNESS;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1407;-1407.234,-4556.244;Inherit;False;Property;_UseAlbedoAsSubsurface;Use Albedo As Subsurface;24;0;Create;True;0;0;False;0;1;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;1384;-921.855,-2128.875;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1346;-1670.4,-2054.4;Inherit;False;Constant;_Float0;Float 0;22;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1416;-47.2335,-4620.244;Half;False;OUT_TRANSMISSION;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;1387;-1908.248,-2287.114;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1282;140.0228,-2392.521;Inherit;False;Internal Features Support;-1;;7424;3c493d142aeebd840af72d626f6915c6;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1386;-1914.847,-1968.515;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1412;-687.2336,-4700.244;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1354;-1152,-2272;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1414;-431.2336,-4700.244;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1272;-1280,-2368;Inherit;False;1416;OUT_TRANSMISSION;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1352;-1798.4,-2246.4;Half;False;Property;_GrassOcclusionTransmissionDampening;Grass Occlusion Transmission Dampening;27;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1109;-619.392,-2753.51;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1271;-1280,-3360;Half;False;Main_MetallicGlossMap_B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1315;-1070.089,-4308.103;Half;False;Property;_Occlusion1;Grass Subsurface Low;28;0;Create;False;0;0;False;0;0.1;0.1;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1293;-896,-2352;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;1413;-1071.234,-4604.244;Inherit;False;True;True;True;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;1405;-1583.234,-4412.244;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;1266;-2005.389,-4841.903;Half;False;Property;_SubsurfaceColor;Grass Subsurface;26;0;Create;False;0;0;False;0;0.9647059,1,0.6941177,0.5019608;0.9647059,1,0.6941177,0.5019608;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1347;-1670.4,-2150.4;Inherit;False;Constant;_Float1;Float 1;22;0;Create;True;0;0;False;0;5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1377;-1400.45,-2476.862;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1345;-1408,-2176;Inherit;False;Remap From 0-1;-1;;7438;e64dd7a39884fcf479ce6585a25254a4;0;3;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1373;-135.392,-2095.51;Float;False;False;-1;2;ASEMaterialInspector;0;10;New Amplify Shader;30a8e337ed84177439ca24b6a5c97cd1;True;Meta;0;3;Meta;0;False;False;True;False;True;0;False;-1;False;False;False;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=True;True;2;0;False;False;False;True;2;False;-1;False;False;False;False;False;True;1;LightMode=Meta;False;0;;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1371;-135.392,-2161.51;Float;False;False;-1;2;ASEMaterialInspector;0;10;New Amplify Shader;30a8e337ed84177439ca24b6a5c97cd1;True;ForwardAdd;0;1;ForwardAdd;0;False;False;True;False;True;0;False;-1;False;False;False;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=True;True;2;0;True;4;1;False;-1;1;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;True;2;False;-1;False;False;True;1;LightMode=ForwardAdd;False;0;;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1372;-135.392,-2128.51;Float;False;False;-1;2;ASEMaterialInspector;0;10;New Amplify Shader;30a8e337ed84177439ca24b6a5c97cd1;True;Deferred;0;2;Deferred;0;False;False;True;False;True;0;False;-1;False;False;False;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=True;True;2;0;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;False;0;;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1370;-135.392,-2406.51;Float;False;True;-1;2;ASEMaterialInspector;0;10;GPUInstancer/appalachia/impostors/grass-runtime;30a8e337ed84177439ca24b6a5c97cd1;True;ForwardBase;0;0;ForwardBase;10;False;False;True;False;True;0;False;-1;False;False;False;False;False;True;4;RenderType=TransparentCutout=RenderType;Queue=AlphaTest=Queue=0;DisableBatching=True;ImpostorType=HemiOctahedron;True;4;0;False;False;False;False;False;False;True;1;False;-1;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Material Type,InvertActionOnDeselection;1;0;5;True;True;True;True;True;False;;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1374;-135.392,-2062.51;Float;False;False;-1;2;ASEMaterialInspector;0;10;New Amplify Shader;30a8e337ed84177439ca24b6a5c97cd1;True;ShadowCaster;0;4;ShadowCaster;0;False;False;True;False;True;0;False;-1;False;False;False;False;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=True;True;2;0;False;False;False;False;False;False;True;1;False;-1;False;False;True;1;LightMode=ShadowCaster;False;0;;0;0;Standard;0;0
WireConnection;1375;0;1376;0
WireConnection;1381;0;1375;8
WireConnection;1287;0;1381;1
WireConnection;1394;0;1390;5
WireConnection;1394;1;1391;0
WireConnection;744;0;1381;3
WireConnection;1340;0;1394;0
WireConnection;1359;14;1356;0
WireConnection;1359;11;1357;0
WireConnection;1290;0;1292;0
WireConnection;1290;1;1340;0
WireConnection;1307;0;1300;495
WireConnection;1365;0;1348;0
WireConnection;1365;1;1366;0
WireConnection;1365;2;1359;0
WireConnection;1320;0;409;0
WireConnection;1382;0;1375;0
WireConnection;1321;0;409;0
WireConnection;1380;0;1321;0
WireConnection;1350;0;1292;0
WireConnection;1350;1;1290;0
WireConnection;1350;2;1365;0
WireConnection;1328;0;1307;0
WireConnection;1328;1;1419;0
WireConnection;1074;0;1320;0
WireConnection;1074;1;1382;0
WireConnection;1383;0;1375;0
WireConnection;745;0;749;0
WireConnection;745;1;294;0
WireConnection;660;0;745;0
WireConnection;1378;0;1375;1
WireConnection;1342;0;1344;0
WireConnection;1342;1;1350;0
WireConnection;1342;2;1313;0
WireConnection;1388;0;1375;6
WireConnection;1322;0;1383;0
WireConnection;1322;1;1074;0
WireConnection;1322;2;1380;0
WireConnection;1418;1152;1328;0
WireConnection;1364;41;1388;0
WireConnection;1364;58;1418;0
WireConnection;1409;0;1407;0
WireConnection;1411;0;1409;0
WireConnection;1411;1;1315;0
WireConnection;1415;0;1414;0
WireConnection;1415;1;1413;0
WireConnection;1407;0;1266;0
WireConnection;1407;1;1405;0
WireConnection;1384;0;1342;0
WireConnection;1416;0;1415;0
WireConnection;1387;0;1386;0
WireConnection;1386;0;1342;0
WireConnection;1412;0;1410;0
WireConnection;1412;1;1409;0
WireConnection;1354;0;1387;0
WireConnection;1354;1;1345;0
WireConnection;1414;0;1412;0
WireConnection;1414;1;1411;0
WireConnection;1109;0;1322;0
WireConnection;1271;0;1381;2
WireConnection;1293;0;1272;0
WireConnection;1293;1;1354;0
WireConnection;1413;0;1407;0
WireConnection;1405;0;1375;0
WireConnection;1405;3;1404;0
WireConnection;1377;0;1378;0
WireConnection;1345;6;1352;0
WireConnection;1345;7;1347;0
WireConnection;1345;8;1346;0
WireConnection;1370;0;1109;0
WireConnection;1370;1;1377;0
WireConnection;1370;3;1109;0
WireConnection;1370;4;654;0
WireConnection;1370;5;1384;0
WireConnection;1370;6;1364;0
WireConnection;1370;9;1364;91
ASEEND*/
//CHKSM=E2791D03D279E1B7431B93D1A199CC40B8546267
