Shader "internal/utility/TreeCreator/LeafHeightShader"
{
	Properties
	{
		_Input00Tex ("Input00", 2D) = "black" {}
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
			    
			    float hue = 0;
			    
			    float maximum = max(max(color.r, color.g), color.b);
			    float minimum = min(max(color.r, color.g), color.b);
			   
			    if (color.g > color.r && color.g > color.b)
			    {
			        hue = 2 + ((color.b - color.r)/(maximum-minimum));
			    }
			    else if (color.b > color.r && color.b > color.g)
			    {
			        hue = 4 + ((color.r - color.g)/(maximum-minimum));
			    }
			    else // red
			    {
			        hue = (color.g - color.b)/(maximum-minimum);
			    }
			    
			    hue = 1 - (hue/6);
			    
			    hue = (hue - .7) / (.3);
			    
			    hue = clamp(hue, 0, 1);
			    
			    hue = hue * color.a;
			    
			    return float4(hue, hue, hue, hue);
			}
			ENDCG
		}
	}
}
