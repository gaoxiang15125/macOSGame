//
//  Snake.swift
//  TestThread
//
//  Created by gaoxiang on 2019/10/12.
//  Copyright © 2019 w11757. All rights reserved.
//

import Foundation
import SpriteKit
class Snake{
//蛇不在存储具体吃了多少分的食物，在蛇中增加当前长度属性，
//对与蛇身体怎么绘制，我觉得可以用多个精灵拼接的方式绘制蛇身，虽然明显存在极大的资源浪费，但是除此之外没有啥办法啊（大概没有办法）
    //蛇需要具有的属性：蛇的移动速度 蛇的长度 蛇身体的位置 总感觉这样制作怪怪的
    //对于蛇的绘制，j我觉得可以使用链表来实现
    //一个有趣的想法，我以为可以使用蛇身相互重叠，来实现360的移动方向
    //方块越小自然越精细，不过我很好奇别人如何实现的360度旋转 且待花纹
    //目前的方案：头节点可动，非头节点不可动，每次将最后的节点放置到头节点，作为可动的节点
    let snakeWith:CGFloat = 30.0
    let snakeHight:CGFloat = 20.0
    let snakeBeginNum: Int = 10
    var snakeBodys: Queue<SnakeSection> = Queue<SnakeSection>()
    //蛇不需要知道自己的节点数，只需要知道一次增加多少 蛇只有自己的位置？
    //新的想法，干脆让蛇头拉着身子走不就完了吗
    init(scene: SKScene) {
        //干脆中间座位起始点吧
        //每条蛇节与其上个蛇节的边界链接在一起
        var snakeBuffer: SnakeSection? = nil
        for index in 0...snakeBeginNum {
            let oneSnakeSection = SnakeSection(positionX: scene.size.width/2.0, positionY: scene.size.height/6.0+CGFloat((index*15)), sectionRadius: 25, color: UIColor.purple)
            scene.addChild(oneSnakeSection.snakeSection)
            self.snakeBodys.enqueue(oneSnakeSection)
            print(oneSnakeSection.snakeSection.frame)
            //存在上个节点，就添加链接
            if snakeBuffer == nil {
                
            }else {
                //我认为 Pin 链接 或者 Limit joints 链接比较符合要求
                let snakeJoint = SKPhysicsJointPin.joint(withBodyA: oneSnakeSection.snakeSection.physicsBody!, bodyB: (snakeBuffer?.snakeSection.physicsBody)!, anchor: oneSnakeSection.snakeSection.position)
                scene.physicsWorld.add(snakeJoint)
            }
            snakeBuffer = oneSnakeSection
        }
        snakeBodys.front?.snakeSection.physicsBody?.isDynamic = true
    }
    //蛇的基本方法
}
