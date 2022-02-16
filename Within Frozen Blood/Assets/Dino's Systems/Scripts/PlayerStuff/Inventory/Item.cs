using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Sirenix.OdinInspector;

[CreateAssetMenu(fileName = "Item", menuName = "Dino's_Systems/Inventory/Items/Item")]
public class Item : ScriptableObject
{
    [BoxGroup("Basic Info")]
    [LabelWidth(100)]
    public string itemName;
    [LabelWidth(100)]
    [BoxGroup("Basic Info")]
    [TextArea]
    public string description;

    public bool isThrowable;

    [ShowIf("isThrowable")]
    [TabGroup("Throwable")]
    public bool isFlare;
    [TabGroup("Throwable")]
    [ShowIf("isFlare")]
    public float brightness;
    [TabGroup("Throwable")]
    [ShowIf("isFlare")]
    public float burnoutTime;

    [HorizontalGroup("Game Data", 75)]
    [PreviewField(75)]
    [HideLabel]
    public GameObject itemModel;
}
