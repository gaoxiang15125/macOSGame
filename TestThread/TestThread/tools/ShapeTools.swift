//
//  ShapeTools.swift
//  TestThread
//
//  Created by gaoxiang on 2019/10/12.
//  Copyright © 2019 w11757. All rights reserved.
//

import Foundation
import SpriteKit

class ShapeTools {
    
    static func creatCircleWithColorAndRadius(color: UIColor,radius: CGFloat) -> SKShapeNode {
        //之后修改position即可，此处Rect xy没啥影响
        let circleRect = CGRect(x: 0, y: 0, width:radius*2, height: radius*2)
        let circleNode = SKShapeNode()
        circleNode.path = UIBezierPath(ovalIn: circleRect).cgPath
        circleNode.strokeColor = color
        circleNode.fillColor = color
        return circleNode
    }
}
