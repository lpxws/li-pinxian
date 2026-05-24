using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using System.Xml;

public class GameController : MonoBehaviour
{
    private GameManager gameManager;

    //关卡尺寸
    public float gridSize;
    public int height;
    public int width;
    public Vector2 originPoint;

    private Bullet bullet;
    public Wall wallPrefab;
    private XmlNodeList wallList;
    private bool[] skipX;
    private bool[] skipY;
    public Block blockPrefab;
    private Block[][] blockGroup;
    private Block[][] tempBlockGroup;
    private int blockNumX;
    private int blockNumY;
    public int colorNum;

    public PlayerController playerController;
    private enum GAME_STATE {
        REDAY,
        PLAY,
        ROUND_END,
        OVER
    }
    private GAME_STATE gameState;

    //游戏分数相关
    private int blockNumber;
    private int score;
    private int winNumber;

    //UI
    public HUD hudController;
    
    // Start is called before the first frame update
    void Start()
    {
       InitiateGame();
       RestartGame();
    }

    private void InitiateGame()
    {   
        //创建游戏控制器
        if (FindObjectOfType(typeof(GameManager)) != null)
        gameManager = FindObjectOfType(typeof(GameManager)) as GameManager;
        else {
            GameObject go = new GameObject("GameManager");
            DontDestroyOnLoad(go);
            gameManager = go.AddComponent<GameManager>();
        }

        //从XML读取关卡数据
        TextAsset xmlFile = Resources.Load<TextAsset>("Datas/Data_Levels");
        XmlDocument document = new XmlDocument();
        document.LoadXml(xmlFile.text);
        XmlNodeList nodeList = document.SelectSingleNode("level").ChildNodes;
        foreach (XmlElement elementLevel in nodeList) 
        {  
            if (gameManager.levelNumber.ToString() == elementLevel.ChildNodes[0].InnerText) {
                blockNumX = int.Parse(elementLevel.ChildNodes[1].InnerText);
                blockNumY = int.Parse(elementLevel.ChildNodes[2].InnerText);
                winNumber = int.Parse(elementLevel.ChildNodes[3].InnerText);
                wallList = elementLevel.ChildNodes[4].ChildNodes;
                skipX = new bool[blockNumX];
                for (int i = 0; i < blockNumX; i++) skipX[i] = false;
                skipY = new bool[blockNumY];
                for (int j = 0; j < blockNumY; j++) skipY[j] = false;
                if (elementLevel.ChildNodes[5] != null) 
                    foreach (XmlElement elementX in elementLevel.ChildNodes[5].ChildNodes) 
                        skipX[int.Parse(elementX.InnerText)] = true;

                if (elementLevel.ChildNodes[6] != null) 
                    foreach (XmlElement elementY in elementLevel.ChildNodes[6].ChildNodes) 
                        skipY[int.Parse(elementY.InnerText)] = true;
                break;
            }
        }

        //初始化游戏状态
        gameState = GAME_STATE.REDAY;
        playerController.Initiate(gridSize, height, width, originPoint);
        bullet = playerController.bullet;
        bullet.gameController = this;
        
        //初始化方块列表
        blockGroup = new Block[blockNumX][];
        for (int a = 0; a < blockNumX; a++) blockGroup[a] = new Block[blockNumY]; 
        tempBlockGroup = blockGroup;
    }

    private void RestartGame() {
        gameState = GAME_STATE.PLAY;
        blockNumber = 0;
        CreateBlocks(blockNumX, blockNumY);
        CreateWall();

        playerController.RestartGame();

        hudController.ShowGameStart(winNumber);
        hudController.ShowBlockNumber(blockNumber);
    }

    //创建排列方块组
    private void CreateBlocks(int numX, int numY)
    {
        //生成随机池
        int max = blockNumX * blockNumY;
        List<int> random = new List<int>();
        for (int m = 0; m < max; m++) {
            random.Add(m % colorNum + 1 );
        }

        for (int i = 0; i < numX; i++)
        {
            for (int j = 0; j < numY; j++)
            {
                Block blockInstance = Instantiate(blockPrefab, GetPositionByGrid(i, j), Quaternion.identity);
                blockInstance.posX = i;
                blockInstance.posY = j;
                int randomMark = random[Random.Range(0, random.Count)];
                blockInstance.ChangeMark(randomMark);
                random.Remove(randomMark);
                //blockGroup.Add(blockInstance);
                blockGroup[i][j] = blockInstance;
                blockNumber ++;
            }
        }
    }

    //创建墙砖块
    private void CreateWall() {
        foreach (XmlElement wallElement in wallList) {
            int x = int.Parse(wallElement.ChildNodes[1].InnerText);
            int y = int.Parse(wallElement.ChildNodes[2].InnerText);
            Wall wallInstance = Instantiate(wallPrefab, new Vector2(originPoint.x + x*gridSize, originPoint.y + y*gridSize), Quaternion.identity);
            wallInstance.gridX = x;
            wallInstance.type = int.Parse(wallElement.ChildNodes[0].InnerText);
        }
    }

    //子弹碰撞处理
    public void BulletOnTrigger(GameObject otherObject) {
        //Debug.Log(otherObject.tag);
        switch (otherObject.tag)
        {
            case "Ground":
                EndRound();
                break;
            case "Wall":
                Wall wall = otherObject.gameObject.GetComponent<Wall>();
                if (bullet.IsShooting()) {
                    if (wall != null) bullet.posX = wall.gridX + 1;
                    bullet.Fall();
                    bullet.AlignToGrid(originPoint, gridSize);
                }
                if (bullet.IsFalling()) {
                    if (wall.gridX == bullet.posX && wall.type == 1) {

                    }
                }
                break;
            case "Block":
                Block block = otherObject.gameObject.GetComponent<Block>();
                if (block != null && ((bullet.IsShooting() && block.posY == bullet.posY) || (bullet.IsFalling() && block.posX == bullet.posX))){
                    CollideBlock(block);
                }
                break;
        }
    }

    //子弹与砖块碰撞处理
    private void CollideBlock(Block block){
        if (bullet.mark == 0) {
            bullet.ChangeMark(block.mark);
            bullet.isFirstShoot = false;
        }
        if (bullet.mark == block.mark) {
            bullet.isFirstShoot = false;
            //消除相同砖块，并将上方砖块下落，更新砖块网格信息
            for (int j = block.posY;  j < blockNumY; j++){
                if (j == blockNumY -1 || blockGroup[block.posX][j + 1] == null) {
                    tempBlockGroup[block.posX][j] = null;
                    continue;
                }
                Block tempBlock = blockGroup[block.posX][j + 1];
                tempBlock.Move(GetPositionByGrid(block.posX, j));
                tempBlockGroup[block.posX][j] = tempBlock;
            }
            Destroy(block.gameObject);
            blockNumber --;
            hudController.ShowBlockNumber(blockNumber);
        } else {
            if (bullet.isFirstShoot) EndRound();
            else {
                int i = bullet.mark;
                bullet.ChangeMark(block.mark);
                block.ChangeMark(i);
                EndRound();
            }
        }
    }


    public Vector2 GetPositionByGrid(int gridX, int gridY) {
        Vector2 position = new Vector2(originPoint.x + gridX * gridSize, originPoint.y + gridY * gridSize );
        return position;
    }

    //发射结束
    private void EndRound() {
        gameState = GAME_STATE.ROUND_END;
        playerController.BulletReturn();
        for(int i = 0; i < blockNumX; i++) {
            for (int j = 0; j < blockNumY; j++) {
                Block tempBlock = tempBlockGroup[i][j];
                if (tempBlock != null) {
                    tempBlock.posX = i;
                    tempBlock.posY = j;
                }
            }
        }
        blockGroup = tempBlockGroup;

        IsGameEnd();
    }

    public bool IsGameEnd() {
        //检测游戏是否结束
        if (IsBulletWasted()) {
            if (IsGameWin()) {
                GameWin();
                return true;
            } else {
                GameOver();
                return true;
            }
        }
        return false;
    }

    //检测是否游戏胜利
    private bool IsGameWin() {
        if (blockNumber <= winNumber) {
            return true;
        }
        return false;
    }

    //检测是否没有可以射击的砖块
    private bool IsBulletWasted() {
        //检测横向
        for (int i = 0; i < blockNumX; i++) {
            if (skipX[i]) continue;
            for (int j = blockNumY - 1; j > -1; j--) {
                if (blockGroup[i][j] == null) continue;
                if (blockGroup[i][j].mark == bullet.mark || bullet.mark == 0) return false;
                else break;
            }
        }  
        //检测纵向
        for (int m = 0; m < blockNumY; m++) {
            if (skipY[m]) continue;
            for (int n = blockNumX - 1; n > -1; n--) {
                if (blockGroup[n][m] == null) continue;
                if (blockGroup[n][m].mark == bullet.mark || bullet.mark == 0) return false;
                else break;
            }
        }  
       
        return true;
    }

    //游戏胜利流程
    private void GameWin() {
        int a = 0;
        if (blockNumber == 3) a = 1;
        else if (blockNumber == winNumber) a = 2;
        hudController.ShowGameWin(a);
    }

    //游戏结束流程
    private void GameOver() {
        hudController.ShowGameOver();
    }

    //游戏重新开始流程
    public void ResetGame() {
        foreach (Block[] items in blockGroup)
        {
            foreach (Block blk in items){
                if (blk != null)
            Destroy(blk.gameObject);
            }
        }
        
        Invoke("RestartGame", 0.2f);
    }

    //返回关卡选择界面
    public void ExitGame() {
        SceneManager.LoadScene("LevelSelectScene");
    }
}
