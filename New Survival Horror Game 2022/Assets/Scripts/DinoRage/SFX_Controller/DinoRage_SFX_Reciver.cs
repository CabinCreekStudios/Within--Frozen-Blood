using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DinoRage.Enums;
using DinoRage.Classes;
using Random = UnityEngine.Random;


namespace DinoRage
{
    public class DinoRage_SFX_Reciver : MonoBehaviour
    {
        public bool _is_this_play_on_enabled = false;
        public float _default_volume = 1f;
        public float _default_pitch = 1f;
        private AudioSource m_AudioSource = null;
        public SFX_DATA _sound_on_created = null;

        private void OnEnable()
        {
            if (m_AudioSource == null)
            {
                m_AudioSource = GetComponent<AudioSource>();
            }
            if (_is_this_play_on_enabled == true)
            {
                _Play_SFX(_sound_on_created);
            }
        }
        public void _Play_SFX(SFX_DATA sfx_used)
        {
            int _sound_picked = Random.Range(1, sfx_used.SFX_lists.Count);
            // picks if it need to use value recived or random values set on each audio
            switch (sfx_used._SFX_info._is_it_random)
            {
                case DinoRage_Enums.RANDOM_SETTINGS.DONT_USE_RANDOM:
                    m_AudioSource.volume = sfx_used._SFX_info._pre_pick_volume;
                    m_AudioSource.pitch = sfx_used._SFX_info._pre_pick_pitch;
                    break;
                case DinoRage_Enums.RANDOM_SETTINGS.USE_RANDOM:
                    m_AudioSource.volume = Random.Range(sfx_used.SFX_lists[_sound_picked]._random_volume.x, sfx_used.SFX_lists[_sound_picked]._random_volume.y);
                    m_AudioSource.pitch = Random.Range(sfx_used.SFX_lists[_sound_picked]._random_pitch.x, sfx_used.SFX_lists[_sound_picked]._random_pitch.y);
                    break;
            }
            //Play the sound once
            m_AudioSource.PlayOneShot(sfx_used.SFX_lists[_sound_picked].sound);
            return;
        }

        public void _Play_SFX_Default(SFX_DATA sfx_used)
        {
            // use this if you dont want random settings and just want to pass SFX DATA Thru
            int _sound_picked = Random.Range(1, sfx_used.SFX_lists.Count);
            m_AudioSource.volume = _default_volume;
            m_AudioSource.pitch = _default_pitch;
            m_AudioSource.PlayOneShot(sfx_used.SFX_lists[_sound_picked].sound);

        }


    }
}