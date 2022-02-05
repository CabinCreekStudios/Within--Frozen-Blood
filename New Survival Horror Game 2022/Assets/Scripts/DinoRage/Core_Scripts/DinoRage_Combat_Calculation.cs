using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DinoRage.Classes;
using DinoRage.Enums;



namespace DinoRage.Combat
{



    public class DinoRage_Combat_Calculation : MonoBehaviour
    {
        // percentage that amour helps prevent damage
        public float _amour_effect = 20f;


        public static DinoRage_Combat_Calculation Instance { get; set; }


        private void OnEnable()
        {
            Instance = this;
        }




        public void Damage_Calculation(DinoRage_Combat_Node _target, DinoRage_Effect_DATA _effect ,
            DinoRage_Combat_Node _attacker)
        {

            switch (_effect._effect_type)
            {
                case Enums.DinoRage_Enums.EFFECT_TYPE.INSTANT_DAMGE:
                    Calculate_Instant_Damage(_target, _effect, _attacker);
                    break;

                case Enums.DinoRage_Enums.EFFECT_TYPE.DAMAGE_OVER_TIME:

                    break;

                case Enums.DinoRage_Enums.EFFECT_TYPE.INSTANT_HEAL:

                    break;               

                case Enums.DinoRage_Enums.EFFECT_TYPE.HEAL_OVER_TIME:

                    break;

                case Enums.DinoRage_Enums.EFFECT_TYPE.STATS:

                    break;
            }
        }

        public void Calculate_Instant_Damage(DinoRage_Combat_Node _target, DinoRage_Effect_DATA _effect,
            DinoRage_Combat_Node _attacker)
        {
            // this first calculates the _thep_damage amount based on if the damage is random
            float _effects_damage;
            float _total_damage;
            if (_effect._instant_damage_info._random_or_not == DinoRage_Enums.RANDOM_SETTINGS.USE_RANDOM)
            {
                _effects_damage = Random.Range(_effect._instant_damage_info._random_damage_amount.x, _effect._instant_damage_info._random_damage_amount.y);
            }
            else { _effects_damage = _effect._instant_damage_info._non_random_damage_amount; }
            

            // this is to calculate the amours effect against other elements
            float _amour_help = (_target._combat_info._amour * _amour_effect / 100);
            switch (_effect._instant_damage_info._damage_type)
            {
                case DinoRage_Enums.DAMAGE_TYPES.PHYSICAL_DAMAGE:                                                         
                    // adds the damage to the _attackers damage
                    _total_damage = _attacker._combat_info._basic_damage + _effects_damage - _target._combat_info._amour;    
                    // makes sure the amount is above 0 so it dosent add health
                    if (_total_damage <= 0) { return; }
                    // this part runs if it needs to take health away
                    _target._combat_info._health = _target._combat_info._health - _total_damage;

                    break;

                case DinoRage_Enums.DAMAGE_TYPES.COLD_DAMAGE:

                    break;

                case DinoRage_Enums.DAMAGE_TYPES.FIRE_DAMAGE:

                    break;

                case DinoRage_Enums.DAMAGE_TYPES.POISON_DAMAGE:

                    break;

            }

        }

    }
}