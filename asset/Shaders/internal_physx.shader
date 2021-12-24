// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "internal_physx"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_TRANSPARENCY("TRANSPARENCY", Range( 0 , 1)) = 0.1
		_COLOR("COLOR", Color) = (1,1,1,1)
		_Mask("Mask", 2D) = "white" {}
		[Normal]_Normal("Normal", 2D) = "bump" {}
		_Offset("Offset", Vector) = (0,0,0,0)
		_Scale("Scale", Vector) = (0,0,0,0)
		_Contrast("Contrast", Range( 0 , 10)) = 1
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		ZWrite On
		ZTest LEqual
		Blend SrcAlpha OneMinusSrcAlpha
		
		AlphaToMask On
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha noshadow exclude_path:deferred 
		struct Input
		{
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldPos;
			half ASEVFace : VFACE;
		};

		uniform float _Contrast;
		uniform sampler2D _Normal;
		uniform float2 _Scale;
		uniform float2 _Offset;
		uniform float4 _COLOR;
		uniform float _TRANSPARENCY;
		uniform sampler2D _Mask;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 temp_cast_0 = (_Contrast).xxx;
			float3 temp_output_42_0_g927 = pow( abs( ase_worldNormal ) , temp_cast_0 );
			float3 break2_g929 = temp_output_42_0_g927;
			float temp_output_74_0_g927 = 1.0;
			float3 ase_worldPos = i.worldPos;
			float2 temp_output_1_0_g933 = (ase_worldPos).zy;
			float2 temp_output_31_0_g927 = _Scale;
			float2 temp_output_2_0_g933 = temp_output_31_0_g927;
			float2 temp_output_30_0_g927 = _Offset;
			float2 temp_output_3_0_g933 = temp_output_30_0_g927;
			float3 break6_g930 = sign( ase_worldNormal );
			float3 appendResult7_g930 = (float3((( break6_g930.x < 0.0 ) ? -1.0 :  1.0 ) , (( break6_g930.y < 0.0 ) ? -1.0 :  1.0 ) , (( break6_g930.z < 0.0 ) ? -1.0 :  1.0 )));
			float3 temp_output_57_0_g927 = appendResult7_g930;
			float3 appendResult53_g927 = (float3((temp_output_57_0_g927).xy , ( 1.0 / (( (temp_output_57_0_g927).z == 0.0 ) ? 1.0 :  (temp_output_57_0_g927).z ) )));
			float3 axisSigns54_g927 = appendResult53_g927;
			float3 break89_g927 = axisSigns54_g927;
			float2 temp_output_106_0_g927 = ( ( (( temp_output_74_0_g927 > 0.0 ) ? ( temp_output_1_0_g933 / temp_output_2_0_g933 ) :  ( temp_output_1_0_g933 * temp_output_2_0_g933 ) ) + temp_output_3_0_g933 ) * break89_g927.x );
			float2 temp_output_1_0_g931 = (ase_worldPos).xz;
			float2 temp_output_2_0_g931 = temp_output_31_0_g927;
			float2 temp_output_3_0_g931 = temp_output_30_0_g927;
			float2 temp_output_107_0_g927 = ( ( (( temp_output_74_0_g927 > 0.0 ) ? ( temp_output_1_0_g931 / temp_output_2_0_g931 ) :  ( temp_output_1_0_g931 * temp_output_2_0_g931 ) ) + temp_output_3_0_g931 ) * break89_g927.y );
			float2 temp_output_1_0_g932 = (ase_worldPos).xy;
			float2 temp_output_2_0_g932 = temp_output_31_0_g927;
			float2 temp_output_3_0_g932 = temp_output_30_0_g927;
			float2 temp_output_108_0_g927 = ( ( (( temp_output_74_0_g927 > 0.0 ) ? ( temp_output_1_0_g932 / temp_output_2_0_g932 ) :  ( temp_output_1_0_g932 * temp_output_2_0_g932 ) ) + temp_output_3_0_g932 ) * break89_g927.z );
			float3 weightedBlendVar840_g926 = ( temp_output_42_0_g927 / ( break2_g929.x + break2_g929.y + break2_g929.z ) );
			float3 weightedAvg840_g926 = ( ( weightedBlendVar840_g926.x*UnpackNormal( tex2D( _Normal, temp_output_106_0_g927 ) ) + weightedBlendVar840_g926.y*UnpackNormal( tex2D( _Normal, temp_output_107_0_g927 ) ) + weightedBlendVar840_g926.z*UnpackNormal( tex2D( _Normal, temp_output_108_0_g927 ) ) )/( weightedBlendVar840_g926.x + weightedBlendVar840_g926.y + weightedBlendVar840_g926.z ) );
			float3 temp_output_13_0_g944 = weightedAvg840_g926;
			float3 switchResult20_g944 = (((i.ASEVFace>0)?(temp_output_13_0_g944):(-temp_output_13_0_g944)));
			float3 FrontFacesNormal50 = switchResult20_g944;
			o.Normal = FrontFacesNormal50;
			float4 FrontFacesAlbedo51 = _COLOR;
			float4 BackFacesAlbedo47 = ( _COLOR * 0.35 );
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float dotResult33 = dot( ase_worldNormal , ase_worldViewDir );
			float FaceSign53 = (1.0 + (sign( dotResult33 ) - -1.0) * (0.0 - 1.0) / (1.0 - -1.0));
			float4 lerpResult62 = lerp( FrontFacesAlbedo51 , BackFacesAlbedo47 , FaceSign53);
			o.Albedo = lerpResult62.rgb;
			o.Alpha = _TRANSPARENCY;
			float3 temp_cast_2 = (_Contrast).xxx;
			float3 temp_output_42_0_g936 = pow( abs( ase_worldNormal ) , temp_cast_2 );
			float3 break2_g938 = temp_output_42_0_g936;
			float temp_output_74_0_g936 = 1.0;
			float2 temp_output_1_0_g942 = (ase_worldPos).zy;
			float2 temp_output_31_0_g936 = _Scale;
			float2 temp_output_2_0_g942 = temp_output_31_0_g936;
			float2 temp_output_30_0_g936 = _Offset;
			float2 temp_output_3_0_g942 = temp_output_30_0_g936;
			float3 break6_g939 = sign( ase_worldNormal );
			float3 appendResult7_g939 = (float3((( break6_g939.x < 0.0 ) ? -1.0 :  1.0 ) , (( break6_g939.y < 0.0 ) ? -1.0 :  1.0 ) , (( break6_g939.z < 0.0 ) ? -1.0 :  1.0 )));
			float3 temp_output_57_0_g936 = appendResult7_g939;
			float3 appendResult53_g936 = (float3((temp_output_57_0_g936).xy , ( 1.0 / (( (temp_output_57_0_g936).z == 0.0 ) ? 1.0 :  (temp_output_57_0_g936).z ) )));
			float3 axisSigns54_g936 = appendResult53_g936;
			float3 break89_g936 = axisSigns54_g936;
			float2 temp_output_106_0_g936 = ( ( (( temp_output_74_0_g936 > 0.0 ) ? ( temp_output_1_0_g942 / temp_output_2_0_g942 ) :  ( temp_output_1_0_g942 * temp_output_2_0_g942 ) ) + temp_output_3_0_g942 ) * break89_g936.x );
			float2 temp_output_1_0_g940 = (ase_worldPos).xz;
			float2 temp_output_2_0_g940 = temp_output_31_0_g936;
			float2 temp_output_3_0_g940 = temp_output_30_0_g936;
			float2 temp_output_107_0_g936 = ( ( (( temp_output_74_0_g936 > 0.0 ) ? ( temp_output_1_0_g940 / temp_output_2_0_g940 ) :  ( temp_output_1_0_g940 * temp_output_2_0_g940 ) ) + temp_output_3_0_g940 ) * break89_g936.y );
			float2 temp_output_1_0_g941 = (ase_worldPos).xy;
			float2 temp_output_2_0_g941 = temp_output_31_0_g936;
			float2 temp_output_3_0_g941 = temp_output_30_0_g936;
			float2 temp_output_108_0_g936 = ( ( (( temp_output_74_0_g936 > 0.0 ) ? ( temp_output_1_0_g941 / temp_output_2_0_g941 ) :  ( temp_output_1_0_g941 * temp_output_2_0_g941 ) ) + temp_output_3_0_g941 ) * break89_g936.z );
			float3 weightedBlendVar840_g935 = ( temp_output_42_0_g936 / ( break2_g938.x + break2_g938.y + break2_g938.z ) );
			float4 weightedAvg840_g935 = ( ( weightedBlendVar840_g935.x*tex2D( _Mask, temp_output_106_0_g936 ) + weightedBlendVar840_g935.y*tex2D( _Mask, temp_output_107_0_g936 ) + weightedBlendVar840_g935.z*tex2D( _Mask, temp_output_108_0_g936 ) )/( weightedBlendVar840_g935.x + weightedBlendVar840_g935.y + weightedBlendVar840_g935.z ) );
			float OpacityMask59 = (weightedAvg840_g935).a;
			clip( OpacityMask59 - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "AppalachiaShaderGUI"
}
/*ASEBEGIN
Version=17500
214.4;0;966;338;167.7192;-429.5762;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;30;-1834.043,1835.265;Inherit;False;1094.131;402.4268;Comment;6;53;46;40;33;32;31;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;31;-1758.823,2053.692;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;32;-1784.043,1899.173;Inherit;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;34;-2805.469,140.9456;Inherit;False;1966.44;1208.77;Comment;15;50;47;71;72;69;24;59;79;80;81;82;83;86;87;88;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DotProductOpNode;33;-1525.792,1980.386;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;87;-2230.424,1112.031;Inherit;False;Property;_Scale;Scale;6;0;Create;True;0;0;False;0;0,0;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TexturePropertyNode;81;-2482.53,897.4897;Inherit;True;Property;_Mask;Mask;3;0;Create;True;0;0;False;0;3c65230d888a88b4daa9adc3ddcb8ef3;0d0b7bb6fa52ad14bbd860240a233091;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexturePropertyNode;82;-2475.53,679.4897;Inherit;True;Property;_Normal;Normal;4;1;[Normal];Create;True;0;0;False;0;c929f57137044294c9e9e8520ba20151;b0d0c5388f256c943bd46a33509969b8;True;bump;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.Vector2Node;86;-2234.424,982.0305;Inherit;False;Property;_Offset;Offset;5;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;88;-2322.424,1245.031;Inherit;False;Property;_Contrast;Contrast;7;0;Create;True;0;0;False;0;1;10;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;24;-2732.463,194.4101;Inherit;False;Property;_COLOR;COLOR;2;0;Create;True;0;0;False;0;1,1,1,1;0.589,0.4920305,0.287317,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SignOpNode;40;-1358.24,1991.998;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;69;-2079.388,421.2089;Inherit;False;Constant;_Float0;Float 0;8;0;Create;True;0;0;False;0;0.35;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;79;-1989.257,900.9961;Inherit;False;Triplanar Simple Sampler;-1;;935;01695575fb4cb334c88991ac43649b5e;0;4;835;SAMPLER2D;0;False;891;FLOAT2;0,0;False;890;FLOAT2;1,1;False;889;FLOAT;1;False;1;COLOR;846
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;-1870.54,293.9744;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;46;-1195.737,1973.838;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;80;-1994.507,689.4255;Inherit;False;Triplanar Simple Normal Sampler;-1;;926;7453eec4bca63124ead9b90d329314b3;0;4;835;SAMPLER2D;0;False;891;FLOAT2;0,0;False;890;FLOAT2;1,1;False;889;FLOAT;1;False;1;FLOAT3;846
Node;AmplifyShaderEditor.RegisterLocalVarNode;53;-973.9112,1970.184;Float;False;FaceSign;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;47;-1196.406,334.6924;Float;False;BackFacesAlbedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;51;-2446.905,31.81659;Float;False;FrontFacesAlbedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;71;-1617.424,710.0366;Inherit;False;Normal BackFace;-1;;944;121446c878db06f4c847f9c5afed7cfe;0;1;13;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;83;-1658.53,895.4897;Inherit;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;59;-1408,896;Float;False;OpacityMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;50;-1411.966,696.1826;Float;False;FrontFacesNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;49;-780.3041,537.087;Inherit;False;47;BackFacesAlbedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;55;-780.9741,661.828;Inherit;False;53;FaceSign;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;-821.9404,401.034;Inherit;False;51;FrontFacesAlbedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;23;51.14331,889.3126;Inherit;False;Property;_TRANSPARENCY;TRANSPARENCY;1;0;Create;True;0;0;False;0;0.1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;61;132.0077,993.163;Inherit;False;59;OpacityMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;52;9.188759,605.1274;Inherit;False;50;FrontFacesNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;62;-434.3019,465.1627;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;28;490.9211,537.8494;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;internal_physx;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;1;False;-1;3;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Transparent;;Transparent;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0.08;0.333,0.333,0.333,0;VertexScale;False;False;Cylindrical;False;False;False;_BILLBOARD_ON;Relative;0;;0;-1;-1;-1;0;True;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;14;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT3;0,0,0;False;0
WireConnection;33;0;32;0
WireConnection;33;1;31;0
WireConnection;40;0;33;0
WireConnection;79;835;81;0
WireConnection;79;891;86;0
WireConnection;79;890;87;0
WireConnection;79;889;88;0
WireConnection;72;0;24;0
WireConnection;72;1;69;0
WireConnection;46;0;40;0
WireConnection;80;835;82;0
WireConnection;80;891;86;0
WireConnection;80;890;87;0
WireConnection;80;889;88;0
WireConnection;53;0;46;0
WireConnection;47;0;72;0
WireConnection;51;0;24;0
WireConnection;71;13;80;846
WireConnection;83;0;79;846
WireConnection;59;0;83;0
WireConnection;50;0;71;0
WireConnection;62;0;54;0
WireConnection;62;1;49;0
WireConnection;62;2;55;0
WireConnection;28;0;62;0
WireConnection;28;1;52;0
WireConnection;28;9;23;0
WireConnection;28;10;61;0
ASEEND*/
//CHKSM=D6714FFCBD469BC521E52A5061F56935B3AF432A