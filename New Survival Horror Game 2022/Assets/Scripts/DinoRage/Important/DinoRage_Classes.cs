using DinoRage.Enums;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;


namespace DinoRage.Classes
{
    public class DinoRage_Classes : MonoBehaviour
    {
        [Serializable]
        public class SFX_DATA_HOLDER
        {
            public SFX_DATA sfx_used = null;
            public DinoRage_Enums.RANDOM_SETTINGS _is_it_random = DinoRage_Enums.RANDOM_SETTINGS.DONT_USE_RANDOM;
            public float _pre_pick_pitch = 1f;
            public float _pre_pick_volume = 1f;
        }

        [Serializable]
        public class WORLD_TIME_SAVE
        {
            public bool _already_set = false;
            public int _hours = 0;
            public int _minutes = 0;
            public int _seconds = 0;
            public int _days = 0;
            public int _months = 0;
            public int _years = 0;
        }






    }
}