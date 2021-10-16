// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "internal/debugging/debug_triplanar-cylinder-projection"
{
	Properties
	{
		[KeywordEnum(SurfaceUpness,WallSegmentation,ClusterNoise,ClusterSegmentation,WallClusters,FadedWall,FadedClusters,FadedWallClusters,ClusterSegmentationCycles)] _3WayTextureSelection("3WayTextureSelection", Float) = 0
		_ClusterScale("Cluster Scale", Range( 0.0001 , 0.02)) = 1
		_ClusterOctaves("Cluster Octaves", Range( 1 , 20)) = 1
		_SideThresholds("Side Thresholds", Vector) = (0.33,0.66,0,0)
		_FadeSideThresholds("Fade Side Thresholds", Vector) = (0.36,0.33,-0.33,-0.36)
		_ClusterNoiseFadeRange("Cluster Noise Fade Range", Range( 0 , 0.2)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.5
		#pragma shader_feature_local _3WAYTEXTURESELECTION_SURFACEUPNESS _3WAYTEXTURESELECTION_WALLSEGMENTATION _3WAYTEXTURESELECTION_CLUSTERNOISE _3WAYTEXTURESELECTION_CLUSTERSEGMENTATION _3WAYTEXTURESELECTION_WALLCLUSTERS _3WAYTEXTURESELECTION_FADEDWALL _3WAYTEXTURESELECTION_FADEDCLUSTERS _3WAYTEXTURESELECTION_FADEDWALLCLUSTERS _3WAYTEXTURESELECTION_CLUSTERSEGMENTATIONCYCLES
		#pragma surface surf Standard keepalpha noshadow 
		struct Input
		{
			float3 worldNormal;
			float3 worldPos;
		};

		uniform float2 _SideThresholds;
		uniform float _ClusterScale;
		uniform float _ClusterOctaves;
		uniform float4 _FadeSideThresholds;
		uniform float _ClusterNoiseFadeRange;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldNormal = i.worldNormal;
			float dotResult39 = dot( ase_worldNormal , float3(0,1,0) );
			float3 temp_cast_0 = (dotResult39).xxx;
			float3 temp_cast_1 = (dotResult39).xxx;
			float3 _Vector10 = float3(1,0,0);
			float3 _Vector8 = float3(0,1,0);
			float3 _Vector9 = float3(0,0,1);
			float3 temp_output_57_0 = (( dotResult39 < _SideThresholds.x ) ? _Vector10 :  (( dotResult39 < _SideThresholds.y ) ? _Vector8 :  _Vector9 ) );
			float3 ase_worldPos = i.worldPos;
			float3 temp_output_2_0_g198 = ( ase_worldPos * _ClusterScale );
			float3 p10_g198 = floor( temp_output_2_0_g198 );
			float3 break9_g205 = ( ( ( ( p10_g198 + float3(0,0,0) ) * 0.3183099 ) + 0.1 ) * 17.0 );
			float3 break9_g206 = ( ( ( ( p10_g198 + float3(1,0,0) ) * 0.3183099 ) + 0.1 ) * 17.0 );
			float3 temp_output_3_0_g198 = frac( temp_output_2_0_g198 );
			float3 temp_cast_2 = (3.0).xxx;
			float3 f9_g198 = ( temp_output_3_0_g198 * temp_output_3_0_g198 * ( temp_cast_2 - ( temp_output_3_0_g198 * 2.0 ) ) );
			float3 break14_g198 = f9_g198;
			float lerpResult20_g198 = lerp( frac( ( break9_g205.x * break9_g205.y * break9_g205.z * ( break9_g205.x + break9_g205.y + break9_g205.z ) ) ) , frac( ( break9_g206.x * break9_g206.y * break9_g206.z * ( break9_g206.x + break9_g206.y + break9_g206.z ) ) ) , break14_g198.x);
			float3 break9_g203 = ( ( ( ( p10_g198 + float3(0,1,0) ) * 0.3183099 ) + 0.1 ) * 17.0 );
			float3 break9_g204 = ( ( ( ( p10_g198 + float3(1,1,0) ) * 0.3183099 ) + 0.1 ) * 17.0 );
			float lerpResult21_g198 = lerp( frac( ( break9_g203.x * break9_g203.y * break9_g203.z * ( break9_g203.x + break9_g203.y + break9_g203.z ) ) ) , frac( ( break9_g204.x * break9_g204.y * break9_g204.z * ( break9_g204.x + break9_g204.y + break9_g204.z ) ) ) , break14_g198.x);
			float lerpResult15_g198 = lerp( lerpResult20_g198 , lerpResult21_g198 , break14_g198.y);
			float3 break9_g200 = ( ( ( ( p10_g198 + float3(0,0,1) ) * 0.3183099 ) + 0.1 ) * 17.0 );
			float3 break9_g199 = ( ( ( ( p10_g198 + float3(1,0,1) ) * 0.3183099 ) + 0.1 ) * 17.0 );
			float lerpResult22_g198 = lerp( frac( ( break9_g200.x * break9_g200.y * break9_g200.z * ( break9_g200.x + break9_g200.y + break9_g200.z ) ) ) , frac( ( break9_g199.x * break9_g199.y * break9_g199.z * ( break9_g199.x + break9_g199.y + break9_g199.z ) ) ) , break14_g198.x);
			float3 break9_g202 = ( ( ( ( p10_g198 + float3(0,1,1) ) * 0.3183099 ) + 0.1 ) * 17.0 );
			float3 break9_g201 = ( ( ( ( p10_g198 + float3(1,1,1) ) * 0.3183099 ) + 0.1 ) * 17.0 );
			float lerpResult23_g198 = lerp( frac( ( break9_g202.x * break9_g202.y * break9_g202.z * ( break9_g202.x + break9_g202.y + break9_g202.z ) ) ) , frac( ( break9_g201.x * break9_g201.y * break9_g201.z * ( break9_g201.x + break9_g201.y + break9_g201.z ) ) ) , break14_g198.x);
			float lerpResult16_g198 = lerp( lerpResult22_g198 , lerpResult23_g198 , break14_g198.y);
			float lerpResult11_g198 = lerp( lerpResult15_g198 , lerpResult16_g198 , break14_g198.z);
			float temp_output_27_0 = ( lerpResult11_g198 * _ClusterOctaves );
			float temp_output_35_0 = frac( temp_output_27_0 );
			float3 temp_cast_3 = (temp_output_35_0).xxx;
			float temp_output_55_0 = (( temp_output_35_0 < 0.33 ) ? 0.2 :  (( temp_output_35_0 < 0.66 ) ? 0.6 :  1.0 ) );
			float3 temp_cast_4 = (temp_output_55_0).xxx;
			float temp_output_5_0_g234 = dotResult39;
			float2 break18_g234 = (_FadeSideThresholds).xy;
			float3 temp_output_1_0_g234 = _Vector9;
			float3 temp_output_2_0_g234 = _Vector8;
			float temp_output_7_0_g235 = break18_g234.y;
			float3 lerpResult4_g234 = lerp( temp_output_2_0_g234 , temp_output_1_0_g234 , ( ( temp_output_5_0_g234 - temp_output_7_0_g235 ) / ( break18_g234.x - temp_output_7_0_g235 ) ));
			float2 break19_g234 = (_FadeSideThresholds).zw;
			float3 temp_output_3_0_g234 = _Vector10;
			float temp_output_7_0_g236 = break19_g234.x;
			float3 lerpResult16_g234 = lerp( temp_output_2_0_g234 , temp_output_3_0_g234 , ( ( temp_output_5_0_g234 - temp_output_7_0_g236 ) / ( break19_g234.y - temp_output_7_0_g236 ) ));
			float3 temp_output_56_0 = (( temp_output_5_0_g234 > break18_g234.x ) ? temp_output_1_0_g234 :  (( temp_output_5_0_g234 > break18_g234.y ) ? lerpResult4_g234 :  (( temp_output_5_0_g234 > break19_g234.x ) ? temp_output_2_0_g234 :  (( temp_output_5_0_g234 > break19_g234.y ) ? lerpResult16_g234 :  temp_output_3_0_g234 ) ) ) );
			float temp_output_5_0_g224 = temp_output_35_0;
			float2 appendResult36 = (float2(( 0.66 + _ClusterNoiseFadeRange ) , 0.66));
			float2 break18_g224 = appendResult36;
			float temp_output_1_0_g224 = 1.0;
			float temp_output_2_0_g224 = 0.6;
			float temp_output_7_0_g225 = break18_g224.y;
			float lerpResult4_g224 = lerp( temp_output_2_0_g224 , temp_output_1_0_g224 , ( ( temp_output_5_0_g224 - temp_output_7_0_g225 ) / ( break18_g224.x - temp_output_7_0_g225 ) ));
			float2 appendResult37 = (float2(0.33 , ( 0.33 - _ClusterNoiseFadeRange )));
			float2 break19_g224 = appendResult37;
			float temp_output_3_0_g224 = 0.2;
			float temp_output_7_0_g226 = break19_g224.x;
			float lerpResult16_g224 = lerp( temp_output_2_0_g224 , temp_output_3_0_g224 , ( ( temp_output_5_0_g224 - temp_output_7_0_g226 ) / ( break19_g224.y - temp_output_7_0_g226 ) ));
			float3 temp_output_51_0 = ((( temp_output_5_0_g224 > break18_g224.x ) ? temp_output_1_0_g224 :  (( temp_output_5_0_g224 > break18_g224.y ) ? lerpResult4_g224 :  (( temp_output_5_0_g224 > break19_g224.x ) ? temp_output_2_0_g224 :  (( temp_output_5_0_g224 > break19_g224.y ) ? lerpResult16_g224 :  temp_output_3_0_g224 ) ) ) )).xxx;
			float temp_output_5_0_g231 = (( fmod( temp_output_27_0 , 2.0 ) > 1.0 ) ? ( 1.0 - temp_output_35_0 ) :  temp_output_35_0 );
			float2 break18_g231 = appendResult36;
			float temp_output_1_0_g231 = 1.0;
			float temp_output_2_0_g231 = 0.6;
			float temp_output_7_0_g232 = break18_g231.y;
			float lerpResult4_g231 = lerp( temp_output_2_0_g231 , temp_output_1_0_g231 , ( ( temp_output_5_0_g231 - temp_output_7_0_g232 ) / ( break18_g231.x - temp_output_7_0_g232 ) ));
			float2 break19_g231 = appendResult37;
			float temp_output_3_0_g231 = 0.2;
			float temp_output_7_0_g233 = break19_g231.x;
			float lerpResult16_g231 = lerp( temp_output_2_0_g231 , temp_output_3_0_g231 , ( ( temp_output_5_0_g231 - temp_output_7_0_g233 ) / ( break19_g231.y - temp_output_7_0_g233 ) ));
			#if defined(_3WAYTEXTURESELECTION_SURFACEUPNESS)
				float3 staticSwitch71 = temp_cast_0;
			#elif defined(_3WAYTEXTURESELECTION_WALLSEGMENTATION)
				float3 staticSwitch71 = temp_output_57_0;
			#elif defined(_3WAYTEXTURESELECTION_CLUSTERNOISE)
				float3 staticSwitch71 = temp_cast_3;
			#elif defined(_3WAYTEXTURESELECTION_CLUSTERSEGMENTATION)
				float3 staticSwitch71 = temp_cast_4;
			#elif defined(_3WAYTEXTURESELECTION_WALLCLUSTERS)
				float3 staticSwitch71 = ( temp_output_57_0 * temp_output_55_0 );
			#elif defined(_3WAYTEXTURESELECTION_FADEDWALL)
				float3 staticSwitch71 = temp_output_56_0;
			#elif defined(_3WAYTEXTURESELECTION_FADEDCLUSTERS)
				float3 staticSwitch71 = temp_output_51_0;
			#elif defined(_3WAYTEXTURESELECTION_FADEDWALLCLUSTERS)
				float3 staticSwitch71 = ( temp_output_56_0 * temp_output_51_0 );
			#elif defined(_3WAYTEXTURESELECTION_CLUSTERSEGMENTATIONCYCLES)
				float3 staticSwitch71 = ((( temp_output_5_0_g231 > break18_g231.x ) ? temp_output_1_0_g231 :  (( temp_output_5_0_g231 > break18_g231.y ) ? lerpResult4_g231 :  (( temp_output_5_0_g231 > break19_g231.x ) ? temp_output_2_0_g231 :  (( temp_output_5_0_g231 > break19_g231.y ) ? lerpResult16_g231 :  temp_output_3_0_g231 ) ) ) )).xxx;
			#else
				float3 staticSwitch71 = temp_cast_0;
			#endif
			o.Albedo = staticSwitch71;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17000
0;0;1280;659;2226.23;-1432.246;2.124059;True;False
Node;AmplifyShaderEditor.RangedFloatNode;2;-2741.535,-853.5311;Float;False;Property;_ClusterScale;Cluster Scale;1;0;Create;True;0;0;False;0;1;0.0129;0.0001;0.02;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;6;-3060.492,371.1259;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;12;-2741.535,-757.5311;Float;False;Property;_ClusterOctaves;Cluster Octaves;2;0;Create;True;0;0;False;0;1;6;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-2497.418,391.766;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;18;-2368,384;Float;False;Cluster Noise;-1;;198;fa82b03b37d70fd46b5de1b93bd0f898;0;1;2;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;19;-2536.495,484.8454;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-2176,384;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-2030.15,2014.162;Float;False;Constant;_Float7;Float 7;11;0;Create;True;0;0;False;0;0.33;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-2043.926,1770.502;Float;False;Property;_ClusterNoiseFadeRange;Cluster Noise Fade Range;5;0;Create;True;0;0;False;0;0;0.01;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-2032.905,1908.712;Float;False;Constant;_Float6;Float 6;11;0;Create;True;0;0;False;0;0.66;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;35;-2016,400;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;86;-1771.1,822.1999;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;21;-1728.577,1831.8;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleRemainderNode;84;-2048,480;Float;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;87;-1786.185,902.1951;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;24;-3053.293,-288.7649;Float;False;Constant;_float0;float0;4;0;Create;True;0;0;False;0;0,1,0;0,1,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;23;-3072.854,-456.5894;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;25;-1776.247,2060.822;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;34;-3045.882,52.11737;Float;False;Constant;_Vector8;Vector 8;0;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;40;-3050.198,206.5835;Float;False;Constant;_Vector9;Vector 9;0;0;Create;True;0;0;False;0;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;32;-1385.25,2316.762;Float;False;Constant;_Float4;Float 4;11;0;Create;True;0;0;False;0;0.6;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareGreater;85;-1585.603,778.7287;Float;False;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;48;-3053.294,-102.5388;Float;False;Constant;_Vector10;Vector 10;0;0;Create;True;0;0;False;0;1,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector2Node;38;-2677.535,-981.5311;Float;False;Property;_SideThresholds;Side Thresholds;3;0;Create;True;0;0;False;0;0.33,0.66;-0.33,0.32;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.DotProductOpNode;39;-2830.879,-365.5893;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-1386.55,2210.362;Float;False;Constant;_Float3;Float 3;11;0;Create;True;0;0;False;0;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;93;-646.0379,763.1528;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;29;-2055.561,1464.463;Float;False;Property;_FadeSideThresholds;Fade Side Thresholds;4;0;Create;True;0;0;False;0;0.36,0.33,-0.33,-0.36;0.36,0.33,-0.33,-0.36;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;36;-1524.247,1857.821;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;37;-1537.247,1951.821;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-1379.841,2398.856;Float;False;Constant;_Float5;Float 5;11;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;80;-2189.022,997.587;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCCompareLower;42;-1286.012,531.4045;Float;False;4;0;FLOAT;0;False;1;FLOAT;0.66;False;2;FLOAT;0.6;False;3;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;83;-2348.249,1046.9;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCCompareLower;43;-2140.495,13.79205;Float;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;82;-2292.453,1006.215;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;41;-530.3228,1950.826;Float;False;Three Way Threshold Fade;-1;;224;d9b81761a1bb212428c4e8f674c6382b;0;6;5;FLOAT;0;False;1;FLOAT;0;False;8;FLOAT2;0,0;False;2;FLOAT;0;False;7;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;44;-1692.99,1528.029;Float;False;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;46;-1692.99,1608.029;Float;False;False;False;True;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;94;-727.2924,751.5556;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;91;-526.4097,2141.631;Float;False;Three Way Threshold Fade;-1;;231;d9b81761a1bb212428c4e8f674c6382b;0;6;5;FLOAT;0;False;1;FLOAT;0;False;8;FLOAT2;0,0;False;2;FLOAT;0;False;7;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;51;-46.68124,1986.344;Float;False;FLOAT3;0;1;2;3;1;0;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCCompareLower;55;-1023.703,434.0747;Float;False;4;0;FLOAT;0;False;1;FLOAT;0.33;False;2;FLOAT;0.2;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;56;-1141.356,1497.615;Float;False;Three Way Threshold Fade;-1;;234;d9b81761a1bb212428c4e8f674c6382b;0;6;5;FLOAT;0;False;1;FLOAT3;0,0,0;False;8;FLOAT2;0,0;False;2;FLOAT3;0,0,0;False;7;FLOAT2;0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCCompareLower;57;-1643.142,-80.45432;Float;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode;92;-38.53547,2071.731;Float;False;FLOAT3;0;1;2;3;1;0;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;402.1095,77.92611;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;63;-1354.374,-268.8523;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;374.1396,564.561;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;71;872.7631,-11.60215;Float;False;Property;_3WayTextureSelection;3WayTextureSelection;0;0;Create;True;0;0;False;0;0;0;1;True;;KeywordEnum;9;SurfaceUpness;WallSegmentation;ClusterNoise;ClusterSegmentation;WallClusters;FadedWall;FadedClusters;FadedWallClusters;ClusterSegmentationCycles;Create;True;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1534.833,-9.934204;Float;False;True;3;Float;ASEMaterialInspector;0;0;Standard;internal/Debugging/debug_triplanar-cylinder-projection;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;13;0;6;0
WireConnection;13;1;2;0
WireConnection;18;2;13;0
WireConnection;19;0;12;0
WireConnection;27;0;18;0
WireConnection;27;1;19;0
WireConnection;35;0;27;0
WireConnection;86;0;35;0
WireConnection;21;0;16;0
WireConnection;21;1;14;0
WireConnection;84;0;27;0
WireConnection;87;0;35;0
WireConnection;25;0;15;0
WireConnection;25;1;14;0
WireConnection;85;0;84;0
WireConnection;85;2;86;0
WireConnection;85;3;87;0
WireConnection;39;0;23;0
WireConnection;39;1;24;0
WireConnection;93;0;35;0
WireConnection;36;0;21;0
WireConnection;36;1;16;0
WireConnection;37;0;15;0
WireConnection;37;1;25;0
WireConnection;80;0;40;0
WireConnection;42;0;35;0
WireConnection;83;0;48;0
WireConnection;43;0;39;0
WireConnection;43;1;38;2
WireConnection;43;2;34;0
WireConnection;43;3;40;0
WireConnection;82;0;34;0
WireConnection;41;5;93;0
WireConnection;41;1;30;0
WireConnection;41;8;36;0
WireConnection;41;2;32;0
WireConnection;41;7;37;0
WireConnection;41;3;31;0
WireConnection;44;0;29;0
WireConnection;46;0;29;0
WireConnection;94;0;85;0
WireConnection;91;5;94;0
WireConnection;91;1;30;0
WireConnection;91;8;36;0
WireConnection;91;2;32;0
WireConnection;91;7;37;0
WireConnection;91;3;31;0
WireConnection;51;0;41;0
WireConnection;55;0;35;0
WireConnection;55;3;42;0
WireConnection;56;5;39;0
WireConnection;56;1;80;0
WireConnection;56;8;44;0
WireConnection;56;2;82;0
WireConnection;56;7;46;0
WireConnection;56;3;83;0
WireConnection;57;0;39;0
WireConnection;57;1;38;1
WireConnection;57;2;48;0
WireConnection;57;3;43;0
WireConnection;92;0;91;0
WireConnection;65;0;57;0
WireConnection;65;1;55;0
WireConnection;63;0;39;0
WireConnection;70;0;56;0
WireConnection;70;1;51;0
WireConnection;71;1;63;0
WireConnection;71;0;57;0
WireConnection;71;2;35;0
WireConnection;71;3;55;0
WireConnection;71;4;65;0
WireConnection;71;5;56;0
WireConnection;71;6;51;0
WireConnection;71;7;70;0
WireConnection;71;8;92;0
WireConnection;0;0;71;0
ASEEND*/
//CHKSM=B194D3466FA869F40891D544A87073CA0F7D81CE