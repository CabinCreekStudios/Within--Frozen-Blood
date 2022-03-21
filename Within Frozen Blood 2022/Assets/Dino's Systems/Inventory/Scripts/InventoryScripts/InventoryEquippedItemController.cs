using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class InventoryEquippedItemController : MonoBehaviour
{
    public Item item;

    public Transform itemContent;
    public GameObject inventoryItem;

    EquipmentSlot equipmentSlot;

    public EquipmentSlotType equipmentSlotType;
    public GameObject unEquipPanel;

    private void Awake()
    {
        equipmentSlotType = GetComponentInParent<EquipmentSlot>().equipmentSlotType;
        
        gameObject.name = "Equipped Slot(" + equipmentSlotType.ToString() + ")";
    }

    public void ShowUnEquipPanel()
    {
        unEquipPanel.SetActive(true);
    }

    public void HideUnEquipPanel()
    {
        unEquipPanel.SetActive(false);
    }

    public void AddItem(Item newItem)
    {
        item = newItem;
    }

    public void UnEquipItem()
    {
        
        GameObject obj = Instantiate(inventoryItem, itemContent);
        var itemName = obj.transform.Find("ItemName").GetComponent<TMP_Text>();
        var itemIcon = obj.transform.Find("ItemIcon").GetComponent<Image>();

        itemName.text = item.itemName;
        itemIcon.sprite = item.icon;
        GameObject.Find("ItemSlot").GetComponent<InventoryItemController>().item = this.item;

        InventoryManager.Instance.Add(item);
        InventoryManager.Instance.SetInventoryItems();
        InventoryManager.Instance.RemoveEquipment(item);

        Destroy(gameObject);
    }
}
