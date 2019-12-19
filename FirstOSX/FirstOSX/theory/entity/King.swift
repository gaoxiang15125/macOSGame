//
//  King.swift
//  FirstOSX
//
//  Created by gaoxiang on 2019/11/20.
//  Copyright © 2019 w11757. All rights reserved.
//

import Foundation
import SpriteKit
//按道理可以使用一个类完成所有设计，但是还是使用三个分别实现，知道的少些是好事
class King: SKSpriteNode, BattleCard {
    var cardType: CardType{
        return CardType.King
    }

    convenience init() {
        let texture: SKTexture = SKTexture(imageNamed: "Sun")
        self.init(texture: texture, color: NSColor.black, size: KingAndSlave.cardSize)
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
