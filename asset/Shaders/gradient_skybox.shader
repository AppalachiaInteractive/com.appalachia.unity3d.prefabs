Shader "appalachia/gradient_skybox"
{
	Properties
	{
		[HDR]_Top("Top", Color) = (1,1,1,1)
		[HDR]_Middle("Middle", Color) = (1,0,0,1)
		[HDR]_Bottom("Bottom", Color) = (0,0,0,1)
		_Shift("Shift", Range( -1 , 1)) = 0
		_Multiply("Multiply", Float) = 1
		_Power("Power", Float) = 1
		[Toggle(_SCREENSPACE_ON)] _Screenspace("Screen space", Float) = 0

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
			#pragma shader_feature_local _SCREENSPACE_ON


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

			uniform float _Shift;
			uniform float _Multiply;
			uniform float _Power;
			uniform float4 _Bottom;
			uniform float4 _Middle;
			uniform float4 _Top;

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord1 = screenPos;
				
				o.ase_texcoord = v.vertex;
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
				float4 screenPos = i.ase_texcoord1;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				#ifdef _SCREENSPACE_ON
				float staticSwitch13 = ase_screenPosNorm.y;
				#else
				float staticSwitch13 = i.ase_texcoord.xyz.y;
				#endif
				float clampResult13_g30 = clamp( pow( saturate( ( ( _Shift + staticSwitch13 ) * _Multiply ) ) , _Power ) , 0.0 , 1.0 );
				float4 _Vector0 = float4(0,0,0,0);
				float4 _Vector1 = float4(1,1,1,1);
				float clampResult13_g36 = clamp( (-1.0 + (clampResult13_g30 - _Vector0.x) * (1.0 - -1.0) / (_Vector1.x - _Vector0.x)) , -1.0 , 1.0 );
				float4 temp_output_3_0_g36 = _Middle;
				float4 lerpResult1_g42 = lerp( _Bottom , temp_output_3_0_g36 , saturate( ( 1.0 + clampResult13_g36 ) ));
				float4 lerpResult1_g37 = lerp( temp_output_3_0_g36 , _Top , saturate( clampResult13_g36 ));
				
				
				finalColor = (( clampResult13_g36 < 0.0 ) ? lerpResult1_g42 :  lerpResult1_g37 );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=17500
-429.3333;-960;1706.667;939;989.9031;697.2053;1;True;False
Node;AmplifyShaderEditor.PosVertexDataNode;11;-1596.67,338.9635;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenPosInputsNode;2;-1602.49,83.16423;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;13;-1357.788,197.2544;Inherit;False;Property;_Screenspace;Screen space;6;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-1298.749,53.96152;Inherit;False;Property;_Shift;Shift;3;0;Create;True;0;0;False;0;0;-0.02;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1059.179,445.5748;Inherit;False;Property;_Multiply;Multiply;4;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;26;-1037.749,233.9615;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-807.1788,289.5748;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;9;-603.1788,284.5748;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-724.1788,465.5748;Inherit;False;Property;_Power;Power;5;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;8;-409.1788,254.5748;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;5;-444.5072,-526.7715;Inherit;False;Property;_Bottom;Bottom;2;1;[HDR];Create;True;0;0;False;0;0,0,0,1;0.02823393,0.01523146,0.002414744,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;20;-448.4043,-314.9395;Inherit;False;Property;_Middle;Middle;1;1;[HDR];Create;True;0;0;False;0;1,0,0,1;0.05621554,0.04886024,0.0352004,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;4;-456.5,-107.18;Inherit;False;Property;_Top;Top;0;1;[HDR];Create;True;0;0;False;0;1,1,1,1;0.09614436,0.09089058,0.0798576,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;22;305.3827,-190.4944;Inherit;False;Lerp 3;-1;;30;17ff52dfb094d4f4495896f316029fca;0;4;1;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;6;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1;671.3331,-246.4455;Float;False;True;-1;2;ASEMaterialInspector;100;1;appalachia/gradient_skybox;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;True;False;True;0;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;0
WireConnection;13;1;11;2
WireConnection;13;0;2;2
WireConnection;26;0;25;0
WireConnection;26;1;13;0
WireConnection;6;0;26;0
WireConnection;6;1;7;0
WireConnection;9;0;6;0
WireConnection;8;0;9;0
WireConnection;8;1;10;0
WireConnection;22;1;5;0
WireConnection;22;3;20;0
WireConnection;22;4;4;0
WireConnection;22;6;8;0
WireConnection;1;0;22;0
ASEEND*/
//CHKSM=A9BA4231935C46C465DD5A725B905B67E9A25093