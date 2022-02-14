// Cristian Pop - https://boxophobic.com/

using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

namespace TheVegetationEngine
{
    public enum BufferType
    {
        Undefined = -1,
        Colors = 10,
        Extras = 20,
        Motion = 30,
        React = 40,
        Custom = 100,
    }

    public enum RendererType
    {
        Mesh = 0,
        Particle = 1,
        Trail = 2,
        //Line = 3,
    }

    public enum PropertyType
    {
        Texture = 0,
        Vector = 1,
        Value = 2,
    }

    [System.Serializable]
    public class TVEElementMaterialData
    {
        public Shader shader;
        public List<TVEElementPropertyData> props;

        public TVEElementMaterialData()
        {

        }
    }

    [System.Serializable]
    public class TVEElementPropertyData
    {
        public PropertyType type;
        public string prop;
        public Texture texture;
        public Vector4 vector;
        public float value;

        public TVEElementPropertyData()
        {

        }
    }

    [System.Serializable]
    public class TVEElementDrawerData
    {
        public BufferType buffer;
        public int layer;
        public GameObject gameObject;
        public Mesh mesh;
        public RendererType rendererType;
        public Renderer renderer;

        public TVEElementDrawerData()
        {

        }
    }

    [System.Serializable]
    public class TVEElementInstancedData
    {
        public BufferType buffer;
        public int layer;
        public Material material;
        public Mesh mesh;
        public List<Renderer> renderers;

        public TVEElementInstancedData()
        {

        }
    }

    [System.Serializable]
    public class TVEVolumeData
    {
        public bool enabled;
        public bool isUpdated;
        public BufferType buffer;
        public RenderTexture internalTex;
        public RenderTextureFormat internalFormat;
        public int internalResolution;
        public string internalTexName;
        public string internalTexCoord;
        public string internalTexUsage;
        public CommandBuffer[] internalBuffer;
        public int internalBufferSize = 0;
        public float[] internalBufferUsage;
        public bool followMainCamera;

        public TVEVolumeData()
        {

        }
    }
}