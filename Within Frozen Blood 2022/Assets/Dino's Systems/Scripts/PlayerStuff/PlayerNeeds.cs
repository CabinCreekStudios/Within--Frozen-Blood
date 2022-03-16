using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class PlayerNeeds : MonoBehaviour
{
    public static PlayerNeeds Instance;

    public float health;
    public float stamina;

    public TMP_Text healthText;

    private void Awake()
    {
        Instance = this;
    }

    public void IncreaseHealth(float value)
    {
        health += value;
        healthText.text = $"Health:{health}";
    }
}
