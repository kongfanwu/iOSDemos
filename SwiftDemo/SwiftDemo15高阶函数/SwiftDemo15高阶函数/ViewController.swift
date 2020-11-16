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

//https://blog.csdn.net/mo_xiao_mo/article/details/78424714
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
//        var string = "123456789"
//        let text = string.stringByReplacingCharactersInRange(index: 9, length: 1, replacText: "q")
//        print(text)
        
//        let arr = [1, 2, 3, 4]
//        let arr2 = arr.map({
//            $0 + 1
//        })
//        print(arr2)
        
        class Person: NSObject {}
        
       var namesOfIntegers = ["1", "2", "3", "4", "5", "6", "7"]
        
//        var dataArray = [[String]]()
//        var cellArray: [String]!
//        for (index, obj) in namesOfIntegers.enumerated() {
//            if index % 3 == 0 {
//                if index != 0 {
//                    dataArray.append(cellArray)
//                }
//                cellArray = [String]()
//                cellArray.append(obj)
//            } else {
//                cellArray.append(obj)
//            }
//        }
//        dataArray.append(cellArray)
//        print(dataArray)
        
        var dataArray = [[String]]()
        for (index, obj) in namesOfIntegers.enumerated() {
            let rowIndex = Int(floorf(Float(index) / 3.0))
            if index % 3 == 0 {
                dataArray.append([String]())
                dataArray[rowIndex].append(obj)
            } else {
                dataArray[rowIndex].append(obj)
            }
        }
        print(dataArray)
    }


}

