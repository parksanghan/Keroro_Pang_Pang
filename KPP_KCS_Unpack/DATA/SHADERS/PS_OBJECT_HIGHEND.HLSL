#include "Common.hlsl"

float4 light1Color : register(c0);
float4 light2Color : register(c1);
float4 ambientCube[6] : register(c2);

sampler albedoMap : register(s0);
sampler warpedMap : register(s1);

float3 ComputeAmbientLight(float3 worldNormal) {
    float3 nSquared = worldNormal * worldNormal;
    int3 isNegative = (worldNormal < 0.0);
    float3 linearColor;
    linearColor = nSquared.x * ambientCube[isNegative.x] +
                  nSquared.y * ambientCube[isNegative.y+2] +
                  nSquared.z * ambientCube[isNegative.z+4];
    return linearColor;
}

float4 main(VertexInterpolants interpolants) : COLOR0 {
    // Normalize interpolated vectors.
    float3 normal = normalize(interpolants.normal);
    float3 viewDir = normalize(interpolants.viewDir);
    float3 light1Dir = normalize(interpolants.light1Dir);

    // Rim lighting
    float NdotV = Dot3Clamp(normal, viewDir);
    float fresnel = 1.0f - NdotV;
    float rim = pow(fresnel, 4);
    float3 rimLighting = rim * light2Color.xyz;

    // Compute Light1
    float NdotL = Dot3Clamp(normal, light1Dir);
    float VdotL = Dot3Clamp(-light1Dir, viewDir);

    float3 warpedDiffuse = tex1D(warpedMap, NdotL) * light1Color.xyz;
    float3 ambient = ComputeAmbientLight(normal);

    float4 albedo = tex2D(albedoMap, interpolants.texCoord);

    return float4(warpedDiffuse + ambient, 1.0f) * albedo + float4(rimLighting, 0.0f);
}