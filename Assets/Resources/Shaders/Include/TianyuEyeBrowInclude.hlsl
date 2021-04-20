#version 320 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

precision highp float;
precision highp int;
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
vec2 ImmCB_0_0_0[12];
uniform     mediump vec4 _MainColor;
uniform     mediump vec4 _CharacterSkinColorScale;
uniform     mediump vec4 _EyebrowTilingOffset;
uniform     mediump vec4 _EyebrowHSV;
uniform     mediump vec4 _HighlightColor;
uniform     mediump float _DarkCharacterScale;
uniform     mediump float _DarkCharacterCtrl;
uniform     mediump float _AutoExposure;
uniform     mediump float _AutoExposure_Intensity;
uniform     mediump float _OutputAlpha;
uniform     mediump vec4 _FogInfo2;
uniform     mediump vec4 _FogInfo3;
uniform     mediump vec4 _FogInfo4;
uniform     mediump vec4 _FogColor1;
uniform     mediump vec4 _FogColor2;
uniform     mediump vec4 _FogColor3;
uniform     mediump float _SoftShadowType;
uniform     vec4 hlslcc_mtx4x4_CustomShadowMatrix[4];
uniform     float _CustomShadowBias;
uniform     mediump float PANGU_CHARACTER_SOFT_SHADOW_SOFTNESS;
uniform     mediump vec3 _CharacterLightDir;
uniform     mediump float _VlmScale;
uniform     mediump float _VolumetricShadow;
uniform     mediump vec4 _SSSDiffParam;
uniform     mediump vec4 _SSSLightColor;
uniform     mediump vec4 _SSSSpecParam;
uniform     mediump vec4 _SSSPoreParam;
uniform     mediump float _LipCubeIntensity;
uniform     mediump float _HDRTexEnable;
uniform     mediump vec4 _FacialParams;
uniform     mediump vec4 _RimColor;
uniform     mediump float _RimPower;
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
    UNITY_UNIFORM mediump vec4 _WorldSpaceLightPos0;
    UNITY_UNIFORM vec4 _LightPositionRange;
    UNITY_UNIFORM vec4 _LightProjectionParams;
    UNITY_UNIFORM vec4 unity_4LightPosX0;
    UNITY_UNIFORM vec4 unity_4LightPosY0;
    UNITY_UNIFORM vec4 unity_4LightPosZ0;
    UNITY_UNIFORM mediump vec4 unity_4LightAtten0;
    UNITY_UNIFORM mediump vec4 unity_LightColor[8];
    UNITY_UNIFORM vec4 unity_LightPosition[8];
    UNITY_UNIFORM mediump vec4 unity_LightAtten[8];
    UNITY_UNIFORM vec4 unity_SpotDirection[8];
    UNITY_UNIFORM mediump vec4 unity_SHAr;
    UNITY_UNIFORM mediump vec4 unity_SHAg;
    UNITY_UNIFORM mediump vec4 unity_SHAb;
    UNITY_UNIFORM mediump vec4 unity_SHBr;
    UNITY_UNIFORM mediump vec4 unity_SHBg;
    UNITY_UNIFORM mediump vec4 unity_SHBb;
    UNITY_UNIFORM mediump vec4 unity_SHC;
    UNITY_UNIFORM mediump vec4 unity_OcclusionMaskSelector;
    UNITY_UNIFORM mediump vec4 unity_ProbesOcclusion;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(2) uniform UnityShadows {
#endif
    UNITY_UNIFORM vec4 unity_ShadowSplitSpheres[4];
    UNITY_UNIFORM vec4 unity_ShadowSplitSqRadii;
    UNITY_UNIFORM vec4 unity_LightShadowBias;
    UNITY_UNIFORM vec4 _LightSplitsNear;
    UNITY_UNIFORM vec4 _LightSplitsFar;
    UNITY_UNIFORM vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
    UNITY_UNIFORM mediump vec4 _LightShadowData;
    UNITY_UNIFORM vec4 unity_ShadowFadeCenterAndType;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(3) uniform VlmSH {
#endif
    UNITY_UNIFORM mediump vec4 _VlmValues[7];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _FaceMaskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(2) uniform mediump sampler2D _BumpMap;
UNITY_LOCATION(3) uniform mediump sampler2D _ParamTex;
UNITY_LOCATION(4) uniform mediump sampler2D _ParamTex2;
UNITY_LOCATION(5) uniform mediump sampler2D _EyebrowMask;
UNITY_LOCATION(6) uniform mediump samplerCube _Cube;
UNITY_LOCATION(7) uniform mediump sampler2D _PoreTex;
UNITY_LOCATION(8) uniform mediump sampler2D _CustomShadowTex;
UNITY_LOCATION(9) uniform mediump sampler2D _SSSTex;
UNITY_LOCATION(10) uniform mediump sampler2D _AutoExposureTex;
UNITY_LOCATION(11) uniform mediump sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
uniform mediump sampler2D _ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;


float4  Frag(Varyings input)
{
    ImmCB_0_0_0[0] = float2(0.0, 0.0);
    ImmCB_0_0_0[1] = float2(0.249529794, 0.732074976);
    ImmCB_0_0_0[2] = float2(-0.346920609, 0.643783629);
    ImmCB_0_0_0[3] = float2(-0.0187890902, 0.482739389);
    ImmCB_0_0_0[4] = float2(-0.272521287, 0.896188021);
    ImmCB_0_0_0[5] = float2(-0.681433618, 0.648048103);
    ImmCB_0_0_0[6] = float2(0.415204495, 0.279417187);
    ImmCB_0_0_0[7] = float2(0.1310554, 0.26759249);
    ImmCB_0_0_0[8] = float2(0.534474373, 0.562441111);
    ImmCB_0_0_0[9] = float2(0.838568926, 0.513734818);
    ImmCB_0_0_0[10] = float2(0.604505181, 0.0839385688);
    ImmCB_0_0_0[11] = float2(0.464316308, 0.868464172);

    float3 positionWS = float3(input.texcoord0.w, input.texcoord1.w，input.texcoord2.w);
    float3 viewDirWS = _WorldSpaceCameraPos.xyz - positionWS;
    float3 viewDirWSNormalize = SafeNormalize(viewDirWS);

    float2 uv = input.texcoord3.xy;
    half4 faceMask = SAMPLE_TEXTURE2D(_FaceMaskTex, sampler_FaceMaskTex, uv)
    half4 diffuseColor = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, uv);
    float4 normalTBNS = SAMPLE_TEXTURE2D(_BumpMap, sampler_BumpMap, uv);
    float4 normalTBNSNormalized.xy = normalTBNS.xy * 2f - 1f;
    float4 params1 = SAMPLE_TEXTURE2D(_ParamTex, sampler_ParamTex, uv);
    float2 params2 = SAMPLE_TEXTURE2D(_ParamTex2, sampler_ParamTex, uv).xw;

    float mask = (0.800000012<_FacialParams.z)? 0f : 1.0f;
    mask *= params2.g;
    float3 color1 = diffuseColor * _MainColor - diffuseColor;
    color1 = color1 * mask + diffuseColor;

    //Eyebrow: 眼睛额头处理;
    mask = (input.texcoord3.z<0.5) ? 1-input.texcoord3.z : input.texcoord3.z;
    float u = mask + _EyebrowTilingOffset.z：
    float v = input.texcoord3.w + _EyebrowTilingOffset.w;
    float2 eyeBrowUV = float2 (u, v) * _EyebrowTilingOffset.xy;
    float4 eyeBrowMask = SAMPLE_TEXTURE2D(_EyebrowMask, sampler_EyebrowMask, eyeBrowUV);
    float4 eyeBrowColor = eyeBrowMask * _MainColor;

    mask = (eyeBrowColor.y>=eyeBrowColor.z)?1.0 : 0;
    float2 color2 = eyeBrowMask.yz * _MainColor.yz - eyeBrowColor.zy;
    color2 *= mask;
    float4 color3 = 0;
    color3.xy = eyeBrowMask.zy * _MainColor.zy + color2.xy;
    color3.zw = mask * float2 (1f, -1f) + float2 (-1.0, 0.666666687);

// #ifdef UNITY_ADRENO_ES3
//     u_xlatb52 = !!(u_xlat16_9.x>=u_xlat16_11.x);
// #else
//     u_xlatb52 = u_xlat16_9.x>=u_xlat16_11.x;
// #endif
//     u_xlat16_56 = (u_xlatb52) ? 1.0 : 0.0;
    mask = (eyeBrowColor.x>=color3.x)? 1.0f : 0;

    // u_xlat16_10.xyz = (-u_xlat16_11.xyw);
    // u_xlat16_10.w = (-u_xlat16_9.x);
    float4 color4 = float4 (-eyeBrowColor.xyw, -color3.x);

    // u_xlat16_8.x = u_xlat16_8.x * _MainColor.x + u_xlat16_10.x;
    // u_xlat16_8.yzw = u_xlat16_10.yzw + u_xlat16_11.yzx;
    eyeBrowMask.x = eyeBrowMask.x * _MainColor.x + color4.x;
    eyeBrowMask.yzw = color4.yzw + eyeBrowColor.yzx;

    // u_xlat16_10.xyz = vec3(u_xlat16_56) * u_xlat16_8.xyz + u_xlat16_11.xyw;
    // u_xlat16_56 = u_xlat16_56 * u_xlat16_8.w + u_xlat16_9.x;
    // u_xlat16_58 = min(u_xlat16_10.y, u_xlat16_56);
    // u_xlat16_58 = (-u_xlat16_58) + u_xlat16_10.x;
    // u_xlat16_56 = (-u_xlat16_10.y) + u_xlat16_56;

    color4.xyz = mask * eyeBrowMask.xyz + eyeBrowColor.xyw;
    mask = mask * eyeBrowMask.w + color3.x;
    float t = min(color4.y, mask);
    t = color4.x - t;
    mask = mask - color4.y;

    // u_xlat16_52 = u_xlat16_58 * 6.0 + 9.99999975e-05;
    // u_xlat16_52 = u_xlat16_56 / u_xlat16_52;
    // u_xlat16_52 = u_xlat16_52 + u_xlat16_10.z;

    float t2 = t * 6.0 + 9.99999975e-05;
    t2 = mask / t2;
    t2 += color4.z;

    // u_xlat16_56 = u_xlat16_10.x + 9.99999975e-05;
    // u_xlat16_56 = u_xlat16_58 / u_xlat16_56;
    // u_xlat16_58 = abs(u_xlat16_52) + _EyebrowHSV.x;
    // u_xlat16_56 = u_xlat16_56 + _EyebrowHSV.y;
    // u_xlat16_10.x = u_xlat16_10.x + _EyebrowHSV.z;

    mask = color4.x + 9.99999975e-05;
    mask = t / mask;
    t = abs(t2) + _EyebrowHSV.x;
    mask += _EyebrowHSV.y;
    color4.x += _EyebrowHSV.z;

    // u_xlat16_27.xyz = vec3(u_xlat16_58) + vec3(1.0, 0.666666687, 0.333333343);
    // u_xlat16_27.xyz = fract(u_xlat16_27.xyz);
    // u_xlat16_3.xyz = u_xlat16_27.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
    // u_xlat16_27.xyz = abs(u_xlat16_3.xyz) + vec3(-1.0, -1.0, -1.0);

    float3 color5 = t + float3 (1.0, 0.666666687, 0.333333343);
    color5 = frac(color5);
    color5 = abs(color5 * 6f - 3f) - 1f;

// #ifdef UNITY_ADRENO_ES3
//     u_xlat16_27.xyz = min(max(u_xlat16_27.xyz, 0.0), 1.0);
// #else
//     u_xlat16_27.xyz = clamp(u_xlat16_27.xyz, 0.0, 1.0);
// #endif
//     u_xlat16_27.xyz = u_xlat16_27.xyz + vec3(-1.0, -1.0, -1.0);
//     u_xlat16_27.xyz = vec3(u_xlat16_56) * u_xlat16_27.xyz + vec3(1.0, 1.0, 1.0);

    color5 = saturate(color5) - 1f;
    color5 = color5 * mask + 1f;

    // u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_27.xyz + (-u_xlat16_9.xyz);
    // u_xlat16_10.xyz = u_xlat16_9.www * u_xlat16_10.xyz + u_xlat16_9.xyz;
    // u_xlat16_56 = u_xlat16_2.y * _EyebrowHSV.w;
    // u_xlat16_10.xyz = (-u_xlat16_7.xyz) + u_xlat16_10.xyz;

    color4.xyz = color4.x * color5.xyz - color3.xyz;
    color4.xyz = color3.w * color4.xyz + color3.xyz;
    mask = faceMask.y * _EyebrowHSV.w;
    color4.xyz -= color1.xyz;

    // u_xlat16_7.xyz = vec3(u_xlat16_56) * u_xlat16_10.xyz + u_xlat16_7.xyz;
    // u_xlat16_56 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    // u_xlat16_56 = inversesqrt(u_xlat16_56);
    // u_xlat16_10.xyz = vec3(u_xlat16_56) * vs_TEXCOORD5.xyz;

    color1.xyz += mask * color4.xyz;
    float3 viewDirWS = SafeNormalize(input.viewDirWS.xyz);    

    // u_xlat3.x = vs_TEXCOORD0.z;
    // u_xlat3.y = vs_TEXCOORD1.z;
    // u_xlat3.z = vs_TEXCOORD2.z;

    float3 normalWS = float3(input.texcoord0.z, input.texcoord1.z, input.texcoord2.z);


    // u_xlat16_56 = dot(u_xlat16_10.xyz, u_xlat3.xyz);
    float vdn = dot(viewDirWS, normalWS);

// #ifdef UNITY_ADRENO_ES3
//     u_xlat16_56 = min(max(u_xlat16_56, 0.0), 1.0);
// #else
//     u_xlat16_56 = clamp(u_xlat16_56, 0.0, 1.0);
// #endif
//     u_xlat16_58 = u_xlat16_56 * u_xlat16_56;
//     u_xlat16_58 = u_xlat16_58 * _LipCubeIntensity;

    vdn = saturate(vdn);
    float lipCubeIntensity = vdn * vdn * _LipCubeIntensity;

    // u_xlat16_10.x = dot((-vs_TEXCOORD5.xyz), u_xlat3.xyz);
    // u_xlat16_10.x = u_xlat16_10.x + u_xlat16_10.x;
    // u_xlat16_10.xyz = u_xlat3.xyz * (-u_xlat16_10.xxx) + (-vs_TEXCOORD5.xyz);

    float backViewDirDotN = dot(-input.viewDirWS.xyz, normalWS) * 2;
    float3 backviewDir = -backViewDirDotN * normalWS - input.viewDirWS.xyz;

    // u_xlat52 = _FacialParams.y * -3.0 + 3.0;
    // u_xlat16_3.xyz = textureLod(_Cube, u_xlat16_10.xyz, u_xlat52).xyz;
    // u_xlat3.xyz = vec3(u_xlat16_56) * u_xlat16_3.xyz;
    
    float mip = _FacialParams.y * -3.0 + 3.0;
    float3 faceCubeColor = textureLod(_Cube, backviewDir, mip).xyz;
    float3 faceCubeColor2 = faceCubeColor * vdn;

// #ifdef UNITY_ADRENO_ES3
//     u_xlatb52 = !!(_HDRTexEnable<0.5);
// #else
//     u_xlatb52 = _HDRTexEnable<0.5;
// #endif
//     u_xlat9.xyz = u_xlat3.xyz * vec3(0.25, 0.25, 0.25);
//     u_xlat3.xyz = (bool(u_xlatb52)) ? u_xlat3.xyz : u_xlat9.xyz;

    faceCubeColor2 = (_HDRTexEnable<0.5)? faceCubeColor2 : faceCubeColor2*0.25f;

    // u_xlat16_10.xyz = u_xlat3.xyz * vec3(u_xlat16_58);
    // u_xlat16_10.xyz = u_xlat16_4.zzz * u_xlat16_10.xyz;
    // u_xlat16_7.xyz = u_xlat16_10.xyz * _FacialParams.xxx + u_xlat16_7.xyz;
    // u_xlat16_10.xy = vs_TEXCOORD3.xy * _SSSPoreParam.xx;
    // u_xlat16_10.xy = u_xlat16_10.xy * vec2(10.0, 10.0);
    // u_xlat16_8 = texture(_PoreTex, u_xlat16_10.xy);
    // u_xlat16_10.xy = u_xlat16_8.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    // u_xlat16_44.xy = u_xlat16_8.xy + vec2(-1.0, -1.0);
    // u_xlat16_44.xy = u_xlat16_4.ww * u_xlat16_44.xy + vec2(1.0, 1.0);
    // u_xlat16_10.xy = (-u_xlat16_5.xy) + u_xlat16_10.xy;

    float3 faceCubeColor3 = faceCubeColor2 * lipCubeIntensity * normalTBNS.z;
    color1.xyz = faceCubeColor3 * _FacialParams.x + color1.xyz;
    float poreUV = input.texcoord3.xy * _SSSPoreParam.xx * 10;
    float4 poreColor = SAMPLE_TEXTURE2D(_PoreTex, sampler_PoreTex, poreUV);
    float2 t3 = poreColor.zw * 2f - 1f;
    float2 t4 = poreColor.xy - 1f;
    t4 = t4 * normalTBNS.w + 1.0f;
    t3 = t3 - normalTBNSNormalized.xy;

    // u_xlat16_11.xy = u_xlat16_4.ww * u_xlat16_10.xy + u_xlat16_5.xy;
    // u_xlat16_11.z = 1.0;
    // u_xlat16_12.x = dot(vs_TEXCOORD0.xyz, u_xlat16_11.xyz);
    // u_xlat16_12.y = dot(vs_TEXCOORD1.xyz, u_xlat16_11.xyz);
    // u_xlat16_12.z = dot(vs_TEXCOORD2.xyz, u_xlat16_11.xyz);

    float2 xy = normalTBNS.w * t3.xy + normalTBNSNormalized.xy;
    float3 xyz = float3(xy, 1.0f);
    float3 normal1 = 0;
    normal1.x = dot(input.texcoord0.xyz, xyz);
    normal1.y = dot(input.texcoord1.xyz, xyz);
    normal1.z = dot(input.texcoord2.xyz, xyz);

    // u_xlat16_56 = u_xlat16_4.z * _FacialParams.x;
    // u_xlat16_58 = (-u_xlat16_3.w) + _FacialParams.y;
    // u_xlat16_5.w = u_xlat16_56 * u_xlat16_58 + u_xlat16_3.w;
    // u_xlat16_5.z = 1.0;
    // u_xlat16_11.x = dot(vs_TEXCOORD0.xyz, u_xlat16_5.xyz);
    // u_xlat16_11.y = dot(vs_TEXCOORD1.xyz, u_xlat16_5.xyz);
    // u_xlat16_11.z = dot(vs_TEXCOORD2.xyz, u_xlat16_5.xyz);
    // u_xlat16_52 = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
    // u_xlat16_52 = inversesqrt(u_xlat16_52);
    // u_xlat16_3 = vec4(u_xlat16_52) * u_xlat16_11.zyxx;

    float xx = normalTBNS.z * _FacialParams.x;
    float yy = _FacialParams.y - faceCubeColor.w;
    normalTBNSNormalized.w = xx * yy + faceCubeColor.w;
    normalTBNSNormalized.z = 1.0f;
    float3 normal2 = 0;
    normal2.x = dot(input.texcoord0.xyz, normalTBNSNormalized.xyz);
    normal2.y = dot(input.texcoord1.xyz, normalTBNSNormalized.xyz);
    normal2.z = dot(input.texcoord2.xyz, normalTBNSNormalized.xyz);
    normal2 = inversesqrt( dot(normal2.xyz, normal2.xyz) ) * normal2.zyxx;

    // u_xlatb19.xz = lessThan(vec4(1.0, 0.0, 2.0, 2.0), vec4(_SoftShadowType)).xz;
    // u_xlat8 = vs_TEXCOORD1.wwww * hlslcc_mtx4x4_CustomShadowMatrix[1];
    // u_xlat8 = hlslcc_mtx4x4_CustomShadowMatrix[0] * vs_TEXCOORD0.wwww + u_xlat8;
    // u_xlat8 = hlslcc_mtx4x4_CustomShadowMatrix[2] * vs_TEXCOORD2.wwww + u_xlat8;
    // u_xlat8 = u_xlat8 + hlslcc_mtx4x4_CustomShadowMatrix[3];

    // begin shadow --------
    bvec softShadowType = lessThan(float4(1.0f, 0f, 2f, 2f), float4(_SoftShadowType.xxxx)).xz;
    float4 customShadow;
    customShadow = input.texcoord1.w * _CustomShadowMatrix[1];
    customShadow += input.texcoord0.w * _CustomShadowMatrix[0];
    customShadow += input.texcoord2.w * _CustomShadowMatrix[2];
    customShadow += input.texcoord3.w * _CustomShadowMatrix[3];

    // u_xlat9 = vs_TEXCOORD1.wwww * hlslcc_mtx4x4unity_WorldToShadow[1];
    // u_xlat9 = hlslcc_mtx4x4unity_WorldToShadow[0] * vs_TEXCOORD0.wwww + u_xlat9;
    // u_xlat9 = hlslcc_mtx4x4unity_WorldToShadow[2] * vs_TEXCOORD2.wwww + u_xlat9;
    // u_xlat9 = u_xlat9 + hlslcc_mtx4x4unity_WorldToShadow[3];

    float4 unityShadow;
    unityShadow = input.texcoord1.w * unity_WorldToShadow[1];
    unityShadow += input.texcoord0.w * unity_WorldToShadow[0];
    unityShadow += input.texcoord2.w * unity_WorldToShadow[2];
    unityShadow += input.texcoord3.w * unity_WorldToShadow[3];

    // u_xlat8 = (u_xlatb19.x) ? u_xlat8 : u_xlat9;
    customShadow =  softShadowType.x ? customShadow : unityShadow;

    float t5 = 0; 
    float t6 = 0;

    // if(u_xlatb19.z)
    if (softShadowType.z)
    {
        // u_xlat9 = u_xlat8;
        // u_xlat16_5.x = float(0.0);
        // u_xlat16_22.x = float(0.0);

        unityShadow = customShadow;

        while(true)
        {
// #ifdef UNITY_ADRENO_ES3
//             u_xlatb52 = !!(u_xlat16_22.x>=12.0);
// #else
//             u_xlatb52 = u_xlat16_22.x>=12.0;
// #endif

            if(t6 >= 12.0){ break; }

            // u_xlatu52 = uint(u_xlat16_22.x);
            uint index = uint(t6);

            // u_xlat9.xy = ImmCB_0_0_0[int(u_xlatu52)].xy * vec2(PANGU_CHARACTER_SOFT_SHADOW_SOFTNESS) + u_xlat9.xy;
            // u_xlat4.xy = u_xlat9.xy / u_xlat9.ww;
            // u_xlat52 = texture(_CustomShadowTex, u_xlat4.xy).x;
            // u_xlat53 = u_xlat9.z + (-_CustomShadowBias);

            unityShadow.xy += ImmCB_0_0_0[int(index)].xy * float2(PANGU_CHARACTER_SOFT_SHADOW_SOFTNESS);
            float2 uv = unityShadow.xy / unityShadow.w;
            float shadow = SAMPLE_TEXTURE2D(_CustomShadowTex, sampler_CustomShadowTex, uv).x;
            float offset = unityShadow.z -  _CustomShadowBias;

// #ifdef UNITY_ADRENO_ES3
//             u_xlatb52 = !!(u_xlat53<u_xlat52);
// #else
//             u_xlatb52 = u_xlat53<u_xlat52;
// #endif
//             u_xlat52 = u_xlatb52 ? 1.0 : float(0.0);
//             u_xlat16_5.x = u_xlat52 + u_xlat16_5.x;
//             u_xlat16_22.x = u_xlat16_22.x + 1.0;

            t5 = t5 + ( offset < shadow )? 1.0 : 0.0;
            t6++;
        }
        // u_xlat16_5.x = u_xlat16_5.x * 0.0833333358;
        shadowAvg = t5 * 0833333358f;
    } 
    else 
    {
        // if(u_xlatb19.x)
        if (softShadowType.x)
        {
            // u_xlat9 = u_xlat8;
            // u_xlat16_22.x = float(0.0);
            // u_xlat16_39 = float(0.0);

            unityShadow = customShadow;
            t5 = 0;
            t6 = 0;

            while(true)
            {
// #ifdef UNITY_ADRENO_ES3
//                 u_xlatb52 = !!(u_xlat16_39>=8.0);
// #else
//                 u_xlatb52 = u_xlat16_39>=8.0;
// #endif
//                 if(u_xlatb52){break;}

                if (t6 >= 8.0f) { break; }

                // u_xlatu52 = uint(u_xlat16_39);

                uint index = uint(t6);

                // u_xlat9.xy = ImmCB_0_0_0[int(u_xlatu52)].xy * vec2(PANGU_CHARACTER_SOFT_SHADOW_SOFTNESS) + u_xlat9.xy;
                // u_xlat19.xz = u_xlat9.xy / u_xlat9.ww;
                // u_xlat52 = texture(_CustomShadowTex, u_xlat19.xz).x;
                // u_xlat19.x = u_xlat9.z + (-_CustomShadowBias);

                unityShadow += ImmCB_0_0_0[int(index)].xy * float2(PANGU_CHARACTER_SOFT_SHADOW_SOFTNESS);
                float2 uv = unityShadow.xy / unityShadow.w;
                float shadow = SAMPLE_TEXTURE2D(_CustomShadowTex, sampler_CustomShadowTex, uv).x;
                uv.x =  unityShadow.z - _CustomShadowBias;

// #ifdef UNITY_ADRENO_ES3
//                 u_xlatb52 = !!(u_xlat19.x<u_xlat52);
// #else
//                 u_xlatb52 = u_xlat19.x<u_xlat52;
// #endif
//                 u_xlat52 = u_xlatb52 ? 1.0 : float(0.0);
//                 u_xlat16_22.x = u_xlat52 + u_xlat16_22.x;
//                 u_xlat16_39 = u_xlat16_39 + 1.0;

                t5 += (uv.x < shadow)? 1.0f : 0f;
                t6++;
            }
            // u_xlat16_5.x = u_xlat16_22.x * 0.125;
            shadowAvg = t5 * 0.125f;
        } 
        else 
        {
            // u_xlatb19.xz = lessThan(vec4(-0.5, 0.0, -1.5, -1.5), vec4(_SoftShadowType)).xz;
            softShadowType = lessThan(float4(-0.5, 0.0, -1.5, -1.5), float4(_SoftShadowType)).xz;

            // u_xlat52 = (u_xlatb19.x) ? 12.0 : 8.0;
            // u_xlat52 = (u_xlatb19.z) ? u_xlat52 : 4.0;

            float maxLimit = softShadowType.x? 12.0 : 8.0;
            maxLimit = softShadowType.z? maxLimit : 4.0f;

            // u_xlat19.x = u_xlat8.z;
            // u_xlat16_22.x = float(0.0);
            // u_xlat16_39 = float(0.0);

            unityShadow = customShadow;
            t5 = 0; t6 = 0;

            while(true)
            {
// #ifdef UNITY_ADRENO_ES3
//                 u_xlatb53 = !!(u_xlat16_39>=u_xlat52);
// #else
//                 u_xlatb53 = u_xlat16_39>=u_xlat52;
// #endif
//                 if(u_xlatb53){break;}

                if (t6 >= maxLimit) break;

                // u_xlatu53 = uint(u_xlat16_39);

                uint index = uint(t6);

// #ifdef UNITY_ADRENO_ES3
//                 u_xlatb4 = !!(u_xlat19.x<0.00999999978);
// #else
//                 u_xlatb4 = u_xlat19.x<0.00999999978;
// #endif
//                 u_xlat19.x = (u_xlatb4) ? 1.0 : u_xlat19.x;

                unityShadow = (unityShadow<0.00999999978)? 1.0f : unityShadow;

                // u_xlat4.xy = ImmCB_0_0_0[int(u_xlatu53)].xy * vec2(PANGU_CHARACTER_SOFT_SHADOW_SOFTNESS) + u_xlat8.xy;
                // vec3 txVec0 = vec3(u_xlat4.xy,u_xlat19.x);

                float offset = ImmCB_0_0_0[int(index)].xy * float2(PANGU_CHARACTER_SOFT_SHADOW_SOFTNESS) + customShadow.xy;
                float3 uv = float3(offset.xy, unityShadow);

                // u_xlat16_58 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
                // u_xlat16_22.x = u_xlat16_22.x + u_xlat16_58;
                // u_xlat16_39 = u_xlat16_39 + 1.0;

                float shadow = textureLod(_ShadowMapTexture, uv, 0.0);
                t5 += shadow;
                t6++;
            }
            // u_xlat16_5.x = u_xlat16_22.x / u_xlat52;

            shadowAvg = t5 / maxLimit;

        //ENDIF
        }
    //ENDIF
    }

    // u_xlat16_22.x = (-_LightShadowData.x) + 1.0;
    // u_xlat16_5.x = u_xlat16_5.x * u_xlat16_22.x + _LightShadowData.x;
    // u_xlat16_52 = (-_VolumetricShadow) * 0.600000024 + 1.0;
    // u_xlat16_22.x = dot(_CharacterLightDir.zyx, u_xlat16_3.xyw);

    shadowAvg = lerp(shadowAvg, 1, _LightShadowData.x);
    float volumetricShadow = 1 - _VolumetricShadow * 0.600000024;
    float ldn = dot(_CharacterLightDir.zyx, normal2.xyw); 

// #ifdef UNITY_ADRENO_ES3
//     u_xlat16_22.x = min(max(u_xlat16_22.x, 0.0), 1.0);
// #else
//     u_xlat16_22.x = clamp(u_xlat16_22.x, 0.0, 1.0);
// #endif
    ldn = saturate(ldn);

    // u_xlat19.xz = u_xlat16_22.xx * vec2(0.5, 0.600000024) + vec2(0.5, 0.200000003);
    // u_xlat16_36.x = u_xlat16_36.x * -0.399999976 + 1.0;
    // u_xlat36 = min(u_xlat16_36.x, u_xlat19.z);
    // u_xlat36 = u_xlat36 + 0.100000001;
    // u_xlat36 = max(u_xlat36, 0.0);
    // u_xlat36 = u_xlat36 + -0.100000001;

    float2 sssUV = ldn * float2(0.5f, 0.600000024f) + float2(0.5f, 0.200000003f);
    params2.x = params2.x * -0.399999976 + 1.0;
    float t7 = min(params2.x, sssUV.y) + 0.100000001;
    t7 = max(t7, 0);
    t7 -= 0.100000001;

//     u_xlat16_52 = (-u_xlat16_5.x) * u_xlat16_52 + 1.0;
//     u_xlat52 = (-u_xlat16_52) * u_xlat36 + 1.0;
//     u_xlat16_11.xyz = _CharacterSkinColorScale.xyz * _SSSLightColor.xyz;
//     u_xlat16_5.x = dot(u_xlat16_12.xyz, u_xlat16_12.xyz);
//     u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
//     u_xlat16_12.xyz = u_xlat16_5.xxx * u_xlat16_12.xyz;
//     u_xlat16_5.x = dot(u_xlat1.zyx, u_xlat16_3.xyw);
//     u_xlat16_39 = u_xlat16_5.x;
// #ifdef UNITY_ADRENO_ES3
//     u_xlat16_39 = min(max(u_xlat16_39, 0.0), 1.0);
// #else
//     u_xlat16_39 = clamp(u_xlat16_39, 0.0, 1.0);
// #endif

    float t8 = 1 - t7 * (1 - shadowAvg * volumetricShadow);
    float3 skinColor = _CharacterSkinColorScale.xyz * _SSSLightColor.xyz;
    normal1 = SafeNormalize(normal1);
    t7 = dot(viewDirWSNormalize.zyx, normal2.xyw);
    t6 = saturate(t7);

    // u_xlat16_5.xw = (-u_xlat16_5.xw) + vec2(1.0, 1.0);
    // u_xlat16_36.x = max(u_xlat16_5.w, 0.0500000007);
    // u_xlat16_36.x = min(u_xlat16_36.x, 1.0);
    // u_xlat16_56 = u_xlat16_36.x * -0.31099999;

    normalTBNSNormalized.xw = float2(-t7, -normalTBNSNormalized.w) + 1;
    float t9 = min(max(normalTBNSNormalized.w, 0.0500000007f), 1.0f);
    float t10 = t9 * -0.31099999f;

    // u_xlat16_5.w = u_xlat16_6.w * u_xlat16_56 + u_xlat16_36.x;
    // u_xlat16_5.xw = u_xlat16_5.xw * u_xlat16_5.xw;
    // u_xlat16_4.x = u_xlat16_5.w * u_xlat16_5.w + 0.00999999978;
    // u_xlat16_13.xyz = u_xlat16_44.xxx * vec3(1.0, 0.5, 0.25);
    // u_xlat16_14.xyz = u_xlat16_44.yyy * vec3(0.0, 0.25, 0.300000012);

    normalTBNSNormalized.w = t10 * params1.w + t9;
    normalTBNSNormalized.xw = normalTBNSNormalized.xw * normalTBNSNormalized.xw;
    float t11 = normalTBNSNormalized.w * normalTBNSNormalized.w + 0.00999999978;
    float3 t12 = t4.xxx * float3(1.0f, 0.5f, 0.25f);
    float3 t13 = t4.yyy * float3(0.0f, 0.25f, 0.300000012f);


    // u_xlat16_56 = (-u_xlat16_39) + 1.0;
    // u_xlat16_58 = u_xlat16_56 * u_xlat16_56;
    // u_xlat16_9.xyz = (-u_xlat16_44.xxx) * vec3(1.0, 0.5, 0.25) + vec3(0.5, 0.5, 0.5);
    // u_xlat16_9.xyz = vec3(u_xlat16_58) * u_xlat16_9.xyz + u_xlat16_13.xyz;
    // u_xlat16_15.xyz = (-u_xlat16_44.yyy) * vec3(0.0, 0.25, 0.300000012) + vec3(0.5, 0.5, 0.5);
    // u_xlat16_15.xyz = vec3(u_xlat16_58) * u_xlat16_15.xyz + u_xlat16_14.xyz;
    // u_xlat16_10.x = u_xlat16_6.z * 0.636900008;
    // u_xlat19.z = 0.0;

    t10 = 1 - t6;
    float t14 = t10 * t10;
    float3 t15 = float3(1.0f, 0.5f, 0.25f) * (-t4.xxx) + 0.5f;
    t15 = t15 * t14 + t13;
    float3 t16 = float3(0.0f, 0.25f, 0.300000012f) * (-t4.yyy) + 0.5f;
    t16 = t16 * t14 + t13;
    float t17 = params1.z *  0.636900008;
    sssUV.v = 0;

    // u_xlat16_16.xyz = texture(_SSSTex, u_xlat19.xz).xyz;
    // u_xlat16_27.xyz = u_xlat16_11.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_10.xxx;
    // u_xlat16_27.xyz = u_xlat16_6.xxx * u_xlat16_27.xyz;
    // u_xlat16_27.xyz = u_xlat16_27.xyz * _SSSDiffParam.xxx;
    // u_xlat16_28.xyz = u_xlat16_11.xyz * _SSSDiffParam.yyy;

    float3 sssTexColor = SAMPLE_TEXTURE2D(_SSSTex, sampler_SSSTex, sssUV).xyz;
    float3 t18 = skinColor * 2 + t17;
    t18 *= params1.x * _SSSDiffParam.x;
    float3 t19 = skinColor * _SSSDiffParam.y;

    // u_xlat16_63 = u_xlat16_10.x * _SSSDiffParam.w;
    // u_xlat16_28.xyz = u_xlat16_28.xyz * u_xlat16_16.xyz + vec3(u_xlat16_63);
    // u_xlat16_27.xyz = u_xlat16_27.xyz * _CharacterSkinColorScale.xyz;
    // u_xlat16_27.xyz = u_xlat16_27.xyz * _MainColor.xyz;
    // u_xlat16_27.xyz = u_xlat16_27.xyz * vec3(0.25, 0.0, 0.0) + u_xlat16_28.xyz;

    t19 = t19 * sssTexColor + (t17*_SSSDiffParam.w);
    t18 = t18 * _CharacterSkinColorScale.xyz;
    t18 = t18 * _MainColor.xyz;
    t18 = t18 * float3(0.25, 0, 0) + t19;

    // u_xlat16_27.xyz = vec3(u_xlat52) * u_xlat16_27.xyz;
    // u_xlat16_19.x = u_xlat16_11.x * 4.0;
    // u_xlat16_19.x = u_xlat16_22.x * u_xlat16_19.x;
    // u_xlat16_11.xyz = u_xlat0.xyz * vec3(u_xlat51) + _CharacterLightDir.xyz;
    // u_xlat16_22.x = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
    // u_xlat16_22.x = inversesqrt(u_xlat16_22.x);
    // u_xlat16_11.xyz = u_xlat16_22.xxx * u_xlat16_11.xyz;

    t18 = t18 * t8;
    float t20 = skinColor.x * 4 * params2.x;
    float3 h = SafeNormalize(viewDirWS) +  _CharacterLightDir.xyz;
    h = SafeNormalize(h);

    // u_xlat16_22.x = dot(u_xlat16_11.xyz, u_xlat16_12.xyz);
    // u_xlat16_11.x = dot(u_xlat16_11.xyz, u_xlat1.xyz);
    // u_xlat16_0.x = u_xlat16_22.x * u_xlat16_4.x + (-u_xlat16_22.x);
    // u_xlat16_0.x = u_xlat16_0.x * u_xlat16_22.x + 1.0;
    // u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;

    float ndh = dot(h, normal1);
    float hdv = dot(h, viewDirWSNormalize);
    float t21 = ndh * normalTBNS.x - ndh;
    t21 = t21 * ndh + 1.0f;
    t21 = t21 * t21;    

    // u_xlat0.x = max(u_xlat16_0.x, 9.99999975e-05);
    // u_xlat16_17 = u_xlat16_11.x * -5.55472994 + -6.98316002;
    // u_xlat16_17 = u_xlat16_11.x * u_xlat16_17;
    // u_xlat16_17 = exp2(u_xlat16_17);

    viewDirWS.x  = max(9.99999975e-05, t21);
    float t22 = hdv * -5.55472994 + -6.98316002;
    t22 *= hdv;
    t22 = exp2(t22);

    // u_xlat0.y = u_xlat16_17 * 0.959999979 + 0.0399999991;
    // u_xlat0.xy = u_xlat0.xy * vec2(3.14159298, 0.25);
    // u_xlat0.x = u_xlat16_4.x / u_xlat0.x;
    // u_xlat0.x = u_xlat0.y * u_xlat0.x;

    viewDirWS.y = t22  * 0.959999979 + 0.0399999991;
    viewDirWS.xy = viewDirWS.xy * float2(3.14159298, 0.25);
    viewDirWS.x = normalTBNS.x / viewDirWS.x;
    viewDirWS.x = viewDirWS.y * viewDirWS.x;

    // u_xlat16_22.x = u_xlat16_19.x * u_xlat0.x;
    // u_xlat16_0 = u_xlat16_36.xxxx * vec4(-1.0, -0.0274999999, -0.572000027, 0.0219999999) + vec4(1.0, 0.0425000004, 1.03999996, -0.0399999991);
    // u_xlat16_11.x = u_xlat16_0.x * u_xlat16_0.x;
    // u_xlat16_1.x = u_xlat16_39 * -9.27999973;
    // u_xlat16_1.x = exp2(u_xlat16_1.x);

    float t23 = t20 * viewDirWS.x;
    float4 t24 = t9 * float4(-1.0f, -0.0274999999f, -0.572000027f, 0.0219999999f) + 
            float4(1.0f, 0.0425000004f, 1.03999996f, -0.0399999991f);
    float t25 = t24 * t24;
    float2 t26.x = t6 * -9.27999973;
    t26.x = exp2(t26.x);

    u_xlat16_1.x = min(u_xlat16_1.x, u_xlat16_11.x);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_0.x + u_xlat16_0.y;
    u_xlat16_1.xy = u_xlat16_1.xx * vec2(-1.03999996, 1.03999996) + u_xlat16_0.zw;
    u_xlat16_39 = u_xlat16_1.x * 0.0399999991 + u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_22.x * 0.5;

    t26.x = min(t26.x, t25);
    t26.x = t26.x * t24.x + t24.y;
    t26.xy = t26.xx * float2(-1.03999996, 1.03999996) + t24.zw;
    


    u_xlat16_1.x = min(u_xlat16_1.x, 6.0);
    u_xlat16_22.x = u_xlat16_39 * 0.899999976;
    u_xlat16_22.x = u_xlat16_6.z * u_xlat16_22.x;
    u_xlat16_11.x = (-u_xlat16_6.w) + 1.0;
    u_xlat16_11.xyz = u_xlat16_15.xyz * u_xlat16_6.www + u_xlat16_11.xxx;
    u_xlat16_11.xyz = u_xlat16_22.xxx * u_xlat16_11.xyz;
    u_xlat16_22.x = dot(u_xlat16_10.xxx, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_39 = u_xlat16_10.x * u_xlat16_39;
    u_xlat16_12.xyz = u_xlat16_9.xyz * vec3(u_xlat16_39);
    u_xlat16_19.xyz = u_xlat16_12.xyz * vec3(15.0, 15.0, 15.0);
    u_xlat16_19.xyz = u_xlat16_6.www * u_xlat16_19.xyz;
    u_xlat16_11.xyz = u_xlat16_11.xyz * u_xlat16_22.xxx + u_xlat16_19.xyz;
    u_xlat16_11.xyz = u_xlat16_11.xyz * _SSSSpecParam.www;
    u_xlat16_11.xyz = u_xlat16_2.xxx * (-u_xlat16_11.xyz) + u_xlat16_11.xyz;
    u_xlat16_11.xyz = u_xlat16_4.www * u_xlat16_11.xyz;
    u_xlat16_22.x = u_xlat16_1.x * _SSSSpecParam.y;
    u_xlat16_11.xyz = u_xlat16_22.xxx * u_xlat16_6.yyy + u_xlat16_11.xyz;
    u_xlat16_10.xyz = u_xlat16_7.xyz * u_xlat16_27.xyz;
    u_xlat16_10.xyz = u_xlat16_11.xyz * vec3(u_xlat52) + u_xlat16_10.xyz;
    u_xlat16_1.xyz = u_xlat16_7.xyz * vec3(0.300000012, 0.300000012, 0.300000012);
    u_xlat16_0 = u_xlat16_3 * vec4(-0.325735003, 0.325735003, 0.325735003, -0.273137003);
    u_xlat16_0.w = u_xlat16_3.x * u_xlat16_0.w;
    u_xlat16_22.xy = u_xlat16_3.xw * vec2(-0.273137003, 0.273137003);
    u_xlat16_52 = u_xlat16_3.y * u_xlat16_3.y;
    u_xlat16_52 = u_xlat16_52 * 3.0 + -1.0;
    u_xlat2.y = u_xlat16_52 * 0.0788479969;
    u_xlat16_2.xz = u_xlat16_3.yy * u_xlat16_22.xy;
    u_xlat16_22.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_22.x = u_xlat16_3.w * u_xlat16_3.w + (-u_xlat16_22.x);
    u_xlat2.w = u_xlat16_22.x * 0.136568502;
    u_xlat16_22.x = dot(u_xlat16_0, _VlmValues[0]);
    u_xlat2.xz = u_xlat16_2.xz;
    u_xlat16_39 = dot(u_xlat2, _VlmValues[1]);
    u_xlat16_22.x = u_xlat16_39 + u_xlat16_22.x;
    u_xlat16_7.x = _VlmValues[6].x * 0.282094985 + u_xlat16_22.x;
    u_xlat16_22.x = dot(u_xlat16_0, _VlmValues[2]);
    u_xlat16_39 = dot(u_xlat2, _VlmValues[3]);
    u_xlat16_22.x = u_xlat16_39 + u_xlat16_22.x;
    u_xlat16_7.y = _VlmValues[6].y * 0.282094985 + u_xlat16_22.x;
    u_xlat16_22.x = dot(u_xlat16_0, _VlmValues[4]);
    u_xlat16_39 = dot(u_xlat2, _VlmValues[5]);
    u_xlat16_22.x = u_xlat16_39 + u_xlat16_22.x;
    u_xlat16_7.z = _VlmValues[6].z * 0.282094985 + u_xlat16_22.x;
    u_xlat16_11.xyz = u_xlat16_7.xyz * vec3(2.50999999, 2.50999999, 2.50999999) + vec3(0.0299999993, 0.0299999993, 0.0299999993);
    u_xlat16_11.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz;
    u_xlat16_12.xyz = u_xlat16_7.xyz * vec3(2.43000007, 2.43000007, 2.43000007) + vec3(0.589999974, 0.589999974, 0.589999974);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_12.xyz + vec3(0.140000001, 0.140000001, 0.140000001);
    u_xlat16_7.xyz = u_xlat16_11.xyz / u_xlat16_7.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(vec3(_VlmScale, _VlmScale, _VlmScale));
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat16_10.xyz;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat16_5.xxx * _HighlightColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * _HighlightColor.www + u_xlat16_1.xyz;
    u_xlat16_1.x = u_xlat16_56 * 0.425000012;
    u_xlat16_1.x = u_xlat16_56 * u_xlat16_1.x + u_xlat16_58;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_6.w;
    u_xlat16_1.x = u_xlat16_1.x * _RimPower;
    u_xlat16_5.xyz = u_xlat16_1.xxx * _RimColor.xyz + u_xlat16_5.xyz;
    u_xlat16_1.x = texture(_AutoExposureTex, vec2(0.5, 0.5)).x;
    u_xlat16_18 = _AutoExposure_Intensity + 1.0;
    u_xlat16_35 = _AutoExposure_Intensity * -0.300000012 + 1.0;
    u_xlat16_18 = float(1.0) / u_xlat16_18;
    u_xlat16_35 = float(1.0) / u_xlat16_35;
    u_xlat16_1.x = u_xlat16_1.x * 5.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat16_18) + u_xlat16_35;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_35 + u_xlat16_18;
    u_xlat16_5.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * vec3(vec3(_AutoExposure, _AutoExposure, _AutoExposure));
    u_xlat16_56 = dot((-_WorldSpaceLightPos0.xyz), vs_TEXCOORD4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_56 = min(max(u_xlat16_56, 0.0), 1.0);
#else
    u_xlat16_56 = clamp(u_xlat16_56, 0.0, 1.0);
#endif
    u_xlat16_56 = u_xlat16_56 * u_xlat16_56;
    u_xlat16_58 = (-vs_TEXCOORD4.y) * _FogInfo2.w + _FogInfo2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_58 = min(max(u_xlat16_58, 0.0), 1.0);
#else
    u_xlat16_58 = clamp(u_xlat16_58, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = (-_FogColor1.xyz) + _FogColor2.xyz;
    u_xlat16_10.xyz = vec3(u_xlat16_58) * u_xlat16_10.xyz + _FogColor1.xyz;
    u_xlat16_58 = dot(u_xlat16_10.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_61 = vs_TEXCOORD4.w * _FogInfo4.x;
    u_xlat16_11.xyz = vec3(u_xlat16_58) * _FogInfo4.yyy + (-u_xlat16_10.xyz);
    u_xlat16_10.xyz = vec3(u_xlat16_61) * u_xlat16_11.xyz + u_xlat16_10.xyz;
    u_xlat16_11.xyz = _FogInfo3.zzz * _FogColor3.xyz;
    u_xlat16_10.xyz = u_xlat16_11.xyz * vec3(u_xlat16_56) + u_xlat16_10.xyz;
    u_xlat16_1.x = (-vs_TEXCOORD4.w) + 1.0;
    u_xlat16_1.xyz = u_xlat16_7.xyz * u_xlat16_1.xxx + u_xlat16_10.xyz;
    u_xlat16_1.xyz = (-u_xlat16_5.xyz) * vec3(vec3(_AutoExposure, _AutoExposure, _AutoExposure)) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = vs_TEXCOORD4.www * u_xlat16_1.xyz + u_xlat16_7.xyz;
    u_xlat16_52 = (-_DarkCharacterScale) * _DarkCharacterCtrl + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_52) * u_xlat16_1.xyz;
    u_xlat16_5.x = (-u_xlat16_1.x) * u_xlat16_52 + 1.0;
    SV_Target0.x = _OutputAlpha * u_xlat16_5.x + u_xlat16_2.x;
    SV_Target0.yz = u_xlat16_2.yz;
    SV_Target0.w = 1.0;
    return;
}