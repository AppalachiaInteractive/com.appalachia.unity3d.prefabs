// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Heightblend Material Test"
{
	Properties
	{
		_TextureScale("Texture Scale", Range( 0 , 50)) = 1
		_AlbedoH("Albedo H", 2DArray) = "black" {}
		[Normal]_Normal("Normal", 2DArray) = "bump" {}
		_MAOHS("MAOHS", 2DArray) = "black" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
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

		uniform UNITY_DECLARE_TEX2DARRAY( _Normal );
		uniform float _TextureScale;
		uniform UNITY_DECLARE_TEX2DARRAY( _AlbedoH );
		uniform UNITY_DECLARE_TEX2DARRAY( _MAOHS );

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 break45_g536 = ase_worldNormal;
			float worldNormalZ217_g536 = break45_g536.z;
			float worldNormalY216_g536 = break45_g536.y;
			float3 worldNormalAbs95_g536 = abs( ase_worldNormal );
			float3 break43_g536 = worldNormalAbs95_g536;
			float worldNormalAbsX218_g536 = break43_g536.x;
			float3 appendResult327_g536 = (float3(worldNormalZ217_g536 , worldNormalY216_g536 , worldNormalAbsX218_g536));
			float3 n114_g541 = ( float3(0,0,1) + appendResult327_g536 );
			float3 ase_worldPos = i.worldPos;
			float2 appendResult13_g536 = (float2(ase_worldPos.z , ase_worldPos.y));
			float2 temp_output_51_0_g519 = float2( 0,0 );
			float2 textureOffset81_g536 = temp_output_51_0_g519;
			float2 appendResult92 = (float2(_TextureScale , _TextureScale));
			float2 temp_output_31_0_g519 = appendResult92;
			float2 textureScale83_g536 = temp_output_31_0_g519;
			float2 uvX19_g536 = ( ( appendResult13_g536 + textureOffset81_g536 ) / textureScale83_g536 );
			float temp_output_34_0_g519 = 0.0;
			float texIndex15_g536 = temp_output_34_0_g519;
			float normalScale30_g536 = 1.0;
			float3 texArray61_g536 = UnpackScaleNormal( UNITY_SAMPLE_TEX2DARRAY(_Normal, float3(uvX19_g536, texIndex15_g536)  ), normalScale30_g536 );
			float3 n215_g541 = ( texArray61_g536 * float3(-1,-1,1) );
			float dotResult9_g541 = dot( n114_g541 , n215_g541 );
			float3 break332_g536 = ( ( ( n114_g541 * dotResult9_g541 ) / (n114_g541).z ) - n215_g541 );
			float3 break225_g536 = sign( ase_worldNormal );
			float axisSignX223_g536 = (( break225_g536.x < 0.5 ) ? -1.0 :  1.0 );
			float3 appendResult264_g536 = (float3(( break332_g536.z * axisSignX223_g536 ) , break332_g536.y , break332_g536.x));
			float3 blendWeights59_g520 = float3( -1,-1,-1 );
			float3 break208_g520 = blendWeights59_g520;
			float3 worldNormalAbs95_g520 = abs( ase_worldNormal );
			float dotResult145_g520 = dot( worldNormalAbs95_g520 , float3( 1,1,1 ) );
			float blendChannel153_g520 = 3.0;
			float temp_output_2_0_g521 = blendChannel153_g520;
			float2 appendResult13_g520 = (float2(ase_worldPos.z , ase_worldPos.y));
			float2 textureOffset81_g520 = temp_output_51_0_g519;
			float2 textureScale83_g520 = temp_output_31_0_g519;
			float2 uvX19_g520 = ( ( appendResult13_g520 + textureOffset81_g520 ) / textureScale83_g520 );
			float texIndex15_g520 = 0.0;
			float4 texArray139_g520 = UNITY_SAMPLE_TEX2DARRAY(_AlbedoH, float3(uvX19_g520, texIndex15_g520)  );
			float4 break3_g521 = texArray139_g520;
			float channelBlendX160_g520 = (( temp_output_2_0_g521 >= 3.0 ) ? break3_g521.w :  (( temp_output_2_0_g521 >= 2.0 ) ? break3_g521.z :  (( temp_output_2_0_g521 >= 1.0 ) ? break3_g521.y :  break3_g521.x ) ) );
			float temp_output_2_0_g526 = blendChannel153_g520;
			float2 appendResult12_g520 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 uvY20_g520 = ( ( appendResult12_g520 + textureOffset81_g520 + float2( 0.33,0.33 ) ) / textureScale83_g520 );
			float4 texArray133_g520 = UNITY_SAMPLE_TEX2DARRAY(_AlbedoH, float3(uvY20_g520, texIndex15_g520)  );
			float4 break3_g526 = texArray133_g520;
			float channelBlendY159_g520 = (( temp_output_2_0_g526 >= 3.0 ) ? break3_g526.w :  (( temp_output_2_0_g526 >= 2.0 ) ? break3_g526.z :  (( temp_output_2_0_g526 >= 1.0 ) ? break3_g526.y :  break3_g526.x ) ) );
			float temp_output_2_0_g527 = blendChannel153_g520;
			float2 appendResult11_g520 = (float2(ase_worldPos.x , ase_worldPos.y));
			float2 uvZ21_g520 = ( ( appendResult11_g520 + textureOffset81_g520 + float2( 0.66,0.66 ) ) / textureScale83_g520 );
			float4 texArray119_g520 = UNITY_SAMPLE_TEX2DARRAY(_AlbedoH, float3(uvZ21_g520, texIndex15_g520)  );
			float4 break3_g527 = texArray119_g520;
			float channelBlendZ161_g520 = (( temp_output_2_0_g527 >= 3.0 ) ? break3_g527.w :  (( temp_output_2_0_g527 >= 2.0 ) ? break3_g527.z :  (( temp_output_2_0_g527 >= 1.0 ) ? break3_g527.y :  break3_g527.x ) ) );
			float3 appendResult165_g520 = (float3(channelBlendX160_g520 , channelBlendY159_g520 , channelBlendZ161_g520));
			float temp_output_32_0_g519 = 1.0;
			float clampResult184_g520 = clamp( temp_output_32_0_g519 , 0.0 , 1.0 );
			float channelBlendSharpness181_g520 = ( 1.0 - clampResult184_g520 );
			float temp_output_182_0_g520 = ( max( max( channelBlendX160_g520 , channelBlendY159_g520 ) , channelBlendZ161_g520 ) - channelBlendSharpness181_g520 );
			float3 appendResult189_g520 = (float3(temp_output_182_0_g520 , temp_output_182_0_g520 , temp_output_182_0_g520));
			float3 temp_output_186_0_g520 = max( ( ( ( ( worldNormalAbs95_g520 / dotResult145_g520 ) * float3( 3,3,3 ) ) + appendResult165_g520 ) - appendResult189_g520 ) , float3( 0,0,0 ) );
			float dotResult191_g520 = dot( temp_output_186_0_g520 , float3( 1,1,1 ) );
			float3 heightBlendWeights173_g520 = ( temp_output_186_0_g520 / dotResult191_g520 );
			float3 temp_output_214_0_g520 = (( ( break208_g520.x + break208_g520.y + break208_g520.z ) < 0.0 ) ? heightBlendWeights173_g520 :  blendWeights59_g520 );
			float3 break316_g520 = temp_output_214_0_g520;
			float3 temp_output_322_0_g520 = ( temp_output_214_0_g520 / ( break316_g520.x + break316_g520.y + break316_g520.z ) );
			float3 blendWeights59_g536 = temp_output_322_0_g520;
			float3 break208_g536 = blendWeights59_g536;
			float dotResult145_g536 = dot( worldNormalAbs95_g536 , float3( 1,1,1 ) );
			float blendChannel153_g536 = 3.0;
			float temp_output_2_0_g537 = blendChannel153_g536;
			float4 texArray139_g536 = UNITY_SAMPLE_TEX2DARRAY(_Normal, float3(uvX19_g536, texIndex15_g536)  );
			float4 break3_g537 = texArray139_g536;
			float channelBlendX160_g536 = (( temp_output_2_0_g537 >= 3.0 ) ? break3_g537.w :  (( temp_output_2_0_g537 >= 2.0 ) ? break3_g537.z :  (( temp_output_2_0_g537 >= 1.0 ) ? break3_g537.y :  break3_g537.x ) ) );
			float temp_output_2_0_g542 = blendChannel153_g536;
			float2 appendResult12_g536 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 uvY20_g536 = ( ( appendResult12_g536 + textureOffset81_g536 + float2( 0.33,0.33 ) ) / textureScale83_g536 );
			float4 texArray133_g536 = UNITY_SAMPLE_TEX2DARRAY(_Normal, float3(uvY20_g536, texIndex15_g536)  );
			float4 break3_g542 = texArray133_g536;
			float channelBlendY159_g536 = (( temp_output_2_0_g542 >= 3.0 ) ? break3_g542.w :  (( temp_output_2_0_g542 >= 2.0 ) ? break3_g542.z :  (( temp_output_2_0_g542 >= 1.0 ) ? break3_g542.y :  break3_g542.x ) ) );
			float temp_output_2_0_g543 = blendChannel153_g536;
			float2 appendResult11_g536 = (float2(ase_worldPos.x , ase_worldPos.y));
			float2 uvZ21_g536 = ( ( appendResult11_g536 + textureOffset81_g536 + float2( 0.66,0.66 ) ) / textureScale83_g536 );
			float4 texArray119_g536 = UNITY_SAMPLE_TEX2DARRAY(_Normal, float3(uvZ21_g536, texIndex15_g536)  );
			float4 break3_g543 = texArray119_g536;
			float channelBlendZ161_g536 = (( temp_output_2_0_g543 >= 3.0 ) ? break3_g543.w :  (( temp_output_2_0_g543 >= 2.0 ) ? break3_g543.z :  (( temp_output_2_0_g543 >= 1.0 ) ? break3_g543.y :  break3_g543.x ) ) );
			float3 appendResult165_g536 = (float3(channelBlendX160_g536 , channelBlendY159_g536 , channelBlendZ161_g536));
			float clampResult184_g536 = clamp( temp_output_32_0_g519 , 0.0 , 1.0 );
			float channelBlendSharpness181_g536 = ( 1.0 - clampResult184_g536 );
			float temp_output_182_0_g536 = ( max( max( channelBlendX160_g536 , channelBlendY159_g536 ) , channelBlendZ161_g536 ) - channelBlendSharpness181_g536 );
			float3 appendResult189_g536 = (float3(temp_output_182_0_g536 , temp_output_182_0_g536 , temp_output_182_0_g536));
			float3 temp_output_186_0_g536 = max( ( ( ( ( worldNormalAbs95_g536 / dotResult145_g536 ) * float3( 3,3,3 ) ) + appendResult165_g536 ) - appendResult189_g536 ) , float3( 0,0,0 ) );
			float dotResult191_g536 = dot( temp_output_186_0_g536 , float3( 1,1,1 ) );
			float3 heightBlendWeights173_g536 = ( temp_output_186_0_g536 / dotResult191_g536 );
			float3 temp_output_214_0_g536 = (( ( break208_g536.x + break208_g536.y + break208_g536.z ) < 0.0 ) ? heightBlendWeights173_g536 :  blendWeights59_g536 );
			float3 break316_g536 = temp_output_214_0_g536;
			float3 temp_output_322_0_g536 = ( temp_output_214_0_g536 / ( break316_g536.x + break316_g536.y + break316_g536.z ) );
			float3 finalBlendWeights146_g536 = temp_output_322_0_g536;
			float3 break66_g536 = finalBlendWeights146_g536;
			float worldNormalX215_g536 = break45_g536.x;
			float worldNormalAbsY219_g536 = break43_g536.y;
			float3 appendResult334_g536 = (float3(worldNormalX215_g536 , worldNormalZ217_g536 , worldNormalAbsY219_g536));
			float3 n114_g539 = ( float3(0,0,1) + appendResult334_g536 );
			float3 texArray28_g536 = UnpackScaleNormal( UNITY_SAMPLE_TEX2DARRAY(_Normal, float3(uvY20_g536, texIndex15_g536)  ), normalScale30_g536 );
			float3 n215_g539 = ( texArray28_g536 * float3(-1,-1,1) );
			float dotResult9_g539 = dot( n114_g539 , n215_g539 );
			float3 break338_g536 = ( ( ( n114_g539 * dotResult9_g539 ) / (n114_g539).z ) - n215_g539 );
			float axisSignY226_g536 = (( break225_g536.y < 0.5 ) ? -1.0 :  1.0 );
			float3 appendResult339_g536 = (float3(break338_g536.x , ( break338_g536.z * axisSignY226_g536 ) , break338_g536.y));
			float worldNormalAbsZ220_g536 = break43_g536.z;
			float3 appendResult343_g536 = (float3(worldNormalX215_g536 , worldNormalY216_g536 , worldNormalAbsZ220_g536));
			float3 n114_g538 = ( float3(0,0,1) + appendResult343_g536 );
			float3 texArray50_g536 = UnpackScaleNormal( UNITY_SAMPLE_TEX2DARRAY(_Normal, float3(uvZ21_g536, texIndex15_g536)  ), normalScale30_g536 );
			float3 n215_g538 = ( texArray50_g536 * float3(-1,-1,1) );
			float dotResult9_g538 = dot( n114_g538 , n215_g538 );
			float3 break347_g536 = ( ( ( n114_g538 * dotResult9_g538 ) / (n114_g538).z ) - n215_g538 );
			float axisSignZ227_g536 = (( break225_g536.z < 0.5 ) ? -1.0 :  1.0 );
			float3 appendResult348_g536 = (float3(break347_g536.x , break347_g536.y , ( break347_g536.z * axisSignZ227_g536 )));
			float3 normalizeResult62_g536 = normalize( ( ( appendResult264_g536 * break66_g536.x ) + ( appendResult339_g536 * break66_g536.y ) + ( appendResult348_g536 * break66_g536.z ) ) );
			float3 normalizeResult35_g540 = normalize( mul( float3x3((WorldNormalVector( i , float3(1,0,0) )), (WorldNormalVector( i , float3(0,1,0) )), (WorldNormalVector( i , float3(0,0,1) ))), normalizeResult62_g536 ) );
			float3 normalizeResult26_g519 = normalize( normalizeResult35_g540 );
			o.Normal = normalizeResult26_g519;
			float4 channelX258_g520 = texArray139_g520;
			float3 finalBlendWeights146_g520 = temp_output_322_0_g520;
			float3 break132_g520 = finalBlendWeights146_g520;
			float4 channelY257_g520 = texArray133_g520;
			float4 channelZ256_g520 = texArray119_g520;
			o.Albedo = ( ( channelX258_g520 * break132_g520.x ) + ( channelY257_g520 * break132_g520.y ) + ( channelZ256_g520 * break132_g520.z ) ).xyz;
			float2 appendResult13_g528 = (float2(ase_worldPos.z , ase_worldPos.y));
			float2 textureOffset81_g528 = temp_output_51_0_g519;
			float2 textureScale83_g528 = temp_output_31_0_g519;
			float2 uvX19_g528 = ( ( appendResult13_g528 + textureOffset81_g528 ) / textureScale83_g528 );
			float texIndex15_g528 = temp_output_34_0_g519;
			float4 texArray139_g528 = UNITY_SAMPLE_TEX2DARRAY(_MAOHS, float3(uvX19_g528, texIndex15_g528)  );
			float4 channelX258_g528 = texArray139_g528;
			float3 blendWeights59_g528 = temp_output_322_0_g536;
			float3 break208_g528 = blendWeights59_g528;
			float3 worldNormalAbs95_g528 = abs( ase_worldNormal );
			float dotResult145_g528 = dot( worldNormalAbs95_g528 , float3( 1,1,1 ) );
			float blendChannel153_g528 = 3.0;
			float temp_output_2_0_g529 = blendChannel153_g528;
			float4 break3_g529 = texArray139_g528;
			float channelBlendX160_g528 = (( temp_output_2_0_g529 >= 3.0 ) ? break3_g529.w :  (( temp_output_2_0_g529 >= 2.0 ) ? break3_g529.z :  (( temp_output_2_0_g529 >= 1.0 ) ? break3_g529.y :  break3_g529.x ) ) );
			float temp_output_2_0_g534 = blendChannel153_g528;
			float2 appendResult12_g528 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 uvY20_g528 = ( ( appendResult12_g528 + textureOffset81_g528 + float2( 0.33,0.33 ) ) / textureScale83_g528 );
			float4 texArray133_g528 = UNITY_SAMPLE_TEX2DARRAY(_MAOHS, float3(uvY20_g528, texIndex15_g528)  );
			float4 break3_g534 = texArray133_g528;
			float channelBlendY159_g528 = (( temp_output_2_0_g534 >= 3.0 ) ? break3_g534.w :  (( temp_output_2_0_g534 >= 2.0 ) ? break3_g534.z :  (( temp_output_2_0_g534 >= 1.0 ) ? break3_g534.y :  break3_g534.x ) ) );
			float temp_output_2_0_g535 = blendChannel153_g528;
			float2 appendResult11_g528 = (float2(ase_worldPos.x , ase_worldPos.y));
			float2 uvZ21_g528 = ( ( appendResult11_g528 + textureOffset81_g528 + float2( 0.66,0.66 ) ) / textureScale83_g528 );
			float4 texArray119_g528 = UNITY_SAMPLE_TEX2DARRAY(_MAOHS, float3(uvZ21_g528, texIndex15_g528)  );
			float4 break3_g535 = texArray119_g528;
			float channelBlendZ161_g528 = (( temp_output_2_0_g535 >= 3.0 ) ? break3_g535.w :  (( temp_output_2_0_g535 >= 2.0 ) ? break3_g535.z :  (( temp_output_2_0_g535 >= 1.0 ) ? break3_g535.y :  break3_g535.x ) ) );
			float3 appendResult165_g528 = (float3(channelBlendX160_g528 , channelBlendY159_g528 , channelBlendZ161_g528));
			float clampResult184_g528 = clamp( temp_output_32_0_g519 , 0.0 , 1.0 );
			float channelBlendSharpness181_g528 = ( 1.0 - clampResult184_g528 );
			float temp_output_182_0_g528 = ( max( max( channelBlendX160_g528 , channelBlendY159_g528 ) , channelBlendZ161_g528 ) - channelBlendSharpness181_g528 );
			float3 appendResult189_g528 = (float3(temp_output_182_0_g528 , temp_output_182_0_g528 , temp_output_182_0_g528));
			float3 temp_output_186_0_g528 = max( ( ( ( ( worldNormalAbs95_g528 / dotResult145_g528 ) * float3( 3,3,3 ) ) + appendResult165_g528 ) - appendResult189_g528 ) , float3( 0,0,0 ) );
			float dotResult191_g528 = dot( temp_output_186_0_g528 , float3( 1,1,1 ) );
			float3 heightBlendWeights173_g528 = ( temp_output_186_0_g528 / dotResult191_g528 );
			float3 temp_output_214_0_g528 = (( ( break208_g528.x + break208_g528.y + break208_g528.z ) < 0.0 ) ? heightBlendWeights173_g528 :  blendWeights59_g528 );
			float3 break316_g528 = temp_output_214_0_g528;
			float3 temp_output_322_0_g528 = ( temp_output_214_0_g528 / ( break316_g528.x + break316_g528.y + break316_g528.z ) );
			float3 finalBlendWeights146_g528 = temp_output_322_0_g528;
			float3 break132_g528 = finalBlendWeights146_g528;
			float4 channelY257_g528 = texArray133_g528;
			float4 channelZ256_g528 = texArray119_g528;
			float4 break98 = ( ( channelX258_g528 * break132_g528.x ) + ( channelY257_g528 * break132_g528.y ) + ( channelZ256_g528 * break132_g528.z ) );
			o.Metallic = break98;
			o.Smoothness = break98.w;
			o.Occlusion = break98.y;
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
0;-864;1536;843;6329.123;631.0189;2.872328;True;False
Node;AmplifyShaderEditor.RangedFloatNode;91;-4562.185,591.9663;Float;False;Property;_TextureScale;Texture Scale;22;0;Create;True;0;0;False;0;1;43.1;0;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;66;-5504,-209;Float;True;Property;_AlbedoH;Albedo H;23;0;Create;True;0;0;False;0;ffdd80285816c284eba749c21d10221e;a382312af245d45488af7b10260a0453;False;black;LockedToTexture2DArray;Texture2DArray;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexturePropertyNode;96;-5504,208;Float;True;Property;_MAOHS;MAOHS;25;0;Create;True;0;0;False;0;675b565102eae7742ac74c5459d876b0;bd7eb4fb25b086e4fa57c637943a8e79;True;black;LockedToTexture2DArray;Texture2DArray;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.DynamicAppendNode;92;-4241.085,478.8664;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;67;-5504,0;Float;True;Property;_Normal;Normal;24;1;[Normal];Create;True;0;0;False;0;675b565102eae7742ac74c5459d876b0;ad8d633127e33fe41b8cd79a01b6f088;True;bump;LockedToTexture2DArray;Texture2DArray;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FunctionNode;122;-3975.818,218.4562;Float;False;Triplanar Height Blend Material;0;;519;abdd403a4fe41fb439baa38a122194e7;0;9;36;SAMPLER2D;0;False;33;FLOAT;0;False;35;SAMPLER2D;0;False;38;SAMPLER2D;0;False;34;FLOAT;0;False;37;FLOAT;1;False;31;FLOAT2;1,1;False;51;FLOAT2;0,0;False;32;FLOAT;1;False;3;FLOAT4;0;FLOAT3;29;FLOAT4;30
Node;AmplifyShaderEditor.BreakToComponentsNode;98;-3414.293,454.1965;Float;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-3015.701,72.17162;Float;False;True;3;Float;ASEMaterialInspector;0;0;Standard;Heightblend Material Test;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;92;0;91;0
WireConnection;92;1;91;0
WireConnection;122;36;66;0
WireConnection;122;35;67;0
WireConnection;122;38;96;0
WireConnection;122;31;92;0
WireConnection;98;0;122;30
WireConnection;0;0;122;0
WireConnection;0;1;122;29
WireConnection;0;3;98;0
WireConnection;0;4;98;3
WireConnection;0;5;98;1
ASEEND*/
//CHKSM=CF2FA15C02EB7F76B3B622B7E1D6FBA3FDB8C9BF