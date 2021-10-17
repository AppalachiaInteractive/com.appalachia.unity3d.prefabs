Shader "appalachia/utility/TreeCreator/TreeLeafSurface"
{
	Properties
	{
		_Input00Tex ("Input00", 2D) = "black" {}
		_Input01Tex ("Input01", 2D) = "black" {}
		_IsBark("Is Bark", Range(0,1)) = 1
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
			sampler2D _Input01Tex;
			half _IsBark;
			
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
			    float4 ao = tex2D(_Input01Tex, i.uv);
			    
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
			        
			    float subsurface = (hue/6);
			    subsurface = (subsurface-.2) / (.2);
			    subsurface = clamp(subsurface, 0, 1);
			    subsurface = subsurface * color.a;
			    
			    float height = 1 - (hue/6);
			    height = (height - .7) / (.3);
			    height = clamp(height, 0, 1); 
			    height = height * color.a;
			    
			    float smoothness = (hue/6);
			    smoothness = clamp(smoothness, 0, 1);
			    smoothness = smoothness * color.a * .03;
			    
			    float r = 0;
			    float g = ao.b;
			    float b = _IsBark ? height : subsurface;
			    float a = smoothness;
			    
			    return float4(r,g,b,a);
			}
			ENDCG
		}
	}
}
