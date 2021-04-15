Shader "Aula/SimpleShader"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Transparent"
        }

        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha

            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma vertex vert
            #pragma fragment frag

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            sampler2D _MainTex;

            v2f vert(appdata i)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(i.vertex);
                o.uv = i.uv;
                return o;
            }

            float4 frag (v2f i) : SV_TARGET
            {
                float4 color = tex2D(_MainTex, i.uv);
                // effect purple
                // color.g = 0;

                //effect pb
                //float c = (color.r + color.g + color.b) / 3;
                //color.rgb = float3(c, c, c);

                //effect various color
                //float3 mapUV = float3(i.uv.x, i.uv.y, 0);
                //float c = (color.r + color.g + color.b) / 3;
                //color.rgb = float3(c, c, c) * mapUV;

                //effect multiple
                //color = tex2D(_MainTex, i.uv * 2);

                //effect senoidal
                //float s = (i.uv.y * 50) + _Time.y;
                //i.uv.x += sin(s) * 0.01;
                //color = tex2D(_MainTex, i.uv * 2);

                //effect negative
                color.rgb = 1 - color.rgb;

                return color;
            }

            ENDCG
        }
    }
}
