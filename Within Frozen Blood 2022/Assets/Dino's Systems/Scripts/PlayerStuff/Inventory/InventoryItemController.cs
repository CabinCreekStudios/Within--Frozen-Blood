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
                if (PlayerNeeds.Instance.health < 100)
                {
                    PlayerNeeds.Instance.IncreaseHealth(item.value);
                    RemoveItem();
                }
                if (PlayerNeeds.Instance.health >= 100)
                    PlayerNeeds.Instance.health = 100;
                break;
            case Item.ItemType.Weapon:
                RemoveItem();
                Debug.Log("Weapon Equipped");
                break;
            case Item.ItemType.Throwable:
                RemoveItem();
                Debug.Log("Throwable Equipped");
                break;
        }
    }
}
