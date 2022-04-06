using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class MainMenu : MonoBehaviour
{
    public void SinglePlayer(int sceneLoad)
    {
        SceneManager.LoadScene(sceneLoad);
    }

    public void Quit()
    {
        Application.Quit();
    }
}
