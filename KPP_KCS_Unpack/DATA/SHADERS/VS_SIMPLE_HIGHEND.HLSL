#include "Common.hlsl"

float4x4    mWVP            : register(c0);     // World * View * Projection
float4x4    mWorld          : register(c4);     // World
float4      vFog            : register(c8);

float3      viewPos         : register(c9);
float3      lightPos[2]     : register(c10);
float3      lightColor[2]   : register(c12);

struct VertexInput {
    float4  pos            : POSITION;
    float3  normal         : NORMAL;
    float2  texCoord1      : TEXCOORD0;
    float2  texCoord2      : TEXCOORD1;
};

void main(
    VertexInput vertex,

    out float4 outPos : POSITION,
    out float outFog  : FOG,
    out VertexInterpolants o)
{
    outFog = vFog.x;
    outPos = mul(vertex.pos, mWVP);

    o.texCoord = vertex.texCoord1;

    float4 worldNormal = mul(float4(vertex.normal, 0.0f), mWorld);
    o.normal = worldNormal.xyz;

    float4 worldPos = mul(vertex.pos, mWorld);
    o.viewDir = normalize(viewPos - worldPos.xyz);
    o.light1Dir = normalize(lightPos[0] - worldPos.xyz);
    o.light2Dir = normalize(lightPos[1] - worldPos.xyz);
}
