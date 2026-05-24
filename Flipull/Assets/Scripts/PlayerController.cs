using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    private float gridSize;
    private int levelHeight;
    private int levelWidth;
    private Vector2 originPoint;
    private int posX;
    private int posY;
    public Bullet bullet;
    //private int shootPosition;
    private bool canMove = true;
    private bool canShoot = true;
    public GameObject playerGun; 
    public float moveInternalTime;

    // Update is called once per frame
    void Update()
    {  
        if (canMove && canShoot) {
            if (Input.GetKey("space")){
                bullet.Shoot(posX, posY);
                canMove = false;
                canShoot = false;
            }
            else if (Input.GetKey("down")) {
                posY -= 1;
                if (posY < 0) posY = 0;
                MoveGun();
            }
            else if (Input.GetKey("up")) {
                posY += 1;
                if (posY > levelHeight - 1) posY = levelHeight - 1;
                MoveGun();
            }
        }
    }

    public void Initiate(float grid, int height, int width, Vector2 oPoint) {
        gridSize = grid;
        levelHeight = height;
        levelWidth = width;
        originPoint = oPoint;
        bullet = Instantiate(bullet, new Vector2(1, 1), Quaternion.identity);
        bullet.Initiate(gridSize);
        bullet.playerController = this;
        //ResetGame();
    }

    public void RestartGame() {
        canMove = true;
        canShoot = true;
        posY = 0;
        posX = levelWidth + 1;
        SetGunPosition(posX, 0);
        SetBulletPosition(levelWidth, 0);
        bullet.RestartGame();
    }

    //设置发射位置
    private void SetGunPosition(int X, int Y) {
        playerGun.gameObject.transform.position = new Vector3(originPoint.x + gridSize * X, originPoint.y + gridSize * Y, 0);
    }

    //设置子弹位置
    private void SetBulletPosition(int X, int Y) {
        bullet.transform.position = new Vector3(originPoint.x + gridSize * X, originPoint.y + gridSize * Y, 0);
    }

    //让子弹回到发射位置
    public void BulletReturn() {
        bullet.Return(posY);
    }

    //移动
    private void MoveGun() {        
        canMove = false;
        canShoot = false;
        SetGunPosition(posX, posY);
        SetBulletPosition(levelWidth, posY);
        Invoke("ResetMove", moveInternalTime);
    }

    //射击间隔结束，恢复射击
    public void ResetMove() {
        Invoke("ResetMoveInvoke", 0.1f);
    }

    private void ResetMoveInvoke() {
        if (!canMove) canMove = true;
        if (!canShoot) canShoot = true;
    }



}
