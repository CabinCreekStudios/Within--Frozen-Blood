using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Slot : MonoBehaviour
{
    public int ID;

    public InventoryManager manager;

    private void Start()
    {
        manager = GameObject.FindGameObjectWithTag("Manager").GetComponent<InventoryManager>();
    }

    public void SetID()
    {
        manager.currentSlot = ID;
        manager.PickUpDropInventory();
    }
}
