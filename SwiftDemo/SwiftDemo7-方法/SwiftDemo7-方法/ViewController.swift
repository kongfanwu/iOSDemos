//
//  ViewController.swift
//  SwiftDemo7-方法
//
//  Created by kfw on 2019/7/11.
//  Copyright © 2019 kfw. All rights reserved.
//

import UIKit

// 实例方法（Instance Methods）
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}

struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        
        // 使用这条规则的主要场景是实例方法的某个参数名称与实例的某个属性名称相同的时候。在这种情况下，参数名称享有优先权，并且在引用属性时必须使用一种更严格的方式。这时你可以使用 self 属性来区分参数名称和属性名称。
        return self.x > x
    }
}
/*
 在实例方法中修改值类型
 结构体和枚举是值类型。默认情况下，值类型的属性不能在它的实例方法中被修改。
 但是，如果你确实需要在某个特定的方法中修改结构体或者枚举的属性，你可以为这个方法选择 可变（mutating）行为，然后就可以从其方法内部改变它的属性；并且这个方法做的任何改变都会在方法执行结束时写回到原始结构中。方法还可以给它隐含的 self 属性赋予一个全新的实例，这个新实例在方法结束时会替换现存实例
 */
struct Point2 {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
struct Point3 {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        // 可变方法能够赋给隐含属性 self 一个全新的实例
        self = Point3(x: x + deltaX, y: y + deltaY)
    }
}

class LevelTracker: NSObject {
    static var highestUnlockedLevel = 1
    //  类方法
    static func unlock(_ level: Int) {
        
    }
    //  类方法 子类可重写
    class func unlock2(_ level: Int) {
        
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var somePoint = Point2(x: 1.0, y: 1.0)
        somePoint.moveBy(x: 2.0, y: 3.0)
        print("The point is now at (\(somePoint.x), \(somePoint.y))")
        // 打印“The point is now at (3.0, 4.0)”
    }


}

