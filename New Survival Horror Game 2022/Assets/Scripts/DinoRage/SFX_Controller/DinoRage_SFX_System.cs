using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DinoRage.Enums;
using DinoRage.Classes;

namespace DinoRage
{
    public class DinoRage_SFX_System : MonoBehaviour
    {
        public static DinoRage_SFX_System Instance { get; set; }
        private AudioSource m_AudioSource = null;
        public float _default_volume = 1f;
        public float _default_pitch = 1f;
        public float _volume_picked;
        public float _volume_used;
        
        public bool is_lerping = false;
        public float _increase_speed = 1f;
        public bool _use_increase_volume = true;

        public float _scale_amount = 0.1f;
        private void Start()
        {
            Instance = this;
            if (m_AudioSource == null)
            {
                m_AudioSource = GetComponent<AudioSource>();
            }
            
        }
        public void Update()
        {
            // this will increase the volume till it reaches the volume needed
            if (is_lerping == true)
            {
                _volume_used += _increase_speed * Time.deltaTime;
                m_AudioSource.volume = _volume_used;
                if (_volume_used >= _volume_picked)
                {
                    is_lerping = false;
                }
            }
        }
        public void _Play_SFX(SFX_DATA sfx_used)
        {
            // first stops whats happening in the update loop
            is_lerping = false;
            int _sound_picked = Random.Range(1, sfx_used.SFX_lists.Count);
            // picks pre picked volume or the random volume per SFX         
            switch (sfx_used._SFX_info._is_it_random)
            {
                case DinoRage_Enums.RANDOM_SETTINGS.DONT_USE_RANDOM:
                    _volume_picked = sfx_used._SFX_info._pre_pick_volume;
                    m_AudioSource.pitch = sfx_used._SFX_info._pre_pick_pitch;
                    break;
                case DinoRage_Enums.RANDOM_SETTINGS.USE_RANDOM:
                    _volume_picked = Random.Range(sfx_used.SFX_lists[_sound_picked]._random_volume.x, sfx_used.SFX_lists[_sound_picked]._random_volume.y);
                    m_AudioSource.pitch = Random.Range(sfx_used.SFX_lists[_sound_picked]._random_pitch.x, sfx_used.SFX_lists[_sound_picked]._random_pitch.y);
                    break;
            }
            // this section alows for the volume to increase or just start at the set volume
            if (_use_increase_volume == true)
            {
                m_AudioSource.volume = 0;
                _volume_used = 0;
                is_lerping = true;
            }
            else
            {
                m_AudioSource.volume = _volume_picked;
            }
            // and for the final part the sounds is finaly played
            m_AudioSource.PlayOneShot(sfx_used.SFX_lists[_sound_picked].sound);
            return;
        }




        public void _Play_SFX_Default(SFX_DATA sfx_used)
        {
            // first stops whats happening in the update loop
            is_lerping = false;
            // use this if you dont want random settings and just want to pass SFX DATA Thru
            int _sound_picked = Random.Range(1, sfx_used.SFX_lists.Count);
            m_AudioSource.volume = _default_volume;
            m_AudioSource.pitch = _default_pitch;
            m_AudioSource.PlayOneShot(sfx_used.SFX_lists[_sound_picked].sound);
        }
    }
}
