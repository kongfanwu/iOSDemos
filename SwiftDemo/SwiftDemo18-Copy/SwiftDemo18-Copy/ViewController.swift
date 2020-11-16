//
//  ViewController.swift
//  SwiftDemo18-Copy
//
//  Created by kfw on 2020/8/13.
//  Copyright © 2020 神灯智能. All rights reserved.
// https://www.jianshu.com/p/a8722a25fc20

import UIKit
//protocol Copyable {
//    func copy() -> Copyable
//}
//
//class MyClass:Copyable{
//    var des = ""
//    func copy()-> Copyable{
//        return MyClass(self.des)
//    }
//   required init(_ des:String){
//        self.des = des
//    }
//
//}

protocol Copyable {
    func copy()-> Self
}

class MyClass:Copyable{
    var des = " "
    
    func copy() -> Self{
        
        let obj = type(of: self).init(self.des)
        return obj
        
    }
    required init(_ des:String){
        self.des = des
    }
}

class Son:MyClass{
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let myClass = MyClass("my class")
//        let yourClass = myClass.copy() as! MyClass
//        yourClass.des = "your class"
//        print(yourClass.des)//your class
//        print(myClass.des)// my class
        
        let myClass = MyClass("my class")
        let yourClass = myClass.copy()
        yourClass.des = "your class"
        print(yourClass.des)//your class
        print(myClass.des)// my class
        
        let sonA = Son("sonA")
        let sonB = sonA.copy()
        sonB.des = "sonB"
        print(sonA.des)//sonA
        print(sonB.des)//sonB
    }


}

