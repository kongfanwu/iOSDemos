//
//  ViewController.swift
//  SwiftDemo1
//
//  Created by kfw on 2019/7/9.
//  Copyright © 2019 kfw. All rights reserved.
//

import UIKit

class Person {
    init() {
        
    }
}

class Dod: Person {
    override init() {
        
    }
}

func NSClassFromString_Swift(_ className: String) -> AnyObject? {
    let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String//这是获取项目的名称，
    let className=clsName! + "." + className
//    let viewC = NSClassFromString(className)! as! Person.Type
    return NSClassFromString(className)!
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        _ = arithmeticMean(1, 2, 3, 4, 5)
//
//        var someInt = 3
//        var anotherInt = 107
//        swapTwoInts(&someInt, &anotherInt)
//        print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
//
//        // 使用函数类型
//        var mathFunction: (Int, Int) -> Int = addTwoInts
//        print("Result: \(mathFunction(2, 3))")
//
//        let moveNearerToZero = chooseStepFunction(backward: true)
//        moveNearerToZero(1)
        
//       let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String//这是获取项目的名称，
//
//        let className=clsName! + "." + "Person"
//
//                let viewC = NSClassFromString_Swift("Person")! as! Person.Type //这里需要指定类的类型XX.Type
//        print(viewC)
//        let vc=viewC.init()
        
//
        
//        let text = "123456789"
//
//        let range = text.range(of: "4567")
//
//        print(range!.lowerBound.utf16Offset(in: text))
//        print(range!.upperBound.utf16Offset(in: text))
//
//        print(text.distance(from: text.startIndex, to: range!.lowerBound))
//        print(text.distance(from: range!.lowerBound, to: range!.upperBound))
        
        // goto 语句
//        findAnswer: for m in 1...300{
//            for n in 1...30{
//                if m == 5{
//                    print(m , n)
//                    break findAnswer //跳出整个循环,想当与C语言中的goto语句不建议使用
//                }
//            }
//            print(m)
//        }
        
        findAnswer: for m in 1...300{
            switch m {
            case 5:
                break findAnswer
            default:
                break
            }
            print(m)
        }
        
    }

    func minMax(arra:[Int]) -> (min: Int, max: Int)? {
        return nil;
    }

    func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
        // 调用时如果你没有给第二个参数传值，那么变量  parameterWithDefault 的值默认就是 12 。
    }
    
    // 可变参数
    func arithmeticMean(_ numbers: Double...) -> Double {
        var total: Double = 0
        for number in numbers {
            total += number
        }
        return total / Double(numbers.count)
    }
    
    // 传入传出参数 传入传出参数不能有默认值，并且可变参数也不能被标记 inout 。
    func swapTwoInts(_ a: inout Int, _ b: inout Int) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    // 函数类型.每个函数的具体 函数类型 由它的参数类型和返回类型共同决定。(Int, Int) -> Int
    func addTwoInts(_ a: Int, _ b: Int) -> Int {
        return a + b
    }

    // 返回值是函数类型
    func chooseStepFunction(backward: Bool) -> (Int) -> Int {
        // 嵌套函数
        func stepForward(_ input: Int) -> Int {
            return input + 1
        }
        func stepBackward(_ input: Int) -> Int {
            return input - 1
        }
        return backward ? stepBackward : stepForward
    }
}

