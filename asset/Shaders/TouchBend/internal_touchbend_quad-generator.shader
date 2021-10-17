// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "appalachia/touchbend/quad-generator"
{
	Properties
	{
		_GENERATION_MASK("_GENERATION_MASK", Vector) = (0.25,0.5,0.25,0)
		_GENERATION_SCALE("_GENERATION_SCALE", Float) = 1

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" }
	LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		Cull Back
		ColorMask RGBA
		ZWrite On
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
				float3 ase_normal : NORMAL;
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
			};

			uniform float3 _GENERATION_MASK;
			uniform float _GENERATION_SCALE;

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float3 break173 = abs( v.vertex.xyz );
				float3 _Vector0 = float3(-0.01,-0.01,-0.01);
				float temp_output_174_0 = ( (( break173.x >= _Vector0.x && break173.x <= _GENERATION_MASK.x ) ? 1.0 :  0.0 ) * (( break173.y >= _Vector0.y && break173.y <= _GENERATION_MASK.y ) ? 1.0 :  0.0 ) * (( break173.z >= _Vector0.z && break173.z <= _GENERATION_MASK.z ) ? 1.0 :  0.0 ) );
				
				o.ase_texcoord = v.vertex;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = (( temp_output_174_0 > 0.0 ) ? ( v.ase_normal * (( _GENERATION_SCALE - 1.0 )).xxx ) :  float3(0,0,0) );
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
				float3 break173 = abs( i.ase_texcoord.xyz );
				float3 _Vector0 = float3(-0.01,-0.01,-0.01);
				float temp_output_174_0 = ( (( break173.x >= _Vector0.x && break173.x <= _GENERATION_MASK.x ) ? 1.0 :  0.0 ) * (( break173.y >= _Vector0.y && break173.y <= _GENERATION_MASK.y ) ? 1.0 :  0.0 ) * (( break173.z >= _Vector0.z && break173.z <= _GENERATION_MASK.z ) ? 1.0 :  0.0 ) );
				float4 _OFFSET = float4(0,0,0,0);
				float4 _Vector2 = float4(2,2,2,2);
				float temp_output_79_0_g11 = ( 8.0 / (_Vector2).x );
				float temp_output_7_0_g12 = ( (_OFFSET).x - temp_output_79_0_g11 );
				float4 appendResult137 = (float4(1.0 , ( ( i.ase_texcoord.xyz.y - temp_output_7_0_g12 ) / ( temp_output_79_0_g11 - temp_output_7_0_g12 ) ) , 0.0 , 0.0));
				
				
				finalColor = (( temp_output_174_0 > 0.0 ) ? appendResult137 :  float4(0,0.5,0,0) );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=17500
0;0;1280;659;-977.4915;288.7746;1.3;True;False
Node;AmplifyShaderEditor.PosVertexDataNode;139;726.7422,-745.967;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.AbsOpNode;140;955.313,-745.98;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;148;587.3047,408.5334;Inherit;False;Property;_GENERATION_SCALE;_GENERATION_SCALE;1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;154;677.9035,491.0443;Inherit;False;Constant;_Float0;Float 0;2;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;151;865.9037,426.0443;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;166;737.6655,-498.5063;Inherit;False;Constant;_Vector0;Vector 0;2;0;Create;True;0;0;False;0;-0.01,-0.01,-0.01;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;144;738.6983,-327.9978;Inherit;False;Property;_GENERATION_MASK;_GENERATION_MASK;0;0;Create;True;0;0;False;0;0.25,0.5,0.25;0.25,0.5,0.25;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.BreakToComponentsNode;173;1149,-741;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;175;1344,-272;Inherit;False;Constant;_Float2;Float 2;2;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;176;1344,-192;Inherit;False;Constant;_Float3;Float 3;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;223;481.7167,193.888;Inherit;False;Constant;_Float7;Float 7;2;0;Create;True;0;0;False;0;8;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;208;437,-3;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SwizzleNode;156;1016.904,423.0443;Inherit;False;FLOAT3;0;0;0;3;1;0;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCCompareWithRange;170;1536,-768;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareWithRange;171;1536,-592;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;225;764.9928,40.80638;Inherit;False;Pack Data;-1;;11;1f16a53b59a58fe47a0b19ee1351fb70;6,33,0,55,0,73,0,85,0,42,0,45,0;8;59;FLOAT;0;False;62;FLOAT2;0,0;False;64;FLOAT4;0,0,0,0;False;63;FLOAT3;0,0,0;False;71;FLOAT4;0,0,0,0;False;70;FLOAT3;0,0,0;False;68;FLOAT;0;False;69;FLOAT2;0,0;False;1;FLOAT;29
Node;AmplifyShaderEditor.NormalVertexDataNode;149;916.5723,230.9859;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;203;1278,-81;Inherit;False;Constant;_Float5;Float 5;2;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareWithRange;172;1536,-416;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;174;1821.115,-603.9792;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;188;1887.275,393.3355;Inherit;False;Constant;_Vector2;Vector 2;2;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;155;1233.904,263.0443;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;186;1899.294,204.0146;Inherit;False;Constant;_Float4;Float 4;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;137;1678.105,-67.16657;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector4Node;207;1635.898,106.9363;Inherit;False;Constant;_Vector1;Vector 1;2;0;Create;True;0;0;False;0;0,0.5,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCCompareGreater;184;2258.173,-23.21558;Inherit;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TFHCCompareGreater;185;2216.488,268.5887;Inherit;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;77;2585.277,192.0861;Float;False;True;-1;2;ASEMaterialInspector;100;1;appalachia/touchbend/quad-generator;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;0;1;False;-1;1;False;-1;0;5;False;-1;10;False;-1;True;0;False;-1;0;False;-1;True;False;True;0;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;0;False;-1;True;False;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;0
WireConnection;140;0;139;0
WireConnection;151;0;148;0
WireConnection;151;1;154;0
WireConnection;173;0;140;0
WireConnection;156;0;151;0
WireConnection;170;0;173;0
WireConnection;170;1;166;1
WireConnection;170;2;144;1
WireConnection;170;3;175;0
WireConnection;170;4;176;0
WireConnection;171;0;173;1
WireConnection;171;1;166;2
WireConnection;171;2;144;2
WireConnection;171;3;175;0
WireConnection;171;4;176;0
WireConnection;225;59;208;2
WireConnection;225;68;223;0
WireConnection;172;0;173;2
WireConnection;172;1;166;3
WireConnection;172;2;144;3
WireConnection;172;3;175;0
WireConnection;172;4;176;0
WireConnection;174;0;170;0
WireConnection;174;1;171;0
WireConnection;174;2;172;0
WireConnection;155;0;149;0
WireConnection;155;1;156;0
WireConnection;137;0;203;0
WireConnection;137;1;225;29
WireConnection;184;0;174;0
WireConnection;184;1;186;0
WireConnection;184;2;137;0
WireConnection;184;3;207;0
WireConnection;185;0;174;0
WireConnection;185;1;186;0
WireConnection;185;2;155;0
WireConnection;185;3;188;0
WireConnection;77;0;184;0
WireConnection;77;1;185;0
ASEEND*/
//CHKSM=F2E4594EFDD1A5531A569995A478FFF38F392040