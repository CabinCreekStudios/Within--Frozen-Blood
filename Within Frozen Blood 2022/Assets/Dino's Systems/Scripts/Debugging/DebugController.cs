using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DebugController : MonoBehaviour
{
    bool showConsole;

    public KeyCode showDebugKey;
    public string input;

    // COMMANDS //
    public static DebugCommand FILL_HEALTH;

    public List<object> commandList;

    private void Awake()
    {
        FILL_HEALTH = new DebugCommand("fill health", "Removes all Wendigo's from the scene.", "fill_health", () =>
        {
            Debug.Log("Filled Health To Max");
            PlayerNeeds.Instance.health = 100f;
        });

        commandList = new List<object>
        {
            FILL_HEALTH,
        };
    }

    private void Update()
    {
        OnToggleDebug();
    }

    public void OnToggleDebug()
    {
        if (Input.GetKeyDown(showDebugKey))
        {
            showConsole = !showConsole;
        }
    }

    public void OnReturn()
    {
        if (showConsole)
        {
            HandleInput();
            input = "";
        }
    }

    private void OnGUI()
    {
        if (!showConsole) { return; }

        float y = 0f;

        GUI.Box(new Rect(0, y, Screen.width, 30), "");
        GUI.backgroundColor = new Color(0, 0, 0, 0);
        input = GUI.TextField(new Rect(10f, y + 5f, Screen.width - 20f, 20f), input);

    }

    private void HandleInput()
    {
        for (int i = 0; i < commandList.Count; i++)
        {
            DebugCommandBase commandBase = commandList[i] as DebugCommandBase;

            if (input.Contains(commandBase.commandId))
            {
                if (commandList[i] as DebugCommand != null)
                {
                    // Cast to this type and invoke the command //
                    (commandList[i] as DebugCommand).Invoke();
                }
            }
        }
    }
}
