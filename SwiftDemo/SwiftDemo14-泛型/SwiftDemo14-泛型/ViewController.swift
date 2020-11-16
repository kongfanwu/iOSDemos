//
//  ViewController.swift
//  SwiftDemo14-泛型
//
//  Created by kfw on 2019/7/15.
//  Copyright © 2019 kfw. All rights reserved.
//

import UIKit

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

// 泛型扩展
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

// 类型约束
// 上面这个函数有两个类型参数。第一个类型参数 T 必须是 SomeClass 子类；第二个类型参数 U 必须符合 SomeProtocol 协议。
//func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
//    // 这里是泛型函数的函数体部分
//}

/*
 关联类型
 定义一个协议时，声明一个或多个关联类型作为协议定义的一部分将会非常有用。关联类型为协议中的某个类型提供了一个占位符名称，其代表的实际类型在协议被遵循时才会被指定。关联类型通过 associatedtype 关键字来指定。
 

 */
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

// 遵循协议
struct IntStack: Container {
    // IntStack 的原始实现部分
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // Container 协议的实现部分
    typealias Item = Int // 可不写，类型推断会根据参数确认
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

// 可以让泛型 Stack 结构体遵循 Container 协议：
struct Stack2<Element>: Container {
    // Stack<Element> 的原始实现部分
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // Container 协议的实现部分
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

// 给关联类型添加约束
// 你可以在协议里给关联类型添加约束来要求遵循的类型满足约束。例如，下面的代码定义了 Container 协议， 要求关联类型 Item 必须遵循 Equatable 协议：
// 要遵守 Container 协议，Item 类型也必须遵守 Equatable 协议。
protocol Container2 {
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

/*
 在关联类型约束里使用协议
 */
protocol SuffixableContainer: Container2 {
    // 在这个协议里，Suffix 是一个关联类型，就像上边例子中 Container 的 Item 类型一样。Suffix 拥有两个约束：它必须遵循 SuffixableContainer 协议（就是当前定义的协议），以及它的 Item 类型必须是和容器里的 Item 类型相同。
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

//extension Stack2: SuffixableContainer {
//
//    func suffix(_ size: Int) -> Stack {
//        var result = Stack()
//        for index in (count-size)..<count {
//            result.append(self[index])
//        }
//        return result
//    }
//    // 推断 suffix 结果是Stack。
//}

/*
 泛型 Where 语句
 类型约束 让你能够为泛型函数、下标、类型的类型参数定义一些强制要求。
 
 对关联类型添加约束通常是非常有用的。你可以通过定义一个泛型 where 子句来实现。通过泛型 where 子句让关联类型遵从某个特定的协议，以及某个特定的类型参数和关联类型必须类型相同。你可以通过将 where 关键字紧跟在类型参数列表后面来定义 where 子句，where 子句后跟一个或者多个针对关联类型的约束，以及一个或多个类型参数和关联类型间的相等关系。你可以在函数体或者类型的大括号之前添加 where 子句。
 
 下面的例子定义了一个名为 allItemsMatch 的泛型函数，用来检查两个 Container 实例是否包含相同顺序的相同元素。如果所有的元素能够匹配，那么返回 true，否则返回 false。
 
 被检查的两个 Container 可以不是相同类型的容器（虽然它们可以相同），但它们必须拥有相同类型的元素。这个要求通过一个类型约束以及一个 where 子句来表示：
 
 这个函数接受 someContainer 和 anotherContainer 两个参数。参数 someContainer 的类型为 C1，参数 anotherContainer 的类型为 C2。C1 和 C2 是容器的两个占位类型参数，函数被调用时才能确定它们的具体类型。
 
 这个函数的类型参数列表还定义了对两个类型参数的要求：
 
 C1 必须符合 Container 协议（写作 C1: Container）。
 C2 必须符合 Container 协议（写作 C2: Container）。
 C1 的 Item 必须和 C2 的 Item 类型相同（写作 C1.Item == C2.Item）。
 C1 的 Item 必须符合 Equatable 协议（写作 C1.Item: Equatable）。
 前两个要求定义在函数的类型形式参数列表里，后两个要求定义在了函数的泛型 where 分句中。
 
 这些要求意味着：
 
 someContainer 是一个 C1 类型的容器。
 anotherContainer 是一个 C2 类型的容器。
 someContainer 和 anotherContainer 包含相同类型的元素。
 someContainer 中的元素可以通过不等于操作符（!=）来检查它们是否相同。
 */
func allItemsMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool where C1.Item == C2.Item, C1.Item: Equatable {
        
        // 检查两个容器含有相同数量的元素
        if someContainer.count != anotherContainer.count {
            return false
        }
        
        // 检查每一对元素是否相等
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        
        // 所有元素都匹配，返回 true
        return true
}

/*
 具有泛型 Where 子句的扩展
 你也可以使用泛型 where 子句作为扩展的一部分。基于以前的例子，下面的示例扩展了泛型 Stack 结构体，添加一个 isTop(_:) 方法。
 这个新的 isTop(_:) 方法首先检查这个栈是不是空的，然后比较给定的元素与栈顶部的元素。如果你尝试不用泛型 where 子句，会有一个问题：在 isTop(_:) 里面使用了 == 运算符，但是 Stack 的定义没有要求它的元素是符合 Equatable 协议的，所以使用 == 运算符导致编译时错误。使用泛型 where 子句可以为扩展添加新的条件，因此只有当栈中的元素符合 Equatable 协议时，扩展才会添加 isTop(_:) 方法。
 */
// Element 泛型必须符合 Equatable 协议
extension Stack2 where Element: Equatable {
    //
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

// 你可以使用泛型 where 子句去扩展一个协议
extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}

/*
 具有泛型 Where 子句的关联类型
 */
protocol Container3 {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
    // 迭代器（Iterator）的泛型 where 子句要求：无论迭代器是什么类型，迭代器中的元素类型，必须和容器项目的类型保持一致。makeIterator() 则提供了容器的迭代器的访问接口。
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}

/*
 一个协议继承了另一个协议，你通过在协议声明的时候，包含泛型 where 子句，来添加了一个约束到被继承协议的关联类型。例如，下面的代码声明了一个 ComparableContainer 协议，它要求所有的 Item 必须是 Comparable 的。
 

 */
protocol ComparableContainer: Container where Item: Comparable { }

/*
 泛型下标
 下标可以是泛型，它们能够包含泛型 where 子句。你可以在 subscript 后用尖括号来写占位符类型，你还可以在下标代码块花括号前写 where 子句。例如：
 这个 Container 协议的扩展添加了一个下标方法，接收一个索引的集合，返回每一个索引所在的值的数组。这个泛型下标的约束如下：
 
 在尖括号中的泛型参数 Indices，必须是符合标准库中的 Sequence 协议的类型。
 下标使用的单一的参数，indices，必须是 Indices 的实例。
 泛型 where 子句要求 Sequence（Indices）的迭代器，其所有的元素都是 Int 类型。这样就能确保在序列（Sequence）中的索引和容器（Container）里面的索引类型是一致的。
 综合一下，这些约束意味着，传入到 indices 下标，是一个整型的序列。
 */
extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
        where Indices.Iterator.Element == Int {
            var result = [Item]()
            for index in indices {
                result.append(self[index])
            }
            return result
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var someInt = 3
        var anotherInt = 107
        swapTwoValues(&someInt, &anotherInt)
        // someInt 现在是 107，anotherInt 现在是 3
        
        var someString = "hello"
        var anotherString = "world"
        swapTwoValues(&someString, &anotherString)
        // someString 现在是“world”，anotherString 现在是“hello”
        
        
        var stackOfStrings = Stack<String>()
        stackOfStrings.push("uno")
        stackOfStrings.push("dos")
        stackOfStrings.push("tres")
        stackOfStrings.push("cuatro")
        
        
        var stackOfStrings2 = Stack2<String>()
        stackOfStrings2.push("uno")
        stackOfStrings2.push("dos")
        stackOfStrings2.push("tres")
        
        if allItemsMatch(stackOfStrings2, stackOfStrings2) {
            print("All items match.")
        } else {
            print("Not all items match.")
        }
        // 打印“All items match.”
    }


}

