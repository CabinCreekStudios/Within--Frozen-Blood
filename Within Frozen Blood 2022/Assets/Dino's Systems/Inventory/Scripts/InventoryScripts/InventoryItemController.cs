using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class InventoryItemController : MonoBehaviour
{
    public Item item;

    //public Button removeButton;
    public GameObject useRemovePanel;

    GameObject dropItemPoint;
    public TMP_Text itemUseName;

    public GameObject equipmentSlot;
    public InventoryEquippedItemController inventoryEquippedItem;
    public Transform equipSlot;

    private void Awake()
    {
        gameObject.name = "ItemSlot";
        dropItemPoint = GameObject.Find("DropItemPoint").gameObject;

       // equipmentSlot.GetComponent<InventoryEquippedItemController>().item = null;
    }

    private void Update()
    {
        
    }

    public void RemoveItem()
    {
        InventoryManager.Instance.Remove(item);

        Destroy(gameObject);
    }

    public void DropItem()
    {
        InventoryManager.Instance.Remove(item);

        if (dropItemPoint != null && item.itemDrop != null)
            Instantiate(item.itemDrop, dropItemPoint.transform.position, Quaternion.identity);

        Destroy(gameObject);
    }

    public void AddItem(Item newItem)
    {
        item = newItem;

        if (newItem == null)
            Destroy(item);
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
        if (item.itemUse != null)
            item.itemUse.SetActive(true);

        GetItem();

        Debug.Log(item.itemName + " Equipped (" + item.itemType + ")");

        RemoveItem();
    }

    public void UseThrowable()
    {
        if (item.itemUse != null)
            item.itemUse.SetActive(true);

        InventoryManager.Instance.AddEquipment(item);
        GetItem();

        Debug.Log(item.itemName + " Equipped (" + item.itemType + ")");

        RemoveItem();
    }

    public void EnableRemoveButton()
    {
        useRemovePanel.SetActive(true);
    }

    public void DisableRemoveButton()
    {
        useRemovePanel.SetActive(false);
    }

    public void UpdateItemUseName()
    {
        
    }

    public void GetItem()
    {
        /*
        GameObject obj = Instantiate(equipmentSlot, equipSlot);
        var itemName = obj.transform.Find("ItemName").GetComponent<TMP_Text>();
        var itemIcon = obj.transform.Find("ItemIcon").GetComponent<Image>();

        itemName.text = item.itemName;
        itemIcon.sprite = item.icon;

        GameObject.Find("Equipped Slot(Item)").GetComponent<InventoryEquippedItemController>().item = this.item;
        
        //equipmentSlot.GetComponent<InventoryEquippedItemController>().item = this.item;
        */
        InventoryManager.Instance.ListEquipmentItems();


        //equipmentSlot.transform.SetParent(equipSlot);
    }
}
