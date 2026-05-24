using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Block : MonoBehaviour
{
    //public float gridSize;
    public int posX;
    public int posY;
    public float gridSize = 1.6f;
    public float speed = 2;
    public int mark;//the picture number of the block
    protected enum STATE{
        IDLE,
        FALL,
        MOVE,
        SHOOT,
        RETURN
    }
    protected STATE state;
    private Vector2 moveTarget;

    // Start is called before the first frame update
    void Start()
    {        
    }

    // Update is called once per frame
    void Update()
    {
        if (state == STATE.MOVE) {
            transform.position = Vector2.MoveTowards(transform.position, moveTarget, speed * Time.deltaTime * 2);
            if (Vector2.Distance(transform.position, moveTarget) < 0.1f ) {
                state = STATE.IDLE;
                transform.position = new Vector3(moveTarget.x, moveTarget.y, 0);
            }
        }   
    }

    //改变图案
    public void ChangeMark(int newMark) 
    {
        Color newColor = new Color();
        switch (newMark)
        {
            case 0 : newColor = Color.white;
            break;
            case 1 : newColor = Color.green;
            break;
            case 2 : newColor = Color.blue;
            break;
            case 3 : newColor = Color.red;
            break;
            case 4 : newColor = Color.yellow;
            break;
        }
        GetComponent<SpriteRenderer>().color = newColor;
        mark = newMark;
    }

    //判断是否在下落或移动
    public bool IsFalling() {
        if (state == STATE.FALL) return true;
        else return false;
    }
    public bool IsShooting() {
        if (state == STATE.SHOOT) return true;
        else return false;
    }

    public void Move(Vector2 targetPoint, bool updateGrid = false, int newX = 0, int newY = 0) {
        state = STATE.MOVE;
        moveTarget = targetPoint;
    }

    //调整位置符合网格
    public void AlignToGrid(Vector2 originPoint, float size) {
        transform.position = new Vector3(originPoint.x += gridSize * posX, originPoint.y += gridSize * posY, 0);
        gridSize = size;
    }
}
