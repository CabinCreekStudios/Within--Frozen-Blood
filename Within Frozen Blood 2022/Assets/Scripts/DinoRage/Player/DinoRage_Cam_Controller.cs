using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace DinoRage
{
    public class DinoRage_Cam_Controller : MonoBehaviour
    {
        public Transform _target;
        public GameObject _the_camera;
        public string _camera_tag = "MainCamera";

        private void Start()
        {
            _the_camera = GameObject.FindWithTag(_camera_tag);
        }




        private void LateUpdate()
        {
            _the_camera.transform.position = _target.position;
            _the_camera.transform.rotation = _target.rotation;
        }



    }
}