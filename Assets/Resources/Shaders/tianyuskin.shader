struct PS_INPUT
{
    float4 dx_Position : SV_Position;
    float4 gl_Position : TEXCOORD6;
    float4 v0 : TEXCOORD0;
    float4 v1 : TEXCOORD1;
    float4 v2 : TEXCOORD2;
    float4 v3 : TEXCOORD3;
    float4 v4 : TEXCOORD4;
    float3 v5 : TEXCOORD5;
};

bool bool_ctor(bool x0)
{
    return bool(x0);
}
float2 vec2_ctor(float x0)
{
    return float2(x0, x0);
}
float3 vec3_ctor(float x0)
{
    return float3(x0, x0, x0);
}
float3 vec3_ctor(float x0, float x1, float x2)
{
    return float3(x0, x1, x2);
}
float3 vec3_ctor(float2 x0, float x1)
{
    return float3(x0, x1);
}
float3 vec3_ctor(float3 x0)
{
    return float3(x0);
}
float4 vec4_ctor(float x0)
{
    return float4(x0, x0, x0, x0);
}
int int_ctor_uint(uint x0)
{
    return int(x0);
}
uint uint_ctor(float x0)
{
    return uint(x0);
}
// Uniforms

uniform float4 __MainColor;
uniform float4 __CharacterSkinColorScale;
uniform float4 __EyebrowTilingOffset;
uniform float4 __EyebrowHSV;
uniform float4 __HighlightColor;
uniform float __DarkCharacterScale;
uniform float __DarkCharacterCtrl;
uniform float __AutoExposure;
uniform float __AutoExposure_Intensity;
uniform float __OutputAlpha;
uniform float4 __FogInfo2;
uniform float4 __FogInfo3;
uniform float4 __FogInfo4;
uniform float4 __FogColor1;
uniform float4 __FogColor2;
uniform float4 __FogColor3;
uniform float __SoftShadowType;
uniform float4 _hlslcc_mtx4x4_CustomShadowMatrix[4];
uniform float __CustomShadowBias;
uniform float _PANGU_CHARACTER_SOFT_SHADOW_SOFTNESS;
uniform float3 __CharacterLightDir;
uniform float __VlmScale;
uniform float __VolumetricShadow;
uniform float4 __SSSDiffParam;
uniform float4 __SSSLightColor;
uniform float4 __SSSSpecParam;
uniform float4 __SSSPoreParam;
uniform float __LipCubeIntensity;
uniform float __HDRTexEnable;
uniform float4 __FacialParams;
uniform float4 __RimColor;
uniform float __RimPower;
static const uint __FaceMaskTex = 0;
static const uint __MainTex = 1;
static const uint __BumpMap = 2;
static const uint __ParamTex = 3;
static const uint __ParamTex2 = 4;
static const uint __EyebrowMask = 5;
static const uint __PoreTex = 6;
static const uint __CustomShadowTex = 7;
static const uint __SSSTex = 8;
static const uint __AutoExposureTex = 9;
uniform Texture2D<float4> textures2D[10] : register(t0);
uniform SamplerState samplers2D[10] : register(s0);
static const uint __Cube = 10;
static const uint textureIndexOffsetCube = 10;
static const uint samplerIndexOffsetCube = 10;
uniform TextureCube<float4> texturesCube[1] : register(t10);
uniform SamplerState samplersCube[1] : register(s10);
static const uint _hlslcc_zcmp_ShadowMapTexture = 11;
static const uint textureIndexOffset2D_comparison = 11;
static const uint samplerIndexOffset2D_comparison = 11;
uniform Texture2D textures2D_comparison[1] : register(t11);
uniform SamplerComparisonState samplers2D_comparison[1] : register(s11);
// Uniform Blocks

cbuffer UnityPerCamera : register(b2)
{
    float4 __Time;
    float4 __SinTime;
    float4 __CosTime;
    float4 _unity_DeltaTime;
    float3 __WorldSpaceCameraPos;
    float4 __ProjectionParams;
    float4 __ScreenParams;
    float4 __ZBufferParams;
    float4 _unity_OrthoParams;
};

cbuffer UnityLighting : register(b3)
{
    float4 __WorldSpaceLightPos0;
    float4 __LightPositionRange;
    float4 __LightProjectionParams;
    float4 _unity_4LightPosX0;
    float4 _unity_4LightPosY0;
    float4 _unity_4LightPosZ0;
    float4 _unity_4LightAtten0;
    float4 _unity_LightColor[8];
    float4 _unity_LightPosition[8];
    float4 _unity_LightAtten[8];
    float4 _unity_SpotDirection[8];
    float4 _unity_SHAr;
    float4 _unity_SHAg;
    float4 _unity_SHAb;
    float4 _unity_SHBr;
    float4 _unity_SHBg;
    float4 _unity_SHBb;
    float4 _unity_SHC;
    float4 _unity_OcclusionMaskSelector;
    float4 _unity_ProbesOcclusion;
};

cbuffer UnityShadows : register(b4)
{
    float4 _unity_ShadowSplitSpheres[4];
    float4 _unity_ShadowSplitSqRadii;
    float4 _unity_LightShadowBias;
    float4 __LightSplitsNear;
    float4 __LightSplitsFar;
    float4 _hlslcc_mtx4x4unity_WorldToShadow[16];
    float4 __LightShadowData;
    float4 _unity_ShadowFadeCenterAndType;
};

cbuffer VlmSH : register(b5)
{
    float4 __VlmValues[7];
};

#ifdef ANGLE_ENABLE_LOOP_FLATTEN
#define LOOP [loop]
#define FLATTEN [flatten]
#else
#define LOOP
#define FLATTEN
#endif

#define ATOMIC_COUNTER_ARRAY_STRIDE 4

// Varyings
static  float4 _vs_TEXCOORD0 = {0, 0, 0, 0};
static  float4 _vs_TEXCOORD1 = {0, 0, 0, 0};
static  float4 _vs_TEXCOORD2 = {0, 0, 0, 0};
static  float4 _vs_TEXCOORD3 = {0, 0, 0, 0};
static  float4 _vs_TEXCOORD4 = {0, 0, 0, 0};
static  float3 _vs_TEXCOORD5 = {0, 0, 0};

static float4 out_SV_Target0 = {0, 0, 0, 0};

cbuffer DriverConstants : register(b1)
{
    struct SamplerMetadata
    {
        int baseLevel;
        int internalFormatBits;
        int wrapModes;
        int padding;
        int4 intBorderColor;
    };
    SamplerMetadata samplerMetadata[12] : packoffset(c4);
};

float4 gl_texture2D(uint samplerIndex, float2 t)
{
    return textures2D[samplerIndex].Sample(samplers2D[samplerIndex], float2(t.x, t.y));
}

float4 gl_texture2DLod0(uint samplerIndex, float2 t)
{
    return textures2D[samplerIndex].SampleLevel(samplers2D[samplerIndex], float2(t.x, t.y), 0);
}

float4 gl_textureCubeLod(uint samplerIndex, float3 t, float lod)
{
    const uint textureIndex = samplerIndex - textureIndexOffsetCube;
    const uint samplerArrayIndex = samplerIndex - samplerIndexOffsetCube;
    return texturesCube[textureIndex].SampleLevel(samplersCube[samplerArrayIndex], float3(t.x, t.y, t.z), lod);
}

float gl_texture2D_comparisonLod0(uint samplerIndex, float3 t)
{
    const uint textureIndex = samplerIndex - textureIndexOffset2D_comparison;
    const uint samplerArrayIndex = samplerIndex - samplerIndexOffset2D_comparison;
    return textures2D_comparison[textureIndex].SampleCmpLevelZero(samplers2D_comparison[samplerArrayIndex], float2(t.x, t.y), t.z);
}

static float2 _ImmCB_0_0_0[12] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
static float3 _u_xlat0 = {0, 0, 0};
static float4 _u_xlat16_0 = {0, 0, 0, 0};
static float3 _u_xlat1 = {0, 0, 0};
static float3 _u_xlat16_1 = {0, 0, 0};
static float _u_xlat2 = {0};
static float4 _u_xlat16_2 = {0, 0, 0, 0};
static bool _u_xlatb2 = {0};
static float4 _u_xlat3 = {0, 0, 0, 0};
static float4 _u_xlat16_3 = {0, 0, 0, 0};
static bool3 _u_xlatb3 = {0, 0, 0};
static float4 _u_xlat16_4 = {0, 0, 0, 0};
static float4 _u_xlat16_5 = {0, 0, 0, 0};
static float3 _u_xlat16_6 = {0, 0, 0};
static float4 _u_xlat7 = {0, 0, 0, 0};
static float4 _u_xlat16_7 = {0, 0, 0, 0};
static float4 _u_xlat16_8 = {0, 0, 0, 0};
static float4 _u_xlat9 = {0, 0, 0, 0};
static float4 _u_xlat16_9 = {0, 0, 0, 0};
static float3 _u_xlat10 = {0, 0, 0};
static float3 _u_xlat16_10 = {0, 0, 0};
static bool _u_xlatb10 = {0};
static float3 _u_xlat11 = {0, 0, 0};
static float3 _u_xlat16_11 = {0, 0, 0};
static float3 _u_xlat16_12 = {0, 0, 0};
static float3 _u_xlat16_13 = {0, 0, 0};
static float3 _u_xlat16_14 = {0, 0, 0};
static float3 _u_xlat16_15 = {0, 0, 0};
static float3 _u_xlat16_16 = {0, 0, 0};
static float3 _u_xlat16_17 = {0, 0, 0};
static float _u_xlat16_18 = {0};
static float _u_xlat16_19 = {0};
static float _u_xlat20 = {0};
static bool _u_xlatb20 = {0};
static float2 _u_xlat16_22 = {0, 0};
static float3 _u_xlat16_26 = {0, 0, 0};
static float _u_xlat16_28 = {0};
static float3 _u_xlat16_31 = {0, 0, 0};
static float _u_xlat16_37 = {0};
static float _u_xlat39 = {0};
static uint _u_xlatu39 = {0};
static bool _u_xlatb39 = {0};
static float _u_xlat16_40 = {0};
static float2 _u_xlat16_44 = {0, 0};
static float _u_xlat54 = {0};
static float _u_xlat55 = {0};
static float _u_xlat16_55 = {0};
static uint _u_xlatu55 = {0};
static bool _u_xlatb55 = {0};
static bool _u_xlatb56 = {0};
static float _u_xlat16_58 = {0};
static float _u_xlat16_60 = {0};
static float _u_xlat16_62 = {0};
static float _u_xlat16_66 = {0};
struct PS_OUTPUT
{
    float4 out_SV_Target0 : SV_TARGET0;
};

PS_OUTPUT generateOutput()
{
    PS_OUTPUT output;
    output.out_SV_Target0 = out_SV_Target0;
    return output;
}


PS_OUTPUT main(PS_INPUT input){
    _vs_TEXCOORD0 = input.v0;
    _vs_TEXCOORD1 = input.v1;
    _vs_TEXCOORD2 = input.v2;
    _vs_TEXCOORD3 = input.v3;
    _vs_TEXCOORD4 = input.v4;
    _vs_TEXCOORD5 = input.v5.xyz;

(_ImmCB_0_0_0[0] = float2(0.0, 0.0));
(_ImmCB_0_0_0[1] = float2(0.24952979, 0.73207498));
(_ImmCB_0_0_0[2] = float2(-0.34692061, 0.64378363));
(_ImmCB_0_0_0[3] = float2(-0.01878909, 0.48273939));
(_ImmCB_0_0_0[4] = float2(-0.27252129, 0.89618802));
(_ImmCB_0_0_0[5] = float2(-0.68143362, 0.6480481));
(_ImmCB_0_0_0[6] = float2(0.4152045, 0.27941719));
(_ImmCB_0_0_0[7] = float2(0.1310554, 0.26759249));
(_ImmCB_0_0_0[8] = float2(0.53447437, 0.56244111));
(_ImmCB_0_0_0[9] = float2(0.83856893, 0.51373482));
(_ImmCB_0_0_0[10] = float2(0.60450518, 0.083938569));
(_ImmCB_0_0_0[11] = float2(0.46431631, 0.86846417));
(_u_xlat0.x = _vs_TEXCOORD0.w);
(_u_xlat0.y = _vs_TEXCOORD1.w);
(_u_xlat0.z = _vs_TEXCOORD2.w);
(_u_xlat0.xyz = ((-_u_xlat0.xyz) + __WorldSpaceCameraPos.xyz));
(_u_xlat54 = dot(_u_xlat0.xyz, _u_xlat0.xyz));
(_u_xlat54 = rsqrt(_u_xlat54));
(_u_xlat1.xyz = (vec3_ctor(_u_xlat54) * _u_xlat0.xyz));
(_u_xlat16_55 = gl_texture2D(__FaceMaskTex, _vs_TEXCOORD3.xy).y);
(_u_xlat16_2.xyz = gl_texture2D(__MainTex, _vs_TEXCOORD3.xy).xyz);
(_u_xlat16_3 = gl_texture2D(__BumpMap, _vs_TEXCOORD3.xy));
(_u_xlat16_4.xy = ((_u_xlat16_3.xy * float2(2.0, 2.0)) + float2(-1.0, -1.0)));
(_u_xlat16_5 = gl_texture2D(__ParamTex, _vs_TEXCOORD3.xy));
(_u_xlat16_3.xy = gl_texture2D(__ParamTex2, _vs_TEXCOORD3.xy).xw);
(_u_xlatb56 = (0.80000001 < __FacialParams.z));
float s9ac = {0};
if (_u_xlatb56)
{
(s9ac = 0.0);
}
else
{
(s9ac = 1.0);
}
(_u_xlat16_58 = s9ac);
(_u_xlat16_58 = (_u_xlat16_3.y * _u_xlat16_58));
(_u_xlat16_6.xyz = ((_u_xlat16_2.xyz * __MainColor.xyz) + (-_u_xlat16_2.xyz)));
(_u_xlat16_6.xyz = ((vec3_ctor(_u_xlat16_58) * _u_xlat16_6.xyz) + _u_xlat16_2.xyz));
(_u_xlatb2 = (_vs_TEXCOORD3.z < 0.5));
(_u_xlat20 = ((-_vs_TEXCOORD3.z) + 1.0));
float s9ad = {0};
if (_u_xlatb2)
{
(s9ad = _u_xlat20);
}
else
{
(s9ad = _vs_TEXCOORD3.z);
}
(_u_xlat2 = s9ad);
(_u_xlat16_7.x = (_u_xlat2 + __EyebrowTilingOffset.z));
(_u_xlat16_7.y = (_vs_TEXCOORD3.w + __EyebrowTilingOffset.w));
(_u_xlat16_7.xy = (_u_xlat16_7.xy * __EyebrowTilingOffset.xy));
(_u_xlat16_2 = gl_texture2D(__EyebrowMask, _u_xlat16_7.xy));
(_u_xlat16_7 = (_u_xlat16_2 * __MainColor));
(_u_xlatb56 = (_u_xlat16_7.y >= _u_xlat16_7.z));
float s9ae = {0};
if (_u_xlatb56)
{
(s9ae = 1.0);
}
else
{
(s9ae = 0.0);
}
(_u_xlat16_58 = s9ae);
(_u_xlat16_8.xy = ((_u_xlat16_2.yz * __MainColor.yz) + (-_u_xlat16_7.zy)));
(_u_xlat16_44.x = 1.0);
(_u_xlat16_44.y = -1.0);
(_u_xlat16_8.xy = (vec2_ctor(_u_xlat16_58) * _u_xlat16_8.xy));
(_u_xlat16_9.xy = ((_u_xlat16_2.zy * __MainColor.zy) + _u_xlat16_8.xy));
(_u_xlat16_9.zw = ((vec2_ctor(_u_xlat16_58) * _u_xlat16_44.xy) + float2(-1.0, 0.66666669)));
(_u_xlatb20 = (_u_xlat16_7.x >= _u_xlat16_9.x));
float s9af = {0};
if (_u_xlatb20)
{
(s9af = 1.0);
}
else
{
(s9af = 0.0);
}
(_u_xlat16_58 = s9af);
(_u_xlat16_8.xyz = (-_u_xlat16_9.xyw));
(_u_xlat16_8.w = (-_u_xlat16_7.x));
(_u_xlat16_2.x = ((_u_xlat16_2.x * __MainColor.x) + _u_xlat16_8.x));
(_u_xlat16_2.yzw = (_u_xlat16_8.yzw + _u_xlat16_9.yzx));
(_u_xlat16_8.xyz = ((vec3_ctor(_u_xlat16_58) * _u_xlat16_2.xyz) + _u_xlat16_9.xyw));
(_u_xlat16_58 = ((_u_xlat16_58 * _u_xlat16_2.w) + _u_xlat16_7.x));
(_u_xlat16_60 = min(_u_xlat16_8.y, _u_xlat16_58));
(_u_xlat16_60 = ((-_u_xlat16_60) + _u_xlat16_8.x));
(_u_xlat16_58 = ((-_u_xlat16_8.y) + _u_xlat16_58));
(_u_xlat16_10.x = ((_u_xlat16_60 * 6.0) + 9.9999997e-05));
(_u_xlat16_10.x = (_u_xlat16_58 / _u_xlat16_10.x));
(_u_xlat16_10.x = (_u_xlat16_8.z + _u_xlat16_10.x));
(_u_xlat16_58 = (_u_xlat16_8.x + 9.9999997e-05));
(_u_xlat16_58 = (_u_xlat16_60 / _u_xlat16_58));
(_u_xlat16_60 = (abs(_u_xlat16_10.x) + __EyebrowHSV.x));
(_u_xlat16_58 = (_u_xlat16_58 + __EyebrowHSV.y));
(_u_xlat16_8.x = (_u_xlat16_8.x + __EyebrowHSV.z));
(_u_xlat16_26.xyz = (vec3_ctor(_u_xlat16_60) + float3(1.0, 0.66666669, 0.33333334)));
(_u_xlat16_26.xyz = frac(_u_xlat16_26.xyz));
(_u_xlat16_10.xyz = ((_u_xlat16_26.xyz * float3(6.0, 6.0, 6.0)) + float3(-3.0, -3.0, -3.0)));
(_u_xlat16_26.xyz = (abs(_u_xlat16_10.xyz) + float3(-1.0, -1.0, -1.0)));
(_u_xlat16_26.xyz = clamp(_u_xlat16_26.xyz, 0.0, 1.0));
(_u_xlat16_26.xyz = (_u_xlat16_26.xyz + float3(-1.0, -1.0, -1.0)));
(_u_xlat16_26.xyz = ((vec3_ctor(_u_xlat16_58) * _u_xlat16_26.xyz) + float3(1.0, 1.0, 1.0)));
(_u_xlat16_8.xyz = ((_u_xlat16_8.xxx * _u_xlat16_26.xyz) + (-_u_xlat16_7.xyz)));
(_u_xlat16_8.xyz = ((_u_xlat16_7.www * _u_xlat16_8.xyz) + _u_xlat16_7.xyz));
(_u_xlat16_58 = (_u_xlat16_55 * __EyebrowHSV.w));
(_u_xlat16_8.xyz = ((-_u_xlat16_6.xyz) + _u_xlat16_8.xyz));
(_u_xlat16_6.xyz = ((vec3_ctor(_u_xlat16_58) * _u_xlat16_8.xyz) + _u_xlat16_6.xyz));
(_u_xlat16_58 = dot(_vs_TEXCOORD5.xyz, _vs_TEXCOORD5.xyz));
(_u_xlat16_58 = rsqrt(_u_xlat16_58));
(_u_xlat16_8.xyz = (vec3_ctor(_u_xlat16_58) * _vs_TEXCOORD5.xyz));
(_u_xlat10.x = _vs_TEXCOORD0.z);
(_u_xlat10.y = _vs_TEXCOORD1.z);
(_u_xlat10.z = _vs_TEXCOORD2.z);
(_u_xlat16_58 = dot(_u_xlat16_8.xyz, _u_xlat10.xyz));
(_u_xlat16_58 = clamp(_u_xlat16_58, 0.0, 1.0));
(_u_xlat16_60 = (_u_xlat16_58 * _u_xlat16_58));
(_u_xlat16_60 = (_u_xlat16_60 * __LipCubeIntensity));
(_u_xlat16_8.x = dot((-_vs_TEXCOORD5.xyz), _u_xlat10.xyz));
(_u_xlat16_8.x = (_u_xlat16_8.x + _u_xlat16_8.x));
(_u_xlat16_8.xyz = ((_u_xlat10.xyz * (-_u_xlat16_8.xxx)) + (-_vs_TEXCOORD5.xyz)));
(_u_xlat55 = ((__FacialParams.y * -3.0) + 3.0));
(_u_xlat16_10.xyz = gl_textureCubeLod(__Cube, _u_xlat16_8.xyz, _u_xlat55).xyz);
(_u_xlat10.xyz = (vec3_ctor(_u_xlat16_58) * _u_xlat16_10.xyz));
(_u_xlatb55 = (__HDRTexEnable < 0.5));
(_u_xlat11.xyz = (_u_xlat10.xyz * float3(0.25, 0.25, 0.25)));
float3 s9b0 = {0, 0, 0};
if (bool_ctor(_u_xlatb55))
{
(s9b0 = _u_xlat10.xyz);
}
else
{
(s9b0 = _u_xlat11.xyz);
}
(_u_xlat10.xyz = s9b0);
(_u_xlat16_8.xyz = (vec3_ctor(_u_xlat16_60) * _u_xlat10.xyz));
(_u_xlat16_8.xyz = (_u_xlat16_3.zzz * _u_xlat16_8.xyz));
(_u_xlat16_6.xyz = ((_u_xlat16_8.xyz * __FacialParams.xxx) + _u_xlat16_6.xyz));
(_u_xlat16_8.xy = (_vs_TEXCOORD3.xy * __SSSPoreParam.xx));
(_u_xlat16_8.xy = (_u_xlat16_8.xy * float2(10.0, 10.0)));
(_u_xlat16_2 = gl_texture2D(__PoreTex, _u_xlat16_8.xy));
(_u_xlat16_8.xy = ((_u_xlat16_2.zw * float2(2.0, 2.0)) + float2(-1.0, -1.0)));
(_u_xlat16_44.xy = (_u_xlat16_2.xy + float2(-1.0, -1.0)));
(_u_xlat16_44.xy = ((_u_xlat16_3.ww * _u_xlat16_44.xy) + float2(1.0, 1.0)));
(_u_xlat16_8.xy = ((-_u_xlat16_4.xy) + _u_xlat16_8.xy));
(_u_xlat16_9.xy = ((_u_xlat16_3.ww * _u_xlat16_8.xy) + _u_xlat16_4.xy));
(_u_xlat16_9.z = 1.0);
(_u_xlat16_12.x = dot(_vs_TEXCOORD0.xyz, _u_xlat16_9.xyz));
(_u_xlat16_12.y = dot(_vs_TEXCOORD1.xyz, _u_xlat16_9.xyz));
(_u_xlat16_12.z = dot(_vs_TEXCOORD2.xyz, _u_xlat16_9.xyz));
(_u_xlat16_58 = (_u_xlat16_3.z * __FacialParams.x));
(_u_xlat16_60 = ((-_u_xlat16_3.x) + __FacialParams.y));
(_u_xlat16_4.w = ((_u_xlat16_58 * _u_xlat16_60) + _u_xlat16_3.x));
(_u_xlat16_4.z = 1.0);
(_u_xlat16_9.x = dot(_vs_TEXCOORD0.xyz, _u_xlat16_4.xyz));
(_u_xlat16_9.y = dot(_vs_TEXCOORD1.xyz, _u_xlat16_4.xyz));
(_u_xlat16_9.z = dot(_vs_TEXCOORD2.xyz, _u_xlat16_4.xyz));
(_u_xlat16_55 = dot(_u_xlat16_9.xyz, _u_xlat16_9.xyz));
(_u_xlat16_55 = rsqrt(_u_xlat16_55));
(_u_xlat16_2 = (vec4_ctor(_u_xlat16_55) * _u_xlat16_9.zyxx));
(_u_xlatb3.xz = (float4(1.0, 0.0, 2.0, 0.0) < vec4_ctor(__SoftShadowType)).xz);
(_u_xlat7 = (_vs_TEXCOORD1.wwww * _hlslcc_mtx4x4_CustomShadowMatrix[1]));
(_u_xlat7 = ((_hlslcc_mtx4x4_CustomShadowMatrix[0] * _vs_TEXCOORD0.wwww) + _u_xlat7));
(_u_xlat7 = ((_hlslcc_mtx4x4_CustomShadowMatrix[2] * _vs_TEXCOORD2.wwww) + _u_xlat7));
(_u_xlat7 = (_u_xlat7 + _hlslcc_mtx4x4_CustomShadowMatrix[3]));
(_u_xlat9 = (_vs_TEXCOORD1.wwww * _hlslcc_mtx4x4unity_WorldToShadow[1]));
(_u_xlat9 = ((_hlslcc_mtx4x4unity_WorldToShadow[0] * _vs_TEXCOORD0.wwww) + _u_xlat9));
(_u_xlat9 = ((_hlslcc_mtx4x4unity_WorldToShadow[2] * _vs_TEXCOORD2.wwww) + _u_xlat9));
(_u_xlat9 = (_u_xlat9 + _hlslcc_mtx4x4unity_WorldToShadow[3]));
float4 s9b1 = {0, 0, 0, 0};
if (_u_xlatb3.x)
{
(s9b1 = _u_xlat7);
}
else
{
(s9b1 = _u_xlat9);
}
(_u_xlat7 = s9b1);
FLATTEN if (_u_xlatb3.z)
{
(_u_xlat9 = _u_xlat7);
(_u_xlat16_4.x = 0.0);
(_u_xlat16_22.x = 0.0);
{LOOP for(; true; )
{
(_u_xlatb55 = (_u_xlat16_22.x >= 12.0));
if (_u_xlatb55)
{
break;
}
(_u_xlatu55 = uint_ctor(_u_xlat16_22.x));
(_u_xlat9.xy = ((_ImmCB_0_0_0[int_ctor_uint(_u_xlatu55)].xy * vec2_ctor(_PANGU_CHARACTER_SOFT_SHADOW_SOFTNESS)) + _u_xlat9.xy));
(_u_xlat10.xy = (_u_xlat9.xy / _u_xlat9.ww));
(_u_xlat55 = gl_texture2DLod0(__CustomShadowTex, _u_xlat10.xy).x);
(_u_xlat39 = (_u_xlat9.z + (-__CustomShadowBias)));
(_u_xlatb55 = (_u_xlat39 < _u_xlat55));
float s9b2 = {0};
if (_u_xlatb55)
{
(s9b2 = 1.0);
}
else
{
(s9b2 = 0.0);
}
(_u_xlat55 = s9b2);
(_u_xlat16_4.x = (_u_xlat55 + _u_xlat16_4.x));
(_u_xlat16_22.x = (_u_xlat16_22.x + 1.0));
}
}
(_u_xlat16_4.x = (_u_xlat16_4.x * 0.083333336));
}
else
{
FLATTEN if (_u_xlatb3.x)
{
(_u_xlat9 = _u_xlat7);
(_u_xlat16_22.x = 0.0);
(_u_xlat16_40 = 0.0);
{LOOP for(; true; )
{
(_u_xlatb55 = (_u_xlat16_40 >= 8.0));
if (_u_xlatb55)
{
break;
}
(_u_xlatu55 = uint_ctor(_u_xlat16_40));
(_u_xlat9.xy = ((_ImmCB_0_0_0[int_ctor_uint(_u_xlatu55)].xy * vec2_ctor(_PANGU_CHARACTER_SOFT_SHADOW_SOFTNESS)) + _u_xlat9.xy));
(_u_xlat3.xz = (_u_xlat9.xy / _u_xlat9.ww));
(_u_xlat55 = gl_texture2DLod0(__CustomShadowTex, _u_xlat3.xz).x);
(_u_xlat3.x = (_u_xlat9.z + (-__CustomShadowBias)));
(_u_xlatb55 = (_u_xlat3.x < _u_xlat55));
float s9b3 = {0};
if (_u_xlatb55)
{
(s9b3 = 1.0);
}
else
{
(s9b3 = 0.0);
}
(_u_xlat55 = s9b3);
(_u_xlat16_22.x = (_u_xlat55 + _u_xlat16_22.x));
(_u_xlat16_40 = (_u_xlat16_40 + 1.0));
}
}
(_u_xlat16_4.x = (_u_xlat16_22.x * 0.125));
}
else
{
(_u_xlatb3.xz = (float4(-0.5, 0.0, -1.5, 0.0) < vec4_ctor(__SoftShadowType)).xz);
float s9b4 = {0};
if (_u_xlatb3.x)
{
(s9b4 = 12.0);
}
else
{
(s9b4 = 8.0);
}
(_u_xlat55 = s9b4);
float s9b5 = {0};
if (_u_xlatb3.z)
{
(s9b5 = _u_xlat55);
}
else
{
(s9b5 = 4.0);
}
(_u_xlat55 = s9b5);
(_u_xlat3.x = _u_xlat7.z);
(_u_xlat16_22.x = 0.0);
(_u_xlat16_40 = 0.0);
{ for(; true; )
{
(_u_xlatb39 = (_u_xlat16_40 >= _u_xlat55));
if (_u_xlatb39)
{
break;
}
(_u_xlatu39 = uint_ctor(_u_xlat16_40));
(_u_xlatb10 = (_u_xlat3.x < 0.0099999998));
float s9b6 = {0};
if (_u_xlatb10)
{
(s9b6 = 1.0);
}
else
{
(s9b6 = _u_xlat3.x);
}
(_u_xlat3.x = s9b6);
(_u_xlat10.xy = ((_ImmCB_0_0_0[int_ctor_uint(_u_xlatu39)].xy * vec2_ctor(_PANGU_CHARACTER_SOFT_SHADOW_SOFTNESS)) + _u_xlat7.xy));
float3 _txVec02475 = vec3_ctor(_u_xlat10.xy, _u_xlat3.x);
(_u_xlat16_60 = gl_texture2D_comparisonLod0(_hlslcc_zcmp_ShadowMapTexture, _txVec02475));
(_u_xlat16_22.x = (_u_xlat16_22.x + _u_xlat16_60));
(_u_xlat16_40 = (_u_xlat16_40 + 1.0));
}
}
(_u_xlat16_4.x = (_u_xlat16_22.x / _u_xlat55));
}
}
(_u_xlat16_22.x = ((-__LightShadowData.x) + 1.0));
(_u_xlat16_4.x = ((_u_xlat16_4.x * _u_xlat16_22.x) + __LightShadowData.x));
(_u_xlat16_55 = (((-__VolumetricShadow) * 0.60000002) + 1.0));
(_u_xlat16_22.x = dot(__CharacterLightDir.zyx, _u_xlat16_2.xyw));
(_u_xlat16_22.x = clamp(_u_xlat16_22.x, 0.0, 1.0));
(_u_xlat3.xz = ((_u_xlat16_22.xx * float2(0.5, 0.60000002)) + float2(0.5, 0.2)));
(_u_xlat16_55 = (((-_u_xlat16_4.x) * _u_xlat16_55) + 1.0));
(_u_xlat55 = (((-_u_xlat16_55) * _u_xlat3.z) + 1.0));
(_u_xlat16_13.xyz = (__CharacterSkinColorScale.xyz * __SSSLightColor.xyz));
(_u_xlat16_4.x = dot(_u_xlat16_12.xyz, _u_xlat16_12.xyz));
(_u_xlat16_4.x = rsqrt(_u_xlat16_4.x));
(_u_xlat16_12.xyz = (_u_xlat16_4.xxx * _u_xlat16_12.xyz));
(_u_xlat16_4.x = dot(_u_xlat1.zyx, _u_xlat16_2.xyw));
(_u_xlat16_40 = _u_xlat16_4.x);
(_u_xlat16_40 = clamp(_u_xlat16_40, 0.0, 1.0));
(_u_xlat16_4.xw = ((-_u_xlat16_4.xw) + float2(1.0, 1.0)));
(_u_xlat16_10.x = max(_u_xlat16_4.w, 0.050000001));
(_u_xlat16_10.x = min(_u_xlat16_10.x, 1.0));
(_u_xlat16_58 = (_u_xlat16_10.x * -0.31099999));
(_u_xlat16_4.w = ((_u_xlat16_5.w * _u_xlat16_58) + _u_xlat16_10.x));
(_u_xlat16_4.xw = (_u_xlat16_4.xw * _u_xlat16_4.xw));
(_u_xlat16_28 = ((_u_xlat16_4.w * _u_xlat16_4.w) + 0.0099999998));
(_u_xlat16_14.xyz = (_u_xlat16_44.xxx * float3(1.0, 0.5, 0.25)));
(_u_xlat16_15.xyz = (_u_xlat16_44.yyy * float3(0.0, 0.25, 0.30000001)));
(_u_xlat16_58 = ((-_u_xlat16_40) + 1.0));
(_u_xlat16_60 = (_u_xlat16_58 * _u_xlat16_58));
(_u_xlat16_11.xyz = (((-_u_xlat16_44.xxx) * float3(1.0, 0.5, 0.25)) + float3(0.5, 0.5, 0.5)));
(_u_xlat16_11.xyz = ((vec3_ctor(_u_xlat16_60) * _u_xlat16_11.xyz) + _u_xlat16_14.xyz));
(_u_xlat16_16.xyz = (((-_u_xlat16_44.yyy) * float3(0.0, 0.25, 0.30000001)) + float3(0.5, 0.5, 0.5)));
(_u_xlat16_16.xyz = ((vec3_ctor(_u_xlat16_60) * _u_xlat16_16.xyz) + _u_xlat16_15.xyz));
(_u_xlat16_8.x = (_u_xlat16_5.z * 0.63690001));
(_u_xlat3.z = 0.0);
(_u_xlat16_17.xyz = gl_texture2D(__SSSTex, _u_xlat3.xz).xyz);
(_u_xlat16_26.xyz = ((_u_xlat16_13.xyz * float3(2.0, 2.0, 2.0)) + _u_xlat16_8.xxx));
(_u_xlat16_26.xyz = (_u_xlat16_5.xxx * _u_xlat16_26.xyz));
(_u_xlat16_26.xyz = (_u_xlat16_26.xyz * __SSSDiffParam.xxx));
(_u_xlat16_31.xyz = (_u_xlat16_13.xyz * __SSSDiffParam.yyy));
(_u_xlat16_66 = (_u_xlat16_8.x * __SSSDiffParam.w));
(_u_xlat16_31.xyz = ((_u_xlat16_31.xyz * _u_xlat16_17.xyz) + vec3_ctor(_u_xlat16_66)));
(_u_xlat16_26.xyz = (_u_xlat16_26.xyz * __CharacterSkinColorScale.xyz));
(_u_xlat16_26.xyz = (_u_xlat16_26.xyz * __MainColor.xyz));
(_u_xlat16_26.xyz = ((_u_xlat16_26.xyz * float3(0.25, 0.0, 0.0)) + _u_xlat16_31.xyz));
(_u_xlat16_26.xyz = (vec3_ctor(_u_xlat55) * _u_xlat16_26.xyz));
(_u_xlat16_3.x = (_u_xlat16_13.x * 4.0));
(_u_xlat16_3.x = (_u_xlat16_22.x * _u_xlat16_3.x));
(_u_xlat16_13.xyz = ((_u_xlat0.xyz * vec3_ctor(_u_xlat54)) + __CharacterLightDir.xyz));
(_u_xlat16_22.x = dot(_u_xlat16_13.xyz, _u_xlat16_13.xyz));
(_u_xlat16_22.x = rsqrt(_u_xlat16_22.x));
(_u_xlat16_13.xyz = (_u_xlat16_22.xxx * _u_xlat16_13.xyz));
(_u_xlat16_22.x = dot(_u_xlat16_13.xyz, _u_xlat16_12.xyz));
(_u_xlat16_12.x = dot(_u_xlat16_13.xyz, _u_xlat1.xyz));
(_u_xlat16_0.x = ((_u_xlat16_22.x * _u_xlat16_28) + (-_u_xlat16_22.x)));
(_u_xlat16_0.x = ((_u_xlat16_0.x * _u_xlat16_22.x) + 1.0));
(_u_xlat16_0.x = (_u_xlat16_0.x * _u_xlat16_0.x));
(_u_xlat0.x = max(_u_xlat16_0.x, 9.9999997e-05));
(_u_xlat16_18 = ((_u_xlat16_12.x * -5.5547299) + -6.98316));
(_u_xlat16_18 = (_u_xlat16_12.x * _u_xlat16_18));
(_u_xlat16_18 = exp2(_u_xlat16_18));
(_u_xlat0.y = ((_u_xlat16_18 * 0.95999998) + 0.039999999));
(_u_xlat0.xy = (_u_xlat0.xy * float2(3.141593, 0.25)));
(_u_xlat0.x = (_u_xlat16_28 / _u_xlat0.x));
(_u_xlat0.x = (_u_xlat0.y * _u_xlat0.x));
(_u_xlat16_22.x = (_u_xlat16_3.x * _u_xlat0.x));
(_u_xlat16_0 = ((_u_xlat16_10.xxxx * float4(-1.0, -0.0275, -0.57200003, 0.022)) + float4(1.0, 0.0425, 1.04, -0.039999999)));
(_u_xlat16_12.x = (_u_xlat16_0.x * _u_xlat16_0.x));
(_u_xlat16_1.x = (_u_xlat16_40 * -9.2799997));
(_u_xlat16_1.x = exp2(_u_xlat16_1.x));
(_u_xlat16_1.x = min(_u_xlat16_1.x, _u_xlat16_12.x));
(_u_xlat16_1.x = ((_u_xlat16_1.x * _u_xlat16_0.x) + _u_xlat16_0.y));
(_u_xlat16_1.xy = ((_u_xlat16_1.xx * float2(-1.04, 1.04)) + _u_xlat16_0.zw));
(_u_xlat16_40 = ((_u_xlat16_1.x * 0.039999999) + _u_xlat16_1.y));
(_u_xlat16_1.x = (_u_xlat16_22.x * 0.5));
(_u_xlat16_1.x = min(_u_xlat16_1.x, 6.0));
(_u_xlat16_22.x = (_u_xlat16_40 * 0.89999998));
(_u_xlat16_22.x = (_u_xlat16_5.z * _u_xlat16_22.x));
(_u_xlat16_12.x = ((-_u_xlat16_5.w) + 1.0));
(_u_xlat16_12.xyz = ((_u_xlat16_16.xyz * _u_xlat16_5.www) + _u_xlat16_12.xxx));
(_u_xlat16_12.xyz = (_u_xlat16_22.xxx * _u_xlat16_12.xyz));
(_u_xlat16_22.x = dot(_u_xlat16_8.xxx, float3(0.30000001, 0.58999997, 0.11)));
(_u_xlat16_40 = (_u_xlat16_8.x * _u_xlat16_40));
(_u_xlat16_13.xyz = (_u_xlat16_11.xyz * vec3_ctor(_u_xlat16_40)));
(_u_xlat16_10.xyz = (_u_xlat16_13.xyz * float3(15.0, 15.0, 15.0)));
(_u_xlat16_10.xyz = (_u_xlat16_5.www * _u_xlat16_10.xyz));
(_u_xlat16_12.xyz = ((_u_xlat16_12.xyz * _u_xlat16_22.xxx) + _u_xlat16_10.xyz));
(_u_xlat16_12.xyz = (_u_xlat16_12.xyz * __SSSSpecParam.www));
(_u_xlat16_12.xyz = ((_u_xlat16_3.yyy * (-_u_xlat16_12.xyz)) + _u_xlat16_12.xyz));
(_u_xlat16_12.xyz = (_u_xlat16_3.www * _u_xlat16_12.xyz));
(_u_xlat16_22.x = (_u_xlat16_1.x * __SSSSpecParam.y));
(_u_xlat16_12.xyz = ((_u_xlat16_22.xxx * _u_xlat16_5.yyy) + _u_xlat16_12.xyz));
(_u_xlat16_8.xyz = (_u_xlat16_6.xyz * _u_xlat16_26.xyz));
(_u_xlat16_8.xyz = ((_u_xlat16_12.xyz * vec3_ctor(_u_xlat55)) + _u_xlat16_8.xyz));
(_u_xlat16_1.xyz = (_u_xlat16_6.xyz * float3(0.30000001, 0.30000001, 0.30000001)));
(_u_xlat16_0 = (_u_xlat16_2 * float4(-0.325735, 0.325735, 0.325735, -0.273137)));
(_u_xlat16_0.w = (_u_xlat16_2.x * _u_xlat16_0.w));
(_u_xlat16_22.xy = (_u_xlat16_2.xw * float2(-0.273137, 0.273137)));
(_u_xlat16_55 = (_u_xlat16_2.y * _u_xlat16_2.y));
(_u_xlat16_55 = ((_u_xlat16_55 * 3.0) + -1.0));
(_u_xlat3.y = (_u_xlat16_55 * 0.078847997));
(_u_xlat16_3.xz = (_u_xlat16_2.yy * _u_xlat16_22.xy));
(_u_xlat16_22.x = (_u_xlat16_2.x * _u_xlat16_2.x));
(_u_xlat16_22.x = ((_u_xlat16_2.w * _u_xlat16_2.w) + (-_u_xlat16_22.x)));
(_u_xlat3.w = (_u_xlat16_22.x * 0.1365685));
(_u_xlat16_22.x = dot(_u_xlat16_0, __VlmValues[0]));
(_u_xlat3.xz = _u_xlat16_3.xz);
(_u_xlat16_40 = dot(_u_xlat3, __VlmValues[1]));
(_u_xlat16_22.x = (_u_xlat16_40 + _u_xlat16_22.x));
(_u_xlat16_6.x = ((__VlmValues[6].x * 0.28209499) + _u_xlat16_22.x));
(_u_xlat16_22.x = dot(_u_xlat16_0, __VlmValues[2]));
(_u_xlat16_40 = dot(_u_xlat3, __VlmValues[3]));
(_u_xlat16_22.x = (_u_xlat16_40 + _u_xlat16_22.x));
(_u_xlat16_6.y = ((__VlmValues[6].y * 0.28209499) + _u_xlat16_22.x));
(_u_xlat16_22.x = dot(_u_xlat16_0, __VlmValues[4]));
(_u_xlat16_40 = dot(_u_xlat3, __VlmValues[5]));
(_u_xlat16_22.x = (_u_xlat16_40 + _u_xlat16_22.x));
(_u_xlat16_6.z = ((__VlmValues[6].z * 0.28209499) + _u_xlat16_22.x));
(_u_xlat16_12.xyz = ((_u_xlat16_6.xyz * float3(2.51, 2.51, 2.51)) + float3(0.029999999, 0.029999999, 0.029999999)));
(_u_xlat16_12.xyz = (_u_xlat16_6.xyz * _u_xlat16_12.xyz));
(_u_xlat16_13.xyz = ((_u_xlat16_6.xyz * float3(2.4300001, 2.4300001, 2.4300001)) + float3(0.58999997, 0.58999997, 0.58999997)));
(_u_xlat16_6.xyz = ((_u_xlat16_6.xyz * _u_xlat16_13.xyz) + float3(0.14, 0.14, 0.14)));
(_u_xlat16_6.xyz = (_u_xlat16_12.xyz / _u_xlat16_6.xyz));
(_u_xlat16_6.xyz = max(_u_xlat16_6.xyz, float3(0.0, 0.0, 0.0)));
(_u_xlat16_6.xyz = (_u_xlat16_6.xyz * vec3_ctor(vec3_ctor(__VlmScale, __VlmScale, __VlmScale))));
(_u_xlat16_1.xyz = ((_u_xlat16_1.xyz * _u_xlat16_6.xyz) + _u_xlat16_8.xyz));
(_u_xlat16_4.x = (_u_xlat16_4.x * _u_xlat16_4.x));
(_u_xlat16_4.xyz = (_u_xlat16_4.xxx * __HighlightColor.xyz));
(_u_xlat16_4.xyz = ((_u_xlat16_4.xyz * __HighlightColor.www) + _u_xlat16_1.xyz));
(_u_xlat16_1.x = (_u_xlat16_58 * 0.42500001));
(_u_xlat16_1.x = ((_u_xlat16_58 * _u_xlat16_1.x) + _u_xlat16_60));
(_u_xlat16_1.x = (_u_xlat16_1.x * _u_xlat16_5.w));
(_u_xlat16_1.x = (_u_xlat16_1.x * __RimPower));
(_u_xlat16_4.xyz = ((_u_xlat16_1.xxx * __RimColor.xyz) + _u_xlat16_4.xyz));
(_u_xlat16_1.x = gl_texture2D(__AutoExposureTex, float2(0.5, 0.5)).x);
(_u_xlat16_19 = (__AutoExposure_Intensity + 1.0));
(_u_xlat16_37 = ((__AutoExposure_Intensity * -0.30000001) + 1.0));
(_u_xlat16_19 = (1.0 / _u_xlat16_19));
(_u_xlat16_37 = (1.0 / _u_xlat16_37));
(_u_xlat16_1.x = (_u_xlat16_1.x * 5.0));
(_u_xlat16_1.x = clamp(_u_xlat16_1.x, 0.0, 1.0));
(_u_xlat16_37 = ((-_u_xlat16_19) + _u_xlat16_37));
(_u_xlat16_1.x = ((_u_xlat16_1.x * _u_xlat16_37) + _u_xlat16_19));
(_u_xlat16_4.xyz = (_u_xlat16_1.xxx * _u_xlat16_4.xyz));
(_u_xlat16_6.xyz = (_u_xlat16_4.xyz * vec3_ctor(vec3_ctor(__AutoExposure, __AutoExposure, __AutoExposure))));
(_u_xlat16_58 = dot((-__WorldSpaceLightPos0.xyz), _vs_TEXCOORD4.xyz));
(_u_xlat16_58 = clamp(_u_xlat16_58, 0.0, 1.0));
(_u_xlat16_58 = (_u_xlat16_58 * _u_xlat16_58));
(_u_xlat16_60 = (((-_vs_TEXCOORD4.y) * __FogInfo2.w) + __FogInfo2.z));
(_u_xlat16_60 = clamp(_u_xlat16_60, 0.0, 1.0));
(_u_xlat16_8.xyz = ((-__FogColor1.xyz) + __FogColor2.xyz));
(_u_xlat16_8.xyz = ((vec3_ctor(_u_xlat16_60) * _u_xlat16_8.xyz) + __FogColor1.xyz));
(_u_xlat16_60 = dot(_u_xlat16_8.xyz, float3(0.30000001, 0.58999997, 0.11)));
(_u_xlat16_62 = (_vs_TEXCOORD4.w * __FogInfo4.x));
(_u_xlat16_12.xyz = ((vec3_ctor(_u_xlat16_60) * __FogInfo4.yyy) + (-_u_xlat16_8.xyz)));
(_u_xlat16_8.xyz = ((vec3_ctor(_u_xlat16_62) * _u_xlat16_12.xyz) + _u_xlat16_8.xyz));
(_u_xlat16_12.xyz = (__FogInfo3.zzz * __FogColor3.xyz));
(_u_xlat16_8.xyz = ((_u_xlat16_12.xyz * vec3_ctor(_u_xlat16_58)) + _u_xlat16_8.xyz));
(_u_xlat16_1.x = ((-_vs_TEXCOORD4.w) + 1.0));
(_u_xlat16_1.xyz = ((_u_xlat16_6.xyz * _u_xlat16_1.xxx) + _u_xlat16_8.xyz));
(_u_xlat16_1.xyz = (((-_u_xlat16_4.xyz) * vec3_ctor(vec3_ctor(__AutoExposure, __AutoExposure, __AutoExposure))) + _u_xlat16_1.xyz));
(_u_xlat16_1.xyz = ((_vs_TEXCOORD4.www * _u_xlat16_1.xyz) + _u_xlat16_6.xyz));
(_u_xlat16_55 = (((-__DarkCharacterScale) * __DarkCharacterCtrl) + 1.0));
(_u_xlat16_3.xyz = (vec3_ctor(_u_xlat16_55) * _u_xlat16_1.xyz));
(_u_xlat16_4.x = (((-_u_xlat16_1.x) * _u_xlat16_55) + 1.0));
(out_SV_Target0.x = ((__OutputAlpha * _u_xlat16_4.x) + _u_xlat16_3.x));
(out_SV_Target0.yz = _u_xlat16_3.yz);
(out_SV_Target0.w = 1.0);
return generateOutput();
}