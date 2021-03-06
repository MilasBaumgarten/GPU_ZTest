﻿Shader "Masquerada/Avatar" {
	Properties{
		_MainTex("MainTex", 2D) = "white" {}
	}
	SubShader{
		Tags{ "RenderType" = "Opaque" "Queue" = "Geometry+1" }
		Pass{
			Stencil{
				Ref 2
				Comp equal
				Pass keep
				ZFail decrWrap
			}

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
					fixed4 col = texSample;

					return col;
				}

			ENDCG
		}
	}
}