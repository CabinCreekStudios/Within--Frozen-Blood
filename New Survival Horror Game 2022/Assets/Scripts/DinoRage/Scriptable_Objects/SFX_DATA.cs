using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Sirenix.OdinInspector;


[CreateAssetMenu(fileName = "SFX_Data", menuName = "DinoRage/Data/SFX_Data")]
public class SFX_DATA : ScriptableObject
{
    [System.Serializable]
    public class DATA_SFX
    {
        public AudioClip sound;
        [Range(0.0f, 1f)]
        // not random volume
        public float Volume = 1f;
        // for random settings
        //[Range(0f , 1f)]
       // public float random_volume_min = 0.5f;
        //[Range(0f, 1f)]
       // public float random_volume_max = 1f;
       // [Range(0.5f, 1.5f)]
        //public float random_pitch_min = 0.9f;
        //[Range(0.5f, 1.5f)]
        //public float random_pitch_max = 1.1f;

        [MinMaxSlider(0f, 1f)]
        public Vector2 _random_volume = new Vector2(0.5f, 1f);
        [MinMaxSlider(0f, 2f)]
        public Vector2 _random_pitch = new Vector2(0.8f, 1.2f);

    }
    public List<DATA_SFX> SFX_lists = new List<DATA_SFX>();
}

