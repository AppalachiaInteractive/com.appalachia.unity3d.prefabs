// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Triplanar Testing Shader"
{
	Properties
	{
		_Tiling("Tiling", Range( 0.05 , 3)) = 1
		_AlbedoCeiling("Albedo Ceiling", 2D) = "white" {}
		_AlbedoFloor("Albedo Floor", 2D) = "white" {}
		_AlbedoWall("Albedo Wall", 2D) = "white" {}
		_NormalStrength("Normal Strength", Range( 0 , 4)) = 0
		_NormallCeiling("Normall Ceiling", 2D) = "bump" {}
		_NormalFloor("Normal Floor", 2D) = "bump" {}
		_NormalWall("Normal Wall", 2D) = "bump" {}
		_AOMultiplier("AO Multiplier", Range( 0 , 4)) = 0
		_AmbientOcclusionCeiling("Ambient Occlusion Ceiling", 2D) = "white" {}
		_AmbientOcclusionFloor("Ambient Occlusion Floor", 2D) = "white" {}
		_AmbientOcclusionWall("Ambient Occlusion Wall", 2D) = "white" {}
		_RoughnessMultiplier("Roughness Multiplier", Range( 0 , 4)) = 0
		_RoughnessCeiling("Roughness Ceiling", 2D) = "white" {}
		_RoughnessFloor("Roughness Floor", 2D) = "white" {}
		_RoughnessWall("Roughness Wall", 2D) = "white" {}
		_Falloff("Falloff", Range( 0.1 , 10)) = 1
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#define ASE_TEXTURE_PARAMS(textureName) textureName

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
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform sampler2D _NormalFloor;
		uniform sampler2D _NormalWall;
		uniform sampler2D _NormallCeiling;
		uniform float _Tiling;
		uniform float _Falloff;
		uniform float _NormalStrength;
		uniform sampler2D _AlbedoFloor;
		uniform sampler2D _AlbedoWall;
		uniform sampler2D _AlbedoCeiling;
		uniform sampler2D _RoughnessFloor;
		uniform sampler2D _RoughnessWall;
		uniform sampler2D _RoughnessCeiling;
		uniform float _RoughnessMultiplier;
		uniform sampler2D _AmbientOcclusionFloor;
		uniform sampler2D _AmbientOcclusionWall;
		uniform sampler2D _AmbientOcclusionCeiling;
		uniform float _AOMultiplier;


		inline float3 TriplanarSamplingCNF( sampler2D topTexMap, sampler2D midTexMap, sampler2D botTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
		{
			float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
			projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
			float3 nsign = sign( worldNormal );
			float negProjNormalY = max( 0, projNormal.y * -nsign.y );
			projNormal.y = max( 0, projNormal.y * nsign.y );
			half4 xNorm; half4 yNorm; half4 yNormN; half4 zNorm;
			xNorm = ( tex2D( ASE_TEXTURE_PARAMS( midTexMap ), tiling * worldPos.zy * float2( nsign.x, 1.0 ) ) );
			yNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.xz * float2( nsign.y, 1.0 ) ) );
			yNormN = ( tex2D( ASE_TEXTURE_PARAMS( botTexMap ), tiling * worldPos.xz * float2( nsign.y, 1.0 ) ) );
			zNorm = ( tex2D( ASE_TEXTURE_PARAMS( midTexMap ), tiling * worldPos.xy * float2( -nsign.z, 1.0 ) ) );
			xNorm.xyz = half3( UnpackScaleNormal( xNorm, normalScale.y ).xy * float2( nsign.x, 1.0 ) + worldNormal.zy, worldNormal.x ).zyx;
			yNorm.xyz = half3( UnpackScaleNormal( yNorm, normalScale.x ).xy * float2( nsign.y, 1.0 ) + worldNormal.xz, worldNormal.y ).xzy;
			zNorm.xyz = half3( UnpackScaleNormal( zNorm, normalScale.y ).xy * float2( -nsign.z, 1.0 ) + worldNormal.xy, worldNormal.z ).xyz;
			yNormN.xyz = half3( UnpackScaleNormal( yNormN, normalScale.z ).xy * float2( nsign.y, 1.0 ) + worldNormal.xz, worldNormal.y ).xzy;
			return normalize( xNorm.xyz * projNormal.x + yNorm.xyz * projNormal.y + yNormN.xyz * negProjNormalY + zNorm.xyz * projNormal.z );
		}


		inline float4 TriplanarSamplingCF( sampler2D topTexMap, sampler2D midTexMap, sampler2D botTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
		{
			float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
			projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
			float3 nsign = sign( worldNormal );
			float negProjNormalY = max( 0, projNormal.y * -nsign.y );
			projNormal.y = max( 0, projNormal.y * nsign.y );
			half4 xNorm; half4 yNorm; half4 yNormN; half4 zNorm;
			xNorm = ( tex2D( ASE_TEXTURE_PARAMS( midTexMap ), tiling * worldPos.zy * float2( nsign.x, 1.0 ) ) );
			yNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.xz * float2( nsign.y, 1.0 ) ) );
			yNormN = ( tex2D( ASE_TEXTURE_PARAMS( botTexMap ), tiling * worldPos.xz * float2( nsign.y, 1.0 ) ) );
			zNorm = ( tex2D( ASE_TEXTURE_PARAMS( midTexMap ), tiling * worldPos.xy * float2( -nsign.z, 1.0 ) ) );
			return xNorm * projNormal.x + yNorm * projNormal.y + yNormN * negProjNormalY + zNorm * projNormal.z;
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 appendResult12 = (float2(_Tiling , _Tiling));
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3x3 ase_worldToTangent = float3x3( ase_worldTangent, ase_worldBitangent, ase_worldNormal );
			float3 triplanar5 = TriplanarSamplingCNF( _NormalFloor, _NormalWall, _NormallCeiling, ase_worldPos, ase_worldNormal, _Falloff, appendResult12, (_NormalStrength).xxx, float3(0,0,0) );
			float3 tanTriplanarNormal5 = mul( ase_worldToTangent, triplanar5 );
			o.Normal = tanTriplanarNormal5;
			float4 triplanar2 = TriplanarSamplingCF( _AlbedoFloor, _AlbedoWall, _AlbedoCeiling, ase_worldPos, ase_worldNormal, _Falloff, appendResult12, float3( 1,1,1 ), float3(0,0,0) );
			o.Albedo = triplanar2.xyz;
			o.Metallic = 0.0;
			float4 triplanar6 = TriplanarSamplingCF( _RoughnessFloor, _RoughnessWall, _RoughnessCeiling, ase_worldPos, ase_worldNormal, _Falloff, appendResult12, float3( 1,1,1 ), float3(0,0,0) );
			o.Smoothness = ( 1.0 - ( triplanar6.x * _RoughnessMultiplier ) );
			float4 triplanar7 = TriplanarSamplingCF( _AmbientOcclusionFloor, _AmbientOcclusionWall, _AmbientOcclusionCeiling, ase_worldPos, ase_worldNormal, _Falloff, appendResult12, float3( 1,1,1 ), float3(0,0,0) );
			o.Occlusion = ( triplanar7.x * _AOMultiplier );
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
241.3333;0;1037;659;958.4341;250.3268;1.6;True;False
Node;AmplifyShaderEditor.RangedFloatNode;11;-1550.87,239.6281;Float;False;Property;_Tiling;Tiling;0;0;Create;True;0;0;False;0;1;0.09;0.05;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;12;-1198.944,102.6415;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-1487.784,372.6384;Float;False;Property;_Falloff;Falloff;16;0;Create;True;0;0;False;0;1;1;0.1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1517.428,517.6337;Float;False;Property;_NormalStrength;Normal Strength;4;0;Create;True;0;0;False;0;0;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-573.9928,484.22;Float;False;Property;_RoughnessMultiplier;Roughness Multiplier;12;0;Create;True;0;0;False;0;0;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.TriplanarNode;6;-955.8582,427.2452;Float;True;Cylindrical;World;False;Roughness Floor;_RoughnessFloor;white;14;None;Roughness Wall;_RoughnessWall;white;15;None;Roughness Ceiling;_RoughnessCeiling;white;13;None;Triplanar Sampler;False;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT3;1,1,1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SwizzleNode;18;-1297.406,490.0895;Float;False;FLOAT3;0;1;2;3;1;0;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-551.7922,694.8781;Float;False;Property;_AOMultiplier;AO Multiplier;8;0;Create;True;0;0;False;0;0;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-511.2581,381.0167;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TriplanarNode;7;-981.8787,653.4241;Float;True;Cylindrical;World;False;Ambient Occlusion Floor;_AmbientOcclusionFloor;white;10;None;Ambient Occlusion Wall;_AmbientOcclusionWall;white;11;None;Ambient Occlusion Ceiling;_AmbientOcclusionCeiling;white;9;None;Triplanar Sampler;False;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT3;1,1,1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;13;-266.3511,152.7319;Float;False;const;-1;;1;5b64729fb717c5f49a1bc2dab81d5e1c;1,3,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TriplanarNode;5;-966.9733,186.2493;Float;True;Cylindrical;World;True;Normal Floor;_NormalFloor;bump;6;None;Normal Wall;_NormalWall;bump;7;None;Normall Ceiling;_NormallCeiling;bump;5;None;Triplanar Sampler;False;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT3;1,1,1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TriplanarNode;2;-974.0061,-24.48422;Float;True;Cylindrical;World;False;Albedo Floor;_AlbedoFloor;white;2;None;Albedo Wall;_AlbedoWall;white;3;None;Albedo Ceiling;_AlbedoCeiling;white;1;None;Triplanar Sampler;False;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT3;1,1,1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;8;-436.458,296.0282;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-263.2581,515.0167;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Triplanar Testing Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;12;0;11;0
WireConnection;12;1;11;0
WireConnection;6;3;12;0
WireConnection;6;4;9;0
WireConnection;18;0;16;0
WireConnection;19;0;6;1
WireConnection;19;1;14;0
WireConnection;7;3;12;0
WireConnection;7;4;9;0
WireConnection;5;8;18;0
WireConnection;5;3;12;0
WireConnection;5;4;9;0
WireConnection;2;3;12;0
WireConnection;2;4;9;0
WireConnection;8;0;19;0
WireConnection;20;0;7;1
WireConnection;20;1;15;0
WireConnection;0;0;2;0
WireConnection;0;1;5;0
WireConnection;0;3;13;0
WireConnection;0;4;8;0
WireConnection;0;5;20;0
ASEEND*/
//CHKSM=04031A8D41051BB072A2FA12227BBCCB648DAA22