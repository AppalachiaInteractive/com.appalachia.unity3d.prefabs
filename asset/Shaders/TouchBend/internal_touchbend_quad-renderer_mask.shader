// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "internal/touchbend/quad-renderer_mask"
{
	Properties
	{
		_MainTex("Main Tex", 2D) = "black" {}
		_STRENGTH("STRENGTH", Range( 0 , 3)) = 1
		_VELOCITY("_VELOCITY", Range( 0 , 8)) = 0
		_MIN_OLD("MIN_OLD", Range( 0 , 1)) = 0
		_MAX_OLD("MAX_OLD", Range( 0 , 1)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Touchbend" }
	LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		Cull Off
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
				float4 ase_texcoord : TEXCOORD0;
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
			};

			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;
			uniform float _MIN_OLD;
			uniform float _MAX_OLD;
			uniform float _STRENGTH;
			uniform float _VELOCITY;

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.zw = 0;
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
				float2 uv_MainTex = i.ase_texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float temp_output_205_0 = saturate( ( (0.0 + (tex2D( _MainTex, uv_MainTex ).r - min( _MIN_OLD , _MAX_OLD )) * (1.0 - 0.0) / (max( _MIN_OLD , _MAX_OLD ) - min( _MIN_OLD , _MAX_OLD ))) * _STRENGTH ) );
				float4 _OFFSET = float4(0,0,0,0);
				float temp_output_7_0_g6 = (_OFFSET).x;
				float4 appendResult207 = (float4(temp_output_205_0 , ( temp_output_205_0 * saturate( ( ( _VELOCITY - temp_output_7_0_g6 ) / ( 8.0 - temp_output_7_0_g6 ) ) ) ) , 0.0 , 0.0));
				
				
				finalColor = appendResult207;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=17500
-6.666667;64;1267;649;-5634.897;-1531.279;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;181;5365.873,1977.374;Inherit;False;Constant;_Float1;Float 1;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;149;5045.794,1803.299;Inherit;False;Property;_MAX_OLD;MAX_OLD;4;0;Create;True;0;0;True;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;146;5082.794,1711.299;Inherit;False;Property;_MIN_OLD;MIN_OLD;3;0;Create;True;0;0;True;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;180;5354.873,1898.374;Inherit;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;131;5313.694,2093.199;Inherit;False;Property;_STRENGTH;STRENGTH;1;0;Create;True;0;0;True;0;1;0.72;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;183;5602.873,1900.374;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;129;5115.457,1355.458;Inherit;True;Property;_MainTex;Main Tex;0;0;Create;True;0;0;True;0;-1;16c79a47f8bbd144eb0c60a10f1762c3;16c79a47f8bbd144eb0c60a10f1762c3;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;182;5640.873,1973.374;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;151;5455.783,1679.036;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;152;5465.783,1762.036;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;150;5681.328,1653.566;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;196;5853.416,1924.83;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;135;6024.677,1785.415;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;206;5422.1,2199.399;Inherit;False;Property;_VELOCITY;_VELOCITY;2;0;Create;True;0;0;True;0;0;0.72;0;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;209;5537.205,2304.865;Inherit;False;Constant;_Float2;Float 2;5;0;Create;True;0;0;False;0;8;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;210;5752.205,2198.865;Inherit;False;Pack Data;-1;;5;1f16a53b59a58fe47a0b19ee1351fb70;6,33,0,55,0,73,0,85,0,42,1,45,1;8;59;FLOAT;0;False;62;FLOAT2;0,0;False;64;FLOAT4;0,0,0,0;False;63;FLOAT3;0,0,0;False;71;FLOAT4;0,0,0,0;False;70;FLOAT3;0,0,0;False;68;FLOAT;0;False;69;FLOAT2;0,0;False;1;FLOAT;29
Node;AmplifyShaderEditor.SaturateNode;205;6167.428,1787.038;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;211;6317.96,1869.923;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;207;6509,1792;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;77;6656,1792;Float;False;True;-1;2;ASEMaterialInspector;100;1;internal/touchbend/quad-renderer_mask;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;True;0;False;-1;0;False;-1;True;False;True;2;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;0;False;-1;True;0;False;-1;True;False;0;False;-1;0;False;-1;True;1;RenderType=Touchbend=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;0
WireConnection;183;0;180;0
WireConnection;182;0;181;0
WireConnection;151;0;146;0
WireConnection;151;1;149;0
WireConnection;152;0;146;0
WireConnection;152;1;149;0
WireConnection;150;0;129;1
WireConnection;150;1;151;0
WireConnection;150;2;152;0
WireConnection;150;3;183;0
WireConnection;150;4;182;0
WireConnection;196;0;131;0
WireConnection;135;0;150;0
WireConnection;135;1;196;0
WireConnection;210;59;206;0
WireConnection;210;68;209;0
WireConnection;205;0;135;0
WireConnection;211;0;205;0
WireConnection;211;1;210;29
WireConnection;207;0;205;0
WireConnection;207;1;211;0
WireConnection;77;0;207;0
ASEEND*/
//CHKSM=4D4CAC98249B56D5AB1EB4BFA610347D25410D76