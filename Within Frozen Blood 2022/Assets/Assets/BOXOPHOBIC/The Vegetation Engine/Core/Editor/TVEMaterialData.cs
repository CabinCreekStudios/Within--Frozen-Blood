// Cristian Pop - https://boxophobic.com/

using UnityEngine;

namespace TheVegetationEngine
{
    [System.Serializable]
    public class TVEMaterialData
    {
        public enum PropertyType
        {
            Value = 0,
            Range = 1,
            Vector = 2,
            Color = 2,
            Enum = 3,
            Space = 99,
        }

        public PropertyType type;
        public string prop;
        public string name;
        public string dependency;
        public float value;
        public float min;
        public float max;
        public bool snap;
        public Vector4 vector;
        public Color color;
        public string[] options;
        public bool hdr;
        public bool space;

        public TVEMaterialData()
        {
            type = PropertyType.Space;
        }

        public TVEMaterialData(string prop, string name, float value, int min, int max, bool snap, bool space)
        {
            type = PropertyType.Range;
            this.prop = prop;
            this.dependency = "_IsTVEShader";
            this.value = value;
            this.name = name;
            this.min = min;
            this.max = max;
            this.snap = snap;
            this.space = space;
        }

        public TVEMaterialData(string prop, string name, Color color, bool hdr, bool space)
        {
            type = PropertyType.Color;
            this.prop = prop;
            this.dependency = "_IsTVEShader";
            this.color = color;
            this.hdr = hdr;
            this.name = name;
            this.space = space;
        }

        public TVEMaterialData(string prop, string name, float value, string[] options, bool space)
        {
            type = PropertyType.Enum;
            this.prop = prop;
            this.dependency = "_IsTVEShader";
            this.value = value;
            this.options = options;
            this.name = name;
            this.space = space;
        }

        public TVEMaterialData(string prop, string name, string dependency, float value, string[] options, bool space)
        {
            type = PropertyType.Enum;
            this.prop = prop;
            this.dependency = dependency;
            this.value = value;
            this.options = options;
            this.name = name;
            this.space = space;
        }
    }
}