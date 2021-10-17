// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "appalachia/fallback-opaque"
{
	Properties
	{
		[InternalBanner(ADS Fallback)]_ADSFallback("< ADS Fallback >", Float) = 1
		[InternalCategory(Rendering)]_RENDERINGG("[ RENDERINGG ]", Float) = 0
		[Enum(Opaque,0,Cutout,1,Fade,2,Transparent,3)]_RenderType("Render Type", Float) = 0
		[Enum(Off,0,Front,1,Back,2)]_CullType("Cull Type", Float) = 0
		[InternalInteractive(_RenderType, 1)]_RenderTypee("# _RenderTypee", Float) = 0
		_Cutoff("Cutout", Range( 0 , 1)) = 0.5
		[InternalCategory(Main)]_MAINN("[ MAINN ]", Float) = 0
		_Color("Main Color", Color) = (1,1,1,1)
		[NoScaleOffset]_MainTex("Main Albedo", 2D) = "white" {}
		[Space(10)]_UVZero("Main UVs", Vector) = (1,1,0,0)
		[InternalCategory(Advanced)]_ADVANCEDD("[ ADVANCEDD ]", Float) = 0
		[HideInInspector]_SrcBlend("_SrcBlend", Float) = 1
		[HideInInspector]_DstBlend("_DstBlend", Float) = 10
		[HideInInspector]_ZWrite("_ZWrite", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		LOD 200
		Cull [_CullType]
		ZWrite [_ZWrite]
		Blend [_SrcBlend] [_DstBlend]
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _RENDERTYPEKEY_OPAQUE _RENDERTYPEKEY_CUT _RENDERTYPEKEY_FADE _RENDERTYPEKEY_TRANSPARENT
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform half _RenderTypee;
		uniform half _ADSFallback;
		uniform half _ADVANCEDD;
		uniform half _RENDERINGG;
		uniform half _MAINN;
		uniform half _SrcBlend;
		uniform half _CullType;
		uniform half _DstBlend;
		uniform half _RenderType;
		uniform half _ZWrite;
		uniform half _Cutoff;
		uniform sampler2D _MainTex;
		uniform half4 _UVZero;
		uniform half4 _Color;

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult564 = (float2(_UVZero.x , _UVZero.y));
			float2 appendResult565 = (float2(_UVZero.z , _UVZero.w));
			half2 Main_UVs587 = ( ( i.uv_texcoord * appendResult564 ) + appendResult565 );
			float4 tex2DNode18 = tex2D( _MainTex, Main_UVs587 );
			half4 Main_MainTex487 = tex2DNode18;
			half4 Main_Color486 = _Color;
			float4 temp_output_1118_0 = ( Main_MainTex487 * Main_Color486 );
			half Main_Color_A1057 = _Color.a;
			half Main_MainTex_A616 = tex2DNode18.a;
			#if defined(_RENDERTYPEKEY_OPAQUE)
				float4 staticSwitch1114 = temp_output_1118_0;
			#elif defined(_RENDERTYPEKEY_CUT)
				float4 staticSwitch1114 = temp_output_1118_0;
			#elif defined(_RENDERTYPEKEY_FADE)
				float4 staticSwitch1114 = temp_output_1118_0;
			#elif defined(_RENDERTYPEKEY_TRANSPARENT)
				float4 staticSwitch1114 = ( Main_MainTex487 * Main_Color486 * Main_Color_A1057 * Main_MainTex_A616 );
			#else
				float4 staticSwitch1114 = temp_output_1118_0;
			#endif
			o.Albedo = staticSwitch1114.rgb;
			float temp_output_1134_0 = 1.0;
			float temp_output_1058_0 = ( Main_Color_A1057 * Main_MainTex_A616 );
			#if defined(_RENDERTYPEKEY_OPAQUE)
				float staticSwitch1111 = temp_output_1134_0;
			#elif defined(_RENDERTYPEKEY_CUT)
				float staticSwitch1111 = temp_output_1134_0;
			#elif defined(_RENDERTYPEKEY_FADE)
				float staticSwitch1111 = temp_output_1058_0;
			#elif defined(_RENDERTYPEKEY_TRANSPARENT)
				float staticSwitch1111 = temp_output_1058_0;
			#else
				float staticSwitch1111 = temp_output_1134_0;
			#endif
			o.Alpha = staticSwitch1111;
			#if defined(_RENDERTYPEKEY_OPAQUE)
				float staticSwitch1112 = temp_output_1134_0;
			#elif defined(_RENDERTYPEKEY_CUT)
				float staticSwitch1112 = Main_MainTex_A616;
			#elif defined(_RENDERTYPEKEY_FADE)
				float staticSwitch1112 = temp_output_1134_0;
			#elif defined(_RENDERTYPEKEY_TRANSPARENT)
				float staticSwitch1112 = temp_output_1134_0;
			#else
				float staticSwitch1112 = temp_output_1134_0;
			#endif
			clip( staticSwitch1112 - _Cutoff );
		}

		ENDCG
		CGPROGRAM
		#pragma exclude_renderers gles vulkan 
		#pragma surface surf Lambert keepalpha fullforwardshadows novertexlights nolightmap  nodynlightmap nodirlightmap nometa noforwardadd 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
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
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
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
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
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
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Unlit/Color"
	CustomEditor "AppalachiaShaderEditorGUI"
}
/*ASEBEGIN
Version=17500
0;-864;1536;843;2204.109;4431.426;1.404299;True;False
Node;AmplifyShaderEditor.Vector4Node;563;-1280,-1568;Half;False;Property;_UVZero;Main UVs;9;0;Create;False;0;0;False;1;Space(10);1,1,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;564;-1024,-1568;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;561;-1280,-1792;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;565;-1024,-1488;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;562;-832,-1792;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;575;-624,-1792;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;587;-448,-1792;Half;False;Main_UVs;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;588;-128,-1792;Inherit;False;587;Main_UVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;409;768,-1792;Half;False;Property;_Color;Main Color;7;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;18;80,-1792;Inherit;True;Property;_MainTex;Main Albedo;8;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;616;384,-1664;Half;False;Main_MainTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1057;1024,-1696;Half;False;Main_Color_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;384,-1792;Half;False;Main_MainTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;1024,-1792;Half;False;Main_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1117;-1280,-2720;Inherit;False;616;Main_MainTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1116;-1280,-2784;Inherit;False;1057;Main_Color_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1077;-1280,-2944;Inherit;False;487;Main_MainTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1059;-1280,-2560;Inherit;False;1057;Main_Color_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1089;-1280,-2880;Inherit;False;486;Main_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;791;-1280,-2464;Inherit;False;616;Main_MainTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1115;-960,-2848;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1058;-1024,-2560;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1118;-960,-2944;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1134;-960,-2688;Inherit;False;const;-1;;1483;5b64729fb717c5f49a1bc2dab81d5e1c;4,21,0,3,1,22,0,28,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;862;-448,-3456;Half;False;Property;_Cutoff;Cutout;5;0;Create;False;3;Off;0;Front;1;Back;2;0;True;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;925;-960,-3456;Half;False;Property;_ZWrite;_ZWrite;13;1;[HideInInspector];Create;True;2;Off;0;On;1;0;True;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;549;-816,-3456;Half;False;Property;_RenderType;Render Type;2;1;[Enum];Create;True;4;Opaque;0;Cutout;1;Fade;2;Transparent;3;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;553;-1120,-3456;Half;False;Property;_DstBlend;_DstBlend;12;1;[HideInInspector];Create;True;0;0;True;0;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1111;-768,-2688;Float;False;Property;_RENDERTYPEKEY;RenderTypeKey;5;0;Create;False;0;0;False;0;0;0;0;False;_ALPHABLEND_ON;KeywordEnum;4;_OPAQUE;_CUT;_FADE;_TRANSPARENT;Create;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;550;-1280,-3456;Half;False;Property;_SrcBlend;_SrcBlend;11;1;[HideInInspector];Create;True;0;0;True;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;743;-640,-3456;Half;False;Property;_CullType;Cull Type;3;1;[Enum];Create;True;3;Off;0;Front;1;Back;2;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1103;-1270.17,-3840.119;Half;False;Property;_RENDERINGG;[ RENDERINGG ];1;0;Create;True;0;0;True;1;InternalCategory(Rendering);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1114;-768,-2944;Float;False;Property;_RENDERTYPEKEY;RenderTypeKey;5;0;Create;False;0;0;False;0;0;0;0;False;_ALPHABLEND_ON;KeywordEnum;4;_OPAQUE;_CUT;_FADE;_TRANSPARENT;Create;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;1112;-768,-2528;Float;False;Property;_RENDERTYPEKEY;RenderTypeKey;5;0;Create;False;0;0;False;0;0;0;0;False;_ALPHABLEND_ON;KeywordEnum;4;_OPAQUE;_CUT;_FADE;_TRANSPARENT;Create;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1109;-934.1699,-3840.119;Half;False;Property;_ADVANCEDD;[ ADVANCEDD ];10;0;Create;True;0;0;True;1;InternalCategory(Advanced);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1106;-1270.17,-3936.119;Half;False;Property;_ADSFallback;< ADS Fallback >;0;0;Create;True;0;0;True;1;InternalBanner(ADS Fallback);1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1102;-1270.17,-3744.119;Half;False;Property;_RenderTypee;# _RenderTypee;4;0;Create;True;0;0;True;1;InternalInteractive(_RenderType, 1);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1100;-1078.17,-3840.119;Half;False;Property;_MAINN;[ MAINN ];6;0;Create;True;0;0;True;1;InternalCategory(Main);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-256,-2944;Float;False;True;-1;2;AppalachiaShaderEditorGUI;200;0;Lambert;appalachia/fallback-opaque;False;False;False;False;False;True;True;True;True;False;True;True;False;False;False;False;False;False;False;False;False;Off;0;True;925;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0;True;True;0;True;Opaque;;Geometry;All;12;d3d9;d3d11_9x;d3d11;glcore;gles3;metal;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;1;5;True;550;10;True;553;0;1;False;550;10;False;553;0;True;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;200;Unlit/Color;-1;-1;-1;-1;0;False;0;0;True;743;-1;0;True;862;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;14;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;683;-1280,-3584;Inherit;False;1078.611;100;Rendering;0;;1,0,0.503,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;760;-128,-1920;Inherit;False;1352.028;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;712;-1280,-1920;Inherit;False;1028.509;100;Main UVs;0;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1099;-1270.17,-4064.119;Inherit;False;891.9857;100;Drawers;0;;1,0.4980392,0,1;0;0
WireConnection;564;0;563;1
WireConnection;564;1;563;2
WireConnection;565;0;563;3
WireConnection;565;1;563;4
WireConnection;562;0;561;0
WireConnection;562;1;564;0
WireConnection;575;0;562;0
WireConnection;575;1;565;0
WireConnection;587;0;575;0
WireConnection;18;1;588;0
WireConnection;616;0;18;4
WireConnection;1057;0;409;4
WireConnection;487;0;18;0
WireConnection;486;0;409;0
WireConnection;1115;0;1077;0
WireConnection;1115;1;1089;0
WireConnection;1115;2;1116;0
WireConnection;1115;3;1117;0
WireConnection;1058;0;1059;0
WireConnection;1058;1;791;0
WireConnection;1118;0;1077;0
WireConnection;1118;1;1089;0
WireConnection;1111;1;1134;0
WireConnection;1111;0;1134;0
WireConnection;1111;2;1058;0
WireConnection;1111;3;1058;0
WireConnection;1114;1;1118;0
WireConnection;1114;0;1118;0
WireConnection;1114;2;1118;0
WireConnection;1114;3;1115;0
WireConnection;1112;1;1134;0
WireConnection;1112;0;791;0
WireConnection;1112;2;1134;0
WireConnection;1112;3;1134;0
WireConnection;0;0;1114;0
WireConnection;0;9;1111;0
WireConnection;0;10;1112;0
ASEEND*/
//CHKSM=0E7700FBFC8E22092E5C37319FB39002CDB20161