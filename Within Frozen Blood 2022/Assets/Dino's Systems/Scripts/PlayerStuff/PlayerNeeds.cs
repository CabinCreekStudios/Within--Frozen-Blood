using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
using Sirenix.OdinInspector;
using Photon.Pun;

public class PlayerNeeds : MonoBehaviour
{
    PhotonView PV;

    public static PlayerNeeds Instance;

    [TabGroup("Basic Info")]
    [Range(0f, 100f)]
    public float health;
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
    public GameObject inventoryObject;
    [TabGroup("Misc")]
    public GameObject equipmentObject;

    public float setWalkSpeedAnim;

    public KeyCode saveKey;

    private void Awake()
    {
        PV = GetComponent<PhotonView>();

        if (PV.IsMine)
        {
            Instance = this;

            _anim.SetBool("isIdle", true);
        }
    }

    private void Start()
    {
        if (!PV.IsMine)
        {
            Destroy(healthText.gameObject);
            Destroy(healthSlider.gameObject);
            Destroy(inventoryObject);
            Destroy(equipmentObject);
        }
    }

    private void OnValidate()
    {
        CalculatingValues();

        // Health //
        healthSlider.value = health;
        healthText.text = $"Health:{health}";

        // Flashlight //
        //flashlightBatterySlider.value = flashlightBattery;
    }

    private void Update()
    {
        if (PV.IsMine)
        {
            // Calculating Health //
            CalculatingValues();

            // Health //
            healthSlider.value = health;
            healthText.text = $"Health:{health}";

            // Flashlight //
            flashlightBatterySlider.value = flashlightBattery;

            // Open And Close Inventory //
            if (Input.GetKeyDown(KeyCode.I))
            {
                if (equipmentObject != null)
                    equipmentObject.active = !equipmentObject.activeSelf;

                if (inventoryObject != null)
                    inventoryObject.active = !inventoryObject.activeSelf;
            }

            if (inventoryObject.active)
            {
                MouseLook.Instance.isLocked = false;
                MouseLookItems.Instance.isLocked = false;
            }

            if (!inventoryObject.active)
            {
                MouseLook.Instance.isLocked = true;
                MouseLookItems.Instance.isLocked = true;
            }

            // Calculating Animation //
            CalculateMoveAnimation();
        }
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
            _anim.SetFloat("Speed", setWalkSpeedAnim);
        }else if (Input.GetKeyUp(KeyCode.W) || Input.GetKeyUp(KeyCode.A) || Input.GetKeyUp(KeyCode.S) || Input.GetKeyUp(KeyCode.D))
        {
            _anim.SetFloat("Speed", 0);
        }
    }

    public void CalculatingValues()
    {
        if (health >= 100)
            health = 100;

        if (flashlightBattery >= 100f)
            flashlightBattery = 100f;
    }
}