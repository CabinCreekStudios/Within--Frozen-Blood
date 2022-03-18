using UnityEngine;
using UnityEditor;
using Sirenix.OdinInspector;
using Sirenix.OdinInspector.Editor;
using Sirenix.Utilities.Editor;
using System.Linq;
using System;

public class InventoryDataEditor : OdinMenuEditorWindow
{
    [MenuItem("Dino's Systems/Tools/Editor/Inventory Data Editor")]
    private static void ShowWindow()
    {
        GetWindow<InventoryDataEditor>().Show();
    }

    protected override OdinMenuTree BuildMenuTree()
    {
        var tree = new OdinMenuTree();

        tree.AddAllAssetsAtPath("Inventory Data", "Assets/Dino's Systems/Inventory", typeof(InventorySO));

        return tree;
    }

    protected override void OnBeginDrawEditors()
    {
        // Gets Reference To Current Selected Item //
        OdinMenuTreeSelection selected = this.MenuTree.Selection;

        SirenixEditorGUI.BeginHorizontalToolbar();
        {
            GUILayout.FlexibleSpace();

            if (SirenixEditorGUI.ToolbarButton("Delete Current"))
            {
                InventorySO asset = selected.SelectedValue as InventorySO;
                string path = AssetDatabase.GetAssetPath(asset);
                AssetDatabase.DeleteAsset(path);
                AssetDatabase.SaveAssets();
            }
        }
        SirenixEditorGUI.EndHorizontalToolbar();
    }
}
