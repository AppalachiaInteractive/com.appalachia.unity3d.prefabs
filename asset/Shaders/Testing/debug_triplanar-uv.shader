// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "internal/debugging/debug_triplanar-uv"
{
	Properties
	{
		[KeywordEnum(MicrssplatTriplanar,RotatedUV,NormalSearch,WorldPosition,WorldNormal)] _TriplanarType("Triplanar Type", Float) = 0
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_TextureSample5("Texture Sample 5", 2D) = "white" {}
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_TextureSample3("Texture Sample 3", 2D) = "white" {}
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
		_TextureSample4("Texture Sample 4", 2D) = "white" {}
		_TriplanarContrast("Triplanar Contrast", Float) = 1
		_TextureScale("Texture Scale", Float) = 1
		_UVMultiplier("UV Multiplier", Vector) = (1,-1,0,0)
		_HighLimitNormal("High Limit Normal", Vector) = (1,1,1,0)
		_LowLimitNormal("Low Limit Normal", Vector) = (1,1,1,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.5
		#pragma shader_feature_local _TRIPLANARTYPE_MICRSSPLATTRIPLANAR _TRIPLANARTYPE_ROTATEDUV _TRIPLANARTYPE_NORMALSEARCH _TRIPLANARTYPE_WORLDPOSITION _TRIPLANARTYPE_WORLDNORMAL
		#pragma surface surf Standard keepalpha noshadow 
		struct Input
		{
			float3 worldNormal;
			float3 worldPos;
		};

		uniform float _TriplanarContrast;
		uniform sampler2D _TextureSample0;
		uniform float _TextureScale;
		uniform sampler2D _TextureSample1;
		uniform sampler2D _TextureSample2;
		uniform sampler2D _TextureSample5;
		uniform float2 _UVMultiplier;
		uniform sampler2D _TextureSample3;
		uniform sampler2D _TextureSample4;
		uniform float3 _LowLimitNormal;
		uniform float3 _HighLimitNormal;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldNormal = i.worldNormal;
			float3 temp_cast_0 = (_TriplanarContrast).xxx;
			float3 temp_output_42_0_g653 = pow( abs( ase_worldNormal ) , temp_cast_0 );
			float3 break2_g656 = temp_output_42_0_g653;
			float3 temp_output_144_62 = ( temp_output_42_0_g653 / ( break2_g656.x + break2_g656.y + break2_g656.z ) );
			float temp_output_74_0_g653 = 1.0;
			float3 ase_worldPos = i.worldPos;
			float2 temp_output_1_0_g658 = (ase_worldPos).zy;
			float2 temp_output_31_0_g653 = (_TextureScale).xx;
			float2 temp_output_2_0_g658 = temp_output_31_0_g653;
			float2 temp_output_30_0_g653 = float2( 0,0 );
			float3 break6_g660 = sign( ase_worldNormal );
			float3 appendResult7_g660 = (float3((( break6_g660.x < 0.0 ) ? -1.0 :  1.0 ) , (( break6_g660.y < 0.0 ) ? -1.0 :  1.0 ) , (( break6_g660.z < 0.0 ) ? -1.0 :  1.0 )));
			float3 temp_output_57_0_g653 = appendResult7_g660;
			float3 appendResult53_g653 = (float3((temp_output_57_0_g653).xy , ( (temp_output_57_0_g653).z * -1.0 )));
			float3 axisSigns54_g653 = appendResult53_g653;
			float3 break89_g653 = axisSigns54_g653;
			float2 temp_output_106_0_g653 = ( ( (( temp_output_74_0_g653 > 0.0 ) ? ( temp_output_1_0_g658 / temp_output_2_0_g658 ) :  ( temp_output_1_0_g658 * temp_output_2_0_g658 ) ) + temp_output_30_0_g653 ) * break89_g653.x );
			float2 temp_output_144_0 = temp_output_106_0_g653;
			float2 temp_output_1_0_g655 = (ase_worldPos).xz;
			float2 temp_output_2_0_g655 = temp_output_31_0_g653;
			float2 temp_output_107_0_g653 = ( ( (( temp_output_74_0_g653 > 0.0 ) ? ( temp_output_1_0_g655 / temp_output_2_0_g655 ) :  ( temp_output_1_0_g655 * temp_output_2_0_g655 ) ) + temp_output_30_0_g653 ) * break89_g653.y );
			float2 temp_output_144_20 = temp_output_107_0_g653;
			float2 temp_output_1_0_g659 = (ase_worldPos).xy;
			float2 temp_output_2_0_g659 = temp_output_31_0_g653;
			float2 temp_output_108_0_g653 = ( ( (( temp_output_74_0_g653 > 0.0 ) ? ( temp_output_1_0_g659 / temp_output_2_0_g659 ) :  ( temp_output_1_0_g659 * temp_output_2_0_g659 ) ) + temp_output_30_0_g653 ) * break89_g653.z );
			float2 temp_output_144_21 = temp_output_108_0_g653;
			float3 weightedBlendVar99 = temp_output_144_62;
			float4 weightedBlend99 = ( weightedBlendVar99.x*tex2D( _TextureSample0, temp_output_144_0 ) + weightedBlendVar99.y*tex2D( _TextureSample1, temp_output_144_20 ) + weightedBlendVar99.z*tex2D( _TextureSample2, temp_output_144_21 ) );
			float3 weightedBlendVar108 = temp_output_144_62;
			float4 weightedBlend108 = ( weightedBlendVar108.x*tex2D( _TextureSample5, ( temp_output_144_0 * _UVMultiplier ) ) + weightedBlendVar108.y*tex2D( _TextureSample3, ( temp_output_144_20 * _UVMultiplier ) ) + weightedBlendVar108.z*tex2D( _TextureSample4, ( temp_output_144_21 * _UVMultiplier ) ) );
			float3 _Vector1 = float3(1,1,1);
			float3 _Vector2 = float3(0,0,0);
			float3 appendResult139 = (float3((( ase_worldNormal.x >= _LowLimitNormal.x && ase_worldNormal.x <= _HighLimitNormal.x ) ? _Vector1.x :  _Vector2.x ) , (( ase_worldNormal.y >= _LowLimitNormal.y && ase_worldNormal.y <= _HighLimitNormal.y ) ? _Vector1.y :  _Vector2.y ) , (( ase_worldNormal.z >= _LowLimitNormal.z && ase_worldNormal.z <= _HighLimitNormal.z ) ? _Vector1.z :  _Vector2.z )));
			#if defined(_TRIPLANARTYPE_MICRSSPLATTRIPLANAR)
				float4 staticSwitch71 = weightedBlend99;
			#elif defined(_TRIPLANARTYPE_ROTATEDUV)
				float4 staticSwitch71 = weightedBlend108;
			#elif defined(_TRIPLANARTYPE_NORMALSEARCH)
				float4 staticSwitch71 = float4( appendResult139 , 0.0 );
			#elif defined(_TRIPLANARTYPE_WORLDPOSITION)
				float4 staticSwitch71 = float4( ase_worldPos , 0.0 );
			#elif defined(_TRIPLANARTYPE_WORLDNORMAL)
				float4 staticSwitch71 = float4( ase_worldNormal , 0.0 );
			#else
				float4 staticSwitch71 = weightedBlend99;
			#endif
			o.Emission = staticSwitch71.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17000
0;-864;1536;843;-2277.021;-940.4478;1.3;True;False
Node;AmplifyShaderEditor.RangedFloatNode;102;-848,-512;Float;False;Property;_TextureScale;Texture Scale;8;0;Create;True;0;0;False;0;1;28.19;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;103;-608,-496;Float;False;FLOAT2;0;1;2;3;1;0;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;101;-826,-666;Float;False;Property;_TriplanarContrast;Triplanar Contrast;7;0;Create;True;0;0;False;0;1;100;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;144;-336,-592;Float;False;Triplanar UVs (Microsplat);-1;;653;12de860eba7d60c4086713c1564c6574;1,109,0;4;39;FLOAT;1;False;30;FLOAT2;0,0;False;31;FLOAT2;1,1;False;74;FLOAT;1;False;8;FLOAT2;0;FLOAT2;20;FLOAT2;21;FLOAT3;62;FLOAT3;61;FLOAT4;90;FLOAT4;99;FLOAT4;103
Node;AmplifyShaderEditor.Vector2Node;104;-132.22,1044.886;Float;False;Property;_UVMultiplier;UV Multiplier;9;0;Create;True;0;0;False;0;1,-1;-1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector3Node;135;1671.2,2133.4;Float;False;Constant;_Vector2;Vector 2;10;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;129;1672.854,1500.827;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;132;1670.2,1639.4;Float;False;Property;_LowLimitNormal;Low Limit Normal;11;0;Create;True;0;0;False;0;1,1,1;-0.83,-0.67,-0.95;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;134;1671.2,1973.4;Float;False;Constant;_Vector1;Vector 1;10;0;Create;True;0;0;False;0;1,1,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;131;1657.2,1793.4;Float;False;Property;_HighLimitNormal;High Limit Normal;10;0;Create;True;0;0;False;0;1,1,1;-0.22,0.13,-0.17;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;112;235.7799,1140.886;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;113;235.7799,1268.886;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;111;235.7799,1012.886;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;109;528.75,921.4086;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;107;619.7799,1140.886;Float;True;Property;_TextureSample5;Texture Sample 5;2;0;Create;True;0;0;False;0;e31d4520bb196294bb3e30db7701e3d4;a08960dd6e8274e7f8fca616e09c48ed;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;105;619.7799,1348.886;Float;True;Property;_TextureSample3;Texture Sample 3;4;0;Create;True;0;0;False;0;1cfeeb233160e0d418095f67b0f196ce;a08960dd6e8274e7f8fca616e09c48ed;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;110;1000.923,1086.142;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;98;512,32;Float;True;Property;_TextureSample2;Texture Sample 2;5;0;Create;True;0;0;False;0;113f30b743a037b46abe023484feec68;a08960dd6e8274e7f8fca616e09c48ed;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;97;512,-176;Float;True;Property;_TextureSample1;Texture Sample 1;3;0;Create;True;0;0;False;0;1cfeeb233160e0d418095f67b0f196ce;a08960dd6e8274e7f8fca616e09c48ed;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCCompareWithRange;137;2119.2,1797.4;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;100;791.9225,-524.1559;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;106;619.7799,1556.886;Float;True;Property;_TextureSample4;Texture Sample 4;6;0;Create;True;0;0;False;0;113f30b743a037b46abe023484feec68;a08960dd6e8274e7f8fca616e09c48ed;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCCompareWithRange;133;2125.6,1603.8;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareWithRange;138;2119.2,1973.4;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;96;512,-384;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;e31d4520bb196294bb3e30db7701e3d4;a08960dd6e8274e7f8fca616e09c48ed;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SummedBlendNode;108;1099.756,1334.012;Float;False;5;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldNormalVector;147;2923.9,1780.068;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;139;2438.589,1655.978;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SummedBlendNode;99;926.3174,-274.2675;Float;False;5;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldPosInputsNode;146;2967.2,1576.268;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StaticSwitch;71;3398.215,1110.255;Float;False;Property;_TriplanarType;Triplanar Type;0;0;Create;True;0;0;False;0;0;0;0;True;;KeywordEnum;5;MicrssplatTriplanar;RotatedUV;NormalSearch;WorldPosition;WorldNormal;Create;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;4191.337,1131.039;Float;False;True;3;Float;ASEMaterialInspector;0;0;Standard;internal/Debugging/debug_triplanar-uv;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;103;0;102;0
WireConnection;144;39;101;0
WireConnection;144;31;103;0
WireConnection;112;0;144;20
WireConnection;112;1;104;0
WireConnection;113;0;144;21
WireConnection;113;1;104;0
WireConnection;111;0;144;0
WireConnection;111;1;104;0
WireConnection;109;0;144;62
WireConnection;107;1;111;0
WireConnection;105;1;112;0
WireConnection;110;0;109;0
WireConnection;98;1;144;21
WireConnection;97;1;144;20
WireConnection;137;0;129;2
WireConnection;137;1;132;2
WireConnection;137;2;131;2
WireConnection;137;3;134;2
WireConnection;137;4;135;2
WireConnection;100;0;144;62
WireConnection;106;1;113;0
WireConnection;133;0;129;1
WireConnection;133;1;132;1
WireConnection;133;2;131;1
WireConnection;133;3;134;1
WireConnection;133;4;135;1
WireConnection;138;0;129;3
WireConnection;138;1;132;3
WireConnection;138;2;131;3
WireConnection;138;3;134;3
WireConnection;138;4;135;3
WireConnection;96;1;144;0
WireConnection;108;0;110;0
WireConnection;108;1;107;0
WireConnection;108;2;105;0
WireConnection;108;3;106;0
WireConnection;139;0;133;0
WireConnection;139;1;137;0
WireConnection;139;2;138;0
WireConnection;99;0;100;0
WireConnection;99;1;96;0
WireConnection;99;2;97;0
WireConnection;99;3;98;0
WireConnection;71;1;99;0
WireConnection;71;0;108;0
WireConnection;71;2;139;0
WireConnection;71;3;146;0
WireConnection;71;4;147;0
WireConnection;0;2;71;0
ASEEND*/
//CHKSM=DF4AE29A788CF407ED969BC63CD0095ADB438370