// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "internal/generic"
{
	Properties
	{
		[InternalBanner(ADS Standard Lit, Generic)]_ADSStandardLitGeneric("< ADS Standard Lit Generic >", Float) = 1
		[InternalCategory(Rendering)]_RENDERINGG("[ RENDERINGG ]", Float) = 0
		[Enum(Opaque,0,Cutout,1,Fade,2,Transparent,3)]_RenderType("Render Type", Float) = 0
		[Enum(Two Sided,0,Back,1,Front,2)]_RenderFaces("Render Faces", Float) = 0
		[Enum(Mirrored Normals,0,Flipped Normals,1)]_NormalInvertOnBackface("Render Backface", Float) = 1
		[InternalInteractive(_RenderType, 1)]_RenderTypee("# _RenderTypee", Float) = 0
		_Cutoff("Cutout", Range( 0 , 1)) = 0.5
		[InternalCategory(Main)]_MAINN("[ MAINN ]", Float) = 0
		_Color("Main Color", Color) = (1,1,1,1)
		[NoScaleOffset]_MainTex("Main Albedo", 2D) = "white" {}
		_NormalScale("Main Normal Scale", Float) = 1
		[NoScaleOffset]BumpMap("Main Normal", 2D) = "bump" {}
		[NoScaleOffset]_MetallicGlossMap("Main Surface", 2D) = "white" {}
		_Metallic("Main Metallic", Range( 0 , 1)) = 0
		_Smoothness("Main Smoothness", Range( 0 , 1)) = 0.5
		[Space(10)]_UVZero("Main UVs", Vector) = (1,1,0,0)
		[InternalCategory(Settings)]_SETTINGSS("[ SETTINGSS ]", Float) = 0
		[HideInInspector]_MotionNoise("Motion Noise", Float) = 1
		_GlobalTurbulence("Global Turbulence", Range( 0 , 1)) = 1
		[InternalCategory(Motion)]_MOTIONN("[ MOTIONN ]", Float) = 0
		[KeywordEnum(World,Local)] _MotionSpace("Motion Space", Float) = 0
		[InternalInteractive(_MotionSpace, 1)]_MotionSpacee("# MotionSpacee", Float) = 0
		_MotionLocalDirection("Motion Local Direction", Vector) = (1,0,0,0)
		[InternalInteractive(ON)]_MotionSpacee_ON("# MotionSpacee_ON", Float) = 0
		_MotionAmplitude("Motion Amplitude", Float) = 0
		_MotionSpeed("Motion Speed", Float) = 0
		_MotionScale("Motion Scale", Float) = 0
		_MotionVariation("Motion Variation", Float) = 0
		[InternalCategory(Advanced)]_ADVANCEDD("[ ADVANCEDD ]", Float) = 0
		[InternalMessage(Info, Batching is not currently supported Please use GPU Instancing instead for better performance, 0, 0)]_BatchingInfo("!!! BatchingInfo", Float) = 0
		[HideInInspector]_LocalDirection("Internal_LocalDirection", Vector) = (0,0,0,0)
		[HideInInspector]_SrcBlend("_SrcBlend", Float) = 1
		[HideInInspector]_DstBlend("_DstBlend", Float) = 10
		[HideInInspector]_ZWrite("_ZWrite", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" "DisableBatching" = "True" }
		LOD 300
		Cull [_RenderFaces]
		ZWrite [_ZWrite]
		Blend [_SrcBlend] [_DstBlend]
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _MOTIONSPACE_WORLD _MOTIONSPACE_LOCAL
		#pragma shader_feature_local _RENDERTYPEKEY_OPAQUE _RENDERTYPEKEY_CUT _RENDERTYPEKEY_FADE _RENDERTYPEKEY_TRANSPARENT
		#pragma exclude_renderers gles vulkan 
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			half ASEVFace : VFACE;
			float4 screenPosition;
		};

		uniform float _MotionNoise;
		uniform half _BatchingInfo;
		uniform half _MotionSpacee_ON;
		uniform half _SrcBlend;
		uniform half _RENDERINGG;
		uniform half _ADVANCEDD;
		uniform half _MotionSpacee;
		uniform half3 _LocalDirection;
		uniform half _RenderFaces;
		uniform half _ADSStandardLitGeneric;
		uniform half _MOTIONN;
		uniform half _DstBlend;
		uniform half _MAINN;
		uniform half _ZWrite;
		uniform half _Cutoff;
		uniform half _SETTINGSS;
		uniform half _RenderTypee;
		uniform half _RenderType;
		uniform half ADS_GlobalScale;
		uniform float _MotionScale;
		uniform half ADS_GlobalSpeed;
		uniform float _MotionSpeed;
		uniform float _MotionVariation;
		uniform half ADS_GlobalAmplitude;
		uniform float _MotionAmplitude;
		uniform sampler2D ADS_TurbulenceTex;
		uniform half ADS_TurbulenceSpeed;
		uniform half ADS_TurbulenceScale;
		uniform half ADS_TurbulenceContrast;
		uniform float _GlobalTurbulence;
		uniform half3 ADS_GlobalDirection;
		uniform half3 _MotionLocalDirection;
		uniform half _NormalScale;
		uniform sampler2D BumpMap;
		uniform half4 _UVZero;
		uniform half _NormalInvertOnBackface;
		uniform sampler2D _MainTex;
		uniform half4 _Color;
		uniform sampler2D _MetallicGlossMap;
		uniform half _Metallic;
		uniform half _Smoothness;


		inline float Dither4x4Bayer( int x, int y )
		{
			const float dither[ 16 ] = {
				 1,  9,  3, 11,
				13,  5, 15,  7,
				 4, 12,  2, 10,
				16,  8, 14,  6 };
			int r = y * 4 + x;
			return dither[r] / 16; // same # of instructions as pre-dividing due to compiler magic
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 ase_vertex3Pos = v.vertex.xyz;
			#if defined(_MOTIONSPACE_WORLD)
				float3 staticSwitch345_g1889 = ase_worldPos;
			#elif defined(_MOTIONSPACE_LOCAL)
				float3 staticSwitch345_g1889 = ase_vertex3Pos;
			#else
				float3 staticSwitch345_g1889 = ase_worldPos;
			#endif
			half MotionScale60_g1889 = ( ADS_GlobalScale * _MotionScale );
			half MotionSpeed62_g1889 = ( ADS_GlobalSpeed * _MotionSpeed );
			float mulTime90_g1889 = _Time.y * MotionSpeed62_g1889;
			float3 temp_output_95_0_g1889 = ( ( staticSwitch345_g1889 * MotionScale60_g1889 ) + mulTime90_g1889 );
			half Packed_Variation1138 = v.color.a;
			half MotionVariation269_g1889 = ( _MotionVariation * Packed_Variation1138 );
			half MotionlAmplitude58_g1889 = ( ADS_GlobalAmplitude * _MotionAmplitude );
			float3 temp_output_92_0_g1889 = ( sin( ( temp_output_95_0_g1889 + MotionVariation269_g1889 ) ) * MotionlAmplitude58_g1889 );
			float3 temp_output_160_0_g1889 = ( temp_output_92_0_g1889 + MotionlAmplitude58_g1889 + MotionlAmplitude58_g1889 );
			float2 temp_cast_0 = (ADS_TurbulenceSpeed).xx;
			half localunity_ObjectToWorld0w1_g1874 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g1874 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g1874 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g1874 = (float3(localunity_ObjectToWorld0w1_g1874 , localunity_ObjectToWorld1w2_g1874 , localunity_ObjectToWorld2w3_g1874));
			float2 panner73_g1872 = ( _Time.y * temp_cast_0 + ( (appendResult6_g1874).xz * ADS_TurbulenceScale ));
			float lerpResult136_g1872 = lerp( 1.0 , saturate( pow( abs( tex2Dlod( ADS_TurbulenceTex, float4( panner73_g1872, 0, 0.0) ).r ) , ADS_TurbulenceContrast ) ) , _GlobalTurbulence);
			half Motion_Turbulence1162 = lerpResult136_g1872;
			float3 lerpResult293_g1889 = lerp( temp_output_92_0_g1889 , temp_output_160_0_g1889 , Motion_Turbulence1162);
			half3 GlobalDirection349_g1889 = ADS_GlobalDirection;
			#if defined(_MOTIONSPACE_WORLD)
				float3 staticSwitch343_g1889 = mul( unity_WorldToObject, float4( GlobalDirection349_g1889 , 0.0 ) ).xyz;
			#elif defined(_MOTIONSPACE_LOCAL)
				float3 staticSwitch343_g1889 = _MotionLocalDirection;
			#else
				float3 staticSwitch343_g1889 = mul( unity_WorldToObject, float4( GlobalDirection349_g1889 , 0.0 ) ).xyz;
			#endif
			half3 MotionDirection59_g1889 = staticSwitch343_g1889;
			half Packed_Mask1141 = v.color.r;
			half MotionMask137_g1889 = Packed_Mask1141;
			float3 temp_output_94_0_g1889 = ( ( lerpResult293_g1889 * MotionDirection59_g1889 ) * MotionMask137_g1889 );
			half3 Motion_Generic1148 = temp_output_94_0_g1889;
			half3 Motion_Output1152 = ( Motion_Generic1148 * Motion_Turbulence1162 );
			v.vertex.xyz += Motion_Output1152;
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			o.screenPosition = ase_screenPos;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 appendResult564 = (float2(_UVZero.x , _UVZero.y));
			float2 appendResult565 = (float2(_UVZero.z , _UVZero.w));
			half2 Main_UVs587 = ( ( i.uv_texcoord * appendResult564 ) + appendResult565 );
			float3 temp_output_13_0_g1896 = UnpackScaleNormal( tex2D( BumpMap, Main_UVs587 ), _NormalScale );
			float3 break17_g1896 = temp_output_13_0_g1896;
			float switchResult12_g1896 = (((i.ASEVFace>0)?(break17_g1896.z):(-break17_g1896.z)));
			float3 appendResult18_g1896 = (float3(break17_g1896.x , break17_g1896.y , switchResult12_g1896));
			float3 lerpResult20_g1896 = lerp( temp_output_13_0_g1896 , appendResult18_g1896 , _NormalInvertOnBackface);
			half3 MainBumpMap620 = lerpResult20_g1896;
			o.Normal = MainBumpMap620;
			float4 tex2DNode18 = tex2D( _MainTex, Main_UVs587 );
			half4 Main_MainTex487 = tex2DNode18;
			half4 Main_Color486 = _Color;
			float4 temp_output_1075_0 = ( Main_MainTex487 * Main_Color486 );
			half Main_Color_A1057 = _Color.a;
			half Main_MainTex_A616 = tex2DNode18.a;
			#if defined(_RENDERTYPEKEY_OPAQUE)
				float4 staticSwitch1114 = temp_output_1075_0;
			#elif defined(_RENDERTYPEKEY_CUT)
				float4 staticSwitch1114 = temp_output_1075_0;
			#elif defined(_RENDERTYPEKEY_FADE)
				float4 staticSwitch1114 = temp_output_1075_0;
			#elif defined(_RENDERTYPEKEY_TRANSPARENT)
				float4 staticSwitch1114 = ( Main_MainTex487 * Main_Color486 * Main_Color_A1057 * Main_MainTex_A616 );
			#else
				float4 staticSwitch1114 = temp_output_1075_0;
			#endif
			o.Albedo = staticSwitch1114.rgb;
			float4 tex2DNode645 = tex2D( _MetallicGlossMap, Main_UVs587 );
			half MAin_MetallicGlossMap_R646 = tex2DNode645.r;
			half OUT_METALLIC748 = ( MAin_MetallicGlossMap_R646 * _Metallic );
			o.Metallic = OUT_METALLIC748;
			half Main_MetallicGlossMap_A744 = tex2DNode645.a;
			half OUT_SMOOTHNESS660 = ( Main_MetallicGlossMap_A744 * _Smoothness );
			o.Smoothness = OUT_SMOOTHNESS660;
			float temp_output_1133_0 = 1.0;
			float temp_output_1058_0 = ( Main_Color_A1057 * Main_MainTex_A616 );
			#if defined(_RENDERTYPEKEY_OPAQUE)
				float staticSwitch1112 = temp_output_1133_0;
			#elif defined(_RENDERTYPEKEY_CUT)
				float staticSwitch1112 = temp_output_1133_0;
			#elif defined(_RENDERTYPEKEY_FADE)
				float staticSwitch1112 = temp_output_1058_0;
			#elif defined(_RENDERTYPEKEY_TRANSPARENT)
				float staticSwitch1112 = temp_output_1058_0;
			#else
				float staticSwitch1112 = temp_output_1133_0;
			#endif
			float temp_output_41_0_g1912 = staticSwitch1112;
			float4 ase_screenPos = i.screenPosition;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 clipScreen39_g1912 = ase_screenPosNorm.xy * _ScreenParams.xy;
			float dither39_g1912 = Dither4x4Bayer( fmod(clipScreen39_g1912.x, 4), fmod(clipScreen39_g1912.y, 4) );
			float temp_output_47_0_g1912 = max( unity_LODFade.x , step( unity_LODFade.x , 0.0 ) );
			dither39_g1912 = step( dither39_g1912, temp_output_47_0_g1912 );
			#ifdef LOD_FADE_CROSSFADE
				float staticSwitch40_g1912 = ( temp_output_41_0_g1912 * dither39_g1912 );
			#else
				float staticSwitch40_g1912 = temp_output_41_0_g1912;
			#endif
			#ifdef ADS_LODFADE_DITHER
				float staticSwitch50_g1912 = staticSwitch40_g1912;
			#else
				float staticSwitch50_g1912 = temp_output_41_0_g1912;
			#endif
			o.Alpha = staticSwitch50_g1912;
			#if defined(_RENDERTYPEKEY_OPAQUE)
				float staticSwitch1113 = temp_output_1133_0;
			#elif defined(_RENDERTYPEKEY_CUT)
				float staticSwitch1113 = Main_MainTex_A616;
			#elif defined(_RENDERTYPEKEY_FADE)
				float staticSwitch1113 = temp_output_1133_0;
			#elif defined(_RENDERTYPEKEY_TRANSPARENT)
				float staticSwitch1113 = temp_output_1133_0;
			#else
				float staticSwitch1113 = temp_output_1133_0;
			#endif
			float temp_output_41_0_g1911 = staticSwitch1113;
			float2 clipScreen39_g1911 = ase_screenPosNorm.xy * _ScreenParams.xy;
			float dither39_g1911 = Dither4x4Bayer( fmod(clipScreen39_g1911.x, 4), fmod(clipScreen39_g1911.y, 4) );
			float temp_output_47_0_g1911 = max( unity_LODFade.x , step( unity_LODFade.x , 0.0 ) );
			dither39_g1911 = step( dither39_g1911, temp_output_47_0_g1911 );
			#ifdef LOD_FADE_CROSSFADE
				float staticSwitch40_g1911 = ( temp_output_41_0_g1911 * dither39_g1911 );
			#else
				float staticSwitch40_g1911 = temp_output_41_0_g1911;
			#endif
			#ifdef ADS_LODFADE_DITHER
				float staticSwitch50_g1911 = staticSwitch40_g1911;
			#else
				float staticSwitch50_g1911 = temp_output_41_0_g1911;
			#endif
			clip( staticSwitch50_g1911 - _Cutoff );
		}

		ENDCG
	}
	Fallback "internal/fallback"
	CustomEditor "InternalShaderGUI"
}
/*ASEBEGIN
Version=17500
0;-864;1536;843;1887.018;4001.95;1.3;True;False
Node;AmplifyShaderEditor.Vector4Node;563;-1280,-672;Half;False;Property;_UVZero;Main UVs;15;0;Create;False;0;0;False;1;Space(10);1,1,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;564;-1024,-672;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;561;-1280,-896;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;565;-1024,-592;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;562;-832,-896;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.VertexColorNode;1154;-1280,-128;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1161;-1280,192;Inherit;False;ADS Global Turbulence;17;;1872;047eb809542f42d40b4b5066e22cee72;0;0;1;FLOAT;85
Node;AmplifyShaderEditor.SimpleAddOpNode;575;-624,-896;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1138;-1024,-48;Half;False;Packed_Variation;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1162;-1024,192;Half;False;Motion_Turbulence;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1140;-512,192;Inherit;False;1138;Packed_Variation;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1141;-1024,-128;Half;False;Packed_Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;587;-448,-896;Half;False;Main_UVs;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1139;-512,112;Float;False;Property;_MotionVariation;Motion Variation;31;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;644;2688,-896;Inherit;False;587;Main_UVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1142;-512,32;Float;False;Property;_MotionScale;Motion Scale;30;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;1170;-512,512;Half;False;Property;_MotionLocalDirection;Motion Local Direction;26;0;Create;False;0;0;False;0;1,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;1144;-512,-128;Float;False;Property;_MotionAmplitude;Motion Amplitude;28;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1163;-512,288;Inherit;False;1162;Motion_Turbulence;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1143;-256,112;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1145;-512,-48;Float;False;Property;_MotionSpeed;Motion Speed;29;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1146;-512,384;Inherit;False;1141;Packed_Mask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;588;-128,-896;Inherit;False;587;Main_UVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;645;2944,-896;Inherit;True;Property;_MetallicGlossMap;Main Surface;12;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;409;768,-896;Half;False;Property;_Color;Main Color;8;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1171;128,-128;Inherit;False;ADS Motion Generic;22;;1889;81cab27e2a487a645a4ff5eb3c63bd27;6,252,2,278,1,228,1,292,2,330,2,326,2;8;220;FLOAT;0;False;221;FLOAT;0;False;222;FLOAT;0;False;218;FLOAT;0;False;287;FLOAT;0;False;136;FLOAT;0;False;279;FLOAT;0;False;342;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;18;80,-896;Inherit;True;Property;_MainTex;Main Albedo;9;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;646;3344,-896;Half;False;MAin_MetallicGlossMap_R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;604;1536,-896;Inherit;False;587;Main_UVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;655;1536,-768;Half;False;Property;_NormalScale;Main Normal Scale;10;0;Create;False;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;616;384,-768;Half;False;Main_MainTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1057;1024,-800;Half;False;Main_Color_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;744;3344,-768;Half;False;Main_MetallicGlossMap_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1148;384,-128;Half;False;Motion_Generic;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;294;3712,-624;Half;False;Property;_Smoothness;Main Smoothness;14;0;Create;False;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;607;1808,-896;Inherit;True;Property;BumpMap;Main Normal;11;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1165;1856,-704;Half;False;Property;_NormalInvertOnBackface;Render Backface;4;1;[Enum];Create;False;2;Mirrored Normals;0;Flipped Normals;1;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1164;768,-32;Inherit;False;1162;Motion_Turbulence;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;750;3712,-816;Half;False;Property;_Metallic;Main Metallic;13;0;Create;False;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;749;3712,-704;Inherit;False;744;Main_MetallicGlossMap_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;656;3712,-896;Inherit;False;646;MAin_MetallicGlossMap_R;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1150;768,-128;Inherit;False;1148;Motion_Generic;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;384,-896;Half;False;Main_MainTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1059;-1280,-1664;Inherit;False;1057;Main_Color_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;1024,-896;Half;False;Main_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;791;-1280,-1568;Inherit;False;616;Main_MainTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1076;-1280,-2368;Inherit;False;486;Main_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;657;4032,-896;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1134;2128,-896;Inherit;False;ADS Normal Backface;-1;;1896;4f53bc25e6d8da34db70401bcf363a2a;0;2;13;FLOAT3;0,0,0;False;30;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1058;-1024,-1664;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1116;-1280,-2192;Inherit;False;616;Main_MainTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;745;4032,-720;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1115;-1280,-2272;Inherit;False;1057;Main_Color_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1151;1024,-128;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;36;-1280,-2432;Inherit;False;487;Main_MainTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1133;-896,-1792;Inherit;False;const;-1;;1895;5b64729fb717c5f49a1bc2dab81d5e1c;1,3,1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;748;4224,-896;Half;False;OUT_METALLIC;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1152;1216,-128;Half;False;Motion_Output;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1117;-1024,-2304;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;1112;-640,-1792;Float;False;Property;_RENDERTYPEKEY;RenderTypeKey;5;0;Create;False;0;0;False;0;0;0;0;False;_ALPHABLEND_ON;KeywordEnum;4;_OPAQUE;_CUT;_FADE;_TRANSPARENT;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;660;4224,-720;Half;False;OUT_SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;620;2368,-896;Half;False;MainBumpMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1075;-1024,-2432;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;1113;-640,-1632;Float;False;Property;_RENDERTYPEKEY;RenderTypeKey;5;0;Create;False;0;0;False;0;0;0;0;False;_ALPHABLEND_ON;KeywordEnum;4;_OPAQUE;_CUT;_FADE;_TRANSPARENT;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;549;-816,-2944;Half;False;Property;_RenderType;Render Type;2;1;[Enum];Create;True;4;Opaque;0;Cutout;1;Fade;2;Transparent;3;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1103;-1280,-3520;Half;False;Property;_RenderTypee;# _RenderTypee;5;0;Create;True;0;0;True;1;InternalInteractive(_RenderType, 1);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1105;-928,-3616;Half;False;Property;_SETTINGSS;[ SETTINGSS ];16;0;Create;True;0;0;True;1;InternalCategory(Settings);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;862;-448,-2944;Half;False;Property;_Cutoff;Cutout;6;0;Create;False;3;Off;0;Front;1;Back;2;0;True;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;925;-960,-2944;Half;False;Property;_ZWrite;_ZWrite;37;1;[HideInInspector];Create;True;2;Off;0;On;1;0;True;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;752;-1280,-1936;Inherit;False;748;OUT_METALLIC;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;553;-1120,-2944;Half;False;Property;_DstBlend;_DstBlend;36;1;[HideInInspector];Create;True;0;0;True;0;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1167;-384,-1792;Inherit;False;ADS LODFade Dither;-1;;1912;f1eaf6a5452c7c7458970a3fc3fa22c1;1,44,0;1;41;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1125;-384,-1472;Inherit;False;1152;Motion_Output;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;1169;-512,655;Float;False;Property;_MotionSpace;Motion Space;24;0;Create;False;0;0;True;0;0;0;0;True;;KeywordEnum;2;World;Local;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1104;-1088,-3616;Half;False;Property;_MAINN;[ MAINN ];7;0;Create;True;0;0;True;1;InternalCategory(Main);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;654;-1280,-1856;Inherit;False;660;OUT_SMOOTHNESS;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1101;-1280,-3616;Half;False;Property;_RENDERINGG;[ RENDERINGG ];1;0;Create;True;0;0;True;1;InternalCategory(Rendering);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1102;-1280,-3712;Half;False;Property;_ADSStandardLitGeneric;< ADS Standard Lit Generic >;0;0;Create;True;0;0;True;1;InternalBanner(ADS Standard Lit, Generic);1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1106;-752,-3616;Half;False;Property;_MOTIONN;[ MOTIONN ];21;0;Create;True;0;0;True;1;InternalCategory(Motion);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1114;-640,-2432;Float;False;Property;_RENDERTYPEKEY;RenderTypeKey;5;0;Create;False;0;0;False;0;0;0;0;False;_ALPHABLEND_ON;KeywordEnum;4;_OPAQUE;_CUT;_FADE;_TRANSPARENT;Create;False;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1168;-384,-1632;Inherit;False;ADS LODFade Dither;-1;;1911;f1eaf6a5452c7c7458970a3fc3fa22c1;1,44,0;1;41;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;624;-1280,-2016;Inherit;False;620;MainBumpMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1173;-880,-3520;Half;False;Property;_MotionSpacee_ON;# MotionSpacee_ON;27;0;Create;True;0;0;True;1;InternalInteractive(ON);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1160;-640,-3520;Half;False;Property;_BatchingInfo;!!! BatchingInfo;33;0;Create;True;0;0;True;1;InternalMessage(Info, Batching is not currently supported Please use GPU Instancing instead for better performance, 0, 0);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;743;-640,-2944;Half;False;Property;_RenderFaces;Render Faces;3;1;[Enum];Create;True;3;Two Sided;0;Back;1;Front;2;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1107;-576,-3616;Half;False;Property;_ADVANCEDD;[ ADVANCEDD ];32;0;Create;True;0;0;True;1;InternalCategory(Advanced);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1172;-1072,-3520;Half;False;Property;_MotionSpacee;# MotionSpacee;25;0;Create;True;0;0;True;1;InternalInteractive(_MotionSpace, 1);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;1175;-1280,288;Half;False;Property;_LocalDirection;Internal_LocalDirection;34;1;[HideInInspector];Create;False;0;0;True;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;550;-1280,-2944;Half;False;Property;_SrcBlend;_SrcBlend;35;1;[HideInInspector];Create;True;0;0;True;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,-2176;Float;False;True;-1;2;InternalShaderGUI;300;0;Standard;internal/generic;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;False;False;False;False;False;True;Off;0;True;925;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0;True;True;0;True;Opaque;;Geometry;All;12;d3d9;d3d11_9x;d3d11;glcore;gles3;metal;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;1;5;True;550;10;True;553;0;1;False;550;10;False;553;0;True;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;300;internal/fallback;-1;-1;-1;-1;0;False;0;0;True;743;-1;0;True;862;0;0;0;False;0.1;False;-1;0;False;-1;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;14;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;760;-128,-1024;Inherit;False;1361.88;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;751;3712,-1024;Inherit;False;713.7266;100;Metallic / Smoothness;0;;1,0.7450981,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1100;-1280,-3840;Inherit;False;897.0701;100;Drawers;0;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;712;-1280,-1024;Inherit;False;1039.27;100;Main UVs;0;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;715;2688,-1024;Inherit;False;890.0676;100;Smoothness Texture;0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1153;-1280,-256;Inherit;False;2698.834;100;Motion;0;;0.03448272,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;683;-1280,-3072;Inherit;False;1084;100;Rendering;0;;1,0,0.503,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;708;1536,-1024;Inherit;False;1038.73;100;Normal Texture;0;;0.5019608,0.5019608,1,1;0;0
WireConnection;564;0;563;1
WireConnection;564;1;563;2
WireConnection;565;0;563;3
WireConnection;565;1;563;4
WireConnection;562;0;561;0
WireConnection;562;1;564;0
WireConnection;575;0;562;0
WireConnection;575;1;565;0
WireConnection;1138;0;1154;4
WireConnection;1162;0;1161;85
WireConnection;1141;0;1154;1
WireConnection;587;0;575;0
WireConnection;1143;0;1139;0
WireConnection;1143;1;1140;0
WireConnection;645;1;644;0
WireConnection;1171;220;1144;0
WireConnection;1171;221;1145;0
WireConnection;1171;222;1142;0
WireConnection;1171;218;1143;0
WireConnection;1171;287;1163;0
WireConnection;1171;136;1146;0
WireConnection;1171;342;1170;0
WireConnection;18;1;588;0
WireConnection;646;0;645;1
WireConnection;616;0;18;4
WireConnection;1057;0;409;4
WireConnection;744;0;645;4
WireConnection;1148;0;1171;0
WireConnection;607;1;604;0
WireConnection;607;5;655;0
WireConnection;487;0;18;0
WireConnection;486;0;409;0
WireConnection;657;0;656;0
WireConnection;657;1;750;0
WireConnection;1134;13;607;0
WireConnection;1134;30;1165;0
WireConnection;1058;0;1059;0
WireConnection;1058;1;791;0
WireConnection;745;0;749;0
WireConnection;745;1;294;0
WireConnection;1151;0;1150;0
WireConnection;1151;1;1164;0
WireConnection;748;0;657;0
WireConnection;1152;0;1151;0
WireConnection;1117;0;36;0
WireConnection;1117;1;1076;0
WireConnection;1117;2;1115;0
WireConnection;1117;3;1116;0
WireConnection;1112;1;1133;0
WireConnection;1112;0;1133;0
WireConnection;1112;2;1058;0
WireConnection;1112;3;1058;0
WireConnection;660;0;745;0
WireConnection;620;0;1134;0
WireConnection;1075;0;36;0
WireConnection;1075;1;1076;0
WireConnection;1113;1;1133;0
WireConnection;1113;0;791;0
WireConnection;1113;2;1133;0
WireConnection;1113;3;1133;0
WireConnection;1167;41;1112;0
WireConnection;1114;1;1075;0
WireConnection;1114;0;1075;0
WireConnection;1114;2;1075;0
WireConnection;1114;3;1117;0
WireConnection;1168;41;1113;0
WireConnection;0;0;1114;0
WireConnection;0;1;624;0
WireConnection;0;3;752;0
WireConnection;0;4;654;0
WireConnection;0;9;1167;0
WireConnection;0;10;1168;0
WireConnection;0;11;1125;0
ASEEND*/
//CHKSM=E80ACD3702C912767F0433AF25B9DEE782D32066
