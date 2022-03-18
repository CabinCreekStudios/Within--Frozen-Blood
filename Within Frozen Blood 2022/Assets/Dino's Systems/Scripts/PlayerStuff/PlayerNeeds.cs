using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
using Sirenix.OdinInspector;

public class PlayerNeeds : MonoBehaviour
{
    public static PlayerNeeds Instance;

    [TabGroup("Basic Info")]
    public float health;
    [TabGroup("Basic Info")]
    public float stamina;

    [TabGroup("Misc")]
    public TMP_Text healthText;
    [TabGroup("Misc")]
    public GameObject inventoryObject;

    private void Awake()
    {
        Instance = this;
    }

    private void Update()
    {
        // Calculating Health //
        healthText.text = $"Health:{health}";


        // Open And Close Inventory //
        if (Input.GetKeyDown(KeyCode.I))
        {
            inventoryObject.active = !inventoryObject.activeSelf;
            MouseLook.Instance.isLocked = !MouseLook.Instance.isLocked;
            InventoryManager.Instance.ListItems();
        }
    }

    public void IncreaseHealth(float value)
    {
        health += value;
        healthText.text = $"Health:{health}";
    }
}
