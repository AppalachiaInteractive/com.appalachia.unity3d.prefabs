#region

using System;
using System.Collections.Generic;
using Appalachia.CI.Integration.Assets;
using Appalachia.Core.Objects.Initialization;
using Appalachia.Core.Objects.Root;
using Appalachia.Utility.Async;
using Appalachia.Utility.Strings;
using Sirenix.OdinInspector;
using UnityEngine;
using Object = UnityEngine.Object;

#endregion

namespace Appalachia.Rendering.Shading.Dynamic
{
    public class AppalachiaTextureArrayConfig : AppalachiaObject
    {
        public enum AllTextureChannel
        {
            R = 0,
            G,
            B,
            A,
            Custom
        }

        public enum Compression
        {
            AutomaticCompressed,
            ForceDXT,
            ForcePVR,
            ForceETC2,
            ForceASTC,
            ForceCrunch,
            Uncompressed
        }

        public enum PackingMode
        {
            Fastest,
            Quality
        }

        public enum SourceTextureSize
        {
            Unchanged,
            k32 = 32,
            k256 = 256
        }

        public enum TextureChannel
        {
            R = 0,
            G,
            B,
            A
        }

        public enum TextureSize
        {
            k4096 = 4096,
            k2048 = 2048,
            k1024 = 1024,
            k512 = 512,
            k256 = 256,
            k128 = 128,
            k64 = 64,
            k32 = 32
        }

        #region Static Fields and Autoproperties

        private static List<AppalachiaTextureArrayConfig> sAllConfigs = new();

        #endregion

        #region Fields and Autoproperties

        [HideInInspector] public bool uiOpenTextures = true;
        [HideInInspector] public bool uiOpenOutput = true;
        [HideInInspector] public bool uiOpenImporter = true;

        [HideInInspector] public string extDiffuse = "_diff";
        [HideInInspector] public string extHeight = "_height";
        [HideInInspector] public string extNorm = "_norm";
        [HideInInspector] public string extSmoothness = "_smoothness";
        [HideInInspector] public string extAO = "_ao";

        public TextureSize diffuseTextureSize = TextureSize.k1024;
        public Compression diffuseCompression = Compression.AutomaticCompressed;
        public FilterMode diffuseFilterMode = FilterMode.Bilinear;
        public int diffuseAnisoLevel = 1;

        public TextureSize normalSAOTextureSize = TextureSize.k1024;
        public Compression normalCompression = Compression.AutomaticCompressed;
        public FilterMode normalFilterMode = FilterMode.Trilinear;
        public int normalAnisoLevel = 1;

        [HideInInspector] public int hash;

        [HideInInspector] public Texture2DArray diffuseArray;

        [HideInInspector] public Texture2DArray normalSAOArray;

        // default settings, and overrides
        public InternalTextureArraySettingsGroup defaultTextureSettings = new();
        public List<PlatformTextureOverride> platformOverrides = new();

        public SourceTextureSize sourceTextureSize = SourceTextureSize.Unchanged;

        [HideInInspector] public AllTextureChannel allTextureChannelHeight = AllTextureChannel.G;

        [HideInInspector] public AllTextureChannel allTextureChannelSmoothness = AllTextureChannel.G;

        [HideInInspector] public AllTextureChannel allTextureChannelAO = AllTextureChannel.G;

        [HideInInspector] public List<InternalTextureEntry> sourceTextures = new();

        #endregion

#if UNITY_EDITOR
        public static List<T> FindAssetsByType<T>()
            where T : Object
        {
            var assets = new List<T>();
            var guids = AssetDatabaseManager.FindAssets(
                ZString.Format("t:{0}", typeof(T).ToString().Replace("UnityEngine.", ""))
            );
            for (var i = 0; i < guids.Length; i++)
            {
                var assetPath = AssetDatabaseManager.GUIDToAssetPath(guids[i]);
                var asset = AssetDatabaseManager.LoadAssetAtPath<T>(assetPath);
                if (asset != null)
                {
                    assets.Add(asset);
                }
            }

            return assets;
        }
#endif

        public static AppalachiaTextureArrayConfig FindConfig(Texture2DArray diffuse)
        {
#if UNITY_EDITOR
            if (sAllConfigs.Count == 0)
            {
                sAllConfigs = FindAssetsByType<AppalachiaTextureArrayConfig>();
            }
#endif

            for (var i = 0; i < sAllConfigs.Count; ++i)
            {
                if (sAllConfigs[i].diffuseArray == diffuse)
                {
                    return sAllConfigs[i];
                }
            }

            return null;
        }

        /// <inheritdoc />
        protected override async AppaTask Initialize(Initializer initializer)
        {
            await base.Initialize(initializer);

            sAllConfigs.Add(this);
        }

        /// <inheritdoc />
        protected override async AppaTask WhenDestroyed()
        {
            await base.WhenDestroyed();

            sAllConfigs.Remove(this);
        }

        #region Nested type: InternalTextureArraySettings

        [Serializable]
        public class InternalTextureArraySettings : AppalachiaSimpleBase
        {
            public InternalTextureArraySettings(TextureSize s, Compression c, FilterMode f, int a = 1)
            {
                textureSize = s;
                compression = c;
                filterMode = f;
                Aniso = a;
            }

            #region Fields and Autoproperties

            public TextureSize textureSize;
            public Compression compression;
            public FilterMode filterMode;

            [PropertyRange(0, 16)] public int Aniso;

            #endregion
        }

        #endregion

        #region Nested type: InternalTextureArraySettingsGroup

        [Serializable]
        public class InternalTextureArraySettingsGroup : AppalachiaSimpleBase
        {
            #region Fields and Autoproperties

            public InternalTextureArraySettings diffuseSettings = new(
                TextureSize.k1024,
                Compression.AutomaticCompressed,
                FilterMode.Bilinear
            );

            public InternalTextureArraySettings normalSettings = new(
                TextureSize.k1024,
                Compression.AutomaticCompressed,
                FilterMode.Bilinear
            );

            #endregion
        }

        #endregion

        #region Nested type: InternalTextureEntry

        [Serializable]
        public class InternalTextureEntry : AppalachiaSimpleBase
        {
            #region Fields and Autoproperties

            public Texture2D diffuse;
            public Texture2D height;
            public TextureChannel heightChannel = TextureChannel.G;
            public Texture2D normal;
            public Texture2D smoothness;
            public TextureChannel smoothnessChannel = TextureChannel.G;
            public bool isRoughness;
            public Texture2D ao;
            public TextureChannel aoChannel = TextureChannel.G;

            #endregion

            public bool HasTextures()
            {
                return (diffuse != null) ||
                       (height != null) ||
                       (normal != null) ||
                       (smoothness != null) ||
                       (ao != null);
            }

            public void Reset()
            {
                diffuse = null;
                height = null;
                normal = null;
                smoothness = null;
                ao = null;
                isRoughness = true;
                heightChannel = TextureChannel.G;
                smoothnessChannel = TextureChannel.G;
                aoChannel = TextureChannel.G;
            }
        }

        #endregion

        #region Nested type: PlatformTextureOverride

        [Serializable]
        public class PlatformTextureOverride : AppalachiaSimpleBase
        {
            #region Fields and Autoproperties

#if UNITY_EDITOR
            public UnityEditor.BuildTarget platform = UnityEditor.BuildTarget.StandaloneWindows;
#endif
            public InternalTextureArraySettingsGroup settings = new();

            #endregion
        }

        #endregion

        #region Menu Items

#if UNITY_EDITOR
        [UnityEditor.MenuItem(
            PKG.Menu.Assets.Base + nameof(AppalachiaTextureArrayConfig),
            priority = PKG.Menu.Assets.Priority
        )]
        public static void CreateAsset()
        {
            CreateNew<AppalachiaTextureArrayConfig>();
        }
#endif

        #endregion
    }
}
