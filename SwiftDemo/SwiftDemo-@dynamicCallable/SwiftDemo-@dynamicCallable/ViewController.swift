//
//  ViewController.swift
//  SwiftDemo-@dynamicCallable
//
//  Created by kfw on 2019/11/23.
//  Copyright © 2019 神灯智能. All rights reserved.
//

import UIKit
/*
 @dynamicCallable时需要注意一些重要的规则:

 您可以将其应用于结构、枚举、类和协议。
 如果使用withKeywordArguments:并且不使用withArguments:您的类型仍然可以在没有参数标签的情况下调用 - 您只会获得键的空字符串。
 如果withKeywordArguments:或与withArguments:被标记为throwing,调用类型也将throwing。
 不能@dynamicCallable添加到扩展,只能添加类型的主要定义。
 您仍然可以向类型添加其他方法和属性,并正常使用它们。
 */
@dynamicCallable
struct RandomNumberGenerator {
    // 第一种是在调用没有参数标签的类型时使用的
    func dynamicallyCall(withArguments args: [Int]) -> Double {
        let numberOfZeroes = Double(args.first ?? 0)
        let maximum = pow(10, numberOfZeroes)
        return Double.random(in: 0...maximum)
    }
    // 二种是在提供标签时a(b, c)使用的(例如a(b: cat, c: dog) ).
    func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, Int>) -> Double {
        let numberOfZeroes = Double(args.first?.value ?? 0)
        let maximum = pow(10, numberOfZeroes)
        return Double.random(in: 0...maximum)
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let random = RandomNumberGenerator()
        /// numberOfZeroes 可以自定义
        /// let result = random.dynamicallyCall(withKeywordArguments: ["numberOfZeroes": 3])
        /// let result = random(numberOfZeroes: 3)

        let result = random(numberOfZeroes: 1)
        _ = random(2)
        
    }


}

