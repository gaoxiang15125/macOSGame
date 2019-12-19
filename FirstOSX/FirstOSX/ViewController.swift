//
//  ViewController.swift
//  FirstOSX
//
//  Created by gaoxiang on 2019/11/1.
//  Copyright © 2019 w11757. All rights reserved.
//

import Cocoa
import SpriteKit
import SnapKit

class ViewController: NSViewController {
    var gameWidth: Int = 20
    var gameHeight: Int = 20
    var mineNum: Int = 5
    var mapManage: MapManage!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //不调整view 类型，尝试直接使用
        mapManage = MapManage(width: gameWidth, height: gameHeight, mineNum: mineNum)
        //NSApplication
        //对button 不添加引用，对buttonCell添加引用
        var xOffset = 0, yOffset = 0
        for mapInfo in mapManage.mapInfos {
            for mapSingle in mapInfo {
                let newButton: NSButton = NSButton()
                newButton.cell = mapSingle
                let idInfo: String = String(yOffset) + " " + String(xOffset)
                newButton.identifier = NSUserInterfaceItemIdentifier(rawValue: idInfo)
                self.view.addSubview(newButton)
                newButton.frame = CGRect(x: 25*xOffset, y: 25*yOffset, width: 25, height: 25)
                xOffset += 1
//                newButton.action = #selector(mineClickResponse)
                let longTap = NSPressGestureRecognizer(target: self, action: #selector(tagCellAsMine(button:)))
                let clickTap = NSClickGestureRecognizer(target: self, action: #selector(mineClickResponse(id:)))
                clickTap.numberOfClicksRequired = 1
                let onceTap = NSClickGestureRecognizer(target: self, action: #selector(changeCellToEmpty(cell:)))
                onceTap.numberOfClicksRequired = 2
                newButton.gestureRecognizers = [longTap,clickTap,onceTap]
                //寻找修改按钮上字符颜色的方法
            }
            yOffset += 1
            xOffset = 0
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    //按钮点击事件
    @objc func mineClickResponse(id: NSClickGestureRecognizer) {
        //获取点击的方格周围的地雷数目
        let button = id.view as! NSButton
        let locationStr = button.identifier!.rawValue
        let locStrs = locationStr.split(separator: " ")
        let width: Int = Int.init(String(locStrs[0]))!
        let height: Int = Int.init(String(locStrs[1]))!
        mapManage.autoClickRangeButton(xPos: width, yPos: height)
        mapManage.isWin()
    }
    //长按标记当前格子为地雷
    @objc func tagCellAsMine(button: NSPressGestureRecognizer) {
        let mineButton = button.view as! NSButton
        let mineCell = mineButton.cell as! CellInfo
        if mineCell.printType == .Tag {
            return
        }
        mineCell.repaintCellType(nowType: .Tag)
//        let mineButton = button.bucell as! CellInfo
//        mineButton.repaintCellType(nowType: .Tag)
        mapManage.surplusMineNum -= 1
        mapManage.isWin()
        // 此处不严格，可能存在多次调用，如何解决这一问题呢？？
    }
    @objc func changeCellToEmpty(cell: NSClickGestureRecognizer) {
        let mineButton = cell.view as! NSButton
        let mineCell = mineButton.cell as! CellInfo
        mineCell.repaintCellType(nowType: .Empty)
        
    }
}

