using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Sirenix.OdinInspector;
using DinosSystems.Inventory;
using UnityEngine.UI;
using TMPro;


public class ItemObject : MonoBehaviour
{
    public bool isMainItem;
    public bool isSideItem;

    public TMP_Text pickupText;

    public KeyCode pickupKey;

    private Inventory inventory;

    [ShowIf("isSideItem")]
    public SideItem sideItem;

    [ShowIf("isSideItem")]
    private SideItemSlot sideItemSlot;

    bool canPickup = false;

    private void Awake()
    {
        inventory = GameObject.FindGameObjectWithTag("Inventory").GetComponent<Inventory>();
        sideItemSlot = GameObject.FindGameObjectWithTag("SideItemSlot").GetComponent<SideItemSlot>();

        /*
        if (isSideItem)
        {
            slot = Image.FindObjectOfType<Slots>();
            slot = FindObjectOfType<Slots>();
        }
        */
    }

    private void Update()
    {
        if (canPickup)
        {
            pickupText.text = "Press " + pickupKey.ToString() + " To Pickup";
            if (Input.GetKeyDown(pickupKey))
                PickUp();
        }

        if (!canPickup)
            pickupText.text = " ";
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

    public void PickUp()
    {
        pickupText.text = " ";
        if (isSideItem)
        {
            sideItemSlot.icon.enabled = true;
            sideItemSlot.icon.sprite = sideItem.icon;

            inventory.sideItem = sideItem;
            inventory.nameOfSideItem = sideItem.name;
            inventory.isHoldingSide = true;

            Debug.Log("Throwable Picked Up!");
            Destroy(gameObject);
        }
    }
}
