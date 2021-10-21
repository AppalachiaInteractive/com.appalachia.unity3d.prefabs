// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "appalachia/debug"
{
	Properties
	{
		_Debug_Arrow("Debug_Arrow", Float) = 1
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True" "DisableBatching" = "True" "IsEmissive" = "true"  }
		LOD 300
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma exclude_renderers d3d9 gles vulkan 
		#pragma surface surf Lambert keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float4 vertexToFrag2018;
			float3 worldPos;
			half ASEVFace : VFACE;
			float4 vertexToFrag1719;
			float3 worldNormal;
		};

		uniform half _DEBUG_MODE;
		uniform sampler2D _WIND_GUST_TEXTURE;
		uniform half _WIND_GUST_TRUNK_FIELD_SIZE;
		uniform half _WIND_GUST_CONTRAST;
		uniform half _WIND_GUST_TEXTURE_ON;
		uniform half3 _WIND_DIRECTION;
		uniform half _DEBUG_MIN;
		uniform half _DEBUG_MAX;
		uniform half _Debug_Arrow;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			half DebugMode1487 = _DEBUG_MODE;
			float ifLocalVar15_g2835 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 10.0 )
				ifLocalVar15_g2835 = v.color.r;
			half4 color2193 = IsGammaSpace() ? half4(1,0.2373333,0.12,1) : half4(1,0.04595175,0.01341175,1);
			float3 ase_vertex3Pos = v.vertex.xyz;
			float ifLocalVar15_g2839 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 11.0 )
				ifLocalVar15_g2839 = (( v.texcoord1.xyz.y < ase_vertex3Pos.y ) ? 1.0 :  0.0 );
			half4 color2470 = IsGammaSpace() ? half4(1,0.2392157,0.1215686,1) : half4(1,0.04666509,0.01370208,1);
			float ifLocalVar15_g2837 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 12.0 )
				ifLocalVar15_g2837 = v.texcoord1.w;
			half4 color2473 = IsGammaSpace() ? half4(1,0.6189286,0.56,0) : half4(1,0.3410889,0.2738385,0);
			float ifLocalVar15_g2841 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 20.0 )
				ifLocalVar15_g2841 = v.color.g;
			half4 color2180 = IsGammaSpace() ? half4(0.12,1,0.2373334,1) : half4(0.01341175,1,0.04595178,1);
			float ifLocalVar15_g2825 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 21.0 )
				ifLocalVar15_g2825 = saturate( ( 1.0 - distance( v.texcoord3.xyz , ase_vertex3Pos ) ) );
			half4 color2181 = IsGammaSpace() ? half4(0.12,1,0.2373334,1) : half4(0.01341175,1,0.04595178,1);
			float ifLocalVar15_g2843 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 22.0 )
				ifLocalVar15_g2843 = v.texcoord3.w;
			half4 color2182 = IsGammaSpace() ? half4(0.56,1,0.6152157,1) : half4(0.2738385,1,0.3365962,1);
			float ifLocalVar15_g2827 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 23.0 )
				ifLocalVar15_g2827 = 1.0;
			float clampResult8_g2635 = clamp( v.texcoord2.w , -1.0 , 1.0 );
			float ifLocalVar15_g2849 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 24.0 )
				ifLocalVar15_g2849 = ( ( clampResult8_g2635 * 0.5 ) + 0.5 );
			half4 color2202 = IsGammaSpace() ? half4(0,1,0.07011509,1) : half4(0,1,0.005994285,1);
			float ifLocalVar15_g2915 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 40.0 )
				ifLocalVar15_g2915 = v.texcoord2.w;
			half4 color2516 = IsGammaSpace() ? half4(0.25,0.25,0.25,1) : half4(0.05087609,0.05087609,0.05087609,1);
			float ifLocalVar15_g2823 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 30.0 )
				ifLocalVar15_g2823 = v.color.b;
			half4 color2188 = IsGammaSpace() ? half4(0.2373332,0.12,1,1) : half4(0.0459517,0.01341175,1,1);
			float4 color658_g2767 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float2 temp_output_61_0_g2773 = float2( 0,0 );
			half localunity_ObjectToWorld0w1_g2630 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g2630 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g2630 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g2630 = (float3(localunity_ObjectToWorld0w1_g2630 , localunity_ObjectToWorld1w2_g2630 , localunity_ObjectToWorld2w3_g2630));
			float2 temp_output_1_0_g2778 = (appendResult6_g2630).xz;
			float temp_output_2497_500 = _WIND_GUST_TRUNK_FIELD_SIZE;
			float temp_output_2_0_g2769 = temp_output_2497_500;
			float temp_output_40_0_g2773 = ( 1.0 / (( temp_output_2_0_g2769 == 0.0 ) ? 1.0 :  temp_output_2_0_g2769 ) );
			float2 temp_cast_2 = (temp_output_40_0_g2773).xx;
			float2 temp_output_2_0_g2778 = temp_cast_2;
			float temp_output_2_0_g2779 = 1.0;
			float mulTime37_g2773 = _Time.y * ( 1.0 / (( temp_output_2_0_g2779 == 0.0 ) ? 1.0 :  temp_output_2_0_g2779 ) );
			float temp_output_220_0_g2774 = -1.0;
			float4 temp_cast_3 = (temp_output_220_0_g2774).xxxx;
			float temp_output_219_0_g2774 = 1.0;
			float4 temp_cast_4 = (temp_output_219_0_g2774).xxxx;
			float4 clampResult26_g2774 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g2773 > float2( 0,0 ) ) ? ( temp_output_1_0_g2778 / temp_output_2_0_g2778 ) :  ( temp_output_1_0_g2778 * temp_output_2_0_g2778 ) ) + temp_output_61_0_g2773 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g2773 ) ) , temp_cast_3 , temp_cast_4 );
			float4 temp_cast_5 = (temp_output_220_0_g2774).xxxx;
			float4 temp_cast_6 = (temp_output_219_0_g2774).xxxx;
			float4 temp_cast_7 = (0.0).xxxx;
			float4 temp_cast_8 = (temp_output_219_0_g2774).xxxx;
			float temp_output_2497_526 = _WIND_GUST_CONTRAST;
			float4 temp_cast_9 = (temp_output_2497_526).xxxx;
			float4 temp_output_52_0_g2773 = saturate( pow( abs( (temp_cast_7 + (clampResult26_g2774 - temp_cast_5) * (temp_cast_8 - temp_cast_7) / (temp_cast_6 - temp_cast_5)) ) , temp_cast_9 ) );
			float temp_output_2497_527 = _WIND_GUST_TEXTURE_ON;
			float4 lerpResult656_g2767 = lerp( color658_g2767 , temp_output_52_0_g2773 , temp_output_2497_527);
			float2 weightedBlendVar660_g2767 = (0.5).xx;
			float4 weightedBlend660_g2767 = ( weightedBlendVar660_g2767.x*(1.0).xxxx + weightedBlendVar660_g2767.y*lerpResult656_g2767 );
			float2 _OutputRange = float2(0.1,1);
			float4 temp_cast_11 = (_OutputRange.x).xxxx;
			float4 temp_cast_12 = (_OutputRange.y).xxxx;
			float4 clampResult667_g2767 = clamp( weightedBlend660_g2767 , temp_cast_11 , temp_cast_12 );
			float ifLocalVar15_g2847 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 90.0 )
				ifLocalVar15_g2847 = clampResult667_g2767.x;
			half4 color1935 = IsGammaSpace() ? half4(0,1,1,1) : half4(0,1,1,1);
			float4 color658_g2783 = IsGammaSpace() ? float4(0.1607843,0.0627451,0.2509804,0.1764706) : float4(0.02217388,0.005181517,0.05126947,0.1764706);
			float2 temp_output_61_0_g2789 = float2( 0,0 );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float2 temp_output_1_0_g2794 = (ase_worldPos).xz;
			float temp_output_2_0_g2785 = temp_output_2497_500;
			float temp_output_40_0_g2789 = ( 1.0 / (( temp_output_2_0_g2785 == 0.0 ) ? 1.0 :  temp_output_2_0_g2785 ) );
			float2 temp_cast_14 = (temp_output_40_0_g2789).xx;
			float2 temp_output_2_0_g2794 = temp_cast_14;
			float temp_output_2_0_g2795 = 1.0;
			float mulTime37_g2789 = _Time.y * ( 1.0 / (( temp_output_2_0_g2795 == 0.0 ) ? 1.0 :  temp_output_2_0_g2795 ) );
			float temp_output_220_0_g2790 = -1.0;
			float4 temp_cast_15 = (temp_output_220_0_g2790).xxxx;
			float temp_output_219_0_g2790 = 1.0;
			float4 temp_cast_16 = (temp_output_219_0_g2790).xxxx;
			float4 clampResult26_g2790 = clamp( sin( ( ( tex2Dlod( _WIND_GUST_TEXTURE, float4( ( (( temp_output_61_0_g2789 > float2( 0,0 ) ) ? ( temp_output_1_0_g2794 / temp_output_2_0_g2794 ) :  ( temp_output_1_0_g2794 * temp_output_2_0_g2794 ) ) + temp_output_61_0_g2789 ), 0, 0.0) ) * ( 2.0 * UNITY_PI ) ) + mulTime37_g2789 ) ) , temp_cast_15 , temp_cast_16 );
			float4 temp_cast_17 = (temp_output_220_0_g2790).xxxx;
			float4 temp_cast_18 = (temp_output_219_0_g2790).xxxx;
			float4 temp_cast_19 = (0.0).xxxx;
			float4 temp_cast_20 = (temp_output_219_0_g2790).xxxx;
			float4 temp_cast_21 = (temp_output_2497_526).xxxx;
			float4 temp_output_52_0_g2789 = saturate( pow( abs( (temp_cast_19 + (clampResult26_g2790 - temp_cast_17) * (temp_cast_20 - temp_cast_19) / (temp_cast_18 - temp_cast_17)) ) , temp_cast_21 ) );
			float4 lerpResult656_g2783 = lerp( color658_g2783 , temp_output_52_0_g2789 , temp_output_2497_527);
			float2 weightedBlendVar660_g2783 = (0.5).xx;
			float4 weightedBlend660_g2783 = ( weightedBlendVar660_g2783.x*(1.0).xxxx + weightedBlendVar660_g2783.y*lerpResult656_g2783 );
			float4 temp_cast_23 = (_OutputRange.x).xxxx;
			float4 temp_cast_24 = (_OutputRange.y).xxxx;
			float4 clampResult667_g2783 = clamp( weightedBlend660_g2783 , temp_cast_23 , temp_cast_24 );
			float ifLocalVar15_g2831 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 91.0 )
				ifLocalVar15_g2831 = clampResult667_g2783.x;
			float dotResult2032 = dot( float4( _WIND_DIRECTION , 0.0 ) , v.texcoord2 );
			float clampResult8_g2633 = clamp( dotResult2032 , -1.0 , 1.0 );
			float ifLocalVar15_g2829 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 92.0 )
				ifLocalVar15_g2829 = ( ( clampResult8_g2633 * 0.5 ) + 0.5 );
			float ifLocalVar15_g2845 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 97.0 )
				ifLocalVar15_g2845 = v.texcoord.z;
			half4 color1939 = IsGammaSpace() ? half4(1,1,1,1) : half4(1,1,1,1);
			float ifLocalVar15_g2833 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 98.0 )
				ifLocalVar15_g2833 = v.color.a;
			half4 color2039 = IsGammaSpace() ? half4(0.5,0,1,1) : half4(0.2140411,0,1,1);
			float ifLocalVar15_g2821 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 99.0 )
				ifLocalVar15_g2821 = v.texcoord.w;
			half4 color2046 = IsGammaSpace() ? half4(1,0,0.5,1) : half4(1,0,0.2140411,1);
			o.vertexToFrag2018 = ( ( ( ( ifLocalVar15_g2835 * color2193 ) + ( ifLocalVar15_g2839 * color2470 ) + ( ifLocalVar15_g2837 * color2473 ) ) + ( ( ifLocalVar15_g2841 * color2180 ) + ( ifLocalVar15_g2825 * color2181 ) + ( ifLocalVar15_g2843 * color2182 ) ) + ( ( ifLocalVar15_g2827 * v.texcoord2 ) + ( ifLocalVar15_g2849 * color2202 ) ) ) + ( ( ifLocalVar15_g2915 * color2516 ) + float4( 0,0,0,0 ) ) + ( ( ( ifLocalVar15_g2823 * color2188 ) + float4( 0,0,0,0 ) ) + ( ( ifLocalVar15_g2847 * color1935 ) + ( ifLocalVar15_g2831 * color1935 ) + ( ifLocalVar15_g2829 * color1935 ) ) + ( ( ifLocalVar15_g2845 * color1939 ) + ( ifLocalVar15_g2833 * color2039 ) + ( ifLocalVar15_g2821 * color2046 ) ) ) );
			float ifLocalVar15_g2935 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 100.0 )
				ifLocalVar15_g2935 = 1.0;
			float ifLocalVar15_g2957 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 101.0 )
				ifLocalVar15_g2957 = v.color.r;
			float ifLocalVar15_g2927 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 102.0 )
				ifLocalVar15_g2927 = v.color.g;
			float ifLocalVar15_g2967 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 103.0 )
				ifLocalVar15_g2967 = v.color.b;
			float ifLocalVar15_g2949 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 104.0 )
				ifLocalVar15_g2949 = v.color.a;
			float ifLocalVar15_g2919 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 111.0 )
				ifLocalVar15_g2919 = v.texcoord.x;
			float ifLocalVar15_g2951 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 112.0 )
				ifLocalVar15_g2951 = v.texcoord.y;
			float ifLocalVar15_g2943 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 113.0 )
				ifLocalVar15_g2943 = v.texcoord.z;
			float ifLocalVar15_g2955 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 114.0 )
				ifLocalVar15_g2955 = v.texcoord.w;
			float ifLocalVar15_g2959 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 121.0 )
				ifLocalVar15_g2959 = v.texcoord1.x;
			float ifLocalVar15_g2921 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 122.0 )
				ifLocalVar15_g2921 = v.texcoord1.y;
			float ifLocalVar15_g2929 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 123.0 )
				ifLocalVar15_g2929 = v.texcoord1.z;
			float ifLocalVar15_g2937 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 124.0 )
				ifLocalVar15_g2937 = v.texcoord1.w;
			float ifLocalVar15_g2917 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 131.0 )
				ifLocalVar15_g2917 = v.texcoord2.x;
			float ifLocalVar15_g2953 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 132.0 )
				ifLocalVar15_g2953 = v.texcoord2.y;
			float ifLocalVar15_g2947 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 133.0 )
				ifLocalVar15_g2947 = v.texcoord2.z;
			float ifLocalVar15_g2945 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 134.0 )
				ifLocalVar15_g2945 = v.texcoord2.w;
			float ifLocalVar15_g2971 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 141.0 )
				ifLocalVar15_g2971 = v.texcoord3.x;
			float ifLocalVar15_g2969 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 142.0 )
				ifLocalVar15_g2969 = v.texcoord3.y;
			float ifLocalVar15_g2961 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 143.0 )
				ifLocalVar15_g2961 = v.texcoord3.z;
			float ifLocalVar15_g2925 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 144.0 )
				ifLocalVar15_g2925 = v.texcoord3.w;
			float ifLocalVar15_g2933 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 151.0 )
				ifLocalVar15_g2933 = ase_vertex3Pos.x;
			float ifLocalVar15_g2931 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 152.0 )
				ifLocalVar15_g2931 = ase_vertex3Pos.y;
			float ifLocalVar15_g2965 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 153.0 )
				ifLocalVar15_g2965 = ase_vertex3Pos.z;
			float3 ase_vertexNormal = v.normal.xyz;
			float ifLocalVar15_g2923 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 161.0 )
				ifLocalVar15_g2923 = ase_vertexNormal.x;
			float ifLocalVar15_g2941 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 162.0 )
				ifLocalVar15_g2941 = ase_vertexNormal.y;
			float ifLocalVar15_g2963 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 163.0 )
				ifLocalVar15_g2963 = ase_vertexNormal.z;
			float3 ifLocalVar15_g2939 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 164.0 )
				ifLocalVar15_g2939 = (ase_vertexNormal).xyz;
			o.vertexToFrag1719 = ( ( ( ifLocalVar15_g2935 * v.color ) + ( ifLocalVar15_g2957 * half4(1,0,0,1) ) + ( ifLocalVar15_g2927 * half4(0,1,0,1) ) + ( ifLocalVar15_g2967 * half4(0,0,1,1) ) + ( ifLocalVar15_g2949 * half4(1,1,1,1) ) ) + ( ( ifLocalVar15_g2919 * half4(1,0,0,1) ) + ( ifLocalVar15_g2951 * half4(0,1,0,1) ) + ( ifLocalVar15_g2943 * half4(0,0,1,1) ) + ( ifLocalVar15_g2955 * half4(1,1,1,1) ) ) + ( ( ifLocalVar15_g2959 * half4(1,0,0,1) ) + ( ifLocalVar15_g2921 * half4(0,1,0,1) ) + ( ifLocalVar15_g2929 * half4(0,0,1,1) ) + ( ifLocalVar15_g2937 * half4(1,1,1,1) ) ) + ( ( ifLocalVar15_g2917 * half4(1,0,0,1) ) + ( ifLocalVar15_g2953 * half4(0,1,0,1) ) + ( ifLocalVar15_g2947 * half4(0,0,1,1) ) + ( ifLocalVar15_g2945 * half4(1,1,1,1) ) ) + ( ( ifLocalVar15_g2971 * half4(1,0,0,1) ) + ( ifLocalVar15_g2969 * half4(0,1,0,1) ) + ( ifLocalVar15_g2961 * half4(0,0,1,1) ) + ( ifLocalVar15_g2925 * half4(1,1,1,1) ) ) + ( ( ifLocalVar15_g2933 * half4(1,0,0,1) ) + ( ifLocalVar15_g2931 * half4(0,1,0,1) ) + ( ifLocalVar15_g2965 * half4(0,0,1,1) ) ) + ( ( ifLocalVar15_g2923 * half4(1,0,0,1) ) + ( ifLocalVar15_g2941 * half4(0,1,0,1) ) + ( ifLocalVar15_g2963 * half4(0,0,1,1) ) + float4( ( ifLocalVar15_g2939 * (ase_vertexNormal).xyz ) , 0.0 ) ) );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			half DebugMode1487 = _DEBUG_MODE;
			float ifLocalVar15_g2973 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 80.0 )
				ifLocalVar15_g2973 = 1.0;
			half4 color2521 = IsGammaSpace() ? half4(1,0.2386928,0.1215686,1) : half4(1,0.04646629,0.01370208,1);
			half4 color2528 = IsGammaSpace() ? half4(0.2373332,0.12,1,1) : half4(0.0459517,0.01341175,1,1);
			float4 switchResult2527 = (((i.ASEVFace>0)?(color2521):(color2528)));
			float4 SPECIAL_COLOR2019 = ( i.vertexToFrag2018 + ( ( ifLocalVar15_g2973 * switchResult2527 ) + float4( 0,0,0,0 ) ) );
			float4 MESH_COLOR1906 = i.vertexToFrag1719;
			half DebugMin1721 = _DEBUG_MIN;
			float temp_output_7_0_g2975 = DebugMin1721;
			float4 temp_cast_0 = (temp_output_7_0_g2975).xxxx;
			half DebugMax1723 = _DEBUG_MAX;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV1442 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode1442 = ( 0.0 + 1.5 * pow( 1.0 - fresnelNdotV1442, 2.0 ) );
			float4 lerpResult1437 = lerp( half4(1,0.5019608,0,0) , half4(1,0.809,0,0) , saturate( fresnelNode1442 ));
			half4 ArrowColor1438 = lerpResult1437;
			half ArrowDebug1450 = _Debug_Arrow;
			float4 lerpResult1278 = lerp( saturate( ( ( ( SPECIAL_COLOR2019 + MESH_COLOR1906 ) - temp_cast_0 ) / ( DebugMax1723 - temp_output_7_0_g2975 ) ) ) , ArrowColor1438 , ArrowDebug1450);
			o.Albedo = ( lerpResult1278 * 0.1 ).rgb;
			o.Emission = ( lerpResult1278 * ( 1.0 - 0.1 ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "AppalachiaShaderGUI"
}
/*ASEBEGIN
Version=17500
390.4;-790.4;676;752;3591.642;-2588.856;1;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;2228;-5350.563,-2268.23;Inherit;False;3;-1;3;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;2222;-5350.563,-2140.23;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;2497;-6362.986,928.3265;Inherit;False;Wind Data;-1;;100;b731396df55b2f64f90cde6dcc71f449;0;0;31;FLOAT3;494;FLOAT3;510;FLOAT;544;FLOAT;543;FLOAT;545;FLOAT;501;FLOAT;495;FLOAT;496;FLOAT;519;FLOAT;497;FLOAT;548;FLOAT;549;FLOAT;567;FLOAT;576;FLOAT;552;FLOAT;553;FLOAT;569;FLOAT;498;FLOAT;565;FLOAT;564;FLOAT;500;FLOAT;562;FLOAT;563;FLOAT;571;FLOAT;577;FLOAT;560;FLOAT;561;FLOAT;573;FLOAT;527;FLOAT;526;FLOAT;579
Node;AmplifyShaderEditor.TexCoordVertexDataNode;2050;-5827.417,1585.304;Inherit;False;2;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1480;-3440.652,-4557.764;Half;False;Global;_DEBUG_MODE;_DEBUG_MODE;3;0;Create;True;0;0;False;0;0;97;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1817;-5206.563,-1340.23;Inherit;False;2;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DistanceOpNode;2250;-5094.563,-2268.23;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;2032;-5486.96,1159.395;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;2506;-5998.96,775.395;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FunctionNode;2507;-5998.96,599.395;Inherit;False;Object Position;-1;;2630;b9555b68a3d67c54f91597a05086026a;0;0;4;FLOAT3;7;FLOAT;0;FLOAT;4;FLOAT;5
Node;AmplifyShaderEditor.FunctionNode;2030;-4966.563,-1244.23;Inherit;False;Pack (-1_1 to 0_1);-1;;2635;03a4f7d823d57204f9f07b2b0a5142db;0;1;7;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2181;-5350.563,-2428.23;Half;False;Constant;_Color_SecondaryPivot;Color_SecondaryPivot;3;0;Create;True;0;0;False;0;0.12,1,0.2373334,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;2174;-5358.96,1159.395;Inherit;False;Pack (-1_1 to 0_1);-1;;2633;03a4f7d823d57204f9f07b2b0a5142db;0;1;7;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;2224;-4838.563,-2268.23;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1935;-5230.96,903.395;Half;False;Constant;_ColorGust;Color Gust;3;0;Create;True;0;0;False;0;0,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SwizzleNode;2510;-5806.96,775.395;Inherit;False;FLOAT2;0;2;2;3;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;2513;-5974.686,237.562;Inherit;True;Global;_WIND_GUST_TEXTURE;_WIND_GUST_TEXTURE;5;0;Create;True;0;0;False;0;None;026dfc64f1bab7b4eae0975faef4dd55;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SwizzleNode;2509;-5806.96,599.395;Inherit;False;FLOAT2;0;2;2;3;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PosVertexDataNode;2467;-5686.563,-3116.23;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2487;-5366.563,-3052.23;Inherit;False;Constant;_Float27;Float 27;6;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2468;-5686.563,-3260.23;Inherit;False;1;-1;3;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;2470;-5350.563,-3356.23;Half;False;Constant;_Color_PrimaryPivot;Color_PrimaryPivot;3;0;Create;True;0;0;False;0;1,0.2392157,0.1215686,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1487;-3182.653,-4564.764;Half;False;DebugMode;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2515;-5550.96,647.395;Inherit;False;Wind (Sample Gust);1;;2767;2f5ec105719e84f46921fb74faad4bf8;0;7;640;SAMPLER2D;;False;623;FLOAT2;0,0;False;620;FLOAT;0;False;621;FLOAT;0;False;653;FLOAT;0;False;624;FLOAT;0;False;625;FLOAT;0;False;5;FLOAT4;528;FLOAT;630;FLOAT;632;FLOAT;634;FLOAT;636
Node;AmplifyShaderEditor.SaturateNode;2226;-4550.563,-2268.23;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2499;-4846.96,1031.395;Float;False;Constant;_GustStrength_Vertex;GustStrength_Vertex;31;0;Create;True;0;0;False;0;91;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2037;-4846.96,1799.395;Float;False;Constant;_Phase;Phase;31;0;Create;True;0;0;False;0;98;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2166;-4590.96,935.395;Inherit;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2055;-4510.96,1735.395;Inherit;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2180;-5222.563,-2620.23;Half;False;Constant;_Color_SecondaryRoll;Color_SecondaryRoll;3;0;Create;True;0;0;False;0;0.12,1,0.2373334,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;2182;-5350.563,-2012.23;Half;False;Constant;_Color_SecondaryBend;Color_SecondaryBend;3;0;Create;True;0;0;False;0;0.56,1,0.6152157,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;2172;-4910.96,855.395;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2042;-4846.96,2055.395;Float;False;Constant;_Variation;Variation;31;0;Create;True;0;0;False;0;99;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2175;-4892.955,1350.405;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2189;-4649.996,607.2695;Inherit;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2187;-4985.996,415.2696;Float;False;Constant;_Tertiary;Tertiary;31;0;Create;True;0;0;False;0;30;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2171;-4910.96,1095.395;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCCompareLower;2488;-4966.563,-3212.23;Inherit;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2514;-5550.96,855.395;Inherit;False;Wind (Sample Gust);1;;2783;2f5ec105719e84f46921fb74faad4bf8;0;7;640;SAMPLER2D;;False;623;FLOAT2;0,0;False;620;FLOAT;0;False;621;FLOAT;0;False;653;FLOAT;0;False;624;FLOAT;0;False;625;FLOAT;0;False;5;FLOAT4;528;FLOAT;630;FLOAT;632;FLOAT;634;FLOAT;636
Node;AmplifyShaderEditor.ColorNode;2193;-5222.563,-3548.23;Half;False;Constant;_Color_Primary;Color_Primary;3;0;Create;True;0;0;False;0;1,0.2373333,0.12,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;2188;-5369.996,447.2696;Half;False;Constant;_Color_Tertiary;Color_Tertiary;3;0;Create;True;0;0;False;0;0.2373332,0.12,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;1939;-5230.96,1575.395;Half;False;Constant;_Color_AmbientOcclusion;Color_AmbientOcclusion;3;0;Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;2227;-4758.563,-2316.23;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2159;-4846.96,775.395;Float;False;Constant;_GustStrength_Object;GustStrength_Object;31;0;Create;True;0;0;False;0;90;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2209;-4694.563,-1404.23;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2046;-5230.96,2087.395;Half;False;Constant;_Color_Variation;Color_Variation;3;0;Create;True;0;0;False;0;1,0,0.5,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2177;-4870.563,-2092.23;Float;False;Constant;_SecondaryBend;SecondaryBend;31;0;Create;True;0;0;False;0;22;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2176;-4838.563,-2652.23;Float;False;Constant;_SecondaryRoll;SecondaryRoll;31;0;Create;True;0;0;False;0;20;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2474;-4758.563,-3244.23;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2476;-4547.563,-3360.23;Inherit;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2475;-4854.563,-3068.23;Float;False;Constant;_PrimaryBend;PrimaryBend;31;0;Create;True;0;0;False;0;12;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2472;-4838.563,-3324.23;Float;False;Constant;_PrimaryPivot;PrimaryPivot;31;0;Create;True;0;0;False;0;11;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2204;-4502.563,-1596.23;Inherit;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2162;-4846.96,1287.395;Float;False;Constant;_GustDirectionality;GustDirectionality;31;0;Create;True;0;0;False;0;92;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2202;-5350.563,-1532.23;Half;False;Constant;_Color_Verticality;Color_Verticality;3;0;Create;True;0;0;False;0;0,1,0.07011509,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;2183;-4502.563,-2460.23;Inherit;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2192;-4838.563,-3580.23;Float;False;Constant;_Primary;Primary;31;0;Create;True;0;0;False;0;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1894;-4846.96,1543.395;Float;False;Constant;_AmbientOcclusion;AmbientOcclusion;31;0;Create;True;0;0;False;0;97;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2179;-4838.563,-2396.23;Float;False;Constant;_SecondaryPivot;SecondaryPivot;31;0;Create;True;0;0;False;0;21;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2473;-5350.563,-2940.23;Half;False;Constant;_Color_PrimaryBend;Color_PrimaryBend;3;0;Create;True;0;0;False;0;1,0.6189286,0.56,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2197;-4838.563,-1788.23;Float;False;Constant;_Forward;Forward;31;0;Create;True;0;0;False;0;23;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2200;-4809.563,-1547.23;Float;False;Constant;_Verticality;Verticality;31;0;Create;True;0;0;False;0;24;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2039;-5230.96,1831.395;Half;False;Constant;_Color_Phase;Color_Phase;3;0;Create;True;0;0;False;0;0.5,0,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;2500;-4847.758,1097.53;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2503;-4206.961,1271.395;Inherit;False;Debug Channel;-1;;2829;81ffbccc3801ea14b83d874e40c65b15;9,27,5,51,0,53,0,55,0,91,0,57,0,96,0,33,0,72,5;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2428;-4206.961,1799.395;Inherit;False;Debug Channel;-1;;2833;81ffbccc3801ea14b83d874e40c65b15;9,27,0,51,3,53,3,55,3,91,3,57,3,96,3,33,3,72,5;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2436;-4206.961,2055.395;Inherit;False;Debug Channel;-1;;2821;81ffbccc3801ea14b83d874e40c65b15;9,27,1,51,3,53,3,55,3,91,3,57,3,96,3,33,3,72,5;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2423;-4206.961,391.395;Inherit;False;Debug Channel;-1;;2823;81ffbccc3801ea14b83d874e40c65b15;9,27,0,51,2,53,2,55,2,91,2,57,2,96,2,33,2,72,5;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;2516;-5505.903,-880.6146;Half;False;Constant;_Color_Tertiary1;Color_Tertiary;3;0;Create;True;0;0;False;0;0.25,0.25,0.25,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;2437;-4198.563,-2396.23;Inherit;False;Debug Channel;-1;;2825;81ffbccc3801ea14b83d874e40c65b15;9,27,5,51,0,53,0,55,0,91,0,57,0,96,0,33,0,72,5;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2425;-4198.563,-1788.23;Inherit;False;Debug Channel;-1;;2827;81ffbccc3801ea14b83d874e40c65b15;9,27,6,51,4,53,4,55,4,91,4,57,4,96,4,33,4,72,3;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;2517;-5441.474,-970.7183;Float;False;Constant;_TypeDesigniator;Type Designiator;31;0;Create;True;0;0;False;0;40;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2504;-4206.961,935.395;Inherit;False;Debug Channel;-1;;2831;81ffbccc3801ea14b83d874e40c65b15;9,27,5,51,0,53,0,55,0,91,0,57,0,96,0,33,0,72,5;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2479;-4198.563,-3324.23;Inherit;False;Debug Channel;-1;;2839;81ffbccc3801ea14b83d874e40c65b15;9,27,5,51,0,53,0,55,0,91,0,57,0,96,0,33,0,72,5;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2430;-4198.563,-2652.23;Inherit;False;Debug Channel;-1;;2841;81ffbccc3801ea14b83d874e40c65b15;9,27,0,51,1,53,1,55,1,91,1,57,1,96,1,33,1,72,5;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2434;-4198.563,-2140.23;Inherit;False;Debug Channel;-1;;2843;81ffbccc3801ea14b83d874e40c65b15;9,27,4,51,3,53,3,55,3,91,3,57,3,96,3,33,3,72,5;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2518;-5105.474,-778.7183;Inherit;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2426;-4206.961,1543.395;Inherit;False;Debug Channel;-1;;2845;81ffbccc3801ea14b83d874e40c65b15;9,27,1,51,2,53,2,55,2,91,2,57,2,96,2,33,2,72,5;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2422;-4206.961,775.395;Inherit;False;Debug Channel;-1;;2847;81ffbccc3801ea14b83d874e40c65b15;9,27,5,51,0,53,0,55,0,91,0,57,0,96,0,33,0,72,5;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2420;-4198.563,-1532.23;Inherit;False;Debug Channel;-1;;2849;81ffbccc3801ea14b83d874e40c65b15;9,27,5,51,0,53,0,55,0,91,0,57,0,96,0,33,0,72,5;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2478;-4198.563,-3068.23;Inherit;True;Debug Channel;-1;;2837;81ffbccc3801ea14b83d874e40c65b15;9,27,2,51,3,53,3,55,3,91,3,57,3,96,3,33,3,72,5;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2421;-4198.563,-3581.23;Inherit;False;Debug Channel;-1;;2835;81ffbccc3801ea14b83d874e40c65b15;9,27,0,51,0,53,0,55,0,91,0,57,0,96,0,33,0,72,5;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1947;-3822.961,1799.395;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2362;-1408,384;Inherit;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2351;-1664,-896;Inherit;False;Constant;_Float13;Float 13;6;0;Create;True;0;0;False;0;141;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2377;-1664,896;Inherit;False;Constant;_Float8;Float 8;6;0;Create;True;0;0;False;0;163;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2521;-4432,3024;Half;False;Constant;_Color_FrontFace;Color_FrontFace;3;0;Create;True;0;0;False;0;1,0.2386928,0.1215686,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2369;-1664,768;Inherit;False;Constant;_Float6;Float 6;6;0;Create;True;0;0;False;0;162;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2191;-3822.961,391.395;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2178;-3814.563,-2428.23;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2316;-1664,-3968;Inherit;False;Constant;_Float24;Float 24;6;0;Create;True;0;0;False;0;100;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2161;-3822.961,919.395;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2297;-1664,-3584;Inherit;False;Constant;_Float20;Float 20;6;0;Create;True;0;0;False;0;103;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2528;-4432,3200;Half;False;Constant;_Color_BackFace;Color_BackFace;3;0;Create;True;0;0;False;0;0.2373332,0.12,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2298;-1664,-3456;Inherit;False;Constant;_Float25;Float 25;6;0;Create;True;0;0;False;0;104;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2322;-1664,-3072;Inherit;False;Constant;_Float23;Float 23;6;0;Create;True;0;0;False;0;112;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2199;-3814.563,-1660.23;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;2519;-4662.438,-994.593;Inherit;False;Debug Channel;-1;;2915;81ffbccc3801ea14b83d874e40c65b15;9,27,3,51,3,53,3,55,3,91,3,57,3,96,3,33,3,72,5;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2294;-1664,-3840;Inherit;False;Constant;_Float2;Float 2;6;0;Create;True;0;0;False;0;101;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2196;-3814.563,-3324.23;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2321;-1664,-2944;Inherit;False;Constant;_Float5;Float 5;6;0;Create;True;0;0;False;0;113;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2327;-1408,-2688;Inherit;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2350;-1664,-768;Inherit;False;Constant;_Float2;Float 2;6;0;Create;True;0;0;False;0;142;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2330;-1664,-2304;Inherit;False;Constant;_Float18;Float 18;6;0;Create;True;0;0;False;0;122;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2349;-1664,-640;Inherit;False;Constant;_Float7;Float 7;6;0;Create;True;0;0;False;0;143;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2329;-1664,-2176;Inherit;False;Constant;_Float19;Float 19;6;0;Create;True;0;0;False;0;123;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2331;-1664,-2432;Inherit;False;Constant;_Float21;Float 21;6;0;Create;True;0;0;False;0;121;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2342;-1664,-1280;Inherit;False;Constant;_Float0;Float 0;6;0;Create;True;0;0;False;0;134;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2353;-1408,-384;Inherit;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2370;-1664,640;Inherit;False;Constant;_Float11;Float 11;6;0;Create;True;0;0;False;0;161;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2324;-1664,-2816;Inherit;False;Constant;_Float26;Float 26;6;0;Create;True;0;0;False;0;114;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2372;-1408,1152;Inherit;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2343;-1408,-1152;Inherit;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2352;-1664,-512;Inherit;False;Constant;_Float12;Float 12;6;0;Create;True;0;0;False;0;144;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2359;-1664,0;Inherit;False;Constant;_Float10;Float 10;6;0;Create;True;0;0;False;0;152;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2360;-1664,-128;Inherit;False;Constant;_Float9;Float 9;6;0;Create;True;0;0;False;0;151;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2341;-1664,-1664;Inherit;False;Constant;_Float15;Float 15;6;0;Create;True;0;0;False;0;131;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2323;-1664,-3200;Inherit;False;Constant;_Float4;Float 4;6;0;Create;True;0;0;False;0;111;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2296;-1664,-3712;Inherit;False;Constant;_Float17;Float 17;6;0;Create;True;0;0;False;0;102;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2367;-1664,128;Inherit;False;Constant;_Float1;Float 1;6;0;Create;True;0;0;False;0;153;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2272;-1408,-3328;Inherit;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2340;-1664,-1536;Inherit;False;Constant;_Float14;Float 14;6;0;Create;True;0;0;False;0;132;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2332;-1664,-2048;Inherit;False;Constant;_Float22;Float 22;6;0;Create;True;0;0;False;0;124;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2339;-1664,-1408;Inherit;False;Constant;_Float3;Float 3;6;0;Create;True;0;0;False;0;133;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2371;-1664,1024;Inherit;False;Constant;_Float16;Float 16;6;0;Create;True;0;0;False;0;164;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2333;-1408,-1920;Inherit;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2447;-1152,-1664;Inherit;False;Debug Channel;-1;;2917;81ffbccc3801ea14b83d874e40c65b15;9,27,3,51,0,53,0,55,0,91,0,57,0,96,0,33,0,72,6;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2455;-1152,-2176;Inherit;False;Debug Channel;-1;;2929;81ffbccc3801ea14b83d874e40c65b15;9,27,2,51,2,53,2,55,2,91,2,57,2,96,2,33,2,72,8;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2449;-1152,-3200;Inherit;False;Debug Channel;-1;;2919;81ffbccc3801ea14b83d874e40c65b15;9,27,1,51,0,53,0,55,0,91,0,57,0,96,0,33,0,72,6;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2453;-1152,-2304;Inherit;False;Debug Channel;-1;;2921;81ffbccc3801ea14b83d874e40c65b15;9,27,2,51,1,53,1,55,1,91,1,57,1,96,1,33,1,72,7;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2454;-1152,640;Inherit;False;Debug Channel;-1;;2923;81ffbccc3801ea14b83d874e40c65b15;9,27,8,51,0,53,0,55,0,91,0,57,0,96,0,33,0,72,6;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2448;-1152,-512;Inherit;False;Debug Channel;-1;;2925;81ffbccc3801ea14b83d874e40c65b15;9,27,4,51,3,53,3,55,3,91,3,57,3,96,3,33,3,72,5;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2431;-1152,-3712;Inherit;False;Debug Channel;-1;;2927;81ffbccc3801ea14b83d874e40c65b15;9,27,0,51,1,53,1,55,1,91,1,57,1,96,1,33,1,72,7;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SwitchByFaceNode;2527;-3920,3088;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2435;-1152,-3968;Inherit;False;Debug Channel;-1;;2935;81ffbccc3801ea14b83d874e40c65b15;9,27,6,51,5,53,5,55,5,91,5,57,5,96,5,33,5,72,0;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2419;-1152,-2048;Inherit;False;Debug Channel;-1;;2937;81ffbccc3801ea14b83d874e40c65b15;9,27,2,51,3,53,3,55,3,91,3,57,3,96,3,33,3,72,5;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2457;-1152,1024;Inherit;False;Debug Channel;-1;;2939;81ffbccc3801ea14b83d874e40c65b15;9,27,8,51,4,53,4,55,4,91,4,57,4,96,4,33,4,72,4;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;2452;-1152,768;Inherit;False;Debug Channel;-1;;2941;81ffbccc3801ea14b83d874e40c65b15;9,27,8,51,1,53,1,55,1,91,1,57,1,96,1,33,1,72,7;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2432;-1152,-2944;Inherit;False;Debug Channel;-1;;2943;81ffbccc3801ea14b83d874e40c65b15;9,27,1,51,2,53,2,55,2,91,2,57,2,96,2,33,2,72,8;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2502;-3566.961,903.395;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2442;-1152,-128;Inherit;False;Debug Channel;-1;;2933;81ffbccc3801ea14b83d874e40c65b15;9,27,7,51,0,53,0,55,0,91,0,57,0,96,0,33,0,72,6;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2458;-1152,-1280;Inherit;False;Debug Channel;-1;;2945;81ffbccc3801ea14b83d874e40c65b15;9,27,3,51,3,53,3,55,3,91,3,57,3,96,3,33,3,72,5;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2427;-1152,0;Inherit;False;Debug Channel;-1;;2931;81ffbccc3801ea14b83d874e40c65b15;9,27,7,51,1,53,1,55,1,91,1,57,1,96,1,33,1,72,7;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2441;-1152,-1408;Inherit;False;Debug Channel;-1;;2947;81ffbccc3801ea14b83d874e40c65b15;9,27,3,51,2,53,2,55,2,91,2,57,2,96,2,33,2,72,8;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2445;-1152,-896;Inherit;False;Debug Channel;-1;;2971;81ffbccc3801ea14b83d874e40c65b15;9,27,4,51,0,53,0,55,0,91,0,57,0,96,0,33,0,72,6;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2429;-1152,-3072;Inherit;False;Debug Channel;-1;;2951;81ffbccc3801ea14b83d874e40c65b15;9,27,1,51,1,53,1,55,1,91,1,57,1,96,1,33,1,72,7;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2523;-3872,2896;Inherit;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2451;-1152,-1536;Inherit;False;Debug Channel;-1;;2953;81ffbccc3801ea14b83d874e40c65b15;9,27,3,51,1,53,1,55,1,91,1,57,1,96,1,33,1,72,7;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2456;-1152,-2816;Inherit;False;Debug Channel;-1;;2955;81ffbccc3801ea14b83d874e40c65b15;9,27,1,51,3,53,3,55,3,91,3,57,3,96,3,33,3,72,5;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2446;-1152,-3840;Inherit;False;Debug Channel;-1;;2957;81ffbccc3801ea14b83d874e40c65b15;9,27,0,51,0,53,0,55,0,91,0,57,0,96,0,33,0,72,6;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2520;-4099.231,-1004.758;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2438;-1152,-2432;Inherit;False;Debug Channel;-1;;2959;81ffbccc3801ea14b83d874e40c65b15;9,27,2,51,0,53,0,55,0,91,0,57,0,96,0,33,0,72,6;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2450;-1152,896;Inherit;False;Debug Channel;-1;;2963;81ffbccc3801ea14b83d874e40c65b15;9,27,8,51,2,53,2,55,2,91,2,57,2,96,2,33,2,72,8;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2440;-1152,128;Inherit;False;Debug Channel;-1;;2965;81ffbccc3801ea14b83d874e40c65b15;9,27,7,51,2,53,2,55,2,91,2,57,2,96,2,33,2,72,8;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2433;-1152,-3584;Inherit;False;Debug Channel;-1;;2967;81ffbccc3801ea14b83d874e40c65b15;9,27,0,51,2,53,2,55,2,91,2,57,2,96,2,33,2,72,8;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2501;-3558.563,-2428.23;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2522;-4352,2944;Float;False;Constant;_Facing;Facing;31;0;Create;True;0;0;False;0;80;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2439;-1152,-3456;Inherit;False;Debug Channel;-1;;2949;81ffbccc3801ea14b83d874e40c65b15;9,27,0,51,3,53,3,55,3,91,3,57,3,96,3,33,3,72,5;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2443;-1152,-640;Inherit;False;Debug Channel;-1;;2961;81ffbccc3801ea14b83d874e40c65b15;9,27,4,51,2,53,2,55,2,91,2,57,2,96,2,33,2,72,8;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2444;-1152,-768;Inherit;False;Debug Channel;-1;;2969;81ffbccc3801ea14b83d874e40c65b15;9,27,4,51,1,53,1,55,1,91,1,57,1,96,1,33,1,72,7;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2269;-768,-3664;Inherit;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2318;-768,-3024;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2348;-768,-720;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2328;-768,-2256;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2524;-3583,2929;Inherit;False;Debug Channel;-1;;2973;81ffbccc3801ea14b83d874e40c65b15;9,27,6,51,2,53,2,55,2,91,2,57,2,96,2,33,2,72,5;4;29;FLOAT;0;False;30;FLOAT;0;False;28;FLOAT;0;False;31;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1915;-3353.665,-1241.026;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2338;-768,-1488;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2358;-768,48;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2368;-768,816;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2418;-226.6282,-1530.199;Inherit;False;7;7;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2530;-3255.384,2921.198;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexToFragmentNode;2018;-3174.563,-1244.23;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2529;-2709.344,-1224.039;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexToFragmentNode;1719;0.0743084,-1519.66;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FresnelNode;1442;-4592.651,-4173.764;Inherit;False;Standard;TangentNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1.5;False;3;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2019;-2304,-1248;Float;False;SPECIAL_COLOR;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1720;-3440.652,-4461.764;Half;False;Global;_DEBUG_MIN;_DEBUG_MIN;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1722;-3440.652,-4365.764;Half;False;Global;_DEBUG_MAX;_DEBUG_MAX;3;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1906;256.0743,-1519.66;Inherit;False;MESH_COLOR;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2021;-2512.245,-5005.49;Inherit;False;1906;MESH_COLOR;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1723;-3138.653,-4365.764;Half;False;DebugMax;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1721;-3216.653,-4461.764;Half;False;DebugMin;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1440;-4336.651,-4301.764;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1439;-4592.651,-4381.764;Half;False;Constant;_Color6;Color 6;0;0;Create;True;0;0;False;0;1,0.809,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1362;-2512.245,-5085.49;Inherit;False;2019;SPECIAL_COLOR;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1459;-4592.651,-4557.764;Half;False;Constant;_Color7;Color 7;0;0;Create;True;0;0;False;0;1,0.5019608,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;1437;-4144.651,-4557.764;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1726;-2190.045,-4763.789;Inherit;False;1721;DebugMin;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1434;-4080.652,-4365.764;Half;False;Property;_Debug_Arrow;Debug_Arrow;6;0;Create;True;0;0;True;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1727;-2190.045,-4683.789;Inherit;False;1723;DebugMax;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1312;-2208.245,-5085.49;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1724;-1872.245,-5085.49;Inherit;False;Remap To 0-1;-1;;2975;5eda8a2bb94ebef4ab0e43d19291cd8b;0;3;6;COLOR;0,0,0,0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1450;-3888.651,-4365.764;Half;False;ArrowDebug;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1438;-3888.651,-4557.764;Half;False;ArrowColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1151;-1232.245,-4637.49;Half;False;Constant;_Float0;Float 0;20;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1273;-1232.245,-4829.49;Inherit;False;1438;ArrowColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;1222;-1680.245,-5085.49;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1281;-1232.245,-4749.49;Inherit;False;1450;ArrowDebug;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1278;-912.2453,-5085.49;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;1572;-802.2453,-4802.49;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1750;-1689.245,-4889.49;Inherit;False;1481;OtherColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1573;-620.2457,-4874.49;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2024;-3696.651,-4877.764;Inherit;True;Property;_MainTex;Main Texture;7;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1510;-1232.245,-4429.49;Float;True;Constant;_Float1;Float 1;38;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1481;-3069.653,-4280.764;Half;False;OtherColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;1508;-976.2453,-4509.49;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;18;-3695.651,-5069.764;Inherit;True;Property;_MainTex;Main Texture;7;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1150;-640.2457,-5085.49;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2230;-1275.349,-4516.261;Inherit;False;616;MainTexAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1467;-3440.652,-4269.764;Float;False;Constant;_Color12;Color 12;21;0;Create;True;0;0;False;0;0.1397059,0.1397059,0.1397059,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMaxOpNode;2025;-3244.04,-4946.779;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;616;-3056.653,-4941.764;Half;False;MainTexAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1738;-1422.245,-4962.49;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-208.2457,-4957.49;Float;False;True;-1;2;AppalachiaShaderGUI;300;0;Lambert;appalachia/debug;False;False;False;False;True;True;True;True;True;True;True;True;False;True;True;True;True;False;False;False;False;Off;0;False;925;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;False;0;False;TransparentCutout;;AlphaTest;All;11;d3d11_9x;d3d11;glcore;gles3;metal;xbox360;xboxone;ps4;psp2;n3ds;wiiu;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;1;True;550;1;True;553;0;0;False;550;0;False;553;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;300;;0;-1;-1;-1;0;False;0;0;False;743;-1;0;False;862;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;14;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;16;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;1502;-1792,-4096;Inherit;False;1664.767;100;Vertex Color;0;;1,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1881;-4608,-3712;Inherit;False;2312.091;100;Tree Wind;0;;0,1,0.1833334,1;0;0
WireConnection;2250;0;2228;0
WireConnection;2250;1;2222;0
WireConnection;2032;0;2497;494
WireConnection;2032;1;2050;0
WireConnection;2030;7;1817;4
WireConnection;2174;7;2032;0
WireConnection;2224;0;2250;0
WireConnection;2510;0;2506;0
WireConnection;2509;0;2507;7
WireConnection;1487;0;1480;0
WireConnection;2515;640;2513;0
WireConnection;2515;623;2509;0
WireConnection;2515;620;2497;500
WireConnection;2515;624;2497;526
WireConnection;2515;625;2497;527
WireConnection;2226;0;2224;0
WireConnection;2172;0;1935;0
WireConnection;2175;0;2174;0
WireConnection;2171;0;1935;0
WireConnection;2488;0;2468;2
WireConnection;2488;1;2467;2
WireConnection;2488;2;2487;0
WireConnection;2514;640;2513;0
WireConnection;2514;623;2510;0
WireConnection;2514;620;2497;500
WireConnection;2514;624;2497;526
WireConnection;2514;625;2497;527
WireConnection;2227;0;2181;0
WireConnection;2209;0;2030;0
WireConnection;2474;0;2470;0
WireConnection;2500;0;1935;0
WireConnection;2503;29;2166;0
WireConnection;2503;30;2162;0
WireConnection;2503;28;2175;0
WireConnection;2503;31;2171;0
WireConnection;2428;29;2055;0
WireConnection;2428;30;2037;0
WireConnection;2428;31;2039;0
WireConnection;2436;29;2055;0
WireConnection;2436;30;2042;0
WireConnection;2436;31;2046;0
WireConnection;2423;29;2189;0
WireConnection;2423;30;2187;0
WireConnection;2423;31;2188;0
WireConnection;2437;29;2183;0
WireConnection;2437;30;2179;0
WireConnection;2437;28;2226;0
WireConnection;2437;31;2227;0
WireConnection;2425;29;2204;0
WireConnection;2425;30;2197;0
WireConnection;2504;29;2166;0
WireConnection;2504;30;2499;0
WireConnection;2504;28;2514;528
WireConnection;2504;31;2500;0
WireConnection;2479;29;2476;0
WireConnection;2479;30;2472;0
WireConnection;2479;28;2488;0
WireConnection;2479;31;2474;0
WireConnection;2430;29;2183;0
WireConnection;2430;30;2176;0
WireConnection;2430;31;2180;0
WireConnection;2434;29;2183;0
WireConnection;2434;30;2177;0
WireConnection;2434;31;2182;0
WireConnection;2426;29;2055;0
WireConnection;2426;30;1894;0
WireConnection;2426;31;1939;0
WireConnection;2422;29;2166;0
WireConnection;2422;30;2159;0
WireConnection;2422;28;2515;528
WireConnection;2422;31;2172;0
WireConnection;2420;29;2204;0
WireConnection;2420;30;2200;0
WireConnection;2420;28;2209;0
WireConnection;2420;31;2202;0
WireConnection;2478;29;2476;0
WireConnection;2478;30;2475;0
WireConnection;2478;31;2473;0
WireConnection;2421;29;2476;0
WireConnection;2421;30;2192;0
WireConnection;2421;31;2193;0
WireConnection;1947;0;2426;0
WireConnection;1947;1;2428;0
WireConnection;1947;2;2436;0
WireConnection;2191;0;2423;0
WireConnection;2178;0;2430;0
WireConnection;2178;1;2437;0
WireConnection;2178;2;2434;0
WireConnection;2161;0;2422;0
WireConnection;2161;1;2504;0
WireConnection;2161;2;2503;0
WireConnection;2199;0;2425;0
WireConnection;2199;1;2420;0
WireConnection;2519;29;2518;0
WireConnection;2519;30;2517;0
WireConnection;2519;31;2516;0
WireConnection;2196;0;2421;0
WireConnection;2196;1;2479;0
WireConnection;2196;2;2478;0
WireConnection;2447;29;2343;0
WireConnection;2447;30;2341;0
WireConnection;2455;29;2333;0
WireConnection;2455;30;2329;0
WireConnection;2449;29;2327;0
WireConnection;2449;30;2323;0
WireConnection;2453;29;2333;0
WireConnection;2453;30;2330;0
WireConnection;2454;29;2372;0
WireConnection;2454;30;2370;0
WireConnection;2448;29;2353;0
WireConnection;2448;30;2352;0
WireConnection;2431;29;2272;0
WireConnection;2431;30;2296;0
WireConnection;2527;0;2521;0
WireConnection;2527;1;2528;0
WireConnection;2435;29;2272;0
WireConnection;2435;30;2316;0
WireConnection;2419;29;2333;0
WireConnection;2419;30;2332;0
WireConnection;2457;29;2372;0
WireConnection;2457;30;2371;0
WireConnection;2452;29;2372;0
WireConnection;2452;30;2369;0
WireConnection;2432;29;2327;0
WireConnection;2432;30;2321;0
WireConnection;2502;0;2191;0
WireConnection;2502;1;2161;0
WireConnection;2502;2;1947;0
WireConnection;2442;29;2362;0
WireConnection;2442;30;2360;0
WireConnection;2458;29;2343;0
WireConnection;2458;30;2342;0
WireConnection;2427;29;2362;0
WireConnection;2427;30;2359;0
WireConnection;2441;29;2343;0
WireConnection;2441;30;2339;0
WireConnection;2445;29;2353;0
WireConnection;2445;30;2351;0
WireConnection;2429;29;2327;0
WireConnection;2429;30;2322;0
WireConnection;2451;29;2343;0
WireConnection;2451;30;2340;0
WireConnection;2456;29;2327;0
WireConnection;2456;30;2324;0
WireConnection;2446;29;2272;0
WireConnection;2446;30;2294;0
WireConnection;2520;0;2519;0
WireConnection;2438;29;2333;0
WireConnection;2438;30;2331;0
WireConnection;2450;29;2372;0
WireConnection;2450;30;2377;0
WireConnection;2440;29;2362;0
WireConnection;2440;30;2367;0
WireConnection;2433;29;2272;0
WireConnection;2433;30;2297;0
WireConnection;2501;0;2196;0
WireConnection;2501;1;2178;0
WireConnection;2501;2;2199;0
WireConnection;2439;29;2272;0
WireConnection;2439;30;2298;0
WireConnection;2443;29;2353;0
WireConnection;2443;30;2349;0
WireConnection;2444;29;2353;0
WireConnection;2444;30;2350;0
WireConnection;2269;0;2435;0
WireConnection;2269;1;2446;0
WireConnection;2269;2;2431;0
WireConnection;2269;3;2433;0
WireConnection;2269;4;2439;0
WireConnection;2318;0;2449;0
WireConnection;2318;1;2429;0
WireConnection;2318;2;2432;0
WireConnection;2318;3;2456;0
WireConnection;2348;0;2445;0
WireConnection;2348;1;2444;0
WireConnection;2348;2;2443;0
WireConnection;2348;3;2448;0
WireConnection;2328;0;2438;0
WireConnection;2328;1;2453;0
WireConnection;2328;2;2455;0
WireConnection;2328;3;2419;0
WireConnection;2524;29;2523;0
WireConnection;2524;30;2522;0
WireConnection;2524;31;2527;0
WireConnection;1915;0;2501;0
WireConnection;1915;1;2520;0
WireConnection;1915;2;2502;0
WireConnection;2338;0;2447;0
WireConnection;2338;1;2451;0
WireConnection;2338;2;2441;0
WireConnection;2338;3;2458;0
WireConnection;2358;0;2442;0
WireConnection;2358;1;2427;0
WireConnection;2358;2;2440;0
WireConnection;2368;0;2454;0
WireConnection;2368;1;2452;0
WireConnection;2368;2;2450;0
WireConnection;2368;3;2457;0
WireConnection;2418;0;2269;0
WireConnection;2418;1;2318;0
WireConnection;2418;2;2328;0
WireConnection;2418;3;2338;0
WireConnection;2418;4;2348;0
WireConnection;2418;5;2358;0
WireConnection;2418;6;2368;0
WireConnection;2530;0;2524;0
WireConnection;2018;0;1915;0
WireConnection;2529;0;2018;0
WireConnection;2529;1;2530;0
WireConnection;1719;0;2418;0
WireConnection;2019;0;2529;0
WireConnection;1906;0;1719;0
WireConnection;1723;0;1722;0
WireConnection;1721;0;1720;0
WireConnection;1440;0;1442;0
WireConnection;1437;0;1459;0
WireConnection;1437;1;1439;0
WireConnection;1437;2;1440;0
WireConnection;1312;0;1362;0
WireConnection;1312;1;2021;0
WireConnection;1724;6;1312;0
WireConnection;1724;7;1726;0
WireConnection;1724;8;1727;0
WireConnection;1450;0;1434;0
WireConnection;1438;0;1437;0
WireConnection;1222;0;1724;0
WireConnection;1278;0;1222;0
WireConnection;1278;1;1273;0
WireConnection;1278;2;1281;0
WireConnection;1572;0;1151;0
WireConnection;1573;0;1278;0
WireConnection;1573;1;1572;0
WireConnection;1481;0;1467;0
WireConnection;1508;0;2230;0
WireConnection;1508;1;1510;0
WireConnection;1150;0;1278;0
WireConnection;1150;1;1151;0
WireConnection;2025;0;18;4
WireConnection;2025;1;2024;4
WireConnection;616;0;2025;0
WireConnection;1738;1;1750;0
WireConnection;0;0;1150;0
WireConnection;0;2;1573;0
ASEEND*/
//CHKSM=F25148F0E4975F7FE97D3F3A9AD7668FED795ED9