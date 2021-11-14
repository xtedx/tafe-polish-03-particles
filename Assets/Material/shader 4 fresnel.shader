Shader "Unlit/fresnelshader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Colour ("Colour", color) = (1,1,1,1)
        _Speed ("Speed", float) = 10
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Transparent"
        }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal: NORMAL;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
                float3 normal : TEXTCOORD1;
                float3 worldPosition : TEXCOORD2;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            float4 _Colour;
            float _Speed;

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o, o.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                //matrix mul tiplication
                o.worldPosition = mul(unity_ObjectToWorld, v.vertex);

                return o;
            }

            fixed4 frag_default(v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }

            //standard frensel effect, glowing
            fixed4 frensel_frag(v2f i) : SV_Target
            {
                float3 n = normalize(i.normal * _Colour);
                float3 v = normalize(_WorldSpaceCameraPos - i.worldPosition);
                return (1 - dot(v, n))  * sin(_Time.y * _Speed);
            }
            
            //this is like main function
            fixed4 frag(v2f i) : SV_Target
            {
                return frensel_frag(i);
            }
            ENDCG
        }
    }
}