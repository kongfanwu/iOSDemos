//
//  ViewController.swift
//  MoyaDemo
//
//  Created by kfw on 2020/12/14.
//

import UIKit
import Moya
import RxSwift

class ViewController: UIViewController {
    
    var provider = MoyaProvider<MyService>(plugins:[RequestHudPlugin()])
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        basicUsage()
    }
    
    func basicUsage() {
        provider.request(.login(userName: "15999999999", pwd: "21218cca77804d2ba1922c33e0151105")) { (result) in
            switch result {
            case let .success(moyaResponse):
                let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
                let data = moyaResponse.data // Data, your JSON response is probably in here!
                do {
                    let dataJson = try moyaResponse.mapJSON()
                    print(dataJson)
                } catch {
                }
            // do something in your app
            case let .failure(error):
                print(error.errorDescription!)
            }
        }
    }

    func upload() {
        if let image = UIImage(named:"1"), let data = image.pngData() {
            provider.request(.uploadGif(data, description: "description")) { (result) in
                
            }
            
        }
    }

    func basicUsage_rx() {
        provider.rx.request(.login(userName: "15999999999", pwd: "21218cca77804d2ba1922c33e0151105")).subscribe { (event) in
            switch event {
            case .success(let response):
            // do something with the data
                
            break
            case .error(let error):
            // handle the error
            break
            }
        }
        
        provider.rx.requestWithProgress(.zen).subscribe { event in
            switch event {
            case .next(let progressResponse):
                if let response = progressResponse.response {
                    // do something with response
                } else {
                    print("Progress: \(progressResponse.progress)")
                }
                break
            case .error(let error):
                // handle the error
                break
            default:
                break
            }
        }
    }
}

