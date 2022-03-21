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

    [TabGroup("Animation")]
    public Animator _anim;

    [TabGroup("Misc")]
    public TMP_Text healthText;
    [TabGroup("Misc")]
    public GameObject inventoryObject;
    [TabGroup("Misc")]
    public GameObject equipmentObject;

    private void Awake()
    {
        Instance = this;

        _anim.SetBool("isIdle", true);
    }

    private void Update()
    {
        // Calculating Health //
        healthText.text = $"Health:{health}";

        // Open And Close Inventory //
        if (Input.GetKeyDown(KeyCode.I))
        {
            equipmentObject.active = !equipmentObject.activeSelf;
            inventoryObject.active = !inventoryObject.activeSelf;
            MouseLook.Instance.isLocked = !MouseLook.Instance.isLocked;
        }

        // List Items //
        if (Input.GetKeyDown(KeyCode.I))
        {
            InventoryManager.Instance.ListItems();
            InventoryManager.Instance.SetInventoryItems();
        }

        // Calculating Animation //
        CalculateMoveAnimation();
    }

    public void IncreaseHealth(float value)
    {
        health += value;
        healthText.text = $"Health:{health}";
    }

    public void CalculateMoveAnimation()
    {
        if (Input.GetKeyDown(KeyCode.W) || Input.GetKeyDown(KeyCode.A) || Input.GetKeyDown(KeyCode.S) || Input.GetKeyDown(KeyCode.D))
        {
            _anim.SetBool("isWalking", true);
        }else if (Input.GetKeyUp(KeyCode.W) || Input.GetKeyUp(KeyCode.A) || Input.GetKeyUp(KeyCode.S) || Input.GetKeyUp(KeyCode.D))
        {
            _anim.SetBool("isWalking", false);
        }
    }
}
