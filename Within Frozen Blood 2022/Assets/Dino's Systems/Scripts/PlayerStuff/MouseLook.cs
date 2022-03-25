using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MouseLook : MonoBehaviour
{
    public static MouseLook Instance;

    public float minMouseSensitivity = 0f;
    public float maxMouseSensitivity = 200f;
    public float mouseSensitivity = 200f;

    public Transform playerBody;

    float xRotation = 0f;

    public bool isLocked;

    private void Awake()
    {
        Instance = this;
    }

    private void Update()
    {
        if (isLocked)
        {
            Cursor.lockState = CursorLockMode.Locked;
            mouseSensitivity = maxMouseSensitivity;
        }else if (!isLocked)
        {
            Cursor.lockState = CursorLockMode.None;
            mouseSensitivity = minMouseSensitivity;
        }

        float mouseX = Input.GetAxis("Mouse X") * mouseSensitivity * Time.deltaTime;
        float mouseY = Input.GetAxis("Mouse Y") * mouseSensitivity * Time.deltaTime;

        xRotation -= mouseY;
        xRotation = Mathf.Clamp(xRotation, -90f, 90f);

        transform.localRotation = Quaternion.Euler(xRotation, 0f, 0f);
        playerBody.Rotate(Vector3.up * mouseX);
    }

    public void EnableIsLocked()
    {
        isLocked = true;
    }

    public void DisableIsLocked()
    {
        isLocked = false;
    }
}
