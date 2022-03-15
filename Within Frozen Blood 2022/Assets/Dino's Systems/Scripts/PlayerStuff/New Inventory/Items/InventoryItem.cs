using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class InventoryItem : MonoBehaviour
{
    public Item itemData;
    public TMP_Text amountText;

    public int amount = 1;

    private void Update()
    {
        if (amount <= 1)
        {
            amountText.gameObject.SetActive(false);
        }
        else
        {
            amountText.gameObject.SetActive(false);
        }

        amountText.text = amount.ToString();
    }
}
