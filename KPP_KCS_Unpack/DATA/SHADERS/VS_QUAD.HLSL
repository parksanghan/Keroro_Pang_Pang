struct VertexInput {
    float4  pos            : POSITION;
    int4    color          : COLOR0;
    int4    specular       : COLOR1;
    float2  texCoord1      : TEXCOORD0;
    float2  texCoord2      : TEXCOORD1;
    float2  texCoord3      : TEXCOORD2;
    float2  texCoord4      : TEXCOORD3;
};

void main(
    VertexInput vertex,

    out float4 outPos : POSITION,
    out float2 outTex : TEXCOORD0)
{
    outPos = vertex.pos;
    outTex = vertex.texCoord1;
}
