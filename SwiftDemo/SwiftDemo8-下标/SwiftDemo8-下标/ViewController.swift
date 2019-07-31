//
//  ViewController.swift
//  SwiftDemo8-下标
//
//  Created by kfw on 2019/7/11.
//  Copyright © 2019 kfw. All rights reserved.
//

import UIKit
struct TimesTable {
    let multiplier: Int
    var array: [Int] = []
    
    subscript(index: Int) -> Int {
        get {
            return multiplier * index
            // 返回一个适当的 Int 类型的值
        }
        set(newValue) {
            // 执行适当的赋值操作
            array.append(newValue)
        }
    }
}
// 类型下标
//enum Planet: Int {
//    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
//    static subscript(n: Int) -> Planet {
//        return Planet(rawValue: n)!
//    }
//}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var threeTimesTable = TimesTable(multiplier: 3, array: [])
        threeTimesTable[0] = 3;
        threeTimesTable[0] = 4;
        print(threeTimesTable.array)
        print("six times three is \(threeTimesTable[6])")
        // 打印“six times three is 18”
    }


}

