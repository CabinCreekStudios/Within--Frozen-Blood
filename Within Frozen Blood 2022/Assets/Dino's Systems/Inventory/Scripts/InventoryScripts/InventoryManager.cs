using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using UnityEngine.UI;
using Sirenix.OdinInspector;

public class InventoryManager : MonoBehaviour
{
    public static InventoryManager Instance;
    public List<Item> Items = new List<Item>();
    public List<Item> EquipmentItems = new List<Item>();

    [TabGroup("Basic Info")]
    public Transform itemContent;
    [TabGroup("Basic Info")]
    public Transform equipmentItemContent;
    [TabGroup("Basic Info")]
    public GameObject inventoryItem;
    [TabGroup("Basic Info")]
    public GameObject equipmentItem;

    [TabGroup("Toggle")]
    public Toggle enableRemove;

    [TabGroup("Misc")]
    public InventoryItemController[] inventoryItems;

    [TabGroup("Misc")]
    public InventoryEquippedItemController[] inventoryEquipmentItems;

    private void Awake()
    {
        Instance = this;
    }

    public void Add(Item item)
    {
        Items.Add(item);
    }

    public void AddEquipment(Item item)
    {
        EquipmentItems.Add(item);
    }

    public void Remove(Item item)
    {
        Items.Remove(item);
    }

    public void RemoveEquipment(Item item)
    {
        EquipmentItems.Remove(item);
    }

    public void ListItems()
    {
        // Clean Content Before Open //
        foreach (Transform trash in itemContent)
        {
            InventoryItemController itemObj = trash.GetComponent<InventoryItemController>();
            if (itemObj.item == null)
            {
                Destroy(trash.gameObject);
            }
        }

        foreach (var item in Items)
        {
            GameObject obj = Instantiate(inventoryItem, itemContent);
            var itemName = obj.transform.Find("ItemName").GetComponent<TMP_Text>();
            var itemIcon = obj.transform.Find("ItemIcon").GetComponent<Image>();
            //var itemObj = obj.transform.Find("Item").GetComponent<InventoryItemController>();
            //var itemDescription = obj.transform.Find("DescriptionText").GetComponent<TMP_Text>();
            var removeButton = obj.transform.Find("RemoveButton").GetComponent<Button>();

            var itemSlot = item;
            

            itemName.text = item.itemName;
            itemIcon.sprite = item.icon;
            itemSlot = item;

            //itemDescription.text = item.description;

            if (enableRemove.isOn)
                removeButton.gameObject.SetActive(true);

            
        }

        SetInventoryItems();
    }

    public void ListEquipmentItems()
    {
        foreach (Transform item in equipmentItemContent)
        {
            Destroy(item.gameObject);
        }

        foreach (var item in EquipmentItems)
        {
            GameObject obj = Instantiate(equipmentItem, equipmentItemContent);
            var itemName = obj.transform.Find("ItemName").GetComponent<TMP_Text>();
            var itemIcon = obj.transform.Find("ItemIcon").GetComponent<Image>();

            itemName.text = item.itemName;
            itemIcon.sprite = item.icon;

            GameObject.Find("Equipped Slot(Item)").GetComponent<InventoryEquippedItemController>().item = item;
        }

        SetEquipmentInventoryItems();
    }

    public void EnableItemsRemove()
    {
        if (enableRemove.isOn)
        {
            foreach (Transform item in itemContent)
            {
                item.Find("RemoveButton").gameObject.SetActive(true);
            }
        }
        else
        {
            foreach (Transform item in itemContent)
            {
                item.Find("RemoveButton").gameObject.SetActive(false);
            }
        }
    }

    public void SetInventoryItems()
    {
        inventoryItems = itemContent.GetComponentsInChildren<InventoryItemController>();

        for (int i = 0; i < Items.Count; i++)
        {
            inventoryItems[i].AddItem(Items[i]);
        }
    }

    public void SetEquipmentInventoryItems()
    {
        inventoryEquipmentItems = equipmentItemContent.GetComponentsInChildren<InventoryEquippedItemController>();

        for (int i = 0; i < EquipmentItems.Count; i++)
        {
            inventoryEquipmentItems[i].AddItem(EquipmentItems[i]);
        }
    }
}
