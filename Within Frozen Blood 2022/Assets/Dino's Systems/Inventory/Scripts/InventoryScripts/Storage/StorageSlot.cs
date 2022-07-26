using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class StorageSlot : MonoBehaviour
{
    public Item item;

    public TMP_Text itemName;
    public TMP_Text itemDescription;
    public Image itemIcon;

    public GameObject interactionPanel;

    public void OnValidate()
    {
        UpdateItem();

        CalculateSlotNames();
    }

    private void Update()
    {
        UpdateItem();

        CalculateSlotNames();
    }

    public void TakeItem()
    {
        CloseInteractionMenu();

        item = null;
    }

    public void UpdateItem()
    {
        if (item == null)
        {
            itemName.text = "";
            itemIcon.enabled = false;
        }

        if (item != null)
        {
            itemIcon.enabled = true;

            itemName.text = item.itemName;
            itemIcon.sprite = item.itemIcon;
        }
    }

    public void ShowInteractionMenu()
    {
        if (item != null)
        {
            interactionPanel.SetActive(true);
            itemDescription.text = item.description;

            itemName.text = "";
        }
    }

    public void CloseInteractionMenu()
    {
        interactionPanel.SetActive(false);
        itemDescription.text = "";

        for (int i = 0; i < Inventory.Instance.slots.Length; i++)
        {
            if (Inventory.Instance.slots[i].transform.GetComponent<Slot>().item == null)
            {
                // Item Can Be Added To The Inventory //
                Inventory.Instance.slots[i].transform.GetComponent<Slot>().item = item;
                break;
            }
        }
    }

    public void HideInteractionMenu()
    {
        if (item != null)
        {
            interactionPanel.SetActive(false);
            itemDescription.text = "";

            UpdateItem();
        }
    }

    public void CalculateSlotNames()
    {
        if (item != null)
            gameObject.name = item.itemName + " Slot";

        if (item == null)
            gameObject.name = "Empty Storage Slot";
    }
}
