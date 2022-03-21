using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class ItemPickup : MonoBehaviour
{
    public Item Item;
    GameObject cam;

    public TMP_Text pickupText;
    bool canPickup;

    public KeyCode pickupKey;

    public void Pickup()
    {
        InventoryManager.Instance.Add(Item);

        Debug.Log(Item.itemName + " Picked Up");

        Destroy(gameObject);
    }

    private void OnValidate()
    {
        gameObject.name = Item.itemName + " Pickup";
        cam = GameObject.FindGameObjectWithTag("MainCamera");
    }

    public void Update()
    {
        if (canPickup)
        {
            pickupText.text = "Press " + pickupKey + " To Pickup " + Item.itemName;

            if (Input.GetKeyDown(pickupKey))
                Pickup();
        }

        if (!canPickup)
            pickupText.text = "";
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            canPickup = true;
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.tag == "Player")
        {
            canPickup = false;
        }
    }
}
