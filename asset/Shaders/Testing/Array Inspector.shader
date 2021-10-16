// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "internal/testing/Array Inspector"
{
	Properties
	{
		_Index("Index", Float) = 0
		_TextureScale("Texture Scale", Vector) = (1,1,0,0)
		_MainTexture("Main Texture", 2DArray) = "white" {}
		[Normal]_Normal("Normal", 2DArray) = "white" {}
		_MAOHS("MAOHS", 2DArray) = "white" {}
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
		#pragma target 3.0
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
		uniform float2 _TextureScale;
		uniform float _Index;
		uniform UNITY_DECLARE_TEX2DARRAY( _MainTexture );
		uniform UNITY_DECLARE_TEX2DARRAY( _MAOHS );

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 break45_g349 = ase_worldNormal;
			float worldNormalZ217_g349 = break45_g349.z;
			float worldNormalY216_g349 = break45_g349.y;
			float3 worldNormalAbs95_g349 = abs( ase_worldNormal );
			float3 break43_g349 = worldNormalAbs95_g349;
			float worldNormalAbsX218_g349 = break43_g349.x;
			float3 appendResult327_g349 = (float3(worldNormalZ217_g349 , worldNormalY216_g349 , worldNormalAbsX218_g349));
			float3 n114_g354 = ( float3(0,0,1) + appendResult327_g349 );
			float3 ase_worldPos = i.worldPos;
			float2 appendResult13_g349 = (float2(ase_worldPos.z , ase_worldPos.y));
			float2 temp_output_51_0_g1 = float2( 0,0 );
			float2 textureOffset81_g349 = temp_output_51_0_g1;
			float2 temp_output_31_0_g1 = _TextureScale;
			float2 textureScale83_g349 = temp_output_31_0_g1;
			float2 uvX19_g349 = ( ( appendResult13_g349 + textureOffset81_g349 ) / textureScale83_g349 );
			float temp_output_34_0_g1 = _Index;
			float texIndex15_g349 = temp_output_34_0_g1;
			float normalScale30_g349 = 1.0;
			float3 texArray61_g349 = UnpackScaleNormal( UNITY_SAMPLE_TEX2DARRAY(_Normal, float3(uvX19_g349, texIndex15_g349)  ), normalScale30_g349 );
			float3 n215_g354 = ( texArray61_g349 * float3(-1,-1,1) );
			float dotResult9_g354 = dot( n114_g354 , n215_g354 );
			float3 break332_g349 = ( ( ( n114_g354 * dotResult9_g354 ) / (n114_g354).z ) - n215_g354 );
			float3 break225_g349 = sign( ase_worldNormal );
			float axisSignX223_g349 = (( break225_g349.x < 0.5 ) ? -1.0 :  1.0 );
			float3 appendResult264_g349 = (float3(( break332_g349.z * axisSignX223_g349 ) , break332_g349.y , break332_g349.x));
			float3 blendWeights59_g333 = float3( -1,-1,-1 );
			float3 break208_g333 = blendWeights59_g333;
			float3 worldNormalAbs95_g333 = abs( ase_worldNormal );
			float dotResult145_g333 = dot( worldNormalAbs95_g333 , float3( 1,1,1 ) );
			float blendChannel153_g333 = 3.0;
			float temp_output_2_0_g334 = blendChannel153_g333;
			float2 appendResult13_g333 = (float2(ase_worldPos.z , ase_worldPos.y));
			float2 textureOffset81_g333 = temp_output_51_0_g1;
			float2 textureScale83_g333 = temp_output_31_0_g1;
			float2 uvX19_g333 = ( ( appendResult13_g333 + textureOffset81_g333 ) / textureScale83_g333 );
			float texIndex15_g333 = _Index;
			float4 texArray139_g333 = UNITY_SAMPLE_TEX2DARRAY(_MainTexture, float3(uvX19_g333, texIndex15_g333)  );
			float4 break3_g334 = texArray139_g333;
			float channelBlendX160_g333 = (( temp_output_2_0_g334 >= 3.0 ) ? break3_g334.w :  (( temp_output_2_0_g334 >= 2.0 ) ? break3_g334.z :  (( temp_output_2_0_g334 >= 1.0 ) ? break3_g334.y :  break3_g334.x ) ) );
			float temp_output_2_0_g339 = blendChannel153_g333;
			float2 appendResult12_g333 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 uvY20_g333 = ( ( appendResult12_g333 + textureOffset81_g333 + float2( 0.33,0.33 ) ) / textureScale83_g333 );
			float4 texArray133_g333 = UNITY_SAMPLE_TEX2DARRAY(_MainTexture, float3(uvY20_g333, texIndex15_g333)  );
			float4 break3_g339 = texArray133_g333;
			float channelBlendY159_g333 = (( temp_output_2_0_g339 >= 3.0 ) ? break3_g339.w :  (( temp_output_2_0_g339 >= 2.0 ) ? break3_g339.z :  (( temp_output_2_0_g339 >= 1.0 ) ? break3_g339.y :  break3_g339.x ) ) );
			float temp_output_2_0_g340 = blendChannel153_g333;
			float2 appendResult11_g333 = (float2(ase_worldPos.x , ase_worldPos.y));
			float2 uvZ21_g333 = ( ( appendResult11_g333 + textureOffset81_g333 + float2( 0.66,0.66 ) ) / textureScale83_g333 );
			float4 texArray119_g333 = UNITY_SAMPLE_TEX2DARRAY(_MainTexture, float3(uvZ21_g333, texIndex15_g333)  );
			float4 break3_g340 = texArray119_g333;
			float channelBlendZ161_g333 = (( temp_output_2_0_g340 >= 3.0 ) ? break3_g340.w :  (( temp_output_2_0_g340 >= 2.0 ) ? break3_g340.z :  (( temp_output_2_0_g340 >= 1.0 ) ? break3_g340.y :  break3_g340.x ) ) );
			float3 appendResult165_g333 = (float3(channelBlendX160_g333 , channelBlendY159_g333 , channelBlendZ161_g333));
			float temp_output_32_0_g1 = 1.0;
			float clampResult184_g333 = clamp( temp_output_32_0_g1 , 0.0 , 1.0 );
			float channelBlendSharpness181_g333 = ( 1.0 - clampResult184_g333 );
			float temp_output_182_0_g333 = ( max( max( channelBlendX160_g333 , channelBlendY159_g333 ) , channelBlendZ161_g333 ) - channelBlendSharpness181_g333 );
			float3 appendResult189_g333 = (float3(temp_output_182_0_g333 , temp_output_182_0_g333 , temp_output_182_0_g333));
			float3 temp_output_186_0_g333 = max( ( ( ( ( worldNormalAbs95_g333 / dotResult145_g333 ) * float3( 3,3,3 ) ) + appendResult165_g333 ) - appendResult189_g333 ) , float3( 0,0,0 ) );
			float dotResult191_g333 = dot( temp_output_186_0_g333 , float3( 1,1,1 ) );
			float3 heightBlendWeights173_g333 = ( temp_output_186_0_g333 / dotResult191_g333 );
			float3 temp_output_214_0_g333 = (( ( break208_g333.x + break208_g333.y + break208_g333.z ) < 0.0 ) ? heightBlendWeights173_g333 :  blendWeights59_g333 );
			float3 break316_g333 = temp_output_214_0_g333;
			float3 temp_output_322_0_g333 = ( temp_output_214_0_g333 / ( break316_g333.x + break316_g333.y + break316_g333.z ) );
			float3 blendWeights59_g349 = temp_output_322_0_g333;
			float3 break208_g349 = blendWeights59_g349;
			float dotResult145_g349 = dot( worldNormalAbs95_g349 , float3( 1,1,1 ) );
			float blendChannel153_g349 = 3.0;
			float temp_output_2_0_g350 = blendChannel153_g349;
			float4 texArray139_g349 = UNITY_SAMPLE_TEX2DARRAY(_Normal, float3(uvX19_g349, texIndex15_g349)  );
			float4 break3_g350 = texArray139_g349;
			float channelBlendX160_g349 = (( temp_output_2_0_g350 >= 3.0 ) ? break3_g350.w :  (( temp_output_2_0_g350 >= 2.0 ) ? break3_g350.z :  (( temp_output_2_0_g350 >= 1.0 ) ? break3_g350.y :  break3_g350.x ) ) );
			float temp_output_2_0_g355 = blendChannel153_g349;
			float2 appendResult12_g349 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 uvY20_g349 = ( ( appendResult12_g349 + textureOffset81_g349 + float2( 0.33,0.33 ) ) / textureScale83_g349 );
			float4 texArray133_g349 = UNITY_SAMPLE_TEX2DARRAY(_Normal, float3(uvY20_g349, texIndex15_g349)  );
			float4 break3_g355 = texArray133_g349;
			float channelBlendY159_g349 = (( temp_output_2_0_g355 >= 3.0 ) ? break3_g355.w :  (( temp_output_2_0_g355 >= 2.0 ) ? break3_g355.z :  (( temp_output_2_0_g355 >= 1.0 ) ? break3_g355.y :  break3_g355.x ) ) );
			float temp_output_2_0_g356 = blendChannel153_g349;
			float2 appendResult11_g349 = (float2(ase_worldPos.x , ase_worldPos.y));
			float2 uvZ21_g349 = ( ( appendResult11_g349 + textureOffset81_g349 + float2( 0.66,0.66 ) ) / textureScale83_g349 );
			float4 texArray119_g349 = UNITY_SAMPLE_TEX2DARRAY(_Normal, float3(uvZ21_g349, texIndex15_g349)  );
			float4 break3_g356 = texArray119_g349;
			float channelBlendZ161_g349 = (( temp_output_2_0_g356 >= 3.0 ) ? break3_g356.w :  (( temp_output_2_0_g356 >= 2.0 ) ? break3_g356.z :  (( temp_output_2_0_g356 >= 1.0 ) ? break3_g356.y :  break3_g356.x ) ) );
			float3 appendResult165_g349 = (float3(channelBlendX160_g349 , channelBlendY159_g349 , channelBlendZ161_g349));
			float clampResult184_g349 = clamp( temp_output_32_0_g1 , 0.0 , 1.0 );
			float channelBlendSharpness181_g349 = ( 1.0 - clampResult184_g349 );
			float temp_output_182_0_g349 = ( max( max( channelBlendX160_g349 , channelBlendY159_g349 ) , channelBlendZ161_g349 ) - channelBlendSharpness181_g349 );
			float3 appendResult189_g349 = (float3(temp_output_182_0_g349 , temp_output_182_0_g349 , temp_output_182_0_g349));
			float3 temp_output_186_0_g349 = max( ( ( ( ( worldNormalAbs95_g349 / dotResult145_g349 ) * float3( 3,3,3 ) ) + appendResult165_g349 ) - appendResult189_g349 ) , float3( 0,0,0 ) );
			float dotResult191_g349 = dot( temp_output_186_0_g349 , float3( 1,1,1 ) );
			float3 heightBlendWeights173_g349 = ( temp_output_186_0_g349 / dotResult191_g349 );
			float3 temp_output_214_0_g349 = (( ( break208_g349.x + break208_g349.y + break208_g349.z ) < 0.0 ) ? heightBlendWeights173_g349 :  blendWeights59_g349 );
			float3 break316_g349 = temp_output_214_0_g349;
			float3 temp_output_322_0_g349 = ( temp_output_214_0_g349 / ( break316_g349.x + break316_g349.y + break316_g349.z ) );
			float3 finalBlendWeights146_g349 = temp_output_322_0_g349;
			float3 break66_g349 = finalBlendWeights146_g349;
			float worldNormalX215_g349 = break45_g349.x;
			float worldNormalAbsY219_g349 = break43_g349.y;
			float3 appendResult334_g349 = (float3(worldNormalX215_g349 , worldNormalZ217_g349 , worldNormalAbsY219_g349));
			float3 n114_g352 = ( float3(0,0,1) + appendResult334_g349 );
			float3 texArray28_g349 = UnpackScaleNormal( UNITY_SAMPLE_TEX2DARRAY(_Normal, float3(uvY20_g349, texIndex15_g349)  ), normalScale30_g349 );
			float3 n215_g352 = ( texArray28_g349 * float3(-1,-1,1) );
			float dotResult9_g352 = dot( n114_g352 , n215_g352 );
			float3 break338_g349 = ( ( ( n114_g352 * dotResult9_g352 ) / (n114_g352).z ) - n215_g352 );
			float axisSignY226_g349 = (( break225_g349.y < 0.5 ) ? -1.0 :  1.0 );
			float3 appendResult339_g349 = (float3(break338_g349.x , ( break338_g349.z * axisSignY226_g349 ) , break338_g349.y));
			float worldNormalAbsZ220_g349 = break43_g349.z;
			float3 appendResult343_g349 = (float3(worldNormalX215_g349 , worldNormalY216_g349 , worldNormalAbsZ220_g349));
			float3 n114_g351 = ( float3(0,0,1) + appendResult343_g349 );
			float3 texArray50_g349 = UnpackScaleNormal( UNITY_SAMPLE_TEX2DARRAY(_Normal, float3(uvZ21_g349, texIndex15_g349)  ), normalScale30_g349 );
			float3 n215_g351 = ( texArray50_g349 * float3(-1,-1,1) );
			float dotResult9_g351 = dot( n114_g351 , n215_g351 );
			float3 break347_g349 = ( ( ( n114_g351 * dotResult9_g351 ) / (n114_g351).z ) - n215_g351 );
			float axisSignZ227_g349 = (( break225_g349.z < 0.5 ) ? -1.0 :  1.0 );
			float3 appendResult348_g349 = (float3(break347_g349.x , break347_g349.y , ( break347_g349.z * axisSignZ227_g349 )));
			float3 normalizeResult62_g349 = normalize( ( ( appendResult264_g349 * break66_g349.x ) + ( appendResult339_g349 * break66_g349.y ) + ( appendResult348_g349 * break66_g349.z ) ) );
			float3 normalizeResult35_g353 = normalize( mul( float3x3((WorldNormalVector( i , float3(1,0,0) )), (WorldNormalVector( i , float3(0,1,0) )), (WorldNormalVector( i , float3(0,0,1) ))), normalizeResult62_g349 ) );
			float3 normalizeResult26_g1 = normalize( normalizeResult35_g353 );
			o.Normal = normalizeResult26_g1;
			float4 channelX258_g333 = texArray139_g333;
			float3 finalBlendWeights146_g333 = temp_output_322_0_g333;
			float3 break132_g333 = finalBlendWeights146_g333;
			float4 channelY257_g333 = texArray133_g333;
			float4 channelZ256_g333 = texArray119_g333;
			o.Albedo = ( ( channelX258_g333 * break132_g333.x ) + ( channelY257_g333 * break132_g333.y ) + ( channelZ256_g333 * break132_g333.z ) ).xyz;
			float2 appendResult13_g341 = (float2(ase_worldPos.z , ase_worldPos.y));
			float2 textureOffset81_g341 = temp_output_51_0_g1;
			float2 textureScale83_g341 = temp_output_31_0_g1;
			float2 uvX19_g341 = ( ( appendResult13_g341 + textureOffset81_g341 ) / textureScale83_g341 );
			float texIndex15_g341 = temp_output_34_0_g1;
			float4 texArray139_g341 = UNITY_SAMPLE_TEX2DARRAY(_MAOHS, float3(uvX19_g341, texIndex15_g341)  );
			float4 channelX258_g341 = texArray139_g341;
			float3 blendWeights59_g341 = temp_output_322_0_g349;
			float3 break208_g341 = blendWeights59_g341;
			float3 worldNormalAbs95_g341 = abs( ase_worldNormal );
			float dotResult145_g341 = dot( worldNormalAbs95_g341 , float3( 1,1,1 ) );
			float blendChannel153_g341 = 3.0;
			float temp_output_2_0_g342 = blendChannel153_g341;
			float4 break3_g342 = texArray139_g341;
			float channelBlendX160_g341 = (( temp_output_2_0_g342 >= 3.0 ) ? break3_g342.w :  (( temp_output_2_0_g342 >= 2.0 ) ? break3_g342.z :  (( temp_output_2_0_g342 >= 1.0 ) ? break3_g342.y :  break3_g342.x ) ) );
			float temp_output_2_0_g347 = blendChannel153_g341;
			float2 appendResult12_g341 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 uvY20_g341 = ( ( appendResult12_g341 + textureOffset81_g341 + float2( 0.33,0.33 ) ) / textureScale83_g341 );
			float4 texArray133_g341 = UNITY_SAMPLE_TEX2DARRAY(_MAOHS, float3(uvY20_g341, texIndex15_g341)  );
			float4 break3_g347 = texArray133_g341;
			float channelBlendY159_g341 = (( temp_output_2_0_g347 >= 3.0 ) ? break3_g347.w :  (( temp_output_2_0_g347 >= 2.0 ) ? break3_g347.z :  (( temp_output_2_0_g347 >= 1.0 ) ? break3_g347.y :  break3_g347.x ) ) );
			float temp_output_2_0_g348 = blendChannel153_g341;
			float2 appendResult11_g341 = (float2(ase_worldPos.x , ase_worldPos.y));
			float2 uvZ21_g341 = ( ( appendResult11_g341 + textureOffset81_g341 + float2( 0.66,0.66 ) ) / textureScale83_g341 );
			float4 texArray119_g341 = UNITY_SAMPLE_TEX2DARRAY(_MAOHS, float3(uvZ21_g341, texIndex15_g341)  );
			float4 break3_g348 = texArray119_g341;
			float channelBlendZ161_g341 = (( temp_output_2_0_g348 >= 3.0 ) ? break3_g348.w :  (( temp_output_2_0_g348 >= 2.0 ) ? break3_g348.z :  (( temp_output_2_0_g348 >= 1.0 ) ? break3_g348.y :  break3_g348.x ) ) );
			float3 appendResult165_g341 = (float3(channelBlendX160_g341 , channelBlendY159_g341 , channelBlendZ161_g341));
			float clampResult184_g341 = clamp( temp_output_32_0_g1 , 0.0 , 1.0 );
			float channelBlendSharpness181_g341 = ( 1.0 - clampResult184_g341 );
			float temp_output_182_0_g341 = ( max( max( channelBlendX160_g341 , channelBlendY159_g341 ) , channelBlendZ161_g341 ) - channelBlendSharpness181_g341 );
			float3 appendResult189_g341 = (float3(temp_output_182_0_g341 , temp_output_182_0_g341 , temp_output_182_0_g341));
			float3 temp_output_186_0_g341 = max( ( ( ( ( worldNormalAbs95_g341 / dotResult145_g341 ) * float3( 3,3,3 ) ) + appendResult165_g341 ) - appendResult189_g341 ) , float3( 0,0,0 ) );
			float dotResult191_g341 = dot( temp_output_186_0_g341 , float3( 1,1,1 ) );
			float3 heightBlendWeights173_g341 = ( temp_output_186_0_g341 / dotResult191_g341 );
			float3 temp_output_214_0_g341 = (( ( break208_g341.x + break208_g341.y + break208_g341.z ) < 0.0 ) ? heightBlendWeights173_g341 :  blendWeights59_g341 );
			float3 break316_g341 = temp_output_214_0_g341;
			float3 temp_output_322_0_g341 = ( temp_output_214_0_g341 / ( break316_g341.x + break316_g341.y + break316_g341.z ) );
			float3 finalBlendWeights146_g341 = temp_output_322_0_g341;
			float3 break132_g341 = finalBlendWeights146_g341;
			float4 channelY257_g341 = texArray133_g341;
			float4 channelZ256_g341 = texArray119_g341;
			float4 break2 = ( ( channelX258_g341 * break132_g341.x ) + ( channelY257_g341 * break132_g341.y ) + ( channelZ256_g341 * break132_g341.z ) );
			o.Metallic = break2;
			o.Smoothness = break2.w;
			o.Occlusion = break2.y;
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
			#pragma target 3.0
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
0;0;1280;659;1723.875;134.444;1;True;False
Node;AmplifyShaderEditor.TexturePropertyNode;4;-1463.079,125.9539;Float;True;Property;_Normal;Normal;25;1;[Normal];Create;True;0;0;False;0;None;None;False;white;LockedToTexture2DArray;Texture2DArray;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexturePropertyNode;3;-1357.013,-240;Float;True;Property;_MainTexture;Main Texture;24;0;Create;True;0;0;False;0;None;None;False;white;LockedToTexture2DArray;Texture2DArray;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1156.901,7.793832;Float;False;Property;_Index;Index;22;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;8;-1099.875,320.556;Float;False;Property;_TextureScale;Texture Scale;23;0;Create;True;0;0;False;0;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TexturePropertyNode;5;-1353.565,298.9387;Float;True;Property;_MAOHS;MAOHS;26;0;Create;True;0;0;False;0;None;None;False;white;LockedToTexture2DArray;Texture2DArray;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FunctionNode;1;-800,0;Float;False;Triplanar Height Blend Material;0;;1;abdd403a4fe41fb439baa38a122194e7;0;9;36;SAMPLER2D;0;False;33;FLOAT;0;False;35;SAMPLER2D;0;False;38;SAMPLER2D;0;False;34;FLOAT;0;False;37;FLOAT;1;False;31;FLOAT2;1,1;False;51;FLOAT2;0,0;False;32;FLOAT;1;False;3;FLOAT4;0;FLOAT3;29;FLOAT4;30
Node;AmplifyShaderEditor.BreakToComponentsNode;2;-320,128;Float;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;internal/testing/Array Inspector;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1;36;3;0
WireConnection;1;33;6;0
WireConnection;1;35;4;0
WireConnection;1;38;5;0
WireConnection;1;34;6;0
WireConnection;1;31;8;0
WireConnection;2;0;1;30
WireConnection;0;0;1;0
WireConnection;0;1;1;29
WireConnection;0;3;2;0
WireConnection;0;4;2;3
WireConnection;0;5;2;1
ASEEND*/
//CHKSM=E0E8B612C8C901351F8525017AE23EB06E9DD96A