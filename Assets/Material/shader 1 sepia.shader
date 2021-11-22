Shader "Custom/FinalColorSepia"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_SepiaIntensity ("SepiaIntensity", Range(0, 1)) = 0
	}

	SubShader
	{
		Tags {"Queue"="Geometry" "RenderType"="Opaque"}

		CGPROGRAM
		#pragma surface surf Lambert

		struct Input {
			float2 uv_MainTex;
		};

		fixed _SepiaIntensity;

		sampler2D _MainTex;

		void surf(Input IN, inout SurfaceOutput o) {
			fixed4 col = tex2D(_MainTex, IN.uv_MainTex);
			fixed3 c = col;
			c.r = dot(col.rgb, half3(0.393, 0.769, 0.189));
			c.g = dot(col.rgb, half3(0.349, 0.686, 0.168));
			c.b = dot(col.rgb, half3(0.272, 0.534, 0.131));
			o.Albedo = lerp(col, c, _SepiaIntensity);
			o.Alpha = 1.0;
		}

		ENDCG
	}

	FallBack "Diffuse"
}