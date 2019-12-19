//
//  StaticTable.swift
//  TestThread
//
//  Created by gaoxiang on 2019/10/12.
//  Copyright © 2019 w11757. All rights reserved.
//

import Foundation

class StaticTable {
    //食物与其可使蛇增加长度之间的关系
    //思考后认为使用两个链表进行存储效果最好
    static let foodSizeTable:[Int] = [5,10,15]
    static let snakeGrowTable:[Int] = [1,2,3,4]
    //食物大小的最大值
    static let maxFoodSize: Int = 20
    //传入吃到的食物大小，返回蛇成长的长度
    static func getGrowResult(foodSize: Int) -> Int{
        var grade:Int = 0
        for foodIndex in foodSizeTable {
            if foodIndex > foodSize {
                break
            }
            grade += 1
        }
        return snakeGrowTable[grade]
    }
}
