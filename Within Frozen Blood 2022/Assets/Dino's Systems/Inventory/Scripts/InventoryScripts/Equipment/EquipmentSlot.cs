using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum EquipmentSlotType
{
    None,
    Item,
    Shoes,
    Pants,
    Shirt,
    Coat,
    Gloves,
    Hat
}

public class EquipmentSlot : MonoBehaviour
{
    public EquipmentSlotType equipmentSlotType;
    private void OnValidate()
    {
        gameObject.name = "" + equipmentSlotType.ToString() + " Slot";
    }
}
