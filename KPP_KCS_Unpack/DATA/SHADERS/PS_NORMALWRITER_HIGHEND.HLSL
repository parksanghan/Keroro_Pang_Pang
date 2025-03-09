#include "Common.hlsl"

float4x3 tangentBasis : register(c0);
float4 alpha : register(c3);

float4 main(VertexInterpolants interpolants) : COLOR0 {
    float3 tangentNormal = mul(interpolants.normal, tangentBasis);
    float3 normal = (tangentNormal + 1.0f) * 0.5f;
    return float4(normal, alpha.a);
}