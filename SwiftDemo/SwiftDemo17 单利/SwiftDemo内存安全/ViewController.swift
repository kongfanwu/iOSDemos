//
//  ViewController.swift
//  SwiftDemo内存安全
//
//  Created by kfw on 2019/11/22.
//  Copyright © 2019 神灯智能. All rights reserved.
//

import UIKit

class User {
    // 在使用default的时候加了``` 符号，这是由于default是保留关键字，如果使用其他名字，如shared`，则直接使用变量名即可。
    static let `default` = User()
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }


}

