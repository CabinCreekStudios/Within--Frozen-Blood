using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Sirenix.OdinInspector;
using UnityEngine.UI;

namespace DinosSystems.Inventory
{
    public class SideItemSlot : MonoBehaviour
    {
        private Inventory inventory;
        public Image icon;
        public KeyCode dropSideItemKey;

        private void Awake()
        {
            inventory = GameObject.FindGameObjectWithTag("Inventory").GetComponent<Inventory>();
        }

        private void Update()
        {
            if (Input.GetKeyDown(dropSideItemKey))
                RemoveItem();
        }

        public void RemoveItem()
        {
            if (inventory.isHoldingSide)
            {
                inventory.isHoldingSide = false;
                icon.sprite = null;
                icon.enabled = false;
                Debug.Log("Dropped Side Item!");
            }
        }
    }
}