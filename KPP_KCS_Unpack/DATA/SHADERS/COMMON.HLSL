float Dot3Clamp(float3 v1, float3 v2) {
    return clamp(dot(v1, v2), 0.0f, 1.0f);
}

struct VertexInterpolants {
    float2  texCoord    : TEXCOORD0;
    float3  normal      : TEXCOORD1;
    float3  viewDir     : TEXCOORD2;
    float3  light1Dir   : TEXCOORD3;
    float3  light2Dir   : TEXCOORD4;
};