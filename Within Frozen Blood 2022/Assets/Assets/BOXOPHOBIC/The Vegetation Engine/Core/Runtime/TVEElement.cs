// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using Boxophobic.StyledGUI;
using System.Collections.Generic;

#if UNITY_EDITOR
using UnityEditor;
#endif

namespace TheVegetationEngine
{
#if UNITY_EDITOR
    [ExecuteInEditMode]
    [AddComponentMenu("BOXOPHOBIC/The Vegetation Engine/TVE Element")]
#endif
    public class TVEElement : StyledMonoBehaviour
    {
        const string layerProp = "_ElementLayerValue";

        [StyledBanner(0.890f, 0.745f, 0.309f, "Element", "", "https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.fd5y8rbb7aia")]
        public bool styledBanner;

        [HideInInspector]
        public TVEElementMaterialData materialData;
        TVEElementDrawerData elementData;

        Renderer meshRenderer;
        Material material;
        Shader shader;
        int layer;

        void OnEnable()
        {
            meshRenderer = gameObject.GetComponent<Renderer>();

            if (meshRenderer.sharedMaterial == null || meshRenderer.sharedMaterial.name == "Element")
            {
                if (materialData == null)
                {
                    materialData = new TVEElementMaterialData();
                }

                if (materialData.shader == null)
                {
#if UNITY_EDITOR
                    material = new Material(Resources.Load<Material>("Internal Colors"));
                    SaveMaterialData(material);
#endif
                }
                else
                {
                    material = new Material(materialData.shader);
                    LoadMaterialData();
                }

                material.name = "Element";
                gameObject.GetComponent<Renderer>().sharedMaterial = material;
            }

            if (meshRenderer.sharedMaterial != null)
            {
                shader = meshRenderer.sharedMaterial.shader;

                if (meshRenderer.sharedMaterial.HasProperty(layerProp))
                {
                    layer = meshRenderer.sharedMaterial.GetInt(layerProp);
                }
            }

            AddElementToVolume();
        }

        void OnDestroy()
        {
            RemoveElementFromVolume();
        }

        void OnDisable()
        {
            RemoveElementFromVolume();
        }

#if UNITY_EDITOR
        void Update()
        {
            if (Application.isPlaying)
            {
                return;
            }

            if (Selection.Contains(gameObject))
            {
                var sharedMaterial = meshRenderer.sharedMaterial;

                if (sharedMaterial != null && sharedMaterial.name == "Element")
                {
                    if (sharedMaterial.shader != null)
                    {
                        SaveMaterialData(gameObject.GetComponent<Renderer>().sharedMaterial);
                    }
                }

                if (sharedMaterial.shader != shader)
                {
                    this.enabled = false;
                    this.enabled = true;
                }

                if (sharedMaterial.HasProperty(layerProp) && sharedMaterial.GetInt(layerProp) != layer)
                {
                    RemoveElementFromVolume();
                    AddElementToVolume();
                    layer = sharedMaterial.GetInt(layerProp);
                }

                if (TVEManager.Instance != null)
                {
                    TVEManager.Instance.globalVolume.SortElementObjects();
                }
            }
        }
#endif

#if UNITY_EDITOR
        void SaveMaterialData(Material mat)
        {
            materialData = new TVEElementMaterialData();
            materialData.props = new List<TVEElementPropertyData>();

            materialData.shader = mat.shader;

            for (int i = 0; i < ShaderUtil.GetPropertyCount(mat.shader); i++)
            {
                var type = ShaderUtil.GetPropertyType(mat.shader, i);
                var prop = ShaderUtil.GetPropertyName(mat.shader, i);

                if (type == ShaderUtil.ShaderPropertyType.TexEnv)
                {
                    var propData = new TVEElementPropertyData();
                    propData.type = PropertyType.Texture;
                    propData.prop = prop;
                    propData.texture = mat.GetTexture(prop);

                    materialData.props.Add(propData);
                }

                if (type == ShaderUtil.ShaderPropertyType.Vector || type == ShaderUtil.ShaderPropertyType.Color)
                {
                    var propData = new TVEElementPropertyData();
                    propData.type = PropertyType.Vector;
                    propData.prop = prop;
                    propData.vector = mat.GetVector(prop);

                    materialData.props.Add(propData);
                }

                if (type == ShaderUtil.ShaderPropertyType.Float || type == ShaderUtil.ShaderPropertyType.Range)
                {
                    var propData = new TVEElementPropertyData();
                    propData.type = PropertyType.Value;
                    propData.prop = prop;
                    propData.value = mat.GetFloat(prop);

                    materialData.props.Add(propData);
                }
            }
        }
#endif

        void LoadMaterialData()
        {
            material.shader = materialData.shader;

            for (int i = 0; i < materialData.props.Count; i++)
            {
                if (materialData.props[i].type == PropertyType.Texture)
                {
                    material.SetTexture(materialData.props[i].prop, materialData.props[i].texture);
                }

                if (materialData.props[i].type == PropertyType.Vector)
                {
                    material.SetVector(materialData.props[i].prop, materialData.props[i].vector);
                }

                if (materialData.props[i].type == PropertyType.Value)
                {
                    material.SetFloat(materialData.props[i].prop, materialData.props[i].value);
                }
            }
        }

        void AddElementToVolume()
        {
            if (TVEManager.Instance == null)
                return;

            if (gameObject.GetComponent<MeshRenderer>() != null && gameObject.GetComponent<MeshRenderer>().sharedMaterial != null)
            {
                var renderer = gameObject.GetComponent<MeshRenderer>();
                var material = renderer.sharedMaterial;

                elementData = new TVEElementDrawerData();
                elementData.buffer = BufferType.Undefined;
                elementData.layer = 0;
                elementData.gameObject = gameObject;
                elementData.rendererType = RendererType.Mesh;
                elementData.renderer = renderer;
                elementData.mesh = gameObject.GetComponent<MeshFilter>().sharedMesh;

                AddElementByType(material);
                SetElementVisibility(renderer);
            }
            else if (gameObject.GetComponent<ParticleSystemRenderer>() != null && gameObject.GetComponent<ParticleSystemRenderer>().sharedMaterial != null)
            {
                var renderer = gameObject.GetComponent<ParticleSystemRenderer>();
                var material = renderer.sharedMaterial;

                elementData = new TVEElementDrawerData();
                elementData.buffer = BufferType.Undefined;
                elementData.layer = 0;
                elementData.gameObject = gameObject;
                elementData.rendererType = RendererType.Particle;
                elementData.renderer = renderer;
                elementData.mesh = null;

                AddElementByType(material);
                SetElementVisibility(renderer);
            }
            else if (gameObject.GetComponent<TrailRenderer>() != null && gameObject.GetComponent<TrailRenderer>().sharedMaterial != null)
            {
                var renderer = gameObject.GetComponent<TrailRenderer>();
                var material = renderer.sharedMaterial;

                elementData = new TVEElementDrawerData();
                elementData.buffer = BufferType.Undefined;
                elementData.layer = 0;
                elementData.gameObject = gameObject;
                elementData.rendererType = RendererType.Trail;
                elementData.renderer = renderer;
                elementData.mesh = null;

                AddElementByType(material);
                SetElementVisibility(renderer);
            }
            //else if (gameObject.GetComponent<LineRenderer>() != null && gameObject.GetComponent<LineRenderer>().sharedMaterial != null)
            //{
            //    var material = gameObject.GetComponent<LineRenderer>().sharedMaterial;
            //    var data = new TVEElementDrawerData(ElementType.Undefined, ElementLayer.Any, RendererType.Line, gameObject, new Mesh(), gameObject.GetComponent<Renderer>());
            //    data.mesh.name = "Line";

            //    AddElementByType(material, data);
            //}
        }

        void AddElementByType(Material material)
        {
            if (material.HasProperty(layerProp))
            {
                elementData.layer = material.GetInt(layerProp);
            }

            bool validType = false;

            if (material.HasProperty("_IsColorsShader"))
            {
                elementData.buffer = BufferType.Colors;
                validType = true;
            }
            else if (material.HasProperty("_IsExtrasShader"))
            {
                elementData.buffer = BufferType.Extras;
                validType = true;
            }
            else if (material.HasProperty("_IsMotionShader"))
            {
                elementData.buffer = BufferType.Motion;
                validType = true;
            }
            else if (material.HasProperty("_IsReactShader"))
            {
                elementData.buffer = BufferType.React;
                validType = true;
            }

            if (validType)
            {
                TVEManager.Instance.globalVolume.volumeElements.Add(elementData);

                var volumeDataSet = TVEManager.Instance.globalVolume.volumeDataSet;

                for (int i = 0; i < volumeDataSet.Count; i++)
                {
                    var volumeData = volumeDataSet[i];

                    if (elementData.buffer == volumeData.buffer)
                    {
                        //volumeData.internalBufferSize = 0;

                        if (elementData.layer > volumeData.internalBufferSize)
                        {

                            volumeData.internalBufferSize = elementData.layer;
                            volumeData.isUpdated = true;
                        }
                    }
                }
            }
        }

        void RemoveElementFromVolume()
        {
            if (TVEManager.Instance == null)
                return;

            var elements = TVEManager.Instance.globalVolume.volumeElements;

            if (elements != null)
            {
                for (int i = 0; i < elements.Count; i++)
                {
                    if (elements[i].gameObject == gameObject)
                    {
                        elements.RemoveAt(i);
                    }
                }
            }

            var instanced = TVEManager.Instance.globalVolume.volumeInstanced;

            if (instanced != null)
            {
                for (int i = 0; i < instanced.Count; i++)
                {
                    for (int j = 0; j < instanced[i].renderers.Count; j++)
                    {
                        if (instanced[i].renderers[j] == meshRenderer)
                        {
                            instanced[i].renderers.RemoveAt(j);
                        }
                    }
                }
            }
        }

        void SetElementVisibility(Renderer renderer)
        {
            if (TVEManager.Instance.globalVolume.elementsVisibility == TVEGlobalVolume.ElementsVisibility.AlwaysHidden)
            {
#if UNITY_2019_3_OR_NEWER
                renderer.forceRenderingOff = true;
#else
                renderer.enabled = false;
#endif
            }

            if (TVEManager.Instance.globalVolume.elementsVisibility == TVEGlobalVolume.ElementsVisibility.AlwaysVisible)
            {
#if UNITY_2019_3_OR_NEWER
                renderer.forceRenderingOff = false;
#else
                renderer.enabled = true;
#endif
            }

            if (TVEManager.Instance.globalVolume.elementsVisibility == TVEGlobalVolume.ElementsVisibility.HiddenAtRuntime)
            {
                if (Application.isPlaying)
                {
#if UNITY_2019_3_OR_NEWER
                    renderer.forceRenderingOff = true;
#else
                    renderer.enabled = false;
#endif
                }
                else
                {
#if UNITY_2019_3_OR_NEWER
                    renderer.forceRenderingOff = false;
#else
                    renderer.enabled = true;
#endif
                }
            }
        }

        void OnDrawGizmosSelected()
        {
            DrawGizmos(true);
        }

        void OnDrawGizmos()
        {
            DrawGizmos(false);
        }

        void DrawGizmos(bool selected)
        {
            var sin = Mathf.SmoothStep(0, 1, Mathf.Sin(Time.realtimeSinceStartup * 4) * 0.5f + 0.5f);

            var genericColor = new Color(0.0f, 0.0f, 0.0f, 0.1f);
            var invalidColor = new Color(1.0f, 0.0f, 0.0f, 0.1f);

            if (selected)
            {
                genericColor = new Color(0.890f, 0.745f, 0.309f, 1.0f);
                invalidColor = new Color(1.0f, 0.05f, 0.05f, sin);
            }

            if (elementData != null)
            {
                Bounds elementBounds = elementData.renderer.bounds;

                if (elementData.buffer == BufferType.Colors)
                {
                    if (IsElementInVolume("TVE_ColorsCoord", elementBounds))
                    {
                        Gizmos.color = genericColor;
                    }
                    else
                    {
                        Gizmos.color = invalidColor;
                    }
                }
                else if (elementData.buffer == BufferType.Extras)
                {
                    if (IsElementInVolume("TVE_ExtrasCoord", elementBounds))
                    {
                        Gizmos.color = genericColor;
                    }
                    else
                    {
                        Gizmos.color = invalidColor;
                    }
                }
                else if (elementData.buffer == BufferType.Motion)
                {
                    if (IsElementInVolume("TVE_MotionCoord", elementBounds))
                    {
                        Gizmos.color = genericColor;
                    }
                    else
                    {
                        Gizmos.color = invalidColor;
                    }
                }
                else if (elementData.buffer == BufferType.React)
                {
                    if (IsElementInVolume("TVE_ReactCoord", elementBounds))
                    {
                        Gizmos.color = genericColor;
                    }
                    else
                    {
                        Gizmos.color = invalidColor;
                    }
                }

                Bounds gizmoBounds;

                if (elementData.rendererType == RendererType.Mesh)
                {
                    gizmoBounds = elementData.mesh.bounds;
                    Gizmos.matrix = transform.localToWorldMatrix;
                }
                else
                {
                    gizmoBounds = elementData.renderer.bounds;
                }

                Gizmos.DrawWireCube(gizmoBounds.center, gizmoBounds.size);
            }
        }

        //void DrawTextGizmo()
        //{
        //    var label = "Outside Volume";

        //    var styleLabel = new GUIStyle(EditorStyles.whiteLabel)
        //    {
        //        richText = true,
        //        alignment = UnityEngine.TextAnchor.MiddleCenter,
        //        fontSize = 9,
        //    };

        //    Handles.BeginGUI();
        //    var size = styleLabel.CalcSize(new GUIContent(label));
        //    var pos2D = HandleUtility.WorldToGUIPoint(transform.position);

        //    GUI.color = Color.red;
        //    GUI.Label(new Rect(pos2D.x - (size.x / 2), pos2D.y - 48, size.x, size.y), label, styleLabel);

        //    Handles.EndGUI();
        //}

        bool IsElementInVolume(string globalCoord, Bounds elementBounds)
        {
            var inVolume = false;

            var coord = Shader.GetGlobalVector(globalCoord);
            var coordUp = Shader.GetGlobalVector("TVE_VolumeParams");

            var sizeX = 1 / coord.x;
            var sizeZ = 1 / coord.y;
            var posX = (-coord.z + 0.5f) * sizeX;
            var posZ = (-coord.w + 0.5f) * sizeZ;

            var volumeBounds = new Bounds(new Vector3(posX, coordUp.x, posZ), new Vector3(sizeX, coordUp.y, sizeZ));

            if (volumeBounds.Intersects(elementBounds))
            {
                inVolume = true;
            }

            return inVolume;
        }
    }
}
