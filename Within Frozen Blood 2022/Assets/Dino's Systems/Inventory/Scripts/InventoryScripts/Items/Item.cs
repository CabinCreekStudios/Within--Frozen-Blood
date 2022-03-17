using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Sirenix.OdinInspector;

[CreateAssetMenu(fileName = "New Item", menuName = "Dino's Systems/Inventory/Create New Item")]
[InlineEditor]
public class Item : ScriptableObject
{
    [BoxGroup("Basic Info")]
    [LabelWidth(100f)]
    public int id;

    [BoxGroup("Basic Info")]
    [LabelWidth(100f)]
    public string itemName;

    [BoxGroup("Basic Info")]
    [LabelWidth(100f)]
    [TextArea]
    public string description;

    [HorizontalGroup("Game Data", 75f)]
    [PreviewField(75)]
    [HideLabel]
    public Sprite icon;

    [VerticalGroup("Game Data/Stats")]
    [LabelWidth(100f)]
    [Range(0, 100)]
    public int value;

    [EnumToggleButtons]
    [Title("Item Type")]
    [HideLabel]
    public ItemType itemType;

    public enum ItemType
    {
        Consumable,
        Weapon,
        Throwable
    }
}
