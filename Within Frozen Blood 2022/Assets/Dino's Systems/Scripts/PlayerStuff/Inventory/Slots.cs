using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace DinosSystems.Inventory
{
    public enum TypeOfSlot
    {
        Main,
        Side
    }

    public class Slots : MonoBehaviour
    {
        public TypeOfSlot typeOfSlot;
        public Image icon;


        public void AddItem()
        {

        }

        public void RemoveItem()
        {

        }
    }
}