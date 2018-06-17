Shader "Masquerada/Border" {
	Properties{
		_MainTex("MainTex", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,1)
	}
		SubShader{
		Tags{ "RenderType" = "Transparent" "Queue" = "Geometry+2" }
		Blend SrcAlpha OneMinusSrcAlpha
		
		Pass{
			CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag

				#include "UnityCG.cginc"

				uniform sampler2D _MainTex;
				uniform float4 _MainTex_ST;

				uniform float4 _Color;

				struct appdata {
					float4 vertex : POSITION;
					float2 uv : TEXCOORD0;
				};

				struct v2f {
					float2 uv : TEXCOORD0;
					float4 vertex : SV_POSITION;
				};

				v2f vert(appdata v) {
					v2f o;
					o.vertex = UnityObjectToClipPos(v.vertex);
					o.uv = TRANSFORM_TEX(v.uv, _MainTex);
					return o;
				}

				fixed4 frag(v2f i) : SV_Target{
					fixed4 texSample = tex2D(_MainTex, i.uv);
					fixed4 col = (1 - texSample.r) * _Color;

					// weiße Stellen ausschneiden (sind Transparenz)
					col.a = 1 - texSample.r;

					return col;
				}
			ENDCG
		}
	}
}