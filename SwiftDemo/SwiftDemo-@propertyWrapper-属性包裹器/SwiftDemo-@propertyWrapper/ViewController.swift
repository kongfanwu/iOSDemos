//
//  ViewController.swift
//  SwiftDemo-@propertyWrapper
//
//  Created by kfw on 2019/11/22.
//  Copyright © 2019 神灯智能. All rights reserved.
//
// https://www.jianshu.com/p/ff4c048f0cf4
// https://github.com/DougGregor/swift-evolution/blob/property-wrappers/proposals/0258-property-wrappers.md
import UIKit

@propertyWrapper /// 先告诉编译器 下面这个UserDefault是一个属性包裹器
struct UserDefault<T> {
    ///这里的属性key 和 defaultValue 还有init方法都是实际业务中的业务代码
    ///我们不需要过多关注
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
///  wrappedValue是@propertyWrapper必须要实现的属性
/// 当操作我们要包裹的属性时  其具体set get方法实际上走的都是wrappedValue 的set get 方法。
    var wrappedValue: T {
        get {
            printGet()
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
    func printGet() {
        print("printGet")
    }
}

///封装一个UserDefault配置文件
struct UserDefaultsConfig {
    ///告诉编译器 我要包裹的是hadShownGuideView这个值。
    ///实际写法就是在UserDefault包裹器的初始化方法前加了个@
    /// hadShownGuideView 属性的一些key和默认值已经在 UserDefault包裹器的构造方法中实现
    @UserDefault("had_shown_guide_view", defaultValue: false)
    static var hadShownGuideView: Bool
    
    ///保存用户名称
    @UserDefault("username", defaultValue: "unknown")
    static var username: String
}

//--------------
@propertyWrapper
struct DelayedImmutable<Value> {
    private var _value: Value? = nil
    
    var wrappedValue: Value {
        get {
            guard let value = _value else {
                fatalError("property accessed before being initialized")
            }
            return value
        }
        
        // Perform an initialization, trapping if the
        // value is already initialized.
        set {
            if _value != nil {
                fatalError("property initialized twice")
            }
            _value = newValue
        }
    }
}

class Foo {
    @DelayedImmutable var x: Int
    
    init() {
        // We don't know "x" yet, and we don't have to set it
    }
    
    func initializeX(x: Int) {
        self.x = x // Will crash if 'self.x' is already initialized
    }
    
    func getX() -> Int {
        return x // Will crash if 'self.x' wasn't initialized
    }
}
//-----------
// NSCopying
@propertyWrapper
struct Copying<Value: NSCopying> {
    private var _value: Value
    
    init(wrappedValue value: Value) {
        // Copy the value on initialization.
        self._value = value.copy() as! Value
    }
    
    var wrappedValue: Value {
        get { return _value }
        set {
            // Copy the value on reassignment.
            _value = newValue.copy() as! Value
        }
    }
}

//----------- 实际使用例子

class ViewController: UIViewController {

    func a(content: String) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        demo1()
    }

    func demo1() {
        ///具体的业务代码。
        UserDefaultsConfig.hadShownGuideView = false
        print(UserDefaultsConfig.hadShownGuideView) // false
        UserDefaultsConfig.hadShownGuideView = true
        print(UserDefaultsConfig.hadShownGuideView) // true
        
//        UserDefaultsConfig.username = "kong"
//        print(UserDefaultsConfig.username)
//        UserDefaultsConfig.username = "fan"
//        print(UserDefaultsConfig.username)
    }

    func demo2() {
        let a = Foo()
        a.initializeX(x: 1)
        a.getX()
    }
}

