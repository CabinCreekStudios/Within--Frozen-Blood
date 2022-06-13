using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
using Sirenix.OdinInspector;
using Photon.Pun;

public class PlayerNeeds : MonoBehaviour
{
    public static PlayerNeeds Instance;

    [TabGroup("Basic Info")]
    [Range(0f, 100f)]
    public float health;
    [TabGroup("Basic Info")]
    [Range(0f, 100f)]
    public float hunger;
    [TabGroup("Basic Info")]
    [Range(0f, 100f)]
    public float thirst;
    [TabGroup("Basic Info")]
    [Range(0f, 100f)]
    public float stamina;

    [TabGroup("Animation")]
    public Animator _anim;

    [TabGroup("Flashlight")]
    public float flashlightBattery = 100f;
    [TabGroup("Flashlight")]
    public Slider flashlightBatterySlider; 

    [TabGroup("Misc")]
    public TMP_Text healthText;
    [TabGroup("Misc")]
    public Slider healthSlider;
    [TabGroup("Misc")]
    public Slider hungerSlider;
    [TabGroup("Misc")]
    public Slider thirstSlider;
    [TabGroup("Misc")]
    public GameObject inventoryObject;
    [TabGroup("Misc")]
    public GameObject equipmentObject;

    public float setWalkSpeedAnim;

    private void Awake()
    {
        Instance = this;

        _anim.SetBool("isIdle", true);
    }

    private void OnValidate()
    {
        CalculatingValues();

        GetStatsOnValidate();
    }

    private void Update()
    {
        // Calculating Health, Flashlight Battery //
        CalculatingValues();

        // Opening/Closing Inventory //
        CalculateInventory();

        // Controls If Cursor Is Locked //
        CalculateCameraValues();

        // Calculating Animation //
        CalculateMoveAnimation();
    }

    void GetStatsOnValidate()
    {
        // Health //
        healthSlider.value = health;
        healthText.text = $"Health:{health}";

        // Hunger //
        hungerSlider.value = hunger;
        healthText.text = $"Health:{health}";

        // Health //
        thirstSlider.value = thirst;
        healthText.text = $"Health:{health}";
    }

    public void IncreaseHealth(float value)
    {
        health += value;
    }

    public void IncreaseHunger(float value)
    {
        hunger += value;
    }

    public void IncreaseThirst(float value)
    {
        thirst += value;
    }

    public void CalculateMoveAnimation()
    {
        if (Input.GetKeyDown(KeyCode.W))
        {
            _anim.SetFloat("SpeedForward", setWalkSpeedAnim);
        }
        else if (Input.GetKeyDown(KeyCode.A))
        {
            _anim.SetFloat("SpeedLeft", setWalkSpeedAnim);
        }
        else if (Input.GetKeyDown(KeyCode.S))
        {
            _anim.SetFloat("SpeedBackward", setWalkSpeedAnim);
        }
        else if (Input.GetKeyDown(KeyCode.D))
        {
            _anim.SetFloat("SpeedRight", setWalkSpeedAnim);
        }
        // Getting Keys Up //
        if (Input.GetKeyUp(KeyCode.W))
        {
            _anim.SetFloat("SpeedForward", 0f);
        }
        else if (Input.GetKeyUp(KeyCode.A))
        {
            _anim.SetFloat("SpeedLeft", 0f);
        }
        else if (Input.GetKeyUp(KeyCode.S))
        {
            _anim.SetFloat("SpeedBackward", 0f);
        }
        else if (Input.GetKeyUp(KeyCode.D))
        {
            _anim.SetFloat("SpeedRight", 0f);
        }
    }

    public void CalculatingValues()
    {
        // Health //
        if (health >= 100)
            health = 100;

        // Hunger //
        if (hunger >= 100)
            hunger = 100;

        // Thirst //
        if (thirst >= 100)
            thirst = 100;

        healthSlider.value = health;
        healthText.text = $"Health:{health}";

        hungerSlider.value = hunger;
        healthText.text = $"Hunger:{hunger}";

        thirstSlider.value = thirst;
        healthText.text = $"Thirst:{thirst}";

        // Flashlight //
        if (flashlightBattery >= 100f)
            flashlightBattery = 100f;

        flashlightBatterySlider.value = flashlightBattery;
    }

    public void CalculateInventory()
    {
        // Open And Close Inventory //
        if (Input.GetKeyDown(KeyCode.I))
        {
            if (equipmentObject != null)
                equipmentObject.active = !equipmentObject.activeSelf;

            if (inventoryObject != null)
                inventoryObject.active = !inventoryObject.activeSelf;
        }
    }

    public void CalculateCameraValues()
    {
        if (inventoryObject.active)
        {
            MouseLook.Instance.isLocked = false;
        }

        if (!inventoryObject.active)
        {
            MouseLook.Instance.isLocked = true;
        }
    }
}