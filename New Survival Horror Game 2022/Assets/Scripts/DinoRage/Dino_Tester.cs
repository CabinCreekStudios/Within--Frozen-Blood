using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DinoRage.Enums;
using DinoRage.Classes;
//using Random = UnityEngine.Random;

namespace DinoRage
{

    public class Dino_Tester : MonoBehaviour
    {
        public SFX_DATA[] _array_of_sounds;
        public SFX_DATA _sound_test_1;
        public SFX_DATA _sound_test_2;
        public SFX_DATA _sound_test_3;
        public SFX_DATA _sound_test_4;
        public DinoRage_Classes.SFX_DATA_HOLDER _fully_made_SFX;

        [SerializeField]
        private DinoRage_Classes.SFX_DATA_HOLDER _temp_data;
        // Update is called once per frame
        void Update()
        {
            // this stuff is for testing
            if (Input.GetKeyDown("1"))
            {
                Test_SFX_reciver(_sound_test_1);
            }
            if (Input.GetKeyDown("2"))
            {
                Basic_None_Random_SFX();
            }
            if (Input.GetKeyDown("3"))
            {
                // this is how to use a random SFX_DATA
                int _random = Random.Range(0, _array_of_sounds.Length);
                Test_SFX_reciver(_array_of_sounds[_random]);
            }
            if (Input.GetKeyDown("4"))
            {
                Full_SFX();
            }
        }
        // this only need SFX_DATA and plays the SFX using the default pitch and volume set on the SFX_System
        public void Basic_None_Random_SFX()
        {
            DinoRage_SFX_System.Instance._Play_SFX_Default(_sound_test_2);
        }

        // building the data for _Play_SFX the more complex reciver if SFX_DATA_HOLDER hasnt been set up or pre made
        public void Test_SFX_reciver(SFX_DATA _the_data)
        {
            _temp_data.sfx_used = _the_data;
            // settings below dont need to be changed it you want to just use 1 default SFX_DATA_HOLDER on this script
            _temp_data._is_it_random = DinoRage_Enums.RANDOM_SETTINGS.USE_RANDOM;
            _temp_data._pre_pick_pitch = 1f;
            _temp_data._pre_pick_volume = 1f;
            DinoRage_SFX_System.Instance._Play_SFX(_temp_data);
        }

        // this is how you call the SFX on the player with a fully made SFX_DATA_HOLDER
        public void Full_SFX()
        {
            DinoRage_SFX_System.Instance._Play_SFX(_fully_made_SFX);
        }
    }
}