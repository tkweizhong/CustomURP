// struct PS_INPUT
// {
//     float4 dx_Position : SV_Position;
//     float4 gl_Position : TEXCOORD7;
//     float4 v0 : TEXCOORD0;
//     float3 v1 : TEXCOORD1;
//     float3 v2 : TEXCOORD2;
//     float3 v3 : TEXCOORD3;
//     float3 v4 : TEXCOORD4;
//     float3 v5 : TEXCOORD5;
//     float3 v6 : TEXCOORD6;
// };

// float float_ctor(int x0)
// {
//     return float(x0);
// }
// float2 vec2_ctor(float x0)
// {
//     return float2(x0, x0);
// }
// float3 vec3_ctor(float x0)
// {
//     return float3(x0, x0, x0);
// }
// float3 vec3_ctor(float x0, float x1, float x2)
// {
//     return float3(x0, x1, x2);
// }
// float3 vec3_ctor(float3 x0)
// {
//     return float3(x0);
// }
// int int_ctor_uint(uint x0)
// {
//     return int(x0);
// }
// Uniforms

// uniform float __DarkCharacterScale : register(c0);
// uniform float __DarkCharacterCtrl : register(c1);
// uniform float __AutoExposure : register(c2);
// uniform float __AutoExposure_Intensity : register(c3);
// uniform float4 __FogInfo2 : register(c4);
// uniform float4 __FogInfo3 : register(c5);
// uniform float4 __FogInfo4 : register(c6);
// uniform float4 __FogColor1 : register(c7);
// uniform float4 __FogColor2 : register(c8);
// uniform float4 __FogColor3 : register(c9);
// uniform float4 __CharacterLightColor : register(c10);
// uniform float4 __ColorLeft : register(c11);
// uniform float4 __ColorRight : register(c12);
// uniform float __CharacterEyeLightScale : register(c13);
// uniform float4 __CombinedProps0 : register(c14);
// uniform float4 __CombinedProps1 : register(c15);
// uniform float4 __CombinedProps2 : register(c16);
// uniform float4 __CombinedProps3 : register(c17);
// uniform float4 __CombinedProps4 : register(c18);
// uniform float4 __Refraction : register(c19);
// uniform float __Alpha : register(c20);
// uniform float __HDRTexEnable : register(c21);
// static const uint __MainTex = 0;
// static const uint __MainRightTex = 1;
// static const uint __Masks = 2;
// static const uint __AutoExposureTex = 3;
// uniform Texture2D<float4> textures2D[4] : register(t0);
// uniform SamplerState samplers2D[4] : register(s0);
// static const uint __Cube = 4;
// static const uint textureIndexOffsetCube = 4;
// static const uint samplerIndexOffsetCube = 4;
// uniform TextureCube<float4> texturesCube[1] : register(t4);
// uniform SamplerState samplersCube[1] : register(s4);
// Uniform Blocks

// cbuffer UnityLighting : register(b2)
// {
//     float4 __WorldSpaceLightPos0;
//     float4 __LightPositionRange;
//     float4 __LightProjectionParams;
//     float4 _unity_4LightPosX0;
//     float4 _unity_4LightPosY0;
//     float4 _unity_4LightPosZ0;
//     float4 _unity_4LightAtten0;
//     float4 _unity_LightColor[8];
//     float4 _unity_LightPosition[8];
//     float4 _unity_LightAtten[8];
//     float4 _unity_SpotDirection[8];
//     float4 _unity_SHAr;
//     float4 _unity_SHAg;
//     float4 _unity_SHAb;
//     float4 _unity_SHBr;
//     float4 _unity_SHBg;
//     float4 _unity_SHBb;
//     float4 _unity_SHC;
//     float4 _unity_OcclusionMaskSelector;
//     float4 _unity_ProbesOcclusion;
// };

// cbuffer UnityPerDraw : register(b3)
// {
//     float4 _hlslcc_mtx4x4unity_ObjectToWorld[4];
//     float4 _hlslcc_mtx4x4unity_WorldToObject[4];
//     float4 _unity_LODFade;
//     float4 _unity_WorldTransformParams;
//     float4 _unity_RenderingLayer;
// };

cbuffer UnityLight0 : register(b4)
{
    float4 _LightColor0;
    float4 _SpecColor;
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
// static  float3 _vs_TEXCOORD0 = {0, 0, 0};
// static  float3 _vs_TEXCOORD4 = {0, 0, 0};
// static  float3 _vs_TEXCOORD5 = {0, 0, 0};
// static  float3 _vs_TEXCOORD8 = {0, 0, 0};
// static  float3 _vs_TEXCOORD9 = {0, 0, 0};
// static  float3 _vs_TEXCOORD11 = {0, 0, 0};
// static  float4 _vs_TEXCOORD12 = {0, 0, 0, 0};

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
    SamplerMetadata samplerMetadata[5] : packoffset(c4);
};

// float4 gl_texture2D(uint samplerIndex, float2 t)
// {
//     return textures2D[samplerIndex].Sample(samplers2D[samplerIndex], float2(t.x, t.y));
// }

float4 gl_textureCube(uint samplerIndex, float3 t)
{
    const uint textureIndex = samplerIndex - textureIndexOffsetCube;
    const uint samplerArrayIndex = samplerIndex - samplerIndexOffsetCube;
    return texturesCube[textureIndex].Sample(samplersCube[samplerArrayIndex], float3(t.x, t.y, t.z));
}

static float3 _u_xlat16_0 = {0, 0, 0};
// static float3 _u_xlat1 = {0, 0, 0};
static float4 _u_xlat16_1 = {0, 0, 0, 0};
static float4 _u_xlat16_2 = {0, 0, 0, 0};
static float4 _u_xlat3 = {0, 0, 0, 0};
// static float4 _u_xlat16_3 = {0, 0, 0, 0};
// static float2 _u_xlat4 = {0, 0};
static float4 _u_xlat16_4 = {0, 0, 0, 0};
static float3 _u_xlat16_5 = {0, 0, 0};
static float3 _u_xlat16_6 = {0, 0, 0};
static float3 _u_xlat16_7 = {0, 0, 0};
// static float3 _u_xlat16_8 = {0, 0, 0};
static float _u_xlat16_9 = {0};
static float2 _u_xlat16_10 = {0, 0};
static float _u_xlat16_16 = {0};
static float _u_xlat17 = {0};
static float _u_xlat16_17 = {0};
static int _u_xlati17 = {0};
static bool2 _u_xlatb17 = {0, 0};
static float _u_xlat19 = {0};
static bool _u_xlatb19 = {0};
static float _u_xlat16_24 = {0};
static float _u_xlat16_25 = {0};
static int _u_xlati25 = {0};
static float _u_xlat26 = {0};
static float _u_xlat16_26 = {0};
static float _u_xlat16_29 = {0};

// struct PS_OUTPUT
// {
//     float4 out_SV_Target0 : SV_TARGET0;
// };

// PS_OUTPUT generateOutput()
// {
//     PS_OUTPUT output;
//     output.out_SV_Target0 = out_SV_Target0;
//     return output;
// }


half4 frag(v2f input) : SV_TARGET0
{
    _vs_TEXCOORD12 = input.v0;
    _vs_TEXCOORD0 = input.v1.xyz;
    _vs_TEXCOORD4 = input.v2.xyz;
    _vs_TEXCOORD5 = input.v3.xyz;
    _vs_TEXCOORD8 = input.v4.xyz;
    _vs_TEXCOORD9 = input.v5.xyz;
    _vs_TEXCOORD11 = input.v6.xyz;

(_u_xlat16_0.x = dot(_vs_TEXCOORD8.xyz, _vs_TEXCOORD5.xyz));
(_u_xlat16_1.xy = max(_Refraction.yz, float2(0.001, 0.001)));
(_u_xlat16_1.x = (1.0299 / _u_xlat16_1.x));
(_u_xlat16_8.x = ((_u_xlat16_1.x * _u_xlat16_0.x) + (-_u_xlat16_1.x)));
(_u_xlat16_16 = ((_u_xlat16_1.x * _u_xlat16_0.x) + _u_xlat16_1.x));
(_u_xlat16_8.x = ((_u_xlat16_8.x * _u_xlat16_16) + 1.0));
(_u_xlat16_8.x = sqrt(_u_xlat16_8.x));
(_u_xlat16_17 = ((_u_xlat16_1.x * _u_xlat16_0.x) + (-_u_xlat16_8.x)));
(_u_xlat16_0.xyz = (_u_xlat16_1.xxx * _vs_TEXCOORD5.xyz));
(_u_xlat16_1.xzw = ((float3(_u_xlat16_17.xxx) * _vs_TEXCOORD8.xyz) + (-_u_xlat16_0.xyz)));
(_u_xlat16_2.x = dot(_u_xlat16_1.xzw, _u_xlat16_1.xzw));
(_u_xlat16_2.x = rsqrt(_u_xlat16_2.x));
(_u_xlat16_1.xzw = (_u_xlat16_1.xzw * _u_xlat16_2.xxx));
(_u_xlat16_0.x = dot(_vs_TEXCOORD11.xyz, (-_vs_TEXCOORD5.xyz)));
(_u_xlat16_0.x = (_u_xlat16_0.x * _u_xlat16_0.x));
(_u_xlat16_2.x = ((_u_xlat16_0.x * 0.67500001) + 0.32499999));
(_u_xlat16_10.xy = (_vs_TEXCOORD0.xy + float2(-0.5, -0.5)));
(_u_xlat16_0.x = dot(_u_xlat16_10.xy, _u_xlat16_10.xy));
(_u_xlat16_0.x = sqrt(_u_xlat16_0.x));
(_u_xlat16_0.x = (_u_xlat16_0.x / _CombinedProps0.z));
(_u_xlat16_0.x = clamp(_u_xlat16_0.x, 0.0, 1.0));
(_u_xlat16_26 = (_u_xlat16_0.x + -1.0));
(_u_xlat16_3.xy = ((-_CombinedProps0.yx) + _CombinedProps3.yx));
(_u_xlatb19 = (0.5 >= _vs_TEXCOORD0.z));
float s972 = {0};
if (_u_xlatb19)
{
(s972 = 1.0);
}
else
{
(s972 = 0.0);
}
(_u_xlat19 = s972);
(_u_xlat3.xy = ((float2(_u_xlat19.xx) * _u_xlat16_3.xy) + _CombinedProps0.yx));
(_u_xlat26 = ((_u_xlat3.x * _u_xlat16_26) + 1.0));
(_u_xlat3.xw = (float2(_u_xlat26.xx) * _u_xlat16_10.xy));
(_u_xlat16_0.x = dot(_u_xlat3.xw, _u_xlat3.xw));
(_u_xlat16_0.x = sqrt(_u_xlat16_0.x));
(_u_xlat16_4.x = (_u_xlat16_0.x * 18.4));
(_u_xlat16_4.x = (((-_u_xlat16_4.x) * _u_xlat16_0.x) + 1.0));
(_u_xlat16_4.x = max(_u_xlat16_4.x, 0.0));
(_u_xlat16_4.x = (_u_xlat16_4.x * _Refraction.w));
(_u_xlat16_8.x = (_u_xlat16_4.x / _u_xlat16_2.x));
(_u_xlat16_8.xyz = (_u_xlat16_1.xzw * _u_xlat16_8.xxx));
(_u_xlat4.x = dot(_u_xlat16_8.xyz, unity_ObjectToWorld[1].xyz));
(_u_xlat4.y = dot(_u_xlat16_8.xyz, unity_ObjectToWorld[2].xyz));
(_u_xlat16_8.x = (_CombinedProps0.z + (-_Refraction.z)));
(_u_xlat16_0.x = ((-_u_xlat16_8.x) + _u_xlat16_0.x));
(_u_xlat16_1.x = (_u_xlat16_0.x / _u_xlat16_1.y));
(_u_xlat16_0.x = (((-_u_xlat16_1.x) * _u_xlat3.y) + 1.0));
(_u_xlat16_0.x = clamp(_u_xlat16_0.x, 0.0, 1.0));
(_u_xlat16_8.x = ((_u_xlat16_0.x * -2.0) + 3.0));
(_u_xlat16_0.x = (_u_xlat16_0.x * _u_xlat16_0.x));
(_u_xlat16_0.x = (_u_xlat16_0.x * _u_xlat16_8.x));
(_u_xlat1.xy = (_u_xlat16_0.xx * _u_xlat4.xy));
uint s973 = {0};
if ((0.0 < _Refraction.x))
{
(s973 = 4294967295);
}
else
{
(s973 = 0);
}
(_u_xlati17 = int(s973));
uint s974 = {0};
if ((_Refraction.x < 0.0))
{
(s974 = 4294967295);
}
else
{
(s974 = 0);
}
(_u_xlati25 = int(s974));
(_u_xlati17 = ((-_u_xlati17) + _u_xlati25));
(_u_xlat16_5.x = float(_u_xlati17));
(_u_xlat16_5.y = -1.0);
(_u_xlatb17.xy = (float4(0.5, 0.5, 0.5, 0.5) < _vs_TEXCOORD0.zzzz).xy);
float2 s975 = {0, 0};
if (_u_xlatb17.x)
{
(s975 = float2(1.0, -1.0));
}
else
{
(s975 = _u_xlat16_5.xy);
}
(_u_xlat16_8.xy = s975);
float4 s976 = {0, 0, 0, 0};
if (_u_xlatb17.y)
{
(s976 = _ColorLeft);
}
else
{
(s976 = _ColorRight);
}
(_u_xlat16_4 = s976);
(_u_xlat1.xy = (_u_xlat16_8.xy * _u_xlat1.xy));
(_u_xlat16_8.x = dot(_vs_TEXCOORD5.xyz, _vs_TEXCOORD5.xyz));
(_u_xlat16_8.x = rsqrt(_u_xlat16_8.x));
(_u_xlat16_8.xyz = (_u_xlat16_8.xxx * _vs_TEXCOORD5.xyz));
(_u_xlat16_8.x = dot(_vs_TEXCOORD11.xyz, _u_xlat16_8.xyz));
(_u_xlat16_8.x = clamp(_u_xlat16_8.x, 0.0, 1.0));
(_u_xlat16_8.x = ((-_u_xlat16_8.x) + 1.0));
(_u_xlat1.xy = (_u_xlat16_8.xx * _u_xlat1.xy));
(_u_xlat16_8.xy = (_u_xlat16_0.xx * _u_xlat1.xy));
(_u_xlat16_5.xy = ((_u_xlat16_10.xy * float2(_u_xlat26.xx)) + _u_xlat16_8.xy));
(_u_xlat16_8.xy = ((abs(_Refraction.xx) * _u_xlat16_8.xy) + _u_xlat3.xw));
(_u_xlat1.xy = (_u_xlat16_8.xy + float2(0.5, 0.5)));
(_u_xlat16_8.x = dot(_u_xlat16_5.xy, _u_xlat16_5.xy));
(_u_xlat16_8.x = sqrt(_u_xlat16_8.x));
(_u_xlat16_0.x = (_u_xlat16_0.x * _u_xlat16_8.x));
(_u_xlat16_0.x = (_u_xlat16_0.x * 4.0));
(_u_xlat16_0.x = log2(_u_xlat16_0.x));
(_u_xlat16_0.x = (_u_xlat16_0.x * _CombinedProps4.x));
(_u_xlat16_0.x = exp2(_u_xlat16_0.x));
(_u_xlat16_2.xyz = (_u_xlat16_4.xyz * float3(0.5, 0.5, 0.5)));
(_u_xlat16_8.xyz = (_u_xlat16_4.www * _u_xlat16_4.xyz));
(_u_xlat16_2.xyz = (_u_xlat16_0.xxx * _u_xlat16_2.xyz));
(_u_xlat16_2.xyz = (_u_xlat16_2.xyz * _CombinedProps4.yyy));
(_u_xlat16_0.x = dot(_vs_TEXCOORD4.xyz, _vs_TEXCOORD4.xyz));
(_u_xlat16_0.x = rsqrt(_u_xlat16_0.x));
(_u_xlat16_0.x = (_u_xlat16_0.x * _vs_TEXCOORD4.z));
(_u_xlat16_0.x = clamp(_u_xlat16_0.x, 0.0, 1.0));
(_u_xlat16_17 = ((-_u_xlat16_0.x) + 1.0));
(_u_xlat16_25 = ((_u_xlat16_0.x * 1.3) + 0.1));
(_u_xlat16_2.xyz = (float3(_u_xlat16_17.xxx) * _u_xlat16_2.xyz));
(_u_xlat16_0.x = log2(_u_xlat16_17));
(_u_xlat16_0.x = (_u_xlat16_0.x * _CombinedProps1.y));
(_u_xlat16_0.x = exp2(_u_xlat16_0.x));
(_u_xlat16_5.x = dot((-_vs_TEXCOORD5.xyz), _vs_TEXCOORD8.xyz));
(_u_xlat16_5.x = (_u_xlat16_5.x + _u_xlat16_5.x));
(_u_xlat16_5.xyz = ((_vs_TEXCOORD8.xyz * (-_u_xlat16_5.xxx)) + (-_vs_TEXCOORD5.xyz)));
(_u_xlat16_3.xyw = gl_textureCube(_Cube, _u_xlat16_5.xyz).xyz);
(_u_xlat16_17 = dot(_u_xlat16_3.xyw, float3(0.11799999, 0.060000002, 0.022)));
(_u_xlat16_3.xyw = ((_u_xlat16_3.xyw * float3(0.2, 0.2, 0.2)) + (-float3(_u_xlat16_17.xxx))));
(_u_xlat16_3.xyw = ((_u_xlat16_3.xyw * float3(0.30000001, 0.30000001, 0.30000001)) + float3(_u_xlat16_17.xxx)));
(_u_xlatb17.x = (_HDRTexEnable < 0.5));
(_u_xlat26 = (_CombinedProps1.x * 0.25));
float s977 = {0};
if (_u_xlatb17.x)
{
(s977 = _CombinedProps1.x);
}
else
{
(s977 = _u_xlat26);
}
(_u_xlat17 = s977);
(_u_xlat16_5.xyz = ((_u_xlat16_3.xyw * float3(_u_xlat17.xxx)) + _u_xlat16_0.xxx));
(_u_xlat16_5.xyz = ((_u_xlat16_2.xyz * float3(10.0, 10.0, 10.0)) + _u_xlat16_5.xyz));
(_u_xlat16_2.xy = SAMPLE_TEXTURE2D_X(_Masks, sampler_Masks, _u_xlat1.xy).yz);
(_u_xlat16_5.xyz = (_u_xlat16_2.xxx * _u_xlat16_5.xyz));
(_u_xlat16_0.x = (_vs_TEXCOORD9.x * 10.0));
(_u_xlat16_0.x = clamp(_u_xlat16_0.x, 0.0, 1.0));
(_u_xlat16_17 = (_u_xlat16_0.x + 0.64999998));
(_u_xlat16_17 = min(_u_xlat16_17, 1.0));
(_u_xlat16_6.xyz = ((_LightColor0.xyz * _CharacterLightColor.www) + _CharacterLightColor.xyz));
(_u_xlat16_0.x = dot(_u_xlat16_6.xyz, float3(0.30000001, 0.58999997, 0.11)));
(_u_xlat16_0.x = (_u_xlat16_17 * _u_xlat16_0.x));
(_u_xlat16_29 = _u_xlat16_0.x);
(_u_xlat16_29 = clamp(_u_xlat16_29, 0.0, 1.0));
(_u_xlat16_5.xyz = (_u_xlat16_5.xyz * float3(_u_xlat16_29.xxx)));
(_u_xlat16_2.xzw = SAMPLE_TEXTURE2D_X(_MainRightTex, sampler_MainRightTex, _u_xlat1.xy).xyz);
(_u_xlat16_1.xyz = SAMPLE_TEXTURE2D_X(_MainTex, sampler_MainTex, _u_xlat1.xy).xyz);
(_u_xlat16_2.xzw = ((-_u_xlat16_1.xyz) + _u_xlat16_2.xzw));
(_u_xlat1.xyz = ((float3(_u_xlat19.xxx) * _u_xlat16_2.xzw) + _u_xlat16_1.xyz));
(_u_xlat16_29 = ((-_u_xlat16_2.y) + 1.0));
(_u_xlat16_6.x = (_CombinedProps2.y * _CombinedProps4.z));
(_u_xlat16_29 = (_u_xlat16_29 * _u_xlat16_6.x));
(_u_xlat16_8.xyz = ((_u_xlat16_8.xyz * _u_xlat16_2.yyy) + float3(_u_xlat16_29.xxx)));
(_u_xlat16_8.xyz = (_u_xlat16_8.xyz * _u_xlat1.xyz));
(_u_xlat16_0.xyz = (_u_xlat16_0.xxx * _u_xlat16_8.xyz));
(_u_xlat16_0.xyz = ((_u_xlat16_0.xyz * float3(_u_xlat16_25.xxx)) + _u_xlat16_5.xyz));
(_u_xlat16_0.xyz = (_u_xlat16_0.xyz * float3(_CharacterEyeLightScale.xxx)));
(_u_xlat16_1.x = SAMPLE_TEXTURE2D_X(_AutoExposureTex, sampler_AutoExposureTex, float2(0.5, 0.5)).x);
(_u_xlat16_1.x = (_u_xlat16_1.x * 5.0));
(_u_xlat16_1.x = clamp(_u_xlat16_1.x, 0.0, 1.0));
(_u_xlat16_9 = ((_AutoExposure_Intensity * -0.30000001) + 1.0));
(_u_xlat16_9 = (1.0 / _u_xlat16_9));
(_u_xlat16_17 = (_AutoExposure_Intensity + 1.0));
(_u_xlat16_17 = (1.0 / _u_xlat16_17));
(_u_xlat16_9 = ((-_u_xlat16_17) + _u_xlat16_9));
(_u_xlat16_1.x = ((_u_xlat16_1.x * _u_xlat16_9) + _u_xlat16_17));
(_u_xlat16_0.xyz = (_u_xlat16_0.xyz * _u_xlat16_1.xxx));
(_u_xlat16_5.xyz = (_u_xlat16_0.xyz * float3(float3(_AutoExposure, _AutoExposure, _AutoExposure))));
(_u_xlat16_24 = (((-_vs_TEXCOORD12.y) * _FogInfo2.w) + _FogInfo2.z));
(_u_xlat16_24 = clamp(_u_xlat16_24, 0.0, 1.0));
(_u_xlat16_6.xyz = ((-_FogColor1.xyz) + _FogColor2.xyz));
(_u_xlat16_6.xyz = ((float3(_u_xlat16_24.xxx) * _u_xlat16_6.xyz) + _FogColor1.xyz));
(_u_xlat16_24 = dot(_u_xlat16_6.xyz, float3(0.30000001, 0.58999997, 0.11)));
(_u_xlat16_7.xyz = ((float3(_u_xlat16_24.xxx) * _FogInfo4.yyy) + (-_u_xlat16_6.xyz)));
(_u_xlat16_24 = (_vs_TEXCOORD12.w * _FogInfo4.x));
(_u_xlat16_6.xyz = ((float3(_u_xlat16_24.xxx) * _u_xlat16_7.xyz) + _u_xlat16_6.xyz));
(_u_xlat16_24 = dot((-_WorldSpaceLightPos0.xyz), _vs_TEXCOORD12.xyz));
(_u_xlat16_24 = clamp(_u_xlat16_24, 0.0, 1.0));
(_u_xlat16_24 = (_u_xlat16_24 * _u_xlat16_24));
(_u_xlat16_7.xyz = (_FogInfo3.zzz * _FogColor3.xyz));
(_u_xlat16_6.xyz = ((_u_xlat16_7.xyz * float3(_u_xlat16_24.xxx)) + _u_xlat16_6.xyz));
(_u_xlat16_1.x = ((-_vs_TEXCOORD12.w) + 1.0));
(_u_xlat16_1.xyz = ((_u_xlat16_5.xyz * _u_xlat16_1.xxx) + _u_xlat16_6.xyz));
(_u_xlat16_1.xyz = (((-_u_xlat16_0.xyz) * float3(float3(_AutoExposure, _AutoExposure, _AutoExposure))) + _u_xlat16_1.xyz));
(_u_xlat16_1.xyz = ((_vs_TEXCOORD12.www * _u_xlat16_1.xyz) + _u_xlat16_5.xyz));
(_u_xlat16_25 = (((-_DarkCharacterScale) * _DarkCharacterCtrl) + 1.0));
(_u_xlat16_1.xyz = (float3(_u_xlat16_25.xxx) * _u_xlat16_1.xyz));
(out_SV_Target0.xyz = _u_xlat16_1.xyz);
(out_SV_Target0.w = _Alpha);
// return generateOutput();
return out_SV_Target0;
}