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
                PlayerNeeds.Instance.IncreaseHealth(item.value);
                break;
            case Item.ItemType.Weapon:
                Debug.Log("Weapon Equipped");
                break;
            case Item.ItemType.Throwable:
                Debug.Log("Throwable Equipped");
                break;
        }

        RemoveItem();
    }
}
