using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class Slot : MonoBehaviour
{
    public Item item;
    public EquipmentSlot equipmentSlot;

    public TMP_Text itemName;
    public TMP_Text itemDescription;
    public Image itemIcon;

    public TMP_Text useText;

    public GameObject interactionPanel;

    private void OnValidate()
    {
        UpdateItem();
    }

    private void Update()
    {
        if (!interactionPanel.active)
            UpdateItem();
    }

    public void DropItem()
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

            if (item.itemType == Item.ItemType.Consumable)
            {
                useText.text = "Use";
            }

            if (item.itemType == Item.ItemType.Throwable || item.itemType == Item.ItemType.Weapon)
            {
                useText.text = "Equip";
            }

            itemName.text = "";
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

    public void CloseInteractionMenu()
    {
        interactionPanel.SetActive(false);
        itemDescription.text = "";
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

            CloseInteractionMenu();

            Debug.Log("Used Consumable");
        }
    }

    public void EquipWeapon()
    {
        if (equipmentSlot.item == null)
        {
            CloseInteractionMenu();

            equipmentSlot.item = item;

            if (item.itemObject != null)
                item.itemObject.SetActive(true);

            item = null;
        }

        Debug.Log("Equipped Weapon");
    }

    public void EquipThrowable()
    {
        if (equipmentSlot.item == null)
        {
            CloseInteractionMenu();

            equipmentSlot.item = item;

            if (item.itemObject != null)
                item.itemObject.SetActive(true);

            item = null;
        }

        Debug.Log("Equipped Throwable");
    }
}
