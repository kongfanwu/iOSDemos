//
//  ViewController.swift
//  SwiftDemo15高阶函数
//
//  Created by kfw on 2019/11/13.
//  Copyright © 2019 神灯智能. All rights reserved.
//

import UIKit

class Personn {
    var name: String = ""
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let p =  Personn()
//        p.name = "1"
//
//        let p2 =  Personn()
//        p2.name = "2"
//
//        let prices = [p, p2]
//        let strs = prices.map({
////            "$\($0)"
////            print($0)
//            $0.name
//        })
//        print(strs)
        
//        var timeDic = [Int : Any]()
//        timeDic["key"] = "value"
//        timeDic["key2"] = "value2"
        
//        timeDic[1] = "value2"
//
//        let jsonStr = timeDic.jsonString()
//        print(jsonStr)
        var string = "123456789"
        let text = string.stringByReplacingCharactersInRange(index: 9, length: 1, replacText: "q")
        print(text)
    }


}

