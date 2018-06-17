Shader "Antichamber/Interior_1" {
	Properties{
		_Color("Color", Color) = (1,1,1,1)
	}
		SubShader{
		Tags{ "RenderType" = "Opaque" "Queue" = "Geometry+1" }	// rendere Objekt nach Szenengeometrie
		Pass{
		Stencil{	// rendere Objekt, wo Stencil Buffer mit 2 beschrieben ist
			Ref 1
			Comp equal
		}
		CGPROGRAM

		#pragma vertex vert
		#pragma fragment frag
		#include "UnityCG.cginc"

		uniform float4 _Color;

		struct v2f {
			float4 pos : SV_POSITION;
		};

		v2f vert(appdata_base v) {
			v2f o;
			o.pos = UnityObjectToClipPos(v.vertex);
			return o;
		}

		fixed4 frag(v2f i) : SV_Target{
			return _Color;
		}
			ENDCG
		}
	}
}