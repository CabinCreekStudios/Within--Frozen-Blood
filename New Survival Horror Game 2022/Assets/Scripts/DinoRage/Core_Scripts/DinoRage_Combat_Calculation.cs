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


        public float _effects_damage;
        public int _target_resistance = 0;
        public int _attacker_damage = 0;
        public float _total_damage;





        public static DinoRage_Combat_Calculation Instance { get; set; }


        private void OnEnable()
        {
            Instance = this;
        }




        public void Damage_Calculation(DinoRage_Combat_Node _target, DinoRage_Effect_DATA _effect ,
            DinoRage_Combat_Node _attacker)
        {
            Debug.Log("recived info about the damage");
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
            // first checks for a dodge on the target to see if it can just skip everything
            for (int i = 0; i <= _target._combat_stats.Length - 1; i++)
            {             
                    //checking for dodge
                    if (_target._combat_stats[i]._type == DinoRage_Enums.COMBAT_NODE_TYPE.DODGE_CHANCE)
                    {
                    int _random_dodge = Random.Range(0, 100);
                    if (_random_dodge <= _target._combat_stats[i]._amount)
                    // need to add a function before return to let the attacked know they dodged
                    { return; }
                    else
                    { break; }
                    }               
            }


            // this first calculates the _thep_damage amount based on if the damage is random

            // this part calculates the damager from the effect based if its random or not
            if (_effect._instant_damage_info._random_or_not == DinoRage_Enums.RANDOM_SETTINGS.USE_RANDOM)
            {
                _effects_damage = (int)Random.Range(_effect._instant_damage_info._random_damage_amount.x, _effect._instant_damage_info._random_damage_amount.y);
            }
            else { _effects_damage = _effect._instant_damage_info._non_random_damage_amount; }
            // this is the loop to calculate damage
            for(int i = 0; i <= _target._combat_stats.Length - 1; i++)
            {
                // first checks if they are the same type
                if(_target._combat_stats[i]._type_effected == _effect._instant_damage_info._damage_type )
                {
                    //now checks if its a resistances if it is it saves as the resistance and ends this loop
                    if (_target._combat_stats[i]._type == DinoRage_Enums.COMBAT_NODE_TYPE.RESISTANCE)
                    {
                        _target_resistance = _target._combat_stats[i]._amount;
                        break;
                    }
                }
            }
            if (_attacker != null)
            {
                // will add a null here after testing
                for (int i = 0; i <= _attacker._combat_stats.Length - 1; i++)
                {
                    // first checks if they are the same type
                    if (_attacker._combat_stats[i]._type_effected == _effect._instant_damage_info._damage_type)
                    {
                        // now makes sure if the damage type for the attacker
                        if (_attacker._combat_stats[i]._type == DinoRage_Enums.COMBAT_NODE_TYPE.DAMAGE)
                        {
                            _attacker_damage = _attacker._combat_stats[i]._amount;
                        }
                    }
                }
            }
            else
            {
                _attacker_damage = 0;
            }


            // the final calculation
            _total_damage = _attacker_damage + _effects_damage - _target_resistance;
            // first make sure its not 0 or below
            if (_total_damage <= 0) { return; }
            // now applys the damage
            _target._combat_info._health = _target._combat_info._health - _total_damage;








            /*
            // this is to calculate the amours effect against other elements
            float _amour_help = (_target._combat_info._amour * _amour_effect / 100);
            switch (_effect._instant_damage_info._damage_type)
            {
                case DinoRage_Enums.DAMAGE_TYPES.PHYSICAL_DAMAGE:
                    // adds the damage to the _attackers damage also works if attacker is null and its just an effec
                    if (_attacker != null)
                    { _total_damage = _attacker._combat_info._basic_damage + _effects_damage - _target._combat_info._amour; }
                    else
                    { _total_damage =_effects_damage - _target._combat_info._amour; }                                    
                    // makes sure the amount is above 0 so it dosent add health
                    if (_total_damage <= 0) { return; }

                    // this part runs if it needs to take health away
                    _target._combat_info._health = _target._combat_info._health - _total_damage;

                    break;

                case DinoRage_Enums.DAMAGE_TYPES.COLD_DAMAGE:
                    // adds the damage to the _attackers damage also works if attacker is null and its just an effec
                    if (_attacker != null)
                    { _total_damage = _attacker._combat_info._cold_damage + _effects_damage - _target._combat_info._cold_resistance; }
                    else
                    { _total_damage = _effects_damage - _target._combat_info._cold_resistance; }
                    // makes sure the amount is above 0 so it dosent add health
                    if (_total_damage <= 0) { return; }
                    // this part runs if it needs to take health away
                    _target._combat_info._health = _target._combat_info._health - _total_damage;

                    break;

                case DinoRage_Enums.DAMAGE_TYPES.FIRE_DAMAGE:

                    break;

                case DinoRage_Enums.DAMAGE_TYPES.POISON_DAMAGE:

                    break;

            }
            */



        }

    }
}