// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "appalachia/fade"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		[Toggle]_Scale("Scale", Float) = 0
		[Toggle]_Dither("Dither", Float) = 1
		_CutoffLowNear("Cutoff Low (Near)", Range( 0 , 1)) = 0.75
		_CutoffHighNear("Cutoff High (Near)", Range( 0 , 1)) = 1
		[HideInInspector]_cutoff("_cutoff", Float) = 0
		_CutoffFar("Cutoff Far", Range( 64 , 1024)) = 64
		_CutoffLowFar("Cutoff Low (Far)", Range( 0 , 1)) = 0.1
		_CutoffHighFar("Cutoff High (Far)", Range( 0 , 1)) = 0.6
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
		#pragma target 3.5
		#pragma multi_compile_instancing
		#pragma exclude_renderers gles vulkan 
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
			float4 screenPosition;
			float4 vertexColor : COLOR;
			float3 worldPos;
		};

		uniform float _Scale;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float _Dither;
		uniform half _CutoffLowNear;
		uniform half _CutoffLowFar;
		uniform half _CutoffFar;
		uniform half _CutoffHighNear;
		uniform half _CutoffHighFar;
		uniform float _cutoff;


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


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 temp_cast_0 = (0.0).xxx;
			float3 temp_cast_1 = (0.0).xxx;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float temp_output_63_0_g6008 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
			float3 lerpResult57_g6008 = lerp( temp_cast_1 , -ase_vertex3Pos , ( 1.0 - temp_output_63_0_g6008 ));
			v.vertex.xyz += (( _Scale )?( lerpResult57_g6008 ):( temp_cast_0 ));
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			o.screenPosition = ase_screenPos;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode2440 = tex2D( _MainTex, uv_MainTex );
			o.Albedo = tex2DNode2440.rgb;
			o.Alpha = 1;
			float localMyCustomExpression2392 = ( 0.0 );
			float4 ase_screenPos = i.screenPosition;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 clipScreen45_g6004 = ase_screenPosNorm.xy * _ScreenParams.xy;
			float dither45_g6004 = Dither8x8Bayer( fmod(clipScreen45_g6004.x, 8), fmod(clipScreen45_g6004.y, 8) );
			float temp_output_56_0_g6004 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
			dither45_g6004 = step( dither45_g6004, temp_output_56_0_g6004 );
			float opacity2392 = (( _Dither )?( ( tex2DNode2440.a * dither45_g6004 ) ):( tex2D( _MainTex, uv_MainTex ).a ));
			float3 ase_worldPos = i.worldPos;
			float temp_output_9_0_g6012 = saturate( ( distance( _WorldSpaceCameraPos , ase_worldPos ) / _CutoffFar ) );
			float lerpResult12_g6012 = lerp( _CutoffLowNear , _CutoffLowFar , temp_output_9_0_g6012);
			float lerpResult11_g6012 = lerp( _CutoffHighNear , _CutoffHighFar , temp_output_9_0_g6012);
			float cutoff2392 = (lerpResult12_g6012 + (i.vertexColor.b - 0.0) * (lerpResult11_g6012 - lerpResult12_g6012) / (1.0 - 0.0));
			clip( opacity2392 - cutoff2392 );
			clip( localMyCustomExpression2392 - _cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "AppalachiaShaderGUI"
}
/*ASEBEGIN
Version=17500
0;-790.4;996;752;-764.7473;2359.432;1.6;True;False
Node;AmplifyShaderEditor.SamplerNode;2440;759.5702,-2451.92;Inherit;True;Property;_MainTex;MainTex;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2467;987.8149,-1518.378;Half;False;Property;_CutoffHighNear;Cutoff High (Near);4;0;Create;False;3;Off;0;Front;1;Back;2;0;True;0;1;0.787;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2466;987.8149,-1406.378;Half;False;Property;_CutoffLowFar;Cutoff Low (Far);6;0;Create;False;3;Off;0;Front;1;Back;2;0;True;0;0.1;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2465;1115.815,-1134.378;Half;False;Property;_CutoffFar;Cutoff Far;5;0;Create;False;3;Off;0;Front;1;Back;2;0;True;0;64;128;64;1024;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2464;1051.815,-1262.378;Half;False;Property;_CutoffHighFar;Cutoff High (Far);7;0;Create;False;3;Off;0;Front;1;Back;2;0;True;0;0.6;0.7;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2468;977.7151,-1681.478;Half;False;Property;_CutoffLowNear;Cutoff Low (Near);3;0;Create;False;3;Off;0;Front;1;Back;2;0;True;0;0.75;0.558;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;2459;1053.177,-1903.826;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;2461;1246.371,-2022.298;Inherit;False;LODFade Dither;-1;;6004;6e71bbc077fec414597ccdc3bd87facb;1,44,1;1;41;FLOAT;0;False;2;FLOAT;0;FLOAT;57
Node;AmplifyShaderEditor.FunctionNode;2442;1858.642,-1127.667;Inherit;False;const;-1;;5998;5b64729fb717c5f49a1bc2dab81d5e1c;6,21,0,3,0,22,0,28,0,63,0,74,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;2443;1463.86,-2131.579;Inherit;False;Property;_Dither;Dither;2;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2462;1856.283,-983.8149;Inherit;False;LODFade Scale;-1;;6008;2d616134d6e77034192d9074a7b51ced;0;1;41;FLOAT3;0,0,0;False;2;FLOAT3;0;FLOAT;68
Node;AmplifyShaderEditor.FunctionNode;2463;1408.365,-1778.159;Inherit;False;Cutoff Distance;-1;;6012;5fa78795cf865fc4fba7d47ebe2d2d92;0;6;16;FLOAT;0;False;20;FLOAT;0;False;21;FLOAT;0;False;18;FLOAT;0;False;19;FLOAT;0;False;17;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;2441;2284.219,-1124.956;Inherit;False;Property;_Scale;Scale;1;0;Create;True;0;0;False;0;0;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2446;2926.016,-1926.887;Inherit;False;Constant;_cutoff;_cutoff;4;1;[HideInInspector];Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;2392;1930.709,-1776.429;Inherit;False;clip( opacity - cutoff )@;7;False;2;True;opacity;FLOAT;0;In;;Float;False;True;cutoff;FLOAT;0;In;;Float;False;My Custom Expression;False;False;0;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2623.32,-2094.93;Float;False;True;-1;3;AppalachiaShaderGUI;400;0;Standard;appalachia/fade;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;False;True;False;False;False;True;Off;0;False;925;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0;True;True;0;False;TransparentCutout;;AlphaTest;ForwardOnly;12;d3d9;d3d11_9x;d3d11;glcore;gles3;metal;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;550;10;False;553;0;1;False;550;10;False;553;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;400;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;True;2446;0;0;0;False;0.1;False;-1;0;False;-1;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;14;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT3;0,0,0;False;0
WireConnection;2461;41;2440;4
WireConnection;2443;0;2440;4
WireConnection;2443;1;2461;0
WireConnection;2463;16;2459;3
WireConnection;2463;20;2468;0
WireConnection;2463;21;2467;0
WireConnection;2463;18;2466;0
WireConnection;2463;19;2464;0
WireConnection;2463;17;2465;0
WireConnection;2441;0;2442;0
WireConnection;2441;1;2462;0
WireConnection;2392;1;2443;0
WireConnection;2392;2;2463;0
WireConnection;0;0;2440;0
WireConnection;0;10;2392;0
WireConnection;0;11;2441;0
ASEEND*/
//CHKSM=12DDBCC647F9D0B53AFABDA4D71A98B1FE0E6216