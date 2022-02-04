using System.Collections;
using System.Collections.Generic;
using UnityEngine;

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

        public enum RANDOM_SETTINGS
        { DONT_USE_RANDOM , USE_RANDOM}
    }





}