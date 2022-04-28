using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Photon.Pun;

public class Inventory : MonoBehaviour
{
    PhotonView PV;

    public static Inventory Instance;
    private void Awake()
    {
        PV = GetComponent<PhotonView>();

        if (PV.IsMine)
            Instance = this;
    }

    public bool[] isFull;
    public GameObject[] slots;
}
