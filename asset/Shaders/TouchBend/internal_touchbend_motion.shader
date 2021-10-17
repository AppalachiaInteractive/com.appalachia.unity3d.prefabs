// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "appalachia/touchbend_motion"
{
	Properties
	{
		_MainTex("_MainTex", 2D) = "black" {}
		_MOTION_DECAY("_MOTION_DECAY", Range( 0 , 1)) = 0.8488235
		_MOTION_CUTOFF("_MOTION_CUTOFF", Range( 0 , 0.1)) = 0.8488235
		_MOTION_UV_OFFSET("_MOTION_UV_OFFSET", Vector) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" "Queue"="Overlay" }
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

			uniform sampler2D _TOUCHBEND_CURRENT_STATE_MAP_MASK;
			uniform float4 _TOUCHBEND_CURRENT_STATE_MAP_MASK_ST;
			uniform sampler2D _MainTex;
			uniform float2 _MOTION_UV_OFFSET;
			uniform float _MOTION_CUTOFF;
			uniform float _MOTION_DECAY;

			
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
				float2 uv_TOUCHBEND_CURRENT_STATE_MAP_MASK = i.ase_texcoord.xy * _TOUCHBEND_CURRENT_STATE_MAP_MASK_ST.xy + _TOUCHBEND_CURRENT_STATE_MAP_MASK_ST.zw;
				float4 tex2DNode208 = tex2D( _TOUCHBEND_CURRENT_STATE_MAP_MASK, uv_TOUCHBEND_CURRENT_STATE_MAP_MASK );
				float2 uv0230 = i.ase_texcoord.xy * float2( 1,1 ) + -_MOTION_UV_OFFSET;
				float4 tex2DNode214 = tex2D( _MainTex, uv0230 );
				float2 break11_g11 = uv0230;
				float clampResult3_g12 = clamp( break11_g11.x , 0.0 , 1.0 );
				float clampResult3_g14 = clamp( break11_g11.y , 0.0 , 1.0 );
				float lerpResult8_g11 = lerp( _MOTION_DECAY , 0.99 , max( abs( ( ( clampResult3_g12 * 2.0 ) - 1.0 ) ) , abs( ( ( clampResult3_g14 * 2.0 ) - 1.0 ) ) ));
				float temp_output_304_0 = lerpResult8_g11;
				float temp_output_222_0 = (( tex2DNode214.r < _MOTION_CUTOFF ) ? 0.0 :  ( temp_output_304_0 * tex2DNode214.r ) );
				float temp_output_2_0_g2 = temp_output_222_0;
				float temp_output_3_0_g2 = 0.0;
				float temp_output_21_0_g2 = 1.0;
				float temp_output_26_0_g2 = 0.0;
				float temp_output_289_0 = (( tex2DNode214.g < _MOTION_CUTOFF ) ? 0.0 :  ( temp_output_304_0 * tex2DNode214.g ) );
				float2 appendResult241 = (float2(saturate( ( tex2DNode208.r + temp_output_222_0 ) ) , saturate( ( saturate( (( temp_output_2_0_g2 > temp_output_3_0_g2 ) ? temp_output_21_0_g2 :  temp_output_26_0_g2 ) ) * ( tex2DNode208.g + temp_output_289_0 ) ) )));
				
				
				finalColor = float4( appendResult241, 0.0 , 0.0 );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=17500
-6.666667;64;1267;649;-4515.045;-794.1077;1;True;False
Node;AmplifyShaderEditor.Vector2Node;232;4125.437,1911.288;Inherit;False;Property;_MOTION_UV_OFFSET;_MOTION_UV_OFFSET;4;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.NegateNode;233;4386.437,1910.288;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;230;4582,1812;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;217;5020.716,1899.105;Inherit;False;Property;_MOTION_DECAY;_MOTION_DECAY;2;0;Create;True;0;0;False;0;0.8488235;0.97;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;303;5111.525,1975.708;Inherit;False;Constant;_Float0;Float 0;5;0;Create;True;0;0;False;0;0.99;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;305;5251.583,1856.101;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;215;4736,1536;Inherit;True;Property;_MainTex;_MainTex;0;0;Create;True;0;0;False;0;None;;False;black;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FunctionNode;304;5316.658,1873.428;Inherit;False;UV Edge Lerp;-1;;11;006e8913aa6d88a4ca02ad95649ce729;0;3;10;FLOAT2;0,0;False;12;FLOAT;0;False;13;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;214;5120,1536;Inherit;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;223;5248,1280;Inherit;False;Property;_MOTION_CUTOFF;_MOTION_CUTOFF;3;0;Create;True;0;0;False;0;0.8488235;0.01;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;216;4736,1024;Inherit;True;Global;_TOUCHBEND_CURRENT_STATE_MAP_MASK;_TOUCHBEND_CURRENT_STATE_MAP_MASK;1;0;Create;True;0;0;False;0;None;;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WireNode;295;5644.145,1475.615;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;296;5636.145,1410.615;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;208;5246,1026;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;210;5712,1360;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;240;5663.701,1343.397;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;290;5719,1490;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareLower;289;5888,1424;Inherit;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;283;6423.849,1388.53;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareLower;222;5888,1280;Inherit;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;286;6745.67,1370.003;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;246;6384,1008;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;263;6405.304,1271.733;Inherit;False;Step (Adv);-1;;2;d57ef49c9f3c4a3409480b2c421b3f99;1,13,2;2;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;19
Node;AmplifyShaderEditor.SimpleAddOpNode;227;6656,896;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;243;7040,1280;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;266;6784,896;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;267;7221.901,1278.7;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;292;6784,1024;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;241;7744,896;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;248;7503.4,1674.6;Inherit;False;Constant;_Float9;Float 9;5;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;293;6384,1136;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;291;6656,1024;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;77;7936,896;Float;False;True;-1;2;ASEMaterialInspector;100;1;appalachia/touchbend_motion;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;0;1;False;-1;1;False;-1;0;0;False;-1;0;False;-1;True;0;False;-1;0;False;-1;True;False;True;2;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;0;False;-1;True;0;False;-1;True;False;0;False;-1;0;False;-1;True;2;RenderType=Opaque=RenderType;Queue=Overlay=Queue=0;True;2;0;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;0
WireConnection;233;0;232;0
WireConnection;230;1;233;0
WireConnection;305;0;230;0
WireConnection;304;10;305;0
WireConnection;304;12;217;0
WireConnection;304;13;303;0
WireConnection;214;0;215;0
WireConnection;214;1;230;0
WireConnection;295;0;214;2
WireConnection;296;0;223;0
WireConnection;208;0;216;0
WireConnection;210;0;304;0
WireConnection;210;1;214;1
WireConnection;240;0;214;1
WireConnection;290;0;304;0
WireConnection;290;1;214;2
WireConnection;289;0;295;0
WireConnection;289;1;296;0
WireConnection;289;3;290;0
WireConnection;283;0;208;2
WireConnection;222;0;240;0
WireConnection;222;1;223;0
WireConnection;222;3;210;0
WireConnection;286;0;283;0
WireConnection;286;1;289;0
WireConnection;246;0;222;0
WireConnection;263;2;222;0
WireConnection;227;0;208;1
WireConnection;227;1;246;0
WireConnection;243;0;263;19
WireConnection;243;1;286;0
WireConnection;266;0;227;0
WireConnection;267;0;243;0
WireConnection;292;0;291;0
WireConnection;241;0;266;0
WireConnection;241;1;267;0
WireConnection;293;0;289;0
WireConnection;291;0;208;2
WireConnection;291;1;293;0
WireConnection;77;0;241;0
ASEEND*/
//CHKSM=31BF5AB8FDDC3FAC5724E30F7E5CD2AE570E14CB