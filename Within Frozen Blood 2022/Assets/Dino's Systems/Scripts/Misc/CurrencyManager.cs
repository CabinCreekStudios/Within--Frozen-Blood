using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class CurrencyManager : MonoBehaviour
{
    public int currencyAmount = 0;
    public TMP_Text currencyText;

    private void OnValidate()
    {
        CalculateCurrency();
    }

    public void Update()
    {
        CalculateCurrency();
    }

    public void CalculateCurrency()
    {
        if (currencyAmount <= 0)
            currencyAmount = 0;

        if (currencyAmount >= 9999999)
            currencyAmount = 9999999;

        if (currencyText != null)
            currencyText.text = "" + currencyAmount;
    }
}
