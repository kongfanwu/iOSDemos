//
//  ViewController.swift
//  SwiftDemo-Mirror反射
//
//  Created by kfw on 2020/8/24.
//  Copyright © 2020 神灯智能. All rights reserved.
//
// https://www.jianshu.com/p/3ccf70806774

import UIKit
class  Person{
    private var name :String? = "piaojin"
    let age :Int=20
    var height :Float=100
    var w :Float?
    var closure : (String) -> (String) = {
        (str:String)in
        return"piaojin"
    }
    var arr : [Any]? = [Any]()
    var a :Int{
        get{
            return 8
        }
        set{
        }
    }
    func sayHello(){}
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var person = Person()
        
//        //创建反射机制的相关对象
//        let m = Mirror(reflecting:person)
//        //获取到属性列表和对应的值
//        for(key,value)in m.children{
//            print("key:\(String(describing: key)),value:\(value),type:\(type(of: value))")
//        }
        
        
        
        let mirror = Mirror(reflecting: person)
                
        print("对象类型：\(mirror.subjectType)")
        print("对象子元素个数：\(mirror.children.count)")
                
        print("--- 对象子元素的属性名和属性值分别如下 ---")
        for case let (label?, value) in mirror.children {
            let mi = Mirror(reflecting: value)
            if mi.displayStyle == Mirror.DisplayStyle.optional {
                
                if let (_, some) = mi.children.first {
                    print("属性：\(label)  值：\(some)")
                } else {
                    print("属性：\(label)  值：")
                }
            } else {
                print("属性：\(label)  值：\(value)")
            }
        }
    }
    
    
}

