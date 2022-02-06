using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Sirenix.OdinInspector;

namespace DinoRage.Enums
{

    public class DinoRage_Enums : MonoBehaviour
    {
        public enum PLAYER_STATE
        {
            AWAKE , ASLEEP ,TIRED
        }

        public enum ANIMATION_TYPE
        {
            TRIGGER, BOOL, FLOAT, INT
        }
        
        public enum WEATHER_TYPES
        {
            CLEAR, CLOUDY_1, CLOUDY_2, CLOUDY_3, CLOUDY_4, FOGGY, HEAVY_RAIN, HEAVY_SNOW, LIGHT_RAIN, LIGHT_SNOW, STORM
        }

        public enum GENDER
        {
            MALE, FEMALE
        }

        [EnumToggleButtons,HideLabel]

        public enum RANDOM_SETTINGS
        { DONT_USE_RANDOM , USE_RANDOM}

        public enum HAND_USED
        { LEFT_HAND, RIGHT_HAND , BOTH_HANDS }

        public enum CLOTHING_TYPES
        { GEAR , TRINKET}

        public enum GEAR_WORN_AREAS
        { HEAD , CHEST , LEGS , HANDS , BOOTS}



        public enum DAMAGE_TYPES
        {
            PHYSICAL_DAMAGE, COLD_DAMAGE, FIRE_DAMAGE, POISON_DAMAGE
        }

        public enum COMBAT_NODE_TYPE
        {
            DAMAGE, RESISTANCE ,DODGE_CHANCE    
        }



        public enum EFFECT_TYPE
        {
            INSTANT_DAMGE,
            DAMAGE_OVER_TIME,
            INSTANT_HEAL,
            HEAL_OVER_TIME,
            STATS,
            ADD_TO_INVENTERY,
            WORLD_EFFECT
        }

        public enum ITEM_TYPE
        {
            CRAFTING_MATERIAL,
            CLOTHING,
            COMSUMABLE,
            WEAPON,
        }








    }
}