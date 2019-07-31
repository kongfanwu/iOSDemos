//
//  ViewController.swift
//  SwiftDemo6-属性
//
//  Created by kfw on 2019/7/10.
//  Copyright © 2019 kfw. All rights reserved.
//

import UIKit
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    // 计算属性
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

// 只读计算属性 只有 getter 没有 setter 的计算属性叫只读计算属性.必须使用 var 关键字定义计算属性
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}

// 属性观察器
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newValue) {
            print("将 totalSteps 的值设置为 \(newValue)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("增加了 \(totalSteps - oldValue) 步")
            }
        }
    }
}

// 类型属性语法 static
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                // 在第一个检查过程中，didSet 属性观察器将 currentLevel 设置成了不同的值，但这不会造成属性观察器被再次调用。
                // 将当前音量限制在阈值之内
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // 存储当前音量作为新的最大输入音量
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
        // 该区间表示整数 0，1，2
        rangeOfThreeItems.firstValue = 6
        // 该区间现在表示整数 6，7，8
        
        
        // 如果创建了一个结构体实例并将其赋值给一个常量，则无法修改该实例的任何属性，即使被声明为可变属性也不行:
//        let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//        // 该区间表示整数 0，1，2，3
//        rangeOfFourItems.firstValue = 6
//        // 尽管 firstValue 是个可变属性，但这里还是会报错
        
        var square = Rect(origin: Point(x: 0.0, y: 0.0),
                          size: Size(width: 10.0, height: 10.0))
        let initialSquareCenter = square.center
        square.center = Point(x: 15.0, y: 15.0)
        print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
        // 打印“square.origin is now at (10.0, 10.0)”
        
        let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
        print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
        // 打印“the volume of fourByFiveByTwo is 40.0”
        
        //获取和设置类型属性的值
        print(SomeClass.storedTypeProperty)
        // 打印“Some value.”
        SomeClass.storedTypeProperty = "Another value."
    }


}

