using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DinoRage.Classes;
using Sirenix.OdinInspector;





namespace DinoRage.Combat
{
    public class DinoRage_Combat_Node : MonoBehaviour
    {
        public DinoRage_Classes.COMBAT_INFORMATION _combat_info;
        [TableList]
        public DinoRage_Classes.COMBAT_NODE_INFO[] _combat_stats;




    }
}