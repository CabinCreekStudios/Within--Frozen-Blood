using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DinoRage.Combat;

namespace DinoRage
{
    public class DinoRage_Collision_Test_Script : MonoBehaviour
    {
        public DinoRage_Combat_Node _the_player;
        public DinoRage_Effect_DATA _effect_data;
        public DinoRage_Combat_Node _npc_combat;

        
        private void OnTriggerEnter(Collider other)
        {
            //Check to see if the tag on the collider is equal to Enemy
            if (other.tag == "Enemy")
            {
                Debug.Log("Triggered by Enemy");
                _npc_combat = other.GetComponent<DinoRage_Combat_Node>();
                DinoRage_Combat_Calculation.Instance.Calculate_Instant_Damage(_npc_combat, _effect_data, _the_player);
            }
            else if(other.tag == "Interacable")
            {
                // testing interactable node causes damage
                 DinoRage_Interacatable_Node _temp_interact = other.GetComponent<DinoRage_Interacatable_Node>();
                DinoRage_Combat_Calculation.Instance.Calculate_Instant_Damage(_the_player, _temp_interact._the_effect, null);
            }
        }
    }
}