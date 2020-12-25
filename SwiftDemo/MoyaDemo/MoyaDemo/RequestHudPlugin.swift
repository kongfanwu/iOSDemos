//
//  RequestHudPlugin.swift
//  MoyaDemo
//
//  Created by kfw on 2020/12/14.
//

import UIKit
import Moya
import ProgressHUD

class RequestHudPlugin: PluginType {
//    private let viewController: UIViewController
//
//    init(viewController: UIViewController) {
//        self.viewController = viewController
//    }
    
    func willSend(_ request: RequestType, target: TargetType) {
        ProgressHUD.show()
    }
    
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        ProgressHUD.dismiss()
    }
}
