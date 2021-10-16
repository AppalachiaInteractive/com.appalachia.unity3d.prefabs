Shader "internal/depth-mask" 
{
    Properties
	{
		[InternalBanner(Internal,Depth Mask)]_BANNER("BANNER", Float) = 1
		[InternalCategory(Rendering)]_RENDERINGG("[ RENDERINGG  ]", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("Cull Mode", Float) = 2
		[Toggle]_ZWriteMode("ZWrite Mode", Float) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTest Mode", Float) = 4
    }
    
	SubShader 
	{
		Tags { "RenderType" = "DepthMask"  "Queue" = "Geometry+10" }
		Cull [_CullMode]		
		ZWrite [_ZWriteMode]
		ZTest [_ZTestMode]
		ColorMask 0
 
		Pass 
		{
		}
	}
}