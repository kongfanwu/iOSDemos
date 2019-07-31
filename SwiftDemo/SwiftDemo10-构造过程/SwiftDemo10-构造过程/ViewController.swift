//
//  ViewController.swift
//  SwiftDemo10-构造过程
//
//  Created by kfw on 2019/7/11.
//  Copyright © 2019 kfw. All rights reserved.
//
/*
 规则 1
 指定构造器必须调用其直接父类的的指定构造器。
 
 规则 2
 便利构造器必须调用同类中定义的其它构造器。
 
 规则 3
 便利构造器最后必须调用指定构造器。
 
 一个更方便记忆的方法是：
 
 指定构造器必须总是向上代理
 便利构造器必须总是横向代理
 
 两段式构造过程
 Swift 中类的构造过程包含两个阶段。第一个阶段，类中的每个存储型属性赋一个初始值。当每个存储型属性的初始值被赋值后，第二阶段开始，它给每个类一次机会，在新实例准备使用之前进一步自定义它们的存储型属性。
 
 两段式构造过程的使用让构造过程更安全，同时在整个类层级结构中给予了每个类完全的灵活性。两段式构造过程可以防止属性值在初始化之前被访问，也可以防止属性被另外一个构造器意外地赋予不同的值。
 */
import UIKit
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}

struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}
struct Celsius {
    var temperatureInCelsius: Double
    // 形参的构造过程
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    // 不带实参标签的构造器形参
    init(_ celsius: Double){
        temperatureInCelsius = celsius
    }
}

class SurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        // 构造过程中常量属性的赋值
        self.text = text
    }
    func ask() {
        print(text)
    }
}

struct Size {
    var width = 0.0, height = 0.0
}

class Person {
    // 类的指定构造器的写法跟值类型简单构造器一样：
    init() {
        
    }
    // 便利构造器也采用相同样式的写法，但需要在 init 关键字之前放置 convenience 关键字，并使用空格将它们俩分开：
    convenience init(a: Int) {
        self.init()
    }
}

class Person2: Person {
    // 类的指定构造器的写法跟值类型简单构造器一样：
    override init() {
        super.init()
    }
    // 便利构造器也采用相同样式的写法，但需要在 init 关键字之前放置 convenience 关键字，并使用空格将它们俩分开：
    convenience init(a: Int) {
        self.init()
    }
}

class Animal {
    var name = "animal"
    init() {
//        self.name = "animal1"
    }
    init(_ name: String) {
        self.name = name;
    }
}

class Dog: Animal {
    var age: Int
    
    // 指定构造器
    override init() {
        // 安全检查 1 指定构造器必须保证它所在类的所有属性都必须先初始化完成，之后才能将其它构造任务向上代理给父类中的构造器。
        self.age = 0;
        //  super.init() 类的第1阶段已完成
        super.init()
        // 安全检查 2 指定构造器必须在为继承的属性设置新值之前向上代理调用父类构造器。如果没这么做，指定构造器赋予的新值将被父类中的构造器所覆盖。
        self.name = "dog init"
    }
    
    // 便利构造器
    convenience init(age: Int, name: String) {
        // 安全检查 3 便利构造器必须为任意属性（包括所有同类中定义的）赋新值之前代理调用其它构造器。如果没这么做，便利构造器赋予的新值将被该类的指定构造器所覆盖。
        self.init()
        
        //  类的第2阶段开始，可以使用self.自定义属性操作
        self.age = age
        self.name = name
    }
}

class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

class Hoverboard: Vehicle {
    var color: String
    init(color: String) {
        self.color = color
        // 如果子类的构造器没有在阶段 2 过程中做自定义操作，并且父类有一个无参数的自定义构造器。你可以在所有父类的存储属性赋值之后省略 super.init() 的调用。
        // super.init() 在这里被隐式调用
    }
    override var description: String {
        return "\(super.description) in a beautiful \(color)"
    }
}

/* 指定构造器和便利构造器实践 */

class Food {
    var name: String
    // 指定构造器
    init(name: String) {
        self.name = name
    }
    // 便利构造器
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
     // 指定构造器
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    // 便利构造器 将父类的指定构造器重写为了便利构造器，
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

// 必要构造器 在类的构造器前添加 required 修饰符表明所有该类的子类都必须实现该构造器：
class SomeClass {
    required init() {
        // 构造器的实现代码
    }
}

class SomeSubclass: SomeClass {
    required init() {
        // 构造器的实现代码
    }
}

/* 通过闭包或函数设置属性的默认值 */

class PropertyBlockClass {
    let name: String = {
        //如果你使用闭包来初始化属性，请记住在闭包执行时，实例的其它部分都还没有初始化。这意味着你不能在闭包里访问其它属性，即使这些属性有默认值。同样，你也不能使用隐式的 self 属性，或者调用任何实例方法。
        return "kongfanwu\(123)"
    }()
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        var f = Fahrenheit()
//        print("The default temperature is \(f.temperature)° Fahrenheit")
//        // 打印“The default temperature is 32.0° Fahrenheit”
//
//        let twoByTwo = Size(width: 2.0, height: 2.0)
//        let zeroByZero = Size()
        
//        method()
        
        print(PropertyBlockClass().name)
    }

    func method() {
//        let anim = Animal("dog")
//        print(anim.name!)
        
//        let dog = Dog(age: 20, name: "狗")
//        print(dog.age, dog.name!)
   
//        let hoverboard = Hoverboard(color: "silver")
//        print("Hoverboard: \(hoverboard.description)")
        let oneMysteryItem = RecipeIngredient()
        
        ShoppingListItem()
        ShoppingListItem(name: "Bacon")
        ShoppingListItem(name: "Eggs", quantity: 6)
    }

}

