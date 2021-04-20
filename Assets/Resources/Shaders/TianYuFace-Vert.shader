//Face vert shader

#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "Packages/com.unity.render-pipelines.universal/Shaders/PostProcessing/Common.hlsl"

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1

#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif

#define UNITY_SUPPORTS_UNIFORM_LOCATION 1

#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif


uniform 	vec3 _PlatformPosition;
uniform 	vec4 _PlatformRotation;
uniform 	half4 _FogInfo;
uniform 	half4 _FogInfo2;
uniform 	half4 _FogInfo3;

#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerCamera {
#endif
	UNITY_UNIFORM vec4 _Time;
	UNITY_UNIFORM vec4 _SinTime;
	UNITY_UNIFORM vec4 _CosTime;
	UNITY_UNIFORM vec4 unity_DeltaTime;

	UNITY_UNIFORM vec3 _WorldSpaceCameraPos;
	UNITY_UNIFORM vec4 _ProjectionParams;
	UNITY_UNIFORM vec4 _ScreenParams;
	UNITY_UNIFORM vec4 _ZBufferParams;
	UNITY_UNIFORM vec4 unity_OrthoParams;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif

#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityLighting {
#endif
	UNITY_UNIFORM half4 _WorldSpaceLightPos0;
	UNITY_UNIFORM vec4 _LightPositionRange;
	UNITY_UNIFORM vec4 _LightProjectionParams;
	UNITY_UNIFORM vec4 unity_4LightPosX0;
	UNITY_UNIFORM vec4 unity_4LightPosY0;
	UNITY_UNIFORM vec4 unity_4LightPosZ0;
	UNITY_UNIFORM half4 unity_4LightAtten0;
	UNITY_UNIFORM half4 unity_LightColor[8];
	UNITY_UNIFORM vec4 unity_LightPosition[8];
	UNITY_UNIFORM half4 unity_LightAtten[8];
	UNITY_UNIFORM vec4 unity_SpotDirection[8];
	UNITY_UNIFORM half4 unity_SHAr;
	UNITY_UNIFORM half4 unity_SHAg;
	UNITY_UNIFORM half4 unity_SHAb;
	UNITY_UNIFORM half4 unity_SHBr;
	UNITY_UNIFORM half4 unity_SHBg;
	UNITY_UNIFORM half4 unity_SHBb;
	UNITY_UNIFORM half4 unity_SHC;
	UNITY_UNIFORM half4 unity_OcclusionMaskSelector;
	UNITY_UNIFORM half4 unity_ProbesOcclusion;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif

#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(4) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 unity_LODFade;
	UNITY_UNIFORM vec4 unity_WorldTransformParams;
	UNITY_UNIFORM vec4 unity_RenderingLayer;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif


#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(5) uniform UnityPerFrame {
#endif
	UNITY_UNIFORM half4 glstate_lightmodel_ambient;
	UNITY_UNIFORM half4 unity_AmbientSky;
	UNITY_UNIFORM half4 unity_AmbientEquator;
	UNITY_UNIFORM half4 unity_AmbientGround;
	UNITY_UNIFORM half4 unity_IndirectSpecColor;
	UNITY_UNIFORM vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_MatrixV[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
	UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_MatrixVP[4];
	UNITY_UNIFORM int unity_StereoEyeIndex;
	UNITY_UNIFORM half4 unity_ShadowColor;
	UNITY_UNIFORM vec4 unity_DynamicResolutionParams;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif


// in float4 in_POSITION0;
// in float4 in_TANGENT0;
// in float3 in_NORMAL0;
// in float4 in_TEXCOORD0;
// in float4 in_TEXCOORD1;

struct AppdataIn
{
    float4 positionOS   : POSITION;
    float4 tangentOS    : TANGENT;
    float3 normalOS     : NORMAL;
    float4 texcoord0    : TEXCOORD0;
    float4 texcoord1    : TEXCOORD1;
};


// out float4 vs_TEXCOORD0;
// out float4 vs_TEXCOORD1;
// out float4 vs_TEXCOORD2;
// out half4 vs_TEXCOORD3;
// out half4 vs_TEXCOORD4;
// out mediump vec3 vs_TEXCOORD5;
// out mediump vec3 vs_TEXCOORD6;
// out float4 vs_TEXCOORD7;

struct v2f
{
    float4  positionCS  :   SV_POSITION;
    
    float4  tangentWS   :   TEXCOORD0;
    float4  bitangentWS  :   TEXCOORD1;
    float4  normalWS   :   TEXCOORD2;

    float4  texcoord   :   TEXCOORD3; //xy: diffuse texcoord; zw: lightmap texcoord;
    float4  texcoord4   :   TEXCOORD4;
    half3   texcoord5   :   TEXCOORD5;
    half3   texcoord6   :   TEXCOORD6;
    half4   texcoord7   :   TEXCOORD7;
};


// vec4 u_xlat0;
// half4 u_xlat16_0;
// vec4 u_xlat1;
// vec4 u_xlat2;
// vec4 u_xlat3;
// vec3 u_xlat4;
// mediump float u_xlat16_5;
// mediump vec3 u_xlat16_6;
// float u_xlat7;
// float u_xlat21;


v2f vert(AppdataIn input)
{
    v2f output = (v2f)0;
    // u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    // u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    // u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    // u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    // u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    // u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    // u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    // u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    // gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;

    //u_xlat0 positionWS
    output.positionCS = TransformObjectToHClip(input.positionOS.xyz);

    u_xlat1.xyz = u_xlat1.www * u_xlat1.xyz;
    vs_TEXCOORD0.w = u_xlat0.x;
    
    // u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    // u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    // u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    // u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    // u_xlat21 = inversesqrt(u_xlat21);
    // u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;

    u_xlat2.xyz = TransformObjectToWorldDir(input.tangentOS.xyz); //tangentWS

    vs_TEXCOORD0.x = u_xlat2.z;

    // u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    // u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    // u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    // u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    // u_xlat21 = inversesqrt(u_xlat21);
    // u_xlat3 = vec4(u_xlat21) * u_xlat3.xyzz;

    u_xlat3 = TransformObjectToWorldNormal(input.normalOS); //normalWS


    // u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
    // u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
    // u_xlat21 = in_TANGENT0.w * unity_WorldTransformParams.w;
    // u_xlat4.xyz = vec3(u_xlat21) * u_xlat4.xyz;


    // vs_TEXCOORD0.y = u_xlat4.x;
    // vs_TEXCOORD0.z = u_xlat3.x;
    // vs_TEXCOORD1.x = u_xlat2.x;
    // vs_TEXCOORD2.x = u_xlat2.y;
    // vs_TEXCOORD1.w = u_xlat0.y;
    // vs_TEXCOORD1.y = u_xlat4.y;
    // vs_TEXCOORD2.y = u_xlat4.z;
    // vs_TEXCOORD1.z = u_xlat3.y;
    // vs_TEXCOORD2.w = u_xlat0.z;
    // vs_TEXCOORD2.z = u_xlat3.w;

    //viewDirWS
    // u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    // vs_TEXCOORD5.xyz = u_xlat0.xyz;


    VertexNormalInputs tbn = GetVertexNormalInputs(input.normalOS, input.tangentOS);
    output.tangentWS = tbn.tangentWS;
    output.bitangentWS = tbn.bitangentWS;
    output.normalWS = tbn.normalWS;
    
    // u_xlat0.xy = in_TEXCOORD0.xy;
    // u_xlat0.zw = in_TEXCOORD1.xy;
    // vs_TEXCOORD3 = u_xlat0;
    output.texcoord = float4(input.texcoord0.xy, input.texcoord1.xy);


    //u_xlat1 : world pos
    u_xlat0.xyz = u_xlat1.zxy * _PlatformRotation.xyz;
    u_xlat0.xyz = _PlatformRotation.zxy * u_xlat1.xyz + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat1.yzx * _PlatformRotation.www + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz * _PlatformRotation.zxy;
    u_xlat0.xyz = _PlatformRotation.yzx * u_xlat0.yzx + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + _PlatformPosition.xyz;
    u_xlat0.xzw = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = (-u_xlat0.y) * _FogInfo2.y + _FogInfo2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat7 * u_xlat7;
    u_xlat7 = u_xlat7 * u_xlat7;
    u_xlat7 = u_xlat7 * _FogInfo.y;
    u_xlat1.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat0.xzw = u_xlat0.xzw / u_xlat1.xxx;
    u_xlat1.x = u_xlat1.x + (-_FogInfo.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    vs_TEXCOORD4.xyz = u_xlat0.xzw;
    u_xlat16_5 = _FogInfo.y * _FogInfo.z;
    u_xlat0.x = max(u_xlat7, u_xlat16_5);
    u_xlat0.x = u_xlat0.x * (-u_xlat1.x);
    u_xlat0.x = u_xlat0.x * 1.44269502;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat7 = u_xlat0.x * _FogInfo.w + (-_FogInfo.w);
    u_xlat7 = u_xlat7 + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat7;
    vs_TEXCOORD4.w = min(u_xlat0.x, _FogInfo3.w);
    u_xlat16_5 = u_xlat3.y * u_xlat3.y;
    u_xlat16_5 = u_xlat3.x * u_xlat3.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat3.ywzx * u_xlat3;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD6.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}