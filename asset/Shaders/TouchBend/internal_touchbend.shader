// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "appalachia/touchbend"
{
	Properties
	{
		_RADIUS("_RADIUS", Range( 0.0001 , 100)) = 0.3

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" }
	LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		BlendOp Add , Add
		Cull Off
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		
		
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
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
			};

			uniform float _RADIUS;

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float3 ase_worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				o.ase_texcoord1.xyz = ase_worldPos;
				float3 ase_worldNormal = UnityObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord2.xyz = ase_worldNormal;
				
				o.ase_texcoord = v.vertex;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.w = 0;
				o.ase_texcoord2.w = 0;
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
				float3 objToWorldDir63 = normalize( mul( unity_ObjectToWorld, float4( i.ase_texcoord.xyz, 0 ) ).xyz );
				float clampResult8_g6 = clamp( objToWorldDir63.x , -1.0 , 1.0 );
				float clampResult8_g1 = clamp( objToWorldDir63.z , -1.0 , 1.0 );
				float3 ase_worldPos = i.ase_texcoord1.xyz;
				float3 ase_worldViewDir = UnityWorldSpaceViewDir(ase_worldPos);
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 ase_worldNormal = i.ase_texcoord2.xyz;
				float fresnelNdotV76 = dot( ase_worldNormal, ase_worldViewDir );
				float fresnelNode76 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV76, 4.084365 ) );
				float temp_output_82_0 = ( 1.0 - fresnelNode76 );
				float temp_output_2_0_g4 = _RADIUS;
				float2 break51 = abs( ( ( 1.0 / (( temp_output_2_0_g4 == 0.0 ) ? 1.0 :  temp_output_2_0_g4 ) ) * (i.ase_texcoord.xyz).xz ) );
				float temp_output_39_0 = ( 1.0 - saturate( max( break51.x , break51.y ) ) );
				float4 appendResult3 = (float4(( ( clampResult8_g6 * 0.5 ) + 0.5 ) , 1.0 , ( ( clampResult8_g1 * 0.5 ) + 0.5 ) , ( ( temp_output_82_0 * temp_output_82_0 ) * temp_output_39_0 * temp_output_39_0 )));
				
				
				finalColor = appendResult3;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=17500
0;0;1280;659;1817.627;641.392;1.6;True;False
Node;AmplifyShaderEditor.RangedFloatNode;24;-1673.2,-126.4;Inherit;False;Property;_RADIUS;_RADIUS;0;0;Create;True;0;0;False;0;0.3;0.3;0.0001;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;62;-1543.452,58.93369;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;37;-1123,-122;Inherit;False;Invert;-1;;4;576cd4c8ab7177b4cb31dbee4d64a7ab;0;1;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;46;-1164.497,53.34869;Inherit;False;True;False;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-921,44;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.AbsOpNode;54;-744.6565,49.80212;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;51;-596.5406,41.05679;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;80;-766.1,-614.9001;Inherit;False;Constant;_FRESNEL_SCALE;_FRESNEL_SCALE;1;0;Create;True;0;0;False;0;1;0.3;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;79;-767.1,-726.9001;Inherit;False;Constant;_FRESNEL_BIAS;_FRESNEL_BIAS;1;0;Create;True;0;0;False;0;0;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-767.1,-518.9001;Inherit;False;Constant;_FRESNEL_POWER;_FRESNEL_POWER;1;0;Create;True;0;0;False;0;4.084365;0.3;0;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;68;-269,132.9182;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;76;-273.764,-582.7738;Inherit;False;Standard;WorldNormal;ViewDir;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;38;-88.039,24.88102;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;64;-1224.424,42.22971;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;82;-18.09875,-576.6124;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;39;114.5697,16.91417;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TransformDirectionNode;63;-351.4856,-335.1395;Inherit;False;Object;World;True;Fast;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;113;186.3552,-596.6175;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;118;-17.6889,-254.9917;Inherit;False;Pack (-1_1 to 0_1);-1;;1;03a4f7d823d57204f9f07b2b0a5142db;0;1;7;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;417.9012,73.38757;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;59;83.0697,-159.7548;Inherit;False;Constant;_Float9;Float 9;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;119;-26.6889,-341.9917;Inherit;False;Pack (-1_1 to 0_1);-1;;6;03a4f7d823d57204f9f07b2b0a5142db;0;1;7;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;67;-273,-99.08176;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;55;-277.7122,13.18686;Inherit;False;Average;-1;;12;3cc639c87d4059642bd54021d04a32cc;2,5,0,4,0;9;15;FLOAT;0;False;16;FLOAT;0;False;17;FLOAT;0;False;18;FLOAT;0;False;19;FLOAT;0;False;20;FLOAT;0;False;21;FLOAT;0;False;22;FLOAT;0;False;23;FLOAT;0;False;1;FLOAT;14
Node;AmplifyShaderEditor.DynamicAppendNode;3;640.8183,-157.5272;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;77;856.9683,-159.5382;Float;False;True;-1;2;ASEMaterialInspector;100;1;appalachia/touchbend;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;0;1;False;-1;0;False;-1;0;5;False;-1;10;False;-1;True;0;False;-1;1;False;-1;True;False;True;2;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;0
WireConnection;37;2;24;0
WireConnection;46;0;62;0
WireConnection;36;0;37;0
WireConnection;36;1;46;0
WireConnection;54;0;36;0
WireConnection;51;0;54;0
WireConnection;68;0;51;0
WireConnection;68;1;51;1
WireConnection;76;1;79;0
WireConnection;76;2;80;0
WireConnection;76;3;81;0
WireConnection;38;0;68;0
WireConnection;64;0;62;0
WireConnection;82;0;76;0
WireConnection;39;0;38;0
WireConnection;63;0;64;0
WireConnection;113;0;82;0
WireConnection;113;1;82;0
WireConnection;118;7;63;3
WireConnection;83;0;113;0
WireConnection;83;1;39;0
WireConnection;83;2;39;0
WireConnection;119;7;63;1
WireConnection;67;0;51;0
WireConnection;67;1;51;1
WireConnection;55;15;51;0
WireConnection;55;16;51;1
WireConnection;3;0;119;0
WireConnection;3;1;59;0
WireConnection;3;2;118;0
WireConnection;3;3;83;0
WireConnection;77;0;3;0
ASEEND*/
//CHKSM=79C82BC509EEAB4CFE2368F607F3F8BE2DAB3B70