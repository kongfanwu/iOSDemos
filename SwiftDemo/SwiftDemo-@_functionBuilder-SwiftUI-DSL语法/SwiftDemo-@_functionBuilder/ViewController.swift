//
//  ViewController.swift
//  SwiftDemo-@_functionBuilder
//
//  Created by kfw on 2019/11/23.
//  Copyright © 2019 神灯智能. All rights reserved.
//

import UIKit

@_functionBuilder
struct TestBuilder {
    typealias Component = [Int]
    
    static func buildBlock(_ children: Component...) -> Component {
        return children.flatMap { $0 }
    }
    
    static func buildIf(_ children: Component?) -> Component {
        return children ?? []
    }
    
    func P(_ children: Component) -> Component {
        return children
    }
}

func testBlock(@TestBuilder makeChildren: () -> [Int]) -> [Int] {
    return makeChildren()
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let b = false
        let res = testBlock {
            if b {
                [1]
            }
            [2]
            [3]
           
        }
        print(res)
        
//        let res = testBlock { () -> [Int] in
//            [11]
//            [12]
//            [13]
//        }
//        print(res)
    }
    
    
}

