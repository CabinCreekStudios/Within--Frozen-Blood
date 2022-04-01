using UnityEngine;
using UnityEditor;
using Sirenix.OdinInspector;
using Sirenix.OdinInspector.Editor;
using Sirenix.Utilities.Editor;

public class ItemDataEditor : OdinMenuEditorWindow
{
    [MenuItem("Dino's Systems/Tools/Editor/Item Data Editor")]
    private static void OpenWindow()
    {
        GetWindow<ItemDataEditor>().Show();
    }

    private CreateNewItemData createNewItemData;

    protected override void OnDestroy()
    {
        base.OnDestroy();

        if (createNewItemData != null)
            DestroyImmediate(createNewItemData.itemData);
    }

    protected override OdinMenuTree BuildMenuTree()
    {
        var tree = new OdinMenuTree();

        createNewItemData = new CreateNewItemData();

        tree.Add("Create New Item", createNewItemData);
        tree.AddAllAssetsAtPath("Item Data(Consumables)", "Assets/Dino's Systems/Inventory/Items/Consumables", typeof(Item));

        tree.AddAllAssetsAtPath("Item Data(Weapons)", "Assets/Dino's Systems/Inventory/Items/Weapons", typeof(Item));

        tree.AddAllAssetsAtPath("Item Data(Throwables)", "Assets/Dino's Systems/Inventory/Items/Throwables", typeof(Item));

        return tree;
    }

    protected override void OnBeginDrawEditors()
    {
        // Gets Reference To Current Selected Item //
        OdinMenuTreeSelection selected = this.MenuTree.Selection;

        // Delete Current ToolBar //
        SirenixEditorGUI.BeginHorizontalToolbar();
        {
            GUILayout.FlexibleSpace();

            if (SirenixEditorGUI.ToolbarButton("Delete Current"))
            {
                Item asset = selected.SelectedValue as Item;
                string path = AssetDatabase.GetAssetPath(asset);
                AssetDatabase.DeleteAsset(path);
                AssetDatabase.SaveAssets();
            }
        }
        SirenixEditorGUI.EndHorizontalToolbar();
    }

    public class CreateNewItemData
    {
        public CreateNewItemData()
        {
            itemData = ScriptableObject.CreateInstance<Item>();
            itemData.itemName = "New Item Data";
        }

        [InlineEditor(ObjectFieldMode = InlineEditorObjectFieldModes.Hidden)]
        public Item itemData;

        [Button("Create New Consumable Item")]
        private void CreateNewConsumableItem()
        {
            AssetDatabase.CreateAsset(itemData, "Assets/Dino's Systems/Inventory/Items/Consumables/" + itemData.itemName + ".asset");
            AssetDatabase.SaveAssets();

            // Create New Instance Of The SO//
            itemData = ScriptableObject.CreateInstance<Item>();
            itemData.itemName = "New Item Data";
        }

        [Button("Creat New Weapon Item")]
        private void CreateNewWeaponItem()
        {
            AssetDatabase.CreateAsset(itemData, "Assets/Dino's Systems/Inventory/Items/Weapons/" + itemData.itemName + ".asset");
            AssetDatabase.SaveAssets();

            // Create New Instance Of The SO//
            itemData = ScriptableObject.CreateInstance<Item>();
            itemData.itemName = "New Item Data";
        }

        [Button("Create New Throwable Item")]
        private void CreateNewThrowableItem()
        {
            AssetDatabase.CreateAsset(itemData, "Assets/Dino's Systems/Inventory/Items/Throwables/" + itemData.itemName + ".asset");
            AssetDatabase.SaveAssets();

            // Create New Instance Of The SO//
            itemData = ScriptableObject.CreateInstance<Item>();
            itemData.itemName = "New Item Data";
        }
    }
}
