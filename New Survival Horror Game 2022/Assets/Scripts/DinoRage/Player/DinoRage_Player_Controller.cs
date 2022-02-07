using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace DinoRage
{
    public class DinoRage_Player_Controller : MonoBehaviour
    {
        // this creates 2 floats
        public float _move_speed , gravity_modifyer,_jump_power ;

        public CharacterController _controller = null;

        public Transform _cam_tran;
        public float _mouse_senstivity = 1f;
        public bool _invert_x;
        public bool _invert_y;


        private Vector3 _move_input;

        public bool _can_jump;
        public Transform _ground_check_point;
        public LayerMask what_is_ground;

        // Start is called before the first frame update
        void Start()
        {

        }
        
        // Update is called once per frame
        void Update()
        {


            //_move_input.x = Input.GetAxis("Horizontal") * _move_speed * Time.deltaTime;
            //_move_input.z = Input.GetAxis("Vertical") * _move_speed * Time.deltaTime;

            // save Y volocity
            float _y_store = _move_input.y;

            Vector3 _hori_move = transform.right * Input.GetAxis("Horizontal");
            Vector3 _vert_move = transform.forward * Input.GetAxis("Vertical");

            _move_input = _hori_move + _vert_move;
            // fixes diagnal movement
            _move_input.Normalize();
            _move_input = _move_input * _move_speed;

            _move_input.y = _y_store;
            _move_input.y += Physics.gravity.y * gravity_modifyer * Time.deltaTime;
            

            // chescks if player is on ground
            if(_controller.isGrounded)
            {
                _move_input.y = Physics.gravity.y * gravity_modifyer * Time.deltaTime;
            }

            // handle jumpin
            // checks if theres atleast 1 ground layer object under the playter
            _can_jump = Physics.OverlapSphere(_ground_check_point.position, 0.25f, what_is_ground).Length > 0;

            if (Input.GetKeyDown(KeyCode.Space)&& _can_jump)
            {
                _move_input.y = _jump_power;
            }


            _controller.Move  (_move_input * Time.deltaTime);

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