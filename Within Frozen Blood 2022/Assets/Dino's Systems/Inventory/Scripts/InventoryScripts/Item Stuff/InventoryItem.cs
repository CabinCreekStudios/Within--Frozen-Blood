using System;
using UnityEngine;
using Sirenix.OdinInspector;

[CreateAssetMenu(fileName = "New Item", menuName = "Dino's Systems/Inventory/Items/Create New Inventory Item")]
[InlineEditor]
public class InventoryItem : ScriptableObject
{
    public string itemName;
    public string description;

    public float value;

    public Sprite itemIcon;

    public GameObject equippedItem;

    [HideInInspector]
    public GameObject itemObject;

    public ItemType itemType;

    public enum ItemType
    {
        Consumable,
        Weapon,
        Throwable,

        Ammo,
        CraftingItem
    }
}
