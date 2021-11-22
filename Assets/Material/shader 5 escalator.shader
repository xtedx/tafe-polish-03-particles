Shader "Custom/shader 5 escalator"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        float2 FlowUV(float2 uv, float time)
        {
            return uv + abs(time);
        }

        float2 FlowUVy(float2 uv, float time)
        {
            //only move y
            uv.y = uv.y + abs(time);
            return uv;
        }

        void surf_teddy_move (Input IN, inout SurfaceOutputStandard o)
        {
            float2 uv = FlowUVy(IN.uv_MainTex, _Time * 2);
            fixed4 c = tex2D (_MainTex, uv) * _Color;
            o.Albedo = c.rgb;
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        
        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            surf_teddy_move(IN, o);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
