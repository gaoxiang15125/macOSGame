//
//  BallGameScene.swift
//  TestThread
//
//  Created by gaoxiang on 2019/10/12.
//  Copyright © 2019 w11757. All rights reserved.
//

import UIKit
import SpriteKit
class BallGameScene: SKScene {
//  该场景在游戏中不会重复出现，直接使用单列模式
//算了 感觉好像不太适合单例模式
    //游戏中包含三个运动精灵，一个文字精灵，
    //猜测使用图片构造的精灵并不是圆形
    var ballNode = SKSpriteNode(imageNamed: "Ball")
    var playerNodeOne = SKSpriteNode(color: UIColor.green, size: CGSize(width: 100, height: 20))
    var playerNodeTwo = SKSpriteNode(color: UIColor.green, size: CGSize(width: 100, height: 20))
    var operationFashion = SKLabelNode(fontNamed: "ZenzaiItache")
    override init(size: CGSize) {
        super.init(size: size)
        addPhysicsToSprite()
    }
    func addPhysicsToSprite() {
        //为小球、两个玩家设置初始位置与对应的物理碰撞体
        //并将精灵节点加入到游戏情景中
        //一个小问题，文本可以被点击选中吗
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
