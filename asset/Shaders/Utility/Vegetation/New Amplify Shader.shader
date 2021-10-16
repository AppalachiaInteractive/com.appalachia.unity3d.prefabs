// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _WIND_GUST_TEXTURE;
		uniform half _WIND_GUST_FIELD_SIZE;
		uniform half _WIND_GUST_CYCLE_TIME;
		uniform half _WIND_GUST_CONTRAST;
		uniform half _WIND_GUST_TEXTURE_ON;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float temp_output_513_0_g57 = ( 1.0 / _WIND_GUST_FIELD_SIZE );
			float2 temp_cast_0 = (temp_output_513_0_g57).xx;
			half localunity_ObjectToWorld0w1_g67 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g67 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g67 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g67 = (float3(localunity_ObjectToWorld0w1_g67 , localunity_ObjectToWorld1w2_g67 , localunity_ObjectToWorld2w3_g67));
			float3 temp_output_509_7_g57 = appendResult6_g67;
			float3 temp_output_512_0_g57 = ( temp_output_513_0_g57 * temp_output_509_7_g57 );
			float2 uv_TexCoord12_g60 = i.uv_texcoord * temp_cast_0 + (temp_output_512_0_g57).xz;
			float4 tex2DNode32_g60 = tex2D( _WIND_GUST_TEXTURE, uv_TexCoord12_g60 );
			float temp_output_516_0_g57 = ( 1.0 / _WIND_GUST_CYCLE_TIME );
			float mulTime37_g60 = _Time.y * temp_output_516_0_g57;
			float temp_output_220_0_g61 = -1.0;
			float temp_output_219_0_g61 = 1.0;
			float clampResult26_g61 = clamp( sin( ( ( tex2DNode32_g60.b * ( 2.0 * UNITY_PI ) ) + mulTime37_g60 ) ) , temp_output_220_0_g61 , temp_output_219_0_g61 );
			float lerpResult531_g57 = lerp( 0.0 , saturate( pow( abs( (0.0 + (clampResult26_g61 - temp_output_220_0_g61) * (temp_output_219_0_g61 - 0.0) / (temp_output_219_0_g61 - temp_output_220_0_g61)) ) , _WIND_GUST_CONTRAST ) ) , _WIND_GUST_TEXTURE_ON);
			float3 temp_cast_1 = (lerpResult531_g57).xxx;
			o.Albedo = temp_cast_1;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17500
0;-864;1536;843;1259.641;222.0049;1.3;True;False
Node;AmplifyShaderEditor.FunctionNode;3;-678.541,249.8951;Inherit;False;Motion Parameters;0;;57;b731396df55b2f64f90cde6dcc71f449;0;0;18;FLOAT3;494;FLOAT3;510;FLOAT;495;FLOAT;496;FLOAT;497;FLOAT;519;FLOAT;501;FLOAT3;511;FLOAT;498;FLOAT;499;FLOAT;500;FLOAT;518;FLOAT;526;FLOAT;528;FLOAT;527;FLOAT;544;FLOAT;543;FLOAT;545
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;New Amplify Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;14;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT3;0,0,0;False;0
WireConnection;0;0;3;528
ASEEND*/
//CHKSM=E88AC17E5E26302592DC04D8C920E9993DAEA62E