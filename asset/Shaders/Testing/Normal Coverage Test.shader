// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Normal Coverage Test"
{
	Properties
	{
		_CoverageNormalBasis("Coverage Normal Basis", Vector) = (0,0.5,0,0)
		_TextureScale("Texture Scale", Range( 0 , 50)) = 1
		_CoverageNormalRange("Coverage Normal Range", Vector) = (0.5,1,0.5,0)
		_FadeSmoothness("Fade Smoothness", Range( 0 , 1)) = 0.01
		_Height("Height", 2D) = "black" {}
		[Normal]_Normal("Normal", 2D) = "bump" {}
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
		uniform float _TextureScale;
		uniform sampler2D _Height;
		uniform float3 _CoverageNormalBasis;
		uniform float3 _CoverageNormalRange;
		uniform float _FadeSmoothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Normal = float3(0,0,1);
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_normWorldNormal = normalize( ase_worldNormal );
			float3 break45_g106 = ase_worldNormal;
			float3 temp_output_39_0_g106 = abs( ase_worldNormal );
			float3 worldNormalAbs95_g106 = temp_output_39_0_g106;
			float3 break43_g106 = worldNormalAbs95_g106;
			float3 appendResult42_g106 = (float3(break45_g106.z , break45_g106.y , break43_g106.x));
			float3 temp_output_3_0_g107 = ( float3(0,0,1) + appendResult42_g106 );
			float normalScale30_g106 = 1.0;
			float3 ase_worldPos = i.worldPos;
			float2 appendResult13_g106 = (float2(ase_worldPos.z , ase_worldPos.y));
			float2 textureOffset81_g106 = float2( 0,0 );
			float2 appendResult92 = (float2(_TextureScale , _TextureScale));
			float2 textureScale83_g106 = appendResult92;
			float2 uvX19_g106 = ( ( appendResult13_g106 + textureOffset81_g106 ) / textureScale83_g106 );
			float3 temp_output_8_0_g107 = ( UnpackScaleNormal( tex2D( _Normal, uvX19_g106 ), normalScale30_g106 ) * float3(-1,-1,1) );
			float dotResult9_g107 = dot( temp_output_3_0_g107 , temp_output_8_0_g107 );
			float3 blendWeights59_g99 = float3( -1,-1,-1 );
			float3 break208_g99 = blendWeights59_g99;
			float3 temp_output_39_0_g99 = abs( ase_worldNormal );
			float3 worldNormalAbs95_g99 = temp_output_39_0_g99;
			float dotResult145_g99 = dot( worldNormalAbs95_g99 , float3( 1,1,1 ) );
			float blendChannel153_g99 = 0.0;
			float temp_output_2_0_g103 = blendChannel153_g99;
			float2 appendResult13_g99 = (float2(ase_worldPos.z , ase_worldPos.y));
			float2 textureOffset81_g99 = float2( 0,0 );
			float2 textureScale83_g99 = appendResult92;
			float2 uvX19_g99 = ( ( appendResult13_g99 + textureOffset81_g99 ) / textureScale83_g99 );
			float4 break3_g103 = tex2D( _Height, uvX19_g99 );
			float channelBlendX160_g99 = (( temp_output_2_0_g103 >= 3.0 ) ? break3_g103.w :  (( temp_output_2_0_g103 >= 2.0 ) ? break3_g103.z :  (( temp_output_2_0_g103 >= 1.0 ) ? break3_g103.y :  break3_g103.x ) ) );
			float temp_output_2_0_g101 = blendChannel153_g99;
			float2 appendResult12_g99 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 uvY20_g99 = ( ( appendResult12_g99 + textureOffset81_g99 ) / textureScale83_g99 );
			float4 break3_g101 = tex2D( _Height, uvY20_g99 );
			float channelBlendY159_g99 = (( temp_output_2_0_g101 >= 3.0 ) ? break3_g101.w :  (( temp_output_2_0_g101 >= 2.0 ) ? break3_g101.z :  (( temp_output_2_0_g101 >= 1.0 ) ? break3_g101.y :  break3_g101.x ) ) );
			float temp_output_2_0_g104 = blendChannel153_g99;
			float2 appendResult11_g99 = (float2(ase_worldPos.x , ase_worldPos.y));
			float2 uvZ21_g99 = ( ( appendResult11_g99 + textureOffset81_g99 ) / textureScale83_g99 );
			float4 break3_g104 = tex2D( _Height, uvZ21_g99 );
			float channelBlendZ161_g99 = (( temp_output_2_0_g104 >= 3.0 ) ? break3_g104.w :  (( temp_output_2_0_g104 >= 2.0 ) ? break3_g104.z :  (( temp_output_2_0_g104 >= 1.0 ) ? break3_g104.y :  break3_g104.x ) ) );
			float3 appendResult165_g99 = (float3(channelBlendX160_g99 , channelBlendY159_g99 , channelBlendZ161_g99));
			float clampResult184_g99 = clamp( 1.0 , 0.0 , 1.0 );
			float channelBlendSharpness181_g99 = ( 1.0 - clampResult184_g99 );
			float temp_output_182_0_g99 = ( max( max( channelBlendX160_g99 , channelBlendY159_g99 ) , channelBlendZ161_g99 ) - channelBlendSharpness181_g99 );
			float3 appendResult189_g99 = (float3(temp_output_182_0_g99 , temp_output_182_0_g99 , temp_output_182_0_g99));
			float3 temp_output_186_0_g99 = max( ( ( ( ( worldNormalAbs95_g99 / dotResult145_g99 ) * float3( 3,3,3 ) ) + appendResult165_g99 ) - appendResult189_g99 ) , float3( 0,0,0 ) );
			float dotResult191_g99 = dot( temp_output_186_0_g99 , float3( 1,1,1 ) );
			float3 heightBlendWeights173_g99 = ( temp_output_186_0_g99 / dotResult191_g99 );
			float3 temp_output_214_0_g99 = (( ( break208_g99.x + break208_g99.y + break208_g99.z ) < 0.0 ) ? heightBlendWeights173_g99 :  blendWeights59_g99 );
			float3 blendWeights59_g106 = temp_output_214_0_g99;
			float3 break208_g106 = blendWeights59_g106;
			float dotResult145_g106 = dot( worldNormalAbs95_g106 , float3( 1,1,1 ) );
			float blendChannel153_g106 = 3.0;
			float temp_output_2_0_g110 = blendChannel153_g106;
			float4 break3_g110 = tex2D( _Normal, uvX19_g106 );
			float channelBlendX160_g106 = (( temp_output_2_0_g110 >= 3.0 ) ? break3_g110.w :  (( temp_output_2_0_g110 >= 2.0 ) ? break3_g110.z :  (( temp_output_2_0_g110 >= 1.0 ) ? break3_g110.y :  break3_g110.x ) ) );
			float temp_output_2_0_g108 = blendChannel153_g106;
			float2 appendResult12_g106 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 uvY20_g106 = ( ( appendResult12_g106 + textureOffset81_g106 ) / textureScale83_g106 );
			float4 break3_g108 = tex2D( _Normal, uvY20_g106 );
			float channelBlendY159_g106 = (( temp_output_2_0_g108 >= 3.0 ) ? break3_g108.w :  (( temp_output_2_0_g108 >= 2.0 ) ? break3_g108.z :  (( temp_output_2_0_g108 >= 1.0 ) ? break3_g108.y :  break3_g108.x ) ) );
			float temp_output_2_0_g111 = blendChannel153_g106;
			float2 appendResult11_g106 = (float2(ase_worldPos.x , ase_worldPos.y));
			float2 uvZ21_g106 = ( ( appendResult11_g106 + textureOffset81_g106 ) / textureScale83_g106 );
			float4 break3_g111 = tex2D( _Normal, uvZ21_g106 );
			float channelBlendZ161_g106 = (( temp_output_2_0_g111 >= 3.0 ) ? break3_g111.w :  (( temp_output_2_0_g111 >= 2.0 ) ? break3_g111.z :  (( temp_output_2_0_g111 >= 1.0 ) ? break3_g111.y :  break3_g111.x ) ) );
			float3 appendResult165_g106 = (float3(channelBlendX160_g106 , channelBlendY159_g106 , channelBlendZ161_g106));
			float clampResult184_g106 = clamp( 1.0 , 0.0 , 1.0 );
			float channelBlendSharpness181_g106 = ( 1.0 - clampResult184_g106 );
			float temp_output_182_0_g106 = ( max( max( channelBlendX160_g106 , channelBlendY159_g106 ) , channelBlendZ161_g106 ) - channelBlendSharpness181_g106 );
			float3 appendResult189_g106 = (float3(temp_output_182_0_g106 , temp_output_182_0_g106 , temp_output_182_0_g106));
			float3 temp_output_186_0_g106 = max( ( ( ( ( worldNormalAbs95_g106 / dotResult145_g106 ) * float3( 3,3,3 ) ) + appendResult165_g106 ) - appendResult189_g106 ) , float3( 0,0,0 ) );
			float dotResult191_g106 = dot( temp_output_186_0_g106 , float3( 1,1,1 ) );
			float3 heightBlendWeights173_g106 = ( temp_output_186_0_g106 / dotResult191_g106 );
			float3 temp_output_214_0_g106 = (( ( break208_g106.x + break208_g106.y + break208_g106.z ) < 0.0 ) ? heightBlendWeights173_g106 :  blendWeights59_g106 );
			float3 finalBlendWeights146_g106 = temp_output_214_0_g106;
			float3 break66_g106 = finalBlendWeights146_g106;
			float3 appendResult46_g106 = (float3(break45_g106.x , break45_g106.z , break43_g106.y));
			float3 temp_output_3_0_g109 = ( float3(0,0,1) + appendResult46_g106 );
			float3 temp_output_8_0_g109 = ( UnpackScaleNormal( tex2D( _Normal, uvY20_g106 ), normalScale30_g106 ) * float3(-1,-1,1) );
			float dotResult9_g109 = dot( temp_output_3_0_g109 , temp_output_8_0_g109 );
			float3 appendResult47_g106 = (float3(break45_g106.x , break43_g106.y , break43_g106.z));
			float3 temp_output_3_0_g112 = ( float3(0,0,1) + appendResult47_g106 );
			float3 temp_output_8_0_g112 = ( UnpackScaleNormal( tex2D( _Normal, uvZ21_g106 ), normalScale30_g106 ) * float3(-1,-1,1) );
			float dotResult9_g112 = dot( temp_output_3_0_g112 , temp_output_8_0_g112 );
			float3 break54_g106 = sign( ase_worldNormal );
			float3 normalizeResult62_g106 = normalize( ( ( ( ( ( temp_output_3_0_g107 * dotResult9_g107 ) / temp_output_3_0_g107.z ) - temp_output_8_0_g107 ) * break66_g106.x ) + ( ( ( ( temp_output_3_0_g109 * dotResult9_g109 ) / temp_output_3_0_g109.z ) - temp_output_8_0_g109 ) * break66_g106.y ) + ( ( ( ( ( ( ( temp_output_3_0_g112 * dotResult9_g112 ) / temp_output_3_0_g112.z ) - temp_output_8_0_g112 ) * break54_g106.x ) * break54_g106.y ) * break54_g106.z ) * break66_g106.z ) ) );
			float3 break47 = (WorldNormalVector( i , normalizeResult62_g106 ));
			float temp_output_44_0_g153 = break47.x;
			float3 break55 = _CoverageNormalBasis;
			float clampResult50 = clamp( break55.x , -1.0 , 1.0 );
			float temp_output_42_0_g153 = clampResult50;
			float3 break51 = _CoverageNormalRange;
			float temp_output_52_0 = saturate( break51.x );
			float temp_output_6_0_g153 = temp_output_52_0;
			float temp_output_45_0_g153 = ( temp_output_42_0_g153 + temp_output_6_0_g153 );
			float temp_output_49_0 = saturate( _FadeSmoothness );
			float temp_output_36_0_g153 = ( temp_output_52_0 * temp_output_49_0 );
			float temp_output_48_0_g153 = ( temp_output_45_0_g153 + temp_output_36_0_g153 );
			float temp_output_7_0_g154 = temp_output_48_0_g153;
			float temp_output_47_0_g153 = ( temp_output_42_0_g153 - temp_output_6_0_g153 );
			float temp_output_50_0_g153 = ( temp_output_47_0_g153 - temp_output_36_0_g153 );
			float temp_output_7_0_g155 = temp_output_50_0_g153;
			float smoothstepResult64_g153 = smoothstep( 0.0 , 1.0 , ( (( temp_output_44_0_g153 >= temp_output_45_0_g153 && temp_output_44_0_g153 <= temp_output_48_0_g153 ) ? ( ( temp_output_44_0_g153 - temp_output_7_0_g154 ) / ( temp_output_45_0_g153 - temp_output_7_0_g154 ) ) :  0.0 ) + (( temp_output_44_0_g153 >= temp_output_47_0_g153 && temp_output_44_0_g153 <= temp_output_45_0_g153 ) ? 1.0 :  0.0 ) + (( temp_output_44_0_g153 >= temp_output_50_0_g153 && temp_output_44_0_g153 <= temp_output_47_0_g153 ) ? ( ( temp_output_44_0_g153 - temp_output_7_0_g155 ) / ( temp_output_47_0_g153 - temp_output_7_0_g155 ) ) :  0.0 ) ));
			float temp_output_44_0_g159 = break47.y;
			float clampResult56 = clamp( break55.y , -1.0 , 1.0 );
			float temp_output_42_0_g159 = clampResult56;
			float temp_output_53_0 = saturate( break51.y );
			float temp_output_6_0_g159 = temp_output_53_0;
			float temp_output_45_0_g159 = ( temp_output_42_0_g159 + temp_output_6_0_g159 );
			float temp_output_36_0_g159 = ( temp_output_53_0 * temp_output_49_0 );
			float temp_output_48_0_g159 = ( temp_output_45_0_g159 + temp_output_36_0_g159 );
			float temp_output_7_0_g160 = temp_output_48_0_g159;
			float temp_output_47_0_g159 = ( temp_output_42_0_g159 - temp_output_6_0_g159 );
			float temp_output_50_0_g159 = ( temp_output_47_0_g159 - temp_output_36_0_g159 );
			float temp_output_7_0_g161 = temp_output_50_0_g159;
			float smoothstepResult64_g159 = smoothstep( 0.0 , 1.0 , ( (( temp_output_44_0_g159 >= temp_output_45_0_g159 && temp_output_44_0_g159 <= temp_output_48_0_g159 ) ? ( ( temp_output_44_0_g159 - temp_output_7_0_g160 ) / ( temp_output_45_0_g159 - temp_output_7_0_g160 ) ) :  0.0 ) + (( temp_output_44_0_g159 >= temp_output_47_0_g159 && temp_output_44_0_g159 <= temp_output_45_0_g159 ) ? 1.0 :  0.0 ) + (( temp_output_44_0_g159 >= temp_output_50_0_g159 && temp_output_44_0_g159 <= temp_output_47_0_g159 ) ? ( ( temp_output_44_0_g159 - temp_output_7_0_g161 ) / ( temp_output_47_0_g159 - temp_output_7_0_g161 ) ) :  0.0 ) ));
			float temp_output_44_0_g156 = break47.z;
			float clampResult37 = clamp( break55.z , -1.0 , 1.0 );
			float temp_output_42_0_g156 = clampResult37;
			float temp_output_54_0 = saturate( break51.z );
			float temp_output_6_0_g156 = temp_output_54_0;
			float temp_output_45_0_g156 = ( temp_output_42_0_g156 + temp_output_6_0_g156 );
			float temp_output_36_0_g156 = ( temp_output_54_0 * temp_output_49_0 );
			float temp_output_48_0_g156 = ( temp_output_45_0_g156 + temp_output_36_0_g156 );
			float temp_output_7_0_g157 = temp_output_48_0_g156;
			float temp_output_47_0_g156 = ( temp_output_42_0_g156 - temp_output_6_0_g156 );
			float temp_output_50_0_g156 = ( temp_output_47_0_g156 - temp_output_36_0_g156 );
			float temp_output_7_0_g158 = temp_output_50_0_g156;
			float smoothstepResult64_g156 = smoothstep( 0.0 , 1.0 , ( (( temp_output_44_0_g156 >= temp_output_45_0_g156 && temp_output_44_0_g156 <= temp_output_48_0_g156 ) ? ( ( temp_output_44_0_g156 - temp_output_7_0_g157 ) / ( temp_output_45_0_g156 - temp_output_7_0_g157 ) ) :  0.0 ) + (( temp_output_44_0_g156 >= temp_output_47_0_g156 && temp_output_44_0_g156 <= temp_output_45_0_g156 ) ? 1.0 :  0.0 ) + (( temp_output_44_0_g156 >= temp_output_50_0_g156 && temp_output_44_0_g156 <= temp_output_47_0_g156 ) ? ( ( temp_output_44_0_g156 - temp_output_7_0_g158 ) / ( temp_output_47_0_g156 - temp_output_7_0_g158 ) ) :  0.0 ) ));
			float temp_output_42_0 = saturate( min( min( smoothstepResult64_g153 , smoothstepResult64_g159 ) , smoothstepResult64_g156 ) );
			float3 finalBlendWeights146_g99 = temp_output_214_0_g99;
			float3 break132_g99 = finalBlendWeights146_g99;
			float3 lerpResult73 = lerp( ase_normWorldNormal , float3(0.5,0.5,1) , (( temp_output_42_0 < 1.0 ) ? ( ( ( tex2D( _Height, uvX19_g99 ) * break132_g99.x ) + ( tex2D( _Height, uvY20_g99 ) * break132_g99.y ) + ( tex2D( _Height, uvZ21_g99 ) * break132_g99.z ) ).r * temp_output_42_0 ) :  temp_output_42_0 ));
			o.Albedo = lerpResult73;
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
0;0;1280;659;2157.824;848.9239;1.9;True;False
Node;AmplifyShaderEditor.RangedFloatNode;91;-4864.401,613.7836;Float;False;Property;_TextureScale;Texture Scale;8;0;Create;True;0;0;False;0;1;30;0;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;66;-4842.741,24.02453;Float;True;Property;_Height;Height;11;0;Create;True;0;0;False;0;ffdd80285816c284eba749c21d10221e;ffdd80285816c284eba749c21d10221e;False;black;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.DynamicAppendNode;92;-4543.301,500.6837;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;3;-2833.806,-44.11392;Float;False;Property;_CoverageNormalRange;Coverage Normal Range;9;0;Create;True;0;0;False;0;0.5,1,0.5;1,1,1;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TexturePropertyNode;67;-4908.928,324.3799;Float;True;Property;_Normal;Normal;12;1;[Normal];Create;True;0;0;False;0;675b565102eae7742ac74c5459d876b0;675b565102eae7742ac74c5459d876b0;True;bump;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FunctionNode;68;-4498.42,47.83805;Float;False;Heightmap Triplanar Sample;1;;99;806427b3683dbd846b8c6c12b2c40220;8,3,0,32,0,175,0,136,0,64,0,74,0,122,0,124,0;9;7;SAMPLER2D;0;False;6;FLOAT;0;False;80;FLOAT2;0,0;False;82;FLOAT2;1,1;False;29;FLOAT;1;False;76;FLOAT;1;False;180;FLOAT;1;False;152;FLOAT;0;False;60;FLOAT3;-1,-1,-1;False;2;COLOR;0;FLOAT3;196
Node;AmplifyShaderEditor.Vector3Node;2;-2854.806,-224.1138;Float;False;Property;_CoverageNormalBasis;Coverage Normal Basis;0;0;Create;True;0;0;False;0;0,0.5,0;0,0.5,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FunctionNode;69;-3979.661,108.7636;Float;False;Heightmap Triplanar Sample;1;;106;806427b3683dbd846b8c6c12b2c40220;8,3,0,32,1,175,0,136,0,64,0,74,0,122,0,124,0;9;7;SAMPLER2D;0;False;6;FLOAT;0;False;80;FLOAT2;0,0;False;82;FLOAT2;1,1;False;29;FLOAT;1;False;76;FLOAT;1;False;180;FLOAT;1;False;152;FLOAT;3;False;60;FLOAT3;-1,-1,-1;False;2;FLOAT3;0;FLOAT3;196
Node;AmplifyShaderEditor.RangedFloatNode;5;-2839.903,139.5812;Float;False;Property;_FadeSmoothness;Fade Smoothness;10;0;Create;True;0;0;False;0;0.01;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;51;-2408.182,-50.50349;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SaturateNode;52;-2152.182,-98.50343;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;53;-2152.182,-18.50349;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;49;-2156.182,192.0966;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;55;-2472.182,-386.5033;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.WorldNormalVector;39;-2324.491,-757.2759;Float;True;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.BreakToComponentsNode;47;-1781.167,-751.6734;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SaturateNode;54;-2152.182,61.49651;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;-1660.165,-132.3988;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;50;-2152.182,-514.5033;Float;False;3;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-1610.577,-386.9396;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;56;-2152.182,-386.5033;Float;False;3;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;37;-2152.182,-258.5034;Float;False;3;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;-1653.887,32.59109;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;93;-1392,-592;Float;False;Threshold Range Fade Smoothstep;-1;;153;660130964062a0a4593db480d023110a;0;4;44;FLOAT;1;False;42;FLOAT;0;False;6;FLOAT;0;False;36;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;95;-1425.753,-361.6344;Float;False;Threshold Range Fade Smoothstep;-1;;159;660130964062a0a4593db480d023110a;0;4;44;FLOAT;1;False;42;FLOAT;0;False;6;FLOAT;0;False;36;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;94;-1376,16;Float;False;Threshold Range Fade Smoothstep;-1;;156;660130964062a0a4593db480d023110a;0;4;44;FLOAT;1;False;42;FLOAT;0;False;6;FLOAT;0;False;36;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;75;-1040,-384;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;76;-896,-272;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;42;-648.2818,-262.3034;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;87;-688.4736,-468.8125;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;89;-425.2096,-375.9229;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;36;-494.1763,39.24182;Float;True;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;72;-693.8954,-37.4797;Float;False;Constant;_Vector3;Vector 3;7;0;Create;True;0;0;False;0;0.5,0.5,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TFHCCompareLower;88;-234.6,-278;Float;False;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;73;61.80096,-94.55139;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;71;-3641.046,-81.69037;Float;False;Constant;_Vector2;Vector 2;7;0;Create;True;0;0;False;0;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;343.1629,-5.579885;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Normal Coverage Test;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;92;0;91;0
WireConnection;92;1;91;0
WireConnection;68;7;66;0
WireConnection;68;82;92;0
WireConnection;69;7;67;0
WireConnection;69;82;92;0
WireConnection;69;60;68;196
WireConnection;51;0;3;0
WireConnection;52;0;51;0
WireConnection;53;0;51;1
WireConnection;49;0;5;0
WireConnection;55;0;2;0
WireConnection;39;0;69;0
WireConnection;47;0;39;0
WireConnection;54;0;51;2
WireConnection;44;0;53;0
WireConnection;44;1;49;0
WireConnection;50;0;55;0
WireConnection;43;0;52;0
WireConnection;43;1;49;0
WireConnection;56;0;55;1
WireConnection;37;0;55;2
WireConnection;45;0;54;0
WireConnection;45;1;49;0
WireConnection;93;44;47;0
WireConnection;93;42;50;0
WireConnection;93;6;52;0
WireConnection;93;36;43;0
WireConnection;95;44;47;1
WireConnection;95;42;56;0
WireConnection;95;6;53;0
WireConnection;95;36;44;0
WireConnection;94;44;47;2
WireConnection;94;42;37;0
WireConnection;94;6;54;0
WireConnection;94;36;45;0
WireConnection;75;0;93;0
WireConnection;75;1;95;0
WireConnection;76;0;75;0
WireConnection;76;1;94;0
WireConnection;42;0;76;0
WireConnection;87;0;68;0
WireConnection;89;0;87;0
WireConnection;89;1;42;0
WireConnection;88;0;42;0
WireConnection;88;2;89;0
WireConnection;88;3;42;0
WireConnection;73;0;36;0
WireConnection;73;1;72;0
WireConnection;73;2;88;0
WireConnection;0;0;73;0
ASEEND*/
//CHKSM=50A7020274B09E441698F3A25E1F77D46B1DCECE