using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DinoRage.Enums;
using DinoRage.Classes;
using Sirenix.OdinInspector;

[CreateAssetMenu(fileName = "Item_Data", menuName = "DinoRage/Data/Item_Data")]
public class DinoRage_Item_DATA : ScriptableObject
{
    public int item_DI = -1;
    public string item_name = "item";

    public DinoRage_Enums.ITEM_TYPE _item_type;
    public int _max_stack_size;

    // need to add consumed effect
    [ShowIf("_item_type", DinoRage_Enums.ITEM_TYPE .COMSUMABLE)]
    public DinoRage_Effect_DATA _consumed_effect = null;

    [ShowIf("_item_type", DinoRage_Enums.ITEM_TYPE.WEAPON)]
    public DinoRage_Classes.WEAPON_DATA _weapon_info = null;

    [ShowIf("_item_type", DinoRage_Enums.ITEM_TYPE.CLOTHING)]
    public DinoRage_Classes.CLOTHING_DATA _clothing_info = null;



}
