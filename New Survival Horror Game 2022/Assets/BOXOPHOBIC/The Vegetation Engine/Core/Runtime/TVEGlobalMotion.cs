// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using Boxophobic.StyledGUI;

namespace TheVegetationEngine
{
    [ExecuteInEditMode]
    [AddComponentMenu("BOXOPHOBIC/The Vegetation Engine/TVE Global Motion")]
    public class TVEGlobalMotion : StyledMonoBehaviour
    {
        [StyledBanner(0.890f, 0.745f, 0.309f, "Global Motion", "", "https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.czf8ud5bmaq2")]
        public bool styledBanner;

        [StyledCategory("Wind Settings", 5, 10)]
        public bool windCat;

        [Tooltip("Controls the global wind power.")]
        [StyledRangeOptions(0, 1, "Wind Power", new string[] { "Low", "Medium", "High" })]
        public float windPower = 0.5f;

        [StyledCategory("Motion Settings")]
        public bool motionCat;

        [Tooltip("Controls the minimum Primary, Second and Details motion when the motion is set to Low. The Wind Power slider interpolates between the settings. A value of 0 will stop the animation on Calm wind.")]
        public Vector3 minimumMotionSettings = new Vector3(0.2f, 0.4f, 0.6f);

        [Tooltip("Controls the maximum Primary, Second and Details motion when the motion is set to High. The Wind Power slider interpolates between the settings.")]
        public Vector3 maximumMotionSettings = new Vector3(1.0f, 1.0f, 1.0f);

        [StyledCategory("Noise Settings")]
        public bool noiseCat;

        [Tooltip("Sets the texture used for wind gust and motion highlight.")]
        public Texture2D noiseTexture;
        [Tooltip("Controls the scale of the noise texture.")]
        public float noiseSize = 50;
        [Tooltip("Controls the speed of the noise texture.")]
        public float noiseSpeed = 1;

        [StyledMessage("Info", "When the Noise is linked with the Motion Direction, smooth direction animation is not supported!", 10, 10)]
        public bool styledLinkMessage = false;

        [Tooltip("Moves the noise texture in the wind direction.")]
        public bool syncNoiseWithMotionDirection = true;

        [StyledSpace(10)]
        public bool styledSpace0;

        float noiseDirectionX;
        float noiseDirectionZ;

        void Start()
        {

#if UNITY_EDITOR
            gameObject.GetComponent<MeshRenderer>().hideFlags = HideFlags.HideInInspector;
            gameObject.GetComponent<MeshFilter>().hideFlags = HideFlags.HideInInspector;
#endif

            // Disable Arrow in play mode
            if (Application.isPlaying == true)
            {
                gameObject.GetComponent<MeshRenderer>().enabled = false;
            }
            else
            {
                gameObject.GetComponent<MeshRenderer>().enabled = true;
            }

            gameObject.name = "Global Motion";
            gameObject.transform.SetSiblingIndex(0);

            if (noiseTexture == null)
            {
                noiseTexture = Resources.Load<Texture2D>("Internal NoiseTex");
            }

            SetGlobalShaderProperties();
        }

        void Update()
        {
            gameObject.transform.eulerAngles = new Vector3(0, gameObject.transform.eulerAngles.y, 0);

            SetGlobalShaderProperties();
        }

        void SetGlobalShaderProperties()
        {
            var windDirection = transform.forward;

            //float windPacked = (Mathf.Atan2(windDirection.x, windDirection.z) / Mathf.PI) * 0.5f + 0.5f;            
            //Vector3 decode = new Vector3( Mathf.Sin( (windPacked * 2 - 1) * Mathf.PI) , 0, Mathf.Cos((windPacked * 2 - 1) * Mathf.PI));
            //Debug.Log(windPacked + "   " + decode);

            // X Bending Motion // Y Second Motion // Z Flutter Motion
            Shader.SetGlobalVector("TVE_MotionParamsMin", new Vector4(minimumMotionSettings.x, minimumMotionSettings.y, minimumMotionSettings.z, 0.0f));
            Shader.SetGlobalVector("TVE_MotionParamsMax", new Vector4(maximumMotionSettings.x, maximumMotionSettings.y, maximumMotionSettings.z, 0.0f));
            Shader.SetGlobalVector("TVE_MotionParams", new Vector4(windDirection.x * 0.5f + 0.5f, windDirection.z * 0.5f + 0.5f, windPower, 0.2f));

            if (syncNoiseWithMotionDirection)
            {
                noiseDirectionX = -gameObject.transform.forward.x;
                noiseDirectionZ = -gameObject.transform.forward.z;

                styledLinkMessage = true;
            }
            else
            {
                noiseDirectionX = -1;
                noiseDirectionZ = -1;

                styledLinkMessage = false;
            }

            var speed = new Vector2(noiseSpeed * noiseDirectionX * 0.1f, noiseSpeed * noiseDirectionZ * 0.1f);
            var size = 1.0f / noiseSize;

            Shader.SetGlobalTexture("TVE_NoiseTex", noiseTexture);
            Shader.SetGlobalVector("TVE_NoiseParams", new Vector4(speed.x, speed.y, size));
        }
    }
}
