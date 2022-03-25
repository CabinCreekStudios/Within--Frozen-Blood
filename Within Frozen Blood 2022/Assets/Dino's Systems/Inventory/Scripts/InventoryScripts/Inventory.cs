using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Inventory : MonoBehaviour
{
    public static Inventory Instance;
    private void Awake()
    {
        Instance = this;
    }

    public bool[] isFull;
    public GameObject[] slots;
}
