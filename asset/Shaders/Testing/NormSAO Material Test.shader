// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "NormSAO Material Test"
{
	Properties
	{
		_TextureScale("Texture Scale", Range( 0 , 50)) = 1
		_NormalScale("Normal Scale", Range( 0 , 5)) = 1
		_AlbedoH("Albedo H", 2DArray) = "black" {}
		[Normal]_Normal("Normal", 2DArray) = "bump" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.5
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldPos;
		};

		uniform UNITY_DECLARE_TEX2DARRAY( _AlbedoH );
		uniform float _TextureScale;
		uniform float _NormalScale;
		uniform UNITY_DECLARE_TEX2DARRAY( _Normal );

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 blendWeights59_g599 = float3( -1,-1,-1 );
			float3 break208_g599 = blendWeights59_g599;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 temp_output_313_0_g599 = abs( ase_worldNormal );
			float dotResult145_g599 = dot( temp_output_313_0_g599 , float3( 1,1,1 ) );
			float blendChannel153_g599 = 3.0;
			float temp_output_2_0_g603 = blendChannel153_g599;
			float3 ase_worldPos = i.worldPos;
			float3 break29_g602 = ase_worldPos;
			float2 appendResult11_g602 = (float2(break29_g602.z , break29_g602.y));
			float2 temp_output_51_0_g598 = float2( 0,0 );
			float2 textureOffset81_g599 = temp_output_51_0_g598;
			float2 temp_output_30_0_g602 = textureOffset81_g599;
			float2 appendResult92 = (float2(_TextureScale , _TextureScale));
			float2 temp_output_31_0_g598 = appendResult92;
			float2 textureScale83_g599 = temp_output_31_0_g598;
			float2 temp_output_31_0_g602 = textureScale83_g599;
			float2 temp_output_354_0_g599 = ( ( appendResult11_g602 + temp_output_30_0_g602 ) / temp_output_31_0_g602 );
			float texIndex15_g599 = 0.0;
			float4 texArray139_g599 = UNITY_SAMPLE_TEX2DARRAY(_AlbedoH, float3(temp_output_354_0_g599, texIndex15_g599)  );
			float4 break3_g603 = texArray139_g599;
			float channelBlendX160_g599 = (( temp_output_2_0_g603 >= 3.0 ) ? break3_g603.w :  (( temp_output_2_0_g603 >= 2.0 ) ? break3_g603.z :  (( temp_output_2_0_g603 >= 1.0 ) ? break3_g603.y :  break3_g603.x ) ) );
			float temp_output_2_0_g600 = blendChannel153_g599;
			float2 appendResult13_g602 = (float2(break29_g602.x , break29_g602.z));
			float2 _Vector0 = float2(0.33,0.33);
			float2 temp_output_354_20_g599 = ( ( appendResult13_g602 + temp_output_30_0_g602 + ( 0.0 * _Vector0 ) ) / temp_output_31_0_g602 );
			float4 texArray133_g599 = UNITY_SAMPLE_TEX2DARRAY(_AlbedoH, float3(temp_output_354_20_g599, texIndex15_g599)  );
			float4 break3_g600 = texArray133_g599;
			float channelBlendY159_g599 = (( temp_output_2_0_g600 >= 3.0 ) ? break3_g600.w :  (( temp_output_2_0_g600 >= 2.0 ) ? break3_g600.z :  (( temp_output_2_0_g600 >= 1.0 ) ? break3_g600.y :  break3_g600.x ) ) );
			float temp_output_2_0_g601 = blendChannel153_g599;
			float2 appendResult10_g602 = (float2(break29_g602.x , break29_g602.y));
			float2 temp_output_354_21_g599 = ( ( appendResult10_g602 + temp_output_30_0_g602 + ( 0.0 * _Vector0 * 2.0 ) ) / temp_output_31_0_g602 );
			float4 texArray119_g599 = UNITY_SAMPLE_TEX2DARRAY(_AlbedoH, float3(temp_output_354_21_g599, texIndex15_g599)  );
			float4 break3_g601 = texArray119_g599;
			float channelBlendZ161_g599 = (( temp_output_2_0_g601 >= 3.0 ) ? break3_g601.w :  (( temp_output_2_0_g601 >= 2.0 ) ? break3_g601.z :  (( temp_output_2_0_g601 >= 1.0 ) ? break3_g601.y :  break3_g601.x ) ) );
			float3 appendResult165_g599 = (float3(channelBlendX160_g599 , channelBlendY159_g599 , channelBlendZ161_g599));
			float clampResult184_g599 = clamp( 1.0 , 0.0 , 1.0 );
			float channelBlendSharpness181_g599 = ( 1.0 - clampResult184_g599 );
			float temp_output_182_0_g599 = ( max( max( channelBlendX160_g599 , channelBlendY159_g599 ) , channelBlendZ161_g599 ) - channelBlendSharpness181_g599 );
			float3 appendResult189_g599 = (float3(temp_output_182_0_g599 , temp_output_182_0_g599 , temp_output_182_0_g599));
			float3 temp_output_186_0_g599 = max( ( ( ( ( temp_output_313_0_g599 / dotResult145_g599 ) * float3( 3,3,3 ) ) + appendResult165_g599 ) - appendResult189_g599 ) , float3( 0,0,0 ) );
			float dotResult191_g599 = dot( temp_output_186_0_g599 , float3( 1,1,1 ) );
			float3 heightBlendWeights173_g599 = ( temp_output_186_0_g599 / dotResult191_g599 );
			float3 temp_output_214_0_g599 = (( ( break208_g599.x + break208_g599.y + break208_g599.z ) < 0.0 ) ? heightBlendWeights173_g599 :  blendWeights59_g599 );
			float3 blendWeights59_g604 = temp_output_214_0_g599;
			float3 break45_g604 = ase_worldNormal;
			float worldNormalZ217_g604 = break45_g604.z;
			float worldNormalY216_g604 = break45_g604.y;
			float3 worldNormalAbs95_g604 = abs( ase_worldNormal );
			float3 break43_g604 = worldNormalAbs95_g604;
			float worldNormalAbsX218_g604 = break43_g604.x;
			float3 appendResult327_g604 = (float3(worldNormalZ217_g604 , worldNormalY216_g604 , worldNormalAbsX218_g604));
			float3 n114_g613 = ( float3(0,0,1) + appendResult327_g604 );
			float normalScale30_g604 = _NormalScale;
			float3 break29_g607 = ase_worldPos;
			float2 appendResult11_g607 = (float2(break29_g607.z , break29_g607.y));
			float2 textureOffset81_g604 = temp_output_51_0_g598;
			float2 temp_output_30_0_g607 = textureOffset81_g604;
			float2 textureScale83_g604 = temp_output_31_0_g598;
			float2 temp_output_31_0_g607 = textureScale83_g604;
			float2 temp_output_354_0_g604 = ( ( appendResult11_g607 + temp_output_30_0_g607 ) / temp_output_31_0_g607 );
			float texIndex15_g604 = 0.0;
			float4 texArray46_g610 = UNITY_SAMPLE_TEX2DARRAY(_Normal, float3(temp_output_354_0_g604, texIndex15_g604)  );
			float4 unpaciked14_g611 = (texArray46_g610).garb;
			float2 break30_g611 = ( normalScale30_g604 * ( ( float2( 2,2 ) * (unpaciked14_g611).xy ) - float2( 1,1 ) ) );
			float normalX31_g611 = break30_g611.x;
			float normalY32_g611 = break30_g611.y;
			float3 appendResult38_g611 = (float3(normalX31_g611 , normalY32_g611 , sqrt( ( ( 1.0 - ( normalX31_g611 * normalX31_g611 ) ) - ( normalY32_g611 * normalY32_g611 ) ) )));
			float3 n215_g613 = ( appendResult38_g611 * float3(-1,-1,1) );
			float dotResult9_g613 = dot( n114_g613 , n215_g613 );
			float3 break332_g604 = ( ( ( n114_g613 * dotResult9_g613 ) / (n114_g613).z ) - n215_g613 );
			float3 break225_g604 = sign( ase_worldNormal );
			float axisSignX223_g604 = (( break225_g604.x < 0.5 ) ? -1.0 :  1.0 );
			float3 appendResult264_g604 = (float3(( break332_g604.z * axisSignX223_g604 ) , break332_g604.y , break332_g604.x));
			float worldNormalX215_g604 = break45_g604.x;
			float worldNormalAbsY219_g604 = break43_g604.y;
			float3 appendResult334_g604 = (float3(worldNormalX215_g604 , worldNormalZ217_g604 , worldNormalAbsY219_g604));
			float3 n114_g606 = ( float3(0,0,1) + appendResult334_g604 );
			float2 appendResult13_g607 = (float2(break29_g607.x , break29_g607.z));
			float2 temp_output_354_20_g604 = ( ( appendResult13_g607 + temp_output_30_0_g607 + ( 0.0 * _Vector0 ) ) / temp_output_31_0_g607 );
			float4 texArray46_g620 = UNITY_SAMPLE_TEX2DARRAY(_Normal, float3(temp_output_354_20_g604, texIndex15_g604)  );
			float4 unpaciked14_g621 = (texArray46_g620).garb;
			float2 break30_g621 = ( normalScale30_g604 * ( ( float2( 2,2 ) * (unpaciked14_g621).xy ) - float2( 1,1 ) ) );
			float normalX31_g621 = break30_g621.x;
			float normalY32_g621 = break30_g621.y;
			float3 appendResult38_g621 = (float3(normalX31_g621 , normalY32_g621 , sqrt( ( ( 1.0 - ( normalX31_g621 * normalX31_g621 ) ) - ( normalY32_g621 * normalY32_g621 ) ) )));
			float3 n215_g606 = ( appendResult38_g621 * float3(-1,-1,1) );
			float dotResult9_g606 = dot( n114_g606 , n215_g606 );
			float3 break338_g604 = ( ( ( n114_g606 * dotResult9_g606 ) / (n114_g606).z ) - n215_g606 );
			float axisSignY226_g604 = (( break225_g604.y < 0.5 ) ? -1.0 :  1.0 );
			float3 appendResult339_g604 = (float3(break338_g604.x , ( break338_g604.z * axisSignY226_g604 ) , break338_g604.y));
			float worldNormalAbsZ220_g604 = break43_g604.z;
			float3 appendResult343_g604 = (float3(worldNormalX215_g604 , worldNormalY216_g604 , worldNormalAbsZ220_g604));
			float3 n114_g605 = ( float3(0,0,1) + appendResult343_g604 );
			float3 n215_g605 = ( float3( 0,0,0 ) * float3(-1,-1,1) );
			float dotResult9_g605 = dot( n114_g605 , n215_g605 );
			float3 break347_g604 = ( ( ( n114_g605 * dotResult9_g605 ) / (n114_g605).z ) - n215_g605 );
			float axisSignZ227_g604 = (( break225_g604.z < 0.5 ) ? -1.0 :  1.0 );
			float3 appendResult348_g604 = (float3(break347_g604.x , break347_g604.y , ( break347_g604.z * axisSignZ227_g604 )));
			float3 weightedBlendVar388_g604 = blendWeights59_g604;
			float3 weightedAvg388_g604 = ( ( weightedBlendVar388_g604.x*appendResult264_g604 + weightedBlendVar388_g604.y*appendResult339_g604 + weightedBlendVar388_g604.z*appendResult348_g604 )/( weightedBlendVar388_g604.x + weightedBlendVar388_g604.y + weightedBlendVar388_g604.z ) );
			float3 normalizeResult62_g604 = normalize( weightedAvg388_g604 );
			float3 normalizeResult35_g612 = normalize( mul( float3x3((WorldNormalVector( i , float3(1,0,0) )), (WorldNormalVector( i , float3(0,1,0) )), (WorldNormalVector( i , float3(0,0,1) ))), normalizeResult62_g604 ) );
			float3 normalizeResult26_g598 = normalize( normalizeResult35_g612 );
			float3 temp_output_132_29 = normalizeResult26_g598;
			o.Normal = temp_output_132_29;
			float4 channelX258_g599 = texArray139_g599;
			float3 finalBlendWeights146_g599 = temp_output_214_0_g599;
			float3 break132_g599 = finalBlendWeights146_g599;
			float4 channelY257_g599 = texArray133_g599;
			float4 channelZ256_g599 = texArray119_g599;
			o.Albedo = ( ( channelX258_g599 * break132_g599.x ) + ( channelY257_g599 * break132_g599.y ) + ( channelZ256_g599 * break132_g599.z ) ).xyz;
			float temp_output_24_0_g611 = (unpaciked14_g611).z;
			float temp_output_24_0_g621 = (unpaciked14_g621).z;
			float2 appendResult10_g607 = (float2(break29_g607.x , break29_g607.y));
			float2 temp_output_354_21_g604 = ( ( appendResult10_g607 + temp_output_30_0_g607 + ( 0.0 * _Vector0 * 2.0 ) ) / temp_output_31_0_g607 );
			float4 texArray46_g608 = UNITY_SAMPLE_TEX2DARRAY(_Normal, float3(temp_output_354_21_g604, texIndex15_g604)  );
			float4 unpaciked14_g609 = (texArray46_g608).garb;
			float temp_output_24_0_g609 = (unpaciked14_g609).z;
			float3 weightedBlendVar392_g604 = blendWeights59_g604;
			float weightedAvg392_g604 = ( ( weightedBlendVar392_g604.x*temp_output_24_0_g611 + weightedBlendVar392_g604.y*temp_output_24_0_g621 + weightedBlendVar392_g604.z*temp_output_24_0_g609 )/( weightedBlendVar392_g604.x + weightedBlendVar392_g604.y + weightedBlendVar392_g604.z ) );
			o.Smoothness = weightedAvg392_g604;
			float3 weightedBlendVar390_g604 = blendWeights59_g604;
			float weightedAvg390_g604 = ( ( weightedBlendVar390_g604.x*(unpaciked14_g611).w + weightedBlendVar390_g604.y*(unpaciked14_g621).w + weightedBlendVar390_g604.z*(unpaciked14_g609).w )/( weightedBlendVar390_g604.x + weightedBlendVar390_g604.y + weightedBlendVar390_g604.z ) );
			o.Occlusion = weightedAvg390_g604;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.5
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float4 tSpace0 : TEXCOORD1;
				float4 tSpace1 : TEXCOORD2;
				float4 tSpace2 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17000
0;0;1280;659;4929.698;246.652;1.3;True;False
Node;AmplifyShaderEditor.RangedFloatNode;91;-5238.047,480.0494;Float;False;Property;_TextureScale;Texture Scale;15;0;Create;True;0;0;False;0;1;5.4;0;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;67;-5504,0;Float;True;Property;_Normal;Normal;18;1;[Normal];Create;True;0;0;False;0;675b565102eae7742ac74c5459d876b0;865c86ad4eedcb74882054c43f92fb5d;True;bump;LockedToTexture2DArray;Texture2DArray;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexturePropertyNode;66;-5504,-209;Float;True;Property;_AlbedoH;Albedo H;17;0;Create;True;0;0;False;0;ffdd80285816c284eba749c21d10221e;8a0820cf6d5f4574489e41c01cf2d37b;False;black;LockedToTexture2DArray;Texture2DArray;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.DynamicAppendNode;92;-4839.913,401.8327;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;124;-5207.204,372.1632;Float;False;Property;_NormalScale;Normal Scale;16;0;Create;True;0;0;False;0;1;0.84;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;127;-5237.514,195.8782;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SwizzleNode;128;-4991.514,138.8782;Float;False;FLOAT2;0;2;2;3;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ToggleSwitchNode;125;-4132.5,-28.96338;Float;False;Property;_ToggleSwitch0;Toggle Switch0;14;0;Create;True;0;0;False;0;1;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;131;-4657.3,-129.0634;Float;False;NormSAO Array Sample;12;;596;b0b9e4b143df5a741a62893492ff1f91;0;4;40;SAMPLER2D;0;False;42;FLOAT2;0,0;False;37;FLOAT;1;False;47;FLOAT;1;False;4;FLOAT3;0;FLOAT;4;FLOAT;5;FLOAT;9
Node;AmplifyShaderEditor.FunctionNode;132;-4624.448,58.8627;Float;False;Triplanar Height Blend Material (Albedo NormSAO);0;;598;b47292ca1d15e2e4c900608dd961d44a;0;8;36;SAMPLER2D;0;False;33;FLOAT;0;False;35;SAMPLER2D;0;False;34;FLOAT;0;False;37;FLOAT;1;False;31;FLOAT2;1,1;False;51;FLOAT2;0,0;False;32;FLOAT;1;False;5;FLOAT4;0;FLOAT3;29;FLOAT;95;FLOAT;96;FLOAT;97
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-3817.144,44.53571;Float;False;True;3;Float;ASEMaterialInspector;0;0;Standard;NormSAO Material Test;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;92;0;91;0
WireConnection;92;1;91;0
WireConnection;128;0;127;0
WireConnection;125;0;131;0
WireConnection;125;1;132;29
WireConnection;131;40;67;0
WireConnection;131;42;128;0
WireConnection;131;37;124;0
WireConnection;132;36;66;0
WireConnection;132;35;67;0
WireConnection;132;37;124;0
WireConnection;132;31;92;0
WireConnection;0;0;132;0
WireConnection;0;1;132;29
WireConnection;0;4;132;96
WireConnection;0;5;132;95
ASEEND*/
//CHKSM=83BAE97B5E0D0BC344D5003561D2C84BB6758C97