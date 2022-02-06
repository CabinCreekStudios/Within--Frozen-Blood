
using UnityEngine;
using UnityEditor;
using Sirenix.OdinInspector;
using Sirenix.OdinInspector.Editor;
using Sirenix.Utilities.Editor;

public class DinoRage_Editor : OdinMenuEditorWindow
{

    [MenuItem("Tools/DinoRage_Editor")]
    private static void open_window()
    {
        GetWindow<DinoRage_Editor>().Show();
    }

    private CreateNewSFX_DATA _create_new_SFX_data;
    private CreateNewRegion_DATA _create_new_region_data;
    private CreateNewEffect_DATA _create_new_effect_data;


    // for clean up
    protected override void OnDestroy()
    {
        base.OnDestroy();
        if (_create_new_SFX_data != null)
        { DestroyImmediate(_create_new_SFX_data._sfx_data); }
        if (_create_new_region_data != null)
        { DestroyImmediate(_create_new_region_data._region_data); }
        if(_create_new_effect_data != null)
        { DestroyImmediate(_create_new_effect_data._effect_data); }
    }



    protected override OdinMenuTree BuildMenuTree()
    {
        // each of these 3 things are needed for each item added
        var tree = new OdinMenuTree();
        _create_new_SFX_data = new CreateNewSFX_DATA();
        _create_new_region_data = new CreateNewRegion_DATA();
        _create_new_effect_data = new CreateNewEffect_DATA();


        tree.Add("New Region", _create_new_region_data);
        tree.AddAllAssetsAtPath("Region Data", "Assets/Scripts/DinoRage/Database/Region_Data", typeof(DinoRage_Region_DATA));

        tree.Add("New SFX", _create_new_SFX_data);
        tree.AddAllAssetsAtPath("SFX Data", "Assets/Scripts/DinoRage/Database/SFX_DATA", typeof(SFX_DATA));

        tree.Add("New Effect", _create_new_effect_data);
        tree.AddAllAssetsAtPath("Effect Data", "Assets/Scripts/DinoRage/Database/Effect_Data", typeof(DinoRage_Effect_DATA));

        tree.AddAllAssetsAtPath("Item Data", "Assets/Scripts/DinoRage/Database/Item_Data", typeof(DinoRage_Item_DATA));
        return tree;
    }

    protected override void OnBeginDrawEditors()
    {
        // gets refrance to the currently selected tree
        OdinMenuTreeSelection selected = this.MenuTree.Selection;

        // this is for deleting data

        SirenixEditorGUI.BeginHorizontalToolbar();
        {
            GUILayout.FlexibleSpace();
            if(SirenixEditorGUI.ToolbarButton("Delete Current"))
            {
                SFX_DATA asset = selected.SelectedValue as SFX_DATA;
                // gets path and uses it to delete item at the paths location
                string path = AssetDatabase.GetAssetPath(asset);
                AssetDatabase.DeleteAsset(path);

                AssetDatabase.SaveAssets();

            }
        }
        SirenixEditorGUI.EndHorizontalToolbar();
    }


    //allows for adding ne SFX data
    public class CreateNewSFX_DATA
    {
        public CreateNewSFX_DATA()
        {
            _sfx_data = ScriptableObject.CreateInstance<SFX_DATA>();
            _sfx_data._SFX_name = "new SFX Data";
        }

        [InlineEditor(ObjectFieldMode = InlineEditorObjectFieldModes.Hidden)]
        public SFX_DATA _sfx_data;

        [Button("Add New SFX Data")]
        private void CreateNewData()
        {
            AssetDatabase.CreateAsset(_sfx_data, "Assets/Scripts/DinoRage/Database/SFX_DATA/" + _sfx_data._SFX_name + ".asset");
            AssetDatabase.SaveAssets();
            // create new instance of the SO
            _sfx_data = ScriptableObject.CreateInstance<SFX_DATA>();
            _sfx_data._SFX_name = "new SFX Data";

        }
    }

    // alows for creating new region
    public class CreateNewRegion_DATA
    {
        public CreateNewRegion_DATA()
        {
            _region_data = ScriptableObject.CreateInstance<DinoRage_Region_DATA>();
            _region_data._region_save_name = "new region Data";
        }

        [InlineEditor(ObjectFieldMode = InlineEditorObjectFieldModes.Hidden)]
        public DinoRage_Region_DATA _region_data;

        [Button("Add New Region Data")]
        private void CreateNewData()
        {
            AssetDatabase.CreateAsset(_region_data, "Assets/Scripts/DinoRage/Database/Region_Data/" + _region_data._region_save_name + ".asset");
            AssetDatabase.SaveAssets();
            // create new instance of the SO
            _region_data = ScriptableObject.CreateInstance<DinoRage_Region_DATA>();
            _region_data._region_save_name = "new region Data";

        }
    }

    // creates new effect data
    public class CreateNewEffect_DATA
    {
        public CreateNewEffect_DATA()
        {
            _effect_data = ScriptableObject.CreateInstance<DinoRage_Effect_DATA>();
            _effect_data._effect_name = "new effect Data";
        }

        [InlineEditor(ObjectFieldMode = InlineEditorObjectFieldModes.Hidden)]
        public DinoRage_Effect_DATA _effect_data;

        [Button("Add New Effect Data")]
        private void CreateNewData()
        {
            AssetDatabase.CreateAsset(_effect_data, "Assets/Scripts/DinoRage/Database/Effect_Data/" + _effect_data._effect_name + ".asset");
            AssetDatabase.SaveAssets();
            // create new instance of the SO
            _effect_data = ScriptableObject.CreateInstance<DinoRage_Effect_DATA>();
            _effect_data._effect_name = "new effect Data";

        }
    }

}
