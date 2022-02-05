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

        }
        // this only need SFX_DATA and plays the SFX using the default pitch and volume set on the SFX_System
        public void Basic_None_Random_SFX()
        {
            DinoRage_SFX_System.Instance._Play_SFX_Default(_sound_test_2);
        }

        public void Test_SFX_reciver(SFX_DATA _the_data)
        {
            DinoRage_SFX_System.Instance._Play_SFX(_the_data);
        }


    }
}