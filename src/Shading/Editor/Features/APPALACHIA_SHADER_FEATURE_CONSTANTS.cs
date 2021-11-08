namespace Appalachia.Rendering.Shading.Features
{
    public static class APPALACHIA_SHADER_FEATURE_CONSTANTS
    {
	    public const string FEATURE_VEGETATION_STUDIO_ENABLED_IFDEF = @"
		// FEATURE_VEGETATION_STUDIO_GENERAL_IFDEF
		#ifdef INDIRECT_INSTANCING_VSP
";
	    public const string ELSE = @"
		#else
";
	    public const string ENDIF = @"
		#endif
";
	    
        public const string FEATURE_START = @"
		// INTERNAL_SHADER_FEATURE_START
";

        public const string FEATURE_END = @"
		// INTERNAL_SHADER_FEATURE_END
";

        public const string FEATURE_VEGETATION_STUDIO_FOLIAGE = @"
		// FEATURE_VEGETATION_STUDIO_FOLIAGE
		#include ""Assets/Resources/CGIncludes/appalachia/VS_indirect.cginc""
		#pragma instancing_options procedural:setupScale_VSP
		#pragma multi_compile GPU_FRUSTUM_ON __
";

        public const string FEATURE_VEGETATION_STUDIO_GENERAL = @"
		// FEATURE_VEGETATION_STUDIO_GENERAL
		#include ""Assets/Resources/CGIncludes/appalachia/VS_indirect.cginc""
		#pragma instancing_options assumeuniformscaling maxcount:50 procedural:setup_VSP
		#pragma multi_compile GPU_FRUSTUM_ON __
";

        public const string FEATURE_GPU_INSTANCER = @"
		// FEATURE_GPU_INSTANCER
		#include ""UnityCG.cginc""
		#include ""Assets/Resources/CGIncludes/appalachia/GPUInstancerInclude.cginc""
		#pragma instancing_options procedural:setupGPUI

";

        public const string FEATURE_LODFADE_DITHER = @"
		// FEATURE_LODFADE_DITHER
		#define INTERNAL_LODFADE_DITHER
		#pragma multi_compile _ LOD_FADE_CROSSFADE
";

        public const string FEATURE_LODFADE_SCALE = @"
		// FEATURE_LODFADE_SCALE
		#define INTERNAL_LODFADE_SCALE
		#pragma multi_compile __ LOD_FADE_CROSSFADE
";

        public static string FEATURE_START_searchterm => FEATURE_START.Trim('\r', '\n', '\t', ' ', '/');

        public static string FEATURE_END_searchterm => FEATURE_END.Trim('\r', '\n', '\t', ' ', '/');

    }
}
