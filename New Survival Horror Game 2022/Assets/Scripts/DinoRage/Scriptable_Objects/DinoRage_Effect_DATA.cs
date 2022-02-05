using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Sirenix.OdinInspector;
using DinoRage.Enums;
using DinoRage.Classes;

[CreateAssetMenu(fileName = "Effect_Data", menuName = "DinoRage/Data/Effect_Data")]
public class DinoRage_Effect_DATA : ScriptableObject
{
    public DinoRage_Enums.EFFECT_TYPE _effect_type = DinoRage_Enums.EFFECT_TYPE.INSTANT_DAMGE;

    [ShowIf("_effect_type", DinoRage_Enums.EFFECT_TYPE.INSTANT_DAMGE)]
    public DinoRage_Classes.INSTANT_DAMAGE _instant_damage_info = null;

    [ShowIf("_effect_type", DinoRage_Enums.EFFECT_TYPE.DAMAGE_OVER_TIME)]
    public DinoRage_Classes.DAMAGE_OVER_TIME _damage_over_time_info = null;

    [ShowIf("_effect_type", DinoRage_Enums.EFFECT_TYPE.INVENTERY)]
    public DinoRage_Classes.ADD_ITEM_TO_INVETORY _add_item_info = null;







}
