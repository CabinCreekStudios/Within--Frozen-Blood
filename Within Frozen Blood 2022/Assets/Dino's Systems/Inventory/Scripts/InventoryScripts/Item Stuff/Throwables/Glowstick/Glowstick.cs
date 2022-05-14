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
    //GameObject player;
    //GameObject player2;

    public GameObject throwObject;

    public string itemThrowObj;

    public int throwButton = 0;

    PhotonView PV;

    private void Awake()
    {
        PV = GetComponent<PhotonView>();


        if (PV.IsMine)
        {
            //cam = GameObject.FindGameObjectWithTag("MainCamera").GetComponent<Camera>();

            

            throwPos2 = GameObject.FindGameObjectWithTag("Player").transform;
            //player2 = GameObject.FindGameObjectWithTag("Player");
        }

        inventoryObject = GameObject.FindGameObjectWithTag("Inventory");
        equipmentSlot = GameObject.FindGameObjectWithTag("Player").GetComponentInChildren<EquipmentSlot>();

        throwPos = GameObject.FindGameObjectWithTag("OtherPlayer").transform;
        //player = GameObject.FindGameObjectWithTag("OtherPlayer");
    }

    private void Start()
    {

    }

    private void Update()
    {
        /*
        if (Input.GetMouseButtonDown(throwButton))
        {
            Throw();

            equipmentSlot.item = null;
        }
        */

        if (!PV.IsMine)
        {
            gameObject.transform.parent = throwPos;
        }
    }

    void Throw()
    {
        PhotonNetwork.Instantiate("GlowStickThrow", transform.position, cam.transform.rotation);
        PhotonNetwork.Destroy(gameObject);

        Debug.Log("Glowstick Thrown");
    }
}
