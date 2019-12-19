//
//  MapCreat.swift
//  FirstOSX
//
//  Created by gaoxiang on 2019/11/25.
//  Copyright © 2019 w11757. All rights reserved.
//

import Foundation

//构造指定大小、地雷数量的地图的数据信息
//本质是随机在地图资源上添加地雷
class MapCreater {
    //二维数组更符合使用情景，修改返回类型为二维数组

    //返回存储地雷方格引用的数组
    //尝试使用元组同时返回地雷列表与方格列表
    public static func creatMap(width: Int, hight: Int, mineCount: Int) -> (mapInfo: [[CellInfo]], mineArray: [CellInfo]) {
        //稍微增加些健壮性
        //地雷数目不能多于格子数目的一半
        //如此声明，所有的对象全部指向同一个地址，本质上根本没有初始化
        var mapInfo: [[CellInfo]] = [[CellInfo]](repeating: [CellInfo](repeating: CellInfo(textCell: "0"), count: width), count: hight)
        //存储地雷的坐标，作为胜利条件的判断，同时应该对可以标注的地雷的数量进行限制
        //存储地雷的引用
        //swift 不需要为列表规定大小吗
        var mineArray: [CellInfo] = [CellInfo]()
        
        if width == 0 || hight == 0 {
            return (mapInfo: mapInfo, mineArray: mineArray)
        } else if (width * hight) < 2 * mineCount {
            return (mapInfo: mapInfo, mineArray: mineArray)
        }
        //自动生成的数组包含的是相同的引用
        //其实也可以存储相同的引用，不过使用这种更好理解
        for index in 0..<hight {
            for xPos in 0..<width {
                mapInfo[index][xPos] = CellInfo(textCell: "0")
            }
        }
        var mineNumber = mineCount
        //通过随机数添加地雷，注意相同的随机数不计算在内
        while(mineNumber > 0) {
            //这种传递应该就是引用传递
            let xPos = Int(arc4random()) % width
            let yPos = Int(arc4random()) % hight
            let cellInfo = mapInfo[yPos][xPos]
            if cellInfo.realType == CellInfo.CellStyle.Empty {
                cellInfo.realType = CellInfo.CellStyle.Mine
                cellInfo.printType = .Mine
                mineArray.append(cellInfo)
                mineNumber -= 1
            }
        }
        return (mapInfo: mapInfo, mineArray: mineArray)
    }
}
