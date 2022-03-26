using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Sirenix.OdinInspector;
using Sirenix.Utilities;

[CreateAssetMenu(fileName = "New Item", menuName = "Dino's Systems/Inventory/Items/Create New Item")]
[InlineEditor]
public class Item : ScriptableObject
{
    public string itemName;
    public string description;

    public float value;

    public Sprite itemIcon;
    public GameObject itemObject;

    public ItemType itemType;

    public enum ItemType
    {
        Consumable,
        Weapon,
        Throwable
    }
}
