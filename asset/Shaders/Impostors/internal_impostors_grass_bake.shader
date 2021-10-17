// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "appalachia/impostors/grass-bake"
{
	Properties
	{
		[NoScaleOffset]_MainTex("Grass Albedo", 2D) = "white" {}
		_NormalScale("Grass Normal Scale", Float) = 1
		[NoScaleOffset]BumpMap("Grass Normal", 2D) = "bump" {}
		[NoScaleOffset]_MetallicGlossMap("Grass Surface", 2D) = "white" {}
		_Cutoff("_Cutoff", Float) = 0.3
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}

	SubShader
	{
		Tags { "RenderType"="TransparentCutout" "Queue"="AlphaTest" "IgnoreProjector"="True" }
	LOD 100
		CGINCLUDE
		#pragma target 4.0
		ENDCG
		Cull Off
		

		Pass
		{
			Name "Unlit"
			CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#pragma multi_compile_fwdbase
			#include "UnityStandardUtils.cginc"
			#include "UnityShaderVariables.cginc"


			struct appdata
			{
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_tangent : TANGENT;
				float3 ase_normal : NORMAL;
			};

			struct v2f
			{
				UNITY_POSITION(pos);
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
			};

			uniform sampler2D _MainTex;
			uniform half _NormalScale;
			uniform sampler2D BumpMap;
			uniform sampler2D _MetallicGlossMap;
			uniform float _Cutoff;


			v2f vert(appdata v )
			{
				v2f o = (v2f)0;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				float3 ase_worldTangent = UnityObjectToWorldDir(v.ase_tangent);
				o.ase_texcoord1.xyz = ase_worldTangent;
				float3 ase_worldNormal = UnityObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord2.xyz = ase_worldNormal;
				float ase_vertexTangentSign = v.ase_tangent.w * unity_WorldTransformParams.w;
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord3.xyz = ase_worldBitangent;
				float3 objectToViewPos = UnityObjectToViewPos(v.vertex.xyz);
				float eyeDepth = -objectToViewPos.z;
				o.ase_texcoord.z = eyeDepth;
				
				o.ase_texcoord.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.w = 0;
				o.ase_texcoord1.w = 0;
				o.ase_texcoord2.w = 0;
				o.ase_texcoord3.w = 0;

				v.vertex.xyz +=  float3(0,0,0) ;
				o.pos = UnityObjectToClipPos(v.vertex);
				return o;
			}


			void frag(v2f i ,
				out half4 outGBuffer0 : SV_Target0, 
				out half4 outGBuffer1 : SV_Target1, 
				out half4 outGBuffer2 : SV_Target2, 
				out half4 outGBuffer3 : SV_Target3,
				out half4 outGBuffer4 : SV_Target4,
				out half4 outGBuffer5 : SV_Target5,
				out half4 outGBuffer6 : SV_Target6,
				out half4 outGBuffer7 : SV_Target7,
				out float outDepth : SV_Depth
			) 
			{
				UNITY_SETUP_INSTANCE_ID( i );
				float2 uv_MainTex18 = i.ase_texcoord.xy;
				float4 tex2DNode18 = tex2D( _MainTex, uv_MainTex18 );
				half3 Main_MainTex487 = (tex2DNode18).rgb;
				half OPACITY616 = saturate( ( tex2DNode18.a * 10.0 ) );
				float4 appendResult1376 = (float4(saturate( Main_MainTex487 ) , OPACITY616));
				
				float2 uvBumpMap607 = i.ase_texcoord.xy;
				half3 MainBumpMap620 = UnpackScaleNormal( tex2D( BumpMap, uvBumpMap607 ), _NormalScale );
				float3 ase_worldTangent = i.ase_texcoord1.xyz;
				float3 ase_worldNormal = i.ase_texcoord2.xyz;
				float3 ase_worldBitangent = i.ase_texcoord3.xyz;
				float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				float3 tanNormal8_g7071 = MainBumpMap620;
				float3 worldNormal8_g7071 = float3(dot(tanToWorld0,tanNormal8_g7071), dot(tanToWorld1,tanNormal8_g7071), dot(tanToWorld2,tanNormal8_g7071));
				float eyeDepth = i.ase_texcoord.z;
				float temp_output_4_0_g7071 = ( -1.0 / UNITY_MATRIX_P[2].z );
				float temp_output_7_0_g7071 = ( ( eyeDepth + temp_output_4_0_g7071 ) / temp_output_4_0_g7071 );
				float4 appendResult11_g7071 = (float4((worldNormal8_g7071*0.5 + 0.5) , temp_output_7_0_g7071));
				
				float2 uv_MetallicGlossMap645 = i.ase_texcoord.xy;
				float4 tex2DNode645 = tex2D( _MetallicGlossMap, uv_MetallicGlossMap645 );
				half Main_MetallicGlossMap_G1287 = tex2DNode645.g;
				half Main_MetallicGlossMap_B1271 = tex2DNode645.b;
				half Main_MetallicGlossMap_A744 = tex2DNode645.a;
				float4 appendResult1371 = (float4(0.0 , Main_MetallicGlossMap_G1287 , Main_MetallicGlossMap_B1271 , Main_MetallicGlossMap_A744));
				

				outGBuffer0 = appendResult1376;
				outGBuffer1 = appendResult11_g7071;
				outGBuffer2 = appendResult1371;
				outGBuffer3 = 0;
				outGBuffer4 = 0;
				outGBuffer5 = 0;
				outGBuffer6 = 0;
				outGBuffer7 = 0;
				float alpha = ( OPACITY616 - _Cutoff );
				clip( alpha );
				outDepth = i.pos.z;
			}
			ENDCG
		}
	}
	
	CustomEditor "ASEMaterialInspector"
	
}
/*ASEBEGIN
Version=17500
118.4;-782.4;1268;647;1008.509;2392.232;1;True;False
Node;AmplifyShaderEditor.SamplerNode;18;-2280.5,-1184.51;Inherit;True;Property;_MainTex;Grass Albedo;0;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;9bf68c6e5059e7549b60e91ca11987a6;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1381;-1789.699,-641.8911;Inherit;False;Constant;_Float9;Float 9;47;0;Create;True;0;0;False;0;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;655;-1402.849,-1113.236;Half;False;Property;_NormalScale;Grass Normal Scale;1;0;Create;False;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;1323;-1971.449,-1176.701;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1379;-1536,-640;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1378;-1376,-640;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;645;-253.849,-1176.236;Inherit;True;Property;_MetallicGlossMap;Grass Surface;3;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;e9a1c1b060b9b2c4989233f1037f9d5d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;607;-1149.849,-1176.236;Inherit;True;Property;BumpMap;Grass Normal;2;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;9a1568052101f2f48ba76e7342adc3f3;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;-1754.501,-1183.51;Half;False;Main_MainTex;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;744;139.1511,-976.2358;Half;False;Main_MetallicGlossMap_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;620;-573.8489,-1176.236;Half;False;MainBumpMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1271;132.2021,-1066.185;Half;False;Main_MetallicGlossMap_B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;616;-1152,-640;Half;False;OPACITY;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;36;-834.1917,-2632.91;Inherit;False;487;Main_MainTex;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1287;111.397,-1153.43;Half;False;Main_MetallicGlossMap_G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1385;-760.3865,-2000.372;Inherit;False;616;OPACITY;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1377;-740.3887,-1845.304;Inherit;False;Property;_Cutoff;_Cutoff;4;0;Create;True;0;0;False;0;0.3;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;624;-1321.085,-2596.524;Inherit;False;620;MainBumpMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1374;-1320.573,-2052.238;Inherit;False;1287;Main_MetallicGlossMap_G;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1109;-583.392,-2615.51;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;749;-1314.066,-1851.753;Inherit;False;744;Main_MetallicGlossMap_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1375;-744.1432,-2528.132;Inherit;False;616;OPACITY;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1267;-1320.568,-1940.684;Inherit;False;1271;Main_MetallicGlossMap_B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1371;-602.124,-2296.435;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;1383;-873.9198,-2424.423;Inherit;False;Pack Normal Depth;-1;;7071;8e386dbec347c9f44befea8ff816d188;0;1;12;FLOAT3;0,0,0;False;3;FLOAT4;0;FLOAT3;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;1376;-399.8208,-2501.284;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;1273;-817.849,-1089.736;Inherit;False;Normal BackFace;-1;;7068;121446c878db06f4c847f9c5afed7cfe;0;1;13;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1386;-542.0484,-2006.778;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1370;-135.392,-2406.51;Float;False;True;-1;2;ASEMaterialInspector;100;9;appalachia/impostors/grass-bake;f53051a8190f7044fa936bd7fbe116c1;True;Unlit;0;0;Unlit;10;False;False;False;True;2;False;-1;False;False;False;False;False;True;3;RenderType=TransparentCutout=RenderType;Queue=AlphaTest=Queue=0;IgnoreProjector=True;True;4;0;False;False;False;False;False;False;False;False;False;False;False;0;;0;0;Standard;0;0;1;True;False;;0
Node;AmplifyShaderEditor.CommentaryNode;760;-2292.742,-1340.294;Inherit;False;753.6121;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;715;-253.849,-1304.236;Inherit;False;658.1602;100;Surface Input;0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;708;-1405.849,-1304.236;Inherit;False;1024.6;100;Normal Texture;0;;0,0.751724,1,1;0;0
WireConnection;1323;0;18;0
WireConnection;1379;0;18;4
WireConnection;1379;1;1381;0
WireConnection;1378;0;1379;0
WireConnection;607;5;655;0
WireConnection;487;0;1323;0
WireConnection;744;0;645;4
WireConnection;620;0;607;0
WireConnection;1271;0;645;3
WireConnection;616;0;1378;0
WireConnection;1287;0;645;2
WireConnection;1109;0;36;0
WireConnection;1371;1;1374;0
WireConnection;1371;2;1267;0
WireConnection;1371;3;749;0
WireConnection;1383;12;624;0
WireConnection;1376;0;1109;0
WireConnection;1376;3;1375;0
WireConnection;1386;0;1385;0
WireConnection;1386;1;1377;0
WireConnection;1370;0;1376;0
WireConnection;1370;1;1383;0
WireConnection;1370;2;1371;0
WireConnection;1370;8;1386;0
ASEEND*/
//CHKSM=F01EB2090CB96DC18D87E4BB6942776FF1A5DAB9