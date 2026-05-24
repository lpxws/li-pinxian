using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{
    static GameManager _instance;
    public int levelNumber = 1;
    
    void Awake() {
        _instance = this;
        DontDestroyOnLoad(_instance.gameObject);
    }

    public static GameManager Instance{
        get {
            return _instance;
        }
    }

    
}
