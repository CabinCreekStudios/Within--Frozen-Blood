using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Sirenix.OdinInspector;
using DinoRage.Classes;


[CreateAssetMenu(fileName = "SFX_Data", menuName = "DinoRage/Data/SFX_Data")]
public class SFX_DATA : ScriptableObject
{
    public string _SFX_name;
    public int _SFX_ID = -1;
    public DinoRage_Classes.SFX_DATA_HOLDER _SFX_info;
    [System.Serializable]
    public class DATA_SFX
    {
        
        public AudioClip sound;
        [Range(0.0f, 1f)]
        // not random volume
        public float Volume = 1f;
        [MinMaxSlider(0f, 1f , true)]
        public Vector2 _random_volume = new Vector2(0.5f, 1f);
        [MinMaxSlider(0f, 2f , true)]
        public Vector2 _random_pitch = new Vector2(0.8f, 1.2f);
    }
    [TableList]
    public List<DATA_SFX> SFX_lists = new List<DATA_SFX>();
}

