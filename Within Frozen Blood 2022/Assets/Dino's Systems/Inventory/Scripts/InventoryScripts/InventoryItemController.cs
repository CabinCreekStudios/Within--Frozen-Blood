using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class InventoryItemController : MonoBehaviour
{
    Item item;

    public Button removeButton;
    public void RemoveItem()
    {
        InventoryManager.Instance.Remove(item);

        Destroy(gameObject);
    }

    public void AddItem(Item newItem)
    {
        item = newItem;
    }

    public void UseItem()
    {
        switch (item.itemType)
        {
            case Item.ItemType.Consumable:
                UseConsumable();
                break;
            case Item.ItemType.Weapon:
                UseWeapon();
                break;
            case Item.ItemType.Throwable:
                UseThrowable();
                break;
        }
    }

    public void UseConsumable()
    {
        if (PlayerNeeds.Instance.health < 100)
        {
            PlayerNeeds.Instance.IncreaseHealth(item.value);
            RemoveItem();
        }
        if (PlayerNeeds.Instance.health >= 100)
            PlayerNeeds.Instance.health = 100;
    }

    public void UseWeapon()
    {
        RemoveItem();
        Debug.Log("Weapon Equipped");
    }

    public void UseThrowable()
    {
        RemoveItem();
        Debug.Log("Throwable Equipped");
    }
}
