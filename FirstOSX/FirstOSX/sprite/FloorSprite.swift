//
//  FloorSprite.swift
//  AnimationCreater
//
//  Created by gaoxiang on 2019/11/12.
//  Copyright © 2019 w11757. All rights reserved.
//

import SpriteKit
//如果没有特色，就使用run代替吧
class FloorSprite: SKSpriteNode {
    //特色： 有碰撞体积，但是静止,作为精灵的地面
    convenience init(size: CGSize) {
        self.init(texture: nil, color: NSColor.black, size: size)
    }
    override init(texture: SKTexture?, color: NSColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        addPhysicsInfo()
    }
    //希望这种错误不会出现第二次了，太low了
    func addPhysicsInfo() {
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = false
        //测试是否isDynamic参数影响碰撞
//        self.physicsBody?.applyForce(CGVector(dx: 0, dy: 10))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
