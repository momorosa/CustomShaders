﻿Shader "Unlit/Zero2Shaders/SolidColor"
{
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            //HLSL
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                //Mesh Attributes
                float4 position : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
            };

            v2f vert(appdata v)
            {
                v2f o; 
                o.vertex = UnityObjectToClipPos(v.position);
                return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                 return float4(1.0, 0.0, 0.0, 1.0);
            }

            ENDCG
        }
    }
}
