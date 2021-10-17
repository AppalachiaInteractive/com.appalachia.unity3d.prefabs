// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "appalachia/terrain-first-pass"
{
	Properties
	{
		[HideInInspector]_Control("Control", 2D) = "white" {}
		[HideInInspector]_Splat0("Splat0", 2D) = "white" {}
		[HideInInspector]_Splat1("Splat1", 2D) = "white" {}
		[HideInInspector]_Normal0("Normal0", 2D) = "white" {}
		[HideInInspector]_Normal1("Normal1", 2D) = "white" {}
		[HideInInspector]_MaskMap0("MaskMap0", 2D) = "white" {}
		[HideInInspector]_MaskMap1("MaskMap1", 2D) = "white" {}
		[HideInInspector]_Smoothness0("Smoothness0", Range( 0 , 1)) = 1
		[HideInInspector]_Smoothness1("Smoothness1", Range( 0 , 1)) = 1
		[HideInInspector][Gamma]_Metallic0("Metallic 0", Float) = 0
		[HideInInspector][Gamma]_Metallic1("Metallic 1", Float) = 0
		_NormalScale("Normal Scale", Range( 0 , 5)) = 1
		[KeywordEnum(Default,NormalsPBR,Normals,OcclusionPBR,Occlusion,FlatPBR,Flat)] _ShadingType("ShadingType", Float) = 0
		_FlatColor("Flat Color", Color) = (0,0,0,0)
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("Cull Mode", Int) = 0
		_BackColor("Back Color", Color) = (0,0,0,0)
		[InternalCategory(Global Illumination)]_GLOBALILLUMINATIONN("[ GLOBAL ILLUMINATIONN ]", Float) = 0
		_GlobalIlluminationAlbedoEffect("Global Illumination Albedo Effect", Range( 0 , 5)) = 1
		_GlobalIlluminationEmissiveEffect("Global Illumination Emissive Effect", Range( 0 , 5)) = 1
		[InternalCategory(Occlusion)]_OCCLUSIONN("[ OCCLUSIONN ]", Float) = 0
		_Occlusion("Texture Occlusion", Range( 0 , 1)) = 0.5
		_VertexOcclusion("Vertex Occlusion", Range( 0 , 1)) = 0.5
		_AOProbeStrength("AO Probe Strength", Range( 0 , 1)) = 0.8
		_AOIndirect("AO Indirect", Range( 0 , 1)) = 1
		_AODirect("AO Direct", Range( 0 , 1)) = 0
		[HideInInspector] _tex3coord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry-100" "IsEmissive" = "true"  }
		Cull [_CullMode]
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityStandardUtils.cginc"
		#include "Lighting.cginc"
		#pragma target 5.0
		#pragma shader_feature_local _SHADINGTYPE_DEFAULT _SHADINGTYPE_NORMALSPBR _SHADINGTYPE_NORMALS _SHADINGTYPE_OCCLUSIONPBR _SHADINGTYPE_OCCLUSION _SHADINGTYPE_FLATPBR _SHADINGTYPE_FLAT
		#pragma multi_compile_fog
		 
		// INTERNAL_SHADER_FEATURE_START
		// INTERNAL_SHADER_FEATURE_END
		  
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 uv_tex3coord;
			float3 worldNormal;
			INTERNAL_DATA
			half ASEVFace : VFACE;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform half _OCCLUSIONN;
		uniform half _GLOBALILLUMINATIONN;
		uniform int _CullMode;
		uniform float _GlobalIlluminationAlbedoEffect;
		uniform sampler2D _Control;
		uniform float4 _Control_ST;
		uniform float _Metallic0;
		uniform sampler2D _MaskMap0;
		uniform sampler2D _Splat0;
		uniform float4 _Splat0_ST;
		uniform float _Smoothness0;
		uniform float _Metallic1;
		uniform sampler2D _MaskMap1;
		uniform sampler2D _Splat1;
		uniform float4 _Splat1_ST;
		uniform float _Smoothness1;
		uniform half _Occlusion;
		uniform half _VertexOcclusion;
		uniform float4x4 _OcclusionProbesWorldToLocal;
		uniform sampler3D _OcclusionProbes;
		uniform float4 _OcclusionProbes_ST;
		uniform float _AOProbeStrength;
		uniform float _OCCLUSION_PROBE_GLOBAL;
		uniform float _AOIndirect;
		uniform float _AODirect;
		uniform sampler2D _Normal0;
		uniform sampler2D _Normal1;
		uniform float _NormalScale;
		uniform float4 _FlatColor;
		uniform float4 _BackColor;
		uniform float _GlobalIlluminationEmissiveEffect;
		uniform float _OCCLUSION_PROBE_TERRAIN;


		float SampleOcclusionProbes( float3 positionWS , float4x4 OcclusionProbesWorldToLocal , float OcclusionProbes )
		{
			float occlusionProbes = 1;
			float3 pos = mul(_OcclusionProbesWorldToLocal, float4(positionWS, 1)).xyz;
			occlusionProbes = tex3D(_OcclusionProbes, pos).a;
			return occlusionProbes;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float localCalculateTangentsStandard16_g19723 = ( 0.0 );
			v.tangent.xyz = cross ( v.normal, float3( 0, 0, 1 ) );
			v.tangent.w = -1;
			v.vertex.xyz += localCalculateTangentsStandard16_g19723;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef UNITY_PASS_FORWARDBASE
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			#if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
			half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
			float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
			float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
			ase_lightAtten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
			#endif
			SurfaceOutputStandard s1_g19736 = (SurfaceOutputStandard ) 0;
			float temp_output_36_0_g19728 = 1.0;
			float2 uv_Control = i.uv_texcoord * _Control_ST.xy + _Control_ST.zw;
			float4 tex2DNode5_g19723 = tex2D( _Control, uv_Control );
			float dotResult20_g19723 = dot( tex2DNode5_g19723 , float4(1,1,1,1) );
			float SplatWeight22_g19723 = dotResult20_g19723;
			float localSplatClip74_g19723 = ( SplatWeight22_g19723 );
			float SplatWeight74_g19723 = SplatWeight22_g19723;
			#if !defined(SHADER_API_MOBILE) && defined(TERRAIN_SPLAT_ADDPASS)
				clip(SplatWeight74_g19723 == 0.0f ? -1 : 1);
			#endif
			float4 SplatControl26_g19723 = ( tex2DNode5_g19723 / ( localSplatClip74_g19723 + 0.001 ) );
			float2 temp_output_59_0_g19723 = (SplatControl26_g19723).rg;
			float2 uv0_Splat0 = i.uv_texcoord * _Splat0_ST.xy + _Splat0_ST.zw;
			float4 tex2DNode85_g19723 = tex2D( _MaskMap0, uv0_Splat0 );
			float4 appendResult119_g19723 = (float4(( _Metallic0 * tex2DNode85_g19723.r ) , tex2DNode85_g19723.g , tex2DNode85_g19723.b , ( tex2DNode85_g19723.a * _Smoothness0 )));
			float2 uv0_Splat1 = i.uv_texcoord * _Splat1_ST.xy + _Splat1_ST.zw;
			float4 tex2DNode93_g19723 = tex2D( _MaskMap1, uv0_Splat1 );
			float4 appendResult118_g19723 = (float4(( _Metallic1 * tex2DNode93_g19723.r ) , tex2DNode93_g19723.g , tex2DNode93_g19723.b , ( tex2DNode93_g19723.a * _Smoothness1 )));
			float2 weightedBlendVar83_g19723 = temp_output_59_0_g19723;
			float4 weightedBlend83_g19723 = ( weightedBlendVar83_g19723.x*appendResult119_g19723 + weightedBlendVar83_g19723.y*appendResult118_g19723 );
			float4 break44 = weightedBlend83_g19723;
			float lerpResult38_g19728 = lerp( temp_output_36_0_g19728 , break44.y , _Occlusion);
			float temp_output_48_0_g19728 = 1.0;
			float lerpResult37_g19728 = lerp( temp_output_36_0_g19728 , saturate( temp_output_48_0_g19728 ) , _VertexOcclusion);
			float3 ase_worldPos = i.worldPos;
			float3 positionWS3_g19731 = ase_worldPos;
			float4x4 OcclusionProbesWorldToLocal3_g19731 = _OcclusionProbesWorldToLocal;
			float3 uv_OcclusionProbes3 = i.uv_tex3coord;
			uv_OcclusionProbes3.xy = i.uv_tex3coord.xy * _OcclusionProbes_ST.xy + _OcclusionProbes_ST.zw;
			float OcclusionProbes3_g19731 = tex3D( _OcclusionProbes, uv_OcclusionProbes3 ).r;
			float localSampleOcclusionProbes3_g19731 = SampleOcclusionProbes( positionWS3_g19731 , OcclusionProbesWorldToLocal3_g19731 , OcclusionProbes3_g19731 );
			float lerpResult1_g19731 = lerp( 1.0 , localSampleOcclusionProbes3_g19731 , ( _AOProbeStrength * _OCCLUSION_PROBE_GLOBAL ));
			float temp_output_7_0_g19728 = ( saturate( ( lerpResult38_g19728 * lerpResult37_g19728 ) ) * lerpResult1_g19731 );
			float lerpResult18_g19728 = lerp( 1.0 , temp_output_7_0_g19728 , _AOIndirect);
			float lerpResult14_g19728 = lerp( 1.0 , temp_output_7_0_g19728 , _AODirect);
			float lerpResult1_g19728 = lerp( lerpResult18_g19728 , lerpResult14_g19728 , ase_lightAtten);
			float temp_output_16_0_g19728 = saturate( lerpResult1_g19728 );
			float2 uv_Splat0 = i.uv_texcoord * _Splat0_ST.xy + _Splat0_ST.zw;
			float2 uv_Splat1 = i.uv_texcoord * _Splat1_ST.xy + _Splat1_ST.zw;
			float2 weightedBlendVar9_g19723 = temp_output_59_0_g19723;
			float4 weightedBlend9_g19723 = ( weightedBlendVar9_g19723.x*tex2D( _Splat0, uv_Splat0 ) + weightedBlendVar9_g19723.y*tex2D( _Splat1, uv_Splat1 ) );
			float4 MixDiffuse28_g19723 = weightedBlend9_g19723;
			float2 weightedBlendVar8_g19723 = temp_output_59_0_g19723;
			float4 weightedBlend8_g19723 = ( weightedBlendVar8_g19723.x*tex2D( _Normal0, uv0_Splat0 ) + weightedBlendVar8_g19723.y*tex2D( _Normal1, uv0_Splat1 ) );
			float3 temp_output_66_14 = UnpackScaleNormal( weightedBlend8_g19723, _NormalScale );
			float3 newWorldNormal11 = normalize( (WorldNormalVector( i , temp_output_66_14 )) );
			float clampResult8_g19724 = clamp( newWorldNormal11.x , -1.0 , 1.0 );
			float clampResult8_g19726 = clamp( newWorldNormal11.z , -1.0 , 1.0 );
			float3 appendResult12 = (float3(( ( clampResult8_g19724 * 0.5 ) + 0.5 ) , newWorldNormal11.y , ( ( clampResult8_g19726 * 0.5 ) + 0.5 )));
			float temp_output_63_0 = temp_output_16_0_g19728;
			float4 temp_cast_21 = (temp_output_63_0).xxxx;
			float4 temp_cast_22 = (temp_output_63_0).xxxx;
			#if defined(_SHADINGTYPE_DEFAULT)
				float4 staticSwitch33 = float4( ( temp_output_16_0_g19728 * MixDiffuse28_g19723.xyz ) , 0.0 );
			#elif defined(_SHADINGTYPE_NORMALSPBR)
				float4 staticSwitch33 = float4( appendResult12 , 0.0 );
			#elif defined(_SHADINGTYPE_NORMALS)
				float4 staticSwitch33 = float4( appendResult12 , 0.0 );
			#elif defined(_SHADINGTYPE_OCCLUSIONPBR)
				float4 staticSwitch33 = temp_cast_21;
			#elif defined(_SHADINGTYPE_OCCLUSION)
				float4 staticSwitch33 = temp_cast_22;
			#elif defined(_SHADINGTYPE_FLATPBR)
				float4 staticSwitch33 = _FlatColor;
			#elif defined(_SHADINGTYPE_FLAT)
				float4 staticSwitch33 = _FlatColor;
			#else
				float4 staticSwitch33 = float4( ( temp_output_16_0_g19728 * MixDiffuse28_g19723.xyz ) , 0.0 );
			#endif
			float4 switchResult67 = (((i.ASEVFace>0)?(staticSwitch33):(_BackColor)));
			float3 albedo51_g19736 = switchResult67.rgb;
			s1_g19736.Albedo = albedo51_g19736;
			float3 temp_output_13_0_g19735 = temp_output_66_14;
			float3 switchResult20_g19735 = (((i.ASEVFace>0)?(temp_output_13_0_g19735):(-temp_output_13_0_g19735)));
			float3 temp_output_55_0_g19736 = switchResult20_g19735;
			float3 normal_TS54_g19736 = temp_output_55_0_g19736;
			s1_g19736.Normal = WorldNormalVector( i , normal_TS54_g19736 );
			float3 emissive71_g19736 = float3(0,0,0);
			s1_g19736.Emission = emissive71_g19736;
			float metallic34_g19736 = break44.x;
			s1_g19736.Metallic = metallic34_g19736;
			float smoothness39_g19736 = break44.w;
			s1_g19736.Smoothness = smoothness39_g19736;
			float occlusion188_g19736 = saturate( ( temp_output_63_0 + _OCCLUSION_PROBE_TERRAIN ) );
			s1_g19736.Occlusion = occlusion188_g19736;

			data.light = gi.light;

			UnityGI gi1_g19736 = gi;
			#ifdef UNITY_PASS_FORWARDBASE
			Unity_GlossyEnvironmentData g1_g19736 = UnityGlossyEnvironmentSetup( s1_g19736.Smoothness, data.worldViewDir, s1_g19736.Normal, float3(0,0,0));
			gi1_g19736 = UnityGlobalIllumination( data, s1_g19736.Occlusion, s1_g19736.Normal, g1_g19736 );
			#endif

			float3 surfResult1_g19736 = LightingStandard ( s1_g19736, viewDir, gi1_g19736 ).rgb;
			surfResult1_g19736 += s1_g19736.Emission;

			#ifdef UNITY_PASS_FORWARDADD//1_g19736
			surfResult1_g19736 -= s1_g19736.Emission;
			#endif//1_g19736
			float3 clampResult196_g19736 = clamp( surfResult1_g19736 , float3(0,0,0) , float3(50,50,50) );
			float3 temp_output_3_3 = clampResult196_g19736;
			float4 temp_cast_29 = (temp_output_63_0).xxxx;
			#if defined(_SHADINGTYPE_DEFAULT)
				float4 staticSwitch31 = float4( temp_output_3_3 , 0.0 );
			#elif defined(_SHADINGTYPE_NORMALSPBR)
				float4 staticSwitch31 = float4( temp_output_3_3 , 0.0 );
			#elif defined(_SHADINGTYPE_NORMALS)
				float4 staticSwitch31 = float4( appendResult12 , 0.0 );
			#elif defined(_SHADINGTYPE_OCCLUSIONPBR)
				float4 staticSwitch31 = float4( temp_output_3_3 , 0.0 );
			#elif defined(_SHADINGTYPE_OCCLUSION)
				float4 staticSwitch31 = temp_cast_29;
			#elif defined(_SHADINGTYPE_FLATPBR)
				float4 staticSwitch31 = float4( temp_output_3_3 , 0.0 );
			#elif defined(_SHADINGTYPE_FLAT)
				float4 staticSwitch31 = _FlatColor;
			#else
				float4 staticSwitch31 = float4( temp_output_3_3 , 0.0 );
			#endif
			c.rgb = staticSwitch31.rgb;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
			float temp_output_36_0_g19728 = 1.0;
			float2 uv_Control = i.uv_texcoord * _Control_ST.xy + _Control_ST.zw;
			float4 tex2DNode5_g19723 = tex2D( _Control, uv_Control );
			float dotResult20_g19723 = dot( tex2DNode5_g19723 , float4(1,1,1,1) );
			float SplatWeight22_g19723 = dotResult20_g19723;
			float localSplatClip74_g19723 = ( SplatWeight22_g19723 );
			float SplatWeight74_g19723 = SplatWeight22_g19723;
			#if !defined(SHADER_API_MOBILE) && defined(TERRAIN_SPLAT_ADDPASS)
				clip(SplatWeight74_g19723 == 0.0f ? -1 : 1);
			#endif
			float4 SplatControl26_g19723 = ( tex2DNode5_g19723 / ( localSplatClip74_g19723 + 0.001 ) );
			float2 temp_output_59_0_g19723 = (SplatControl26_g19723).rg;
			float2 uv0_Splat0 = i.uv_texcoord * _Splat0_ST.xy + _Splat0_ST.zw;
			float4 tex2DNode85_g19723 = tex2D( _MaskMap0, uv0_Splat0 );
			float4 appendResult119_g19723 = (float4(( _Metallic0 * tex2DNode85_g19723.r ) , tex2DNode85_g19723.g , tex2DNode85_g19723.b , ( tex2DNode85_g19723.a * _Smoothness0 )));
			float2 uv0_Splat1 = i.uv_texcoord * _Splat1_ST.xy + _Splat1_ST.zw;
			float4 tex2DNode93_g19723 = tex2D( _MaskMap1, uv0_Splat1 );
			float4 appendResult118_g19723 = (float4(( _Metallic1 * tex2DNode93_g19723.r ) , tex2DNode93_g19723.g , tex2DNode93_g19723.b , ( tex2DNode93_g19723.a * _Smoothness1 )));
			float2 weightedBlendVar83_g19723 = temp_output_59_0_g19723;
			float4 weightedBlend83_g19723 = ( weightedBlendVar83_g19723.x*appendResult119_g19723 + weightedBlendVar83_g19723.y*appendResult118_g19723 );
			float4 break44 = weightedBlend83_g19723;
			float lerpResult38_g19728 = lerp( temp_output_36_0_g19728 , break44.y , _Occlusion);
			float temp_output_48_0_g19728 = 1.0;
			float lerpResult37_g19728 = lerp( temp_output_36_0_g19728 , saturate( temp_output_48_0_g19728 ) , _VertexOcclusion);
			float3 ase_worldPos = i.worldPos;
			float3 positionWS3_g19731 = ase_worldPos;
			float4x4 OcclusionProbesWorldToLocal3_g19731 = _OcclusionProbesWorldToLocal;
			float3 uv_OcclusionProbes3 = i.uv_tex3coord;
			uv_OcclusionProbes3.xy = i.uv_tex3coord.xy * _OcclusionProbes_ST.xy + _OcclusionProbes_ST.zw;
			float OcclusionProbes3_g19731 = tex3D( _OcclusionProbes, uv_OcclusionProbes3 ).r;
			float localSampleOcclusionProbes3_g19731 = SampleOcclusionProbes( positionWS3_g19731 , OcclusionProbesWorldToLocal3_g19731 , OcclusionProbes3_g19731 );
			float lerpResult1_g19731 = lerp( 1.0 , localSampleOcclusionProbes3_g19731 , ( _AOProbeStrength * _OCCLUSION_PROBE_GLOBAL ));
			float temp_output_7_0_g19728 = ( saturate( ( lerpResult38_g19728 * lerpResult37_g19728 ) ) * lerpResult1_g19731 );
			float lerpResult18_g19728 = lerp( 1.0 , temp_output_7_0_g19728 , _AOIndirect);
			float lerpResult14_g19728 = lerp( 1.0 , temp_output_7_0_g19728 , _AODirect);
			float lerpResult1_g19728 = lerp( lerpResult18_g19728 , lerpResult14_g19728 , 1);
			float temp_output_16_0_g19728 = saturate( lerpResult1_g19728 );
			float2 uv_Splat0 = i.uv_texcoord * _Splat0_ST.xy + _Splat0_ST.zw;
			float2 uv_Splat1 = i.uv_texcoord * _Splat1_ST.xy + _Splat1_ST.zw;
			float2 weightedBlendVar9_g19723 = temp_output_59_0_g19723;
			float4 weightedBlend9_g19723 = ( weightedBlendVar9_g19723.x*tex2D( _Splat0, uv_Splat0 ) + weightedBlendVar9_g19723.y*tex2D( _Splat1, uv_Splat1 ) );
			float4 MixDiffuse28_g19723 = weightedBlend9_g19723;
			float2 weightedBlendVar8_g19723 = temp_output_59_0_g19723;
			float4 weightedBlend8_g19723 = ( weightedBlendVar8_g19723.x*tex2D( _Normal0, uv0_Splat0 ) + weightedBlendVar8_g19723.y*tex2D( _Normal1, uv0_Splat1 ) );
			float3 temp_output_66_14 = UnpackScaleNormal( weightedBlend8_g19723, _NormalScale );
			float3 newWorldNormal11 = normalize( (WorldNormalVector( i , temp_output_66_14 )) );
			float clampResult8_g19724 = clamp( newWorldNormal11.x , -1.0 , 1.0 );
			float clampResult8_g19726 = clamp( newWorldNormal11.z , -1.0 , 1.0 );
			float3 appendResult12 = (float3(( ( clampResult8_g19724 * 0.5 ) + 0.5 ) , newWorldNormal11.y , ( ( clampResult8_g19726 * 0.5 ) + 0.5 )));
			float temp_output_63_0 = temp_output_16_0_g19728;
			float4 temp_cast_9 = (temp_output_63_0).xxxx;
			float4 temp_cast_10 = (temp_output_63_0).xxxx;
			#if defined(_SHADINGTYPE_DEFAULT)
				float4 staticSwitch33 = float4( ( temp_output_16_0_g19728 * MixDiffuse28_g19723.xyz ) , 0.0 );
			#elif defined(_SHADINGTYPE_NORMALSPBR)
				float4 staticSwitch33 = float4( appendResult12 , 0.0 );
			#elif defined(_SHADINGTYPE_NORMALS)
				float4 staticSwitch33 = float4( appendResult12 , 0.0 );
			#elif defined(_SHADINGTYPE_OCCLUSIONPBR)
				float4 staticSwitch33 = temp_cast_9;
			#elif defined(_SHADINGTYPE_OCCLUSION)
				float4 staticSwitch33 = temp_cast_10;
			#elif defined(_SHADINGTYPE_FLATPBR)
				float4 staticSwitch33 = _FlatColor;
			#elif defined(_SHADINGTYPE_FLAT)
				float4 staticSwitch33 = _FlatColor;
			#else
				float4 staticSwitch33 = float4( ( temp_output_16_0_g19728 * MixDiffuse28_g19723.xyz ) , 0.0 );
			#endif
			float4 switchResult67 = (((i.ASEVFace>0)?(staticSwitch33):(_BackColor)));
			float3 albedo51_g19736 = switchResult67.rgb;
			o.Albedo = ( _GlobalIlluminationAlbedoEffect * albedo51_g19736 );
			float3 emissive71_g19736 = float3(0,0,0);
			o.Emission = ( _GlobalIlluminationEmissiveEffect * emissive71_g19736 );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 customPack2 : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.customPack2.xyz = customInputData.uv_tex3coord;
				o.customPack2.xyz = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				surfIN.uv_tex3coord = IN.customPack2.xyz;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}

	Dependency "BaseMapShader "="ASESampleShaders/TerrainBase"
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17500
6.4;0;1523;803;769.6946;481.8525;1.3;True;False
Node;AmplifyShaderEditor.FunctionNode;66;-2250.525,-110.9784;Inherit;False;Two Splats First Pass Terrain;24;;19723;a2807dbab3b816d4d91853c7da1b8578;0;5;59;FLOAT2;0,0;False;60;FLOAT4;0,0,0,0;False;61;FLOAT3;0,0,0;False;91;FLOAT4;0,0,0,0;False;62;FLOAT;0;False;5;FLOAT4;0;FLOAT3;14;FLOAT4;94;FLOAT;19;FLOAT3;17
Node;AmplifyShaderEditor.WorldNormalVector;11;-1713.269,304.3552;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.BreakToComponentsNode;44;-1724.106,0.7590027;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;5;-1873.097,-189.9078;Inherit;False;Constant;_Float9;Float 9;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;9;-1435.016,277.8517;Inherit;False;Pack (-1_1 to 0_1);-1;;19724;03a4f7d823d57204f9f07b2b0a5142db;0;1;7;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;14;-1452.458,415.6905;Inherit;False;Pack (-1_1 to 0_1);-1;;19726;03a4f7d823d57204f9f07b2b0a5142db;0;1;7;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;12;-1201.723,325.4948;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;63;-1421.098,-220.0078;Inherit;False;Occlusion Probes;55;;19728;fc5cec86a89be184e93fc845da77a0cc;4,64,0,22,1,65,0,66,1;3;12;FLOAT;0;False;48;FLOAT;0;False;26;FLOAT3;1,1,1;False;2;FLOAT;0;FLOAT3;31
Node;AmplifyShaderEditor.ColorNode;32;-1263.042,566.5662;Inherit;False;Property;_FlatColor;Flat Color;48;0;Create;True;0;0;False;0;0,0,0,0;0,0.1719473,0.2199999,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;37;-925.1007,-93.84961;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;41;-943.1638,-65.96877;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-1396.437,-33.07534;Inherit;False;Global;_OCCLUSION_PROBE_TERRAIN;_OCCLUSION_PROBE_TERRAIN;62;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;40;-992.1007,-118.8496;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;39;-857.1007,-14.84961;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;38;-881.1007,-70.84961;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;64;-1089.819,-45.72665;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;33;-786.3734,-242.4609;Inherit;False;Property;_Keyword0;Keyword 0;8;0;Create;True;0;0;False;0;0;0;0;False;;KeywordEnum;4;Default;Normals;Occlusion;Flat;Reference;31;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;45;-1655.106,151.759;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;71;-586.6479,2.569517;Inherit;False;Property;_BackColor;Back Color;50;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0.8862745;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;69;-566.0296,193.1923;Inherit;False;Normal BackFace;-1;;19735;121446c878db06f4c847f9c5afed7cfe;0;1;13;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;62;-532.5762,307.1338;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;67;-224.368,1.913377;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;3;74.56781,67.18457;Inherit;False;Custom Lighting;51;;19736;b225dcbb02c65fb46af1dbc43764905b;1,67,0;7;56;FLOAT3;0,0,0;False;55;FLOAT3;0,0,0;False;70;FLOAT3;0,0,0;False;45;FLOAT;0;False;148;FLOAT3;0,0,0;False;41;FLOAT;0;False;189;FLOAT;0;False;3;FLOAT3;4;FLOAT3;5;FLOAT3;3
Node;AmplifyShaderEditor.RangedFloatNode;76;-483.5134,-326.4451;Inherit;False;Property;_Opacity;Opacity;23;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;75;-165.5134,-163.4451;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;58;-1890.015,203.3746;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;6;886.2458,525.3344;Inherit;False;Internal Features Support;-1;;19737;3c493d142aeebd840af72d626f6915c6;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;31;584.4419,379.267;Inherit;False;Property;_ShadingType;ShadingType;47;0;Create;True;0;0;False;0;0;0;0;True;;KeywordEnum;7;Default;NormalsPBR;Normals;OcclusionPBR;Occlusion;FlatPBR;Flat;Create;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;56;-2257.49,59.74006;Inherit;False;Four Splats First Pass Terrain;0;;19738;37452fdfb732e1443b7e39720d05b708;0;5;59;FLOAT4;0,0,0,0;False;60;FLOAT4;0,0,0,0;False;61;FLOAT3;0,0,0;False;91;FLOAT4;0,0,0,0;False;62;FLOAT;0;False;5;FLOAT4;0;FLOAT3;14;FLOAT4;94;FLOAT;19;FLOAT3;17
Node;AmplifyShaderEditor.ComponentMaskNode;74;196.9865,-41.44513;Inherit;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;72;-369.7953,-168.4566;Inherit;False;Property;_CullMode;Cull Mode;49;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;0;0;2;0;1;INT;0
Node;AmplifyShaderEditor.WireNode;77;252.4866,-160.4451;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;966.5157,-10.64535;Float;False;True;-1;7;ASEMaterialInspector;0;0;CustomLighting;appalachia/terrain-first-pass;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;-100;True;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;False;False;_BILLBOARD_ON;Relative;0;;0;-1;-1;-1;0;False;1;BaseMapShader =ASESampleShaders/TerrainBase;0;True;72;-1;0;False;-1;1;Pragma;multi_compile_fog;False;;Custom;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;14;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT3;0,0,0;False;0
WireConnection;11;0;66;14
WireConnection;44;0;66;94
WireConnection;9;7;11;1
WireConnection;14;7;11;3
WireConnection;12;0;9;0
WireConnection;12;1;11;2
WireConnection;12;2;14;0
WireConnection;63;12;44;1
WireConnection;63;48;5;0
WireConnection;63;26;66;0
WireConnection;37;0;12;0
WireConnection;41;0;63;0
WireConnection;40;0;63;0
WireConnection;39;0;32;0
WireConnection;38;0;12;0
WireConnection;64;0;63;0
WireConnection;64;1;60;0
WireConnection;33;1;63;31
WireConnection;33;0;37;0
WireConnection;33;2;38;0
WireConnection;33;3;41;0
WireConnection;33;4;40;0
WireConnection;33;5;39;0
WireConnection;33;6;32;0
WireConnection;45;0;66;14
WireConnection;69;13;45;0
WireConnection;62;0;64;0
WireConnection;67;0;33;0
WireConnection;67;1;71;0
WireConnection;3;56;67;0
WireConnection;3;55;69;0
WireConnection;3;45;44;0
WireConnection;3;41;44;3
WireConnection;3;189;62;0
WireConnection;75;0;76;0
WireConnection;75;1;71;4
WireConnection;58;0;66;17
WireConnection;31;1;3;3
WireConnection;31;0;3;3
WireConnection;31;2;12;0
WireConnection;31;3;3;3
WireConnection;31;4;63;0
WireConnection;31;5;3;3
WireConnection;31;6;32;0
WireConnection;74;0;67;0
WireConnection;77;0;75;0
WireConnection;0;0;3;4
WireConnection;0;2;3;5
WireConnection;0;9;77;0
WireConnection;0;14;31;0
WireConnection;0;11;58;0
ASEEND*/
//CHKSM=ABF0571001E514360D3AB0F79CCA93EC53FD928A