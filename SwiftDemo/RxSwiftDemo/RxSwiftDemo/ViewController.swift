//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by kfw on 2020/12/15.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
//        FWObservable()
  
        textField.text = "123"
        let state: Driver<String?> = textField.rx.text.asDriver()
        let observer = textLabel.rx.text
        _ = state.drive(observer)
        
        // drive 订阅会更新一次
        state.map { $0?.count.description }.drive(countLabel.rx.text)
        
        

        
        
      
    }


}

