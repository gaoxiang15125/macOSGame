//
//  MapManage.swift
//  FirstOSX
//
//  Created by gaoxiang on 2019/11/25.
//  Copyright © 2019 w11757. All rights reserved.
//

import Foundation
import Cocoa

class MapManage {
    //使用精灵的话所有方格都应为精灵，精灵持有展示方式
    //将cellInfo修改为SKSpriteNode
    var mapInfos: [[CellInfo]]
    //地雷的引用列表，用于判断结束状态
    var mineArray: [CellInfo]

    //记录按钮是否为点击状态的数组（可以使用按钮的属性代替）
    //还是使用属性代替好一些
//不需要存储宽高与地雷数目，交给调用者管理，存储也没啥，减少运算量
    var width: Int
    var height: Int
    var mineNum: Int
    var surplusMineNum: Int
    init(width: Int, height: Int, mineNum: Int) {
        self.width = width
        self.height = height
        self.mineNum = mineNum
        self.surplusMineNum = mineNum
        let mapInfoBuffer = MapCreater.creatMap(width: width, hight: height, mineCount: mineNum)
        mapInfos = mapInfoBuffer.mapInfo
        mineArray = mapInfoBuffer.mineArray
    }
    //true 表示周围没有地雷，false 表示周围存在地雷，用于递归操作
    //用于遍历周边方格的数组
    let rangeArray: [(numOne: Int,numTwo: Int)] = [(-1,-1),(-1,0),(-1,1),(0,-1),(0,1),(1,-1),(1,0),(1,1)]
    public func isMineAround(xPos: Int, yPos: Int) -> Bool {
        var rangeMine: Int = 0
        if xPos < 0 || xPos >= width {
            return true
        }
        if yPos < 0 || yPos >= height {
            return true
        }
        var mineBuffer = mapInfos[xPos][yPos]
        if mineBuffer.printType != .Empty {
            return true
        }
        for index in rangeArray {
            let xBuffer = xPos + index.numOne
            if xBuffer < 0 || xBuffer >= width {
                continue
            }
            let yBuffer = yPos + index.numTwo
            if yBuffer < 0 || yBuffer >= height {
                continue
            }
            mineBuffer = mapInfos[xBuffer][yBuffer]
            if mineBuffer.realType == CellInfo.CellStyle.Mine {
                rangeMine += 1
            }
        }
        mineBuffer = mapInfos[xPos][yPos]
        mineBuffer.repaintCellMineNum(mineNumber: rangeMine)
        mineBuffer.repaintCellType(nowType: .Middle)
        if rangeMine == 0 {
            return false
        }
        return true
    }

    //点击某按钮后，重置周围所有可点击按钮，知道所有边界均包含数字
    //通过递归实现该算法
    func autoClickRangeButton(xPos: Int, yPos: Int) {
        //如果当前格子周围地雷不为0，直接结束，否则遍历周围为被点击的方格，对为0方格进行相同的操作
        if isMineAround(xPos: xPos, yPos: yPos) {
            //有地雷不遍历，直接退出
        } else {
            //无地雷遍历周围可达到方格
            for index in rangeArray {
                let xBuffer = xPos + index.numOne
                let yBuffer = yPos + index.numTwo
                autoClickRangeButton(xPos: xBuffer, yPos: yBuffer)
            }
        }
    }

    //MARK: - WINNER -
    //最好的方式为记录所有地雷的位置，判断是否找出了所有地雷
    func isWin() {
        if surplusMineNum > 0 {
            return
        }
        //此处编写获胜的逻辑
        print("你赢了，目前只能重启开始下一把游戏")
        isWinnerAppear()
        //目前需要找出所有地雷才会提示完成，希望修改为可以定为所有地雷就提示完成
    }

    //此处进行胜利判断，如果获胜尝试弹窗提醒并重新绘制地图
    func isWinnerAppear() {
        print("开始进行胜利判断")
        for singleMine in mineArray {
            if singleMine.printType != .Tag {
                return
            }
        }
        //此处进行胜利提示
        print("您获得了胜利")
        //创建提示框，让用户选择进一步的操作
        let alertController = NSAlert()
        alertController.messageText = "恭喜你获得了胜利"
        alertController.informativeText = "干嘛的？啥用处啊？"
        alertController.icon = NSImage(named: "littlePig")
        //构造并配置好按钮信息，加入到提示框中
        //不设置大小是否会配饰字体数量作为按钮大小
        //按钮的顺序是什么样的？
        alertController.addButton(withTitle: "继续")
        alertController.addButton(withTitle: "结束吧")
        
        alertController.alertStyle = .informational
        let modalResult: NSApplication.ModalResponse = alertController.runModal()
        reStartGame(clickResult: modalResult)
    }
    //理论上此处应该作为接口，让 ViewController 实现其效果
    @objc func reStartGame(clickResult: NSApplication.ModalResponse) {
        print("继承也好，此处实现也罢，请重新开始一局游戏")
        print(clickResult)
        print("点击的按钮编号为 \(clickResult.rawValue)")
        //点击什么都不做应该不会消失吧
    }
}
