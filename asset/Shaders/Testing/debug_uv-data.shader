// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "internal/debugging/debug_uv-data"
{
	Properties
	{
		[KeywordEnum(UV1,UV2,UV3,UV4,UV5,UV6,UV7,UV8)] _DebugUVChannel("DebugUVChannel", Float) = 0
		[KeywordEnum(RCutoff,GCutoff,BCutoff,ACutoff,RGBA,R,G,B,A)] _DebugUVComponent("DebugUVComponent", Float) = 0
		_UVHighlightCutoff("UV Highlight Cutoff", Float) = 0
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord3( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord4( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.5
		#pragma shader_feature_local _DEBUGUVCOMPONENT_RCUTOFF _DEBUGUVCOMPONENT_GCUTOFF _DEBUGUVCOMPONENT_BCUTOFF _DEBUGUVCOMPONENT_ACUTOFF _DEBUGUVCOMPONENT_RGBA _DEBUGUVCOMPONENT_R _DEBUGUVCOMPONENT_G _DEBUGUVCOMPONENT_B _DEBUGUVCOMPONENT_A
		#pragma shader_feature_local _DEBUGUVCHANNEL_UV1 _DEBUGUVCHANNEL_UV2 _DEBUGUVCHANNEL_UV3 _DEBUGUVCHANNEL_UV4 _DEBUGUVCHANNEL_UV5 _DEBUGUVCHANNEL_UV6 _DEBUGUVCHANNEL_UV7 _DEBUGUVCHANNEL_UV8
		#pragma surface surf Standard keepalpha noshadow vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)

		struct appdata_full_custom
		{
			float4 vertex : POSITION;
			float4 tangent : TANGENT;
			float3 normal : NORMAL;
			float4 texcoord : TEXCOORD0;
			float4 texcoord1 : TEXCOORD1;
			float4 texcoord2 : TEXCOORD2;
			float4 texcoord3 : TEXCOORD3;
			fixed4 color : COLOR;
			UNITY_VERTEX_INPUT_INSTANCE_ID
			float4 ase_texcoord4 : TEXCOORD4;
			float4 ase_texcoord5 : TEXCOORD5;
			float4 ase_texcoord6 : TEXCOORD6;
			float4 ase_texcoord7 : TEXCOORD7;
		};
		struct Input
		{
			float4 uv_tex4coord;
			float4 uv2_tex4coord2;
			float4 uv3_tex4coord3;
			float4 uv4_tex4coord4;
			float4 ase_texcoord4;
			float4 ase_texcoord5;
			float4 ase_texcoord6;
			float4 ase_texcoord7;
		};

		uniform float _UVHighlightCutoff;

		void vertexDataFunc( inout appdata_full_custom v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.ase_texcoord4 = v.ase_texcoord4;
			o.ase_texcoord5 = v.ase_texcoord5;
			o.ase_texcoord6 = v.ase_texcoord6;
			o.ase_texcoord7 = v.ase_texcoord7;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			#if defined(_DEBUGUVCHANNEL_UV1)
				float4 staticSwitch11 = i.uv_tex4coord;
			#elif defined(_DEBUGUVCHANNEL_UV2)
				float4 staticSwitch11 = i.uv2_tex4coord2;
			#elif defined(_DEBUGUVCHANNEL_UV3)
				float4 staticSwitch11 = i.uv3_tex4coord3;
			#elif defined(_DEBUGUVCHANNEL_UV4)
				float4 staticSwitch11 = i.uv4_tex4coord4;
			#elif defined(_DEBUGUVCHANNEL_UV5)
				float4 staticSwitch11 = i.ase_texcoord4;
			#elif defined(_DEBUGUVCHANNEL_UV6)
				float4 staticSwitch11 = i.ase_texcoord5;
			#elif defined(_DEBUGUVCHANNEL_UV7)
				float4 staticSwitch11 = i.ase_texcoord6;
			#elif defined(_DEBUGUVCHANNEL_UV8)
				float4 staticSwitch11 = i.ase_texcoord7;
			#else
				float4 staticSwitch11 = i.uv_tex4coord;
			#endif
			float4 break47 = staticSwitch11;
			float4 temp_cast_0 = ((( break47.x > _UVHighlightCutoff ) ? 1.0 :  0.0 )).xxxx;
			float4 temp_cast_1 = ((( break47.x > _UVHighlightCutoff ) ? 1.0 :  0.0 )).xxxx;
			float4 temp_cast_2 = ((( break47.y > _UVHighlightCutoff ) ? 1.0 :  0.0 )).xxxx;
			float4 temp_cast_3 = ((( break47.z > _UVHighlightCutoff ) ? 1.0 :  0.0 )).xxxx;
			float4 temp_cast_4 = ((( break47.w > _UVHighlightCutoff ) ? 1.0 :  0.0 )).xxxx;
			float4 break17 = staticSwitch11;
			#if defined(_DEBUGUVCOMPONENT_RCUTOFF)
				float4 staticSwitch33 = temp_cast_0;
			#elif defined(_DEBUGUVCOMPONENT_GCUTOFF)
				float4 staticSwitch33 = temp_cast_2;
			#elif defined(_DEBUGUVCOMPONENT_BCUTOFF)
				float4 staticSwitch33 = temp_cast_3;
			#elif defined(_DEBUGUVCOMPONENT_ACUTOFF)
				float4 staticSwitch33 = temp_cast_4;
			#elif defined(_DEBUGUVCOMPONENT_RGBA)
				float4 staticSwitch33 = staticSwitch11;
			#elif defined(_DEBUGUVCOMPONENT_R)
				float4 staticSwitch33 = (break17.x).xxxx;
			#elif defined(_DEBUGUVCOMPONENT_G)
				float4 staticSwitch33 = (break17.y).xxxx;
			#elif defined(_DEBUGUVCOMPONENT_B)
				float4 staticSwitch33 = (break17.z).xxxx;
			#elif defined(_DEBUGUVCOMPONENT_A)
				float4 staticSwitch33 = (break17.w).xxxx;
			#else
				float4 staticSwitch33 = temp_cast_0;
			#endif
			o.Albedo = staticSwitch33.xyz;
			o.Emission = staticSwitch33.xyz;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17000
0;-790.4;936;480;5173.567;707.8561;3.135366;True;False
Node;AmplifyShaderEditor.TexCoordVertexDataNode;10;-4187.427,520.3239;Float;False;6;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;9;-4182.227,352.1237;Float;False;5;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;8;-4182.227,0.1247392;Float;False;3;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;7;-4182.227,704.124;Float;False;7;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;5;-4181.552,-518.9092;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;4;-4182.227,-335.8752;Float;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;3;-4182.227,176.1247;Float;False;4;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1;-4182.227,-175.8752;Float;False;2;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;11;-3694.954,20.96275;Float;False;Property;_DebugUVChannel;DebugUVChannel;0;0;Create;True;0;0;False;0;0;0;6;True;;KeywordEnum;8;UV1;UV2;UV3;UV4;UV5;UV6;UV7;UV8;Create;True;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;47;-3272.514,403.2573;Float;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;45;-3187.009,248.5039;Float;False;Property;_UVHighlightCutoff;UV Highlight Cutoff;2;0;Create;True;0;0;False;0;0;2.76;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;17;-3082.481,-261.3349;Float;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.TFHCCompareGreater;52;-2846.986,657.5891;Float;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;22;-2735.783,-198.6365;Float;False;FLOAT4;0;1;2;3;1;0;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SwizzleNode;26;-2735.783,-38.63646;Float;False;FLOAT4;0;1;2;3;1;0;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SwizzleNode;28;-2735.783,-118.6364;Float;False;FLOAT4;0;1;2;3;1;0;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TFHCCompareGreater;59;-2846.986,401.5891;Float;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareGreater;58;-2846.986,273.5891;Float;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareGreater;53;-2846.986,529.5891;Float;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;20;-2734.552,-284.7886;Float;False;FLOAT4;0;1;2;3;1;0;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;33;-2359.16,15.54411;Float;False;Property;_DebugUVComponent;DebugUVComponent;1;0;Create;True;0;0;False;0;0;0;4;True;;KeywordEnum;9;RCutoff;GCutoff;BCutoff;ACutoff;RGBA;R;G;B;A;Create;True;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-1919.19,-40.50513;Float;False;True;3;Float;ASEMaterialInspector;0;0;Standard;internal/Debugging/debug_uv-data;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;11;1;5;0
WireConnection;11;0;4;0
WireConnection;11;2;1;0
WireConnection;11;3;8;0
WireConnection;11;4;3;0
WireConnection;11;5;9;0
WireConnection;11;6;10;0
WireConnection;11;7;7;0
WireConnection;47;0;11;0
WireConnection;17;0;11;0
WireConnection;52;0;47;3
WireConnection;52;1;45;0
WireConnection;22;0;17;1
WireConnection;26;0;17;3
WireConnection;28;0;17;2
WireConnection;59;0;47;1
WireConnection;59;1;45;0
WireConnection;58;0;47;0
WireConnection;58;1;45;0
WireConnection;53;0;47;2
WireConnection;53;1;45;0
WireConnection;20;0;17;0
WireConnection;33;1;58;0
WireConnection;33;0;59;0
WireConnection;33;2;53;0
WireConnection;33;3;52;0
WireConnection;33;4;11;0
WireConnection;33;5;20;0
WireConnection;33;6;22;0
WireConnection;33;7;28;0
WireConnection;33;8;26;0
WireConnection;0;0;33;0
WireConnection;0;2;33;0
ASEEND*/
//CHKSM=9EA7AC126793613BFD4C3A31800D12666074E943