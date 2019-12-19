//
//  TwoDController.swift
//  TestThread
//
//  Created by gaoxiang on 2019/10/12.
//  Copyright © 2019 w11757. All rights reserved.
//

import UIKit
import SpriteKit
import CoreMotion

class TwoDController: UIViewController {
    
    var gameView: SKView?
    var speedX:UIAccelerationValue = 0
    var speedY:UIAccelerationValue = 0
    var motionManager = CMMotionManager()
    var snakeHead:SnakeSection?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        gameView = (self.view as! SKView)
        let snakeScene = SnakeScene(size: (gameView?.bounds.size)!)
        gameView?.presentScene(snakeScene)
        snakeHead = snakeScene.snake.snakeBodys.front
        motionManager.accelerometerUpdateInterval = 1/60
        if motionManager.isAccelerometerAvailable{
            let queue = OperationQueue.current
            motionManager.startAccelerometerUpdates(to: queue!) { (accelerometerData, error) in
                if error != nil{
                    self.motionManager.stopAccelerometerUpdates()
                }else{
                    //动态设置小球位置
                    self.speedX += accelerometerData!.acceleration.x
                    self.speedY += accelerometerData!.acceleration.y
                    var posX = (self.snakeHead?.snakeSection.position.x)! + CGFloat(self.speedX)
                    var posY = (self.snakeHead?.snakeSection.position.y)! + CGFloat(self.speedY)
                    //碰到边框后的反弹处理
                    if posX<0{
                        posX = 0
                        //碰到左边的边框以0.4倍的速度反弹
                        self.speedX *= -0.4
                    }else if posX > self.view.bounds.size.width{
                        posX = self.view.bounds.size.width
                        //碰到右边的边框以0.4倍的速度反弹
                        self.speedX *= -0.4
                    }
                    if posY < 88{
                        posY = 88
                        //碰到上面的边框不反弹
                        self.speedY *= 0.5
                    }else if posY > self.view.bounds.size.height{
                        posY = self.view.bounds.size.height
                        //碰到下面的边框以1.5倍的速度反弹
                        self.speedY *= -0.5
                    }
                    self.snakeHead?.snakeSection.position = CGPoint(x: posX, y: posY)
                }
               
            }
        }else{
            print("你的设备不支持加速计")
        }
    }
}
