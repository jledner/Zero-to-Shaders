Shader "Unlit/CustomUnlitShader"
{
    Properties
    {
        _LowerEdge("Low Edge", Range(0,1)) =0
        _UpperEdge("Upper Edge", Range(0,1)) =1
        _Color1("Color 1", Color) = (1,0,0,1)
        _Color2("Color 2", Color) = (0,0,1,1)
    }

    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            static const float PI = 3.14159265f;
            static const float PI_2 = PI*2;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            float random(float2 v)
            {
                return frac(sin(dot(v.xy, float2(12.9898, 78.233))) * 43758.5453123);
            }

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            float _LowerEdge;
            float _UpperEdge;
            float _Color1;
            float _Color2;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                //smoothstep function as color
                float4 color1 = _Color1;
                float4 color2 = _Color2;
                float green = color1.g;
                float blue = color2.b;
                return float4(sin(random(i.uv.x * _LowerEdge)), (i.uv.y * _UpperEdge), 1.0f, 1);
            }
            ENDCG
        }
    }
}
