    #ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED
    
    struct IndirectShaderData
    {
        float4x4 PositionMatrix;
        float4x4 InversePositionMatrix;
    };
    
    #if defined(SHADER_API_GLCORE) || defined(SHADER_API_D3D11) || defined(SHADER_API_GLES3) || defined(SHADER_API_METAL) || defined(SHADER_API_VULKAN) || defined(SHADER_API_PS4) || defined(SHADER_API_XBOXONE)
    
    StructuredBuffer<IndirectShaderData> IndirectShaderDataBuffer;
    StructuredBuffer<IndirectShaderData> VisibleShaderDataBuffer;
    
    #endif
    
    #endif
       
    void setup()
    {    
#ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED

        unity_ObjectToWorld = IndirectShaderDataBuffer[unity_InstanceID].PositionMatrix;
        unity_WorldToObject = IndirectShaderDataBuffer[unity_InstanceID].InversePositionMatrix;

#endif
    }