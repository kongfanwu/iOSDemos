//
//  ViewController.swift
//  SwiftDemo4-Enum
//
//  Created by kfw on 2019/7/10.
//  Copyright © 2019 kfw. All rights reserved.
//

import UIKit

enum CompassPoint {
    case north
    case south
    case east
    case west
}

/*
 令枚举遵循 CaseIterable 协议。Swift 会生成一个 allCases 属性
 */
enum Beverage: CaseIterable {
    case coffee, tea, juice
}

/*
 关联值
 */
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

// 原始值
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

/*
 当使用字符串作为枚举类型的原始值时，每个枚举成员的隐式原始值为该枚举成员的名称。
 let sunsetDirection = CompassPoint.west.rawValue
 // sunsetDirection 值为 "west"
 */
enum CompassPoin2t: String {
    case north, south, east, west
}

// 当使用整数作为原始值时，隐式赋值的值依次递增 1。如果第一个枚举成员没有设置原始值，其原始值将为 0。
let earthsOrder = Planet.earth.rawValue
// earthsOrder 值为 3
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

// 递归枚举
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

class ViewController: UIViewController {
    
    func evaluate(_ expression: ArithmeticExpression) -> Int {
        switch expression {
        case let .number(value):
            return value
        case let .addition(left, right):
            return evaluate(left) + evaluate(right)
        case let .multiplication(left, right):
            return evaluate(left) * evaluate(right)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for beverage in Beverage.allCases {
            print(beverage)
        }
        
        var productBarcode = Barcode.upc(8, 85909, 51226, 3)
        productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
        
        switch productBarcode {
        case .upc(let numberSystem, let manufacturer, let product, let check):
            print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
        case .qrCode(let productCode):
            print("QR code: \(productCode).")
        }
        
        switch productBarcode {
        case let .upc(numberSystem, manufacturer, product, check):
            print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
        case let .qrCode(productCode):
            print("QR code: \(productCode).")
        }
        
        
//        使用原始值初始化枚举实例
        let possiblePlanet = Planet(rawValue: 7)
        // possiblePlanet 类型为 Planet? 值为 Planet.uranus
        
        
        // 递归枚举
        let five = ArithmeticExpression.number(5)
        let four = ArithmeticExpression.number(4)
        let sum = ArithmeticExpression.addition(five, four)
        let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
        
        print(evaluate(product))
        // 打印“18”
    }


}

