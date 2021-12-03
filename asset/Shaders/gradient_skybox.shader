Shader "appalachia/gradient_skybox"
{
	Properties
	{
		_Top("Top", Color) = (1,1,1,1)
		_Middle("Middle", Color) = (1,0,0,1)
		_Bottom("Bottom", Color) = (0,0,0,1)
		_Shift("Shift", Range( -1 , 1)) = 0
		_Multiply("Multiply", Float) = 1
		_Power("Power", Float) = 1
		[Toggle(_SCREENSPACE_ON)] _Screenspace("Screen space", Float) = 0
		[Toggle(_BACKGROUNDNOISE_ON)] _BackgroundNoise("Background Noise", Float) = 1
		_NoiseScale("Noise Scale", Range( 0 , 256)) = 1
		_NoiseMin("Noise Min", Range( -1 , 0)) = -0.1
		_NoiseMax("Noise Max", Range( 0 , 1)) = 0.1
		_NoiseMoveTimeX("Noise Move Time X", Range( 0.01 , 1)) = 0.1
		_NoiseMoveTimeY("Noise Move Time Y", Range( 0.01 , 1)) = 0.1
		_NoiseMoveTimeZ("Noise Move Time Z", Range( 0.01 , 1)) = 0.1

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
			#include "UnityShaderVariables.cginc"
			#pragma shader_feature_local _BACKGROUNDNOISE_ON
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
			uniform float _NoiseMoveTimeX;
			uniform float _NoiseMoveTimeY;
			uniform float _NoiseMoveTimeZ;
			uniform float _NoiseScale;
			uniform float _NoiseMin;
			uniform float _NoiseMax;
			uniform float4 _Bottom;
			uniform float4 _Middle;
			uniform float4 _Top;
			float3 mod3D289( float3 x ) { return x - floor( x / 289.0 ) * 289.0; }
			float4 mod3D289( float4 x ) { return x - floor( x / 289.0 ) * 289.0; }
			float4 permute( float4 x ) { return mod3D289( ( x * 34.0 + 1.0 ) * x ); }
			float4 taylorInvSqrt( float4 r ) { return 1.79284291400159 - r * 0.85373472095314; }
			float snoise( float3 v )
			{
				const float2 C = float2( 1.0 / 6.0, 1.0 / 3.0 );
				float3 i = floor( v + dot( v, C.yyy ) );
				float3 x0 = v - i + dot( i, C.xxx );
				float3 g = step( x0.yzx, x0.xyz );
				float3 l = 1.0 - g;
				float3 i1 = min( g.xyz, l.zxy );
				float3 i2 = max( g.xyz, l.zxy );
				float3 x1 = x0 - i1 + C.xxx;
				float3 x2 = x0 - i2 + C.yyy;
				float3 x3 = x0 - 0.5;
				i = mod3D289( i);
				float4 p = permute( permute( permute( i.z + float4( 0.0, i1.z, i2.z, 1.0 ) ) + i.y + float4( 0.0, i1.y, i2.y, 1.0 ) ) + i.x + float4( 0.0, i1.x, i2.x, 1.0 ) );
				float4 j = p - 49.0 * floor( p / 49.0 );  // mod(p,7*7)
				float4 x_ = floor( j / 7.0 );
				float4 y_ = floor( j - 7.0 * x_ );  // mod(j,N)
				float4 x = ( x_ * 2.0 + 0.5 ) / 7.0 - 1.0;
				float4 y = ( y_ * 2.0 + 0.5 ) / 7.0 - 1.0;
				float4 h = 1.0 - abs( x ) - abs( y );
				float4 b0 = float4( x.xy, y.xy );
				float4 b1 = float4( x.zw, y.zw );
				float4 s0 = floor( b0 ) * 2.0 + 1.0;
				float4 s1 = floor( b1 ) * 2.0 + 1.0;
				float4 sh = -step( h, 0.0 );
				float4 a0 = b0.xzyw + s0.xzyw * sh.xxyy;
				float4 a1 = b1.xzyw + s1.xzyw * sh.zzww;
				float3 g0 = float3( a0.xy, h.x );
				float3 g1 = float3( a0.zw, h.y );
				float3 g2 = float3( a1.xy, h.z );
				float3 g3 = float3( a1.zw, h.w );
				float4 norm = taylorInvSqrt( float4( dot( g0, g0 ), dot( g1, g1 ), dot( g2, g2 ), dot( g3, g3 ) ) );
				g0 *= norm.x;
				g1 *= norm.y;
				g2 *= norm.z;
				g3 *= norm.w;
				float4 m = max( 0.6 - float4( dot( x0, x0 ), dot( x1, x1 ), dot( x2, x2 ), dot( x3, x3 ) ), 0.0 );
				m = m* m;
				m = m* m;
				float4 px = float4( dot( x0, g0 ), dot( x1, g1 ), dot( x2, g2 ), dot( x3, g3 ) );
				return 42.0 * dot( m, px);
			}
			

			
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
				float4 staticSwitch13 = ase_screenPosNorm;
				#else
				float4 staticSwitch13 = float4( i.ase_texcoord.xyz , 0.0 );
				#endif
				float temp_output_8_0 = pow( saturate( ( ( _Shift + staticSwitch13.y ) * _Multiply ) ) , _Power );
				float mulTime44 = _Time.y * _NoiseMoveTimeX;
				float mulTime54 = _Time.y * _NoiseMoveTimeY;
				float mulTime57 = _Time.y * _NoiseMoveTimeZ;
				float3 appendResult60 = (float3(sin( mulTime44 ) , sin( mulTime54 ) , sin( mulTime57 )));
				float simplePerlin3D30 = snoise( ( (staticSwitch13).xyz + appendResult60 )*_NoiseScale );
				simplePerlin3D30 = simplePerlin3D30*0.5 + 0.5;
				float4 _Vector0 = float4(0,0,0,0);
				float4 _Vector1 = float4(1,1,1,1);
				#ifdef _BACKGROUNDNOISE_ON
				float staticSwitch40 = ( temp_output_8_0 + (_NoiseMin + (simplePerlin3D30 - _Vector0.x) * (_NoiseMax - _NoiseMin) / (_Vector1.x - _Vector0.x)) );
				#else
				float staticSwitch40 = temp_output_8_0;
				#endif
				float clampResult13_g30 = clamp( staticSwitch40 , 0.0 , 1.0 );
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
0;0;841;424.1111;1912.737;-826.5325;1;True;False
Node;AmplifyShaderEditor.PosVertexDataNode;11;-3135.424,-384.8597;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenPosInputsNode;2;-3136.133,-220.6816;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;56;-2227.056,846.7598;Inherit;False;Property;_NoiseMoveTimeY;Noise Move Time Y;12;0;Create;True;0;0;False;0;0.1;0.01;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-2214.84,773.4059;Inherit;False;Property;_NoiseMoveTimeX;Noise Move Time X;11;0;Create;True;0;0;False;0;0.1;0.015;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-2230.321,930.0705;Inherit;False;Property;_NoiseMoveTimeZ;Noise Move Time Z;13;0;Create;True;0;0;False;0;0.1;0.02;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;13;-2922.035,-308.2496;Inherit;False;Property;_Screenspace;Screen space;6;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleTimeNode;44;-1927.769,779.6735;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;54;-1939.984,853.0275;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;57;-1943.25,937.9717;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;41;-2193.931,-232.5573;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SinOpNode;53;-1744.931,780.2515;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;55;-1757.146,853.6053;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;58;-1760.413,938.5496;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-1436.503,-21.75778;Float;False;Property;_Shift;Shift;3;0;Create;True;0;0;False;0;0;0.65;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1144.179,383.5748;Float;False;Property;_Multiply;Multiply;4;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;26;-1037.749,233.9615;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;60;-1526.399,774.3752;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode;43;-1382.321,655.8669;Inherit;False;FLOAT3;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-858.6205,230.0105;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;45;-1112.67,784.3508;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-1477.026,927.5474;Inherit;False;Property;_NoiseScale;Noise Scale;8;0;Create;True;0;0;False;0;1;71;0;256;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;9;-678.9878,230.4254;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-1453.124,1119.461;Inherit;False;Property;_NoiseMax;Noise Max;10;0;Create;True;0;0;False;0;0.1;0.05;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-1456.648,1037.077;Inherit;False;Property;_NoiseMin;Noise Min;9;0;Create;True;0;0;False;0;-0.1;-0.05;-1;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1040.953,498.0644;Float;False;Property;_Power;Power;5;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;30;-973.1796,816.5485;Inherit;False;Simplex3D;True;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;8;-490.4028,222.0851;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;32;-726.9318,910.8288;Inherit;False;Remap From 0-1;-1;;103;e64dd7a39884fcf479ce6585a25254a4;0;3;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;35;-185.3547,399.5748;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;218.5602,-95.23203;Float;False;Property;_Top;Top;0;0;Create;True;0;0;False;0;1,1,1,1;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;40;56.60063,246.1591;Inherit;False;Property;_BackgroundNoise;Background Noise;7;0;Create;True;0;0;False;0;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;5;230.553,-514.8234;Float;False;Property;_Bottom;Bottom;2;0;Create;True;0;0;False;0;0,0,0,1;0.09999997,0.09999997,0.09999997,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;20;226.6559,-302.9915;Float;False;Property;_Middle;Middle;1;0;Create;True;0;0;False;0;1,0,0,1;0.04999998,0.04999998,0.04999998,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;22;804.3593,-297.5726;Inherit;False;Lerp 3;-1;;30;17ff52dfb094d4f4495896f316029fca;0;4;1;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;6;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;28;1283.632,-297.3143;Float;False;True;-1;2;ASEMaterialInspector;100;1;appalachia/gradient_skybox;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;True;False;True;0;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;0
WireConnection;13;1;11;0
WireConnection;13;0;2;0
WireConnection;44;0;48;0
WireConnection;54;0;56;0
WireConnection;57;0;59;0
WireConnection;41;0;13;0
WireConnection;53;0;44;0
WireConnection;55;0;54;0
WireConnection;58;0;57;0
WireConnection;26;0;25;0
WireConnection;26;1;41;1
WireConnection;60;0;53;0
WireConnection;60;1;55;0
WireConnection;60;2;58;0
WireConnection;43;0;13;0
WireConnection;6;0;26;0
WireConnection;6;1;7;0
WireConnection;45;0;43;0
WireConnection;45;1;60;0
WireConnection;9;0;6;0
WireConnection;30;0;45;0
WireConnection;30;1;36;0
WireConnection;8;0;9;0
WireConnection;8;1;10;0
WireConnection;32;6;30;0
WireConnection;32;7;37;0
WireConnection;32;8;38;0
WireConnection;35;0;8;0
WireConnection;35;1;32;0
WireConnection;40;1;8;0
WireConnection;40;0;35;0
WireConnection;22;1;5;0
WireConnection;22;3;20;0
WireConnection;22;4;4;0
WireConnection;22;6;40;0
WireConnection;28;0;22;0
ASEEND*/
//CHKSM=B60E67489C3DFA48FAEA937C8B0C8C8ACF5A65D2