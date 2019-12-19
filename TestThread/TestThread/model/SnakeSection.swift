//
//  SnakeSection.swift
//  TestThread
//
//  Created by gaoxiang on 2019/10/12.
//  Copyright © 2019 w11757. All rights reserved.
//

import Foundation
import SpriteKit

class SnakeSection {
    
    var positionX: CGFloat = 0.0
    var positionY: CGFloat = 0.0
    var sectionRadius: CGFloat = 0.0
    var snakeSection: SKShapeNode!
    var snakeColor:UIColor!
    
    init(positionX:CGFloat,positionY:CGFloat,sectionRadius: CGFloat,color:UIColor) {
        self.positionY = positionY
        self.positionX = positionX
        self.sectionRadius = sectionRadius
        snakeColor = color
        creatSnakeSection()
    }
    func creatSnakeSection(){
        //通过使用xy与颜色关联的方式，实现随机颜色
        //参数内是食物情景的大小，作为生成的食物信息的依据
        
        //根据随机生成的数据初始化精灵，碰撞体什么的一起加了
        snakeSection = ShapeTools.creatCircleWithColorAndRadius(color: snakeColor, radius: sectionRadius)
        snakeSection?.physicsBody = SKPhysicsBody(circleOfRadius: sectionRadius)
        snakeSection?.position = CGPoint(x: positionX, y: positionY)
        //snakeSection.physicsBody?.isDynamic = false
    }
    func snakeIsNotTop() {
        snakeSection.physicsBody?.isDynamic = false
    }
    func snakeIsTop() {
        snakeSection.physicsBody?.isDynamic = true
    }
}
