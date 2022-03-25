using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Pickup : MonoBehaviour
{
    public Item item;

    private void OnValidate()
    {
        gameObject.name = item.itemName + " Pickup";
    }

    private void Awake()
    {
        
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            for (int i = 0; i < Inventory.Instance.slots.Length; i++)
            {
                if (Inventory.Instance.slots[i].transform.GetComponent<Slot>().item == null)
                {
                    // Item Can Be Added To The Inventory //
                    Inventory.Instance.slots[i].transform.GetComponent<Slot>().item = item;
                    Inventory.Instance.isFull[i] = true;
                    Destroy(gameObject);
                    break;
                }
            }
        }
    }
}
