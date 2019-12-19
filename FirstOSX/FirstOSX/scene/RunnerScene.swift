//
//  RunnerScene.swift
//  AnimationCreater
//
//  Created by gaoxiang on 2019/11/12.
//  Copyright © 2019 w11757. All rights reserved.
//

import SpriteKit

class RunnerScene: SKScene {
    //本类为创建跑酷效果情景，具体游戏实现可以进行优化
    //障碍物，用来给玩家增加乐趣
    let floorBottom: CGFloat = 150
    let wallNum: Int = 3
    //属性的声明顺序与其初始化顺序相同
    var runner: Runner!
    var obstacleWalls: [WallSprite]!
    
    override func didMove(to view: SKView) {
        setUpBackGroundInfo()
        addRunner()
        addFloor()
        setPhysicsWordInfo()
        addObstacleWall()
    }

    func setUpBackGroundInfo() {
        self.backgroundColor = SKColor.gray
        self.scaleMode = SKSceneScaleMode.aspectFit
    }
    
    func addRunner() {
        runner = Runner()
        self.addChild(runner)
        //不需要设定大小了么，如果不对，修改传入的CGSize值
        //可以通过修改size 直接限制运动员大小，初始位置需要进一步分析判断
        runner.position = CGPoint(x: self.size.width/3, y: self.size.height)
        runner.addAnimationToRunner()
    }
    
    func addFloor() {
        let floor = FloorSprite(size: CGSize(width: self.size.width*2, height: floorBottom))
        self.addChild(floor)
        floor.position = CGPoint(x: self.size.width, y: floorBottom / 2.0)
    }
    func setPhysicsWordInfo() {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -4)
    }
    
    func addObstacleWall() {
        obstacleWalls = [WallSprite]()
        let width = runner.size.width / 3.0 * 2.0
        let height = runner.size.height / 2.0 * 3.0
        for _ in 0..<wallNum {
            let obstacleWall = WallSprite(size: CGSize(width: width, height: height))
            self.addChild(obstacleWall)
            let positionX = randomXsize()
            let positionY = floorBottom + height/2.0
            obstacleWall.position = CGPoint(x: positionX, y: positionY)
            obstacleWalls.append(obstacleWall)
        }
    }
    //为墙体设置随机x轴位置，实现距离的变化
    //距离最小比，即将屏幕的n等分作为可能的最小距离
    let minCutNum: CGFloat = 8
    func randomXsize() -> CGFloat{
        let randomNumber: CGFloat = CGFloat(arc4random() % 30) + minCutNum
        let positionX = self.size.width / CGFloat(minCutNum) * randomNumber
        return positionX
    }
    //碰撞物体的移动速度
    var wallSpeed: CGFloat = 160
    var bufferTime: TimeInterval?
    var halfOfWall: CGFloat!
    override func update(_ currentTime: TimeInterval) {
        if bufferTime == nil {
            bufferTime = currentTime
            halfOfWall = runner.size.width / 3.0
            return
        }
        for wall in obstacleWalls {
            var x = wall.position.x - wallSpeed * CGFloat(currentTime - bufferTime!)
            
            if x < -halfOfWall {
                x = randomXsize() + halfOfWall
            }
            let newPosition = CGPoint(x: x, y: wall.position.y)
            wall.position = newPosition
        }
        bufferTime = currentTime
    }
    override func touchesBegan(with event: NSEvent) {
        runner.physicsBody?.applyForce(CGVector(dx: 0, dy: 100))
        runner.physicsBody?.velocity = CGVector(dx: 0, dy: 400)
    }
    override func touchesCancelled(with event: NSEvent) {
        runner.physicsBody?.applyForce(CGVector(dx: 0, dy: 100))
        runner.physicsBody?.velocity = CGVector(dx: 0, dy: 400)
    }
    override func beginGesture(with event: NSEvent) {
        runner.physicsBody?.applyForce(CGVector(dx: 0, dy: 100))
        runner.physicsBody?.velocity = CGVector(dx: 0, dy: 400)
    }
    override func keyDown(with event: NSEvent) {
        print(event)
        runner.physicsBody?.applyForce(CGVector(dx: 0, dy: 100))
        runner.physicsBody?.velocity = CGVector(dx: 0, dy: 400)
    }
}
