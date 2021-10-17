Shader "appalachia/utility/TreeCreator/BarkMultiplyShader"
{
	Properties
	{
		_Input00Tex ("Input00", 2D) = "black" {}
		_Amount("Amount" , Range(0,1)) = 0.5
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.6
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			sampler2D _Input00Tex;
			half _Amount;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			
			fixed4 frag (v2f i) : SV_Target
			{
			    float4 color = tex2D(_Input00Tex, i.uv);
			    return float4(
			        color.r *_Amount,
			        color.g *_Amount, 
			        color.b *_Amount, 
			        color.a *_Amount);
			}
			ENDCG
		}
	}
}
