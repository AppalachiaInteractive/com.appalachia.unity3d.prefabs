using System;
using AmplifyShaderEditor;
using Appalachia.CI.Constants;
using Appalachia.CI.Integration.Assets;
using Appalachia.Core.Extensions;
using Appalachia.Core.Shading;
using Appalachia.Utility.Extensions;
using Appalachia.Utility.Strings;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

// ReSharper disable once CheckNamespace
// ReSharper disable once UnusedType.Global
public class AppalachiaShaderGUI : ShaderGUI
{
    [NonSerialized] private AppaContext _context;

    protected AppaContext Context
    {
        get
        {
            if (_context == null)
            {
                _context = new AppaContext(this);
            }

            return _context;
        }
    }

    #region Constants and Static Readonly

    private static readonly int Cutoff = Shader.PropertyToID("_Cutoff");

    private static readonly int CutoffHighNear = Shader.PropertyToID("_CutoffHighNear");

    //private Material material;
    //private static MaterialEditor m_instance = null;
    private static readonly int CutoffLowNear = Shader.PropertyToID("_CutoffLowNear");
    private static readonly int DstBlend = Shader.PropertyToID("_DstBlend");
    private static readonly int MetallicGlossMap = Shader.PropertyToID("_MetallicGlossMap");
    private static readonly int RenderType = Shader.PropertyToID("_RenderType");
    private static readonly int SrcBlend = Shader.PropertyToID("_SrcBlend");
    private static readonly int SurfaceMap = Shader.PropertyToID("_SurfaceMap");
    private static readonly int ZWrite = Shader.PropertyToID("_ZWrite");

    #endregion

    #region Static Fields and Autoproperties

    private static int s_ControlHash = "EditorTextField".GetHashCode();

    #endregion

    

    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props)
    {
        try
        {
            var material = materialEditor.target as Material;

            if (material == null)
            {
                return;
            }

            GUILayout.Space(3);

            using (new GUILayout.HorizontalScope())
            {
                if (GUILayout.Button("Open in Shader Editor"))
                {
                    ASEPackageManagerHelper.SetupLateMaterial(material);
                }

                if (GUILayout.Button("Open in Text Editor"))
                {
                    if (UIUtils.IsUnityNativeShader(material.shader))
                    {
                        Context.Log.Warn(
                            ZString.Format(
                                "Action not allowed. Attempting to load the native {0} shader into Text Editor",
                                material.shader.name
                            )
                        );
                    }
                    else
                    {
                        AssetDatabaseManager.OpenAsset(material.shader, 1);
                    }
                }
            }

            PropertiesDefaultGUI(materialEditor, props);

            if (material.HasProperty(CutoffLowNear))
            {
                var cutoffLowNear = material.GetFloat(CutoffLowNear);
                var cutoffHighNear = material.GetFloat(CutoffHighNear);

                var cutoff = (cutoffLowNear + cutoffHighNear) / 2.0f;

                var current = material.GetFloat(Cutoff);

                if (Math.Abs(current - cutoff) > float.Epsilon)
                {
                    var mainTexture = material.GetTexture(GSC.GENERAL._MainTex) as Texture2D;

                    if (mainTexture != null)
                    {
                        var importer = mainTexture.GetTextureImporter();

                        if ((Math.Abs(importer.alphaTestReferenceValue - cutoff) > float.Epsilon) ||
                            !importer.mipMapsPreserveCoverage)
                        {
                            importer.alphaTestReferenceValue = cutoff;
                            importer.mipMapsPreserveCoverage = true;
                            importer.SaveAndReimport();
                        }
                    }

                    material.SetFloat(Cutoff, cutoff);
                    material.MarkAsModified();
                }
            }

            if (material.HasProperty(SurfaceMap) && material.HasProperty(MetallicGlossMap))
            {
                var surface = material.GetTexture(SurfaceMap);
                var metallic = material.GetTexture(MetallicGlossMap);

                if ((surface == null) && (metallic != null))
                {
                    material.SetTexture(SurfaceMap, metallic);
                    material.MarkAsModified();
                }
            }

            SetRenderType(material);
        }
        catch (ExitGUIException)
        {
            throw;
        }
        catch (Exception ex)
        {
            Context.Log.Error(ex);
        }
    }

    public void PropertiesDefaultGUI(MaterialEditor materialEditor, MaterialProperty[] props)
    {
        materialEditor.SetDefaultGUIWidths();
        var info = materialEditor.GetInfoString();

        if (!string.IsNullOrWhiteSpace(info))
        {
            EditorGUILayout.HelpBox(info, MessageType.Info);
        }
        else
        {
            GUIUtility.GetControlID(s_ControlHash, FocusType.Passive, new Rect(0.0f, 0.0f, 0.0f, 0.0f));
        }

        for (var index = 0; index < props.Length; ++index)
        {
            if ((uint)(props[index].flags &
                       (MaterialProperty.PropFlags.HideInInspector |
                        MaterialProperty.PropFlags.PerRendererData)) <=
                0U)
            {
                var property = props[index];

                var propertyHeight = materialEditor.GetPropertyHeight(property, property.displayName);
                var controlRect = EditorGUILayout.GetControlRect(
                    true,
                    propertyHeight,
                    EditorStyles.layerMaskField
                );

                materialEditor.ShaderProperty(controlRect, property, property.displayName);
            }
        }

        EditorGUILayout.Space();

        if (SupportedRenderingFeatures.active.editableMaterialRenderQueue)
        {
            materialEditor.RenderQueueField();
        }

        materialEditor.EnableInstancingField();

        materialEditor.DoubleSidedGIField();
    }

    private void SetRenderType(Material material)
    {
        // Set Render Type
        if (material.HasProperty(RenderType))
        {
            var renderType = material.GetFloat(RenderType);

            if (renderType == 0)
            {
                material.SetOverrideTag("RenderType", "");
                material.SetInt(SrcBlend, (int)BlendMode.One);
                material.SetInt(DstBlend, (int)BlendMode.Zero);
                material.SetInt(ZWrite,   1);
                material.renderQueue = -1;

                material.EnableKeyword("_RENDERTYPEKEY_OPAQUE");
                material.DisableKeyword("_RENDERTYPEKEY_CUT");
                material.DisableKeyword("_RENDERTYPEKEY_FADE");
                material.DisableKeyword("_RENDERTYPEKEY_TRANSPARENT");
            }
            else if (Math.Abs(renderType - 1) < float.Epsilon)
            {
                material.SetOverrideTag("RenderType", "TransparentCutout");
                material.SetInt(SrcBlend, (int)BlendMode.One);
                material.SetInt(DstBlend, (int)BlendMode.Zero);
                material.SetInt(ZWrite,   1);
                material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.AlphaTest;

                material.DisableKeyword("_RENDERTYPEKEY_OPAQUE");
                material.EnableKeyword("_RENDERTYPEKEY_CUT");
                material.DisableKeyword("_RENDERTYPEKEY_FADE");
                material.DisableKeyword("_RENDERTYPEKEY_TRANSPARENT");
            }
            else if (Math.Abs(renderType - 2) < float.Epsilon)
            {
                material.SetOverrideTag("RenderType", "Transparent");
                material.SetInt(SrcBlend, (int)BlendMode.SrcAlpha);
                material.SetInt(DstBlend, (int)BlendMode.OneMinusSrcAlpha);
                material.SetInt(ZWrite,   0);
                material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.Transparent;

                material.DisableKeyword("_RENDERTYPEKEY_OPAQUE");
                material.DisableKeyword("_RENDERTYPEKEY_CUT");
                material.EnableKeyword("_RENDERTYPEKEY_FADE");
                material.DisableKeyword("_RENDERTYPEKEY_TRANSPARENT");
            }
            else if (Math.Abs(renderType - 3) < float.Epsilon)
            {
                material.SetOverrideTag("RenderType", "Transparent");
                material.SetInt(SrcBlend, (int)BlendMode.One);
                material.SetInt(DstBlend, (int)BlendMode.OneMinusSrcAlpha);
                material.SetInt(ZWrite,   0);
                material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.Transparent;

                material.DisableKeyword("_RENDERTYPEKEY_OPAQUE");
                material.DisableKeyword("_RENDERTYPEKEY_CUT");
                material.DisableKeyword("_RENDERTYPEKEY_FADE");
                material.EnableKeyword("_RENDERTYPEKEY_TRANSPARENT");
            }
        }
    }
}
