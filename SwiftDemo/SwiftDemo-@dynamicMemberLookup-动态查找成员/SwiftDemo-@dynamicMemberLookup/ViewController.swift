//
//  ViewController.swift
//  SwiftDemo-@dynamicMemberLookup
//
//  Created by kfw on 2019/11/23.
//  Copyright © 2019 神灯智能. All rights reserved.
// https://www.jianshu.com/p/13e6aa1ad584

import UIKit

/*
 语法
 这个特性中文可以叫动态查找成员。在使用@dynamicMemberLookup标记了对象后（对象、结构体、枚举、protocol），实现了subscript(dynamicMember member: String)方法后我们就可以访问到对象不存在的属性。如果访问到的属性不存在，就会调用到实现的 subscript(dynamicMember member: String)方法，key 作为 member 传入这个方法。
 比如我们声明了一个结构体，没有声明属性。

 如果没有声明@dynamicMemberLookup的话，执行的代码肯定会编译失败。很显然作为一门类型安全语言，编译器会告诉你不存在这些属性。但是在声明了@dynamicMemberLookup后，虽然没有定义 city等属性，但是程序会在运行时动态的查找属性的值，调用subscript(dynamicMember member: String)方法来获取值。

 */
@dynamicMemberLookup
struct Person {
    subscript(dynamicMember member: String) -> String {
        let properties = ["nickname": "Zhuo", "city": "Hangzhou"]
        return properties[member, default: "undefined"]
    }

    subscript(dynamicMember member: String) -> Int {
        return 18
    }
}

// 动态查找成员
@dynamicMemberLookup
enum JSON {
   case intValue(Int)
   case stringValue(String)
   case arrayValue(Array<JSON>)
   case dictionaryValue(Dictionary<String, JSON>)

   var stringValue: String? {
      if case .stringValue(let str) = self {
         return str
      }
      return nil
   }

   subscript(index: Int) -> JSON? {
      if case .arrayValue(let arr) = self {
         return index < arr.count ? arr[index] : nil
      }
      return nil
   }
// 下标形式访问
   subscript(key: String) -> JSON? {
      if case .dictionaryValue(let dict) = self {
         return dict[key]
      }
      return nil
   }

    // 属性直接访问
   subscript(dynamicMember member: String) -> JSON? {
      if case .dictionaryValue(let dict) = self {
         return dict[member]
      }
      return nil
   }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let p = Person()
//        let age: Int = p.age
//        print(age)  // 18
//        print(p.nickname as String)
        let json = ["key" : JSON.stringValue("value")]
        let jsonDic = JSON.dictionaryValue(json)
        
//                print(jsonDic["key1"]?.stringValue as Any)
        print(jsonDic.key?.stringValue as Any)
    }


}

