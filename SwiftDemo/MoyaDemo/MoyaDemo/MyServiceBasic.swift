//
//  MyServiceBasic.swift
//  MoyaDemo
//
//  Created by kfw on 2020/12/14.
//

import Foundation
import Moya


// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

enum MyService {
    case zen
    case showUser(id: Int)
    case createUser(firstName: String, lastName: String)
    case updateUser(id: Int, firstName: String, lastName: String)
    case showAccounts
    case login(userName: String, pwd: String) // 登录示例
    case uploadGif(Data, description: String) // 上传图片示例
}

// MARK: - TargetType Protocol Implementation
extension MyService: TargetType {
    var baseURL: URL { return URL(string: "http://pc.test.api.shendengzhineng.com")! }
    // 指定请求的子路径
    var path: String {
        switch self {
        case .zen:
            return "/zen"
        case .showUser(let id), .updateUser(let id, _, _):
            return "/users/\(id)"
        case .createUser(_, _):
            return "/users"
        case .showAccounts:
            return "/accounts"
        case .login(userName: _, pwd: _):
            return "/index.php/v5.login"
        case .uploadGif(_, _):
            return ""
        }
    }
    var method: Moya.Method {
        switch self {
        case .zen, .showUser, .showAccounts:
            return .get
        case .createUser, .updateUser, .login, .uploadGif:
            return .post
        }
    }
    
    // 用于指定要添加到请求的参数的选项
    var task: Task {
        switch self {
        case .zen, .showUser, .showAccounts: // Send no parameters
            return .requestPlain
        case let .updateUser(_, firstName, lastName):  // Always sends parameters in URL, regardless of which HTTP method is used
            return .requestParameters(parameters: ["first_name": firstName, "last_name": lastName], encoding: URLEncoding.queryString)
        case let .createUser(firstName, lastName): // Always send parameters as JSON in request body
            return .requestParameters(parameters: ["first_name": firstName, "last_name": lastName], encoding: JSONEncoding.default)
        case let .login(userName, pwd):
            let param = ["account": userName,
                         "password": pwd,
                         "cnmtp": "1",
                         "device_token": "",
                         "join_code": "SJ000003",
                         "nonce": "160791687079557383",
                         "sign": "537ce8feaba26c22505be23230e020ed",
                         "timestamp": "1607916870",
                         "token": "34c185868934a4e5cda34a2126262a2b",]
            return .requestParameters(parameters:param , encoding: JSONEncoding.default)
        case let .uploadGif(data, description):
            let gifData = MultipartFormData(provider: .data(data), name: "file", fileName: "gif.gif", mimeType: "image/gif")
            let descriptionData = MultipartFormData(provider: .data(description.data(using: .utf8)!), name: "description")
            let multipartData = [gifData, descriptionData]
            return .uploadMultipart(multipartData)
        }
    }
    // 单元测试用
    var sampleData: Data {
        switch self {
        case .zen:
            return "Half measures are as bad as nothing at all.".data(using: .utf8)!
        case .showUser(let id):
            return "{\"id\": \(id), \"first_name\": \"Harry\", \"last_name\": \"Potter\"}".data(using: .utf8)!
        case .createUser(let firstName, let lastName):
            return "{\"id\": 100, \"first_name\": \"\(firstName)\", \"last_name\": \"\(lastName)\"}".data(using: .utf8)!
        case .updateUser(let id, let firstName, let lastName):
            return "{\"id\": \(id), \"first_name\": \"\(firstName)\", \"last_name\": \"\(lastName)\"}".data(using: .utf8)!
        case .showAccounts:
            // Provided you have a file named accounts.json in your bundle.
            guard let url = Bundle.main.url(forResource: "accounts", withExtension: "json"),
                  let data = try? Data(contentsOf: url) else {
                return Data()
            }
            return data
        case .login(userName: let userName, pwd: let pwd):
            return "{\"id\": \(userName), \"first_name\": \"Harry\", \"last_name\": \"Potter\"}".data(using: .utf8)!
        case .uploadGif(_, _):
            return "".data(using: .utf8)!
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
}
