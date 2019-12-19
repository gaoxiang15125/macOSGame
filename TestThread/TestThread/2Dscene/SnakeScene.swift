//
//  SnakeScene.swift
//  TestThread
//
//  Created by gaoxiang on 2019/10/13.
//  Copyright © 2019 w11757. All rights reserved.
//

import UIKit
import SpriteKit

class SnakeScene: SKScene {
    //使用添加静态链接的方式实现拖拽功能
    var dragNode: SKNode?
    var dragJoint: SKPhysicsJoint?
    //持久化对象
    var snake:Snake!
    override init(size: CGSize) {
        super.init(size: size)
//        //添加墙体，放置掉落
//        let wallsNode = SKNode()
//        //不能设置锚点，直接尝试使用定点矩形作为边界
//        let rect = CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width, height: self.frame.height)
//        wallsNode.physicsBody = SKPhysicsBody(edgeLoopFrom: rect)
//        self.addChild(wallsNode)
        //添加小蛇
        snake = Snake(scene: self)
        self.backgroundColor = UIColor.gray
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
    }
    //添加拖拽节点的实现
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //之前已经设置过参数了，那么那里的参数会对此处的点击结果造成什么影响吗
        guard let touch = touches.first else {
            print("不能无故进入吧： \(event!)")
            return
        }
        //获取目前被触摸的精灵节点
        let touchPosition = touch.location(in: self)
        let touchNode = self.atPoint(touchPosition)
        //书上与代码中存在差异，采取我认为正确的方式
        guard touchNode.physicsBody != nil else {
            return
        }
        //按我理解是加了一个静态节点作为拖拽的目标
        let newDragNode = SKNode()
        newDragNode.position = touchPosition
        newDragNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 10))
        newDragNode.physicsBody?.isDynamic = false
        self.addChild(newDragNode)
        //将两者按照可滑动链接到一起
        let newDragJoint = SKPhysicsJointPin.joint(withBodyA: newDragNode.physicsBody!, bodyB: touchNode.physicsBody!, anchor: touchPosition)
        self.physicsWorld.add(newDragJoint)
        self.dragJoint = newDragJoint
        self.dragNode = newDragNode
    }
    //添加拖拽移动动画
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //这个判断的目的是什么？我不相信会误调
        guard let touch = touches.first else {
            return
        }
        let touchPosition = touch.location(in: self)
        dragNode?.position = touchPosition
    }
    //移除手指的时候，删除链接的节点
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        stopDragging()
    }
    //点击取消时，也要判断是否创建了链接，创建了就将其移出
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        stopDragging()
    }
    func stopDragging() {
        guard dragJoint != nil else {
            return
        }
        self.physicsWorld.remove(dragJoint!)
        dragJoint = nil
        dragNode?.removeFromParent()
        dragNode = nil
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
