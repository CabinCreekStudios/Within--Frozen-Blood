// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using System.Collections.Generic;
using Boxophobic.StyledGUI;

namespace TheVegetationEngine
{
    [ExecuteInEditMode]
    public class TVEManager : StyledMonoBehaviour
    {
        public static TVEManager Instance;

        [StyledBanner(0.890f, 0.745f, 0.309f, "The Vegetation Engine", "", "https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.hbq3w8ae720x")]
        public bool styledBanner;

        [HideInInspector]
        public TVEGlobalMotion globalMotion;
        [HideInInspector]
        public TVEGlobalSeasons globalSeasons;
        [HideInInspector]
        public TVEGlobalOverlay globalOverlay;
        [HideInInspector]
        public TVEGlobalWetness globalWetness;
        [HideInInspector]
        public TVEGlobalLighting globalLighting;
        [HideInInspector]
        public TVEGlobalDetails globalDetails;
        [HideInInspector]
        public TVEGlobalSettings globalSettings;
        [HideInInspector]
        public TVEGlobalVolume globalVolume;

        void Awake()
        {
            Instance = this;

            CreateComponents();
            InitializeComponents();
        }

        void OnEnable()
        {
            // Set instance in edit mode
            // On script compilations 
            Instance = this;
        }

        void CreateComponents()
        {
            if (globalMotion == null)
            {
                GameObject go = new GameObject();

                go.AddComponent<MeshFilter>();
                go.GetComponent<MeshFilter>().mesh = Resources.Load<Mesh>("ArrowMesh");

                go.AddComponent<MeshRenderer>();
                go.GetComponent<MeshRenderer>().sharedMaterial = Resources.Load<Material>("ArrowMotion");

                go.AddComponent<TVEGlobalMotion>();

                SetParent(go);

                go.transform.localPosition = new Vector3(0, 2f, 0);

                globalMotion = go.GetComponent<TVEGlobalMotion>();
            }
            else
            {
                globalMotion.enabled = true;
            }

            if (globalSeasons == null)
            {
                GameObject go = new GameObject();
                go.AddComponent<TVEGlobalSeasons>();
                SetParent(go);

                globalSeasons = go.GetComponent<TVEGlobalSeasons>();
            }
            else
            {
                globalSeasons.enabled = true;
            }

            if (globalOverlay == null)
            {
                GameObject go = new GameObject();
                go.AddComponent<TVEGlobalOverlay>();

                SetParent(go);

                globalOverlay = go.GetComponent<TVEGlobalOverlay>();
            }
            else
            {
                globalOverlay.enabled = true;
            }

            if (globalWetness == null)
            {
                GameObject go = new GameObject();
                go.AddComponent<TVEGlobalWetness>();
                SetParent(go);

                globalWetness = go.GetComponent<TVEGlobalWetness>();
            }
            else
            {
                globalWetness.enabled = true;
            }

            if (globalLighting == null)
            {
                GameObject go = new GameObject();
                go.AddComponent<TVEGlobalLighting>();
                SetParent(go);

                globalLighting = go.GetComponent<TVEGlobalLighting>();
            }
            else
            {
                globalLighting.enabled = true;
            }

            if (globalSettings == null)
            {
                GameObject go = new GameObject();
                go.AddComponent<TVEGlobalSettings>();
                SetParent(go);

                globalSettings = go.GetComponent<TVEGlobalSettings>();
            }
            else
            {
                globalSettings.enabled = true;
            }

            if (globalDetails == null)
            {
                GameObject go = new GameObject();
                go.AddComponent<TVEGlobalDetails>();
                SetParent(go);

                globalDetails = go.GetComponent<TVEGlobalDetails>();
            }
            else
            {
                globalDetails.enabled = true;
            }

            if (globalVolume == null)
            {
                GameObject go = new GameObject();
                go.AddComponent<TVEGlobalVolume>();
                SetParent(go);

                go.transform.localScale = new Vector3(400, 200, 400);

                globalVolume = go.GetComponent<TVEGlobalVolume>();
            }
            else
            {
                globalVolume.enabled = true;
            }
        }

        void InitializeComponents()
        {
            globalVolume.volumeElements = new List<TVEElementDrawerData>();
            globalVolume.volumeInstanced = new List<TVEElementInstancedData>();

            globalVolume.CreateVolumeDataSet();
        }

        void SetParent(GameObject go)
        {
            go.transform.parent = gameObject.transform;
            go.transform.localPosition = Vector3.zero;
            go.transform.eulerAngles = Vector3.zero;
            go.transform.localScale = Vector3.one;
        }
    }
}