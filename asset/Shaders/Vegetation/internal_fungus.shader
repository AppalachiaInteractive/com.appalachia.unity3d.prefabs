// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "internal/fungus"
{
	Properties
	{
		[InternalBanner(Internal, Plant)]_BANNER("BANNER", Float) = 1
		[InternalCategory(Rendering)]_RENDERINGG("[ RENDERINGG ]", Float) = 0
		[Enum(Two Sided,0,Back,1,Front,2)]_RenderFaces("Render Faces", Float) = 0
		_Cutoff("Cutout", Range( 0 , 1)) = 0.5
		[InternalCategory(Main)]_MAINN("[ MAINN ]", Float) = 0
		_MainTex("Plant Albedo", 2D) = "white" {}
		_Color("Plant Color", Color) = (1,1,1,1)
		_BumpMap("Plant Normal", 2D) = "white" {}
		_NormalScale("Plant Normal Scale", Float) = 1
		_Float6("Plant AO (G)", Range( 0 , 1)) = 1
		_Smoothness("Plant Smoothness (A)", Range( 0 , 1)) = 1
		_MetallicGlossMap("Plant Surface", 2D) = "white" {}
		[InternalCategory(Settings)]_SETTINGS("[ SETTINGS ]", Float) = 0
		[InternalCategory(Advanced)]_ADVANCEDD("[ ADVANCEDD ]", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" "DisableBatching" = "True" }
		LOD 300
		Cull [_RenderFaces]
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 4.0
		#pragma multi_compile_instancing
		 
		// INTERNAL_SHADER_FEATURE_START
		// INTERNAL_SHADER_FEATURE_END
		  
		#pragma exclude_renderers gles vulkan 
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
			half ASEVFace : VFACE;
		};

		uniform half _ADVANCEDD;
		uniform half _SETTINGS;
		uniform half _RENDERINGG;
		uniform half _Cutoff;
		uniform half _RenderFaces;
		uniform half _BANNER;
		uniform half _MAINN;
		uniform half _NormalScale;
		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform half4 _Color;
		uniform sampler2D _MetallicGlossMap;
		uniform float4 _MetallicGlossMap_ST;
		uniform half _Smoothness;
		uniform half _Float6;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 temp_output_41_0_g6020 = float3(0,0,0);
			float3 temp_cast_0 = (0.0).xxx;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float temp_output_63_0_g6021 = (( unity_LODFade.x >= 1E-05 && unity_LODFade.x <= 0.99999 ) ? unity_LODFade.x :  1.0 );
			float3 lerpResult57_g6021 = lerp( temp_cast_0 , -ase_vertex3Pos , ( 1.0 - temp_output_63_0_g6021 ));
			#ifdef INTERNAL_LODFADE_SCALE
				float3 staticSwitch58_g6020 = lerpResult57_g6021;
			#else
				float3 staticSwitch58_g6020 = temp_output_41_0_g6020;
			#endif
			#ifdef LOD_FADE_CROSSFADE
				float3 staticSwitch62_g6020 = staticSwitch58_g6020;
			#else
				float3 staticSwitch62_g6020 = temp_output_41_0_g6020;
			#endif
			v.vertex.xyz += staticSwitch62_g6020;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float3 break17_g2122 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap ), _NormalScale );
			float switchResult12_g2122 = (((i.ASEVFace>0)?(break17_g2122.z):(-break17_g2122.z)));
			float3 appendResult18_g2122 = (float3(break17_g2122.x , break17_g2122.y , switchResult12_g2122));
			half3 MainBumpMap620 = appendResult18_g2122;
			o.Normal = MainBumpMap620;
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode1258 = tex2D( _MainTex, uv_MainTex );
			half4 Main_MainTex487 = tex2DNode1258;
			half4 Main_Color486 = _Color;
			o.Albedo = saturate( ( Main_MainTex487 * Main_Color486 ) ).rgb;
			float2 uv_MetallicGlossMap = i.uv_texcoord * _MetallicGlossMap_ST.xy + _MetallicGlossMap_ST.zw;
			float4 tex2DNode1260 = tex2D( _MetallicGlossMap, uv_MetallicGlossMap );
			half Main_MetallicGlossMap_A744 = tex2DNode1260.a;
			half OUT_SMOOTHNESS660 = ( Main_MetallicGlossMap_A744 * _Smoothness );
			o.Smoothness = OUT_SMOOTHNESS660;
			half Main_MetallicGlossMap_G1261 = tex2DNode1260.g;
			half OUT_AO1266 = ( _Float6 * Main_MetallicGlossMap_G1261 );
			o.Occlusion = OUT_AO1266;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Utils/ADS Fallback"
	CustomEditor "ADSShaderGUI"
}
/*ASEBEGIN
Version=17500
0;-864;1536;843;1913.315;2125.347;1;True;False
Node;AmplifyShaderEditor.SamplerNode;1260;1197.172,-883.2394;Inherit;True;Property;_MetallicGlossMap;Plant Surface;11;0;Create;False;0;0;False;0;-1;None;51d1c3f6ec9fd964a82bf68e95c81991;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1258;-1320.405,-869.6622;Inherit;True;Property;_MainTex;Plant Albedo;5;0;Create;False;0;0;False;0;-1;None;efe9ba740dce8614cb7e9d6ac712e5d1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;409;-592,-896;Half;False;Property;_Color;Plant Color;6;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1261;1552,-880;Half;False;Main_MetallicGlossMap_G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;655;0,-896;Half;False;Property;_NormalScale;Plant Normal Scale;8;0;Create;False;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;744;1543,-722;Half;False;Main_MetallicGlossMap_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1262;1920,-704;Half;False;Property;_Float6;Plant AO (G);9;0;Create;False;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;-336,-896;Half;False;Main_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;749;1920,-896;Inherit;False;744;Main_MetallicGlossMap_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1265;1920,-624;Inherit;False;1261;Main_MetallicGlossMap_G;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1259;241.5953,-904.6622;Inherit;True;Property;_BumpMap;Plant Normal;7;0;Create;False;0;0;False;0;-1;None;14638357db41fb94fa7dc603772cd2a2;True;0;True;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;294;1920,-817;Half;False;Property;_Smoothness;Plant Smoothness (A);10;0;Create;False;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;-976,-896;Half;False;Main_MainTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1083;-1281.307,-2304.148;Inherit;False;486;Main_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;36;-1281.307,-2368.148;Inherit;False;487;Main_MainTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1231;592,-896;Inherit;False;Normal BackFace;-1;;2122;121446c878db06f4c847f9c5afed7cfe;0;1;13;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1264;2224,-672;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;616;-976,-768;Half;False;Main_MainTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;745;2238,-896;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1074;-769.3071,-2368.148;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;620;832,-896;Half;False;MainBumpMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1266;2432,-704;Half;False;OUT_AO;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;660;2400,-896;Half;False;OUT_SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;791;-1422.255,-1722.032;Inherit;False;616;Main_MainTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1112;264.4814,-2252.256;Inherit;False;317.573;603.8616;Drawers;6;1275;1118;1116;1115;1113;1119;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;743;264.4814,-1356.256;Half;False;Property;_RenderFaces;Render Faces;2;1;[Enum];Create;True;3;Two Sided;0;Back;1;Front;2;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1230;1545,-806;Half;False;Main_MetallicGlossMap_B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareGreater;1268;-608.6682,-1827.791;Inherit;False;4;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1267;-1267.607,-2068.884;Inherit;False;1266;OUT_AO;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1109;-577.3071,-2368.148;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1115;296.4815,-1996.256;Half;False;Property;_MAINN;[ MAINN ];4;0;Create;True;0;0;True;1;InternalCategory(Main);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1275;296.4815,-1724.256;Inherit;False;Internal Features Support;-1;;6032;3c493d142aeebd840af72d626f6915c6;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1119;296.4815,-2188.256;Half;False;Property;_BANNER;BANNER;0;0;Create;True;0;0;True;1;InternalBanner(Internal, Plant);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;862;461.4816,-1356.256;Half;False;Property;_Cutoff;Cutout;3;0;Create;False;3;Off;0;Front;1;Back;2;0;True;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1116;296.4815,-1900.256;Half;False;Property;_SETTINGS;[ SETTINGS ];12;0;Create;True;0;0;True;1;InternalCategory(Settings);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1113;296.4815,-2092.256;Half;False;Property;_RENDERINGG;[ RENDERINGG ];1;0;Create;True;0;0;True;1;InternalCategory(Rendering);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1118;296.4815,-1804.256;Half;False;Property;_ADVANCEDD;[ ADVANCEDD ];14;0;Create;True;0;0;True;1;InternalCategory(Advanced);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1274;-1023.365,-1698.558;Inherit;False;Execute LOD Fade;-1;;2224;18ea34bd83a0d6c4db425672111543e6;0;2;41;FLOAT;0;False;58;FLOAT3;0,0,0;False;3;FLOAT;0;FLOAT3;91;FLOAT;96
Node;AmplifyShaderEditor.GetLocalVarNode;624;-1304.607,-2216.884;Inherit;False;620;MainBumpMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1269;-1070.187,-1842.002;Inherit;False;Property;_Invisible;Invisible;13;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;654;-1304.607,-2136.884;Inherit;False;660;OUT_SMOOTHNESS;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-128,-2048;Float;False;True;-1;4;ADSShaderGUI;300;0;Standard;internal/fungus;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;False;True;False;False;False;True;Off;0;False;925;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;12;d3d9;d3d11_9x;d3d11;glcore;gles3;metal;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;550;10;False;553;0;1;False;550;10;False;553;0;True;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;300;Utils/ADS Fallback;-1;-1;-1;-1;0;False;0;0;True;743;-1;0;True;862;0;0;0;False;0.1;False;-1;0;False;-1;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;14;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;708;0,-1024;Inherit;False;1024.6;100;Normal Texture;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;760;-1280,-1024;Inherit;False;1152.612;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;715;1152,-1024;Inherit;False;1473.26;100;Surface Input;0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;683;264.4814,-1484.256;Inherit;False;417.3682;100;Rendering And Settings;0;;1,0,0.503,1;0;0
WireConnection;1261;0;1260;2
WireConnection;744;0;1260;4
WireConnection;486;0;409;0
WireConnection;1259;5;655;0
WireConnection;487;0;1258;0
WireConnection;1231;13;1259;0
WireConnection;1264;0;1262;0
WireConnection;1264;1;1265;0
WireConnection;616;0;1258;4
WireConnection;745;0;749;0
WireConnection;745;1;294;0
WireConnection;1074;0;36;0
WireConnection;1074;1;1083;0
WireConnection;620;0;1231;0
WireConnection;1266;0;1264;0
WireConnection;660;0;745;0
WireConnection;1230;0;1260;3
WireConnection;1268;0;1269;0
WireConnection;1268;3;1274;0
WireConnection;1109;0;1074;0
WireConnection;1274;41;791;0
WireConnection;0;0;1109;0
WireConnection;0;1;624;0
WireConnection;0;4;654;0
WireConnection;0;5;1267;0
WireConnection;0;11;1274;91
ASEEND*/
//CHKSM=715785B52B9308382BBD25EF99840ADA2DD9C9C3