//
//  Runner.swift
//  AnimationCreater
//
//  Created by gaoxiang on 2019/11/12.
//  Copyright © 2019 w11757. All rights reserved.
//

import SpriteKit

class Runner: SKSpriteNode {
//先尝试着看看效果，不行在该吧
    //闭包会被赋值几次？看一看
    static var allTextures: [SKTexture] = {
        let atlas = SKTextureAtlas(named: "perRun")
        print("闭包赋值被调用了，加载的图集数量为：")
        print(atlas.textureNames.count)
        //不知道这样写此属性会被调用多少次，暂时这样设计
        let testureNames = (atlas.textureNames ).sorted { (one, two) -> Bool in
            return one < two
        }
        return testureNames.map { (textureName) -> SKTexture in
            return atlas.textureNamed(textureName)
        }
    }()

    convenience init() {
        let width = Runner.allTextures[0].size().width
        let height = Runner.allTextures[0].size().height
        let runnerSize = CGSize(width: width / 2, height: height / 2)
        self.init(texture: Runner.allTextures[0],color: NSColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0),size: runnerSize)
    }
    override init(texture: SKTexture?, color: NSColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        //addAnimationToRunner()
        //智能的编译器在重写的构造方法外无法知道self表示的是什么类型的精灵
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //添加动画实现的函数，但是此时还没有为其设定大小与位置，不知道可不可以在初始时调用该方法
    func addAnimationToRunner() {
        let animationAction = SKAction.animate(with: Runner.allTextures, timePerFrame: 1.0/10.0)
        self.run(SKAction.repeatForever(animationAction))
    }
}
