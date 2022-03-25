using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class Slot : MonoBehaviour
{
    public Item item;
    public int i;

    public TMP_Text itemName;
    public Image itemIcon;

    public GameObject interactionPanel;

    private void OnValidate()
    {
        UpdateItem();
    }

    private void Update()
    {
        UpdateItem();

        if (item == null)
        {
            Inventory.Instance.isFull[i] = false;
        }
    }

    public void DropItem()
    {
        interactionPanel.SetActive(false);
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
        }
    }

    public void HideInteractionMenu()
    {
        if (item != null)
        {
            interactionPanel.SetActive(false);
        }
    }

    public void UseItem()
    {
        switch (item.itemType)
        {
            case Item.ItemType.Consumable:
                UseConsumable();
                break;
            case Item.ItemType.Weapon:
                EquipWeapon();
                break;
            case Item.ItemType.Throwable:
                EquipThrowable();
                break;
            default:
                break;
        }
    }

    public void UseConsumable()
    {
        if (PlayerNeeds.Instance.health <= 99)
        {
            PlayerNeeds.Instance.IncreaseHealth(item.value);

            item = null;

            interactionPanel.SetActive(false);

            Debug.Log("Used Consumable");
        }
    }

    public void EquipWeapon()
    {
        interactionPanel.SetActive(false);

        Debug.Log("Equipped Weapon");
    }

    public void EquipThrowable()
    {
        interactionPanel.SetActive(false);

        Debug.Log("Equipped Throwable");
    }
}
