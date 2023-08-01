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
                     encoding: ParameterEncoding = URLEncoding.default,
                     completion:@escaping ([String: Any]?, Errors?) -> Void) {
        
        if Reachability.isConnectedToNetwork() {
            AF.request(urlString,
                       method: HTTPMethod(rawValue: method),
                       parameters: parameters,
                       encoding: encoding,
                       headers: headers).responseJSON { response in
                switch response.result {
                case .success(let value):
                    completion(value as? [String : Any], nil)
                case .failure(let error):
                    print(error)
                    completion(nil, Errors.invalidResponse)
                }
            }
        }else{
            completion(nil, Errors.apiError(message: "NO INTERNET"))
        }
    }
}
