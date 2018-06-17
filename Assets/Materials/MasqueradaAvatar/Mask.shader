Shader "Masquerada/Mask" {
	Properties{
		_Color("Color", Color) = (1,1,1,1)
	}
	SubShader{
		Tags{ "RenderType" = "Opaque" "Queue" = "Geometry" }
		Pass{
			Stencil{
				Ref 2
				Comp always
				Pass replace
			}
			CGPROGRAM

				#pragma vertex vert
				#pragma fragment frag
				#include "UnityCG.cginc"

				uniform float4 _Color;

				struct v2f {
					float4 pos : SV_POSITION;
					fixed3 color : COLOR0;
				};

				v2f vert(appdata_base v) {
					v2f o;
					o.pos = UnityObjectToClipPos(v.vertex);
					return o;
				}

				fixed4 frag(v2f i) : SV_Target {
					return _Color;
				}
			ENDCG
		}
	}
}