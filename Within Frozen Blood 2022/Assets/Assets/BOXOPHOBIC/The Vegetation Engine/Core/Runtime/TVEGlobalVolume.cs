// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using Boxophobic.StyledGUI;
using UnityEngine.Rendering;
using System.Collections.Generic;
#if UNITY_EDITOR
using UnityEditor;
#endif

namespace TheVegetationEngine
{
    [ExecuteInEditMode]
    [AddComponentMenu("BOXOPHOBIC/The Vegetation Engine/TVE Global Volume")]
    public class TVEGlobalVolume : StyledMonoBehaviour
    {
        const int FOLLOW_CAMERA_RESOLUTION = 1024;
        const float FOLLOW_CAMERA_DISTANCE = 100f;

        public enum ElementsVisibility
        {
            AlwaysHidden = 0,
            AlwaysVisible = 10,
            HiddenAtRuntime = 20,
        }

        public enum ElementsSorting
        {
            SortInEditMode = 0,
            SortAtRuntime = 10,
        }

        public enum VolumeDataMode
        {
            Off = -1,
            FollowMainCamera = 10,
            RenderedInVolumeLowerQuality = 256,
            RenderedInVolumeLowQuality = 512,
            RenderedInVolumeMediumQuality = 1024,
            RenderedInVolumeHighQuality = 2048,
            RenderedInVolumeUltraQuality = 4096,
        }

        [StyledBanner(0.890f, 0.745f, 0.309f, "Global Volume", "", "https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.a39m1w5ouu94")]
        public bool styledBanner;

        [StyledCategory("Camera Settings", 5, 10)]
        public bool cameraCat;

        [StyledMessage("Error", "Main Camera not found! Make sure you have a main camera with Main Camera tag in your scene! Particle elements updating will be skipped without it. Enter play mode to update the status!", 0, 10)]
        public bool styledCameraMessaage = false;

        public Camera mainCamera;

        [StyledCategory("Elements Settings")]
        public bool elementsCat;

#if UNITY_EDITOR
        [StyledMessage("Info", "Realtime Sorting is not supported for elements with GPU Instanceing enabled!", 0, 10)]
        public bool styledSortingMessaage = true;
#endif

        [Tooltip("Controls the elements visibility in scene and game view.")]
        public ElementsVisibility elementsVisibility = ElementsVisibility.HiddenAtRuntime;
        [HideInInspector]
        public ElementsVisibility elementsVisibilityOld = ElementsVisibility.HiddenAtRuntime;
        [Tooltip("Controls the elements sorting by element position. Always on in scene view.")]
        public ElementsSorting elementsSorting = ElementsSorting.SortInEditMode;
        [Tooltip("Controls the elements fading at the volume edges if the Enable Edge Fade Support is toggled on the element material.")]
        [Range(0, 1)]
        public float elementsEdgeFade = 0.75f;
        [Tooltip("Controls if the elements set to Default layer should affect all the higher layers, when the higher layers exist.")]
        public bool elementsDefaultLayerIsGlobal = false;

        [StyledCategory("Render Settings")]
        public bool dataCat;

        [Tooltip("Volume data used for Colors elements rendering. In Dynamic mode, the buffer follows the Main Camera. In Quality mode, the buffer is rendered inside the Global Volume at the following resolutions: Lower 256, Low 512, Medium 1024, High 2048, Ultra 4096.")]
        public VolumeDataMode renderColorsData = VolumeDataMode.RenderedInVolumeMediumQuality;
        [Tooltip("Volume data used for Extras elements rendering. In Dynamic mode, the buffer follows the Main Camera. In Quality mode, the buffer is rendered inside the Global Volume at the following resolutions: Lower 256, Low 512, Medium 1024, High 2048, Ultra 4096.")]
        public VolumeDataMode renderExtrasData = VolumeDataMode.RenderedInVolumeMediumQuality;
        [Tooltip("Volume data used for Motion elements rendering. In Dynamic mode, the buffer follows the Main Camera. In Quality mode, the buffer is rendered inside the Global Volume at the following resolutions: Lower 256, Low 512, Medium 1024, High 2048, Ultra 4096.")]
        public VolumeDataMode renderMotionData = VolumeDataMode.RenderedInVolumeMediumQuality;
        [Tooltip("Volume data used for Interaction and Size elements rendering. In Dynamic mode, the buffer follows the Main Camera. In Quality mode, the buffer is rendered inside the Global Volume at the following resolutions: Lower 256, Low 512, Medium 1024, High 2048, Ultra 4096.")]
        public VolumeDataMode renderReactData = VolumeDataMode.RenderedInVolumeMediumQuality;
        //[Tooltip("Volume data used for Custom elements and effects rendering. In Dynamic mode, the buffer follows the Main Camera. In Quality mode, the buffer is rendered inside the Global Volume at the following resolutions: Low 512, Medium 1024, High 2048, Ultra 4096.")]
        //public VolumeDataMode renderCustomData = VolumeDataMode.Off;

        [StyledCategory("Debug Settings")]
        public bool debugCat;

        [StyledInteractive("OFF")]
        public bool interactiveOff;

        [Tooltip("List containg Volume data entities.")]
        public List<TVEVolumeData> volumeDataSet;
        [Tooltip("List containg all the Element entities.")]
        public List<TVEElementDrawerData> volumeElements;
        [Tooltip("List containg all the Element entities with GPU Instancing enabled.")]
        public List<TVEElementInstancedData> volumeInstanced;

        [StyledSpace(10)]
        public bool styledSpace0;

        TVEVolumeData colorsData;
        TVEVolumeData extrasData;
        TVEVolumeData motionData;
        TVEVolumeData reactData;

        bool usesFollowMainCamera;
        Vector3 volumeWorldPosition;
        Vector3 volumeWorldScale;
        Vector3 volumeFollowPosition;
        Vector3 volumeFollowScale;

        Vector4 bufferParams;

        Matrix4x4 projectionMatrix;
        Matrix4x4 modelViewMatrix = new Matrix4x4
        (
            new Vector4(1f, 0f, 0f, 0f),
            new Vector4(0f, 0f, -1f, 0f),
            new Vector4(0f, -1f, 0f, 0f),
            new Vector4(0f, 0f, 0f, 1f)
        );

        void Start()
        {
            gameObject.name = "Global Volume";
            gameObject.transform.SetSiblingIndex(7);

            if (volumeElements == null)
            {
                volumeElements = new List<TVEElementDrawerData>();
            }

            CreateRenderBuffers();

            SortElementObjects();
            SetElementsVisibility();

            if (Application.isPlaying)
            {
                BuildInstancedElements();
            }

            GetMaincamera();
        }

        void Update()
        {
            if (elementsSorting == ElementsSorting.SortAtRuntime)
            {
                SortElementObjects();
            }

            if (mainCamera == null)
            {
                GetMaincamera();
            }

            if (elementsVisibilityOld != elementsVisibility)
            {
                SetElementsVisibility();

                elementsVisibilityOld = elementsVisibility;
            }

#if UNITY_EDITOR
            CheckRenderBuffers();

            if (elementsSorting == ElementsSorting.SortAtRuntime)
            {
                styledSortingMessaage = true;
            }
            else
            {
                styledSortingMessaage = false;
            }

            if (mainCamera == null)
            {
                styledCameraMessaage = true;
            }
            else
            {
                styledCameraMessaage = false;
            }
#endif

            UpdateVolumeBounds();

            UpdateRenderBuffers();
            ExecuteRenderBuffers();

            SetGlobalShaderParameters();
        }

        void GetMaincamera()
        {
            mainCamera = Camera.main;
        }

        public void CreateVolumeDataSet()
        {
            volumeDataSet = new List<TVEVolumeData>();

            colorsData = new TVEVolumeData();
            colorsData.enabled = true;
            colorsData.buffer = BufferType.Colors;
            colorsData.internalTexName = "TVE_ColorsTex";
            colorsData.internalTexCoord = "TVE_ColorsCoord";
            colorsData.internalTexUsage = "TVE_ColorsUsage";
            colorsData.internalResolution = 1024;
            colorsData.internalFormat = RenderTextureFormat.ARGBHalf;
            colorsData.internalBufferSize = 0;

            extrasData = new TVEVolumeData();
            extrasData.enabled = true;
            extrasData.buffer = BufferType.Extras;
            extrasData.internalTexName = "TVE_ExtrasTex";
            extrasData.internalTexCoord = "TVE_ExtrasCoord";
            extrasData.internalTexUsage = "TVE_ExtrasUsage";
            extrasData.internalResolution = 1024;
            extrasData.internalFormat = RenderTextureFormat.Default;
            extrasData.internalBufferSize = 0;

            motionData = new TVEVolumeData();
            motionData.enabled = true;
            motionData.buffer = BufferType.Motion;
            motionData.internalTexName = "TVE_MotionTex";
            motionData.internalTexCoord = "TVE_MotionCoord";
            motionData.internalTexUsage = "TVE_MotionUsage";
            motionData.internalResolution = 1024;
            motionData.internalFormat = RenderTextureFormat.Default;
            motionData.internalBufferSize = 0;

            reactData = new TVEVolumeData();
            reactData.enabled = true;
            reactData.buffer = BufferType.React;
            reactData.internalTexName = "TVE_ReactTex";
            reactData.internalTexCoord = "TVE_ReactCoord";
            reactData.internalTexUsage = "TVE_ReactUsage";
            reactData.internalResolution = 1024;
            reactData.internalFormat = RenderTextureFormat.Default;
            reactData.internalBufferSize = 0;

            UpdateVolumeData(colorsData, renderColorsData);
            UpdateVolumeData(extrasData, renderExtrasData);
            UpdateVolumeData(motionData, renderMotionData);
            UpdateVolumeData(reactData, renderReactData);

            volumeDataSet.Add(colorsData);
            volumeDataSet.Add(extrasData);
            volumeDataSet.Add(motionData);
            volumeDataSet.Add(reactData);
        }

        void UpdateVolumeData(TVEVolumeData volumeData, VolumeDataMode volumeDataMode)
        {
            if (volumeDataMode == VolumeDataMode.Off)
            {
                volumeData.enabled = false;
                volumeData.internalResolution = 32;
                volumeData.internalBufferSize = 0;
                volumeData.followMainCamera = false;
            }
            else if (volumeDataMode == VolumeDataMode.FollowMainCamera)
            {
                volumeData.enabled = true;
                volumeData.internalResolution = FOLLOW_CAMERA_RESOLUTION;
                volumeData.followMainCamera = true;
            }
            else if (volumeDataMode == VolumeDataMode.RenderedInVolumeLowerQuality)
            {
                volumeData.enabled = true;
                volumeData.internalResolution = 256;
                volumeData.followMainCamera = false;
            }
            else if (volumeDataMode == VolumeDataMode.RenderedInVolumeLowQuality)
            {
                volumeData.enabled = true;
                volumeData.internalResolution = 512;
                volumeData.followMainCamera = false;
            }
            else if (volumeDataMode == VolumeDataMode.RenderedInVolumeMediumQuality)
            {
                volumeData.enabled = true;
                volumeData.internalResolution = 1024;
                volumeData.followMainCamera = false;
            }
            else if (volumeDataMode == VolumeDataMode.RenderedInVolumeHighQuality)
            {
                volumeData.enabled = true;
                volumeData.internalResolution = 2048;
                volumeData.followMainCamera = false;
            }
            else if (volumeDataMode == VolumeDataMode.RenderedInVolumeUltraQuality)
            {
                volumeData.enabled = true;
                volumeData.internalResolution = 4096;
                volumeData.followMainCamera = false;
            }
        }

        void UpdateVolumeBounds()
        {
            volumeWorldPosition = gameObject.transform.position;
            volumeWorldScale = gameObject.transform.lossyScale;

            if (mainCamera != null)
            {
                float grid = FOLLOW_CAMERA_DISTANCE / FOLLOW_CAMERA_RESOLUTION;
                float posX = Mathf.Round(mainCamera.transform.position.x / grid) * grid;
                float posZ = Mathf.Round(mainCamera.transform.position.z / grid) * grid;

                volumeFollowPosition = new Vector3(posX, gameObject.transform.position.y, posZ);
                volumeFollowScale = new Vector3(FOLLOW_CAMERA_DISTANCE, gameObject.transform.lossyScale.y, FOLLOW_CAMERA_DISTANCE);
            }
        }

        void CreateRenderBuffers()
        {
            for (int i = 0; i < volumeDataSet.Count; i++)
            {
                var volumeData = volumeDataSet[i];

                if (volumeData == null)
                {
                    continue;
                }

                if (volumeData.internalTex != null)
                {
                    volumeData.internalTex.Release();
                }

                if (volumeData.internalBuffer != null)
                {
                    for (int b = 0; b < volumeData.internalBuffer.Length; b++)
                    {
                        volumeData.internalBuffer[b].Clear();
                    }

                }

                volumeData.internalTex = new RenderTexture(volumeData.internalResolution, volumeData.internalResolution, 0, volumeData.internalFormat);
                volumeData.internalTex.dimension = TextureDimension.Tex2DArray;
                volumeData.internalTex.volumeDepth = volumeData.internalBufferSize + 1;
                volumeData.internalTex.name = volumeData.buffer.ToString();
                volumeData.internalTex.wrapMode = TextureWrapMode.Clamp;

                volumeData.internalBuffer = new CommandBuffer[volumeData.internalBufferSize + 1];

                volumeData.internalBufferUsage = new float[9];

                for (int b = 0; b < volumeData.internalBuffer.Length; b++)
                {
                    volumeData.internalBuffer[b] = new CommandBuffer();
                    volumeData.internalBuffer[b].name = volumeData.buffer.ToString();
                    volumeData.internalBufferUsage[b] = 1.0f;
                }

                Shader.SetGlobalTexture(volumeData.internalTexName, volumeData.internalTex);
                Shader.SetGlobalFloatArray(volumeData.internalTexUsage, volumeData.internalBufferUsage);
            }
        }

        void UpdateRenderBuffers()
        {
            for (int i = 0; i < volumeDataSet.Count; i++)
            {
                var volumeData = volumeDataSet[i];

                if (volumeData == null)
                {
                    continue;
                }

                if (volumeData.internalBuffer == null)
                {
                    continue;
                }

                if (volumeData.buffer == BufferType.Extras)
                {
                    bufferParams = new Vector4(Shader.GetGlobalFloat("TVE_EmissiveValue"), Shader.GetGlobalFloat("TVE_WetnessValue"), Shader.GetGlobalFloat("TVE_OverlayValue"), 1);
                    Shader.SetGlobalVector("TVE_ExtrasParams", bufferParams);

                }
                else if (volumeData.buffer == BufferType.Motion)
                {
                    bufferParams = Shader.GetGlobalVector("TVE_MotionParams");
                }
                else if (volumeData.buffer == BufferType.React)
                {
                    bufferParams = new Vector4(0, 0, 0, 1);
                    Shader.SetGlobalVector("TVE_ReactParams", bufferParams);
                }
                else
                {
                    bufferParams = new Color(0.5f, 0.5f, 0.5f, 0.0f);

                    if (QualitySettings.activeColorSpace == ColorSpace.Linear)
                    {
                        bufferParams = new Color(0.5f, 0.5f, 0.5f, 0.0f).linear;
                    }
                    Shader.SetGlobalVector("TVE_ColorsParams", bufferParams);
                }

                for (int b = 0; b < volumeData.internalBuffer.Length; b++)
                {
                    volumeData.internalBuffer[b].Clear();
                    volumeData.internalBuffer[b].ClearRenderTarget(true, true, bufferParams);

                    if (volumeData.enabled == false)
                    {
                        continue;
                    }

                    for (int e = 0; e < volumeElements.Count; e++)
                    {
                        var elementData = volumeElements[e];

                        if (elementData.buffer == volumeData.buffer)
                        {
                            if (elementData.layer == b || (elementData.layer == 0 && elementsDefaultLayerIsGlobal))
                            {
                                Camera.SetupCurrent(mainCamera);
                                volumeData.internalBuffer[b].DrawRenderer(elementData.renderer, elementData.renderer.sharedMaterial, 0, 0);
                            }
                        }
                    }

                    if (!Application.isPlaying)
                    {
                        continue;
                    }

                    if (volumeData.enabled == false)
                    {
                        continue;
                    }

                    for (int e = 0; e < volumeInstanced.Count; e++)
                    {
                        var elementData = volumeInstanced[e];

                        if (elementData.buffer == volumeData.buffer)
                        {
                            if (elementData.layer == b || (elementData.layer == 0 && elementsDefaultLayerIsGlobal))
                            {
                                Matrix4x4[] matrix4X4s = new Matrix4x4[elementData.renderers.Count];

                                for (int m = 0; m < elementData.renderers.Count; m++)
                                {
                                    matrix4X4s[m] = elementData.renderers[m].localToWorldMatrix;
                                }

                                volumeData.internalBuffer[b].DrawMeshInstanced(elementData.mesh, 0, elementData.material, 0, matrix4X4s);
                            }
                        }
                    }
                }
            }
        }

        void ExecuteRenderBuffers()
        {
            GL.PushMatrix();
            RenderTexture currentRenderTexture = RenderTexture.active;

            for (int i = 0; i < volumeDataSet.Count; i++)
            {
                var volumeData = volumeDataSet[i];

                if (volumeData == null)
                {
                    continue;
                }

                if (volumeData.internalBuffer == null)
                {
                    continue;
                }

                var position = volumeWorldPosition;
                var scale = volumeWorldScale;

                if (volumeData.followMainCamera && mainCamera != null)
                {
                    position = volumeFollowPosition;
                    scale = volumeFollowScale;
                }

                projectionMatrix = Matrix4x4.Ortho(-scale.x / 2 + position.x,
                                                    scale.x / 2 + position.x,
                                                    scale.z / 2 + -position.z,
                                                    -scale.z / 2 + -position.z,
                                                    -scale.y / 2 + position.y,
                                                    scale.y / 2 + position.y);

                var x = 1 / scale.x;
                var y = 1 / scale.z;
                var z = 1 / scale.x * position.x - 0.5f;
                var w = 1 / scale.z * position.z - 0.5f;
                var coord = new Vector4(x, y, -z, -w);

                GL.LoadProjectionMatrix(projectionMatrix);
                GL.modelview = modelViewMatrix;

                Shader.SetGlobalVector(volumeData.internalTexCoord, coord);

                for (int b = 0; b < volumeData.internalBuffer.Length; b++)
                {
                    Graphics.SetRenderTarget(volumeData.internalTex, 0, CubemapFace.Unknown, b);
                    Graphics.ExecuteCommandBuffer(volumeData.internalBuffer[b]);
                }
            }

            RenderTexture.active = currentRenderTexture;
            GL.PopMatrix();
        }

        void CheckRenderBuffers()
        {
            if (Application.isPlaying)
            {
                return;
            }

            for (int i = 0; i < volumeDataSet.Count; i++)
            {
                var volumeData = volumeDataSet[i];

                if (volumeData == null)
                {
                    continue;
                }

                if (volumeData.isUpdated)
                {
                    CreateRenderBuffers();
                    volumeData.isUpdated = false;
                }
            }

            if (colorsData.followMainCamera || extrasData.followMainCamera || motionData.followMainCamera || reactData.followMainCamera)
            {
                usesFollowMainCamera = true;
            }
            else
            {
                usesFollowMainCamera = false;
            }
        }

        void SetGlobalShaderParameters()
        {
            Shader.SetGlobalFloat("TVE_ElementsFadeValue", elementsEdgeFade);
            Shader.SetGlobalVector("TVE_VolumeParams", new Vector4(volumeWorldPosition.y, volumeWorldScale.y));
        }

        public void SortElementObjects()
        {
            for (int i = 0; i < volumeElements.Count - 1; i++)
            {
                for (int j = 0; j < volumeElements.Count - 1; j++)
                {
                    if (volumeElements[j] != null && volumeElements[j].gameObject.transform.position.y > volumeElements[j + 1].gameObject.transform.position.y)
                    {
                        var next = volumeElements[j + 1];
                        volumeElements[j + 1] = volumeElements[j];
                        volumeElements[j] = next;
                    }
                }
            }
        }

        public void BuildInstancedElements()
        {
            if (volumeElements.Count == 0)
            {
                return;
            }

            var instanced = new List<TVEElementInstancedData>();

            for (int i = 0; i < volumeElements.Count; i++)
            {
                if (volumeElements[i].renderer.sharedMaterial.enableInstancing == true)
                {
                    var element = volumeElements[i];

                    var data = new TVEElementInstancedData();
                    data.buffer = element.buffer;
                    data.layer = element.layer;
                    data.material = element.renderer.sharedMaterial;
                    data.mesh = element.mesh;

                    instanced.Add(data);
                }
            }

            for (int i = 0; i < instanced.Count; i++)
            {
                var renderersList = new List<Renderer>();

                for (int j = 0; j < volumeElements.Count; j++)
                {
                    if (renderersList.Count > 1022)
                    {
                        break;
                    }

                    if (instanced[i].material == volumeElements[j].renderer.sharedMaterial && instanced[i].mesh == volumeElements[j].mesh)
                    {
                        renderersList.Add(volumeElements[j].renderer);
                        volumeElements.Remove(volumeElements[j]);
                        j--;
                    }
                }

                instanced[i].renderers = renderersList;
            }

            for (int i = 0; i < instanced.Count; i++)
            {
                if (instanced[i].renderers.Count == 0)
                {
                    instanced.RemoveAt(i);
                    i--;
                }
            }

            volumeInstanced.AddRange(instanced);
            instanced.Clear();
        }

        void SetElementsVisibility()
        {
            if (elementsVisibility == ElementsVisibility.AlwaysHidden)
            {
                DisableElementsVisibility();
            }
            else if (elementsVisibility == ElementsVisibility.AlwaysVisible)
            {
                EnableElementsVisibility();
            }
            else if (elementsVisibility == ElementsVisibility.HiddenAtRuntime)
            {
                if (Application.isPlaying)
                {
                    DisableElementsVisibility();
                }
                else
                {
                    EnableElementsVisibility();
                }
            }
        }

        void EnableElementsVisibility()
        {
            for (int i = 0; i < volumeElements.Count; i++)
            {
                if (volumeElements[i] != null)
                {
#if UNITY_2019_3_OR_NEWER
                    volumeElements[i].renderer.forceRenderingOff = false;
#else
                    volumeElements[i].renderer.enabled = true;
#endif
                }
            }
        }

        void DisableElementsVisibility()
        {
            for (int i = 0; i < volumeElements.Count; i++)
            {
                if (volumeElements[i] != null)
                {
#if UNITY_2019_3_OR_NEWER
                    volumeElements[i].renderer.forceRenderingOff = true;
#else
                    volumeElements[i].renderer.enabled = false;
#endif
                }
            }
        }

#if UNITY_EDITOR        
        void OnDrawGizmosSelected()
        {
            Gizmos.color = new Color(0.890f, 0.745f, 0.309f, 1f);
            Gizmos.DrawWireCube(volumeWorldPosition, volumeWorldScale);
        }

        void OnDrawGizmos()
        {
            Gizmos.color = new Color(0.0f, 0.0f, 0.0f, 0.11f);
            Gizmos.DrawWireCube(volumeWorldPosition, volumeWorldScale);            

            if (usesFollowMainCamera)
            {
                if (mainCamera != null)
                {
                    if (Selection.Contains(mainCamera.gameObject))
                    {
                        Gizmos.color = new Color(0.890f, 0.745f, 0.309f, 1f);
                    }

                    Gizmos.DrawWireCube(volumeFollowPosition, volumeFollowScale);
                }
            }
        }

        void OnValidate()
        {
            if (colorsData != null && extrasData != null && motionData != null && reactData != null)
            {
                UpdateVolumeData(colorsData, renderColorsData);
                UpdateVolumeData(extrasData, renderExtrasData);
                UpdateVolumeData(motionData, renderMotionData);
                UpdateVolumeData(reactData, renderReactData);

                CreateRenderBuffers();
            }
        }
#endif
    }
}
