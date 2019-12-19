//
//  KingAndSlave.swift
//  FirstOSX
//
//  Created by gaoxiang on 2019/11/20.
//  Copyright © 2019 w11757. All rights reserved.
//

import SpriteKit

class KingAndSlave: SKScene {
    
    let cardNum: Int = 4
    //默认卡牌大小
    static let cardSize: CGSize = CGSize(width: 90, height: 60)
    //玩家手中的套牌，默认为国王套牌
    var playList: Array<BattleCard> = Array()
    var computerList: Array<BattleCard> = Array()
    override func didMove(to view: SKView) {
        //创建游戏情景
        //初始化两组套牌，并选择一组作为玩家的套牌
        setUpBackGroundInfo()
        creatGameInfo()
        drawSpriteToScene()
    }
    //设置情景背景
    func setUpBackGroundInfo() {
        self.backgroundColor = SKColor.gray
        self.scaleMode = SKSceneScaleMode.aspectFit
    }
    //创建两组卡牌，一组包含一个国王，一组包含一个奴隶
    func creatGameInfo() {
        for index in 0...cardNum - 1 {
            playList.append(Citizen())
            computerList.append(Citizen())
        }
        addSpecialCard()
    }
    func addSpecialCard() {
        if playList.count < cardNum {
            playList.append(King())
            computerList.append(Salve())
            return
        }
        let battleCard: BattleCard = playList[3]
        if battleCard.cardType == CardType.King {
            playList[3] = Salve()
            computerList[3] = King()
        }else {
            playList[3] = King()
            computerList[3] = Salve()
        }
        
    }
    //向情景中添加等待绘制的精灵,
    //重新绘制精灵代价太高，不如直接重新创建情景
    func drawSpriteToScene() {
        let minInterval: CGFloat = self.size.width/CGFloat(cardNum*2)
        var number: CGFloat = 0
        for battleCard in playList {
            let battleBuffer = battleCard as! SKSpriteNode
            self.addChild(battleBuffer)
            let x:CGFloat = minInterval * (1 + number)
            let y:CGFloat = KingAndSlave.cardSize.height/2 + 20
            number += 2
            battleBuffer.position = CGPoint(x: x, y: y)
        }
        number = 0;
        for battleCard in computerList {
            let battleBuffer = battleCard as! SKSpriteNode
            self.addChild(battleBuffer)
            let x:CGFloat = minInterval * (1 + number)
            let y:CGFloat = self.size.height - KingAndSlave.cardSize.height/2 - 20
            number += 2
            battleBuffer.position = CGPoint(x: x, y: y)
        }
    }
    //添加出牌动画
    func moveCardToMiddle(moveCard: BattleCard) {
        
    }
}
