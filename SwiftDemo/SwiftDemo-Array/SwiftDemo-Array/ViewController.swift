//
//  ViewController.swift
//  SwiftDemo-Array
//
//  Created by kfw on 2019/11/21.
//  Copyright © 2019 神灯智能. All rights reserved.
//


// https://www.cnblogs.com/strengthen/p/10297316.html
import UIKit

protocol P {
    func foo()
}
struct TestA: P {
    var a = 0
    func foo() {
        
    }
}
//这个容器类型包装后可以通过下标访问，也可以通过属性访问
struct ContainerStruct<A> {
    var storage: A
    subscript(s:String)->A{
        get{ return storage} // 会拷贝
        set{storage = newValue}
    }
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 1
//        var shopping_list = [53,4,2,45]
//        for item in shopping_list.sorted(){
//            print(item,terminator: " ")
//        }
//        结果:
//        2 4 45 53
        
        // 2
//        shopping_list = shopping_list.sorted { (old, new) -> Bool in
//            return old<new;
//        }
//        print(shopping_list)
        
        // 3
//        first where 根据判断条件返回结果
//        let result = shopping_list.first(where: { (intResult) -> Bool in
//            return intResult==4
//        })
//        print(result ?? 0)
        
        // 4 break return 只会跳出当前body后续代码 不会结束循环
//        shopping_list.forEach { (result) in
//            print(result)
//        }
        
        // 5 相加
//        shopping_list += shopping_list
//        print(shopping_list)
        
        // 移除，的数组不可为空,空会崩溃
//        var shopping_list2 = [Any]()
//        shopping_list2.removeFirst()
        
        // 移除， 空返回nil
//        print(shopping_list2.popLast())
        
//        print(shopping_list.isEmpty)
        
        // 传必报为参数， 做条件判断
//        var arr = ["123Z","456Z","789"]
//        let filterArr = arr.filter { (str) -> Bool in
//            return str.contains("Z")}
//        print(filterArr)
        //Print ["123Z", "456Z"]
        
        
        // flatMap 强解包
        //以map方法进行对比
//        let arr1:[String?] = ["123", "456", "789"]
//        let newArr1 = arr1.map { $0 }
//        print(newArr1)
//        //Print [Optional("123"), Optional("456"), Optional("789")]
//
//        //flatMap
//        let arr2:[String?] = ["123", "456", "789", nil]
//        let newArr2 = arr2.compactMap { $0 }
//        print(newArr2)
//        //Print ["123", "456", "789"]
        
        // 数组亚平解嵌套数组，就是把二维数组里的元素展开成一维数组
//        var arr = [[1, 1.1], [2], [3], [4], [5]]
//        let flatMapArr = arr.flatMap{ $0 }
//        //压平解嵌套数组
//        print(flatMapArr)
//        // Print [1.0, 1.1, 2.0, 3.0, 4.0, 5.0]
        
//        print((1...5).reduce(0, +))
//        let numbers = [1, 2, 3, 4]
//        let numberSum = numbers.reduce(0, { x, y in
//            print(x, y)
//            return x + y
//        })
//        print(numberSum)
        
//        var arr = [1,2,3,4,5]
//        //闭包形式
//        let newArr1 = arr.reduce("strengthen") { (a1, a2) -> String in
//                  return "\(a1)" + "\(a2)"}
//        print(newArr1)
//        //Print strengthen12345
//
//        //简写形式
//        let newArr2 = arr.reduce("Z"){ "\($0)" + "\($1)" }
//        print(newArr2)
//        //Print Z12345
        
        // 截取
//        var arr = [1,2,3,4,5]
//        //prefix：从头部开始截取
//        //upTo：[0,3),不包含第三个元素的索引:0,1,2
//        let prefixArr = arr.prefix(upTo: 3)
//        print(prefixArr)
//        //Print [1, 2, 3]
//
//        //suffix：截取至尾部
//        //从第三个元素到末尾，包含第三个元素的索引:3，4
//        let suffixArr = arr.suffix(from: 3)
//        print(suffixArr)
//        //Print [4, 5]
//
//        // 删除获得新数组
//        var arr = [1,2,3,4,5]
//        //从头部开始删除三个元素
//        let dropFirstArr = arr.dropFirst(3)
//        print(dropFirstArr)
//        //Print [4, 5]
//
//        //从尾部开始删除三个元素
//        let dropLastArr = arr.dropLast(3)
//        print(dropLastArr)
//        //Print [1, 2]
        
        // 验证字符串中是否包含某单词
//        let words = ["Strengthen","Swift","iOS"]
//        let sentence = "My name is Strengthen iOS"
//
//        //方法1:filter
//        let result1 = words.filter({
//            print($0)
//            return sentence.contains($0)
//        })
//        print(result1)
//        //Print true
//
//        //方法2:contains
//        let result2 = words.contains(where: sentence.contains)
//        print(result2)
        //Print true
              
        
//        var arr = [1,3]
//        //判断是否包含偶数
//        let result = arr.contains{ $0 % 2 == 0}
//        print(result)
        //Print true
        
//        let expenses = [21.37, 55.21, 9.32, 10.18, 388.77, 11.41]
//        let hasBigPurchase = expenses.contains { $0 > 1000 }
//        print(hasBigPurchase)
//        ///     // 'hasBigPurchase' == true
        
      
//        var test = TestA()
//        withUnsafePointer(to: &test) {
//            print("\($0)")
//        }
//        var test2: P = test
//        withUnsafePointer(to: &test2) {
//            print("\($0)")
//        }
        
//        var x = [1,2,3]
//        var y = x
//        print(String.init(format: "%p", x))
//        print(String.init(format: "%p", y))
//        print(x) //[1,2,3]
//        print(y) //[1,2,3]
//        x.append(4)
//        print(x) //[1,2,3,4]
//        print(y) //[1,2,3]
//        print(String.init(format: "%p", x))
//        print(String.init(format: "%p", y))
        
//        写时拷贝机制
        final class Empty {
            
        }
        struct COWStruct {
            var ref = Empty()
            mutating func change() -> String {
                
                // 去判断当前对象是否有多个引用指向，如果并没有其他变量强引用则返回true。
                if isKnownUniquelyReferenced(&ref) {
                    return "No copy"
                } else {
                    return "Copy"
                }
            }
        }
        
        var array = [COWStruct()]
        print(array[0].change())//no copy
        
        var dict = ["struct": COWStruct()]
        print(dict["struct"]!.change())//no copy
        
        var container = ContainerStruct(storage: COWStruct())
        print(container.storage.change())//no copy
        print(container["1"].change())//copy
        
//        var obj = COWStruct()
//        withUnsafePointer(to: &obj.ref) {print("\($0)")}
//        var obj2 = obj
//        withUnsafePointer(to: &obj2.ref) {print("\($0)")}
        
//        withUnsafePointer(to: &obj) { print("\($0)") }
//        var arr = [COWStruct()]
//        withUnsafePointer(to: &arr[0]) { print("\($0)") }
//        print(arr[0].change())
//        var obj2 = arr[0]
//        withUnsafePointer(to: &arr[0]) { print("\($0)") }
//        print(arr[0].change())
//        withUnsafePointer(to: &obj2) { print("\($0)") }
//        print(obj2.change())
        
//        var dict = ["key": COWStruct()]
//
//        print(dict["key"]?.change())
//        var a = dict["key"]!
//        print(dict["key"]?.change())
//        print(a.change())
         // Optional("Copy")]
        
//        var arr = [COWStruct()]
//        print(arr[0].change())
//        var b = arr[0]
//        print(arr[0].change())
//        print(b.change())
    }
   

}

