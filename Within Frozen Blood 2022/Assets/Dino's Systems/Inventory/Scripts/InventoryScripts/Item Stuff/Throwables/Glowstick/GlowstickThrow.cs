using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Rigidbody))]
public class GlowstickThrow : MonoBehaviour
{
    public float maxSpeed = 10f;

    public float throwForce;
    private Transform throwPos;
    public Rigidbody rb;

    private void Awake()
    {
        throwPos = GameObject.Find("EquipPos/ThrowPos").transform;

        rb.AddRelativeForce(Vector3.forward * throwForce);
    }

    private void FixedUpdate()
    {
        if (rb.velocity.magnitude > maxSpeed)
        {
            rb.velocity = rb.velocity.normalized * maxSpeed;
        }
    }
}
