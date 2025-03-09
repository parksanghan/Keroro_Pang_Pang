sampler colorMap : register(s0);
sampler normalMap : register(s1);

float4 main(
    float4 pos : POSITION,
    float2 texCoord : TEXCOORD0) : COLOR0
{
    half4 normalColor = tex2D(normalMap, texCoord);
    half4 normal = 2.0 * normalColor - 1.0;

    half2 newUV = texCoord + normal.xy * (0.05f * normalColor.a);

    return tex2D(colorMap, newUV);
}