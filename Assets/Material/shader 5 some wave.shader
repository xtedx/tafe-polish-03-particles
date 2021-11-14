Shader "Unlit/something"{
    Properties{
        _MainTex ("Texture", 2D) = "white" {}
        _ColorA("Color A", Color) = (1,1,1,1)
        _ColorB("Color B", Color) = (0,0,0,0)

        //        _Scale("UV Scale", Float) = 1
        //        _Offset("UV Offset", Float) = 0
    }
        SubShader{
            Tags { "Queue"="Geometry" "RenderType"="Opaque" }
            Pass{

            Cull Back
            Zwrite Off //dont write to the depth buffer / z-buffer
            ZTest NotEqual
            Blend One One //Additive

            //Blend DstColor Zero //Multiply
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #define TAU 6.28318530718
            struct appdata {//data that comes from the mesh
                float4 vertex : POSITION; //vertex position in object space 
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };
            struct v2f{
                float4 vertex : SV_POSITION; //texel position in clip space
                float2 uv : TEXCOORD1;
                float3 normal : NORMAL;
            };
            
            float4 _ColorA;
            float4 _ColorB;
            
            v2f vert (appdata v){
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;//(v.uv + _Offset) * _Scale; //

                
                o.normal = v.normal; //mul((float3x3) unity_ObjectToWorld, v.normal);
                //o.normal = UnityObjectToWorldNormal(v.normal);
                return o;
            }
            
            float4 frag (v2f i) : SV_Target{
                //wave pattern
                float xOffset = cos( i.uv.x * TAU * 8) * 0.01;
                xOffset = 0;
                float t = cos((i.uv.y + xOffset - _Time.y *  0.1)  * TAU * 3) * 0.5 + 0.5;
                t *= 4-i.uv.y;

                float waves = t;


                float4 outColor = lerp(_ColorA, _ColorB, i.uv.y * _Time);
                return float4( outColor.xyz * waves,1);
                

                
               // i.uv.x *= cos(_Time.y);
                //float4 col = tex2D(_MainTex, i.uv);
                
                //return float4(i.uv,0,1);
                // 0 - u - x - r
                // 1 - v - y - g
                // 2 -   - z - b
                // 3 -   - w - a
            }
            ENDCG
        }
    }
}