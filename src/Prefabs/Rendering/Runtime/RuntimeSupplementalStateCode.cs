namespace Appalachia.Rendering.Prefabs.Rendering.Runtime
{
    public enum RuntimeSupplementalStateCode
    {
        NotReady = 0,

        ModelTypeDisabled = 10,
        ContentTypeDisabled = 11,

        PrefabRenderingSetDisabled = 20,
        ExternalParametersDisabled = 30,

        PrefabRenderingSetIsSoloed = 40,
        PrefabRenderingSetIsMuted = 41,
        AnotherPrefabRenderingSetIsSoloed = 42,

        ModelTypeIsSoloed = 50,
        ModelTypeIsMuted = 51,
        AnotherModelTypeIsSoloed = 52,

        ContentTypeIsSoloed = 55,
        ContentTypeIsMuted = 56,
        AnotherContentTypeIsSoloed = 57,

        UsingSavedLocations = 60,
        NoLocationsSaved = 61,

        NoExternalParameters = 100,

        ExternalParameterExplicitlyEnabled = 120,
        ExternalParametersEnabledByDefault = 130
    }
}
