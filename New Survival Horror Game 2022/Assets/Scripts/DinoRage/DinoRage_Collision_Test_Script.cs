using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DinoRage.Combat;

namespace DinoRage
{
    public class DinoRage_Collision_Test_Script : MonoBehaviour
    {
        public DinoRage_Combat_Node _causing_damage;
        public DinoRage_Effect_DATA _effect_data;
        public DinoRage_Combat_Node _target;

        
        private void OnTriggerEnter(Collider other)
        {
            //checks if the player collided  with the collider then dose damage to the player
            if (other.tag == "Player")
            {
                Debug.Log("Triggered by Player");
                // this gets combat data from the other 
                _target = other.GetComponent<DinoRage_Combat_Node>();
                // this send all the info off for calculation
                DinoRage_Combat_Calculation.Instance.Damage_Calculation(_target, _effect_data, _causing_damage);
            }
            /*
            else if(other.tag == "Interacable")
            {
                // testing interactable node causes damage
                 DinoRage_Interacatable_Node _temp_interact = other.GetComponent<DinoRage_Interacatable_Node>();
                DinoRage_Combat_Calculation.Instance.Calculate_Instant_Damage(_causing_damage, _temp_interact._the_effect, null);
            }
            */
        }
    }
}