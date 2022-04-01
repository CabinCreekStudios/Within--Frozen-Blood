using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class SaveableEntity : MonoBehaviour
{
    [SerializeField] private string id = string.Empty;

    public string Id => id;

    private void OnValidate()
    {
        GenerateID();
    }

    [ContextMenu("Generate ID")]
    private void GenerateID() => id = Guid.NewGuid().ToString();

    public object CaptureState()
    {
        var state = new Dictionary<string, object>();

        foreach (var saveable in GetComponents<ISaveable>())
        {
            state[saveable.GetType().ToString()] = saveable.CaptureState();
        }

        return state;
    }

    public void RestoreState()
    {

    }
}
