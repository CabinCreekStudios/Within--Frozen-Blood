using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Random = UnityEngine.Random;
using DinoRage.Classes;

namespace DinoRage.Regions
{

    public class DinoRage_Regions_Core : MonoBehaviour
    {
        public static DinoRage_Regions_Core Instance { get; set; }
        public string _region_name = "";
        public DinoRage_Region_DATA _current_region = null;
        public DinoRage_Region_DATA _last_region = null;
        // adding time of day , weather and music data below to use

        // not fully set up but this can be used to load and save the time if needed
        public DinoRage_Classes.WORLD_TIME_SAVE _time_of_the_day;





        private void Start()
        {
            Instance = this;
        }

        public void Entered_Region(DinoRage_Region_DATA _new_region)
        {
            // makes sure it only runs the new region code if its a new region
            // this is to prevent any sorta mistakes that could happen
            if (_current_region == _new_region) {return;}

            // now sets up the current region and the last region
            // once everything is working the last region may have a use
            _last_region = _current_region;
            _current_region = _new_region;
        }



        public void Change_Weather()
        {

        }
        public void Change_Time_Of_Day()
        {

        }



        

    }

}