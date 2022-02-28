using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DinosSystems.Inventory;

public class ThrowProjectile : MonoBehaviour
{
    public float throwSpeed;
    Rigidbody rb;

    GameObject camera;

    float x, y, z;

    private void Awake()
    {
        rb = GetComponent<Rigidbody>();
        camera = GameObject.FindGameObjectWithTag("MainCamera").gameObject;

        rb.AddRelativeForce(camera.transform.forward * throwSpeed);
    }
}
