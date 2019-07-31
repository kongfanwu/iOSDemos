//
//  main.swift
//  SwiftDemo2
//
//  Created by kfw on 2019/7/9.
//  Copyright © 2019 kfw. All rights reserved.
//

import Foundation

//var name: String? = "11"
//let name2 = "kokng"
//let res = name ?? name2
//print(res)
//
//for index in 1...5 {
//    print("\(index) times 5 is \(index * 5)")
//}
//
//// 单侧区间
//let names = ["Anna", "Alex", "Brian", "Jack"]
//for name in names[2...] {
//    print(name)
//}
//
//var emptyString = ""               // 空字符串
//var anotherEmptyString = String()  // 初始化语法
////这是两个空字符串，他们等价
//if emptyString.isEmpty {
//    print("Nothing to see here")
//}

var welcome = "hello"
welcome.insert("!", at: welcome.endIndex)
// welcome 现在等于 "hello!"
welcome.insert(contentsOf: ",there", at: welcome.index(before: welcome.endIndex))
print(welcome)
//print(welcome)
////welcome.remove(at: welcome.index(before: welcome.endIndex))
//let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
//welcome.removeSubrange(range)
let a:String.Index = "5".endIndex;

let index = welcome.firstIndex(of: ",") ?? welcome.endIndex
let subStr = welcome[..<index]
print(String(subStr))

// 字符串截取
let helloWorld = "Hello, World!"
let subStringTo5 = String(helloWorld[..<helloWorld.index(helloWorld.startIndex, offsetBy: 5)])
print("subStringTo5: \(subStringTo5)")
