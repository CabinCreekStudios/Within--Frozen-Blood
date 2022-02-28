using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Sirenix.OdinInspector;
using DinosSystems.Inventory;

public enum TypeOfThrowableItemEquipped
{
    None,
    GlowStick,
    Flare
}

public class ThrowableItem : MonoBehaviour
{
    [TabGroup("Basic Properties")]
    public SideItem sideItem;
    [TabGroup("Basic Properties")]
    private SideItemSlot sideItemSlot;
    [TabGroup("Basic Properties")]
    public TypeOfThrowableItemEquipped typeOfThrowableItem;

    [TabGroup("Mechanics")]
    public GameObject throwObject;
    [TabGroup("Mechanics")]
    public GameObject throwPosition;

    [TabGroup("Inputs")]
    public int throwInput;

    private void Awake()
    {
        sideItemSlot = GameObject.FindGameObjectWithTag("SideItemSlot").GetComponent<SideItemSlot>();
    }

    private void Update()
    {
        if (sideItem.isGlowStickEquipped)
            GlowStick();
        if (sideItem.isGlowStickEquipped)
            Debug.Log("GlowStick Not Equipped");
    }

    public void GlowStick()
    {
        if (typeOfThrowableItem == TypeOfThrowableItemEquipped.GlowStick)
        {
            if (Input.GetMouseButtonDown(throwInput))
            {
                ThrowGlowStick();
                Debug.Log("GlowStick Thrown");
            }


            Debug.Log("GlowStick Equipped!");
        }
    }

    public void ThrowGlowStick()
    {
        Instantiate(throwObject, throwPosition.transform.position, Quaternion.identity);

        sideItem.isGlowStickEquipped = false;
        sideItem.glowStickParts.SetActive(false);

        sideItemSlot.RemoveItem();
    }
}
