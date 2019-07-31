//
//  ViewController.swift
//  SwiftDemo9-继承
//
//  Created by kfw on 2019/7/11.
//  Copyright © 2019 kfw. All rights reserved.
//

import UIKit

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // 什么也不做——因为车辆不一定会有噪音
    }
}

class Bicycle: Vehicle {
    var hasBasket = false
    // 重写方法
    override func makeNoise() {
        print("Choo Choo")
    }
}

class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
    // 重写属性
    override var description: String {
        get {
            return super.description + " in gear \(currentNumberOfPassengers)"
        }
        set (newValue) {
            print(newValue)
        }
    }
   
}
class Car: Vehicle {
    var gear: Int = 0
}

class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let someVehicle = Vehicle()
        print("Vehicle: \(someVehicle.description)")
        
        let bicycle = Bicycle()
        bicycle.hasBasket = true
        bicycle.currentSpeed = 15.0
        print("Bicycle: \(bicycle.description)")
        
        let tandem = Tandem()
        tandem.hasBasket = true
        tandem.currentNumberOfPassengers = 2
        tandem.currentSpeed = 22.0
        print("Tandem: \(tandem.description)")
    }


}

