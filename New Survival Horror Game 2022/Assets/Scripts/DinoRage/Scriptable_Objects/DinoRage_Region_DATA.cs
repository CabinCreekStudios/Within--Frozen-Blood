using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Sirenix.OdinInspector;
using DinoRage.Enums;

[CreateAssetMenu(fileName = "Region_Data", menuName = "DinoRage/Data/Region_Data")]
public class DinoRage_Region_DATA : ScriptableObject
{
    public int _region_ID = 0;
    public string _region_name = "Snow_Lands";
    public bool _show_name_popup = false;  
    public bool _change_weather_on_enter = false;
    public DinoRage_Enums.WEATHER_TYPES _weather = DinoRage_Enums.WEATHER_TYPES.CLEAR;

  
    public bool _call_special_function_when_entering = false;
    // need to set up a class and how and what this function can call and make sure to add some kinda timer


}
