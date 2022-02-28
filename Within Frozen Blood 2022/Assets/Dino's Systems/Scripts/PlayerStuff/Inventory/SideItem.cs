using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Sirenix.OdinInspector;

namespace DinosSystems.Inventory
{
    public enum itemType
    {
        None,
        Glowstick,
        Flare
    }

    [CreateAssetMenu(fileName = "Side_Item", menuName = "Dino's_Systems/Inventory/Items/Side_Item")]
    [InlineEditor]
    public class SideItem : ScriptableObject
    {
        [BoxGroup("Basic Info")]
        [LabelWidth(100)]
        public string itemName;

        [LabelWidth(100)]
        [BoxGroup("Basic Info")]
        [TextArea]
        public string description;

        [TabGroup("Flare")]
        [GUIColor(3f, 0.4f, 0.4f)]
        public float brightness;

        [TabGroup("Flare")]
        [GUIColor(3f, 1.5f, .04f)]
        public float burnoutTime;

        [TabGroup("GlowStick")]
        public bool isGlowStickEquipped;

        [TabGroup("GlowStick")]
        public Light glowLight;

        [TabGroup("GlowStick")]
        public float glowStickBrightness;

        [TabGroup("GlowStick")]
        public float glowStickBrightnessDimAmount;

        [TabGroup("GlowStick")]
        public float radiusGlow;

        [TabGroup("GlowStick")]
        public GameObject glowStickParts;

        [HorizontalGroup("Game Data", 75)]
        [PreviewField(75)]
        [HideLabel]
        public Sprite icon;

        [HorizontalGroup("Game Data", 75)]
        [PreviewField(75)]
        [HideLabel]
        public GameObject itemModel;

        public itemType itemType;
    }
}