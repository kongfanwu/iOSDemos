//
//  ViewController.swift
//  SwiftDemo内存安全
//
//  Created by kfw on 2019/11/22.
//  Copyright © 2019 神灯智能. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // number 和 stepSize 都指向了同一个存储地址。同一块内存的读和写访问重叠了，就此产生了冲突。
//        var stepSize = 1
//        func increment(_ number: inout Int) {
//            number += stepSize
//        }
//        increment(&stepSize)
        
    }


}

