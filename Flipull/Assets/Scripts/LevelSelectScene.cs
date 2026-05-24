using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class LevelSelectScene : MonoBehaviour
{
    private GameManager gameManager;
    // Start is called before the first frame update
    void Start()
    {
        if (FindObjectOfType(typeof(GameManager)) != null)
        gameManager = FindObjectOfType(typeof(GameManager)) as GameManager;
        //GameObject.FindObjectsOfType<GameManager>()[0].GetComponent<GameManager>();
        else {
            GameObject go = new GameObject("GameManager");
            DontDestroyOnLoad(go);
            gameManager = go.AddComponent<GameManager>();
            }
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void EnterLevel(int level) {
        gameManager.levelNumber = level;
        SceneManager.LoadScene("PlayScene");
    }
}
