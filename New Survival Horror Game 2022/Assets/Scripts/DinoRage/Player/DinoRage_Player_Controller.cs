using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace DinoRage
{
    public class DinoRage_Player_Controller : MonoBehaviour
    {
        public float _move_speed = 8f;
        public CharacterController _controller = null;

        public Transform _cam_tran;
        public float _mouse_senstivity = 1f;
        public bool _invert_x;
        public bool _invert_y;


        private Vector3 _move_input;

        // Start is called before the first frame update
        void Start()
        {

        }

        // Update is called once per frame
        void Update()
        {


            //_move_input.x = Input.GetAxis("Horizontal") * _move_speed * Time.deltaTime;
            //_move_input.z = Input.GetAxis("Vertical") * _move_speed * Time.deltaTime;

            Vector3 _hori_move = transform.right * Input.GetAxis("Horizontal");
            Vector3 _vert_move = transform.forward * Input.GetAxis("Vertical");

            _move_input = _hori_move + _vert_move;

            // fixes diagnal movement
            _move_input.Normalize();

            _move_input = _move_input * _move_speed * Time.deltaTime;


            _controller.Move  (_move_input);

            // controlls cam rotation
            Vector2 mouse_input = new Vector2(Input.GetAxisRaw("Mouse X"), Input.GetAxisRaw("Mouse Y")) * _mouse_senstivity;

            //invert stuff
            if (_invert_x == true)
            {
                mouse_input.x = -mouse_input.x;
            }
            if (_invert_y == true)
            {
                mouse_input.y = -mouse_input.y;
            }



            // rotates player Quaternion.Euler converts rotation to something i can use
            transform.rotation = Quaternion.Euler(transform.rotation.eulerAngles.x, transform.rotation.eulerAngles.y + mouse_input.x,
            transform.rotation.eulerAngles.z);


            //controll cam looking up and downm the new vector 3 just makes it so i only need to add the value to 1
            _cam_tran.rotation = Quaternion.Euler(_cam_tran.rotation.eulerAngles + new Vector3(-mouse_input.y, 0f, 0f));

        }



    }
}