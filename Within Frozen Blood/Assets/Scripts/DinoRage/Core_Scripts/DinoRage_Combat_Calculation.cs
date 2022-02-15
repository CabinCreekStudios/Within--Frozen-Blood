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


        public int _effects_damage;
        public int _target_resistance = 0;
        public int _attacker_damage = 0;
        public int _total_damage;

        public float _total_dodge_amount = 0;
        public float _heal_bonuce_total = 0;

        public int _total_health_steal_percentage = 0;
        public int _total_health_stolen = 0;

        public int _total_to_heal = 0;

        public int _random_dodge;





        public static DinoRage_Combat_Calculation Instance { get; set; }


        private void OnEnable()
        {
            Instance = this;
        }




        public void Damage_Calculation(DinoRage_Combat_Node _target, DinoRage_Effect_DATA _effect,
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
                    Calculate_Instant_Heal(_target, _effect, _attacker);
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
            // these reset the values
              _effects_damage = 0;
              _target_resistance = 0;
              _attacker_damage = 0;
              _total_damage = 0;
              _random_dodge = 0;
              _total_dodge_amount = 0;             
              _total_health_stolen = 0;

            // first get percentage off the effect of how much health to steal
            _total_health_steal_percentage = _effect._instant_damage_info._percentage_of_damage_stolen;
            // this part calculates the damager from the effect based if its random or not
            if (_effect._instant_damage_info._random_or_not == DinoRage_Enums.RANDOM_SETTINGS.USE_RANDOM)
            {
                _effects_damage = (int)Random.Range(_effect._instant_damage_info._random_damage_amount.x, _effect._instant_damage_info._random_damage_amount.y);
            }
            else { _effects_damage = _effect._instant_damage_info._non_random_damage_amount; }

            // this is the loop to calculate damage
            for (int i = 0; i <= _target._combat_stats.Length - 1; i++)
            {
                // first checks if they are the same type
                if (_target._combat_stats[i]._type_effected == _effect._instant_damage_info._damage_type && _target._combat_stats[i]._type == DinoRage_Enums.COMBAT_NODE_TYPE.RESISTANCE)
                {
                      _target_resistance += _target._combat_stats[i]._amount;
                }
                if (_target._combat_stats[i]._type == DinoRage_Enums.COMBAT_NODE_TYPE.DODGE_CHANCE)
                {
                    Debug.Log("found dodge value");
                    _total_dodge_amount += _target._combat_stats[i]._amount;
                }
            }
            if (_attacker != null)
            {
                // will add a null here after testing
                for (int i = 0; i <= _attacker._combat_stats.Length - 1; i++)
                {
                    // first checks if they are the same type
                    if (_attacker._combat_stats[i]._type_effected == _effect._instant_damage_info._damage_type && _attacker._combat_stats[i]._type == DinoRage_Enums.COMBAT_NODE_TYPE.DAMAGE)
                    {
                      // now makes sure if the damage type for the attacker
                        _attacker_damage += _attacker._combat_stats[i]._amount;
                    }
                    // get health steal info
                    if (_attacker._combat_stats[i]._type == DinoRage_Enums.COMBAT_NODE_TYPE.Health_Steal)
                    {
                        _total_health_steal_percentage += _attacker._combat_stats[i]._amount;
                    }
                }
            }

            // first make sure if doddge the attack
            _random_dodge = Random.Range(0, 100);
            if (_random_dodge <= _total_dodge_amount) { return; }

            // gets the value of the total attack
            _total_damage = _attacker_damage + _effects_damage - _target_resistance;
            // first make sure its not 0 or below
            if (_total_damage <= 0) { return; }
            //now calculates if to steal health
            if(_effect._instant_damage_info._steal_health == true && _attacker != null)
            {
                    //_total_health_stolen = (int)_total_damage *  _total_health_steal_percentage / 100;
                    _attacker._combat_info._health += (int)_total_damage * _total_health_steal_percentage / 100;
            }

            
            // now applys the damage
            _target._combat_info._health = _target._combat_info._health - _total_damage;

        }




        public void Calculate_Instant_Heal(DinoRage_Combat_Node _target, DinoRage_Effect_DATA _effect,
            DinoRage_Combat_Node _attacker)
        {
            _heal_bonuce_total = 100;
            _total_to_heal = 0;
            // first gets all bonuce heal percentage
            for (int i = 0; i <= _target._combat_stats.Length - 1; i++)
            {
                if (_target._combat_stats[i]._type == DinoRage_Enums.COMBAT_NODE_TYPE.HEAL_BONUCE_PERCENTAGE)
                {
                    _heal_bonuce_total += _target._combat_stats[i]._amount;
                }
            }
            int _temp = (int)(_effect._instant_heal_info._heal_amount * _heal_bonuce_total);
            _total_to_heal = (int)_temp / 100;
            // adds the mount healed
            _target._combat_info._health += _total_to_heal;

        }


    }
}