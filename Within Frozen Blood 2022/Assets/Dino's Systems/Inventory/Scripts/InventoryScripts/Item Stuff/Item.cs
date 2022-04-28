using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Sirenix.OdinInspector;
using Sirenix.Utilities;

[Serializable]
[CreateAssetMenu(fileName = "New Item", menuName = "Dino's Systems/Inventory/Items/Create New Item")]
[InlineEditor]
public class Item : ScriptableObject
{
    public string itemName;
    public string description;

    public float value;

    public Sprite itemIcon;

    public GameObject equippedItem;

    [HideInInspector]
    public GameObject itemObject;

    public ItemType itemType;

    private void OnValidate()
    {
        itemObject = equippedItem;
    }

    public enum ItemType
    {
        Consumable,
        Weapon,
        Throwable,

        Ammo,
        CraftingItem
    }
}
