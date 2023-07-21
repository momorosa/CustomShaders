Shader "Unlit/Zero2Shaders/ExpStep"
{
    Properties
    {
        _Threshold ("Threshold", Range(0.0, 1.0)) = 0.5
        _Color1 ("Color 1", Color) = (1, 0, 0, 1)
        _Color2 ("Color 2", Color) = (0, 0, 1, 1)
        _Sharpness ("Sharpness", Range(1.0, 10.0)) = 5.0
    }

     SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        float _Threshold;
        fixed4 _Color1;
        fixed4 _Color2;
        float _Sharpness;
        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        float ExpStep (float threshold, float value, float sharpness)
        {
            float result = 0.0;
            if (value > threshold)
            {
                result = 1.0 - exp(-sharpness * (value - threshold));
            }
            return result;
        }

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Sample the texture using UV coordinates
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);

            // Calcuate the blending factor using the exponential step function
            float blendFactor = ExpStep(_Threshold, c.r, _Sharpness);

            // Blend between Color1 and Color2 based on the blend factor
            fixed4 finalColor = lerp(_Color1, _Color2, blendFactor);
            
            // Apply the final color to the surface output
            o.Albedo = finalColor.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"

}
