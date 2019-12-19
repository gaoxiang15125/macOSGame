//
//  BattleCard.swift
//  FirstOSX
//
//  Created by gaoxiang on 2019/11/20.
//  Copyright © 2019 w11757. All rights reserved.
//

import Foundation

protocol BattleCard {
    var cardType: CardType {
        get
    }
    func compare(hostileCard: BattleCard) -> CompareResult
}
//该枚举应该从属于国王奴隶游戏情景，回头再转移
enum CardType: Int {
    case King = 2
    case Citizen = 0
    case Salve = -1
}
enum CompareResult: Int {
    case Win = 1
    case Lost = -1
    case draw = 0
}
//编写一个默认的比较方式，仅用于国王与努力游戏
extension BattleCard{
    
    func compare(hostileCard: BattleCard) -> CompareResult {
        //通过控制数字的结果范围判读卡牌大小关系
        let cardValue: Int = self.cardType.rawValue + hostileCard.cardType.rawValue
        if cardValue == 0 {
            return CompareResult.draw
        }else if self.cardType == CardType.King && (cardValue == 2) {
            return CompareResult.Win
        }else if self.cardType == CardType.Citizen && cardValue == -1 {
            return CompareResult.Win
        }else {
            return CompareResult.Lost
        }
    }
}
