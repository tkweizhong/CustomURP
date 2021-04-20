#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

uniform float3 _PlatformPosition;
uniform float4 _PlatformRotation;

uniform float4 _FogInfo;
uniform float4 _FogInfo2;
uniform float4 _FogInfo3;
uniform float4 _FogInfo4;
uniform float4 _FogColor1;
uniform float4 _FogColor2;
uniform float4 _FogColor3;

uniform float3 _CharacterLightDir;
uniform float4 _CharacterLightColor;

// uniform float4 _CombinedProps0;
// uniform float4 _CombinedProps3;

uniform float _DarkCharacterScale;
uniform float _DarkCharacterCtrl;
uniform float _AutoExposure;
uniform float _AutoExposure_Intensity;

uniform float4 _ColorLeft;
uniform float4 _ColorRight;
uniform float _CharacterEyeLightScale;
uniform float4 _CombinedProps0;
uniform float4 _CombinedProps1;
uniform float4 _CombinedProps2;
uniform float4 _CombinedProps3;
uniform float4 _CombinedProps4;
uniform float4 _Refraction;
uniform float _Alpha;
uniform float _HDRTexEnable;

// static const uint _MainTex = 0;
// static const uint _MainRightTex = 1;
// static const uint _Masks = 2;
// static const uint _AutoExposureTex = 3;

// uniform Texture2D<float4> textures2D[4];
// uniform SamplerState samplers2D[4];

TEXTURE2D_X(_MainTex);
SAMPLER(sampler_MainTex);
TEXTURE2D_X(_MainRightTex);
SAMPLER(sampler_MainRightTex);
TEXTURE2D_X(_Masks);
SAMPLER(sampler_Masks);
TEXTURE2D_X(_AutoExposureTex);
SAMPLER(sampler_AutoExposureTex);

static const uint _Cube = 4;
static const uint textureIndexOffsetCube = 4;
static const uint samplerIndexOffsetCube = 4;
uniform TextureCube<float4> texturesCube[1];
uniform SamplerState samplersCube[1];


struct v2f
{
    float4 PositionCS : SV_Position;
    // float4 gl_Position : TEXCOORD7;
    float4 v0 : TEXCOORD0;
    float3 v1 : TEXCOORD1;
    float3 v2 : TEXCOORD2;
    float3 v3 : TEXCOORD3;
    float3 v4 : TEXCOORD4;
    float3 v5 : TEXCOORD5;
    float3 v6 : TEXCOORD6;
};


struct TianyuAppdata
{
    float4 PositionOS : TEXCOORD0;
    float4 TangentOS  : TEXCOORD1;
    float3 NormalOS : TEXCOORD2;
    float4 Texcoord0 : TEXCOORD3;
    float4 Texcoord1 : TEXCOORD4;
};