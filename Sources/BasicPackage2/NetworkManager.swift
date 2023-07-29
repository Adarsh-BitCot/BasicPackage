//
//  File.swift
//  
//
//  Created by bitcot on 29/07/23.
//

import Foundation
import Alamofire

class NetworkManager: NSObject {
    static let shared = NetworkManager()
    private override init() {}
    func makeAPICall(urlString: String,
                     parameters: [String: Any] = [:],
                     headers : HTTPHeaders = [:],
                     method: String = "GET",
                     encoding: ParameterEncoding = JSONEncoding.default,
                     completion:@escaping ([String: Any]?) -> Void) {
        AF.request(urlString,
                   method: HTTPMethod(rawValue: method),
                   parameters: parameters,
                   encoding: encoding,
                   headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                print(String(data: value as! Data, encoding: .utf8)!)
                completion(value as? [String : Any])
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
}
