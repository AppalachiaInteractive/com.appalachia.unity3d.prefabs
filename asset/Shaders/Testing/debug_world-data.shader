// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "internal/debugging/debug_world-data"
{
	Properties
	{
		[KeywordEnum(WorldNormal,WorldPosition,WorldReflection,CameraDistance)] _MeshData("MeshData", Float) = 0
		_CameraRangeInterest("Camera Range Interest", Float) = 1024
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.5
		#pragma shader_feature_local _MESHDATA_WORLDNORMAL _MESHDATA_WORLDPOSITION _MESHDATA_WORLDREFLECTION _MESHDATA_CAMERADISTANCE
		#pragma surface surf Standard keepalpha noshadow 
		struct Input
		{
			float3 worldNormal;
			float3 worldRefl;
			INTERNAL_DATA
			float3 worldPos;
		};

		uniform float _CameraRangeInterest;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldNormal = i.worldNormal;
			float3 ase_worldReflection = i.worldRefl;
			float3 ase_worldPos = i.worldPos;
			float temp_output_7_0_g230 = _CameraRangeInterest;
			float3 temp_cast_0 = (( ( distance( _WorldSpaceCameraPos , ase_worldPos ) - temp_output_7_0_g230 ) / ( 0.0 - temp_output_7_0_g230 ) )).xxx;
			#if defined(_MESHDATA_WORLDNORMAL)
				float3 staticSwitch73 = ase_worldNormal;
			#elif defined(_MESHDATA_WORLDPOSITION)
				float3 staticSwitch73 = ase_worldNormal;
			#elif defined(_MESHDATA_WORLDREFLECTION)
				float3 staticSwitch73 = ase_worldReflection;
			#elif defined(_MESHDATA_CAMERADISTANCE)
				float3 staticSwitch73 = temp_cast_0;
			#else
				float3 staticSwitch73 = ase_worldNormal;
			#endif
			o.Albedo = staticSwitch73;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17000
0;0;1280;659;1407.196;729.2809;1;True;False
Node;AmplifyShaderEditor.WorldPosInputsNode;49;-1477.701,-267.8546;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceCameraPos;50;-1558.301,-417.3546;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DistanceOpNode;54;-1230.474,-346.2684;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-1268.498,-210.3113;Float;False;Property;_CameraRangeInterest;Camera Range Interest;1;0;Create;True;0;0;False;0;1024;1024;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldReflectionVector;61;-1486.676,-572.1144;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FunctionNode;64;-1048.701,-344.5547;Float;False;Remap To 0-1;-1;;230;5eda8a2bb94ebef4ab0e43d19291cd8b;0;3;6;FLOAT;0;False;7;FLOAT;1024;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;66;-1463.193,-732.5836;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;67;-1467.159,-879.4308;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StaticSwitch;73;-739.4042,-527.5145;Float;False;Property;_MeshData;MeshData;0;0;Create;True;0;0;False;0;0;0;1;True;;KeywordEnum;4;WorldNormal;WorldPosition;WorldReflection;CameraDistance;Create;True;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-260.512,-514.5112;Float;False;True;3;Float;ASEMaterialInspector;0;0;Standard;internal/Debugging/debug_world-data;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;54;0;50;0
WireConnection;54;1;49;0
WireConnection;64;6;54;0
WireConnection;64;7;60;0
WireConnection;73;1;67;0
WireConnection;73;0;66;0
WireConnection;73;2;61;0
WireConnection;73;3;64;0
WireConnection;0;0;73;0
ASEEND*/
//CHKSM=D585247304D69D09E107025575F645540F32B05D