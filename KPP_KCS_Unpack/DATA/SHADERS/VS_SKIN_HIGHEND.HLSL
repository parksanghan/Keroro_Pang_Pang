#include "Common.hlsl"

float4x4    mWVP            : register(c0);     // World * View * Projection
float4x4    mWorld          : register(c4);     // World
float4      vFog            : register(c8);

float3      viewPos         : register(c9);
float3      lightPos[2]     : register(c10);
float3      lightColor[2]   : register(c12);

float4x3    mSkin[128]      : register(c20);

struct VertexInput {
    float4  pos            : POSITION;
    float3  normal         : NORMAL;
    float2  texCoord1      : TEXCOORD0;
    float2  texCoord2      : TEXCOORD1;
    float4  blendWeights   : BLENDWEIGHT;
    float4  blendIndices   : BLENDINDICES;
};

float4x3 ComputeSkinningMatrix(float4 weights, float4 indices) {
    float weightsArray[4] = (float[4])weights;
    int   indexArray[4]   = (int[4])D3DCOLORtoUBYTE4(indices);

    float4x3 m = mSkin[indexArray[0]] * weightsArray[0];
    m += mSkin[indexArray[1]] * weightsArray[1];
    m += mSkin[indexArray[2]] * weightsArray[2];
    m += mSkin[indexArray[3]] * weightsArray[3];

    return m;
}

void main(
    VertexInput vertex,

    out float4 outPos : POSITION,
    out float outFog  : FOG,
    out VertexInterpolants o)
{
    outFog = vFog.x;

    o.texCoord = vertex.texCoord1;

    float4x3 mSkinning = ComputeSkinningMatrix(vertex.blendWeights, vertex.blendIndices);
    float3 skinnedPos = mul(vertex.pos, mSkinning);
    outPos = mul(float4(skinnedPos, 1.0f), mWVP);

    o.normal = mul(vertex.normal, mSkinning);

    float4 worldPos = mul(float4(skinnedPos, 1.0f), mWorld);
    o.viewDir = normalize(viewPos - worldPos.xyz);
    o.light1Dir = normalize(lightPos[0] - worldPos.xyz);
    o.light2Dir = normalize(lightPos[1] - worldPos.xyz);
}
