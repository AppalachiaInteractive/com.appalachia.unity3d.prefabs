Shader "internal_depth-mask2"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("Cull Mode", Float) = 2
		[Toggle]_ZWriteMode("ZWrite Mode", Float) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTest Mode", Float) = 4
		[HideInInspector] __dirty( "", Int ) = 1
	}


	SubShader
	{
		Tags { "RenderType" = "DepthMask"  "Queue" = "Geometry+20" }
		Cull [_CullMode]
		ZWrite [_ZWriteMode]
		ZTest [_ZTestMode]
		ColorMask 0
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows noshadow 
		struct Input
		{
			half filler;
		};

		uniform float _CullMode;
		uniform float _ZWriteMode;
		uniform float _ZTestMode;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color12 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
			o.Albedo = color12.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17500
225.6;51.2;1236;724;-112.3239;391.3042;1.845869;True;False
Node;AmplifyShaderEditor.RangedFloatNode;2;947.8964,7.395081;Inherit;False;Property;_CullMode;Cull Mode;1;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;1222.281,262.504;Inherit;False;Property;_ZWriteMode;ZWrite Mode;2;1;[Toggle];Create;True;0;0;True;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;1218.281,349.504;Inherit;False;Property;_ZTestMode;ZTest Mode;3;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CompareFunction;True;0;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;12;-254.5814,19.6572;Inherit;False;Constant;_Color0;Color 0;4;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;13;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;internal_depth-mask2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;True;3;0;True;6;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;20;True;Custom;DepthMask;Geometry;All;14;all;False;False;False;False;0;False;1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;False;False;_BILLBOARD_ON;Relative;0;;0;-1;-1;-1;0;False;0;0;True;2;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;14;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT3;0,0,0;False;0
WireConnection;13;0;12;0
ASEEND*/
//CHKSM=1B3D725B8FC338AF20C121EFF69245EDF04E3FA8