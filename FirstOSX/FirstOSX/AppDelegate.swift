//
//  AppDelegate.swift
//  FirstOSX
//
//  Created by gaoxiang on 2019/11/1.
//  Copyright © 2019 w11757. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

////
////  ViewController.swift
////  FirstOSX
////
////  Created by gaoxiang on 2019/11/1.
////  Copyright © 2019 w11757. All rights reserved.
////
//
//import Cocoa
//import SpriteKit
//import SnapKit
//
//class ViewController: NSViewController {
//    //创建展示游戏内容的情景
//    var gameScene: RunnerScene = RunnerScene()
//    //国王与奴隶游戏场景
//    var kingAndSalve: KingAndSlave = KingAndSlave()
//    var spritView: SKView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        //我觉得将spriteVIew加到View 上是一个不错e的解决方案
//        spritView = self.view as? SKView
//        if spritView == nil {
//           print("忘记在故事版上修改view的实现了")
//        }
//        gameScene.size = spritView.bounds.size
//        kingAndSalve.size = spritView.bounds.size
//        spritView.presentScene(kingAndSalve)
//        //不知道可不可以使用SnapKit为情景设置约束
//
//    }
//
//    override var representedObject: Any? {
//        didSet {
//        // Update the view, if already loaded.
//        }
//    }
//
//
//}
//
