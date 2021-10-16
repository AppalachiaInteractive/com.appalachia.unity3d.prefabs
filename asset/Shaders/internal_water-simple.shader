// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "internal/water-simple"
{
	Properties
	{
		[InternalBanner(Internal,Standard)]_BANNER("BANNER", Float) = 1
		[InternalCategory(Rendering)]_RENDERINGG("[ RENDERINGG  ]", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("Cull Mode", Float) = 2
		_MaskClipValue("Mask Clip Value", Range( 0 , 1)) = 0.5
		[Toggle]_AlphaToCoverage("Alpha To Coverage", Float) = 0
		[Toggle]_ZWriteMode("ZWrite Mode", Float) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTest Mode", Float) = 4
		[InternalCategory(Albedo)]_ALBEDOO("[ ALBEDOO ]", Float) = 0
		_MainTex("Albedo", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,0)
		_Saturation("Saturation", Range( -1 , 4)) = 0
		_Brightness("Brightness", Range( -1 , 4)) = 0
		_Contrast("Contrast", Range( 0 , 10)) = 1
		_ContrastCorrection("Contrast Correction", Range( 0 , 10)) = 1
		[InternalCategory(Normal)]_NORMALL("[ NORMALL ]", Float) = 0
		[NoScaleOffset][Normal]_BumpMap("Normal", 2D) = "bump" {}
		_BumpScale("Normal Scale", Range( 0 , 5)) = 1
		[InternalCategory(Emission)]_EMISSIONN("[ EMISSIONN ]", Float) = 0
		[NoScaleOffset]_EmissionMap("Emission Map", 2D) = "white" {}
		_EmissionColor("Emission Color", Color) = (0,0,0,0)
		_EmissionStrength("Emission Strength", Range( 0 , 5)) = 1
		[InternalCategory(Specularity)]_SPECULARITYY("[ SPECULARITYY  ]", Float) = 0
		[InternalCategory(Surface)]_SURFACEE("[ SURFACEE ]", Float) = 0
		[NoScaleOffset]_MetallicGlossMap("Surface Map", 2D) = "white" {}
		[Toggle]_IgnoreMetallicMap("Ignore Metallic Map", Range( 0 , 1)) = 0
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_Glossiness("Smoothness", Range( 0 , 1)) = 0.1
		[Toggle]_InvertSmoothness("Invert Smoothness", Float) = 0
		_OcclusionStrength("Occlusion", Range( 0 , 1)) = 1
		[InternalCategory(Occlusion)]_OCCLUSIONN("[ OCCLUSIONN ]", Float) = 0
		_Occlusion("Texture Occlusion", Range( 0 , 1)) = 0.5
		_AOProbeStrength("AO Probe Strength", Range( 0 , 1)) = 0.8
		_AOIndirect("AO Indirect", Range( 0 , 1)) = 1
		_AODirect("AO Direct", Range( 0 , 1)) = 0
		[InternalCategory(Global Illumination)]_GLOBALILLUMINATIONN("[ GLOBAL ILLUMINATIONN ]", Float) = 0
		_GlobalIlluminationAlbedoEffect("Global Illumination Albedo Effect", Range( 0 , 5)) = 1
		_GlobalIlluminationEmissiveEffect("Global Illumination Emissive Effect", Range( 0 , 5)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex3coord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "InternalMasked"  "Queue" = "Geometry+20" "DisableBatching" = "True" "IsEmissive" = "true"  }
		Cull [_CullMode]
		ZWrite [_ZWriteMode]
		ZTest [_ZTestMode]
		AlphaToMask [_AlphaToCoverage]
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityStandardUtils.cginc"
		#include "Lighting.cginc"
		#pragma target 4.5
		#pragma multi_compile_instancing
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		 
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
		uniform half _ALBEDOO;
		uniform half _EMISSIONN;
		uniform half _SURFACEE;
		uniform float _AlphaToCoverage;
		uniform float _ZTestMode;
		uniform float _MaskClipValue;
		uniform half _RENDERINGG;
		uniform float _ZWriteMode;
		uniform half _SPECULARITYY;
		uniform half _BANNER;
		uniform float _CullMode;
		uniform half _GLOBALILLUMINATIONN;
		uniform half _NORMALL;
		uniform float _GlobalIlluminationAlbedoEffect;
		uniform sampler2D _MetallicGlossMap;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float _OcclusionStrength;
		uniform half _Occlusion;
		uniform float4x4 _OcclusionProbesWorldToLocal;
		uniform sampler3D _OcclusionProbes;
		uniform float4 _OcclusionProbes_ST;
		uniform float _AOProbeStrength;
		uniform float _OCCLUSION_PROBE_GLOBAL;
		uniform float _AOIndirect;
		uniform float _AODirect;
		uniform float _Contrast;
		uniform float4 _Color;
		uniform float _Saturation;
		uniform float _Brightness;
		uniform float _ContrastCorrection;
		uniform float _GlobalIlluminationEmissiveEffect;
		uniform sampler2D _EmissionMap;
		uniform float4 _EmissionColor;
		uniform float _EmissionStrength;
		uniform float _BumpScale;
		uniform sampler2D _BumpMap;
		uniform float _IgnoreMetallicMap;
		uniform float _Metallic;
		uniform float _InvertSmoothness;
		uniform float _Glossiness;


		float SampleOcclusionProbes( float3 positionWS , float4x4 OcclusionProbesWorldToLocal , float OcclusionProbes )
		{
			float occlusionProbes = 1;
			float3 pos = mul(_OcclusionProbesWorldToLocal, float4(positionWS, 1)).xyz;
			occlusionProbes = tex3D(_OcclusionProbes, pos).a;
			return occlusionProbes;
		}


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
			SurfaceOutputStandard s1_g20553 = (SurfaceOutputStandard ) 0;
			float temp_output_36_0_g20384 = 1.0;
			float2 uv0_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 UV77 = uv0_MainTex;
			float4 tex2DNode34 = tex2D( _MetallicGlossMap, UV77 );
			float lerpResult74 = lerp( 1.0 , tex2DNode34.g , _OcclusionStrength);
			float _OCCLUSION48 = lerpResult74;
			float lerpResult38_g20384 = lerp( temp_output_36_0_g20384 , _OCCLUSION48 , _Occlusion);
			float3 ase_worldPos = i.worldPos;
			float3 positionWS3_g20387 = ase_worldPos;
			float4x4 OcclusionProbesWorldToLocal3_g20387 = _OcclusionProbesWorldToLocal;
			float3 uv_OcclusionProbes3 = i.uv_tex3coord;
			uv_OcclusionProbes3.xy = i.uv_tex3coord.xy * _OcclusionProbes_ST.xy + _OcclusionProbes_ST.zw;
			float OcclusionProbes3_g20387 = tex3D( _OcclusionProbes, uv_OcclusionProbes3 ).r;
			float localSampleOcclusionProbes3_g20387 = SampleOcclusionProbes( positionWS3_g20387 , OcclusionProbesWorldToLocal3_g20387 , OcclusionProbes3_g20387 );
			float lerpResult1_g20387 = lerp( 1.0 , localSampleOcclusionProbes3_g20387 , ( _AOProbeStrength * _OCCLUSION_PROBE_GLOBAL ));
			float temp_output_7_0_g20384 = ( saturate( ( lerpResult38_g20384 * temp_output_36_0_g20384 ) ) * lerpResult1_g20387 );
			float lerpResult18_g20384 = lerp( 1.0 , temp_output_7_0_g20384 , _AOIndirect);
			float lerpResult14_g20384 = lerp( 1.0 , temp_output_7_0_g20384 , _AODirect);
			float lerpResult1_g20384 = lerp( lerpResult18_g20384 , lerpResult14_g20384 , ase_lightAtten);
			float temp_output_16_0_g20384 = saturate( lerpResult1_g20384 );
			float temp_output_88_0_g20298 = _Contrast;
			float4 tex2DNode2 = tex2D( _MainTex, UV77 );
			float4 temp_output_89_0_g20298 = ( tex2DNode2 * _Color );
			float3 hsvTorgb92_g20298 = RGBToHSV( temp_output_89_0_g20298.rgb );
			float temp_output_118_0_g20298 = 1.0;
			float3 hsvTorgb83_g20298 = HSVToRGB( float3(hsvTorgb92_g20298.x,( hsvTorgb92_g20298.y * ( temp_output_118_0_g20298 + _Saturation ) ),( hsvTorgb92_g20298.z * ( temp_output_118_0_g20298 + _Brightness ) )) );
			float4 _ALBEDO23 = CalculateContrast(temp_output_88_0_g20298,( float4( hsvTorgb83_g20298 , 0.0 ) * ( 1.0 / (( _ContrastCorrection == 0.0 ) ? 1.0 :  _ContrastCorrection ) ) ));
			float3 albedo51_g20553 = ( temp_output_16_0_g20384 * _ALBEDO23.rgb );
			s1_g20553.Albedo = albedo51_g20553;
			float3 _NORMAL_TS25 = UnpackScaleNormal( tex2D( _BumpMap, UV77 ), _BumpScale );
			float3 temp_output_55_0_g20553 = _NORMAL_TS25;
			float3 normal_TS54_g20553 = temp_output_55_0_g20553;
			s1_g20553.Normal = WorldNormalVector( i , normal_TS54_g20553 );
			float4 _EMISSION20 = ( tex2D( _EmissionMap, UV77 ) * _EmissionColor * _EmissionStrength );
			float3 emissive71_g20553 = _EMISSION20.rgb;
			s1_g20553.Emission = emissive71_g20553;
			float lerpResult340 = lerp( tex2DNode34.r , 1.0 , _IgnoreMetallicMap);
			float _METALLIC33 = ( lerpResult340 * _Metallic );
			float metallic34_g20553 = _METALLIC33;
			s1_g20553.Metallic = metallic34_g20553;
			float _SMOOTHNESS58 = ( (( _InvertSmoothness )?( ( 1.0 - tex2DNode34.a ) ):( tex2DNode34.a )) * _Glossiness );
			float smoothness39_g20553 = _SMOOTHNESS58;
			s1_g20553.Smoothness = smoothness39_g20553;
			float occlusion188_g20553 = temp_output_16_0_g20384;
			s1_g20553.Occlusion = occlusion188_g20553;

			data.light = gi.light;

			UnityGI gi1_g20553 = gi;
			#ifdef UNITY_PASS_FORWARDBASE
			Unity_GlossyEnvironmentData g1_g20553 = UnityGlossyEnvironmentSetup( s1_g20553.Smoothness, data.worldViewDir, s1_g20553.Normal, float3(0,0,0));
			gi1_g20553 = UnityGlobalIllumination( data, s1_g20553.Occlusion, s1_g20553.Normal, g1_g20553 );
			#endif

			float3 surfResult1_g20553 = LightingStandard ( s1_g20553, viewDir, gi1_g20553 ).rgb;
			surfResult1_g20553 += s1_g20553.Emission;

			#ifdef UNITY_PASS_FORWARDADD//1_g20553
			surfResult1_g20553 -= s1_g20553.Emission;
			#endif//1_g20553
			float3 clampResult196_g20553 = clamp( surfResult1_g20553 , float3(0,0,0) , float3(50,50,50) );
			c.rgb = clampResult196_g20553;
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
			float temp_output_36_0_g20384 = 1.0;
			float2 uv0_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float2 UV77 = uv0_MainTex;
			float4 tex2DNode34 = tex2D( _MetallicGlossMap, UV77 );
			float lerpResult74 = lerp( 1.0 , tex2DNode34.g , _OcclusionStrength);
			float _OCCLUSION48 = lerpResult74;
			float lerpResult38_g20384 = lerp( temp_output_36_0_g20384 , _OCCLUSION48 , _Occlusion);
			float3 ase_worldPos = i.worldPos;
			float3 positionWS3_g20387 = ase_worldPos;
			float4x4 OcclusionProbesWorldToLocal3_g20387 = _OcclusionProbesWorldToLocal;
			float3 uv_OcclusionProbes3 = i.uv_tex3coord;
			uv_OcclusionProbes3.xy = i.uv_tex3coord.xy * _OcclusionProbes_ST.xy + _OcclusionProbes_ST.zw;
			float OcclusionProbes3_g20387 = tex3D( _OcclusionProbes, uv_OcclusionProbes3 ).r;
			float localSampleOcclusionProbes3_g20387 = SampleOcclusionProbes( positionWS3_g20387 , OcclusionProbesWorldToLocal3_g20387 , OcclusionProbes3_g20387 );
			float lerpResult1_g20387 = lerp( 1.0 , localSampleOcclusionProbes3_g20387 , ( _AOProbeStrength * _OCCLUSION_PROBE_GLOBAL ));
			float temp_output_7_0_g20384 = ( saturate( ( lerpResult38_g20384 * temp_output_36_0_g20384 ) ) * lerpResult1_g20387 );
			float lerpResult18_g20384 = lerp( 1.0 , temp_output_7_0_g20384 , _AOIndirect);
			float lerpResult14_g20384 = lerp( 1.0 , temp_output_7_0_g20384 , _AODirect);
			float lerpResult1_g20384 = lerp( lerpResult18_g20384 , lerpResult14_g20384 , 1);
			float temp_output_16_0_g20384 = saturate( lerpResult1_g20384 );
			float temp_output_88_0_g20298 = _Contrast;
			float4 tex2DNode2 = tex2D( _MainTex, UV77 );
			float4 temp_output_89_0_g20298 = ( tex2DNode2 * _Color );
			float3 hsvTorgb92_g20298 = RGBToHSV( temp_output_89_0_g20298.rgb );
			float temp_output_118_0_g20298 = 1.0;
			float3 hsvTorgb83_g20298 = HSVToRGB( float3(hsvTorgb92_g20298.x,( hsvTorgb92_g20298.y * ( temp_output_118_0_g20298 + _Saturation ) ),( hsvTorgb92_g20298.z * ( temp_output_118_0_g20298 + _Brightness ) )) );
			float4 _ALBEDO23 = CalculateContrast(temp_output_88_0_g20298,( float4( hsvTorgb83_g20298 , 0.0 ) * ( 1.0 / (( _ContrastCorrection == 0.0 ) ? 1.0 :  _ContrastCorrection ) ) ));
			float3 albedo51_g20553 = ( temp_output_16_0_g20384 * _ALBEDO23.rgb );
			o.Albedo = ( _GlobalIlluminationAlbedoEffect * albedo51_g20553 );
			float4 _EMISSION20 = ( tex2D( _EmissionMap, UV77 ) * _EmissionColor * _EmissionStrength );
			float3 emissive71_g20553 = _EMISSION20.rgb;
			o.Emission = ( _GlobalIlluminationEmissiveEffect * emissive71_g20553 );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows dithercrossfade 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			AlphaToMask Off
			CGPROGRAM
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
	CustomEditor "InternalShaderGUI"
}
/*ASEBEGIN
Version=17500
533.6;-864;1536;843;6432.631;2263.452;6.245329;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;76;-3328,-1024;Inherit;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;77;-3104,-1024;Inherit;False;UV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;81;-3706,321;Inherit;False;77;UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;21;-2744,-832;Inherit;False;Property;_Color;Color;9;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-2814,-1024;Inherit;True;Property;_MainTex;Albedo;8;0;Create;False;0;0;False;0;-1;None;c37675aa7c2afbb4fbf491de96addd18;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;34;-3456,304;Inherit;True;Property;_MetallicGlossMap;Surface Map;25;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;48cc708243ed3d040892659b8e8cae8c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;42;-2833.917,336;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;339;-2860.171,221.1573;Inherit;False;Property;_IgnoreMetallicMap;Ignore Metallic Map;26;1;[Toggle];Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;192;-2639.263,1298.474;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;162;-2309.282,1480.282;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;197;-2560,-1287.6;Inherit;False;Property;_ContrastCorrection;Contrast Correction;13;0;Create;True;0;0;False;0;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;79;-3072,-352;Inherit;False;77;UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-2560,1024;Inherit;False;Property;_OcclusionStrength;Occlusion;31;0;Create;False;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;59;-2820,849;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;195;-2556,-1536.6;Inherit;False;Property;_Saturation;Saturation;10;0;Create;True;0;0;False;0;0;0;-1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;75;-2369,852;Inherit;False;Constant;_Float0;Float 0;24;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;194;-2555,-1450.6;Inherit;False;Property;_Brightness;Brightness;11;0;Create;True;0;0;False;0;0;0;-1;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;196;-2560,-1367.6;Inherit;False;Property;_Contrast;Contrast;12;0;Create;True;0;0;False;0;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;341;-2609.171,153.1573;Inherit;False;Constant;_Float20;Float 20;64;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-2496,-960;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;340;-2397.171,222.1573;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;5;-2752,-192;Inherit;False;Property;_EmissionColor;Emission Color;19;0;Create;False;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;4;-2828,-404;Inherit;True;Property;_EmissionMap;Emission Map;18;1;[NoScaleOffset];Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;78;-3090,-671;Inherit;False;77;UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-2542.917,384;Inherit;False;Property;_Metallic;Metallic;27;0;Create;True;0;0;False;0;0;0.611;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-2817,-16;Inherit;False;Property;_EmissionStrength;Emission Strength;20;0;Create;True;0;0;False;0;1;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-3184,-592;Inherit;False;Property;_BumpScale;Normal Scale;16;0;Create;False;0;0;False;0;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;257;-2195.25,-1041.027;Inherit;False;Color Adjustment;-1;;20298;f9571dc7cf91d954d87b44c4dd2d35aa;6,90,0,81,1,91,1,85,1,116,0,111,1;6;89;COLOR;0,0,0,0;False;82;FLOAT;0;False;86;FLOAT;0;False;87;FLOAT;0;False;88;FLOAT;0;False;115;FLOAT;0;False;1;COLOR;37
Node;AmplifyShaderEditor.ToggleSwitchNode;161;-2105.775,1391.111;Inherit;False;Property;_InvertSmoothness;Invert Smoothness;29;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;74;-2176,896;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-2202.775,1606.111;Inherit;False;Property;_Glossiness;Smoothness;28;0;Create;False;0;0;False;0;0.1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;3;-2816,-640;Inherit;True;Property;_BumpMap;Normal;15;2;[NoScaleOffset];[Normal];Create;False;0;0;False;0;-1;None;860eb468a6bfcc74b8288d6457a5bfa6;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;48;-2017,897;Inherit;False;_OCCLUSION;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-2432,-384;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;23;-1911.4,-976.9;Inherit;False;_ALBEDO;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-2177.917,256;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-1813.775,1337.111;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;58;-1685.775,1337.111;Inherit;False;_SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;88;-262.7961,-475.2572;Inherit;False;48;_OCCLUSION;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;33;-2049.917,256;Inherit;False;_METALLIC;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;20;-2264.4,-391.8;Inherit;False;_EMISSION;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;26;-231.8999,-375.1;Inherit;False;23;_ALBEDO;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;25;-2432,-640;Inherit;False;_NORMAL_TS;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;87;-105.4961,94.24282;Inherit;False;58;_SMOOTHNESS;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;331;1435.495,754.1688;Inherit;False;494.9983;670.553;Rendering;5;272;333;334;335;336;;0,0.0238266,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;200;885.158,724.5157;Inherit;False;420.0045;734.6437;Drawers;2;202;212;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;27;-26.19607,-269.3572;Inherit;False;25;_NORMAL_TS;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;28;-121.0961,-100.9572;Inherit;False;20;_EMISSION;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;86;-118.496,10.24281;Inherit;False;33;_METALLIC;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;262;20.49999,-387;Inherit;False;Occlusion Probes;32;;20384;fc5cec86a89be184e93fc845da77a0cc;4,64,1,22,1,65,1,66,0;3;12;FLOAT;0;False;48;FLOAT;0;False;26;FLOAT3;1,1,1;False;2;FLOAT;0;FLOAT3;31
Node;AmplifyShaderEditor.RegisterLocalVarNode;125;-2016,559;Inherit;False;_SPECULAR;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;310;-2159.57,1243.46;Inherit;False;Property;_DisplacementStrength;Displacement;30;0;Create;False;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;300;1127.791,894.5376;Half;False;Property;_RENDERINGG;[ RENDERINGG  ];1;0;Create;True;0;0;True;1;InternalCategory(Rendering);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;143;-2412,-856;Inherit;False;albedo_alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;333;1738.482,1103.294;Inherit;False;Property;_ZWriteMode;ZWrite Mode;5;1;[Toggle];Create;True;0;0;True;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;211;1095.977,1179.209;Half;False;Property;_NORMALL;[ NORMALL ];14;0;Create;True;0;0;True;1;InternalCategory(Normal);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;202;917.158,788.5157;Half;False;Property;_BANNER;BANNER;0;0;Create;True;0;0;True;1;InternalBanner(Internal,Standard);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;272;1464.097,848.185;Inherit;False;Property;_CullMode;Cull Mode;2;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;0;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;188;418.8837,-365.2993;Inherit;False;Custom Lighting;42;;20553;b225dcbb02c65fb46af1dbc43764905b;1,67,0;7;56;FLOAT3;0,0,0;False;55;FLOAT3;0,0,0;False;70;FLOAT3;0,0,0;False;45;FLOAT;0;False;148;FLOAT3;0,0,0;False;41;FLOAT;0;False;189;FLOAT;0;False;3;FLOAT3;4;FLOAT3;5;FLOAT3;3
Node;AmplifyShaderEditor.GetLocalVarNode;315;-135.3961,-185.9572;Inherit;False;312;_DISPLACEMENT;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;313;-2514.275,1172.531;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;213;907.2191,881.9824;Half;False;Property;_SPECULARITYY;[ SPECULARITYY  ];21;0;Create;True;0;0;True;1;InternalCategory(Specularity);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;311;-1798.57,1108.46;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;334;1699.482,1004.294;Inherit;False;Property;_AlphaToCoverage;Alpha To Coverage;4;1;[Toggle];Create;True;0;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;314;-2063.151,1098.441;Inherit;False;Constant;_Float50;Float 50;24;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;336;1734.482,1190.294;Inherit;False;Property;_ZTestMode;ZTest Mode;6;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CompareFunction;True;0;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;128;-2816,432;Inherit;True;Property;_SpecGlossMap;Specularity Map;22;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;126;-3008,464;Inherit;False;77;UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;124;-2556,645;Inherit;False;Property;_Specularity;Specularity;23;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;152;-2423.621,519.1543;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;122;-2176,560;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;312;-1638.57,1111.46;Inherit;False;_DISPLACEMENT;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;206;916.158,1076.515;Half;False;Property;_SURFACEE;[ SURFACEE ];24;0;Create;True;0;0;True;1;InternalCategory(Surface);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;199;914.957,1363.731;Inherit;False;Internal Features Support;-1;;20552;3c493d142aeebd840af72d626f6915c6;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;212;1139.219,988.9824;Half;False;Property;_EMISSIONN;[ EMISSIONN ];17;0;Create;True;0;0;True;1;InternalCategory(Emission);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;207;918.158,980.5149;Half;False;Property;_ALBEDOO;[ ALBEDOO ];7;0;Create;True;0;0;True;1;InternalCategory(Albedo);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;335;1447.482,1126.294;Inherit;False;Property;_MaskClipValue;Mask Clip Value;3;0;Create;True;0;0;True;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;859.679,-385.0178;Float;False;True;-1;5;InternalShaderGUI;0;0;CustomLighting;internal/water-simple;False;False;False;False;False;False;False;False;False;False;False;False;True;True;False;False;True;False;True;True;False;Back;1;True;333;3;True;336;False;0;False;-1;0;False;-1;False;3;Custom;0.5;True;True;20;True;Custom;InternalMasked;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;False;False;_BILLBOARD_ON;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;272;-1;0;True;335;0;0;0;False;0.1;False;-1;0;True;334;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;14;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT3;0,0,0;False;0
WireConnection;77;0;76;0
WireConnection;2;1;77;0
WireConnection;34;1;81;0
WireConnection;42;0;34;1
WireConnection;192;0;34;4
WireConnection;162;0;34;4
WireConnection;59;0;34;2
WireConnection;22;0;2;0
WireConnection;22;1;21;0
WireConnection;340;0;42;0
WireConnection;340;1;341;0
WireConnection;340;2;339;0
WireConnection;4;1;79;0
WireConnection;257;89;22;0
WireConnection;257;86;195;0
WireConnection;257;87;194;0
WireConnection;257;88;196;0
WireConnection;257;115;197;0
WireConnection;161;0;192;0
WireConnection;161;1;162;0
WireConnection;74;0;75;0
WireConnection;74;1;59;0
WireConnection;74;2;47;0
WireConnection;3;1;78;0
WireConnection;3;5;24;0
WireConnection;48;0;74;0
WireConnection;6;0;4;0
WireConnection;6;1;5;0
WireConnection;6;2;32;0
WireConnection;23;0;257;37
WireConnection;12;0;340;0
WireConnection;12;1;31;0
WireConnection;56;0;161;0
WireConnection;56;1;57;0
WireConnection;58;0;56;0
WireConnection;33;0;12;0
WireConnection;20;0;6;0
WireConnection;25;0;3;0
WireConnection;262;12;88;0
WireConnection;262;26;26;0
WireConnection;125;0;122;0
WireConnection;143;0;2;4
WireConnection;188;56;262;31
WireConnection;188;55;27;0
WireConnection;188;70;28;0
WireConnection;188;45;86;0
WireConnection;188;41;87;0
WireConnection;188;189;262;0
WireConnection;313;0;34;3
WireConnection;311;0;314;0
WireConnection;311;1;313;0
WireConnection;311;2;310;0
WireConnection;128;1;126;0
WireConnection;152;0;128;0
WireConnection;122;0;152;0
WireConnection;122;1;124;0
WireConnection;312;0;311;0
WireConnection;0;0;188;4
WireConnection;0;2;188;5
WireConnection;0;14;188;3
ASEEND*/
//CHKSM=86E9827564FEE41A0071F70A9FECCE5C65FAFC43