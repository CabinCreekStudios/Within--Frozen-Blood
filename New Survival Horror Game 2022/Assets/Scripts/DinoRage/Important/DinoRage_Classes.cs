using DinoRage.Enums;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DinoRage.Enums;
using Sirenix.OdinInspector;


namespace DinoRage.Classes
{
    public class DinoRage_Classes : MonoBehaviour
    {
        [Serializable]
        public class SFX_DATA_HOLDER
        {
            //public SFX_DATA sfx_used = null;
            public DinoRage_Enums.RANDOM_SETTINGS _is_it_random = DinoRage_Enums.RANDOM_SETTINGS.DONT_USE_RANDOM;
            [Range(0.0f, 1f)]
            public float _pre_pick_pitch = 1f;
            [Range(0.0f, 1f)]
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


        // section below is mostly for effect
        [Serializable]
        public class INSTANT_DAMAGE
        {
            public DinoRage_Enums.DAMAGE_TYPES _damage_type = DinoRage_Enums.DAMAGE_TYPES.PHYSICAL_DAMAGE;
            public DinoRage_Enums.RANDOM_SETTINGS _random_or_not;

            [MinMaxSlider(0, 100, true)]
            [ShowIf("_random_or_not", DinoRage_Enums.RANDOM_SETTINGS.USE_RANDOM)]
            public Vector2 _random_damage_amount = new Vector2(10, 100);

            [ShowIf("_random_or_not", DinoRage_Enums.RANDOM_SETTINGS.DONT_USE_RANDOM)]
            public float _non_random_damage_amount = 10;
        }


        [Serializable]
        public class DAMAGE_OVER_TIME
        {
            public DinoRage_Enums.DAMAGE_TYPES _damage_type = DinoRage_Enums.DAMAGE_TYPES.PHYSICAL_DAMAGE;

            public int _seconds_to_take_damage = 1;

            public DinoRage_Enums.RANDOM_SETTINGS _random_or_not;
            [MinMaxSlider(0, 100, true)]
            [ShowIf("_random_or_not", DinoRage_Enums.RANDOM_SETTINGS.USE_RANDOM)]
            public Vector2 _random_damage_per_second = new Vector2(1, 5);

            [ShowIf("_random_or_not", DinoRage_Enums.RANDOM_SETTINGS.DONT_USE_RANDOM)]
            public float _non_random_damage_per_second = 3;
        }
        [Serializable]
        public class ADD_ITEM_TO_INVETORY
        {
            public int _item_ID = 0;
            public DinoRage_Item_DATA _item_added = null;
            public int _amount = 1;

        }
        [Serializable]
        public class PLAYER_STATUS_EFFECT
        {
            
        }

        // this class is what is used and passed thru to damage calculation

        [Serializable]

        public class COMBAT_INFORMATION
        {
            public float _health = 0f;


            public int _amour;
            public int _basic_damage = 0;

            public int _fire_resistance = 0;
            public int _fire_damage = 0;

            public int _cold_resistance = 0;
            public int _cold_damage = 0;

            public int _poison_resistance = 0;
            public int poison_damage = 0;
        }





        // from here down is gear and weapons

        [Serializable]
        public class WEAPON_DATA
        {
            public DinoRage_Enums.HAND_USED _hand_used_for_weapon = DinoRage_Enums.HAND_USED.LEFT_HAND;
            public int _weapon_damage = 10;
            public float _weapon_speed = 3.5f;

       
        }
        [Serializable]
        public class CLOTHING_DATA
        {
            public DinoRage_Enums.CLOTHING_TYPES _clothing_type = DinoRage_Enums.CLOTHING_TYPES.GEAR;

            public DinoRage_Enums.GEAR_WORN_AREAS _gear_area = DinoRage_Enums.GEAR_WORN_AREAS.HEAD;
        }



    }
}