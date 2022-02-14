using UnityEngine;
using UnityEditor;
using Sirenix.OdinInspector;
using Sirenix.OdinInspector.Editor;
using Sirenix.Utilities.Editor;

public class EnemyDataEditor : OdinMenuEditorWindow
{
    [MenuItem("Dino's Systems/Tools/Enemy Stuff/Enemy Data")]
    private static void OpenWindow()
    {
        GetWindow<EnemyDataEditor>().Show();
    }

    protected override OdinMenuTree BuildMenuTree()
    {
        var tree = new OdinMenuTree();

        return tree;
    }
}
