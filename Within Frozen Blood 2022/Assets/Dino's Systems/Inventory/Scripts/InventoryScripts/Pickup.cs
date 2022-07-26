using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Pickup : MonoBehaviour
{
    public Item item;

    public Collider _other;

    private void OnValidate()
    {
        if (item == null)
            gameObject.name = "Empty Item";

        if (item != null)
            gameObject.name = item.itemName + " Pickup";
    }

    private void Awake()
    {
        
    }

    private void OnTriggerEnter(Collider other)
    {
        if (_other.tag == "Player")
        {
            for (int i = 0; i < Inventory.Instance.slots.Length; i++)
            {
                if (Inventory.Instance.slots[i].transform.GetComponent<Slot>().item == null)
                {
                    // Item Can Be Added To The Inventory //
                    Inventory.Instance.slots[i].transform.GetComponent<Slot>().item = item;
                    Destroy(gameObject);
                    break;
                }
            }
        }
    }
}
