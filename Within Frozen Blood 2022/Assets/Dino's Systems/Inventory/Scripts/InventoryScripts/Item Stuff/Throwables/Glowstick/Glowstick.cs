using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Photon.Pun;

public class Glowstick : MonoBehaviour
{
    Camera cam;

    public EquipmentSlot equipmentSlot;
    public GameObject inventoryObject;

    public Transform throwPos;
    Transform throwPos2;
    GameObject player;
    GameObject player2;

    public GameObject throwObject;

    public int throwButton = 0;

    PhotonView PV;

    private void Awake()
    {
        PV = GetComponent<PhotonView>();

        cam = GameObject.FindGameObjectWithTag("MainCamera").GetComponent<Camera>();

        inventoryObject = GameObject.FindGameObjectWithTag("Inventory");
        equipmentSlot = GameObject.FindGameObjectWithTag("Player").GetComponentInChildren<EquipmentSlot>();

        throwPos = GameObject.FindGameObjectWithTag("OtherPlayer").transform;
        player = GameObject.FindGameObjectWithTag("OtherPlayer");

        throwPos2 = GameObject.FindGameObjectWithTag("Player").transform;
        player2 = GameObject.FindGameObjectWithTag("Player");
    }

    private void Start()
    {

    }

    private void Update()
    {
        if (!PV.IsMine)
        {
            gameObject.transform.parent = throwPos;
        }
        //gameObject.transform.position = PlayerMovement.Instance.otherPlayerEquip.position;

        if (PlayerMovement.Instance.PV.IsMine)
        {
            if (Input.GetMouseButtonDown(throwButton) && !inventoryObject.active)
            {
                equipmentSlot.item = null;

                if (throwObject != null)
                    Throw();
            }
        }
    }

    void Throw()
    {
        Instantiate(throwObject, throwPos.position, Quaternion.identity);
        Destroy(gameObject);
    }
}
