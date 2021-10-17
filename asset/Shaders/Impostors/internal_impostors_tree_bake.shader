// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "appalachia/impostors/tree-bake"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		[NoScaleOffset]_MainTex("Bark Albedo", 2D) = "white" {}
		_Saturation("Saturation", Range( 0.1 , 2)) = 1
		_Brightness("Brightness", Range( 0.1 , 2)) = 1
		_BumpScale("Normal Scale", Range( 0 , 5)) = 1
		[NoScaleOffset]_BumpMap("Bark Normal", 2D) = "bump" {}
		[NoScaleOffset]_MetallicGlossMap("Surface", 2D) = "white" {}
		_Glossiness("Smoothness", Range( 0 , 1)) = 0.1
		[Space(10)]_UVZero("Trunk UVs", Vector) = (1,1,0,0)
		_Occlusion("Occlusion", Range( 0 , 1)) = 1
		_LeafColor2("Leaf Color 2", Color) = (1,1,1,1)
		_TextureOcclusionDarkening("Texture Occlusion Darkening", Range( 0 , 1)) = 0
		_VertexOcclusion("Vertex Occlusion", Range( 0 , 1)) = 0.5
		_NonLeafColor("Non-Leaf Color", Color) = (1,1,1,1)
		_VertexOcclusionDarkening("Vertex Occlusion Darkening", Range( 0 , 1)) = 0
		_OcclusionColor("Occlusion Color", Color) = (0,0,0,0)
		[Toggle(_ENABLEBASE_ON)] _ENABLEBASE("Enable Base", Float) = 0
		_Color3("Base Color", Color) = (1,1,1,1)
		[NoScaleOffset]_MainTex3("Base Albedo", 2D) = "white" {}
		_BumpScale3("Base Normal Scale", Float) = 1
		[NoScaleOffset][Normal]_BumpMap3("Base Normal", 2D) = "bump" {}
		[NoScaleOffset]_MetallicGlossMap3("Base Surface", 2D) = "white" {}
		_Glossiness3("Base Smoothness", Range( 0 , 1)) = 0.1
		_Occlusion3("Base Occlusion", Range( 0 , 1)) = 1
		[Space(10)]_UVZero3("Base UVs", Vector) = (1,1,0,0)
		_BaseBlendHeight("Base Blend Height", Range( 0 , 20)) = 0.1
		_BaseBlendAmount("Base Blend Amount", Range( 0.0001 , 1)) = 0.1
		_TrunkHeightOffset("Trunk Height Offset", Range( -1 , 1)) = 0
		_TrunkHeightRange("Trunk Height Range", Range( 0 , 1)) = 1
		_BaseBlendHeightContrast("Base Blend Height Contrast", Range( 0 , 1)) = 0.5
		_BaseHeightOffset("Base Height Offset", Range( -1 , 1)) = 0
		_BaseHeightRange("Base Height Range", Range( 0 , 1)) = 0.9
		_BaseBlendNormals("Base Blend Normals", Range( 0 , 1)) = 0
		[HideInInspector][Toggle]_IsBark("Is Bark", Float) = 1

	}

	SubShader
	{
		Tags { "RenderType"="Opaque" }
	LOD 100
		CGINCLUDE
		#pragma target 4.0
		ENDCG
		Cull Off
		

		Pass
		{
			Name "Unlit"
			CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#pragma multi_compile_fwdbase
			#include "UnityShaderVariables.cginc"
			#include "UnityStandardUtils.cginc"
			#include "Lighting.cginc"
			#include "AutoLight.cginc"
			#pragma shader_feature_local _ENABLEBASE_ON


			struct appdata
			{
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_tangent : TANGENT;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_color : COLOR;
			};

			struct v2f
			{
				UNITY_POSITION(pos);
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_color : COLOR;
			};

			//This is a late directive
			
			uniform sampler2D _MainTex;
			uniform half4 _UVZero;
			uniform float _Saturation;
			uniform float _Brightness;
			uniform sampler2D _MainTex3;
			uniform half4 _UVZero3;
			uniform half _BaseBlendHeight;
			uniform half _BaseBlendAmount;
			uniform sampler2D _MetallicGlossMap3;
			uniform float _BaseHeightRange;
			uniform float _BaseHeightOffset;
			uniform sampler2D _MetallicGlossMap;
			uniform float _TrunkHeightRange;
			uniform float _TrunkHeightOffset;
			uniform float _BaseBlendHeightContrast;
			uniform float4 _OcclusionColor;
			uniform half _VertexOcclusion;
			uniform half _VertexOcclusionDarkening;
			uniform half _Occlusion;
			uniform half _Occlusion3;
			uniform half _TextureOcclusionDarkening;
			uniform half _BumpScale;
			uniform sampler2D _BumpMap;
			uniform half _BumpScale3;
			uniform sampler2D _BumpMap3;
			uniform half _BaseBlendNormals;
			uniform half4 _Color;
			uniform half4 _Color3;
			uniform half _IsBark;
			uniform half4 _LeafColor2;
			uniform half4 _NonLeafColor;
			uniform half _Glossiness;
			uniform half _Glossiness3;
			float3 HSVToRGB( float3 c )
			{
				float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
				float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
				return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
			}
			
			float3 RGBToHSV(float3 c)
			{
				float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
				float4 p = lerp( float4( c.bg, K.wz ), float4( c.gb, K.xy ), step( c.b, c.g ) );
				float4 q = lerp( float4( p.xyw, c.r ), float4( c.r, p.yzx ), step( p.x, c.r ) );
				float d = q.x - min( q.w, q.y );
				float e = 1.0e-10;
				return float3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}


			v2f vert(appdata v )
			{
				v2f o = (v2f)0;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				float4 uv4332_g8718 = v.ase_texcoord4;
				uv4332_g8718.xy = v.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float4 break360_g8718 = uv4332_g8718;
				float3 ase_worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				float3 temp_output_356_0_g8718 = ( ase_worldPos - (_WorldSpaceCameraPos).xyz );
				float3 normalizeResult358_g8718 = normalize( temp_output_356_0_g8718 );
				float3 cam_pos_axis_z384_g8718 = normalizeResult358_g8718;
				float3 normalizeResult366_g8718 = normalize( cross( float3(0,1,0) , cam_pos_axis_z384_g8718 ) );
				float3 cam_pos_axis_x385_g8718 = normalizeResult366_g8718;
				float4x4 break375_g8718 = UNITY_MATRIX_V;
				float3 appendResult377_g8718 = (float3(break375_g8718[ 0 ][ 0 ] , break375_g8718[ 0 ][ 1 ] , break375_g8718[ 0 ][ 2 ]));
				float3 cam_rot_axis_x378_g8718 = appendResult377_g8718;
				float dotResult436_g8718 = dot( float3(0,1,0) , temp_output_356_0_g8718 );
				float temp_output_438_0_g8718 = saturate( abs( dotResult436_g8718 ) );
				float3 lerpResult424_g8718 = lerp( cam_pos_axis_x385_g8718 , cam_rot_axis_x378_g8718 , temp_output_438_0_g8718);
				float3 xAxis346_g8718 = lerpResult424_g8718;
				float3 cam_pos_axis_y383_g8718 = cross( cam_pos_axis_z384_g8718 , normalizeResult366_g8718 );
				float3 appendResult381_g8718 = (float3(break375_g8718[ 1 ][ 0 ] , break375_g8718[ 1 ][ 1 ] , break375_g8718[ 1 ][ 2 ]));
				float3 cam_rot_axis_y379_g8718 = appendResult381_g8718;
				float3 lerpResult423_g8718 = lerp( cam_pos_axis_y383_g8718 , cam_rot_axis_y379_g8718 , temp_output_438_0_g8718);
				float3 yAxis362_g8718 = lerpResult423_g8718;
				float isBillboard343_g8718 = (( break360_g8718.w < -0.99999 ) ? 1.0 :  0.0 );
				
				float3 ase_worldTangent = UnityObjectToWorldDir(v.ase_tangent);
				o.ase_texcoord3.xyz = ase_worldTangent;
				float3 ase_worldNormal = UnityObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord4.xyz = ase_worldNormal;
				float ase_vertexTangentSign = v.ase_tangent.w * unity_WorldTransformParams.w;
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord5.xyz = ase_worldBitangent;
				o.ase_texcoord6.xyz = ase_worldPos;
				
				float3 objectToViewPos = UnityObjectToViewPos(v.vertex.xyz);
				float eyeDepth = -objectToViewPos.z;
				o.ase_texcoord1.z = eyeDepth;
				
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord1.xy = v.ase_texcoord3.xy;
				o.ase_texcoord2 = v.vertex;
				o.ase_texcoord7 = v.ase_texcoord2;
				o.ase_color = v.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.w = 0;
				o.ase_texcoord3.w = 0;
				o.ase_texcoord4.w = 0;
				o.ase_texcoord5.w = 0;
				o.ase_texcoord6.w = 0;

				v.vertex.xyz += ( -( ( break360_g8718.x * xAxis346_g8718 ) + ( break360_g8718.y * yAxis362_g8718 ) ) * isBillboard343_g8718 * -1.0 );
				o.pos = UnityObjectToClipPos(v.vertex);
				return o;
			}


			void frag(v2f i , half ase_vface : VFACE,
				out half4 outGBuffer0 : SV_Target0, 
				out half4 outGBuffer1 : SV_Target1, 
				out half4 outGBuffer2 : SV_Target2, 
				out half4 outGBuffer3 : SV_Target3,
				out half4 outGBuffer4 : SV_Target4,
				out half4 outGBuffer5 : SV_Target5,
				out half4 outGBuffer6 : SV_Target6,
				out half4 outGBuffer7 : SV_Target7,
				out float outDepth : SV_Depth
			) 
			{
				UNITY_SETUP_INSTANCE_ID( i );
				float2 appendResult564 = (float2(_UVZero.x , _UVZero.y));
				float2 appendResult565 = (float2(_UVZero.z , _UVZero.w));
				half2 Main_UVs587 = ( ( i.ase_texcoord.xy * appendResult564 ) + appendResult565 );
				float4 tex2DNode18 = tex2D( _MainTex, Main_UVs587 );
				float3 hsvTorgb2213 = RGBToHSV( tex2DNode18.rgb );
				float3 hsvTorgb2218 = HSVToRGB( float3(hsvTorgb2213.x,( hsvTorgb2213.y * _Saturation ),( hsvTorgb2213.z * _Brightness )) );
				half3 Main_MainTex487 = hsvTorgb2218;
				float2 appendResult1482 = (float2(_UVZero3.x , _UVZero3.y));
				float2 appendResult1483 = (float2(_UVZero3.z , _UVZero3.w));
				float2 temp_output_1485_0 = ( ( i.ase_texcoord1.xy * appendResult1482 ) + appendResult1483 );
				half4 Base_MainTex1489 = tex2D( _MainTex3, temp_output_1485_0 );
				float4 tex2DNode2049 = tex2D( _MetallicGlossMap3, temp_output_1485_0 );
				half Base_MetallicGlossMap_B2229 = tex2DNode2049.b;
				float height_230_g3760 = saturate( ( (0.0 + (Base_MetallicGlossMap_B2229 - 0.0) * (_BaseHeightRange - 0.0) / (1.0 - 0.0)) + _BaseHeightOffset ) );
				float4 tex2DNode645 = tex2D( _MetallicGlossMap, Main_UVs587 );
				half Main_MetallicGlossMap_B1929 = tex2DNode645.b;
				float height_129_g3760 = saturate( ( (0.0 + (Main_MetallicGlossMap_B1929 - 0.0) * (_TrunkHeightRange - 0.0) / (1.0 - 0.0)) + _TrunkHeightOffset ) );
				float clampResult6_g3760 = clamp( ( 1.0 - saturate( _BaseBlendHeightContrast ) ) , 1E-07 , 0.999999 );
				float height_start26_g3760 = ( max( height_129_g3760 , height_230_g3760 ) - clampResult6_g3760 );
				float level_239_g3760 = max( ( height_230_g3760 - height_start26_g3760 ) , 0.0 );
				float level_138_g3760 = max( ( height_129_g3760 - height_start26_g3760 ) , 0.0 );
				float temp_output_60_0_g3760 = ( level_138_g3760 + level_239_g3760 );
				half Mask_BaseBlend1491 = ( ( 1.0 - saturate( (0.0 + (i.ase_texcoord2.xyz.y - 0.0) * (1.0 - 0.0) / (_BaseBlendHeight - 0.0)) ) ) * _BaseBlendAmount * ( level_239_g3760 / temp_output_60_0_g3760 ) );
				float4 lerpResult1495 = lerp( float4( Main_MainTex487 , 0.0 ) , Base_MainTex1489 , Mask_BaseBlend1491);
				half4 Blending_BaseAlbedo1896 = lerpResult1495;
				#ifdef _ENABLEBASE_ON
				float4 staticSwitch2463 = Blending_BaseAlbedo1896;
				#else
				float4 staticSwitch2463 = float4( Main_MainTex487 , 0.0 );
				#endif
				half4 OUT_ALBEDO1501 = staticSwitch2463;
				float4 main33_g8665 = OUT_ALBEDO1501;
				float4 color31_g8666 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
				float4 temp_output_8_0_g8665 = color31_g8666;
				float lerpResult1308 = lerp( 1.0 , i.ase_texcoord.z , _VertexOcclusion);
				half Vertex_Occlusion1312 = lerpResult1308;
				float4 temp_cast_3 = (Vertex_Occlusion1312).xxxx;
				float4 lerpResult12_g8665 = lerp( temp_output_8_0_g8665 , temp_cast_3 , _VertexOcclusionDarkening);
				float4 temp_output_15_0_g8667 = lerpResult12_g8665;
				half Main_MetallicGlossMap_G1788 = tex2DNode645.g;
				float lerpResult1793 = lerp( 1.0 , Main_MetallicGlossMap_G1788 , _Occlusion);
				half Main_Occlusion1794 = lerpResult1793;
				half Base_MetallicGlossMap_G2050 = tex2DNode2049.g;
				float lerpResult2055 = lerp( 1.0 , Base_MetallicGlossMap_G2050 , _Occlusion3);
				half Base_Occlusion2056 = lerpResult2055;
				float lerpResult2065 = lerp( Main_Occlusion1794 , Base_Occlusion2056 , Mask_BaseBlend1491);
				half Blending_BaseOcclusion2064 = lerpResult2065;
				#ifdef _ENABLEBASE_ON
				float staticSwitch2466 = Blending_BaseOcclusion2064;
				#else
				float staticSwitch2466 = Main_Occlusion1794;
				#endif
				half OUT_AO2077 = staticSwitch2466;
				float4 temp_cast_4 = (OUT_AO2077).xxxx;
				float4 lerpResult13_g8665 = lerp( temp_output_8_0_g8665 , temp_cast_4 , _TextureOcclusionDarkening);
				float4 temp_output_16_0_g8667 = lerpResult13_g8665;
				float4 lerpResult20_g8665 = lerp( _OcclusionColor , main33_g8665 , ( ( temp_output_15_0_g8667 + temp_output_16_0_g8667 ) / 2.0 ));
				float3 tex2DNode607 = UnpackScaleNormal( tex2D( _BumpMap, Main_UVs587 ), _BumpScale );
				half3 MainBumpMap620 = tex2DNode607;
				half3 Base_NormalTex1490 = UnpackScaleNormal( tex2D( _BumpMap3, temp_output_1485_0 ), _BumpScale3 );
				float3 lerpResult1502 = lerp( MainBumpMap620 , Base_NormalTex1490 , Mask_BaseBlend1491);
				float3 lerpResult2192 = lerp( lerpResult1502 , BlendNormals( MainBumpMap620 , Base_NormalTex1490 ) , _BaseBlendNormals);
				half3 Blending_BaseNormal1897 = lerpResult2192;
				#ifdef _ENABLEBASE_ON
				float3 staticSwitch2464 = Blending_BaseNormal1897;
				#else
				float3 staticSwitch2464 = MainBumpMap620;
				#endif
				half3 OUT_NORMAL1512 = staticSwitch2464;
				float3 ase_worldTangent = i.ase_texcoord3.xyz;
				float3 ase_worldNormal = i.ase_texcoord4.xyz;
				float3 ase_worldBitangent = i.ase_texcoord5.xyz;
				float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				float3 tanNormal14_g8665 = OUT_NORMAL1512;
				float3 worldNormal14_g8665 = float3(dot(tanToWorld0,tanNormal14_g8665), dot(tanToWorld1,tanNormal14_g8665), dot(tanToWorld2,tanNormal14_g8665));
				float3 ase_worldPos = i.ase_texcoord6.xyz;
				float3 worldSpaceLightDir = UnityWorldSpaceLightDir(ase_worldPos);
				float dotResult16_g8665 = dot( worldNormal14_g8665 , worldSpaceLightDir );
				float4 lerpResult3_g8665 = lerp( main33_g8665 , lerpResult20_g8665 , saturate( dotResult16_g8665 ));
				half4 Main_Color486 = _Color;
				half4 Base_Color1533 = _Color3;
				float4 lerpResult1536 = lerp( Main_Color486 , Base_Color1533 , Mask_BaseBlend1491);
				half4 Blending_BaseColor1898 = lerpResult1536;
				#ifdef _ENABLEBASE_ON
				float4 staticSwitch2462 = Blending_BaseColor1898;
				#else
				float4 staticSwitch2462 = Main_Color486;
				#endif
				half4 OUT_COLOR1539 = staticSwitch2462;
				float IS_BARK2885 = round( _IsBark );
				float4 appendResult2931 = (float4(( lerpResult3_g8665 * OUT_COLOR1539 * unity_ColorSpaceDouble ).rgb , IS_BARK2885));
				float OUTPUT_OPACITY_BARK2960 = IS_BARK2885;
				float4 appendResult2962 = (float4(appendResult2931.xyz , OUTPUT_OPACITY_BARK2960));
				float4 uv2557_g8660 = i.ase_texcoord7;
				uv2557_g8660.xy = i.ase_texcoord7.xy * float2( 1,1 ) + float2( 0,0 );
				float temp_output_17_0_g8663 = round( uv2557_g8660.w );
				float temp_output_18_0_g8663 = 3.0;
				half4 LEAF_MainTex2872 = tex2DNode18;
				float4 temp_output_15_0_g8630 = _Color;
				float4 temp_output_16_0_g8630 = _LeafColor2;
				float4 temp_output_2804_14 = ( ( temp_output_15_0_g8630 + temp_output_16_0_g8630 ) / 2.0 );
				half LEAF_Opacity2873 = tex2DNode18.a;
				float4 lerpResult2806 = lerp( temp_output_2804_14 , _NonLeafColor , LEAF_Opacity2873);
				half4 LEAF_Other_Color2878 = lerpResult2806;
				half4 LEAF_Color2877 = temp_output_2804_14;
				float3 hsvTorgb2837 = RGBToHSV( ( LEAF_MainTex2872 * LEAF_Color2877 * unity_ColorSpaceDouble ).rgb );
				float SATURATION2915 = _Saturation;
				float BRIGHTNESS2916 = _Brightness;
				float3 hsvTorgb2853 = HSVToRGB( float3(hsvTorgb2837.x,( hsvTorgb2837.y * SATURATION2915 ),( hsvTorgb2837.z * BRIGHTNESS2916 )) );
				half LEAF_MetallicGlossMap_B2875 = tex2DNode645.b;
				float4 lerpResult2856 = lerp( ( LEAF_MainTex2872 * LEAF_Other_Color2878 * unity_ColorSpaceDouble ) , float4( hsvTorgb2853 , 0.0 ) , ( LEAF_MetallicGlossMap_B2875 * 2.0 ));
				float4 temp_output_19_0_g8663 = lerpResult2856;
				float4 temp_output_20_0_g8663 = LEAF_MainTex2872;
				float temp_output_2934_0 = saturate( ( LEAF_Opacity2873 * 10.0 * ( 1.0 - IS_BARK2885 ) ) );
				float4 appendResult2929 = (float4(saturate( (( temp_output_17_0_g8663 == temp_output_18_0_g8663 ) ? temp_output_19_0_g8663 :  temp_output_20_0_g8663 ) ).rgb , temp_output_2934_0));
				float OUTPUT_OPACITY_LEAF2956 = temp_output_2934_0;
				float4 lerpResult2941 = lerp( appendResult2962 , appendResult2929 , OUTPUT_OPACITY_LEAF2956);
				
				float3 normalizeResult2598 = normalize( OUT_NORMAL1512 );
				float3 break17_g8664 = tex2DNode607;
				float switchResult12_g8664 = (((ase_vface>0)?(break17_g8664.z):(-break17_g8664.z)));
				float3 appendResult18_g8664 = (float3(break17_g8664.x , break17_g8664.y , switchResult12_g8664));
				half3 LEAF_BumpMap2871 = appendResult18_g8664;
				float3 lerpResult2943 = lerp( normalizeResult2598 , LEAF_BumpMap2871 , OUTPUT_OPACITY_LEAF2956);
				float3 normalizeResult2948 = normalize( lerpResult2943 );
				float3 tanNormal8_g8723 = normalizeResult2948;
				float3 worldNormal8_g8723 = float3(dot(tanToWorld0,tanNormal8_g8723), dot(tanToWorld1,tanNormal8_g8723), dot(tanToWorld2,tanNormal8_g8723));
				float eyeDepth = i.ase_texcoord1.z;
				float temp_output_4_0_g8723 = ( -1.0 / UNITY_MATRIX_P[2].z );
				float temp_output_7_0_g8723 = ( ( eyeDepth + temp_output_4_0_g8723 ) / temp_output_4_0_g8723 );
				float4 appendResult11_g8723 = (float4((worldNormal8_g8723*0.5 + 0.5) , temp_output_7_0_g8723));
				
				float temp_output_15_0_g8690 = Vertex_Occlusion1312;
				float temp_output_16_0_g8690 = OUT_AO2077;
				half Main_MetallicGlossMap_A744 = tex2DNode645.a;
				half Main_Smoothness660 = ( Main_MetallicGlossMap_A744 * _Glossiness );
				half Base_MetallicGlossMap_A2051 = tex2DNode2049.a;
				half Base_Smoothness748 = ( Base_MetallicGlossMap_A2051 * _Glossiness3 );
				float lerpResult2059 = lerp( Main_Smoothness660 , Base_Smoothness748 , Mask_BaseBlend1491);
				half Blending_BaseSmoothness2060 = lerpResult2059;
				#ifdef _ENABLEBASE_ON
				float staticSwitch2465 = Blending_BaseSmoothness2060;
				#else
				float staticSwitch2465 = Main_Smoothness660;
				#endif
				half OUT_SMOOTHNESS2071 = staticSwitch2465;
				float4 appendResult2898 = (float4(i.ase_color.r , ( ( temp_output_15_0_g8690 + temp_output_16_0_g8690 ) / 2.0 ) , 0.0 , OUT_SMOOTHNESS2071));
				half LEAF_MetallicGlossMap_G2874 = tex2DNode645.g;
				float lerpResult2812 = lerp( 1.0 , LEAF_MetallicGlossMap_G2874 , _Occlusion);
				half LEAF_Occlusion2880 = lerpResult2812;
				half LEAF_Vertex_Occlusion2881 = lerpResult1308;
				half LEAF_MetallicGlossMap_A2876 = tex2DNode645.a;
				half LEAF_SMOOTHNESS2879 = ( LEAF_MetallicGlossMap_A2876 * _Glossiness );
				float4 appendResult2945 = (float4(i.ase_color.r , ( LEAF_Occlusion2880 * LEAF_Vertex_Occlusion2881 ) , 0.0 , LEAF_SMOOTHNESS2879));
				float4 lerpResult2944 = lerp( appendResult2898 , appendResult2945 , OUTPUT_OPACITY_LEAF2956);
				

				outGBuffer0 = lerpResult2941;
				outGBuffer1 = appendResult11_g8723;
				outGBuffer2 = lerpResult2944;
				outGBuffer3 = 0;
				outGBuffer4 = 0;
				outGBuffer5 = 0;
				outGBuffer6 = 0;
				outGBuffer7 = 0;
				float alpha = ( OUTPUT_OPACITY_LEAF2956 - 0.25 );
				clip( alpha );
				outDepth = i.pos.z;
			}
			ENDCG
		}
	}
	
	CustomEditor "ASEMaterialInspector"
	
}
/*ASEBEGIN
Version=17500
118.4;-782.4;1268;647;-3826.736;4157.095;1;True;False
Node;AmplifyShaderEditor.Vector4Node;563;-2048,-1888;Half;False;Property;_UVZero;Trunk UVs;11;0;Create;False;0;0;False;1;Space(10);1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;561;-2048,-2048;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;564;-1792,-1888;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;565;-1792,-1808;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;562;-1600,-2048;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;1480;-2051.614,-32;Half;False;Property;_UVZero3;Base UVs;33;0;Create;False;0;0;False;1;Space(10);1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;1482;-1795.613,-32;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;575;-1392,-2048;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1481;-2051.614,-256;Inherit;False;3;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1484;-1603.613,-256;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1483;-1795.613,48;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;587;-1179,-2045;Half;False;Main_UVs;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;644;130.7473,-898.5554;Inherit;False;587;Main_UVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1485;-1395.613,-256;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;2049;-1155.614,128;Inherit;True;Property;_MetallicGlossMap3;Base Surface;30;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;3d71e135301ead648aa518fbd4034569;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;2237;-259.6134,-256;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;645;386.7473,-898.5554;Inherit;True;Property;_MetallicGlossMap;Surface;7;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;f21aa9ff13365794d8fe8e5ab752ed99;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2238;-339.6134,-96;Half;False;Property;_BaseBlendHeight;Base Blend Height;34;0;Create;True;0;0;False;1;;0.1;3;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;588;-2048,-1280;Inherit;False;587;Main_UVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2229;-803.6133,176;Half;False;Base_MetallicGlossMap_B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1929;700.7508,-581.3958;Half;False;Main_MetallicGlossMap_B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;2240;12.38663,-256;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2226;-131.6134,719.9999;Float;False;Property;_BaseHeightRange;Base Height Range;40;0;Create;True;0;0;False;0;0.9;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2223;-131.6134,464;Float;False;Property;_BaseBlendHeightContrast;Base Blend Height Contrast;38;0;Create;True;0;0;False;0;0.5;0.766;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2230;-131.6134,384;Inherit;False;2229;Base_MetallicGlossMap_B;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2224;-131.6134,559.9999;Float;False;Property;_TrunkHeightRange;Trunk Height Range;37;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2227;-131.6134,799.9999;Float;False;Property;_BaseHeightOffset;Base Height Offset;39;0;Create;True;0;0;False;0;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2231;-131.6134,304;Inherit;False;1929;Main_MetallicGlossMap_B;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2225;-131.6134,639.9999;Float;False;Property;_TrunkHeightOffset;Trunk Height Offset;36;0;Create;True;0;0;False;0;0;0.33;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;18;-1792,-1281;Inherit;True;Property;_MainTex;Bark Albedo;2;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;5f79b2d209181ac4caf48353216276d5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;2241;220.3866,-256;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2216;-976,-1040;Inherit;False;Property;_Brightness;Brightness;4;0;Create;True;0;0;False;0;1;1;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1788;700.7508,-661.396;Half;False;Main_MetallicGlossMap_G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;2213;-928,-1280;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;655;92.39239,-1218.155;Half;False;Property;_BumpScale;Normal Scale;5;0;Create;False;0;0;False;0;1;4.75;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1426;352.8716,29.55515;Half;False;Property;_BaseBlendAmount;Base Blend Amount;35;0;Create;True;0;0;False;1;;0.1;1;0.0001;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2215;-976,-1136;Inherit;False;Property;_Saturation;Saturation;3;0;Create;True;0;0;False;0;1;1;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1488;-1539.613,0;Half;False;Property;_BumpScale3;Base Normal Scale;28;0;Create;False;0;0;False;0;1;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;604;131.3924,-1346.155;Inherit;False;587;Main_UVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2050;-794.6133,107;Half;False;Base_MetallicGlossMap_G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;2242;380.3866,-256;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2222;367.8406,283.4037;Inherit;False;Height Blend;-1;;3760;f050d451a30c809489d59339735fb04d;0;7;3;FLOAT;0.5;False;1;FLOAT;0;False;19;FLOAT;1;False;13;FLOAT;0;False;21;FLOAT;0;False;24;FLOAT;1;False;22;FLOAT;0;False;2;FLOAT;61;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1792;-1152,1328;Half;False;Property;_Occlusion;Occlusion;12;0;Create;False;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2053;-256,1248;Inherit;False;2050;Base_MetallicGlossMap_G;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2217;-656,-1056;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2052;-256,1344;Half;False;Property;_Occlusion3;Base Occlusion;32;0;Create;False;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2584;-1155.614,1152;Inherit;False;const;-1;;3773;5b64729fb717c5f49a1bc2dab81d5e1c;4,21,0,3,1,22,0,28,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2232;860.3868,0;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;409;-1793.3,-997.9;Half;False;Property;_Color;Color;1;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2214;-656,-1168;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2585;-259.6134,1152;Inherit;False;const;-1;;3774;5b64729fb717c5f49a1bc2dab81d5e1c;4,21,0,3,1,22,0,28,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;607;403.3923,-1346.155;Inherit;True;Property;_BumpMap;Bark Normal;6;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;3130d1036d33deb49b9376334bbd026a;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;2774;-1792,-768;Half;False;Property;_LeafColor2;Leaf Color 2;13;0;Create;True;0;0;False;0;1,1,1,1;0.6698484,0.6981132,0.3589355,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1486;-1155.614,-64;Inherit;True;Property;_BumpMap3;Base Normal;29;2;[NoScaleOffset];[Normal];Create;False;0;0;False;0;-1;None;f99f6fdd4b6609e4889aada8f34a067e;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1795;-1152,1248;Inherit;False;1788;Main_MetallicGlossMap_G;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1415;-1155.614,-256;Inherit;True;Property;_MainTex3;Base Albedo;27;1;[NoScaleOffset];Create;False;0;0;False;0;-1;None;395f3dc081ab76248854e859729ee5bb;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.HSVToRGBNode;2218;-480,-1280;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;1793;-771.6133,1152;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1491;1020.387,0;Half;False;Mask_BaseBlend;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2804;-1373.5,-789.2;Inherit;False;Average;-1;;8630;3cc639c87d4059642bd54021d04a32cc;2,5,0,4,0;9;15;COLOR;0,0,0,0;False;16;COLOR;0,0,0,0;False;17;FLOAT;0;False;18;FLOAT;0;False;19;FLOAT;0;False;20;FLOAT;0;False;21;FLOAT;0;False;22;FLOAT;0;False;23;FLOAT;0;False;1;COLOR;14
Node;AmplifyShaderEditor.RegisterLocalVarNode;620;771.3925,-1346.155;Half;False;MainBumpMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1490;-835.6133,-64;Half;False;Base_NormalTex;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;2055;124.3866,1152;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2877;-1134.136,-892.0419;Half;False;LEAF_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;-224,-1280;Half;False;Main_MainTex;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2873;-1348.509,-944.9429;Half;False;LEAF_Opacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1465;5280.142,-4174.509;Inherit;False;606.4664;256.6625;Drawers;4;2885;2638;862;2888;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2051;-828.6133,266;Half;False;Base_MetallicGlossMap_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2872;-1301.509,-1051.943;Half;False;LEAF_MainTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1499;1665.265,1251.477;Inherit;False;1491;Mask_BaseBlend;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2056;316.3866,1152;Half;False;Base_Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1508;1665.265,563.4775;Inherit;False;1490;Base_NormalTex;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1489;-835.6133,-256;Half;False;Base_MainTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1503;1665.265,499.4775;Inherit;False;620;MainBumpMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1794;-579.6133,1152;Half;False;Main_Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1532;-2051.614,384;Half;False;Property;_Color3;Base Color;26;0;Create;False;0;0;False;0;1,1,1,1;0.7420651,0.7830188,0.350881,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;744;700.7508,-501.3959;Half;False;Main_MetallicGlossMap_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;749;1154.747,-898.5554;Inherit;False;744;Main_MetallicGlossMap_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;656;-1411.613,384;Inherit;False;2051;Base_MetallicGlossMap_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2638;5310.626,-4115.542;Half;False;Property;_IsBark;Is Bark;46;2;[HideInInspector];[Toggle];Create;True;2;Off;0;On;1;0;True;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2803;-1429,-536;Inherit;False;2873;LEAF_Opacity;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2833;-773.7195,-4035.06;Inherit;False;2877;LEAF_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2834;-768.7957,-4123.41;Inherit;False;2872;LEAF_MainTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorSpaceDouble;2835;-745.9177,-3874.767;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;750;-1411.613,464;Half;False;Property;_Glossiness3;Base Smoothness;31;0;Create;False;0;0;False;0;0.1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;294;1154.747,-818.5554;Half;False;Property;_Glossiness;Smoothness;8;0;Create;False;0;0;False;0;0.1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2796;-1792,-560;Half;False;Property;_NonLeafColor;Non-Leaf Color;16;0;Create;True;0;0;False;0;1,1,1,1;0.706,0.6903853,0.65658,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;2061;1665.265,1139.478;Inherit;False;2056;Base_Occlusion;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1502;2113.265,515.4775;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;-1313,-1156;Half;False;Main_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2193;2065.264,755.4774;Half;False;Property;_BaseBlendNormals;Base Blend Normals;41;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1497;1665.265,371.4776;Inherit;False;1489;Base_MainTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2062;1665.265,1075.478;Inherit;False;1794;Main_Occlusion;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1533;-1731.613,384;Half;False;Base_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1496;1665.265,307.4776;Inherit;False;487;Main_MainTex;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BlendNormalsNode;2190;2097.265,643.4774;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;2065;2113.265,1075.478;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;745;1474.747,-914.5554;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RoundOpNode;2888;5505.482,-4008.37;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2915;-608.7397,-946.6213;Inherit;False;SATURATION;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2916;-621.7397,-853.6213;Inherit;False;BRIGHTNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2836;-429.5019,-4078.506;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;2192;2305.265,515.4775;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1535;1665.265,195.4775;Inherit;False;1533;Base_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;657;-1091.613,384;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2806;-1136,-784;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1534;1665.265,131.4775;Inherit;False;486;Main_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;1495;2113.265,307.4776;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2919;-266.0555,-3648.387;Inherit;False;2916;BRIGHTNESS;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2875;726.7264,-851.4326;Half;False;LEAF_MetallicGlossMap_B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2878;-928,-784;Half;False;LEAF_Other_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2885;5633.482,-4008.37;Inherit;False;IS_BARK;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RGBToHSVNode;2837;-239.6777,-3972.323;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;1897;2449.266,515.4775;Half;False;Blending_BaseNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;660;1666.747,-914.5554;Half;False;Main_Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1536;2113.265,131.4775;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;748;-899.6133,384;Half;False;Base_Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2918;-246.9267,-3747.489;Inherit;False;2915;SATURATION;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1896;2449.266,307.4776;Half;False;Blending_BaseAlbedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2064;2417.266,1075.478;Half;False;Blending_BaseOcclusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorSpaceDouble;2846;-54.48689,-4152.049;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;2057;1665.265,963.4774;Inherit;False;748;Base_Smoothness;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2847;64.62907,-4325.428;Inherit;False;2872;LEAF_MainTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2840;92.74211,-3722.397;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2841;-45.55891,-4254.526;Inherit;False;2878;LEAF_Other_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2848;368.727,-3502.128;Inherit;False;const;-1;;8653;5b64729fb717c5f49a1bc2dab81d5e1c;4,21,0,3,6,22,0,28,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2953;2700,-3049;Inherit;False;2885;IS_BARK;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2844;98.08806,-3814.796;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2842;195.9965,-3873.324;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1309;-2048,1440;Half;False;Property;_VertexOcclusion;Vertex Occlusion;15;0;Create;True;0;0;False;0;0.5;0.6;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2170;2945.265,899.4775;Inherit;False;1794;Main_Occlusion;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1638;-2048,1248;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;2159;2945.265,403.4776;Inherit;False;1896;Blending_BaseAlbedo;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1898;2449.266,131.4775;Half;False;Blending_BaseColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2178;2945.265,515.4775;Inherit;False;620;MainBumpMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2153;2945.265,979.4774;Inherit;False;2064;Blending_BaseOcclusion;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2058;1665.265,899.4775;Inherit;False;660;Main_Smoothness;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2845;174.727,-3598.128;Inherit;False;2875;LEAF_MetallicGlossMap_B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2163;2945.265,323.4776;Inherit;False;487;Main_MainTex;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;2586;-2051.614,1152;Inherit;False;const;-1;;8654;5b64729fb717c5f49a1bc2dab81d5e1c;4,21,0,3,1,22,0,28,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2171;2945.265,595.4775;Inherit;False;1897;Blending_BaseNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.HSVToRGBNode;2853;266.9235,-3810.974;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2852;409.4232,-4039.024;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2874;727.7264,-929.4329;Half;False;LEAF_MetallicGlossMap_G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2849;508.5358,-3635.589;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2827;2736,-3232;Inherit;False;2873;LEAF_Opacity;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1308;-1667.613,1152;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;2954;2915.571,-3067.413;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;2463;3280.708,351.4651;Float;False;Property;_ENABLEBASE5;Enable Base;23;0;Create;False;0;0;False;0;0;0;0;True;;Toggle;2;Off;Base;Reference;2462;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2154;2945.265,211.4775;Inherit;False;1898;Blending_BaseColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;2059;2113.265,899.4775;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2935;2752,-3136;Inherit;False;Constant;_Float9;Float 9;47;0;Create;True;0;0;False;0;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2168;2945.265,131.4775;Inherit;False;486;Main_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;2466;3342.044,926.4568;Float;False;Property;_ENABLEBASE8;Enable Base;19;0;Create;False;0;0;False;0;0;0;0;True;;Toggle;2;Off;Base;Reference;2462;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;2464;3280.708,511.4651;Float;False;Property;_ENABLEBASE6;Enable Base;22;0;Create;False;0;0;False;0;0;0;0;True;;Toggle;2;Off;Base;Reference;2462;True;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2933;3205.382,-3233.689;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2859;2022.694,-3557.635;Inherit;False;Tree Component ID;-1;;8659;5271313988492174092a46e3f289ae62;1,4,3;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2808;-1152.895,1421.644;Inherit;False;const;-1;;8658;5b64729fb717c5f49a1bc2dab81d5e1c;4,21,0,3,1,22,0,28,0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1312;-1475.613,1152;Half;False;Vertex_Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2060;2417.266,899.4775;Half;False;Blending_BaseSmoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1501;3585.264,323.4776;Half;False;OUT_ALBEDO;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2807;-1208.895,1519.644;Inherit;False;2874;LEAF_MetallicGlossMap_G;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;2462;3289.661,134.2091;Float;False;Property;_ENABLEBASE;Enable Base;24;0;Create;False;0;0;False;0;0;0;1;True;;Toggle;2;Off;Base;Create;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2858;2027.239,-3363.071;Inherit;False;2872;LEAF_MainTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;2856;886.8738,-3815.667;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2876;726.7264,-755.4326;Half;False;LEAF_MetallicGlossMap_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2077;3585.264,899.4775;Half;False;OUT_AO;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2857;1850.973,-3694.821;Inherit;False;Mesh Values (Tree) (Complex) (UV3);-1;;8660;8e1e1d817f2a77d4ea50f9fe634408b6;0;0;2;FLOAT3;500;FLOAT;549
Node;AmplifyShaderEditor.RegisterLocalVarNode;1512;3585.264,515.4775;Half;False;OUT_NORMAL;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1313;-393.6476,-5122.113;Inherit;False;1312;Vertex_Occlusion;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2934;3372.271,-3481.22;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2107;-393.6476,-5314.113;Inherit;False;2077;OUT_AO;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2812;-832.8955,1421.644;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2818;1140.221,-727.1061;Inherit;False;2876;LEAF_MetallicGlossMap_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2861;2345.741,-3490.034;Inherit;False;Multi Comparison;-1;;8663;8cbe358a30145e843bfece526f25c2c8;1,4,1;4;17;FLOAT;0;False;18;FLOAT;0;False;19;COLOR;0,0,0,0;False;20;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2179;2945.265,707.4774;Inherit;False;660;Main_Smoothness;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2162;2888.265,801.4774;Inherit;False;2060;Blending_BaseSmoothness;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2535;-393.6476,-5506.113;Inherit;False;Property;_OcclusionColor;Occlusion Color;18;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;2814;784.004,-1234.623;Inherit;False;Normal BackFace;-1;;8664;121446c878db06f4c847f9c5afed7cfe;0;1;13;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2452;-393.6476,-5026.113;Half;False;Property;_VertexOcclusionDarkening;Vertex Occlusion Darkening;17;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1539;3585.264,131.4775;Half;False;OUT_COLOR;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2549;-393.6476,-5602.113;Inherit;False;1512;OUT_NORMAL;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2570;-393.6476,-5698.113;Inherit;False;1501;OUT_ALBEDO;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;2457;-393.6476,-5218.113;Half;False;Property;_TextureOcclusionDarkening;Texture Occlusion Darkening;14;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2636;74.3465,-5433.454;Inherit;False;Simulate Depth;-1;;8665;b59c4a4c8e1cd4948894fc73b8ee23fa;0;7;32;COLOR;0,0,0,0;False;36;FLOAT3;0,0,0;False;31;COLOR;0,0,0,0;False;28;FLOAT;0;False;25;FLOAT;0;False;27;FLOAT;0;False;26;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorSpaceDouble;2640;363.7426,-5148.738;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;2448;451.3525,-5250.113;Inherit;False;1539;OUT_COLOR;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2880;-589.2953,1421.344;Half;False;LEAF_Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2865;2683.336,-3493.784;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;624;1898.742,-4905.965;Inherit;False;1512;OUT_NORMAL;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2815;1455.221,-715.1061;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2871;1060.204,-1240.922;Half;False;LEAF_BumpMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;2465;3264.708,719.465;Float;False;Property;_ENABLEBASE7;Enable Base;25;0;Create;False;0;0;False;0;0;0;0;True;;Toggle;2;Off;Base;Reference;2462;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2955;1452.174,-4817.969;Inherit;False;2885;IS_BARK;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2956;3571.475,-3482.183;Inherit;False;OUTPUT_OPACITY_LEAF;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2881;-1486.895,1247.644;Half;False;LEAF_Vertex_Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2958;3983.061,-4096.12;Inherit;False;2956;OUTPUT_OPACITY_LEAF;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2822;3281.053,-3042.798;Inherit;False;2871;LEAF_BumpMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2071;3585.264,707.4774;Half;False;OUT_SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2497;1869.956,-4522.728;Inherit;False;1312;Vertex_Occlusion;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2879;1647.221,-715.1061;Half;False;LEAF_SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2960;1675.54,-4820.6;Inherit;False;OUTPUT_OPACITY_BARK;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;2598;2156.909,-4910.366;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2824;2666.954,-2529.264;Inherit;False;2881;LEAF_Vertex_Occlusion;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2823;2802.425,-2627.431;Inherit;False;2880;LEAF_Occlusion;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2496;1904.456,-4421.126;Inherit;False;2077;OUT_AO;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2451;822.8914,-5242.779;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;2929;3558.435,-3388.789;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;2965;3903.787,-3472.894;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;2590;2212.606,-4500.05;Inherit;False;Average;-1;;8690;3cc639c87d4059642bd54021d04a32cc;2,5,0,4,0;9;15;FLOAT;0;False;16;FLOAT;0;False;17;FLOAT;0;False;18;FLOAT;0;False;19;FLOAT;0;False;20;FLOAT;0;False;21;FLOAT;0;False;22;FLOAT;0;False;23;FLOAT;0;False;1;FLOAT;14
Node;AmplifyShaderEditor.LerpOp;2943;4344.269,-4106.337;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;2930;1835.9,-4301.452;Inherit;False;Mesh Values (Tree) (Complex) (Vertex Colors);-1;;8691;9cacaefc2ecfddf4c8e070f9be99b854;0;0;4;FLOAT;495;FLOAT;501;FLOAT;550;FLOAT;552
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2825;3027.312,-2559.38;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;654;1857.157,-4618.948;Inherit;False;2071;OUT_SMOOTHNESS;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2946;2638.73,-2903.562;Inherit;False;Mesh Values (Tree) (Complex) (Vertex Colors);-1;;8692;9cacaefc2ecfddf4c8e070f9be99b854;0;0;4;FLOAT;495;FLOAT;501;FLOAT;550;FLOAT;552
Node;AmplifyShaderEditor.GetLocalVarNode;2961;3752.766,-4668.146;Inherit;False;2960;OUTPUT_OPACITY_BARK;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2821;2817.887,-2730.37;Inherit;False;2879;LEAF_SMOOTHNESS;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;2931;1701.69,-5092.075;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;2898;2430.342,-4603.58;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;2962;4166.032,-4701.566;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;2945;3197.162,-2709.705;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;2963;3801.058,-4278.654;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;2957;4034.218,-4276.973;Inherit;False;2956;OUTPUT_OPACITY_LEAF;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2947;4291.385,-3586.355;Inherit;False;Constant;_Float0;Float 0;47;0;Create;True;0;0;False;0;0.25;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2959;3807.061,-3821.12;Inherit;False;2956;OUTPUT_OPACITY_LEAF;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;2948;4515.876,-4107.855;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;2854;944.9263,-4028.442;Half;False;Property;_NonLeafFadeColor;Non-Leaf Fade Color;20;0;Create;True;0;0;False;0;0.3773585,0.3773585,0.3773585,1;0.3773584,0.3773584,0.3773584,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;2924;1430.05,-4395.011;Inherit;False;BACKSHADE_CONTRAST;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2843;622.7269,-3534.128;Inherit;False;2875;LEAF_MetallicGlossMap_B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2944;4458.744,-3887.371;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2855;1209.283,-3538.184;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2869;1057.708,-3563.875;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2860;1431.211,-3609.9;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2968;4522.862,-3720.115;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2923;1430.05,-4491.011;Inherit;False;BACKSHADE_POWER;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2850;750.7269,-3437.128;Inherit;False;Property;_NonLeafFadeStrength;Non-Leaf Fade Strength;21;0;Create;True;0;0;False;0;0.1;0.35;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2941;4436.308,-4360.627;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.OneMinusNode;2851;910.7268,-3534.128;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2966;4661.331,-4132.983;Inherit;False;Pack Normal Depth;-1;;8723;8e386dbec347c9f44befea8ff816d188;0;1;12;FLOAT3;0,0,0;False;3;FLOAT4;0;FLOAT3;14;FLOAT;15
Node;AmplifyShaderEditor.FunctionNode;2870;217.0932,-3316.969;Inherit;False;Mesh Values (Tree) (Complex) (Vertex Colors);-1;;8722;9cacaefc2ecfddf4c8e070f9be99b854;0;0;4;FLOAT;495;FLOAT;501;FLOAT;550;FLOAT;552
Node;AmplifyShaderEditor.ColorNode;2951;3865.825,-4891.269;Inherit;False;Constant;_Color9;Color 9;47;0;Create;True;0;0;False;0;0.02666664,0,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;2618;1128.516,-5110.329;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;2952;3951.636,-4467.33;Inherit;False;Constant;_Color10;Color 9;47;0;Create;True;0;0;False;0;1,0,0,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;2641;432.3745,-4790.629;Inherit;False;Mesh Values (Tree) (Complex) (Vertex Colors);-1;;8717;9cacaefc2ecfddf4c8e070f9be99b854;0;0;4;FLOAT;495;FLOAT;501;FLOAT;550;FLOAT;552
Node;AmplifyShaderEditor.RangedFloatNode;2620;1008.948,-4583.06;Inherit;False;Property;_BackshadingPower;Backshading Power;44;0;Create;True;0;0;False;0;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2868;586.7079,-3547.875;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2928;2457.469,-3671.443;Inherit;False;2923;BACKSHADE_POWER;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2927;2480.469,-3583.443;Inherit;False;2924;BACKSHADE_CONTRAST;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2612;984.7487,-4977.45;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2922;1430.05,-4587.011;Inherit;False;BACKSHADE_BIAS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2622;1045.671,-4846.871;Inherit;False;Property;_Backshade;Backshade;42;0;Create;True;0;0;False;0;0.4528302,0.4528302,0.4528302,1;0.226415,0.226415,0.226415,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;2921;1430.05,-4683.011;Inherit;False;BACKSHADE;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;2925;2505.469,-3833.443;Inherit;False;2921;BACKSHADE;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;2867;3018.8,-3476.607;Inherit;False;Backshade;-1;;8724;ef1e6c9fe3ccd0a469022ea4da76c89a;0;5;25;FLOAT3;0,0,0;False;28;COLOR;0,0,0,0;False;20;FLOAT;0;False;21;FLOAT;0;False;22;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;2608;630.3524,-5090.113;Half;False;Property;_TrunkFadeColor;Trunk Fade Color;9;0;Create;True;0;0;False;0;1,1,1,1;0.6603774,0.6603774,0.6603774,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;2624;1407.262,-5037.441;Inherit;False;Backshade;-1;;8732;ef1e6c9fe3ccd0a469022ea4da76c89a;0;5;25;FLOAT3;0,0,0;False;28;COLOR;0,0,0,0;False;20;FLOAT;0;False;21;FLOAT;0;False;22;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2623;1018.203,-4506.732;Inherit;False;Property;_BackshadingContrast;Backshading Contrast;45;0;Create;True;0;0;False;0;1;1;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2926;2476.469,-3747.443;Inherit;False;2922;BACKSHADE_BIAS;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2820;4670.974,-3525.209;Inherit;False;Pivot Billboard;-1;;8718;50ed44a1d0e6ecb498e997b8969f8558;3,433,2,432,2,431,2;0;3;FLOAT3;370;FLOAT3;369;FLOAT4;371
Node;AmplifyShaderEditor.RangedFloatNode;2621;994.6508,-4667.531;Inherit;False;Property;_BackshadingBias;Backshading Bias;43;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;862;5470.626,-4115.542;Half;False;Property;_Cutoff;_cutoff;0;1;[HideInInspector];Create;False;3;Off;0;Front;1;Back;2;0;False;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2613;565.3524,-4898.113;Inherit;False;Property;_TrunkFadeStrength;Trunk Fade Strength;10;0;Create;True;0;0;False;0;0;0.748;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2642;5017.625,-4181.766;Float;False;True;-1;2;ASEMaterialInspector;100;9;appalachia/impostors/tree-bake;f53051a8190f7044fa936bd7fbe116c1;True;Unlit;0;0;Unlit;10;False;False;False;True;2;False;-1;False;False;False;False;False;True;1;RenderType=Opaque=RenderType;True;4;0;False;False;False;False;False;False;False;False;False;False;False;0;;0;0;Standard;0;0;1;True;False;;0
Node;AmplifyShaderEditor.CommentaryNode;760;-2048,-1472;Inherit;False;2046.548;120.5201;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1544;-2051.614,1024;Inherit;False;2559.027;100;Ambient Occlusion;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;715;130.7473,-1026.555;Inherit;False;872;100;Smoothness Texture(Metallic, AO, Height, Smoothness);0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;712;-2048,-2240;Inherit;False;1077.027;100;Main UVs;0;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;708;131.3924,-1474.155;Inherit;False;833.139;100;Normal Texture;0;;0.5019608,0.5019608,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;2188;2945.265,3.477521;Inherit;False;1048.21;100;Trunk Base Blending Final;0;;1,0,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;751;1154.747,-1026.555;Inherit;False;761.9668;100;Metallic / Smoothness;0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;2189;1665.265,3.477521;Inherit;False;1027.098;100;Trunk Base Blending ;0;;1,0,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1545;-2051.614,-384;Inherit;False;1541.176;100;Base Blend Inputs;0;;1,0.234,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1546;-387.6134,-384;Inherit;False;1880.808;100;Blend Height Mask;0;;1,0.234,0,1;0;0
WireConnection;564;0;563;1
WireConnection;564;1;563;2
WireConnection;565;0;563;3
WireConnection;565;1;563;4
WireConnection;562;0;561;0
WireConnection;562;1;564;0
WireConnection;1482;0;1480;1
WireConnection;1482;1;1480;2
WireConnection;575;0;562;0
WireConnection;575;1;565;0
WireConnection;1484;0;1481;0
WireConnection;1484;1;1482;0
WireConnection;1483;0;1480;3
WireConnection;1483;1;1480;4
WireConnection;587;0;575;0
WireConnection;1485;0;1484;0
WireConnection;1485;1;1483;0
WireConnection;2049;1;1485;0
WireConnection;645;1;644;0
WireConnection;2229;0;2049;3
WireConnection;1929;0;645;3
WireConnection;2240;0;2237;2
WireConnection;2240;2;2238;0
WireConnection;18;1;588;0
WireConnection;2241;0;2240;0
WireConnection;1788;0;645;2
WireConnection;2213;0;18;0
WireConnection;2050;0;2049;2
WireConnection;2242;0;2241;0
WireConnection;2222;3;2223;0
WireConnection;2222;1;2231;0
WireConnection;2222;19;2224;0
WireConnection;2222;13;2225;0
WireConnection;2222;21;2230;0
WireConnection;2222;24;2226;0
WireConnection;2222;22;2227;0
WireConnection;2217;0;2213;3
WireConnection;2217;1;2216;0
WireConnection;2232;0;2242;0
WireConnection;2232;1;1426;0
WireConnection;2232;2;2222;0
WireConnection;2214;0;2213;2
WireConnection;2214;1;2215;0
WireConnection;607;1;604;0
WireConnection;607;5;655;0
WireConnection;1486;1;1485;0
WireConnection;1486;5;1488;0
WireConnection;1415;1;1485;0
WireConnection;2218;0;2213;1
WireConnection;2218;1;2214;0
WireConnection;2218;2;2217;0
WireConnection;1793;0;2584;0
WireConnection;1793;1;1795;0
WireConnection;1793;2;1792;0
WireConnection;1491;0;2232;0
WireConnection;2804;15;409;0
WireConnection;2804;16;2774;0
WireConnection;620;0;607;0
WireConnection;1490;0;1486;0
WireConnection;2055;0;2585;0
WireConnection;2055;1;2053;0
WireConnection;2055;2;2052;0
WireConnection;2877;0;2804;14
WireConnection;487;0;2218;0
WireConnection;2873;0;18;4
WireConnection;2051;0;2049;4
WireConnection;2872;0;18;0
WireConnection;2056;0;2055;0
WireConnection;1489;0;1415;0
WireConnection;1794;0;1793;0
WireConnection;744;0;645;4
WireConnection;1502;0;1503;0
WireConnection;1502;1;1508;0
WireConnection;1502;2;1499;0
WireConnection;486;0;409;0
WireConnection;1533;0;1532;0
WireConnection;2190;0;1503;0
WireConnection;2190;1;1508;0
WireConnection;2065;0;2062;0
WireConnection;2065;1;2061;0
WireConnection;2065;2;1499;0
WireConnection;745;0;749;0
WireConnection;745;1;294;0
WireConnection;2888;0;2638;0
WireConnection;2915;0;2215;0
WireConnection;2916;0;2216;0
WireConnection;2836;0;2834;0
WireConnection;2836;1;2833;0
WireConnection;2836;2;2835;0
WireConnection;2192;0;1502;0
WireConnection;2192;1;2190;0
WireConnection;2192;2;2193;0
WireConnection;657;0;656;0
WireConnection;657;1;750;0
WireConnection;2806;0;2804;14
WireConnection;2806;1;2796;0
WireConnection;2806;2;2803;0
WireConnection;1495;0;1496;0
WireConnection;1495;1;1497;0
WireConnection;1495;2;1499;0
WireConnection;2875;0;645;3
WireConnection;2878;0;2806;0
WireConnection;2885;0;2888;0
WireConnection;2837;0;2836;0
WireConnection;1897;0;2192;0
WireConnection;660;0;745;0
WireConnection;1536;0;1534;0
WireConnection;1536;1;1535;0
WireConnection;1536;2;1499;0
WireConnection;748;0;657;0
WireConnection;1896;0;1495;0
WireConnection;2064;0;2065;0
WireConnection;2840;0;2837;3
WireConnection;2840;1;2919;0
WireConnection;2844;0;2837;2
WireConnection;2844;1;2918;0
WireConnection;2842;0;2837;1
WireConnection;1898;0;1536;0
WireConnection;2853;0;2842;0
WireConnection;2853;1;2844;0
WireConnection;2853;2;2840;0
WireConnection;2852;0;2847;0
WireConnection;2852;1;2841;0
WireConnection;2852;2;2846;0
WireConnection;2874;0;645;2
WireConnection;2849;0;2845;0
WireConnection;2849;1;2848;0
WireConnection;1308;0;2586;0
WireConnection;1308;1;1638;3
WireConnection;1308;2;1309;0
WireConnection;2954;0;2953;0
WireConnection;2463;1;2163;0
WireConnection;2463;0;2159;0
WireConnection;2059;0;2058;0
WireConnection;2059;1;2057;0
WireConnection;2059;2;1499;0
WireConnection;2466;1;2170;0
WireConnection;2466;0;2153;0
WireConnection;2464;1;2178;0
WireConnection;2464;0;2171;0
WireConnection;2933;0;2827;0
WireConnection;2933;1;2935;0
WireConnection;2933;2;2954;0
WireConnection;1312;0;1308;0
WireConnection;2060;0;2059;0
WireConnection;1501;0;2463;0
WireConnection;2462;1;2168;0
WireConnection;2462;0;2154;0
WireConnection;2856;0;2852;0
WireConnection;2856;1;2853;0
WireConnection;2856;2;2849;0
WireConnection;2876;0;645;4
WireConnection;2077;0;2466;0
WireConnection;1512;0;2464;0
WireConnection;2934;0;2933;0
WireConnection;2812;0;2808;0
WireConnection;2812;1;2807;0
WireConnection;2812;2;1792;0
WireConnection;2861;17;2857;549
WireConnection;2861;18;2859;0
WireConnection;2861;19;2856;0
WireConnection;2861;20;2858;0
WireConnection;2814;13;607;0
WireConnection;1539;0;2462;0
WireConnection;2636;32;2570;0
WireConnection;2636;36;2549;0
WireConnection;2636;31;2535;0
WireConnection;2636;28;2107;0
WireConnection;2636;25;2457;0
WireConnection;2636;27;1313;0
WireConnection;2636;26;2452;0
WireConnection;2880;0;2812;0
WireConnection;2865;0;2861;0
WireConnection;2815;0;2818;0
WireConnection;2815;1;294;0
WireConnection;2871;0;2814;0
WireConnection;2465;1;2179;0
WireConnection;2465;0;2162;0
WireConnection;2956;0;2934;0
WireConnection;2881;0;1308;0
WireConnection;2071;0;2465;0
WireConnection;2879;0;2815;0
WireConnection;2960;0;2955;0
WireConnection;2598;0;624;0
WireConnection;2451;0;2636;0
WireConnection;2451;1;2448;0
WireConnection;2451;2;2640;0
WireConnection;2929;0;2865;0
WireConnection;2929;3;2934;0
WireConnection;2965;0;2929;0
WireConnection;2590;15;2497;0
WireConnection;2590;16;2496;0
WireConnection;2943;0;2598;0
WireConnection;2943;1;2822;0
WireConnection;2943;2;2958;0
WireConnection;2825;0;2823;0
WireConnection;2825;1;2824;0
WireConnection;2931;0;2451;0
WireConnection;2931;3;2955;0
WireConnection;2898;0;2930;495
WireConnection;2898;1;2590;14
WireConnection;2898;3;654;0
WireConnection;2962;0;2931;0
WireConnection;2962;3;2961;0
WireConnection;2945;0;2946;495
WireConnection;2945;1;2825;0
WireConnection;2945;3;2821;0
WireConnection;2963;0;2965;0
WireConnection;2948;0;2943;0
WireConnection;2924;0;2623;0
WireConnection;2944;0;2898;0
WireConnection;2944;1;2945;0
WireConnection;2944;2;2959;0
WireConnection;2855;0;2869;0
WireConnection;2855;1;2851;0
WireConnection;2855;2;2850;0
WireConnection;2869;0;2868;0
WireConnection;2860;1;2854;0
WireConnection;2860;2;2855;0
WireConnection;2968;0;2959;0
WireConnection;2968;1;2947;0
WireConnection;2923;0;2620;0
WireConnection;2941;0;2962;0
WireConnection;2941;1;2963;0
WireConnection;2941;2;2957;0
WireConnection;2851;0;2843;0
WireConnection;2966;12;2948;0
WireConnection;2618;1;2608;0
WireConnection;2618;2;2612;0
WireConnection;2868;0;2870;495
WireConnection;2612;0;2613;0
WireConnection;2612;1;2641;495
WireConnection;2922;0;2621;0
WireConnection;2921;0;2622;0
WireConnection;2867;28;2925;0
WireConnection;2867;20;2926;0
WireConnection;2867;21;2928;0
WireConnection;2867;22;2927;0
WireConnection;2624;28;2622;0
WireConnection;2624;20;2621;0
WireConnection;2624;21;2620;0
WireConnection;2624;22;2623;0
WireConnection;2642;0;2941;0
WireConnection;2642;1;2966;0
WireConnection;2642;2;2944;0
WireConnection;2642;8;2968;0
WireConnection;2642;9;2820;370
ASEEND*/
//CHKSM=8CB9F86966E9F0573DED403223C2EF8FD6E68CC4