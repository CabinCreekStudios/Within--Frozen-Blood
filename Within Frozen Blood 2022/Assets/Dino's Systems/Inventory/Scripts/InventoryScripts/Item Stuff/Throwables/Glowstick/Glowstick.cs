using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Glowstick : MonoBehaviour
{
    public EquipmentSlot equipmentSlot;
    public GameObject inventoryObject;

    public GameObject throwObject;

    public int throwButton = 0;

    private void Update()
    {
        if (Input.GetMouseButtonDown(throwButton) && !inventoryObject.active)
        {
            equipmentSlot.item = null;
            gameObject.SetActive(false);

            Instantiate(throwObject, transform.position, Quaternion.identity);
        }
    }
}
