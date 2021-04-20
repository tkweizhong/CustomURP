Shader "TianYu/Eye"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _MainRightTex ("Texture", 2D) = "white" {}
        _Masks ("Texture", 2D) = "white" {}
        _AutoExposureTex ("Texture", 2D) = "white" {}
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "EyeVS.hlsl"
            #include "EyePS.hlsl"

            
            ENDHLSL
        }
    }
}
