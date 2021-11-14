Shader "Unlit/somewave"{
    Properties{
        //_MainTex ("Texture hi", 2D) = "white" {}
        _ColorA("Color A", Color) = (1,1,1,1)
        _ColorB("Color B", Color) = (0,0,0,0)

        //        _Scale("UV Scale", Float) = 1
        //        _Offset("UV Offset", Float) = 0
    }
        SubShader{
            Tags { "RenderType" = "Opauqe"
                  "Queue" = "Transparent"}
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

            float InverseLerp(float a, float b, float v)
            {
                return (v-a)/(b-a);
            }
            
            // float Lerp(float a, float b, float t){
            //     return(1.0 - t) * a+b * t;
            // }
            
            float4 frag (v2f i) : SV_Target{
                //wave pattern
                float xOffset = sin( i.uv.x * TAU * 8) * 0.01;
                float t = sin((i.uv.y + xOffset - _Time.y *  0.1)  * TAU * 5) * 0.5 + 0.5;
                t *= 1- i.uv.y;
                
                bool topBottomRemover = ( abs(i.normal.y ) < 0.8);

                //removed the top + bottom 80%
                float waves = t * topBottomRemover;
                
                float4 outColor = lerp(_ColorA, _ColorB, i.uv.y);
                return float4( outColor.xyz * waves,1);
            }
            ENDCG
        }
    }
}