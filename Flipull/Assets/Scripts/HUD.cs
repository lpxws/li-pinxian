using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class HUD : MonoBehaviour
{
    public TextMeshProUGUI blockNumText;
    public TextMeshProUGUI gameResulText;
    public TextMeshProUGUI targetText;
    public Button playButton;
    public Button exitButton;
    // Start is called before the first frame update

    public void ShowBlockNumber(int num) {
        blockNumText.text = "Blocks    " + num;
    }

    public void ShowGameStart(int winNumber) {
        gameResulText.gameObject.SetActive(false);
        playButton.gameObject.SetActive(false);
        exitButton.gameObject.SetActive(false);
        targetText.text = "CLEAR " + winNumber;
    }

    //现实游戏胜利界面
    public void ShowGameWin(int type) {
        switch (type) {
            case 0:
                gameResulText.text = "YOU WIN";
                break;
            case 1:
                gameResulText.text = "PERFECT";
                break;
            case 2:
                gameResulText.text = "JUST CLEAR";
                break;
        }
        gameResulText.gameObject.SetActive(true);
        playButton.gameObject.SetActive(true);
        exitButton.gameObject.SetActive(true);

    }

    //显示游戏结束界面
    public void ShowGameOver() {
        gameResulText.text = "GAME OVER";
        playButton.gameObject.SetActive(true);
        gameResulText.gameObject.SetActive(true);
        exitButton.gameObject.SetActive(true);
    }
}
