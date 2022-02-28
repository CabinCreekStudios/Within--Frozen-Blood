using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum typeOfItemHolding
{
    None,
    Glowstick,
    Flare
}

namespace DinosSystems.Inventory
{
    public class Inventory : MonoBehaviour
    {
        public bool isHoldingSide;
        public bool isHoldingWeapon;

        public bool sideWeaponEquipped;

        public string nameOfSideItem;
        public SideItem sideItem;

        public KeyCode equipButton;

        private void Update()
        {
            if (isHoldingSide)
            {
                if (Input.GetKeyDown(equipButton))
                {
                    Equip();
                }
            }

            if (!isHoldingSide)
            {
                UnEquip();
            }
        }

        public void Equip()
        {
            sideItem.itemModel.SetActive(!sideItem.itemModel.active);

            if (nameOfSideItem == "GlowStick")
            {
                sideItem.glowLight.enabled = true;
                sideItem.glowStickParts.SetActive(true);
                sideItem.glowLight.intensity = sideItem.glowStickBrightness;
                sideItem.glowLight.range = sideItem.radiusGlow;
                sideItem.isGlowStickEquipped = true;

                if (!sideItem.itemModel.active)
                    sideItem.glowLight.intensity -= sideItem.glowStickBrightnessDimAmount;

                if (sideItem.itemModel.active)
                    sideItem.glowLight.intensity += sideItem.glowStickBrightnessDimAmount;
            }
        }

        public void UnEquip()
        {
            if (sideItem.glowLight != null)
                sideItem.glowLight.enabled = false;

            if (sideItem.itemModel != null)
                sideItem.itemModel.SetActive(false);

            sideItem.isGlowStickEquipped = false;
            nameOfSideItem = " ";
            sideItem = null;
        }
    }
}