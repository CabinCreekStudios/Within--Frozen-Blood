using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace DinoRage
{
    public class DinoRage_Cam_Controller : MonoBehaviour
    {
        public Transform _target;

        private void LateUpdate()
        {
            transform.position = _target.position;
            transform.rotation = _target.rotation;
        }



    }
}