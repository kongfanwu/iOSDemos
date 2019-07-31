//
//  ViewController.swift
//  SwiftDemo5-Class-Struct
//
//  Created by kfw on 2019/7/10.
//  Copyright © 2019 kfw. All rights reserved.
//

import UIKit
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        Resolution(width: 1, height: 2)
        let a = VideoMode()
        let b = VideoMode()
        // 恒等运算符  使用这两个运算符检测两个常量或者变量是否引用了同一个实例：
        if a === b {}
        if a !== b {}
    }


}

