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




        public void Dawage_Calculation(DinoRage_Classes.COMBAT_INFORMATION _target, DinoRage_Effect_DATA _effect ,
            DinoRage_Classes.COMBAT_INFORMATION _attacker)
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

        public void Calculate_Instant_Damage(DinoRage_Classes.COMBAT_INFORMATION _target, DinoRage_Effect_DATA _effect,
            DinoRage_Classes.COMBAT_INFORMATION _attacker)
        {
            // this is to calculate the amours effect against other elements
            float _amour_help = (_target._amour * _amour_effect / 100);
            switch (_effect._instant_damage_info._damage_type)
            {
                case DinoRage_Enums.DAMAGE_TYPES.PHYSICAL_DAMAGE:
                    
                    float _temp_damage_amount = 0f;
                    // this first calculates the _thep_damage amount based on if the damage is random
                    if (_effect._instant_damage_info._random_or_not == DinoRage_Enums.RANDOM_SETTINGS.USE_RANDOM)
                    {
                        _temp_damage_amount = Random.Range(_effect._instant_damage_info._random_damage_amount.x, _effect._instant_damage_info._random_damage_amount.y);
                    }
                    else { _temp_damage_amount = _effect._instant_damage_info._non_random_damage_amount; }

                    float _attack_damage = _attacker._basic_damage + _temp_damage_amount;
                    if ( _target._amour >= _attack_damage) { return; }
                    _target._health = _target._health - (_attack_damage - _target._amour);
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