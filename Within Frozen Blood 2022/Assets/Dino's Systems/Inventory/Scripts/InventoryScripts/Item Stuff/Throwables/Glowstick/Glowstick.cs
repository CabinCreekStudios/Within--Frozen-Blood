using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Glowstick : MonoBehaviour
{
    Camera cam;

    EquipmentSlot equipmentSlot;
    GameObject inventoryObject;

    Transform throwPos;

    public GameObject throwObject;

    public string itemThrowObj;

    public int throwButton = 0;

    private void Awake()
    {
        GetAwakeProperties();
    }

    private void Update()
    {
        if (Input.GetMouseButtonDown(throwButton))
        {
            Throw();

            equipmentSlot.item = null;
        }
    }

    void GetAwakeProperties()
    {
        cam = GameObject.FindGameObjectWithTag("MainCamera").gameObject.GetComponent<Camera>();

        throwPos = GameObject.FindGameObjectWithTag("Player").transform;
        inventoryObject = GameObject.FindGameObjectWithTag("Inventory");
        equipmentSlot = GameObject.FindGameObjectWithTag("Player").GetComponentInChildren<EquipmentSlot>();
    }

    void Throw()
    {
        Instantiate(throwObject, transform.position, cam.transform.rotation);
        Destroy(gameObject);

        Debug.Log("Glowstick Thrown");
    }
}
