//
//  ViewController.swift
//  HandyJSONDemo
//
//  Created by kfw on 2019/10/24.
//  Copyright © 2019 神灯智能. All rights reserved.
//

import UIKit
import HandyJSON

class Cat: HandyJSON {
    var id: Int64!
    var name: String!
    var friendName: String?
    var parent: (String, String)?

    required init() {}

    func mapping(mapper: HelpingMapper) {
        // specify 'cat_id' field in json map to 'id' property in object
        mapper <<<
            self.id <-- "cat_id"

        // specify 'parent' field in json parse as following to 'parent' property in object
        mapper <<<
            self.parent <-- TransformOf<(String, String), String>(fromJSON: { (rawString) -> (String, String)? in
                if let parentNames = rawString?.split(separator: "/").map(String.init) {
                    return (parentNames[0], parentNames[1])
                }
                return nil
            }, toJSON: { (tuple) -> String? in
                if let _tuple = tuple {
                    return "\(_tuple.0)/\(_tuple.1)"
                }
                return nil
            })

        // specify 'friend.name' path field in json map to 'friendName' property
        mapper <<<
            self.friendName <-- "friend.name"
        
        // 排除指定属性
        mapper >>> self.friendName
    }
    // 映射完成回调
    func didFinishMapping() {
        print("you can fill some observing logic here")
         print(self.id!)
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let jsonString = "{\"cat_id\":12345,\"name\":\"Kitty\",\"parent\":\"Tom/Lily\",\"friend\":{\"id\":54321,\"name\":\"Lily\"}}"

        if let cat = Cat.deserialize(from: jsonString) {
            print(cat.id!)
            print(cat.parent!)
            if let friendname = cat.friendName {
                print(friendname)
            }
        }
    }


}

