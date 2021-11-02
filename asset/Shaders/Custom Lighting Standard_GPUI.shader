// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "GPUInstancer/appalachia/Standard"
{
	Properties
	{
		_MainTex("Albedo", 2D) = "white" {}
		_Color("Color", Color) = (0,0,0,0)
		[NoScaleOffset][Normal]_BumpMap("Normal", 2D) = "bump" {}
		_BumpScale("Normal Scale", Range( 0 , 5)) = 0
		[NoScaleOffset]_EmissionMap("Emission Map", 2D) = "white" {}
		_EmissionColor("Emission Color", Color) = (0,0,0,0)
		_EmissionStrength("Emission Strength", Range( 0 , 5)) = 1
		[Toggle(_USESURFACEMAP_ON)] _UseSurfaceMap("Use Surface Map", Float) = 0
		[NoScaleOffset]_SurfaceMap("Surface Map", 2D) = "white" {}
		[NoScaleOffset]_MetallicGlossMap("Metallic Map", 2D) = "white" {}
		_Metallic("Metallic", Range( 0 , 1)) = 0
		[NoScaleOffset]_SmoothnessMap("Smoothness Map", 2D) = "white" {}
		_Glossiness("Smoothness", Range( 0 , 1)) = 0.1
		[Toggle]_InvertSmoothness("Invert Smoothness", Float) = 0
		[NoScaleOffset]_OcclusionMap("Occlusion Map", 2D) = "white" {}
		_OcclusionStrength("Occlusion", Range( 0 , 1)) = 1
		[HideInInspector][AppalachiaCategory(Occlusion)]_OCCLUSIONN("[ OCCLUSIONN ]", Float) = 0
		_Occlusion("Texture Occlusion", Range( 0 , 1)) = 0.5
		_AOProbeStrength("AO Probe Strength", Range( 0 , 1)) = 0.8
		_AOIndirect("AO Indirect", Range( 0 , 1)) = 1
		_AODirect("AO Direct", Range( 0 , 1)) = 0
		[HideInInspector][AppalachiaCategory(Global Illumination)]_GLOBALILLUMINATIONN("[ GLOBAL ILLUMINATIONN ]", Float) = 0
		_GlobalIlluminationAlbedoEffect("Global Illumination Albedo Effect", Range( 0 , 5)) = 1
		_GlobalIlluminationEmissiveEffect("Global Illumination Emissive Effect", Range( 0 , 5)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex3coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityStandardUtils.cginc"
		#include "Lighting.cginc"
		#pragma target 4.5
		#pragma shader_feature_local _USESURFACEMAP_ON
		#include "Assets/Resources/CGIncludes/Appalachia/indirect.cginc"
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

		uniform half _GLOBALILLUMINATIONN;
		uniform half _OCCLUSIONN;
		uniform float _GlobalIlluminationAlbedoEffect;
		uniform sampler2D _OcclusionMap;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform sampler2D _SurfaceMap;
		uniform float _OcclusionStrength;
		uniform half _Occlusion;
		uniform float4x4 _OcclusionProbesWorldToLocal;
		uniform sampler3D _OcclusionProbes;
		uniform float4 _OcclusionProbes_ST;
		uniform float _AOProbeStrength;
		uniform float _AOIndirect;
		uniform float _AODirect;
		uniform float4 _Color;
		uniform float _GlobalIlluminationEmissiveEffect;
		uniform sampler2D _EmissionMap;
		uniform float4 _EmissionColor;
		uniform float _EmissionStrength;
		uniform float _BumpScale;
		uniform sampler2D _BumpMap;
		uniform sampler2D _MetallicGlossMap;
		uniform float _Metallic;
		uniform float _InvertSmoothness;
		uniform sampler2D _SmoothnessMap;
		uniform float _Glossiness;


		float SampleOcclusionProbes( float3 positionWS , float4x4 OcclusionProbesWorldToLocal , float OcclusionProbes )
		{
			float occlusionProbes = 1;
			float3 pos = mul(_OcclusionProbesWorldToLocal, float4(positionWS, 1)).xyz;
			occlusionProbes = tex3D(_OcclusionProbes, pos).a;
			return occlusionProbes;
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
			SurfaceOutputStandard s1_g235 = (SurfaceOutputStandard ) 0;
			float temp_output_36_0_g19899 = 1.0;
			float2 uv0_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 UV77 = uv0_MainTex;
			float4 tex2DNode34 = tex2D( _SurfaceMap, UV77 );
			#ifdef _USESURFACEMAP_ON
				float staticSwitch44 = tex2DNode34.g;
			#else
				float staticSwitch44 = tex2D( _OcclusionMap, UV77 ).r;
			#endif
			float lerpResult74 = lerp( 1.0 , staticSwitch44 , _OcclusionStrength);
			float _OCCLUSION48 = lerpResult74;
			float lerpResult38_g19899 = lerp( temp_output_36_0_g19899 , _OCCLUSION48 , _Occlusion);
			float3 ase_worldPos = i.worldPos;
			float3 positionWS3_g19900 = ase_worldPos;
			float4x4 OcclusionProbesWorldToLocal3_g19900 = _OcclusionProbesWorldToLocal;
			float3 uv_OcclusionProbes3 = i.uv_tex3coord;
			uv_OcclusionProbes3.xy = i.uv_tex3coord.xy * _OcclusionProbes_ST.xy + _OcclusionProbes_ST.zw;
			float OcclusionProbes3_g19900 = tex3D( _OcclusionProbes, uv_OcclusionProbes3 ).r;
			float localSampleOcclusionProbes3_g19900 = SampleOcclusionProbes( positionWS3_g19900 , OcclusionProbesWorldToLocal3_g19900 , OcclusionProbes3_g19900 );
			float lerpResult1_g19900 = lerp( 1.0 , localSampleOcclusionProbes3_g19900 , _AOProbeStrength);
			float temp_output_7_0_g19899 = ( saturate( ( lerpResult38_g19899 * temp_output_36_0_g19899 ) ) * lerpResult1_g19900 );
			float lerpResult18_g19899 = lerp( 1.0 , temp_output_7_0_g19899 , _AOIndirect);
			float lerpResult14_g19899 = lerp( 1.0 , temp_output_7_0_g19899 , _AODirect);
			float lerpResult1_g19899 = lerp( lerpResult18_g19899 , lerpResult14_g19899 , ase_lightAtten);
			float temp_output_16_0_g19899 = saturate( lerpResult1_g19899 );
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode2 = tex2D( _MainTex, uv_MainTex );
			float4 _ALBEDO23 = ( tex2DNode2 * _Color );
			float3 albedo51_g235 = ( temp_output_16_0_g19899 * _ALBEDO23.rgb );
			s1_g235.Albedo = albedo51_g235;
			float3 _NORMAL_TS25 = UnpackScaleNormal( tex2D( _BumpMap, UV77 ), _BumpScale );
			float3 normal_WS54_g235 = normalize( (WorldNormalVector( i , _NORMAL_TS25 )) );
			s1_g235.Normal = normal_WS54_g235;
			float4 _EMISSION20 = ( tex2D( _EmissionMap, UV77 ) * _EmissionColor * _EmissionStrength );
			float3 emissive71_g235 = _EMISSION20.rgb;
			s1_g235.Emission = emissive71_g235;
			#ifdef _USESURFACEMAP_ON
				float staticSwitch35 = tex2DNode34.r;
			#else
				float staticSwitch35 = tex2D( _MetallicGlossMap, UV77 ).r;
			#endif
			float _METALLIC33 = ( staticSwitch35 * _Metallic );
			float metallic34_g235 = _METALLIC33;
			s1_g235.Metallic = metallic34_g235;
			#ifdef _USESURFACEMAP_ON
				float staticSwitch55 = tex2DNode34.a;
			#else
				float staticSwitch55 = tex2D( _SmoothnessMap, UV77 ).r;
			#endif
			float _SMOOTHNESS58 = ( (( _InvertSmoothness )?( ( 1.0 - staticSwitch55 ) ):( staticSwitch55 )) * _Glossiness );
			float smoothness39_g235 = _SMOOTHNESS58;
			s1_g235.Smoothness = smoothness39_g235;
			float occlusion188_g235 = temp_output_16_0_g19899;
			s1_g235.Occlusion = occlusion188_g235;

			data.light = gi.light;

			UnityGI gi1_g235 = gi;
			#ifdef UNITY_PASS_FORWARDBASE
			Unity_GlossyEnvironmentData g1_g235 = UnityGlossyEnvironmentSetup( s1_g235.Smoothness, data.worldViewDir, s1_g235.Normal, float3(0,0,0));
			gi1_g235 = UnityGlobalIllumination( data, s1_g235.Occlusion, s1_g235.Normal, g1_g235 );
			#endif

			float3 surfResult1_g235 = LightingStandard ( s1_g235, viewDir, gi1_g235 ).rgb;
			surfResult1_g235 += s1_g235.Emission;

			#ifdef UNITY_PASS_FORWARDADD//1_g235
			surfResult1_g235 -= s1_g235.Emission;
			#endif//1_g235
			c.rgb = surfResult1_g235;
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
			float temp_output_36_0_g19899 = 1.0;
			float2 uv0_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 UV77 = uv0_MainTex;
			float4 tex2DNode34 = tex2D( _SurfaceMap, UV77 );
			#ifdef _USESURFACEMAP_ON
				float staticSwitch44 = tex2DNode34.g;
			#else
				float staticSwitch44 = tex2D( _OcclusionMap, UV77 ).r;
			#endif
			float lerpResult74 = lerp( 1.0 , staticSwitch44 , _OcclusionStrength);
			float _OCCLUSION48 = lerpResult74;
			float lerpResult38_g19899 = lerp( temp_output_36_0_g19899 , _OCCLUSION48 , _Occlusion);
			float3 ase_worldPos = i.worldPos;
			float3 positionWS3_g19900 = ase_worldPos;
			float4x4 OcclusionProbesWorldToLocal3_g19900 = _OcclusionProbesWorldToLocal;
			float3 uv_OcclusionProbes3 = i.uv_tex3coord;
			uv_OcclusionProbes3.xy = i.uv_tex3coord.xy * _OcclusionProbes_ST.xy + _OcclusionProbes_ST.zw;
			float OcclusionProbes3_g19900 = tex3D( _OcclusionProbes, uv_OcclusionProbes3 ).r;
			float localSampleOcclusionProbes3_g19900 = SampleOcclusionProbes( positionWS3_g19900 , OcclusionProbesWorldToLocal3_g19900 , OcclusionProbes3_g19900 );
			float lerpResult1_g19900 = lerp( 1.0 , localSampleOcclusionProbes3_g19900 , _AOProbeStrength);
			float temp_output_7_0_g19899 = ( saturate( ( lerpResult38_g19899 * temp_output_36_0_g19899 ) ) * lerpResult1_g19900 );
			float lerpResult18_g19899 = lerp( 1.0 , temp_output_7_0_g19899 , _AOIndirect);
			float lerpResult14_g19899 = lerp( 1.0 , temp_output_7_0_g19899 , _AODirect);
			float lerpResult1_g19899 = lerp( lerpResult18_g19899 , lerpResult14_g19899 , 1);
			float temp_output_16_0_g19899 = saturate( lerpResult1_g19899 );
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode2 = tex2D( _MainTex, uv_MainTex );
			float4 _ALBEDO23 = ( tex2DNode2 * _Color );
			float3 albedo51_g235 = ( temp_output_16_0_g19899 * _ALBEDO23.rgb );
			o.Albedo = ( _GlobalIlluminationAlbedoEffect * albedo51_g235 );
			float4 _EMISSION20 = ( tex2D( _EmissionMap, UV77 ) * _EmissionColor * _EmissionStrength );
			float3 emissive71_g235 = _EMISSION20.rgb;
			o.Emission = ( _GlobalIlluminationEmissiveEffect * emissive71_g235 );
		}

		ENDCG
		CGPROGRAM
#include "UnityCG.cginc"
#include "Assets/Resources/CGIncludes/Appalachia/GPUInstancerInclude.cginc"
#pragma instancing_options procedural:setupGPUI
#pragma multi_compile_instancing
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
#include "UnityCG.cginc"
#include "Assets/Resources/CGIncludes/Appalachia/GPUInstancerInclude.cginc"
#pragma instancing_options procedural:setupGPUI
#pragma multi_compile_instancing
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.5
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
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17500
17.6;-752;1381;486;3518.975;-615.5905;1;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;76;-3328,-1024;Inherit;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;77;-3104,-1024;Inherit;False;UV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;81;-3712,320;Inherit;False;77;UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;34;-3456,304;Inherit;True;Property;_SurfaceMap;Surface Map;8;1;[NoScaleOffset];Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;85;-3024.775,1219.111;Inherit;False;77;UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;54;-2838.775,1212.111;Inherit;True;Property;_SmoothnessMap;Smoothness Map;14;1;[NoScaleOffset];Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;192;-3205.19,1285.653;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;82;-2992,784;Inherit;False;77;UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;59;-2832,976;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;55;-2533.775,1435.111;Inherit;False;Property;_Surface_Map;Surface_Map;13;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Reference;35;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;43;-2815,768;Inherit;True;Property;_OcclusionMap;Occlusion Map;17;1;[NoScaleOffset];Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;80;-3073.917,144;Inherit;False;77;UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-2560,1024;Inherit;False;Property;_OcclusionStrength;Occlusion;18;0;Create;False;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;75;-2353,786;Inherit;False;Constant;_Float0;Float 0;24;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;21;-2744,-832;Inherit;False;Property;_Color;Color;1;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;42;-2833.917,336;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;11;-2817.917,128;Inherit;True;Property;_MetallicGlossMap;Metallic Map;9;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;162;-2242.282,1489.282;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-2816,-1024;Inherit;True;Property;_MainTex;Albedo;0;0;Create;False;0;0;False;0;-1;None;138df4511c079324cabae1f7f865c1c1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;79;-3072,-352;Inherit;False;77;UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;44;-2432,896;Inherit;False;Property;_Surface_Map;Surface_Map;12;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Reference;35;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;161;-2105.775,1391.111;Inherit;False;Property;_InvertSmoothness;Invert Smoothness;16;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-2202.775,1594.111;Inherit;False;Property;_Glossiness;Smoothness;15;0;Create;False;0;0;False;0;0.1;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;74;-2176,896;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-2542.917,384;Inherit;False;Property;_Metallic;Metallic;10;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;78;-3090,-671;Inherit;False;77;UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-2817,-16;Inherit;False;Property;_EmissionStrength;Emission Strength;6;0;Create;True;0;0;False;0;1;0.76;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;5;-2752,-192;Inherit;False;Property;_EmissionColor;Emission Color;5;0;Create;False;0;0;False;0;0,0,0,0;0.0754717,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;35;-2479.104,267.0457;Inherit;False;Property;_UseSurfaceMap;Use Surface Map;7;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Multiple;MAOHS;Create;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;4;-2828,-404;Inherit;True;Property;_EmissionMap;Emission Map;4;1;[NoScaleOffset];Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;24;-3184,-592;Inherit;False;Property;_BumpScale;Normal Scale;3;0;Create;False;0;0;False;0;0;1.85;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-2496,-960;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-1813.775,1337.111;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;48;-2016,896;Inherit;False;_OCCLUSION;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-2177.917,256;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;3;-2816,-640;Inherit;True;Property;_BumpMap;Normal;2;2;[NoScaleOffset];[Normal];Create;False;0;0;False;0;-1;None;77fdad851e93f394c9f8a1b1a63b56f3;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;23;-2304,-960;Inherit;False;_ALBEDO;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-2432,-384;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;26;-515.2,302;Inherit;False;23;_ALBEDO;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;20;-2264.4,-391.8;Inherit;False;_EMISSION;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;33;-2049.917,256;Inherit;False;_METALLIC;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;58;-1685.775,1337.111;Inherit;False;_SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;88;-511,213;Inherit;False;48;_OCCLUSION;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;25;-2432,-640;Inherit;False;_NORMAL_TS;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;190;-195.3112,161.8606;Inherit;False;Occlusion Probes;19;;19899;fc5cec86a89be184e93fc845da77a0cc;4,22,1,65,1,66,0,64,1;3;12;FLOAT;0;False;48;FLOAT;0;False;26;FLOAT3;1,1,1;False;2;FLOAT;0;FLOAT3;31
Node;AmplifyShaderEditor.GetLocalVarNode;27;-510,-111;Inherit;False;25;_NORMAL_TS;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;28;-510,-32;Inherit;False;20;_EMISSION;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;86;-512,46;Inherit;False;33;_METALLIC;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;87;-512,128;Inherit;False;58;_SMOOTHNESS;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;152;-2423.621,519.1543;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;143;-2412,-856;Inherit;False;albedo_alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;124;-2556,645;Inherit;False;Property;_Specularity;Specularity;12;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;125;-2016,559;Inherit;False;_SPECULAR;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;128;-2816,432;Inherit;True;Property;_SpecGlossMap;Specularity Map;11;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;126;-3008,464;Inherit;False;77;UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;188;204.204,-71.15521;Inherit;False;Custom Lighting;29;;235;b225dcbb02c65fb46af1dbc43764905b;1,67,0;7;56;FLOAT3;0,0,0;False;55;FLOAT3;0,0,0;False;70;FLOAT3;0,0,0;False;45;FLOAT;0;False;148;FLOAT3;0,0,0;False;41;FLOAT;0;False;189;FLOAT;0;False;3;FLOAT3;4;FLOAT3;5;FLOAT3;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;122;-2176,560;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;755.3914,-160.3595;Float;False;True;-1;5;ASEMaterialInspector;0;0;CustomLighting;GPUInstancer/appalachia/Standard;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;2;Include;;True;daec767d067045cf9bd7d0096189bd18;Custom;Pragma;instancing_options procedural:setup;False;;Custom;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;14;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT3;0,0,0;False;0
WireConnection;77;0;76;0
WireConnection;34;1;81;0
WireConnection;54;1;85;0
WireConnection;192;0;34;4
WireConnection;59;0;34;2
WireConnection;55;1;54;1
WireConnection;55;0;192;0
WireConnection;43;1;82;0
WireConnection;42;0;34;1
WireConnection;11;1;80;0
WireConnection;162;0;55;0
WireConnection;44;1;43;1
WireConnection;44;0;59;0
WireConnection;161;0;55;0
WireConnection;161;1;162;0
WireConnection;74;0;75;0
WireConnection;74;1;44;0
WireConnection;74;2;47;0
WireConnection;35;1;11;1
WireConnection;35;0;42;0
WireConnection;4;1;79;0
WireConnection;22;0;2;0
WireConnection;22;1;21;0
WireConnection;56;0;161;0
WireConnection;56;1;57;0
WireConnection;48;0;74;0
WireConnection;12;0;35;0
WireConnection;12;1;31;0
WireConnection;3;1;78;0
WireConnection;3;5;24;0
WireConnection;23;0;22;0
WireConnection;6;0;4;0
WireConnection;6;1;5;0
WireConnection;6;2;32;0
WireConnection;20;0;6;0
WireConnection;33;0;12;0
WireConnection;58;0;56;0
WireConnection;25;0;3;0
WireConnection;190;12;88;0
WireConnection;190;26;26;0
WireConnection;152;0;128;0
WireConnection;143;0;2;4
WireConnection;125;0;122;0
WireConnection;128;1;126;0
WireConnection;188;56;190;31
WireConnection;188;55;27;0
WireConnection;188;70;28;0
WireConnection;188;45;86;0
WireConnection;188;41;87;0
WireConnection;188;189;190;0
WireConnection;122;0;152;0
WireConnection;122;1;124;0
WireConnection;0;0;188;4
WireConnection;0;2;188;5
WireConnection;0;14;188;3
ASEEND*/
//CHKSM=FB927471408A14C42FF73CBEA990182FC88828E3
