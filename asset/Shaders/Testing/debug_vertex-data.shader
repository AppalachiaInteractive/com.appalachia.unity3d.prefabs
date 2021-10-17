// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "appalachia/debugging/debug_vertex-data"
{
	Properties
	{
		[KeywordEnum(VertexRGBA,VertexR,VertexB,VertexG,VertexA,Normal,Position,Tangent,TangentSign)] _DebugUVChannel("DebugUVChannel", Float) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.5
		#pragma shader_feature_local _DEBUGUVCHANNEL_VERTEXRGBA _DEBUGUVCHANNEL_VERTEXR _DEBUGUVCHANNEL_VERTEXB _DEBUGUVCHANNEL_VERTEXG _DEBUGUVCHANNEL_VERTEXA _DEBUGUVCHANNEL_NORMAL _DEBUGUVCHANNEL_POSITION _DEBUGUVCHANNEL_TANGENT _DEBUGUVCHANNEL_TANGENTSIGN
		#pragma surface surf Standard keepalpha noshadow vertex:vertexDataFunc 
		struct Input
		{
			float4 vertexColor : COLOR;
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldPos;
			half ase_vertexTangentSign;
		};

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.ase_vertexTangentSign = v.tangent.w;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Normal = float3(0,0,1);
			float4 temp_cast_0 = (i.vertexColor.r).xxxx;
			float4 temp_cast_1 = (i.vertexColor.g).xxxx;
			float4 temp_cast_2 = (i.vertexColor.b).xxxx;
			float4 temp_cast_3 = (i.vertexColor.a).xxxx;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			float temp_output_7_0_g3 = -1.0;
			float3 temp_cast_4 = (temp_output_7_0_g3).xxx;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float temp_output_7_0_g4 = -128.0;
			float3 temp_cast_6 = (temp_output_7_0_g4).xxx;
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float4 ase_vertexTangent = mul( unity_WorldToObject, float4( ase_worldTangent, 0 ) );
			float temp_output_7_0_g7 = -1.0;
			float3 temp_cast_8 = (temp_output_7_0_g7).xxx;
			float temp_output_7_0_g5 = -1.0;
			float4 temp_cast_10 = (( ( i.ase_vertexTangentSign - temp_output_7_0_g5 ) / ( 1.0 - temp_output_7_0_g5 ) )).xxxx;
			#if defined(_DEBUGUVCHANNEL_VERTEXRGBA)
				float4 staticSwitch11 = i.vertexColor;
			#elif defined(_DEBUGUVCHANNEL_VERTEXR)
				float4 staticSwitch11 = temp_cast_0;
			#elif defined(_DEBUGUVCHANNEL_VERTEXB)
				float4 staticSwitch11 = temp_cast_1;
			#elif defined(_DEBUGUVCHANNEL_VERTEXG)
				float4 staticSwitch11 = temp_cast_2;
			#elif defined(_DEBUGUVCHANNEL_VERTEXA)
				float4 staticSwitch11 = temp_cast_3;
			#elif defined(_DEBUGUVCHANNEL_NORMAL)
				float4 staticSwitch11 = float4( ( ( ase_vertexNormal - temp_cast_4 ) / ( 1.0 - temp_output_7_0_g3 ) ) , 0.0 );
			#elif defined(_DEBUGUVCHANNEL_POSITION)
				float4 staticSwitch11 = float4( ( ( ase_vertex3Pos - temp_cast_6 ) / ( 128.0 - temp_output_7_0_g4 ) ) , 0.0 );
			#elif defined(_DEBUGUVCHANNEL_TANGENT)
				float4 staticSwitch11 = float4( ( ( ase_vertexTangent.xyz - temp_cast_8 ) / ( 1.0 - temp_output_7_0_g7 ) ) , 0.0 );
			#elif defined(_DEBUGUVCHANNEL_TANGENTSIGN)
				float4 staticSwitch11 = temp_cast_10;
			#else
				float4 staticSwitch11 = i.vertexColor;
			#endif
			o.Albedo = staticSwitch11.rgb;
			o.Emission = staticSwitch11.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17000
0;0;853;659;4453.26;436.0397;1;True;False
Node;AmplifyShaderEditor.NormalVertexDataNode;63;-4441.488,-234.4382;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;62;-4416,-64;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TangentVertexDataNode;61;-4429.248,121.8993;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TangentSignVertexDataNode;60;-4536.254,327.8821;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;64;-4188.362,-424.8042;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;72;-4171.449,-214.8315;Float;False;Remap To 0-1;-1;;3;5eda8a2bb94ebef4ab0e43d19291cd8b;0;3;6;FLOAT3;0,0,0;False;7;FLOAT;-1;False;8;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;73;-4160,-48;Float;False;Remap To 0-1;-1;;4;5eda8a2bb94ebef4ab0e43d19291cd8b;0;3;6;FLOAT3;0,0,0;False;7;FLOAT;-128;False;8;FLOAT;128;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;66;-4223.698,287.0808;Float;False;Remap To 0-1;-1;;5;5eda8a2bb94ebef4ab0e43d19291cd8b;0;3;6;FLOAT;0;False;7;FLOAT;-1;False;8;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;75;-4176.717,111.1974;Float;False;Remap To 0-1;-1;;7;5eda8a2bb94ebef4ab0e43d19291cd8b;0;3;6;FLOAT3;0,0,0;False;7;FLOAT;-1;False;8;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;11;-3705.844,22.52272;Float;False;Property;_DebugUVChannel;DebugUVChannel;0;0;Create;True;0;0;False;0;0;0;2;True;;KeywordEnum;9;VertexRGBA;VertexR;VertexB;VertexG;VertexA;Normal;Position;Tangent;TangentSign;Create;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-1919.19,-40.50513;Float;False;True;3;Float;ASEMaterialInspector;0;0;Standard;appalachia/Debugging/debug_vertex-data;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;72;6;63;0
WireConnection;73;6;62;0
WireConnection;66;6;60;0
WireConnection;75;6;61;0
WireConnection;11;1;64;0
WireConnection;11;0;64;1
WireConnection;11;2;64;2
WireConnection;11;3;64;3
WireConnection;11;4;64;4
WireConnection;11;5;72;0
WireConnection;11;6;73;0
WireConnection;11;7;75;0
WireConnection;11;8;66;0
WireConnection;0;0;11;0
WireConnection;0;2;11;0
ASEEND*/
//CHKSM=6446C857729B1C74A1361C1A455BB80D60F767AF