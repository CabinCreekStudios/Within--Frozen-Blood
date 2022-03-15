using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Sirenix.OdinInspector;
using UnityEngine.UI;

namespace DinosSystems.Inventory
{
    public class SideItemSlot : MonoBehaviour
    {
        [TabGroup("Basic Properties")]
        private Inventory inventory;

        [TabGroup("Basic Properties")]
        public Image icon;

        [TabGroup("Keys")]
        public KeyCode dropSideItemKey;

        [TabGroup("Game Objects")]
        public GameObject dropPosition;

        [TabGroup("Game Objects")]
        public GameObject dropItem;

        private void Awake()
        {
            inventory = GameObject.FindGameObjectWithTag("Inventory").GetComponent<Inventory>();
        }

        private void Update()
        {
            if (Input.GetKeyDown(dropSideItemKey))
                DropItem();
        }

        public void DropItem()
        {
            if (inventory.isHoldingSide)
                Instantiate(dropItem, dropPosition.transform.position, Quaternion.identity);

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