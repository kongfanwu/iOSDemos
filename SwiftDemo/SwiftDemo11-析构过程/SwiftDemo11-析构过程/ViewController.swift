//
//  ViewController.swift
//  SwiftDemo11-析构过程
//
//  Created by kfw on 2019/7/12.
//  Copyright © 2019 kfw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
// 析构器是在实例释放发生前被自动调用的。你不能主动调用析构器。子类继承了父类的析构器，并且在子类析构器实现的最后，父类的析构器会被自动调用。即使子类没有提供自己的析构器，父类的析构器也同样会被调用。
    deinit {
        // 执行析构过程
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

