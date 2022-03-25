using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Sirenix.OdinInspector;

[CreateAssetMenu(fileName = "New Item", menuName = "Dino's Systems/Inventory/Items/Create New Item")]
[InlineEditor]
public class Item : ScriptableObject
{
    public string itemName;
    public Sprite itemIcon;

    public float value;

    public ItemType itemType;

    public enum ItemType
    {
        Consumable,
        Weapon,
        Throwable
    }
}
