// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "internal/touchbend/quad-renderer_spatial"
{
	Properties
	{
		_MainTex("Main Tex", 2D) = "black" {}
		_STRENGTH("STRENGTH", Range( 0 , 3)) = 1
		_MIN_OLD("MIN_OLD", Range( 0 , 1)) = 0
		_MAX_OLD("MAX_OLD", Range( 0 , 1)) = 1
		_Touchbend("_Touchbend", Float) = 1

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Touchbend" "Queue"="Transparent" "PreviewType"="Plane" }
	LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		Cull Off
		ColorMask RGBA
		ZWrite Off
		ZTest LEqual
		
		
		
		Pass
		{
			Name "Unlit"
			Tags { "LightMode"="ForwardBase" }
			CGPROGRAM

			

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			

			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
			};

			uniform sampler2D _MainTex;
			uniform float _STRENGTH;
			uniform float _MAX_OLD;
			uniform float _MIN_OLD;
			uniform float _Touchbend;

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float3 ase_worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				o.ase_texcoord1.xyz = ase_worldPos;
				
				o.ase_texcoord = v.vertex;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.w = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				float3 appendResult137 = (float3(i.ase_texcoord.xyz.x , i.ase_texcoord.xyz.y , i.ase_texcoord.xyz.z));
				float3 objToWorldDir191 = normalize( mul( unity_ObjectToWorld, float4( appendResult137, 0 ) ).xyz );
				float4 appendResult284 = (float4(objToWorldDir191.x , 0.0 , objToWorldDir191.z , 0.0));
				float4 normalizeResult285 = normalize( appendResult284 );
				float3 break197 = ( ( normalizeResult285.xyz * 0.5 ) + 0.5 );
				float3 ase_worldPos = i.ase_texcoord1.xyz;
				float4 _OFFSET = float4(0,0,0,0);
				float temp_output_7_0_g20 = (_OFFSET).x;
				float4 appendResult192 = (float4(break197.x , ( ( ase_worldPos.y - temp_output_7_0_g20 ) / ( 1024.0 - temp_output_7_0_g20 ) ) , break197.z , 1.0));
				
				
				finalColor = appendResult192;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=17500
0;0;1280;659;-5321.417;-1422.237;1;True;False
Node;AmplifyShaderEditor.PosVertexDataNode;194;4779.31,1221.004;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;137;4996.31,1242.004;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TransformDirectionNode;191;5157.31,1235.004;Inherit;False;Object;World;True;Fast;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;284;5496.596,1252.181;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.NormalizeNode;285;5723.144,1341.99;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WorldPosInputsNode;295;5548.522,1475.724;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;297;5763.78,1793.715;Inherit;False;Constant;_Float10;Float 10;2;0;Create;True;0;0;False;0;1024;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;193;5936.41,1336.404;Inherit;False;Normal Pack;-1;;17;505170751a054f248b165a75f7b6efb7;0;1;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;197;6169.888,1336.211;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;300;6515.098,1710.568;Inherit;False;Constant;_Float2;Float 2;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;298;6070,1634;Inherit;False;Pack Data;-1;;19;1f16a53b59a58fe47a0b19ee1351fb70;6,33,0,55,0,73,0,85,0,42,1,45,1;8;59;FLOAT;0;False;62;FLOAT2;0,0;False;64;FLOAT4;0,0,0,0;False;63;FLOAT3;0,0,0;False;71;FLOAT4;0,0,0,0;False;70;FLOAT3;0,0,0;False;68;FLOAT;0;False;69;FLOAT2;0,0;False;1;FLOAT;29
Node;AmplifyShaderEditor.SimpleAddOpNode;291;5671,1684;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;135;5832.954,2133.464;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;289;5319.266,1744.899;Inherit;False;Constant;_Float9;Float 9;2;0;Create;True;0;0;False;0;8;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;129;4688.17,1523.22;Inherit;True;Property;_MainTex;Main Tex;0;0;Create;True;0;0;True;0;-1;0ae6ee93c4c5c464a86dbffad016bb06;16c79a47f8bbd144eb0c60a10f1762c3;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;299;5544.995,1667.391;Inherit;False;Unpack Data;-1;;15;094bd96375a2bc140be980fdb53fc590;6,33,0,55,0,73,0,85,0,42,0,45,0;8;59;FLOAT;0;False;62;FLOAT2;0,0;False;64;FLOAT4;0,0,0,0;False;63;FLOAT3;0,0,0;False;71;FLOAT4;0,0,0,0;False;70;FLOAT3;0,0,0;False;68;FLOAT;0;False;69;FLOAT2;0,0;False;1;FLOAT;29
Node;AmplifyShaderEditor.SimpleMaxOpNode;152;5220.355,2145.233;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;305;4761.272,1911.126;Inherit;False;Property;_Touchbend;_Touchbend;4;0;Create;True;0;0;True;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;196;5595.988,2274.027;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;131;5056.266,2442.396;Inherit;False;Property;_STRENGTH;STRENGTH;1;0;Create;True;0;0;True;0;1;0.72;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;151;5209.355,2047.233;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;183;5327.445,2310.571;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;192;6899.121,1350.932;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TFHCRemapNode;150;5423.9,2002.763;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;149;4780.566,2152.496;Inherit;False;Property;_MAX_OLD;MAX_OLD;3;0;Create;True;0;0;True;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;181;5107.445,2327.571;Inherit;False;Constant;_Float1;Float 1;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;180;5097.445,2246.571;Inherit;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;182;5383.445,2322.571;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;146;4817.566,2060.496;Inherit;False;Property;_MIN_OLD;MIN_OLD;2;0;Create;True;0;0;True;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;148;6169.749,2131.054;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;77;7060.31,1350.204;Float;False;True;-1;2;ASEMaterialInspector;100;1;internal/touchbend/quad-renderer_spatial;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;True;0;False;-1;0;False;-1;True;False;True;2;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;2;False;-1;True;0;False;-1;True;False;0;False;-1;0;False;-1;True;3;RenderType=Touchbend=RenderType;Queue=Transparent=Queue=0;PreviewType=Plane;True;2;0;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;0
WireConnection;137;0;194;1
WireConnection;137;1;194;2
WireConnection;137;2;194;3
WireConnection;191;0;137;0
WireConnection;284;0;191;1
WireConnection;284;2;191;3
WireConnection;285;0;284;0
WireConnection;193;2;285;0
WireConnection;197;0;193;0
WireConnection;298;59;295;2
WireConnection;298;68;297;0
WireConnection;135;0;150;0
WireConnection;135;1;196;0
WireConnection;299;59;129;2
WireConnection;299;68;289;0
WireConnection;152;0;146;0
WireConnection;152;1;149;0
WireConnection;196;0;131;0
WireConnection;151;0;146;0
WireConnection;151;1;149;0
WireConnection;183;0;180;0
WireConnection;192;0;197;0
WireConnection;192;1;298;29
WireConnection;192;2;197;2
WireConnection;192;3;300;0
WireConnection;150;0;129;1
WireConnection;150;1;151;0
WireConnection;150;2;152;0
WireConnection;150;3;183;0
WireConnection;150;4;182;0
WireConnection;182;0;181;0
WireConnection;148;0;135;0
WireConnection;77;0;192;0
ASEEND*/
//CHKSM=6EBFB0FFE808D37047019D51E3167BFF67289585