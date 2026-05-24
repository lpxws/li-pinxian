using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Bullet : Block
{
    //public float moveTime;
    public GameController gameController;
    public PlayerController playerController;
    public bool isFirstShoot;
    private Vector3 targetPosition;
    public float returnSpeed;

    // Update is called once per frame
    void Update()
    {
        switch (state){
            case STATE.SHOOT : 
                transform.position = Vector3.MoveTowards(transform.position, new Vector3(-500, transform.position.y, 0), speed * Time.deltaTime);
                break;
            case STATE.FALL :
                transform.position = Vector3.MoveTowards(transform.position, new Vector3(transform.position.x, -500, 0), speed * Time.deltaTime);
                break;
            case STATE.RETURN :
                Vector3 center = (transform.position + targetPosition) * 0.5f;
                center -= new Vector3(0, 0.5f, 0);
                Vector3 start = transform.position - center;
                Vector3 end = targetPosition - center;
                transform.position = Vector3.Slerp(start, end, returnSpeed*Time.deltaTime);
                transform.position += center;
            
                //transform.position = Vector3.MoveTowards(transform.position, targetPosition, returnSpeed * Time.deltaTime);
                if (Vector3.Distance(transform.position, targetPosition) <= 0.1f) {
                    transform.position = targetPosition;
                    if (!gameController.IsGameEnd()){
                        playerController.ResetMove();
                        state = STATE.IDLE;
                    }
                }
                
                break;
        }
    }

    //初始化方块
    public void Initiate(float grid){
        gridSize = grid;
    }

    public void RestartGame() {
        ChangeMark(0);
        isFirstShoot = true;
        state = STATE.IDLE;
    }

    //发射子弹
    public void Shoot(int x, int y)
    {
        posX = x;
        posY = y;
        if(state == STATE.IDLE) {
            state = STATE.SHOOT;
        }
    }
    //下落
    public void Fall(){
        if (state == STATE.SHOOT) {
            state = STATE.FALL;
        }
    }
    
    //返回射击位置
    public void Return(int returnPosition)
    {
        state = STATE.RETURN;
        targetPosition = new Vector3(gameController.originPoint.x + gridSize * gameController.width, gameController.originPoint.y + gridSize * returnPosition);
        isFirstShoot = true;
    }

    //与其他物件发生碰撞
    public void OnTriggerEnter2D(Collider2D col){
        gameController.BulletOnTrigger(col.gameObject);
    }


}
