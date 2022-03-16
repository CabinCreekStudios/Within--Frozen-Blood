using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "New Item", menuName = "Dino's Systems/Inventory/Create New Item")]
public class Item : ScriptableObject
{
    public int id;
    public string itemName;
    public int value;
    public Sprite icon;

    public ItemType itemType;

    public enum ItemType
    {
        Consumable,
        Weapon,
        Throwable
    }
}
