Shader "Antichamber/Mask_2" {
		SubShader{
		Tags{ "RenderType" = "Opaque" "Queue" = "Geometry" }
		ColorMask 0 // wird nicht gerendert
		ZWrite Off	// wird nicht für Tiefe verwendet
		Pass{
			Stencil{	// überschreibt alles hinter Objekt im Stencil Buffer mit 2
				Ref 2
				Comp always
				Pass replace
			}
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			struct v2f {
				float4 pos : SV_POSITION;
			};

			v2f vert(appdata_base v) {
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				return o;
			}

			fixed4 frag(v2f i) : SV_Target{
				return half4(1,1,1,1);
			}
			ENDCG
		}
	}
}