// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "internal/Global/Arrow"
{
	Properties
	{
		[HideInInspector]_Debug_Arrow("Debug_Arrow", Float) = 1
		_MainColor("Main Color", Color) = (1,0.3778228,0,0)
		_EdgeColor("Edge Color", Color) = (1,0.809,0,0)
		_MuteColor("Mute Color", Color) = (1,0.3778228,0,0)
		_FresnelBias("Fresnel Bias", Range( 0 , 10)) = 0
		_FresnelScale("Fresnel Scale", Range( 0 , 10)) = 1.5
		_FresnelPower("Fresnel Power", Range( 0 , 10)) = 2
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
		};

		uniform float _FresnelPower;
		uniform float _FresnelBias;
		uniform float _FresnelScale;
		uniform float _Debug_Arrow;
		uniform float4 _MuteColor;
		uniform float4 _MainColor;
		uniform float4 _EdgeColor;
		uniform half _WIND_GUST_AMPLITUDE;
		uniform half _WIND_GUST_AUDIO_STRENGTH;
		uniform half _WIND_AUDIO_INFLUENCE;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV1 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode1 = ( _FresnelBias + _FresnelScale * pow( 1.0 - fresnelNdotV1, _FresnelPower ) );
			float4 lerpResult45 = lerp( _MainColor , _EdgeColor , fresnelNode1);
			float lerpResult632_g323 = lerp( _WIND_GUST_AMPLITUDE , _WIND_GUST_AUDIO_STRENGTH , _WIND_AUDIO_INFLUENCE);
			float4 lerpResult2 = lerp( _MuteColor , lerpResult45 , lerpResult632_g323);
			o.Emission = saturate( lerpResult2 ).rgb;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Unlit keepalpha fullforwardshadows 

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
				float3 worldPos : TEXCOORD1;
				float3 worldNormal : TEXCOORD2;
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
				o.worldNormal = worldNormal;
				o.worldPos = worldPos;
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
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
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
Version=17500
0;-790.4;1005;750;755.7067;81.8877;1.774687;True;False
Node;AmplifyShaderEditor.RangedFloatNode;28;-156.5314,977.4526;Float;False;Property;_FresnelPower;Fresnel Power;6;0;Create;True;0;0;True;0;2;2.4;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-156.5314,787.4525;Float;False;Property;_FresnelBias;Fresnel Bias;4;0;Create;True;0;0;True;0;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-156.5314,882.4525;Float;False;Property;_FresnelScale;Fresnel Scale;5;0;Create;True;0;0;True;0;1.5;10;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;1;227.4686,786.4525;Inherit;False;Standard;TangentNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1.5;False;3;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-576.9779,630.0671;Float;False;Property;_EdgeColor;Edge Color;2;0;Create;True;0;0;False;0;1,0.809,0,0;1,0.8115324,0.4386792,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;3;-581.3384,432.5142;Float;False;Property;_MainColor;Main Color;1;0;Create;True;0;0;False;0;1,0.3778228,0,0;0.07390056,0.3113207,0.03083838,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;45;319.3033,523.2806;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;44;-141.6225,33.25746;Inherit;False;Wind Data (Audio);-1;;323;cfe895c1fd10b494dadeb00b49e9db7a;0;0;5;FLOAT;640;FLOAT;639;FLOAT;627;FLOAT;629;FLOAT;631
Node;AmplifyShaderEditor.ColorNode;46;-122.1433,237.556;Float;False;Property;_MuteColor;Mute Color;3;0;Create;True;0;0;False;0;1,0.3778228,0,0;0.3301887,0.3301887,0.3301887,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;2;680.5941,373.0639;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;42;926.3508,363.6948;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-783,34;Float;False;Property;_Debug_Arrow;Debug_Arrow;0;1;[HideInInspector];Create;True;0;0;True;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;43;1102.594,377.0639;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;internal/Global/Arrow;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;False;False;_BILLBOARD_ON;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;14;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT3;0,0,0;False;0
WireConnection;1;1;26;0
WireConnection;1;2;27;0
WireConnection;1;3;28;0
WireConnection;45;0;3;0
WireConnection;45;1;4;0
WireConnection;45;2;1;0
WireConnection;2;0;46;0
WireConnection;2;1;45;0
WireConnection;2;2;44;640
WireConnection;42;0;2;0
WireConnection;43;2;42;0
ASEEND*/
//CHKSM=37C018977F4B608A382687CB43BF6DCD715A23D0