//
//  CellInfo.swift
//  FirstOSX
//
//  Created by gaoxiang on 2019/11/25.
//  Copyright © 2019 w11757. All rights reserved.
//

import Foundation
import Cocoa
//格子本身为两种状态，地雷、空
//格子可以表现为三种状态 地雷、空、标记
//如果可以修改背景颜色，希望可以将此处修改为NSButton
class CellInfo: NSButtonCell {
    //public var//修改后 printType 属性被NSButton自带的颜色完全取代
    public var printType: CellStyle = .Empty
    var realType: CellStyle = .Empty
    //该方格周围方格地雷数目，当为0时不绘制
    var mineNum: Int = 0
    //格子承载的数据信息只有这两样
    //使用精灵没有图片资源，不晓得如何精灵加文字，直接使用button，简单方便
    override init(textCell string: String) {
        super.init(textCell: string)
        //三个关键属性，颜色、文本、位置。
        repaintCellType(nowType: printType)
        repaintCellMineNum(mineNumber: mineNum)
        //位置在外部确定
    }

    //修改表现样式，并重新绘制方格信息
    func repaintCellType(nowType: CellStyle) {
        self.printType = nowType
        self.backgroundColor = getCellColorFromStyle()
    }
    //修改展示的方格周围地雷数目
    func repaintCellMineNum(mineNumber: Int) {
        self.mineNum = mineNumber
        //先设置为0 观察是否绘制到屏幕中
        if mineNumber == 0 {
            self.title = ""
            return
        }
        self.title = String(mineNum)
        //self.font = NSFont(name: <#T##String#>, size: <#T##CGFloat#>)
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension CellInfo {
    enum CellStyle {
        case Empty
        case Mine
        case Tag
        case Middle
        //显示周围地雷个数的方格必定是Middle状态
    }
    
    func getCellColorFromStyle() -> NSColor{
        var cellColor: NSColor!
        switch printType {
        case .Mine:
            cellColor = NSColor.black
        case .Tag:
            cellColor = NSColor.red
        case .Middle:
            cellColor = NSColor.purple
        default:
            cellColor = NSColor.gray
        }
        return cellColor
    }
}
