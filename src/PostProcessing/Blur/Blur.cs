using System;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

namespace Appalachia.Rendering.PostProcessing.Blur
{
    [Serializable]
    [PostProcess(typeof(BlurRenderer), PostProcessEvent.BeforeTransparent, "Appalachia/Blur")]
    public sealed class Blur : PostProcessEffectSettings
    {
        // ReSharper disable FieldCanBeMadeReadOnly.Global
        [PropertyRange(1, 8)] public IntParameter downsample = new IntParameter { value = 1 };

        [PropertyRange(0.0f, 40.0f)]
        public FloatParameter blurSize = new FloatParameter { value = 3f };

        [PropertyRange(0, 8)] public IntParameter blurIterations = new IntParameter { value = 2 };
    }

    public sealed class BlurRenderer : PostProcessEffectRenderer<Blur>
    {
        #region Fields and Autoproperties

        private int parameterID;
        private Shader shader;

        #endregion

        /// <inheritdoc />
        public override void Init()
        {
            base.Init();
            shader = Shader.Find("Hidden/Appalachia/Blur");
            parameterID = Shader.PropertyToID("_Parameter");
        }

        /// <inheritdoc />
        public override void Render(PostProcessRenderContext context)
        {
            var nbIterations = settings.blurIterations.value;
            if (nbIterations == 0)
            {
                context.command.Blit(context.source, context.destination);
                return;
            }

            var cmd = context.command;
            var sheet = context.propertySheets.Get(shader);

            var widthMod = 1.0f / (1.0f * (1 << settings.downsample.value));
            var blurSize = settings.blurSize.value;
            sheet.properties.SetFloat(parameterID, blurSize * widthMod);

            var rtW = context.width >> settings.downsample.value;
            var rtH = context.height >> settings.downsample.value;

            // downsample
            var rt = RenderTexture.GetTemporary(rtW, rtH, 0, context.sourceFormat);
            rt.filterMode = FilterMode.Bilinear;
            cmd.BlitFullscreenTriangle(context.source, rt, sheet, 0);

            for (var i = 0; i < nbIterations; i++)
            {
                var iterationOffs = i * 1.0f;
                sheet.properties.SetFloat(parameterID, (blurSize * widthMod) + iterationOffs);

                // vertical blur
                var rt2 = RenderTexture.GetTemporary(rtW, rtH, 0, context.sourceFormat);
                rt2.filterMode = FilterMode.Bilinear;
                cmd.BlitFullscreenTriangle(rt, rt2, sheet, 1);
                RenderTexture.ReleaseTemporary(rt);
                rt = rt2;

                // horizontal blur
                rt2 = RenderTexture.GetTemporary(rtW, rtH, 0, context.sourceFormat);
                rt2.filterMode = FilterMode.Bilinear;
                cmd.BlitFullscreenTriangle(rt, rt2, sheet, 2);
                RenderTexture.ReleaseTemporary(rt);
                rt = rt2;
            }

            context.command.Blit(rt, context.destination);
            RenderTexture.ReleaseTemporary(rt);
        }
    }
}
