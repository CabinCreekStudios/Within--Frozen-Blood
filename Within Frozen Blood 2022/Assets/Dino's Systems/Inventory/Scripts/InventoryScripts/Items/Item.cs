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
    [Tooltip("The Item ID")]
    public int id;

    [BoxGroup("Basic Info")]
    [LabelWidth(100f)]
    [Tooltip("The Name Of The Item")]
    public string itemName;

    [BoxGroup("Basic Info")]
    [LabelWidth(100f)]
    [TextArea]
    [Tooltip("The Description For The Item")]
    public string description;

    [HorizontalGroup("Game Data", 75f)]
    [PreviewField(75)]
    [HideLabel]
    [Tooltip("The Icon For The Item")]
    public Sprite icon;

    [VerticalGroup("Game Data/Stats")]
    [LabelWidth(100f)]
    [Tooltip("The Item That Appears In Hand")]
    public GameObject itemUse;

    [VerticalGroup("Game Data/Stats")]
    [LabelWidth(100f)]
    [Tooltip("The Item That Appears When You Drop It")]
    public GameObject itemDrop;

    [VerticalGroup("Game Data/Stats")]
    [LabelWidth(100f)]
    [Tooltip("The Label Of When You Hover Over An Item In The Inventory")]
    public string itemUseName;

    [VerticalGroup("Game Data/Stats")]
    [LabelWidth(100f)]
    [Range(0, 100)]
    [Tooltip("The Value Of A Set Item Used For Consumables")]
    public int value;

    [EnumToggleButtons]
    [Title("Item Type")]
    [HideLabel]
    [Tooltip("The Item Types")]
    public ItemType itemType;

    public enum ItemType
    {
        Consumable,
        Weapon,
        Throwable
    }
}
