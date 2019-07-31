//
//  ViewController.swift
//  SwiftDemo13-扩展
//
//  Created by kfw on 2019/7/12.
//  Copyright © 2019 kfw. All rights reserved.
//

import UIKit
// 协议可以定义可选要求，遵循协议的类型可以选择是否实现这些要求。在协议中使用 optional 关键字作为前缀来定义可选要求。可选要求用在你需要和 Objective-C 打交道的代码中。协议和可选要求都必须带上 @objc 属性。标记 @objc 特性的协议只能被继承自 Objective-C 类的类或者 @objc 类遵循，其他类以及结构体和枚举均不能遵循这种协议。
//使用可选要求时（例如，可选的方法或者属性），它们的类型会自动变成可选的。比如，一个类型为 (Int) -> String 的方法会变成 ((Int) -> String)?。需要注意的是整个函数类型是可选的，而不是函数的返回值。
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

extension CounterDataSource {
    func randomBool() -> Bool {
        return true
    }
}

class Counter: CounterDataSource {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        print((dataSource?.randomBool())!)
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

//extension SomeType: SomeProtocol, AnotherProtocol {
//    // 协议所需要的实现写在这里
//}

extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}

extension Optional {
    /// 可选值为空的时候返回 true
    var isNone: Bool {
        switch self {
        case .none:
            return true
        case .some:
            return false
        }
    }
    
    /// 可选值非空返回 true
    var isSome: Bool {
        return !isNone
    }
}

class ViewController: UIViewController {
    let optional: Int? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
//        let a = Counter()
//        a.dataSource = a
//        a.increment()
        
    }
    

}

