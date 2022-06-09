using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Photon.Pun;
using Sirenix.OdinInspector;

public class PlayerMovement : MonoBehaviour
{
    public static PlayerMovement Instance;

    [TabGroup("Basic Info")]
    [Tooltip("The Player Controller That Controls Movement")]
    public CharacterController controller;


    [TabGroup("Movement")]
    [Tooltip("The Speed Of Which The Player Moves")]
    public float speed = 6f;
    [TabGroup("Movement")]
    [Tooltip("Adding On To How Fast The Player Runs")]
    public float runSpeedMultiplier = 1.5f;
    [TabGroup("Movement")]
    [Tooltip("The Speed That The Player Falls")]
    public float gravity = -9.81f;
    [TabGroup("Movement")]
    [Tooltip("The Force Applied For How Much The Player Can Jump")]
    public float jumpHeight = 3f;

    [TabGroup("Jumping")]
    [Tooltip("A Game Object That Checks If You Can Jump")]
    public Transform groundCheck;
    [TabGroup("Jumping")]
    [Tooltip("The Distance To The Ground To Where You Can Jump")]
    public float groundDistance = 0.4f;
    [TabGroup("Jumping")]
    [Tooltip("The Layer Mask That Makes You Able To Jump")]
    public LayerMask groundMask;

    public Transform otherPlayerEquip;

    Vector3 velocity;

    bool isGrounded;

    private void Awake()
    {
        GetAwakeValues();
    }

    private void Start()
    {
        GetStartValues();
    }

    private void Update()
    {
        CalculateMovement();
        CalculateJumping();
        CalculateGravity();
    }

    public void GetAwakeValues()
    {
        Instance = this;
    }

    public void GetStartValues()
    {
        
    }

    public void CalculateMovement()
    {
        float x = Input.GetAxis("Horizontal");
        float z = Input.GetAxis("Vertical");

        Vector3 move = transform.right * x + transform.forward * z;

        controller.Move(move * speed * Time.deltaTime);

        if (Input.GetKeyDown(KeyCode.LeftShift))
        {
            speed += runSpeedMultiplier;
        }
        else if (Input.GetKeyUp(KeyCode.LeftShift))
        {
            speed -= runSpeedMultiplier;
        }
    }

    public void CalculateJumping()
    {
        if (Input.GetButtonDown("Jump") && isGrounded)
        {
            velocity.y = Mathf.Sqrt(jumpHeight * -2f * gravity);
        }
    }

    public void CalculateGravity()
    {
        /// Checking if is grounded by checking if it is touching the ground ///
        isGrounded = Physics.CheckSphere(groundCheck.position, groundDistance, groundMask);

        if (isGrounded && velocity.y < 0)
        {
            velocity.y = -2f;
        }

        velocity.y += gravity * Time.deltaTime;
        controller.Move(velocity * Time.deltaTime);
    }
}
