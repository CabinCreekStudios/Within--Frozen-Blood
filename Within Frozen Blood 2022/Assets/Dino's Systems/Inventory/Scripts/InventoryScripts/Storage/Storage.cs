using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class Storage : MonoBehaviour
{
    public GameObject storageInventory;
    public GameObject inventory;
    public GameObject equipmentPanel;

    public TMP_Text openText;

    public KeyCode openKey;

    public bool canOpen;

    private void OnValidate()
    {
        if (openText != null)
            openText.text = openKey.ToString();
    }

    private void Awake()
    {
        if (!canOpen)
            openText.gameObject.SetActive(false);
    }

    private void Update()
    {
        if (canOpen)
        {
            openText.gameObject.SetActive(true);
            PlayerNeeds.Instance.cursor.SetActive(false);

            if (Input.GetKeyDown(openKey))
                OpenStorage();
        }else if (!canOpen)
        {
            openText.gameObject.SetActive(false);
            PlayerNeeds.Instance.cursor.SetActive(true);
        }

        if (Input.GetKeyDown(KeyCode.I) && canOpen)
        {
            storageInventory.SetActive(false);
        }
    }

    void OpenStorage()
    {
        storageInventory.SetActive(true);
        inventory.SetActive(true);
        equipmentPanel.SetActive(true);
    }

    void CloseStorage()
    {
        storageInventory.SetActive(false);
        inventory.SetActive(false);
        equipmentPanel.SetActive(false);
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            canOpen = true;
            
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.tag == "Player")
        {
            canOpen = false;
            CloseStorage();
        }
    }
}
