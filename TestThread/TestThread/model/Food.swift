//
//  File.swift
//  TestThread
//
//  Created by gaoxiang on 2019/10/12.
//  Copyright © 2019 w11757. All rights reserved.
//

import Foundation
import SpriteKit

class Food {
    //无法通过继承解决问题，决定采用拥有的方式控制精灵
    //之所以不继承，是因为初始化过不去啊
    var positionX: CGFloat = 0
    var positionY: CGFloat = 0
    var radius: CGFloat = 0
    var foodSprite: SKShapeNode?
    init(sceneSize: CGSize) {
        //初始化精灵信息，颜色等随机
        makeFoodSpriteRight(sceneSize: sceneSize)
    }
    func makeFoodSpriteRight(sceneSize: CGSize) {
        //通过使用xy与颜色关联的方式，实现随机颜色
        //参数内是食物情景的大小，作为生成的食物信息的依据
        self.positionX = CGFloat(arc4random_uniform(UInt32(sceneSize.width)))
        self.positionY = CGFloat(arc4random_uniform(UInt32(sceneSize.height)))
        self.radius = CGFloat(arc4random_uniform(UInt32(StaticTable.maxFoodSize)))
        //根据随机生成的数据初始化精灵，碰撞体什么的一起加了
        let randomColor = UIColor(red: 247/255.0, green: self.positionX/sceneSize.width, blue: self.positionY/sceneSize.height, alpha: 1.0)
        foodSprite = ShapeTools.creatCircleWithColorAndRadius(color: randomColor, radius: radius)
        foodSprite?.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        print(foodSprite?.frame.size)
        foodSprite?.position = CGPoint(x: positionX, y: positionY)
    }
    //需要加什么回头再看吧
}
