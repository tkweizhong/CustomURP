#include "TianyuModelCommon.hlsl"

// struct VS_OUTPUT
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

// struct VS_OUTPUT
// {
//     float4 PositionCS : SV_Position;
//     // float4 gl_Position : TEXCOORD7;
//     float4 v0 : TEXCOORD0;
//     float3 v1 : TEXCOORD1;
//     float3 v2 : TEXCOORD2;
//     float3 v3 : TEXCOORD3;
//     float3 v4 : TEXCOORD4;
//     float3 v5 : TEXCOORD5;
//     float3 v6 : TEXCOORD6;
// };


// bool bool_ctor(bool x0)
// {
//     return bool(x0);
// }
// float2 vec2_ctor(float x0)
// {
//     return float2(x0, x0);
// }
// float3 vec3_ctor(float x0)
// {
//     return float3(x0, x0, x0);
// }
// Uniforms

// uniform float3 _PlatformPosition : register(c1);
// uniform float4 _PlatformRotation : register(c2);
// uniform float4 _FogInfo : register(c3);
// uniform float4 _FogInfo2 : register(c4);
// uniform float4 _FogInfo3 : register(c5);
// uniform float3 _CharacterLightDir : register(c6);
// uniform float4 _CombinedProps0 : register(c7);
// uniform float4 _CombinedProps3 : register(c8);
// Uniform Blocks
 
// cbuffer UnityPerCamera : register(b2)
// {
//     float4 _Time;
//     float4 _SinTime;
//     float4 _CosTime;
//     float4 _unity_DeltaTime;
//     float3 _WorldSpaceCameraPos;
//     float4 _ProjectionParams;
//     float4 _ScreenParams;
//     float4 _ZBufferParams;
//     float4 _unity_OrthoParams;
// };

// cbuffer UnityPerDraw : register(b3)
// {
//     float4 _hlslcc_mtx4x4unity_ObjectToWorld[4];
//     float4 _hlslcc_mtx4x4unity_WorldToObject[4];
//     float4 _unity_LODFade;
//     float4 _unity_WorldTransformParams;
//     float4 _unity_RenderingLayer;
// };

// cbuffer UnityPerFrame : register(b4)
// {
//     float4 _glstate_lightmodel_ambient;
//     float4 _unity_AmbientSky;
//     float4 _unity_AmbientEquator;
//     float4 _unity_AmbientGround;
//     float4 _unity_IndirectSpecColor;
//     float4 _hlslcc_mtx4x4glstate_matrix_projection[4];
//     float4 _hlslcc_mtx4x4unity_MatrixV[4];
//     float4 _hlslcc_mtx4x4unity_MatrixInvV[4];
//     float4 _hlslcc_mtx4x4unity_MatrixVP[4];
//     int _unity_StereoEyeIndex;
//     float4 _unity_ShadowColor;
//     float4 _unity_DynamicResolutionParams;
// };

#ifdef ANGLE_ENABLE_LOOP_FLATTEN
#define LOOP [loop]
#define FLATTEN [flatten]
#else
#define LOOP
#define FLATTEN
#endif

#define ATOMIC_COUNTER_ARRAY_STRIDE 4

// Attributes
// static float4 _in_POSITION0 = {0, 0, 0, 0};
// static float4 _in_TANGENT0 = {0, 0, 0, 0};
// static float3 _in_NORMAL0 = {0, 0, 0};
// static float4 _in_TEXCOORD0 = {0, 0, 0, 0};
// static float4 _in_TEXCOORD1 = {0, 0, 0, 0};

static float4 gl_Position = float4(0, 0, 0, 0);

// // Varyings
static  float3 _vs_TEXCOORD0 = {0, 0, 0};
static  float3 _vs_TEXCOORD2 = {0, 0, 0};
static  float3 _vs_TEXCOORD4 = {0, 0, 0};
static  float3 _vs_TEXCOORD5 = {0, 0, 0};
static  float3 _vs_TEXCOORD6 = {0, 0, 0};
static  float3 _vs_TEXCOORD7 = {0, 0, 0};
static  float3 _vs_TEXCOORD8 = {0, 0, 0};
static  float3 _vs_TEXCOORD9 = {0, 0, 0};
static  float3 _vs_TEXCOORD10 = {0, 0, 0};
static  float3 _vs_TEXCOORD11 = {0, 0, 0};
static  float4 _vs_TEXCOORD12 = {0, 0, 0, 0};

cbuffer DriverConstants : register(b1)
{
    float4 dx_ViewAdjust : packoffset(c1);
    float2 dx_ViewCoords : packoffset(c2);
    float2 dx_ViewScale  : packoffset(c3);
};

static float4 _u_xlat0 = {0, 0, 0, 0};
static float4 _u_xlat1 = {0, 0, 0, 0};
static float4 _u_xlat2 = {0, 0, 0, 0};
static float4 _u_xlat16_3 = {0, 0, 0, 0};
static float3 _u_xlat4 = {0, 0, 0};
static float _u_xlat5 = {0};
static float3 _u_xlat16_8 = {0, 0, 0};
static float _u_xlat15 = {0};
static bool _u_xlatb15 = false;
static float _u_xlat16 = {0};
static float _u_xlat16_18 = {0};

// struct VS_INPUT
// {
//     float4 _in_POSITION0 : TEXCOORD0;
//     float4 _in_TANGENT0 : TEXCOORD1;
//     float3 _in_NORMAL0 : TEXCOORD2;
//     float4 _in_TEXCOORD0 : TEXCOORD3;
//     float4 _in_TEXCOORD1 : TEXCOORD4;
// };


// void initAttributes(VS_INPUT input)
// {
//     _in_POSITION0 = input._in_POSITION0;
//     _in_TANGENT0 = input._in_TANGENT0;
//     _in_NORMAL0 = input._in_NORMAL0;
//     _in_TEXCOORD0 = input._in_TEXCOORD0;
//     _in_TEXCOORD1 = input._in_TEXCOORD1;
// }


v2f generateOutput(TianyuAppdata input)
{
    v2f output;
    output.PositionCS = gl_Position;
    // output.gl_Position = gl_Position;
    // output.dx_Position.x = gl_Position.x;
    // output.dx_Position.y = - gl_Position.y;
    // output.dx_Position.z = (gl_Position.z + gl_Position.w) * 0.5;
    // output.dx_Position.w = gl_Position.w;
    output.v0 = _vs_TEXCOORD12;
    output.v1 = _vs_TEXCOORD0;
    output.v2 = _vs_TEXCOORD4;
    output.v3 = _vs_TEXCOORD5;
    output.v4 = _vs_TEXCOORD8;
    output.v5 = _vs_TEXCOORD9;
    output.v6 = _vs_TEXCOORD11;

    return output;
}

v2f vert(TianyuAppdata input)
{
    // initAttributes(input);

    v2f output = (v2f)0;

(_u_xlat0 = (input.PositionOS.yyyy * unity_ObjectToWorld[1]));
(_u_xlat0 = ((unity_ObjectToWorld[0] * input.PositionOS.xxxx) + _u_xlat0));
(_u_xlat0 = ((unity_ObjectToWorld[2] * input.PositionOS.zzzz) + _u_xlat0));
(_u_xlat1 = (_u_xlat0 + unity_ObjectToWorld[3]));
(_u_xlat0.xyz = ((unity_ObjectToWorld[3].xyz * input.PositionOS.www) + _u_xlat0.xyz));

(_u_xlat2 = (_u_xlat1.yyyy * unity_MatrixVP[1]));
(_u_xlat2 = ((unity_MatrixVP[0] * _u_xlat1.xxxx) + _u_xlat2));
(_u_xlat2 = ((unity_MatrixVP[2] * _u_xlat1.zzzz) + _u_xlat2));
(gl_Position = ((unity_MatrixVP[3] * _u_xlat1.wwww) + _u_xlat2));

// float4 positionWS = mul(unity_ObjectToWorld, input.PositionOS);
// output.PositionCS = mul(unity_MatrixVP, positionWS);
// _u_xlat1 = positionWS;

(_u_xlat1.xyz = (_u_xlat1.www * _u_xlat1.xyz));
(_u_xlat2.xy = (input.Texcoord0.xy + float2(-0.5, -0.5)));
(_u_xlat16_3.x = dot(_u_xlat2.xy, _u_xlat2.xy));
(_u_xlat15 = max(_u_xlat16_3.x, 0.001));
(_u_xlat16_3.x = sqrt(_u_xlat16_3.x));
(_u_xlat16_8.x = rsqrt(_u_xlat15));
(_u_xlat16_8.xy = (_u_xlat2.xy * _u_xlat16_8.xx));
(_u_xlatb15 = (0.5 >= input.Texcoord1.x));
float s956 = {0};
if (_u_xlatb15)
{
(s956 = 1.0);
}
else
{
(s956 = 0.0);
}
(_u_xlat15 = s956);
(_u_xlat16 = ((-_CombinedProps0.x) + _CombinedProps3.x));
(_u_xlat15 = ((_u_xlat15 * _u_xlat16) + _CombinedProps0.x));
(_u_xlat15 = max(_u_xlat15, 0.001));
(_u_xlat15 = (_CombinedProps0.z / _u_xlat15));
(_u_xlat16 = max(_u_xlat15, 0.001));
(_u_xlat16 = (_u_xlat16_3.x / _u_xlat16));
(_u_xlat16 = (_u_xlat16 * _CombinedProps0.z));
(_u_xlat2.xy = (_u_xlat16_8.xy * float2(_u_xlat16.xx)));
(_u_xlat16_18 = ((-_u_xlat15) + _u_xlat16_3.x));
(_u_xlatb15 = (_u_xlat15 >= _u_xlat16_3.x));
(_u_xlat16_3.x = ((-_CombinedProps0.z) + 1.0));
(_u_xlat16_3.x = ((_u_xlat16_18 * _u_xlat16_3.x) + _CombinedProps0.z));
(_u_xlat16_3.xy = (_u_xlat16_8.xy * _u_xlat16_3.xx));
float2 s957 = {0, 0};
if (_u_xlatb15)
{
(s957 = _u_xlat2.xy);
}
else
{
(s957 = _u_xlat16_3.xy);
}
(_u_xlat2.xy = s957);
(_u_xlat2.xy = (_u_xlat2.xy + float2(0.5, 0.5)));
(_u_xlat2.z = input.Texcoord1.x);
(_vs_TEXCOORD0.xyz = _u_xlat2.xyz);
(_vs_TEXCOORD2.xyz = _u_xlat0.xyz);
(_u_xlat0.xyz = ((-_u_xlat0.xyz) + _WorldSpaceCameraPos.xyz));
(_vs_TEXCOORD5.xyz = _u_xlat0.xyz);
(_u_xlat0.x = dot(input.NormalOS.xyz, input.NormalOS.xyz));
(_u_xlat0.x = rsqrt(_u_xlat0.x));
(_u_xlat0.xyz = (_u_xlat0.xxx * input.NormalOS.zxy));
(_u_xlat15 = dot(input.TangentOS.xyz, input.TangentOS.xyz));
(_u_xlat15 = rsqrt(_u_xlat15));
(_u_xlat2.xyz = (float3(_u_xlat15.xxx) * input.TangentOS.yzx));
(_u_xlat4.xyz = (_u_xlat0.xyz * _u_xlat2.xyz));
(_u_xlat0.xyz = ((_u_xlat0.zxy * _u_xlat2.yzx) + (-_u_xlat4.xyz)));
(_u_xlat0.xyz = (_u_xlat0.xyz * input.TangentOS.www));
(_u_xlat2.xyz = (_WorldSpaceCameraPos.yyy * unity_WorldToObject[1].xyz));
(_u_xlat2.xyz = ((unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx) + _u_xlat2.xyz));
(_u_xlat2.xyz = ((unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz) + _u_xlat2.xyz));
(_u_xlat2.xyz = (_u_xlat2.xyz + unity_WorldToObject[3].xyz));
(_u_xlat2.xyz = (_u_xlat2.xyz + (-input.PositionOS.xyz)));
(_u_xlat0.y = dot(_u_xlat0.xyz, _u_xlat2.xyz));
(_u_xlat0.x = dot(input.TangentOS.xyz, _u_xlat2.xyz));
(_u_xlat0.z = dot(input.NormalOS.xyz, _u_xlat2.xyz));
(_vs_TEXCOORD4.xyz = _u_xlat0.xyz);
(_u_xlat0.xyz = (input.TangentOS.yyy * unity_ObjectToWorld[1].xyz));
(_u_xlat0.xyz = ((unity_ObjectToWorld[0].xyz * input.TangentOS.xxx) + _u_xlat0.xyz));
(_u_xlat0.xyz = ((unity_ObjectToWorld[2].xyz * input.TangentOS.zzz) + _u_xlat0.xyz));
(_u_xlat0.xyz = ((unity_ObjectToWorld[3].xyz * input.TangentOS.www) + _u_xlat0.xyz));
(_u_xlat15 = dot(_u_xlat0.xyz, _u_xlat0.xyz));
(_u_xlat15 = rsqrt(_u_xlat15));
(_u_xlat0.xyz = (float3(_u_xlat15.xxx) * _u_xlat0.xyz));
(_vs_TEXCOORD6.xyz = _u_xlat0.xyz);
(_u_xlat2.x = dot(input.NormalOS.xyz, unity_WorldToObject[0].xyz));
(_u_xlat2.y = dot(input.NormalOS.xyz, unity_WorldToObject[1].xyz));
(_u_xlat2.z = dot(input.NormalOS.xyz, unity_WorldToObject[2].xyz));
(_u_xlat15 = dot(_u_xlat2.xyz, _u_xlat2.xyz));
(_u_xlat15 = rsqrt(_u_xlat15));
(_u_xlat2.xyz = ((_u_xlat15) * _u_xlat2.xyz));
(_u_xlat16_3.xyz = (_u_xlat0.yzx * _u_xlat2.zxy));
(_u_xlat16_3.xyz = ((_u_xlat2.yzx * _u_xlat0.zxy) + (-_u_xlat16_3.xyz)));
(_vs_TEXCOORD8.xyz = _u_xlat2.xyz);
(_u_xlat0.xyz = (_u_xlat16_3.xyz * input.TangentOS.www));
(_vs_TEXCOORD7.xyz = _u_xlat0.xyz);
(_u_xlat0.x = (_CharacterLightDir.y * unity_WorldToObject[1].x));
(_u_xlat0.x = ((unity_WorldToObject[0].x * _CharacterLightDir.x) + _u_xlat0.x));
(_u_xlat0.x = ((unity_WorldToObject[2].x * _CharacterLightDir.z) + _u_xlat0.x));
(_vs_TEXCOORD9.xyz = (-_u_xlat0.xxx));
(_u_xlat0.xyz = (unity_ObjectToWorld[0].yyy * unity_MatrixV[1].xyz));
(_u_xlat0.xyz = ((unity_MatrixV[0].xyz * unity_ObjectToWorld[0].xxx) + _u_xlat0.xyz));
(_u_xlat0.xyz = ((unity_MatrixV[2].xyz * unity_ObjectToWorld[0].zzz) + _u_xlat0.xyz));
(_u_xlat0.xyz = ((unity_MatrixV[3].xyz * unity_ObjectToWorld[0].www) + _u_xlat0.xyz));
(_u_xlat15 = dot((-_u_xlat0.xyz), (-_u_xlat0.xyz)));
(_u_xlat15 = rsqrt(_u_xlat15));
(_u_xlat0.xyz = ((_u_xlat15) * (-_u_xlat0.xyz)));
(_vs_TEXCOORD10.xyz = _u_xlat0.xyz);
(_u_xlat0.x = dot((-unity_ObjectToWorld[0].xyz), (-unity_ObjectToWorld[0].xyz)));
(_u_xlat0.x = rsqrt(_u_xlat0.x));
(_u_xlat0.xyz = (_u_xlat0.xxx * (-unity_ObjectToWorld[0].xyz)));
(_vs_TEXCOORD11.xyz = _u_xlat0.xyz);
(_u_xlat0.xyz = (_u_xlat1.zxy * _PlatformRotation.xyz));
(_u_xlat0.xyz = ((_PlatformRotation.zxy * _u_xlat1.xyz) + (-_u_xlat0.xyz)));
(_u_xlat0.xyz = ((_u_xlat1.yzx * _PlatformRotation.www) + _u_xlat0.xyz));
(_u_xlat2.xyz = (_u_xlat0.xyz * _PlatformRotation.zxy));
(_u_xlat0.xyz = ((_PlatformRotation.yzx * _u_xlat0.yzx) + (-_u_xlat2.xyz)));
(_u_xlat0.xyz = ((_u_xlat0.xyz * float3(2.0, 2.0, 2.0)) + _u_xlat1.xyz));
(_u_xlat0.xyz = (_u_xlat0.xyz + _PlatformPosition.xyz));
(_u_xlat0.xzw = ((-_u_xlat0.xyz) + _WorldSpaceCameraPos.xyz));
(_u_xlat5 = (((-_u_xlat0.y) * _FogInfo2.y) + _FogInfo2.x));
(_u_xlat5 = clamp(_u_xlat5, 0.0, 1.0));
(_u_xlat5 = (_u_xlat5 * _u_xlat5));
(_u_xlat5 = (_u_xlat5 * _u_xlat5));
(_u_xlat5 = (_u_xlat5 * _FogInfo.y));
(_u_xlat1.x = dot(_u_xlat0.xzw, _u_xlat0.xzw));
(_u_xlat1.x = sqrt(_u_xlat1.x));
(_u_xlat0.xzw = (_u_xlat0.xzw / _u_xlat1.xxx));
(_u_xlat1.x = (_u_xlat1.x + (-_FogInfo.x)));
(_u_xlat1.x = max(_u_xlat1.x, 0.0));
(_vs_TEXCOORD12.xyz = _u_xlat0.xzw);
(_u_xlat16_3.x = (_FogInfo.y * _FogInfo.z));
(_u_xlat0.x = max(_u_xlat5, _u_xlat16_3.x));
(_u_xlat0.x = (_u_xlat0.x * (-_u_xlat1.x)));
(_u_xlat0.x = (_u_xlat0.x * 1.442695));
(_u_xlat0.x = exp2(_u_xlat0.x));
(_u_xlat0.x = ((-_u_xlat0.x) + 1.0));
(_u_xlat5 = ((_u_xlat0.x * _FogInfo.w) + (-_FogInfo.w)));
(_u_xlat5 = (_u_xlat5 + 1.0));
(_u_xlat0.x = (_u_xlat0.x / _u_xlat5));
(_vs_TEXCOORD12.w = min(_u_xlat0.x, _FogInfo3.w));

output = generateOutput(input);

return output; 
}