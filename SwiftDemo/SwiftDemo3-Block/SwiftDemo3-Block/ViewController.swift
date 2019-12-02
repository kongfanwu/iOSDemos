//
//  ViewController.swift
//  SwiftDemo3-Block
//
//  Created by kfw on 2019/7/9.
//  Copyright © 2019 kfw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var incrementByTen: (() -> Int)?
    var incrementBySeven: (() -> Int)?
    var incrementBySeven2: (() -> Int)?
    var completionHandlers: [() -> Void] = []
    
    func someFunctionThatTakesAClosure(closure: () -> Void) {
        // 函数主体部分
    }
    
    func makeIncrementer(forIncrement amount: Int) -> () -> Int {
        var runningTotal = 0
        func incrementer() -> Int {
            runningTotal += amount
            return runningTotal
        }
        return incrementer
    }
    
    func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
        completionHandlers.append(completionHandler)
    }
    
    /*
     弱引用和无主引用
     在闭包和捕获的实例总是互相引用并且总是同时销毁时，将闭包内的捕获定义为 无主引用。
     
     相反的，在被捕获的引用可能会变为 nil 时，将闭包内的捕获定义为 弱引用。弱引用总是可选类型，并且当引用的实例被销毁后，弱引用的值会自动置为 nil。这使我们可以在闭包体内检查它们是否存在。
     
     如果被捕获的引用绝对不会变为 nil，应该用无主引用，而不是弱引用。
     */
    
    lazy var someClosure: (Int, String) -> String = {
        [unowned self] (index: Int, stringToProcess: String) -> String in
        // 这里是闭包的函数体
        print(index, stringToProcess)
        return "res"
    }
    
//    lazy var someClosure2: () -> String = {
//        [unowned self, weak delegate = self.delegate!] in
//        // 这里是闭包的函数体
//    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
         print("124(\("456"))")
        
//        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
//        var reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
//            return s1 > s2
//        })
//        print(reversedNames)
        
        // 通过上下文推测类型 可以省去 (s1: String, s2: String) -> Bool
//        reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
        
        // 单一闭包表达式隐式返回 单一闭包表达式可以省略声明return
//        reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
        
        /*
         缩写参数名
         $0, $1, $2 等来代替闭包的参数。 缩写参数的值和类型也会通过函数预期类型推断出来。
         in 关键字也可以被省略，因为这个闭包表达式已经通过主体完全构建出来了
         */
//        reversedNames = names.sorted(by: { $0 > $1 } )
        //// 尾随闭包
//        reversedNames = names.sorted(){ $0 > $1 }
//        reversedNames = names.sorted { $0 > $1 }
        
        /*
         运算符方法
         实际上还有一种 更简短 的方式来编写上面例子中的闭包表达式。Swift 的 String 类型将其大于运算符（>）的字符串特定实现为具有两个 String 类型参数的方法，并返回一个 Bool 类型的值。而这正好与 sorted(by: ) 方法的参数需要的函数类型相符合。因此，你可以简单地传递一个大于运算符，Swift 可以自动推断出你想使用其特定于字符串的实现
         */
//        reversedNames = names.sorted(by: >)
        
        
//        // 尾随闭包
//        // 这里被调用函数没用后置闭包的写法:
//        someFunctionThatTakesAClosure(closure: {
//            // 闭包主体部分
//        })
//
//        // 这里被调用函数使用后置闭包的写法:
//        someFunctionThatTakesAClosure() {
//            // 尾随闭包主体部分
//        }
//        print("*", terminator: "")
//        print("*", terminator: "")
        
    
//        let n = 10
//        let maxItem = n * 2 - 1
//        var middleItem = (maxItem / 2) +  (maxItem % 2)
//        var lineItemCount = 0
//        for index in 1 ... n {
//            if index == 1 {
//                lineItemCount = 1
//            } else {
//                lineItemCount += 2;
//            }
//
//            for itemIdnex in 1 ... maxItem {
//                if (itemIdnex >= middleItem) && (itemIdnex < (middleItem + lineItemCount)) {
//                    print("*", terminator: "")
//
//                } else {
//                    print("-", terminator: "")
//                }
//            }
//            middleItem -= 1
//            print(" \n")
//        }
        
//        self.incrementByTen = makeIncrementer(forIncrement: 10)
//        self.incrementBySeven = makeIncrementer(forIncrement: 1)
//        self.incrementBySeven2 = self.incrementBySeven;
        
        /*
         逃逸闭包
       当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。当你定义接受闭包作为参数的函数时，你可以在参数名之前标注 @escaping，用来指明这个闭包是允许“逃逸”出这个函数的。
         
           将一个闭包标记为 @escaping 意味着你必须在闭包中显式地引用 self
           非逃逸闭包，这意味着它可以隐式引用 self
         */
//        var x = 10
//        someFunctionWithEscapingClosure { self.x = 100 }
//        someFunctionWithNonescapingClosure { x = 200 }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        print(self.incrementByTen!())
//        print(self.incrementBySeven!())
//        print(self.incrementBySeven2!())
    }
    
   
    
    
}

