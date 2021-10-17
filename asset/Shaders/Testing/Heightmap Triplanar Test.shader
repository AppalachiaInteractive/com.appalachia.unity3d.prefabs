// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "appalachia/testing/Heightmap Triplanar Test"
{
	Properties
	{
		_Albedo("Albedo", 2D) = "white" {}
		_Normal("Normal", 2D) = "bump" {}
		_MAOHS("MAOHS", 2D) = "black" {}
		_TextureOffset("Texture Offset", Vector) = (0,0,0,0)
		_TextureScale("Texture Scale", Range( 0.001 , 20)) = 1
		_BlendSharpness("Blend Sharpness", Range( 0 , 1)) = 0.5
		_NormalScale("Normal Scale", Range( 0 , 5)) = 1
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

		uniform sampler2D _Normal;
		uniform float _NormalScale;
		uniform float2 _TextureOffset;
		uniform float _TextureScale;
		uniform sampler2D _Albedo;
		uniform float _BlendSharpness;
		uniform sampler2D _MAOHS;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 break45_g98 = ase_worldNormal;
			float worldNormalZ217_g98 = break45_g98.z;
			float worldNormalY216_g98 = break45_g98.y;
			float3 temp_output_39_0_g98 = abs( ase_worldNormal );
			float3 worldNormalAbs95_g98 = temp_output_39_0_g98;
			float3 break43_g98 = worldNormalAbs95_g98;
			float worldNormalAbsX218_g98 = break43_g98.x;
			float3 appendResult42_g98 = (float3(worldNormalZ217_g98 , worldNormalY216_g98 , worldNormalAbsX218_g98));
			float3 temp_output_3_0_g102 = ( float3(0,0,1) + appendResult42_g98 );
			float normalScale30_g98 = _NormalScale;
			float3 ase_worldPos = i.worldPos;
			float2 appendResult13_g98 = (float2(ase_worldPos.z , ase_worldPos.y));
			float2 textureOffset81_g98 = _TextureOffset;
			float2 appendResult19 = (float2(_TextureScale , _TextureScale));
			float2 textureScale83_g98 = appendResult19;
			float2 uvX19_g98 = ( ( appendResult13_g98 + textureOffset81_g98 ) / textureScale83_g98 );
			float3 temp_output_8_0_g102 = ( UnpackScaleNormal( tex2D( _Normal, uvX19_g98 ), normalScale30_g98 ) * float3(-1,-1,1) );
			float dotResult9_g102 = dot( temp_output_3_0_g102 , temp_output_8_0_g102 );
			float3 break225_g98 = sign( ase_worldNormal );
			float axisSignZ227_g98 = break225_g98.y;
			float3 blendWeights59_g91 = float3( -1,-1,-1 );
			float3 break208_g91 = blendWeights59_g91;
			float3 temp_output_39_0_g91 = abs( ase_worldNormal );
			float3 worldNormalAbs95_g91 = temp_output_39_0_g91;
			float dotResult145_g91 = dot( worldNormalAbs95_g91 , float3( 1,1,1 ) );
			float blendChannel153_g91 = 3.0;
			float temp_output_2_0_g92 = blendChannel153_g91;
			float2 appendResult13_g91 = (float2(ase_worldPos.z , ase_worldPos.y));
			float2 textureOffset81_g91 = _TextureOffset;
			float2 textureScale83_g91 = appendResult19;
			float2 uvX19_g91 = ( ( appendResult13_g91 + textureOffset81_g91 ) / textureScale83_g91 );
			float4 break3_g92 = tex2D( _Albedo, uvX19_g91 );
			float channelBlendX160_g91 = (( temp_output_2_0_g92 >= 3.0 ) ? break3_g92.w :  (( temp_output_2_0_g92 >= 2.0 ) ? break3_g92.z :  (( temp_output_2_0_g92 >= 1.0 ) ? break3_g92.y :  break3_g92.x ) ) );
			float temp_output_2_0_g94 = blendChannel153_g91;
			float2 appendResult12_g91 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 uvY20_g91 = ( ( appendResult12_g91 + textureOffset81_g91 ) / textureScale83_g91 );
			float4 break3_g94 = tex2D( _Albedo, uvY20_g91 );
			float channelBlendY159_g91 = (( temp_output_2_0_g94 >= 3.0 ) ? break3_g94.w :  (( temp_output_2_0_g94 >= 2.0 ) ? break3_g94.z :  (( temp_output_2_0_g94 >= 1.0 ) ? break3_g94.y :  break3_g94.x ) ) );
			float temp_output_2_0_g93 = blendChannel153_g91;
			float2 appendResult11_g91 = (float2(ase_worldPos.x , ase_worldPos.y));
			float2 uvZ21_g91 = ( ( appendResult11_g91 + textureOffset81_g91 ) / textureScale83_g91 );
			float4 break3_g93 = tex2D( _Albedo, uvZ21_g91 );
			float channelBlendZ161_g91 = (( temp_output_2_0_g93 >= 3.0 ) ? break3_g93.w :  (( temp_output_2_0_g93 >= 2.0 ) ? break3_g93.z :  (( temp_output_2_0_g93 >= 1.0 ) ? break3_g93.y :  break3_g93.x ) ) );
			float3 appendResult165_g91 = (float3(channelBlendX160_g91 , channelBlendY159_g91 , channelBlendZ161_g91));
			float clampResult184_g91 = clamp( _BlendSharpness , 0.0 , 1.0 );
			float channelBlendSharpness181_g91 = ( 1.0 - clampResult184_g91 );
			float temp_output_182_0_g91 = ( max( max( channelBlendX160_g91 , channelBlendY159_g91 ) , channelBlendZ161_g91 ) - channelBlendSharpness181_g91 );
			float3 appendResult189_g91 = (float3(temp_output_182_0_g91 , temp_output_182_0_g91 , temp_output_182_0_g91));
			float3 temp_output_186_0_g91 = max( ( ( ( ( worldNormalAbs95_g91 / dotResult145_g91 ) * float3( 3,3,3 ) ) + appendResult165_g91 ) - appendResult189_g91 ) , float3( 0,0,0 ) );
			float dotResult191_g91 = dot( temp_output_186_0_g91 , float3( 1,1,1 ) );
			float3 heightBlendWeights173_g91 = ( temp_output_186_0_g91 / dotResult191_g91 );
			float3 temp_output_214_0_g91 = (( ( break208_g91.x + break208_g91.y + break208_g91.z ) < 0.0 ) ? heightBlendWeights173_g91 :  blendWeights59_g91 );
			float3 blendWeights59_g98 = temp_output_214_0_g91;
			float3 break208_g98 = blendWeights59_g98;
			float dotResult145_g98 = dot( worldNormalAbs95_g98 , float3( 1,1,1 ) );
			float blendChannel153_g98 = 3.0;
			float temp_output_2_0_g99 = blendChannel153_g98;
			float4 break3_g99 = tex2D( _Normal, uvX19_g98 );
			float channelBlendX160_g98 = (( temp_output_2_0_g99 >= 3.0 ) ? break3_g99.w :  (( temp_output_2_0_g99 >= 2.0 ) ? break3_g99.z :  (( temp_output_2_0_g99 >= 1.0 ) ? break3_g99.y :  break3_g99.x ) ) );
			float temp_output_2_0_g101 = blendChannel153_g98;
			float2 appendResult12_g98 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 uvY20_g98 = ( ( appendResult12_g98 + textureOffset81_g98 ) / textureScale83_g98 );
			float4 break3_g101 = tex2D( _Normal, uvY20_g98 );
			float channelBlendY159_g98 = (( temp_output_2_0_g101 >= 3.0 ) ? break3_g101.w :  (( temp_output_2_0_g101 >= 2.0 ) ? break3_g101.z :  (( temp_output_2_0_g101 >= 1.0 ) ? break3_g101.y :  break3_g101.x ) ) );
			float temp_output_2_0_g100 = blendChannel153_g98;
			float2 appendResult11_g98 = (float2(ase_worldPos.x , ase_worldPos.y));
			float2 uvZ21_g98 = ( ( appendResult11_g98 + textureOffset81_g98 ) / textureScale83_g98 );
			float4 break3_g100 = tex2D( _Normal, uvZ21_g98 );
			float channelBlendZ161_g98 = (( temp_output_2_0_g100 >= 3.0 ) ? break3_g100.w :  (( temp_output_2_0_g100 >= 2.0 ) ? break3_g100.z :  (( temp_output_2_0_g100 >= 1.0 ) ? break3_g100.y :  break3_g100.x ) ) );
			float3 appendResult165_g98 = (float3(channelBlendX160_g98 , channelBlendY159_g98 , channelBlendZ161_g98));
			float clampResult184_g98 = clamp( _BlendSharpness , 0.0 , 1.0 );
			float channelBlendSharpness181_g98 = ( 1.0 - clampResult184_g98 );
			float temp_output_182_0_g98 = ( max( max( channelBlendX160_g98 , channelBlendY159_g98 ) , channelBlendZ161_g98 ) - channelBlendSharpness181_g98 );
			float3 appendResult189_g98 = (float3(temp_output_182_0_g98 , temp_output_182_0_g98 , temp_output_182_0_g98));
			float3 temp_output_186_0_g98 = max( ( ( ( ( worldNormalAbs95_g98 / dotResult145_g98 ) * float3( 3,3,3 ) ) + appendResult165_g98 ) - appendResult189_g98 ) , float3( 0,0,0 ) );
			float dotResult191_g98 = dot( temp_output_186_0_g98 , float3( 1,1,1 ) );
			float3 heightBlendWeights173_g98 = ( temp_output_186_0_g98 / dotResult191_g98 );
			float3 temp_output_214_0_g98 = (( ( break208_g98.x + break208_g98.y + break208_g98.z ) < 0.0 ) ? heightBlendWeights173_g98 :  blendWeights59_g98 );
			float3 finalBlendWeights146_g98 = temp_output_214_0_g98;
			float3 break66_g98 = finalBlendWeights146_g98;
			float3 temp_output_3_0_g104 = ( float3(0,0,1) + float3( 0,0,0 ) );
			float3 temp_output_8_0_g104 = ( UnpackScaleNormal( tex2D( _Normal, uvY20_g98 ), normalScale30_g98 ) * float3(-1,-1,1) );
			float dotResult9_g104 = dot( temp_output_3_0_g104 , temp_output_8_0_g104 );
			float3 temp_output_3_0_g103 = ( float3(0,0,1) + float3( 0,0,0 ) );
			float3 temp_output_8_0_g103 = ( UnpackScaleNormal( tex2D( _Normal, uvZ21_g98 ), normalScale30_g98 ) * float3(-1,-1,1) );
			float dotResult9_g103 = dot( temp_output_3_0_g103 , temp_output_8_0_g103 );
			float3 normalizeResult62_g98 = normalize( ( ( ( ( ( ( temp_output_3_0_g102 * dotResult9_g102 ) / temp_output_3_0_g102.z ) - temp_output_8_0_g102 ) * axisSignZ227_g98 ) * break66_g98.x ) + ( ( ( ( ( temp_output_3_0_g104 * dotResult9_g104 ) / temp_output_3_0_g104.z ) - temp_output_8_0_g104 ) * axisSignZ227_g98 ) * break66_g98.y ) + ( ( ( ( ( temp_output_3_0_g103 * dotResult9_g103 ) / temp_output_3_0_g103.z ) - temp_output_8_0_g103 ) * axisSignZ227_g98 ) * break66_g98.z ) ) );
			o.Normal = normalizeResult62_g98;
			float3 finalBlendWeights146_g91 = temp_output_214_0_g91;
			float3 break132_g91 = finalBlendWeights146_g91;
			o.Albedo = ( ( tex2D( _Albedo, uvX19_g91 ) * break132_g91.x ) + ( tex2D( _Albedo, uvY20_g91 ) * break132_g91.y ) + ( tex2D( _Albedo, uvZ21_g91 ) * break132_g91.z ) ).rgb;
			float2 appendResult13_g105 = (float2(ase_worldPos.z , ase_worldPos.y));
			float2 textureOffset81_g105 = _TextureOffset;
			float2 textureScale83_g105 = appendResult19;
			float2 uvX19_g105 = ( ( appendResult13_g105 + textureOffset81_g105 ) / textureScale83_g105 );
			float3 blendWeights59_g105 = temp_output_214_0_g98;
			float3 break208_g105 = blendWeights59_g105;
			float3 temp_output_39_0_g105 = abs( ase_worldNormal );
			float3 worldNormalAbs95_g105 = temp_output_39_0_g105;
			float dotResult145_g105 = dot( worldNormalAbs95_g105 , float3( 1,1,1 ) );
			float blendChannel153_g105 = 3.0;
			float temp_output_2_0_g106 = blendChannel153_g105;
			float4 break3_g106 = tex2D( _MAOHS, uvX19_g105 );
			float channelBlendX160_g105 = (( temp_output_2_0_g106 >= 3.0 ) ? break3_g106.w :  (( temp_output_2_0_g106 >= 2.0 ) ? break3_g106.z :  (( temp_output_2_0_g106 >= 1.0 ) ? break3_g106.y :  break3_g106.x ) ) );
			float temp_output_2_0_g108 = blendChannel153_g105;
			float2 appendResult12_g105 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 uvY20_g105 = ( ( appendResult12_g105 + textureOffset81_g105 ) / textureScale83_g105 );
			float4 break3_g108 = tex2D( _MAOHS, uvY20_g105 );
			float channelBlendY159_g105 = (( temp_output_2_0_g108 >= 3.0 ) ? break3_g108.w :  (( temp_output_2_0_g108 >= 2.0 ) ? break3_g108.z :  (( temp_output_2_0_g108 >= 1.0 ) ? break3_g108.y :  break3_g108.x ) ) );
			float temp_output_2_0_g107 = blendChannel153_g105;
			float2 appendResult11_g105 = (float2(ase_worldPos.x , ase_worldPos.y));
			float2 uvZ21_g105 = ( ( appendResult11_g105 + textureOffset81_g105 ) / textureScale83_g105 );
			float4 break3_g107 = tex2D( _MAOHS, uvZ21_g105 );
			float channelBlendZ161_g105 = (( temp_output_2_0_g107 >= 3.0 ) ? break3_g107.w :  (( temp_output_2_0_g107 >= 2.0 ) ? break3_g107.z :  (( temp_output_2_0_g107 >= 1.0 ) ? break3_g107.y :  break3_g107.x ) ) );
			float3 appendResult165_g105 = (float3(channelBlendX160_g105 , channelBlendY159_g105 , channelBlendZ161_g105));
			float clampResult184_g105 = clamp( _BlendSharpness , 0.0 , 1.0 );
			float channelBlendSharpness181_g105 = ( 1.0 - clampResult184_g105 );
			float temp_output_182_0_g105 = ( max( max( channelBlendX160_g105 , channelBlendY159_g105 ) , channelBlendZ161_g105 ) - channelBlendSharpness181_g105 );
			float3 appendResult189_g105 = (float3(temp_output_182_0_g105 , temp_output_182_0_g105 , temp_output_182_0_g105));
			float3 temp_output_186_0_g105 = max( ( ( ( ( worldNormalAbs95_g105 / dotResult145_g105 ) * float3( 3,3,3 ) ) + appendResult165_g105 ) - appendResult189_g105 ) , float3( 0,0,0 ) );
			float dotResult191_g105 = dot( temp_output_186_0_g105 , float3( 1,1,1 ) );
			float3 heightBlendWeights173_g105 = ( temp_output_186_0_g105 / dotResult191_g105 );
			float3 temp_output_214_0_g105 = (( ( break208_g105.x + break208_g105.y + break208_g105.z ) < 0.0 ) ? heightBlendWeights173_g105 :  blendWeights59_g105 );
			float3 finalBlendWeights146_g105 = temp_output_214_0_g105;
			float3 break132_g105 = finalBlendWeights146_g105;
			float4 break23 = ( ( tex2D( _MAOHS, uvX19_g105 ) * break132_g105.x ) + ( tex2D( _MAOHS, uvY20_g105 ) * break132_g105.y ) + ( tex2D( _MAOHS, uvZ21_g105 ) * break132_g105.z ) );
			o.Metallic = break23;
			o.Smoothness = break23.a;
			o.Occlusion = break23.g;
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
0;0;1280;659;1783.341;129.7518;2.067907;True;False
Node;AmplifyShaderEditor.RangedFloatNode;17;-2188,888;Float;False;Property;_TextureScale;Texture Scale;11;0;Create;True;0;0;False;0;1;0;0.001;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;16;-2048,752;Float;False;Property;_TextureOffset;Texture Offset;10;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.DynamicAppendNode;19;-1840,880;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;13;-2048,0;Float;True;Property;_Albedo;Albedo;7;0;Create;True;0;0;False;0;None;None;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-1956,983;Float;False;Property;_BlendSharpness;Blend Sharpness;12;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;14;-2048,256;Float;True;Property;_Normal;Normal;8;0;Create;True;0;0;False;0;None;None;False;bump;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-1912,1067;Float;False;Property;_NormalScale;Normal Scale;13;0;Create;True;0;0;False;0;1;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;20;-1536,0;Float;False;Heightmap Triplanar Sample;0;;91;806427b3683dbd846b8c6c12b2c40220;8,3,0,32,0,175,0,136,0,64,0,74,0,122,0,124,0;9;7;SAMPLER2D;0;False;6;FLOAT;0;False;80;FLOAT2;1,0;False;82;FLOAT2;1,0;False;29;FLOAT;1;False;76;FLOAT;1;False;180;FLOAT;1;False;152;FLOAT;3;False;60;FLOAT3;-1,-1,-1;False;2;COLOR;0;FLOAT3;196
Node;AmplifyShaderEditor.TexturePropertyNode;15;-2048,512;Float;True;Property;_MAOHS;MAOHS;9;0;Create;True;0;0;False;0;None;None;False;black;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FunctionNode;21;-1088,192;Float;False;Heightmap Triplanar Sample;0;;98;806427b3683dbd846b8c6c12b2c40220;8,3,0,32,1,175,0,136,0,64,0,74,0,122,0,124,0;9;7;SAMPLER2D;0;False;6;FLOAT;0;False;80;FLOAT2;1,0;False;82;FLOAT2;1,0;False;29;FLOAT;1;False;76;FLOAT;1;False;180;FLOAT;1;False;152;FLOAT;3;False;60;FLOAT3;-1,-1,-1;False;2;FLOAT3;0;FLOAT3;196
Node;AmplifyShaderEditor.FunctionNode;22;-638.7,449.3;Float;False;Heightmap Triplanar Sample;0;;105;806427b3683dbd846b8c6c12b2c40220;8,3,0,32,0,175,0,136,0,64,0,74,0,122,0,124,0;9;7;SAMPLER2D;0;False;6;FLOAT;0;False;80;FLOAT2;1,0;False;82;FLOAT2;1,0;False;29;FLOAT;1;False;76;FLOAT;1;False;180;FLOAT;1;False;152;FLOAT;3;False;60;FLOAT3;-1,-1,-1;False;2;COLOR;0;FLOAT3;196
Node;AmplifyShaderEditor.BreakToComponentsNode;23;-182,372;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;128,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;appalachia/testing/Heightmap Triplanar Test;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;19;0;17;0
WireConnection;19;1;17;0
WireConnection;20;7;13;0
WireConnection;20;80;16;0
WireConnection;20;82;19;0
WireConnection;20;180;24;0
WireConnection;21;7;14;0
WireConnection;21;80;16;0
WireConnection;21;82;19;0
WireConnection;21;29;25;0
WireConnection;21;180;24;0
WireConnection;21;60;20;196
WireConnection;22;7;15;0
WireConnection;22;80;16;0
WireConnection;22;82;19;0
WireConnection;22;180;24;0
WireConnection;22;60;21;196
WireConnection;23;0;22;0
WireConnection;0;0;20;0
WireConnection;0;1;21;0
WireConnection;0;3;23;0
WireConnection;0;4;23;3
WireConnection;0;5;23;1
ASEEND*/
//CHKSM=E0520AAEF3A7D0585823950188630920970FFE80